Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5916640FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbjAJM5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbjAJM5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:57:12 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB191DDE8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:57:11 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A93A51EC04AD;
        Tue, 10 Jan 2023 13:57:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673355429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=e3aZbrX9jsLB8Y3WAfNCVrD8tFak09w/8UN5B8tb074=;
        b=n8stqYgbfzuFA/wxS1p8sxfshrdVy3fNeEcz5YAGqhIj5RZ6DGPqYYXqA4hvwKuXAn+Q1J
        HKp7zcHn854pj0u/3jsMIhMAF64DiED87duiVkYKLHpZ0cjEK3AEpNiX9IDyL5x6BkXuEq
        I+whqeZWwW1MJaD4BvXd6v3zONT4KSY=
Date:   Tue, 10 Jan 2023 13:57:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     Ingo Molnar <mingo@kernel.org>, michael.roth@amd.com,
        hpa@zytor.com, tglx@linutronix.de,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de,
        keescook@chromium.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, brijesh.singh@amd.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, liwei391@huawei.com
Subject: Re: [PATCH -v2] x86/boot/compressed: Register dummy NMI handler in
 EFI boot loader, to avoid kdump crashes
Message-ID: <Y71goW5qTW5dZKcv@zn.tnic>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
 <Y71FJ+G0NGQe3Ppq@gmail.com>
 <Y71TglxSLJKO17SY@gmail.com>
 <Y71V8SRLxZ/Uqkfs@zn.tnic>
 <684a2472-f388-b2e1-4a7a-7bc9a07650b4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <684a2472-f388-b2e1-4a7a-7bc9a07650b4@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:32:07PM +0800, Zeng Heng wrote:
> mce is registered on NMI handler by inject_init().

That's a handler for the NMI raised by raise_mce(). That's for the injection
case, which is simulated. If you're fixing the injection case, then surely not
with a bogus boot NMI handler.

> Yes, exactly. The following procedure is like:
> 
> panic() -> relocate_kernel() -> identity_mapped() -> x86 purgatory image ->
> EFI loader -> secondary kernel

I'm doubtful now as you're injecting errors so you're not really in #MC context
but in this contrived context which is actually an NMI one. So we need to think
about how to fix this case.

Certainly not with an empty NMI handler...

Regardless, we should do

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7832a69d170e..57fe376ed049 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -286,6 +286,8 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+
+		mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);

so that we not run kexec in #MC context.

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
