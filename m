Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9CE6485F5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiLIPvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiLIPv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:51:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BC88E5A0;
        Fri,  9 Dec 2022 07:51:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670601061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eKbpp0wjvU8vo2TqfIGB4ga/ChhXXFfrT2TPlT3D1Nk=;
        b=sledpoQWuT20D5jkQAu4GGNLhHWxtTvIUw6G9s12oo9IQPcXAFQh+IhDHLlmCjd/V5CyRn
        GNObOg/5CVjpPrtLIgMgyJBL4IWAuR74SbroIc/cT+iGgKcLCeqI68bpd/E/eS3h0qMoQI
        /SdVBtzyg7YWZnHftbvc+iHnzKyWwqwHFC3FIw9ANKAHwYCqa3ANwIqL3qmry2nuC7xwym
        F+iPBGLir6UYXcQlWEpVl8p7B1wpHYs1AV98dTh4Sh/FsimVS55vXTGdYIe/HK9l1SgOVv
        fgm72hkHD/C32NLQ+m7OMEDQTXSbLisJupZrbmlt8mYlyfXwv4lVax8tFBvFWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670601061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eKbpp0wjvU8vo2TqfIGB4ga/ChhXXFfrT2TPlT3D1Nk=;
        b=hetIRQeDX4NGfdgSfbTAKYfGFcw/k9tfmfap29Z8THL1ipf8rXNMZ5nTv7bNsdIRnNik00
        rJERnr0NlQ75uZCA==
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v3 00/19] irqdomain: fix mapping race and clean up locking
In-Reply-To: <20221209140150.1453-1-johan+linaro@kernel.org>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
Date:   Fri, 09 Dec 2022 16:51:00 +0100
Message-ID: <87o7scd197.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan!

On Fri, Dec 09 2022 at 15:01, Johan Hovold wrote:
> Parallel probing (e.g. due to asynchronous probing) of devices that
> share interrupts can currently result in two mappings for the same
> hardware interrupt to be created.
>
> This series fixes this mapping race and clean up the irqdomain locking
> so that in the end the global irq_domain_mutex is only used for managing
> the likewise global irq_domain_list, while domain operations (e.g.
> IRQ allocations) use per-domain (hierarchy) locking.

Can you please rebase that on top of:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core

Thanks,

        tglx
