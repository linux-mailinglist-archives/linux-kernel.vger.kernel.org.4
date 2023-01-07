Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B303660CC6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 08:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjAGHhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 02:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAGHhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 02:37:21 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5879D80AF7
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 23:37:20 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so7513386pjk.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 23:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G79kGvOvK2kUaEwYi1qPhoxgJk9OOyECdCC+FtN+8SM=;
        b=O4OXm9YW33tagslMXOjMogagL8sZ3bTlhe3k2v9swUDR+jdbDY42H4ebzdoqT8mAww
         ZOFW12Ox1UG2kOgriPI+sYGHU9O9/zor/nG4Yhd75w0wrFL4Sn4QkEkPaHkiUs/bsN6w
         h0CfEx+RliMORtrGPpR8QKX62uAfW/04X3YdTMaqemBHtbIRD327bxbTTZ5a2izYBc9W
         llii6azA4MaxKTOq45zHW9O6E8ePIs6keNyEM1kap0rJCZzp0FRsWpOBVbQxO+DVDpfu
         tRjykxsezoh1FUHGjV8IK4iRgDDdTZbo1psCYE9V6hgKc35WaeOWj7tZDFx9jG3IJMBs
         X1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G79kGvOvK2kUaEwYi1qPhoxgJk9OOyECdCC+FtN+8SM=;
        b=O4aXcM7rMZE0mRHyQwMhZeVfJXGIviLbvnWtZ9vL8jJdo1ObYZaA0kwhZsu0BiVzzM
         L5BlJbVbpa680vY7JSBJQCc2+9t0/vcKrRs42KIf1kohP5wfMIjvaHOjfSPiSr3UR9jF
         BMqff6snLCzKRVwuRpHAj5JZP2/IZpadmGDisZtc3p50NwiCeKhp5xMPvH4Eh4OHZ4D8
         zzhBRcj4dporJdQoVYld/332uvmKgELJ6U71mzIj/dR/Kn255MtUJPj9AfblS6c8vpsf
         HHSc0bG6f9DhRGUQKWYbad1aRhaChUtLcTy5vImwi89aAPvavTapJJqgJC8r4Lxb7C02
         Cqaw==
X-Gm-Message-State: AFqh2kqYiA+o7QIklUFoXdYMo3VL4hdN0FUjY/uEvZN12gvIfcRcrR2F
        z7yMxRdHXElGmLRrgTJKogg=
X-Google-Smtp-Source: AMrXdXtTpxW378dGOwzIF8UvBqn0SmHpev3ujPfEBi4FIL8aq5qM3SrNOlH3VKNQDuV0C8Q9YpCbkA==
X-Received: by 2002:a17:902:8ec7:b0:192:52d6:7fc7 with SMTP id x7-20020a1709028ec700b0019252d67fc7mr57524462plo.63.1673077039745;
        Fri, 06 Jan 2023 23:37:19 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:ab3b:887b:70e3:4cba])
        by smtp.gmail.com with ESMTPSA id e14-20020a170902ed8e00b00192850277fcsm2093402plj.146.2023.01.06.23.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 23:37:19 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: drop unused members of struct thread_struct
Date:   Fri,  6 Jan 2023 23:37:08 -0800
Message-Id: <20230107073708.1090310-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bad_vaddr, bad_uaddr and error_code fields are set but never read by the
xtensa arch-specific code. Drop them. Also drop the commented out info
field.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/processor.h | 9 ---------
 arch/xtensa/kernel/traps.c          | 2 --
 arch/xtensa/mm/fault.c              | 4 ----
 3 files changed, 15 deletions(-)

diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 228e4dff5fb2..a6d09fe04831 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -154,11 +154,6 @@ struct thread_struct {
 	unsigned long ra; /* kernel's a0: return address and window call size */
 	unsigned long sp; /* kernel's a1: stack pointer */
 
-	/* struct xtensa_cpuinfo info; */
-
-	unsigned long bad_vaddr; /* last user fault */
-	unsigned long bad_uaddr; /* last kernel fault accessing user space */
-	unsigned long error_code;
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	struct perf_event *ptrace_bp[XCHAL_NUM_IBREAK];
 	struct perf_event *ptrace_wp[XCHAL_NUM_DBREAK];
@@ -176,10 +171,6 @@ struct thread_struct {
 {									\
 	ra:		0, 						\
 	sp:		sizeof(init_stack) + (long) &init_stack,	\
-	/*info:		{0}, */						\
-	bad_vaddr:	0,						\
-	bad_uaddr:	0,						\
-	error_code:	0,						\
 }
 
 
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 0c25e035ff10..cd98366a9b23 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -362,8 +362,6 @@ static void do_unaligned_user(struct pt_regs *regs)
 	__die_if_kernel("Unhandled unaligned exception in kernel",
 			regs, SIGKILL);
 
-	current->thread.bad_vaddr = regs->excvaddr;
-	current->thread.error_code = -3;
 	pr_info_ratelimited("Unaligned memory access to %08lx in '%s' "
 			    "(pid = %d, pc = %#010lx)\n",
 			    regs->excvaddr, current->comm,
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 8c781b05c0bd..faf7cf35a0ee 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -206,8 +206,6 @@ void do_page_fault(struct pt_regs *regs)
 bad_area:
 	mmap_read_unlock(mm);
 	if (user_mode(regs)) {
-		current->thread.bad_vaddr = address;
-		current->thread.error_code = is_write;
 		force_sig_fault(SIGSEGV, code, (void *) address);
 		return;
 	}
@@ -232,7 +230,6 @@ void do_page_fault(struct pt_regs *regs)
 	/* Send a sigbus, regardless of whether we were in kernel
 	 * or user mode.
 	 */
-	current->thread.bad_vaddr = address;
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void *) address);
 
 	/* Kernel mode? Handle exceptions or die */
@@ -252,7 +249,6 @@ bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 	if ((entry = search_exception_tables(regs->pc)) != NULL) {
 		pr_debug("%s: Exception at pc=%#010lx (%lx)\n",
 			 current->comm, regs->pc, entry->fixup);
-		current->thread.bad_uaddr = address;
 		regs->pc = entry->fixup;
 		return;
 	}
-- 
2.30.2

