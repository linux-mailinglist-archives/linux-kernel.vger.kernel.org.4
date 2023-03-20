Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60A56C1C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjCTQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjCTQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:45:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E2AA260;
        Mon, 20 Mar 2023 09:40:01 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vVhpGGV4E0OgcgbnIV2egnjyQ1eflBcjehbPQuqlB1o=;
        b=BUoGqWUFgwjgLKXGfdhiwLgTiKURqMTYooMWbPe4PFQnEtRVJijyK/ATWchWzNXosF0VO4
        EmBlSnipHjS/TcR+k0WUdWDBW1zDWQg9aze4/Ca51/CZ7wuheOTSuRW5vW6vsjybL8v1G/
        i0oHZqCLTzpT0LjmurtxM5bt45eFcL1U2gjxG1gIOI58nbbWuh6EPKTo2aM78PaO4nEMse
        ItWtDR3Bq5PW0GLlGarCedKsnil+5xe2vhBkZYnPGtubgOIg7CwBbIEyca6vLg8rNtKHti
        EKf7HI2ro55rpwL3TS7Wz2YV/6OFsZrGC/s3krW/u6gYn3Dou0nlSdq8qr6gcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vVhpGGV4E0OgcgbnIV2egnjyQ1eflBcjehbPQuqlB1o=;
        b=9UqDlkiIeDYJRvjpSegZReAMx+yGzjrJdoWhUCP91kCEqLeBAFLuDvEUano7dGBR+rNN6R
        WcuTIXUjo2DI9ADg==
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
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933036068.5837.7711056166707419991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     d30299329def886f8bcf068da204011a08ab75f9
Gitweb:        https://git.kernel.org/tip/d30299329def886f8bcf068da204011a08ab75f9
Author:        Mike Rapoport <rppt@linux.ibm.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:34 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:12 -07:00

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
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230319001535.23210-40-rick.p.edgecombe%40intel.com
---
 Documentation/x86/shstk.rst       |  4 ++++
 arch/x86/include/uapi/asm/prctl.h |  1 +
 arch/x86/kernel/process_64.c      |  1 +
 arch/x86/kernel/shstk.c           |  9 +++++++--
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/shstk.rst b/Documentation/x86/shstk.rst
index f09afa5..f3553cc 100644
--- a/Documentation/x86/shstk.rst
+++ b/Documentation/x86/shstk.rst
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
index e314956..200efbb 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -25,6 +25,7 @@
 #define ARCH_SHSTK_ENABLE		0x5001
 #define ARCH_SHSTK_DISABLE		0x5002
 #define ARCH_SHSTK_LOCK			0x5003
+#define ARCH_SHSTK_UNLOCK		0x5004
 
 /* ARCH_SHSTK_ features bits */
 #define ARCH_SHSTK_SHSTK		(1ULL <<  0)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9bbad17..69d4cca 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -835,6 +835,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_SHSTK_ENABLE:
 	case ARCH_SHSTK_DISABLE:
 	case ARCH_SHSTK_LOCK:
+	case ARCH_SHSTK_UNLOCK:
 		return shstk_prctl(task, option, arg2);
 	default:
 		ret = -EINVAL;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index ee89c42..ad336ab 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -459,9 +459,14 @@ long shstk_prctl(struct task_struct *task, int option, unsigned long features)
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
