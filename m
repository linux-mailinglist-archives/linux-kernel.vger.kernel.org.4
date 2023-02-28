Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F05E6A5CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjB1QJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjB1QJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:09:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EEC2B2AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:09:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F251B80DFC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F14C4339C;
        Tue, 28 Feb 2023 16:09:11 +0000 (UTC)
Date:   Tue, 28 Feb 2023 16:09:08 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     =?utf-8?B?6KKB5biFKFNodWFpIFl1YW4p?= <yuanshuai@zeku.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        =?utf-8?B?5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ==?= 
        <ouyangweizhao@zeku.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Weizhao Ouyang <o451686892@gmail.com>,
        =?utf-8?B?5Lu756uL6bmPKFBlbmcgUmVuKQ==?= <renlipeng@zeku.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v2] kasan: fix deadlock in start_report()
Message-ID: <Y/4nJEHeUAEBsj6y@arm.com>
References: <20230209031159.2337445-1-ouyangweizhao@zeku.com>
 <CACT4Y+Zrz4KOU82jjEperYOM0sEp6TCmgse4XVMPkwAkS+dXrA@mail.gmail.com>
 <93b94f59016145adbb1e01311a1103f8@zeku.com>
 <CACT4Y+a=BaMNUf=_suQ5or9=ZksX2ht9gX8=XBSDEgHogyy3mg@mail.gmail.com>
 <CA+fCnZf3k-rsaOeti0Q7rqkmvsqDb2XxgxOq6V5Gqp6FGLH7Yg@mail.gmail.com>
 <b058a424e46d4f94a1f2fdc61292606b@zeku.com>
 <2b57491a9fab4ce9a643bd0922e03e73@zeku.com>
 <CA+fCnZcirNwdA=oaLLiDN+NxBPNcA75agPV1sRsKuZ0Wz6w_hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZcirNwdA=oaLLiDN+NxBPNcA75agPV1sRsKuZ0Wz6w_hQ@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 03:13:45AM +0100, Andrey Konovalov wrote:
> +Catalin, would it be acceptable to implement a routine that disables
> in-kernel MTE tag checking (until the next
> mte_enable_kernel_sync/async/asymm call)? In a similar way an MTE
> fault does this, but without the fault itself. I.e., expose the part
> of do_tag_recovery functionality without report_tag_fault?

I don't think we ever re-enable MTE after do_tag_recovery(). The
mte_enable_kernel_*() are called at boot. We do call
kasan_enable_tagging() explicitly in the kunit tests but that's a
controlled fault environment.

IIUC, the problem is that the kernel already got an MTE fault, so at
that point the error is not really recoverable. If we want to avoid a
fault in the first place, we could do something like
__uaccess_enable_tco() (Vincenzo has some patches to generalise these
routines) but if an MTE fault already triggered and MTE is to stay
disabled after the reporting anyway, I don't think it's worth it.

So I wonder whether it's easier to just disable MTE before calling
report_tag_fault() so that it won't trigger additional faults:

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f4cb0f85ccf4..1449d2bc6f10 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -329,8 +329,6 @@ static void do_tag_recovery(unsigned long addr, unsigned long esr,
 			   struct pt_regs *regs)
 {
 
-	report_tag_fault(addr, esr, regs);
-
 	/*
 	 * Disable MTE Tag Checking on the local CPU for the current EL.
 	 * It will be done lazily on the other CPUs when they will hit a
@@ -339,6 +337,8 @@ static void do_tag_recovery(unsigned long addr, unsigned long esr,
 	sysreg_clear_set(sctlr_el1, SCTLR_EL1_TCF_MASK,
 			 SYS_FIELD_PREP_ENUM(SCTLR_EL1, TCF, NONE));
 	isb();
+
+	report_tag_fault(addr, esr, regs);
 }
 
 static bool is_el1_mte_sync_tag_check_fault(unsigned long esr)

-- 
Catalin
