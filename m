Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80DA70B758
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjEVION (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjEVIOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:14:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53024B0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:14:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684743249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mnTuNYqtea/wqsyRqkyQFOYLTYsaJ3v9g3ieEEK162A=;
        b=WJ0waR8tuxofc2BBQx9ZogV075ptotLz7HjIA1mgfZHfmSKB0f2+/Rt4lMUPmJBPW8IYZL
        SFyB87BPgJ//XEG9wRIt3XOC/aYTWP4QJICD8ym9fLe1+tkejq1s0swg6oBPY2RHRObRHK
        2pR5GNKcsWO/+JmANIY6MSvwvbrhLbis//mu8KuarnYcVY5UC8oL8cC1+XOehwLjuGK255
        mP5y8PGY4jOKT3QIaQwQPTIVEWr0mStsh9nnWXIzsztb87sTkH7ehxpv7J3LuTdIeMlGff
        EoM61I2hHrVaP1E5VPAsvSI8xPrI3awvEHyUk2VZdQAvYYKwsW3ysuntSmTVJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684743249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mnTuNYqtea/wqsyRqkyQFOYLTYsaJ3v9g3ieEEK162A=;
        b=vfaDdpbJgRxBvsqf5x7986D6qhCoob6IScLazDVoZTyjzmeG1/2KOa78gmzog4PSJLQUS+
        4acd5z0MF5t0wiCQ==
To:     Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org,
        rui.zhang@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH RFC] x86/tsc: Make recalibration default on for
 TSC_KNOWN_FREQ cases
In-Reply-To: <20230522033018.1276836-1-feng.tang@intel.com>
References: <20230522033018.1276836-1-feng.tang@intel.com>
Date:   Mon, 22 May 2023 10:14:08 +0200
Message-ID: <87h6s4ye9b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22 2023 at 11:30, Feng Tang wrote:
> Commit a7ec817d5542 ("x86/tsc: Add option to force frequency
> recalibration with HW timer") was added to handle cases that the
> firmware has bug and provides a wrong TSC frequency number, and it
> is optional given that this kind of firmware issue rarely happens
> (Paul reported once [1]).
>
> But Rui reported that some Sapphire Rapids platform met this issue
> again recently, and as firmware is also a kind of 'software' which
> can't be bug free, make the recalibration default on. When the
> values from firmware and HW timer's calibration have big gap,
> raise a warning and let vendor to check which side is broken.

Sure firmware can have bugs, but if firmware validation does not even
catch such a trivially to detect bug, then their validation is nothing
else than rubber stamping. Seriously.

Are any of these affected platforms shipping already or is this just
Intel internal muck?

> One downside is, many VMs also has X86_FEATURE_TSC_KNOWN_FREQ set,
> and they will also do this recalibration.

It's also pointless for those SoCs which lack legacy hardware.

So why do you force this on everyone?

Thanks,

        tglx
