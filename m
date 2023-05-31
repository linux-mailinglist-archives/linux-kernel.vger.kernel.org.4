Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C22718114
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjEaNJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbjEaNJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:09:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FF1191
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:09:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685538550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=D8JzOsVHnlOCZetwqX9bTeq4D88l0glnH8zy+8sZ17A=;
        b=r+PfR6yPm+K7fSWl6Tk/XwOG5gw6qrFgMpMb+Xb6vQrV38to75xy0xJ+7Y8ppxvEOouF5f
        jfPVQRUQi0RpZKNcTi6NNeRXI77k3Mcw8kG3IFZtxrbKe9fPsLegE/HVys3S99tp2vzobt
        sneFJMO3dQSHsG/1qwrknjSyI3Uig2akgTpbxw/cvCMp8iaAHtJuTi3Krd5G+nrwTdk7iP
        8/pbxrtrYv4Sox1Ik6LPzzlUt+01MmiwsHdOEm30uAZ1+6heP34RuTgoUqwnnZ840lwAmR
        OT1YV0NuVPDfaD0qLevbUieurKIMbJuFZHP//LGi0FWATBx0/XcVL2o3fwbULw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685538550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=D8JzOsVHnlOCZetwqX9bTeq4D88l0glnH8zy+8sZ17A=;
        b=656aw+7pu6H0kWKWqqxbUsZa7sEPPkdW29RlRpS2bnXwfNUBJroMwEzYUHf7wifBWwAg3/
        B55Ls7x9yhFcP2BA==
To:     Radu Rendec <rrendec@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH 0/5] irq: sysfs interface improvements for SMP
 affinity control
In-Reply-To: <20230530214550.864894-1-rrendec@redhat.com>
Date:   Wed, 31 May 2023 15:09:10 +0200
Message-ID: <877csohcll.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30 2023 at 17:45, Radu Rendec wrote:
> Note: I still need to update the Documentation/ directory for the new
>       sysfs interface, and I will address that in a future version.
>       At this point, I just want to get feedback about the current
>       approach.

From a conceptual POV I understand why this is required, which makes me
hate this chained mechanism even more.

Aside of having no visibility (counters, affinity, etc) the worst thing
about these chained hidden interrupts is:

  There is no control of runaway interrupts as they circumvent the core,
  which has caused hard to diagnose system hangups in the past. See
   
    ba714a9c1dea ("pinctrl/amd: Use regular interrupt instead of chained")

  for demonstration.

The argument I heard for this chained interrupt muck is that it's so
much more performant than using regular interrupt handlers via
request_irq(). It's obviously less overhead, but whether it matters and
most importantly whether it justifies the downsides is a different
question.

There is also the argument about double accounting. Right now the
chained handler is not accounted and only the childs are.

Though that is inconsistent with other demultiplex handlers which _must_
use regular interrupt handlers (threaded) to demultiplex interrupt chips
which sit behind SPI/I2C...

The sum of child interrupts is also not necessarily the number of parent
interrupts, unless there is always exactly only one child handler to
invoke.

Quite some of those demux handlers are also not RT compatible.

AFAICT, there is no real technical reason at least not for the vast
majority of usage sites why the demultiplex handler cannot run inside a
regular interrupt handler context.

So I personally would prefer to get rid of this chained oddball and just
have consistent mechanisms for dealing with interrupts, which would just
avoid exposing the affinity files in two different places.

Providing information about child/parent relationship is an orthogonal
issue.

If there is some good reason (aside of the chained muck) to have sysfs
based affinity management, then I'm not objecting as long as the
functionality is the same, i.e. effective affinity needs be exposed too.

Thanks,

        tglx
