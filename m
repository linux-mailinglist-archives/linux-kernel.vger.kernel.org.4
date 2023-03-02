Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD366A7A20
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCBDir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCBDiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:38:46 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8057423337
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:38:10 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id p6so9052021pga.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 19:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677728289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kK3Dj4U5YWACwWutML+PY+76X37EOgEhaC4TqzyvWlU=;
        b=pywJb+/Tkb6jZ0dtEJc61IeBWwab3zuYwcrOJIFfK4ZdLD06jRk9oOaxBC6T+xwpIU
         onPF300X9ZGD3USf2qbIz9Qguzb00oCva3x+BE3pjIN8HLWHNI2YiOb84eZ2LPL+AMyv
         SO3sPkz6D3jePbXdkIjPEZSm2Eifl4fdh8dxv0xN/asnolR7RO/LKua3HL833DqIG0+K
         eaQ4l8Tqijdh2J4cjBXF0QqHkUyajKDc4wULcYkDrMVY1bgb4U0Bmw8SdbDEEPLv9uNl
         csATgBRuwbLwZZQd/35PYJvObI6nCU4biI8eXAQ7d3X8Dqg3WeQwGR/Bvltq307q9t6/
         REmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677728289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kK3Dj4U5YWACwWutML+PY+76X37EOgEhaC4TqzyvWlU=;
        b=wrtsPMYGjuuUnBHJ73++dyYzEuDgpIpbnNj39cfiHe3DAowhQFFLV9Jsud0OEEEdHa
         OFSy36n4Kyisfn397y1Wo8HlA4luUiTpOQiTT88lH1V8OqV8FQMZLAHra6zx3fnsvZZC
         Dsh9b5SES6wqown+iRI32DnpYPv3k47ai17ZPP6jcQPRQy2W8kZYeTGh50m3vnx3TX1K
         LMDDddrxSmHYWlJaK4qUbooWS/NdJsFE6yGVyXFOHoMQqc4DJ2zzCmrtSZ0he3Qkisxp
         5FHOyPxxPsrfdYWkBoLdI7mfWOnuvLnK7LAovXSPFRPTiIk0Ffley+E6W8/IIu9phBcP
         N/PA==
X-Gm-Message-State: AO0yUKWZqsntLRUzi4ofFPt7cxK+e5y5YRqvmDr4Jjpr9P8CmVrax7zT
        217JdOsSV601zTOxg2Vqu0A=
X-Google-Smtp-Source: AK7set9tbuX/GOWCL8Qz0mnmgzpvBUsivAmbJZvW+TcGU6gx/z9iDCBZ2BsU1IFaTgZxMd3RDt8w8w==
X-Received: by 2002:aa7:990f:0:b0:5a8:ad6c:cd43 with SMTP id z15-20020aa7990f000000b005a8ad6ccd43mr8323105pff.31.1677728289365;
        Wed, 01 Mar 2023 19:38:09 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id i22-20020aa787d6000000b00593a1f7c3dbsm8882731pfo.10.2023.03.01.19.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 19:38:08 -0800 (PST)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Chih-En Lin <shiyn.lin@gmail.com>
Subject: [PATCH] mm/x86: Cleanup unnecessary tsk variable
Date:   Thu,  2 Mar 2023 11:42:21 +0800
Message-Id: <20230302034221.1078251-1-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unnecessary to use tsk to access current if tsk is used by one
time only. In such a case, drop variable tsk by using current.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 arch/x86/mm/fault.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7b0d4ab894c8..841ccf340ce8 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -605,16 +605,14 @@ static noinline void
 pgtable_bad(struct pt_regs *regs, unsigned long error_code,
 	    unsigned long address)
 {
-	struct task_struct *tsk;
 	unsigned long flags;
 	int sig;
 
 	flags = oops_begin();
-	tsk = current;
 	sig = SIGKILL;
 
 	printk(KERN_ALERT "%s: Corrupted page table at address %lx\n",
-	       tsk->comm, address);
+	       current->comm, address);
 	dump_pagetable(address);
 
 	if (__die("Bad pagetable", regs, error_code))
@@ -831,8 +829,6 @@ static void
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		       unsigned long address, u32 pkey, int si_code)
 {
-	struct task_struct *tsk = current;
-
 	if (!user_mode(regs)) {
 		kernelmode_fixup_or_oops(regs, error_code, address,
 					 SIGSEGV, si_code, pkey);
@@ -867,7 +863,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		return;
 
 	if (likely(show_unhandled_signals))
-		show_signal_msg(regs, error_code, address, tsk);
+		show_signal_msg(regs, error_code, address, current);
 
 	set_signal_archinfo(address, error_code);
 
@@ -1253,14 +1249,10 @@ void do_user_addr_fault(struct pt_regs *regs,
 			unsigned long address)
 {
 	struct vm_area_struct *vma;
-	struct task_struct *tsk;
-	struct mm_struct *mm;
+	struct mm_struct *mm = current->mm;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
-	tsk = current;
-	mm = tsk->mm;
-
 	if (unlikely((error_code & (X86_PF_USER | X86_PF_INSTR)) == X86_PF_INSTR)) {
 		/*
 		 * Whoops, this is kernel mode code trying to execute from
-- 
2.39.1

