Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A2261F82A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiKGQCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiKGQCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:02:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0096620180
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oO821jkjlpuWvMjorfVycJRbysjDeH9qbTWtMmciLn8=; b=n1P1Ab7fp7eMKEsOzFUWRPPdyh
        W93J6IgWS8yqluVC18qzmMGlyjQZ8H4RWfV/w5rBPa8ztmIPaeGlYeSZUtGRYaiQTVXOWpyugfp7H
        fAfx1OJHTs/VyPdjJE5AAj1t0AHlnWvxOoKd69ukhuJpnmdeL+ho9mGYO71JyYE0EdHT6tyJqAqsv
        2xnO6ks0Pwzjc9SSOz3dCg7GrPSU8JdV7ewEBocGbNsRoQmyw9efsuCMZsFJwmqNBuOHczPA8Lic/
        TXq33T0yo0Hi5q/20aT2YJiL0GQHwopaTTfzR818g5ClOVX4KpLhwT45FEW7F3828oE3/Q4Hojw14
        LbBinlug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1os4Zn-009U4Y-3Z; Mon, 07 Nov 2022 16:02:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67F3B30026A;
        Mon,  7 Nov 2022 17:02:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50C6E2B1A6BC5; Mon,  7 Nov 2022 17:02:13 +0100 (CET)
Date:   Mon, 7 Nov 2022 17:02:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [tip:x86/mm] [x86/mm]  b389949485:
 WARNING:at_arch/x86/mm/pat/set_memory.c:#__change_page_attr
Message-ID: <Y2ksBbNMsRKFzN4Y@hirez.programming.kicks-ass.net>
References: <202211061748.eb591682-oliver.sang@intel.com>
 <Y2kgVE+etZ1+F2PW@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kgVE+etZ1+F2PW@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 04:12:20PM +0100, Peter Zijlstra wrote:
> On Sun, Nov 06, 2022 at 08:38:27PM +0800, kernel test robot wrote:
> > 
> > Greeting,
> > 
> > FYI, we noticed WARNING:at_arch/x86/mm/pat/set_memory.c:#__change_page_attr due to commit (built with gcc-11):
> > 
> > commit: b38994948567e6d6b62947401c57f4ab2efe070c ("x86/mm: Implement native set_memory_rox()")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm
> > 
> > [test failed on linux-next/master 0cdb3579f1ee4c1e55acf8dfb0697b660067b1f8]
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > If you fix the issue, kindly add following tag
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Link: https://lore.kernel.org/oe-lkp/202211061748.eb591682-oliver.sang@intel.com
> > 
> > 
> > [   44.943065][   T11] ------------[ cut here ]------------
> > [   44.943725][   T11] CPA detected W^X violation: 0000000000000060 -> 0000000000000063 range: 0xffff8881beca5000 - 0xffff8881beca5fff PFN 1beca5
> > [ 44.944929][ T11] WARNING: CPU: 0 PID: 11 at arch/x86/mm/pat/set_memory.c:609 __change_page_attr (arch/x86/mm/pat/set_memory.c:609 arch/x86/mm/pat/set_memory.c:1582) 
> > [   44.945824][   T11] Modules linked in:
> > [   44.946229][   T11] CPU: 0 PID: 11 Comm: kworker/0:1 Tainted: G        W          6.1.0-rc3-00010-gb38994948567 #1 f37474c2082f37dd433f70907b94c2b0df8d70b8
> > [   44.947518][   T11] Workqueue: events bpf_prog_free_deferred
> > [ 44.948074][ T11] RIP: 0010:__change_page_attr (arch/x86/mm/pat/set_memory.c:609 arch/x86/mm/pat/set_memory.c:1582) 
> 
> Urgh, as spotted by dhansen, the code in change_page_attr_set_clr(),
> specifically the checkalias thing, seems to rely on single bit flips for
> NX.
> 
> Let me try to make sense of this stuff....

This appears to appease the test case, but I definitely need to look at
this again with a fresh mind, horrid stuff this and I'm sure I hate this
patch.


---
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index f275605892df..07339ac8bc41 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -69,10 +69,11 @@ static const int cpa_warn_level = CPA_PROTECT;
  */
 static DEFINE_SPINLOCK(cpa_lock);
 
-#define CPA_FLUSHTLB 1
-#define CPA_ARRAY 2
-#define CPA_PAGES_ARRAY 4
-#define CPA_NO_CHECK_ALIAS 8 /* Do not search for aliases */
+#define CPA_FLUSHTLB		0x01
+#define CPA_ARRAY		0x02
+#define CPA_PAGES_ARRAY		0x04
+#define CPA_NO_CHECK_ALIAS	0x08 /* Do not search for aliases */
+#define CPA_HAS_NX		0x10
 
 static inline pgprot_t cachemode2pgprot(enum page_cache_mode pcm)
 {
@@ -1708,9 +1709,21 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
 			goto out;
 
 		if (checkalias) {
-			ret = cpa_process_alias(cpa);
-			if (ret)
-				goto out;
+			pgprot_t set = cpa->mask_set;
+			pgprot_t clr = cpa->mask_clr;
+
+			if (cpa->flags & CPA_HAS_NX) {
+				cpa->mask_set.pgprot &= ~_PAGE_NX;
+				cpa->mask_clr.pgprot &= ~_PAGE_NX;
+			}
+			if (pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr)) {
+				ret = cpa_process_alias(cpa);
+				if (ret)
+					goto out;
+			}
+
+			cpa->mask_set = set;
+			cpa->mask_clr = clr;
 		}
 
 		/*
@@ -1788,8 +1801,10 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 	if (in_flag & (CPA_ARRAY | CPA_PAGES_ARRAY))
 		cpa.flags |= in_flag;
 
-	/* No alias checking for _NX bit modifications */
-	checkalias = (pgprot_val(mask_set) | pgprot_val(mask_clr)) != _PAGE_NX;
+	if ((pgprot_val(mask_set) | pgprot_val(mask_clr)) & _PAGE_NX)
+		cpa.flags |= CPA_HAS_NX;
+
+	checkalias = 1;
 	/* Has caller explicitly disabled alias checking? */
 	if (in_flag & CPA_NO_CHECK_ALIAS)
 		checkalias = 0;
