Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73227339A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346022AbjFPTTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346032AbjFPTRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:17:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE4F3C0C;
        Fri, 16 Jun 2023 12:17:07 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:17:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/hAFkO4NOEoER8CL9Q/AGPB5LbRC/8Ycn9rCGt2ZoqY=;
        b=xsOE2Sf5w8kZAw22ij4qb4/pI8OICio0+mQZ/qylFhGsUcLQZe48nw3ZhoJXE8iXPXcbi7
        Yopbg1I5XVgOPbC8NxOv3DDaEVWQdysjPRi7cLhZ/rLaKpPzYyAjXEhHYCptQgsFkpqB03
        s9U9rEBSiqvrT6cAMsRDzQLmtISL3fXvGMdw9XtHPeKas6IYIshz8ET33vbl1yD7YQzpW3
        fJp3/HOOLDtgz7IcWbOpPGQIrOBibbe4OJjooOSRR2bM9XQQQ7bdS9Zhg6M2UZTZ+5eFgk
        6pLi4iEB0/bADEYKLoUxm35i3ltoSvF7Nj0oMJB1a8jEFAegT/QR51gILwEmJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/hAFkO4NOEoER8CL9Q/AGPB5LbRC/8Ycn9rCGt2ZoqY=;
        b=+ZwxYiT7TlI5fLF3t5QBMPCATdL1h0J3DKA83I2mGonRz2Ng/A8UhI06mQrs38X3kKVlDA
        HikyIg7zijxsrUAw==
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694302574.404.15745410316250224679.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     da6031de051337fc7ace0738553d509fd26cc85c
Gitweb:        https://git.kernel.org/tip/da6031de051337fc7ace0738553d509fd26cc85c
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:31 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:00 -07:00

mm: Move VM_UFFD_MINOR_BIT from 37 to 38

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

Future patches will introduce a new VM flag VM_SHADOW_STACK that will be
VM_HIGH_ARCH_BIT_5. VM_HIGH_ARCH_BIT_1 through VM_HIGH_ARCH_BIT_4 are
bits 32-36, and bit 37 is the unrelated VM_UFFD_MINOR_BIT. For the sake
of order, make all VM_HIGH_ARCH_BITs stay together by moving
VM_UFFD_MINOR_BIT from 37 to 38. This will allow VM_SHADOW_STACK to be
introduced as 37.

Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Peter Xu <peterx@redhat.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-6-rick.p.edgecombe%40intel.com
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9ec20cb..6f52c1e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -370,7 +370,7 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-# define VM_UFFD_MINOR_BIT	37
+# define VM_UFFD_MINOR_BIT	38
 # define VM_UFFD_MINOR		BIT(VM_UFFD_MINOR_BIT)	/* UFFD minor faults */
 #else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 # define VM_UFFD_MINOR		VM_NONE
