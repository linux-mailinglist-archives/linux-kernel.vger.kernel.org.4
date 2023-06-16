Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8351D73395A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbjFPTQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjFPTQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:16:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2967C35B0;
        Fri, 16 Jun 2023 12:16:53 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:16:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uD4FTAl8GqM79Qp1tWMlcF0tG9HveU+5wqM6pUabxJg=;
        b=GytVblKaA+DGNcPiMSqWJpi7pRvg4dSCwPDK7yuywzwe3nN2f43LMg2xo4b75BqOrfcN8E
        IZXTxsg83A8A+OEfutOu6uGf2aienVq0RLnZccrlMISZ3LUb89qirGh8sLGVgaPgxs9nRM
        iaLbG6Bp9p4VNrhBe4gOKEOBtWuYVCuYlRLuCcYdqjRuVGiNODthcTc3/408/pb8zlFljU
        GIe5HhMKUumRI8BOMnE04VX8JuN8qUGWoQM11yeIadhkLOOZOc4Mwf1xDXIIrpRRNa5+wi
        49ixTcBE7edo6RZCmDop7kCAw5DNmKSR4D8Kc0jKdNsm+MDaLuKwBoKwqGPQ4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uD4FTAl8GqM79Qp1tWMlcF0tG9HveU+5wqM6pUabxJg=;
        b=Vtztn9quuAeM4vd75EBRgxpHrjJzqNpuC2eHihfTmCBXVBGfK2eEATSGyHmfBILsMAcSRA
        P5E0JlLVaF+aNbDA==
From:   "tip-bot2 for Mike Rapoport" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Add ARCH_SHSTK_UNLOCK
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694301105.404.1532533870683131985.tip-bot2@tip-bot2>
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

Commit-ID:     7a95f0591bbf36f26059ae02b8d341e77333e00c
Gitweb:        https://git.kernel.org/tip/7a95f0591bbf36f26059ae02b8d341e77333e00c
Author:        Mike Rapoport <rppt@linux.ibm.com>
AuthorDate:    Mon, 12 Jun 2023 17:11:07 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:35 -07:00

x86/shstk: Add ARCH_SHSTK_UNLOCK

Userspace loaders may lock features before a CRIU restore operation has
the chance to set them to whatever state is required by the process
being restored. Allow a way for CRIU to unlock features. Add it as an
arch_prctl() like the other shadow stack operations, but restrict it being
called by the ptrace arch_pctl() interface.

[Merged into recent API changes, added commit log and docs]

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-42-rick.p.edgecombe%40intel.com
---
 Documentation/arch/x86/shstk.rst  |  4 ++++
 arch/x86/include/uapi/asm/prctl.h |  1 +
 arch/x86/kernel/process_64.c      |  1 +
 arch/x86/kernel/shstk.c           |  9 +++++++--
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/shstk.rst b/Documentation/arch/x86/shstk.rst
index f09afa5..f3553cc 100644
--- a/Documentation/arch/x86/shstk.rst
+++ b/Documentation/arch/x86/shstk.rst
@@ -75,6 +75,10 @@ arch_prctl(ARCH_SHSTK_LOCK, unsigned long features)
     are ignored. The mask is ORed with the existing value. So any feature bits
     set here cannot be enabled or disabled afterwards.
 
+arch_prctl(ARCH_SHSTK_UNLOCK, unsigned long features)
+    Unlock features. 'features' is a mask of all features to unlock. All
+    bits set are processed, unset bits are ignored. Only works via ptrace.
+
 The return values are as follows. On success, return 0. On error, errno can
 be::
 
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index eedfde3..3189c4a 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -33,6 +33,7 @@
 #define ARCH_SHSTK_ENABLE		0x5001
 #define ARCH_SHSTK_DISABLE		0x5002
 #define ARCH_SHSTK_LOCK			0x5003
+#define ARCH_SHSTK_UNLOCK		0x5004
 
 /* ARCH_SHSTK_ features bits */
 #define ARCH_SHSTK_SHSTK		(1ULL <<  0)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 0f89aa0..e6db21c 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -899,6 +899,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_SHSTK_ENABLE:
 	case ARCH_SHSTK_DISABLE:
 	case ARCH_SHSTK_LOCK:
+	case ARCH_SHSTK_UNLOCK:
 		return shstk_prctl(task, option, arg2);
 	default:
 		ret = -EINVAL;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index d723cdc..d43b7a9 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -489,9 +489,14 @@ long shstk_prctl(struct task_struct *task, int option, unsigned long features)
 		return 0;
 	}
 
-	/* Don't allow via ptrace */
-	if (task != current)
+	/* Only allow via ptrace */
+	if (task != current) {
+		if (option == ARCH_SHSTK_UNLOCK && IS_ENABLED(CONFIG_CHECKPOINT_RESTORE)) {
+			task->thread.features_locked &= ~features;
+			return 0;
+		}
 		return -EINVAL;
+	}
 
 	/* Do not allow to change locked features */
 	if (features & task->thread.features_locked)
