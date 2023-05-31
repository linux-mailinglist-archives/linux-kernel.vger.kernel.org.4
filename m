Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D1D717F52
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjEaL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbjEaL5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:57:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF12B121;
        Wed, 31 May 2023 04:57:18 -0700 (PDT)
Date:   Wed, 31 May 2023 11:57:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685534237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oz+q/aRG7iEvO/yg/BT9Is3z4SPuuUOoyopbHSj7v40=;
        b=r69tS5M3dRnEzzj5khaZM5nU/GPpIPnGVZvekOCLZRB0xN1pnrO9LVeTcO9Hhh/i6uDfo7
        0nOKzAg6dCXz+xHTAzBIO1QpScX0xQMMpmmha52wp6n1kUFDg83wV0dAZare02KowzmeaF
        Xbuy3s1qmdW7/V6/5IP7tQENhoakyS9+o0WiSWclA13UfrYhp0wR/2QFlojQ8fbh/WZsTv
        598u859C/sjSI2Ml+WjvaCbLUj52zXBDWcQrLDI6Iw9HV0keGxjSXZ0DdBvI3a40y7Ivc5
        lGRCDAaemcPoDY2eHXfG0yaf+3O1CDNCCi87AL4WxE4Ev+e07CkMn7dzLaQxMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685534237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oz+q/aRG7iEvO/yg/BT9Is3z4SPuuUOoyopbHSj7v40=;
        b=tzmekfbdcGwDJLWjY6IBJjVNeFQEDJe0vqDe9QigR+1DQ6Gsf3Oxt9ZUQOYiE0bNI9S3Y2
        HfMpaCtM2wXeYtCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Add longer 64-bit NOPs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515093020.661756940@infradead.org>
References: <20230515093020.661756940@infradead.org>
MIME-Version: 1.0
Message-ID: <168553423659.404.5660759235465936351.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     df25edbac31ea87b488789d44a362063542b5967
Gitweb:        https://git.kernel.org/tip/df25edbac31ea87b488789d44a362063542b5967
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 15 May 2023 11:28:05 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 May 2023 10:21:21 +02:00

x86/alternatives: Add longer 64-bit NOPs

By adding support for longer NOPs there are a few more alternatives
that can turn into a single instruction.

Add up to NOP11, the same limit where GNU as .nops also stops
generating longer nops. This is because a number of uarchs have severe
decode penalties for more than 3 prefixes.

  [ bp: Sync up with the version in tools/ while at it. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230515093020.661756940@infradead.org
---
 arch/x86/include/asm/nops.h       | 16 ++++++++++++++--
 arch/x86/kernel/alternative.c     | 10 ++++++++++
 tools/arch/x86/include/asm/nops.h | 16 ++++++++++++++--
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/nops.h b/arch/x86/include/asm/nops.h
index c5573ea..1c1b755 100644
--- a/arch/x86/include/asm/nops.h
+++ b/arch/x86/include/asm/nops.h
@@ -34,6 +34,8 @@
 #define BYTES_NOP7	0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
 #define BYTES_NOP8	0x3e,BYTES_NOP7
 
+#define ASM_NOP_MAX 8
+
 #else
 
 /*
@@ -47,6 +49,9 @@
  * 6: osp nopl 0x00(%eax,%eax,1)
  * 7: nopl 0x00000000(%eax)
  * 8: nopl 0x00000000(%eax,%eax,1)
+ * 9: cs nopl 0x00000000(%eax,%eax,1)
+ * 10: osp cs nopl 0x00000000(%eax,%eax,1)
+ * 11: osp osp cs nopl 0x00000000(%eax,%eax,1)
  */
 #define BYTES_NOP1	0x90
 #define BYTES_NOP2	0x66,BYTES_NOP1
@@ -56,6 +61,15 @@
 #define BYTES_NOP6	0x66,BYTES_NOP5
 #define BYTES_NOP7	0x0f,0x1f,0x80,0x00,0x00,0x00,0x00
 #define BYTES_NOP8	0x0f,0x1f,0x84,0x00,0x00,0x00,0x00,0x00
+#define BYTES_NOP9	0x2e,BYTES_NOP8
+#define BYTES_NOP10	0x66,BYTES_NOP9
+#define BYTES_NOP11	0x66,BYTES_NOP10
+
+#define ASM_NOP9  _ASM_BYTES(BYTES_NOP9)
+#define ASM_NOP10 _ASM_BYTES(BYTES_NOP10)
+#define ASM_NOP11 _ASM_BYTES(BYTES_NOP11)
+
+#define ASM_NOP_MAX 11
 
 #endif /* CONFIG_64BIT */
 
@@ -68,8 +82,6 @@
 #define ASM_NOP7 _ASM_BYTES(BYTES_NOP7)
 #define ASM_NOP8 _ASM_BYTES(BYTES_NOP8)
 
-#define ASM_NOP_MAX 8
-
 #ifndef __ASSEMBLY__
 extern const unsigned char * const x86_nops[];
 #endif
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 93aa95a..0747d29 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -98,6 +98,11 @@ static const unsigned char x86nops[] =
 	BYTES_NOP6,
 	BYTES_NOP7,
 	BYTES_NOP8,
+#ifdef CONFIG_64BIT
+	BYTES_NOP9,
+	BYTES_NOP10,
+	BYTES_NOP11,
+#endif
 };
 
 const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
