Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7EB63B4EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiK1Wk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiK1Wk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:40:26 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307FD27B0E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:40:25 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 646F81EC042F;
        Mon, 28 Nov 2022 23:40:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669675223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lZmQ7j7zgK9JHgQnY7ydnqQbz44P4Bhdp+DPFB7I0JE=;
        b=JmX75N2bOGozIbq6a9mlp2lFnrW28dA6Bv62M/XaNO5nThh4xGC/EVb1FYs0RDQPA2dXpG
        mNTFLP+uVGAJLyMlCnqGzgeD3+qsXBcJSX2X6Wu2RSoDIcazWV9/lb6/xZ+MFrEdH0RjLw
        +ggtTzGAP56gM6H7IkB3AiLfjFKJgHo=
Date:   Mon, 28 Nov 2022 23:40:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        jpoimboe@kernel.org, peterz@infradead.org, x86@kernel.org,
        cascardo@canonical.com, leit@meta.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <Y4U40wKoSF/ze1Ud@zn.tnic>
References: <20221124104650.533427-1-leitao@debian.org>
 <Y4QD8o8kWb1V4osq@zn.tnic>
 <20221128220358.n5vk6youcdl2er35@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221128220358.n5vk6youcdl2er35@desk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:03:58PM -0800, Pawan Gupta wrote:
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 3e3230cccaa7..cfc2ed2661fc 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -66,7 +66,7 @@ static DEFINE_MUTEX(spec_ctrl_mutex);
>   */
>  void write_spec_ctrl_current(u64 val, bool force)
>  {
> -	if (this_cpu_read(x86_spec_ctrl_current) == val)
> +	if (!force && this_cpu_read(x86_spec_ctrl_current) == val)
>  		return;
>  	this_cpu_write(x86_spec_ctrl_current, val);

Still looks hacky to me.

I think it would be a lot cleaner if MSR_IA32_SPEC_CTRL gets cleaned of
the speculation bits in init_speculation_control() which gets run on
*every* CPU.

So by the time check_bugs() gets to setup stuff, the MSR will be ready
to go regardless.

I.e., something like this (not supposed to work - just to show what I
mean):

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 73cc546e024d..367732c92942 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -993,9 +993,19 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 	 * Intel CPUs, for finer-grained selection of what's available.
 	 */
 	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
+		u64 msr;
+
 		set_cpu_cap(c, X86_FEATURE_IBRS);
 		set_cpu_cap(c, X86_FEATURE_IBPB);
 		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
+
+		/*
+		 * Clear speculation control settings from a previous kernel
+		 * run, i.e., kexec.
+		 */
+		rdmsrl(MSR_IA32_SPEC_CTRL, msr);
+		if (msr & SPEC_CTRL_MASK)
+			wrmsr (MSR_IA32_SPEC_CTRL, msr & ~SPEC_CTRL_MASK);
 	}
 
 	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
