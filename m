Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3645612CF2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJ3VIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3VIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:08:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F38959A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:08:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61764B81055
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 21:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26180C433C1;
        Sun, 30 Oct 2022 21:08:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="o/xt56en"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667164078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vs1yilsLd6bxIKb8IAJ+0QKQjEQERTtWE9r/YjNtvY4=;
        b=o/xt56en10FpHW4xzXNR2Jk404BJFH0QdurRCA3ax/byJ98dbvkzL4a1spmGS8ii+HZxXh
        zlco6HSD2Wpqn4WwBzm9ln/vl35zUmeHidbldXGHUYep0+7DFbaW8xZcBuA1kqz+StkCAR
        gmVFBnQEl6pR67Hz/O9QWt4kaPes84c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7321aa22 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 30 Oct 2022 21:07:57 +0000 (UTC)
Date:   Sun, 30 Oct 2022 22:07:53 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will@kernel.org, jean-philippe@linaro.org, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: remove early archrandom abstraction
Message-ID: <Y17nqd27jHOkzeOp@zx2c4.com>
References: <20221028234025.82222-1-Jason@zx2c4.com>
 <Y160oanRPF3ZLINw@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y160oanRPF3ZLINw@arm.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

> > +static __always_inline bool __cpu_has_rng(void)
> > +{
> > +	if (!system_capabilities_finalized()) {
> > +		/* Open code as we run prior to the first call to cpufeature. */
> > +		unsigned long ftr = read_sysreg_s(SYS_ID_AA64ISAR0_EL1);
> > +		return (ftr >> ID_AA64ISAR0_EL1_RNDR_SHIFT) & 0xf;
> > +	}
> > +	return cpus_have_const_cap(ARM64_HAS_RNG);
> > +}
> 
> We need to be careful with this check as it is only valid on the CPU it
> was called on. Is the result used only on this CPU and with the
> preemption disabled? We have big.LITTLE systems where CPUs may differ
> and the ARM64_HAS_RNG feature may not be enabled once all the CPUs have
> been initialised (capabilities finalised).
> 
> We could make this capability an ARM64_CPUCAP_BOOT_CPU_FEATURE, though
> I'd have to check whether any systems in the wild have such mixed CPUs.

This occurred to me too and I wasn't quite sure how the interaction
worked out. It sounds like system_capabilities_finalized() might still
be false when SMP brings up other cores? In that case, I guess we just
have to make sure the system is still booting / in single CPU mode,
before interrupts have been enabled. This should be straight forward to
do; I'll send a v2.

Jason