@@ -111,6 +116,11 @@ const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
 	x86nops + 1 + 2 + 3 + 4 + 5,
 	x86nops + 1 + 2 + 3 + 4 + 5 + 6,
 	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
+#ifdef CONFIG_64BIT
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9,
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10,
+#endif
 };
 
 /*
diff --git a/tools/arch/x86/include/asm/nops.h b/tools/arch/x86/include/asm/nops.h
index c5573ea..1c1b755 100644
--- a/tools/arch/x86/include/asm/nops.h
+++ b/tools/arch/x86/include/asm/nops.h
@@ -34,6 +34,8 @@
 #define BYTES_NOP7	0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
 #define BYTES_NOP8	0x3e,BYTES_NOP7
 
+#define ASM_NOP_MAX 8
+
 #else
 
 /*
@@ -47,6 +49,9 @@
  * 6: osp nopl 0x00(%eax,%eax,1)
  * 7: nopl 0x00000000(%eax)
  * 8: nopl 0x00000000(%eax,%eax,1)
+ * 9: cs nopl 0x00000000(%eax,%eax,1)
+ * 10: osp cs nopl 0x00000000(%eax,%eax,1)
+ * 11: osp osp cs nopl 0x00000000(%eax,%eax,1)
  */
 #define BYTES_NOP1	0x90
 #define BYTES_NOP2	0x66,BYTES_NOP1
@@ -56,6 +61,15 @@
 #define BYTES_NOP6	0x66,BYTES_NOP5
 #define BYTES_NOP7	0x0f,0x1f,0x80,0x00,0x00,0x00,0x00
 #define BYTES_NOP8	0x0f,0x1f,0x84,0x00,0x00,0x00,0x00,0x00
+#define BYTES_NOP9	0x2e,BYTES_NOP8
+#define BYTES_NOP10	0x66,BYTES_NOP9
+#define BYTES_NOP11	0x66,BYTES_NOP10
+
+#define ASM_NOP9  _ASM_BYTES(BYTES_NOP9)
+#define ASM_NOP10 _ASM_BYTES(BYTES_NOP10)
+#define ASM_NOP11 _ASM_BYTES(BYTES_NOP11)
+
+#define ASM_NOP_MAX 11
 
 #endif /* CONFIG_64BIT */
 
@@ -68,8 +82,6 @@
 #define ASM_NOP7 _ASM_BYTES(BYTES_NOP7)
 #define ASM_NOP8 _ASM_BYTES(BYTES_NOP8)
 
-#define ASM_NOP_MAX 8
-
 #ifndef __ASSEMBLY__
 extern const unsigned char * const x86_nops[];
 #endif
