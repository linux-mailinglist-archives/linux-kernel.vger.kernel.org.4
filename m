Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C900473CB13
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjFXNiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 09:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFXNiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 09:38:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D96D11C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 06:38:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25edb50c3acso1176569a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687613880; x=1690205880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3NpgYDLt7ykmx7/GBz8c/ahah0KCZNV3w9qSaAm6EvU=;
        b=BoamLgKZc8FKQJW6rMvsb2KYHhrA1XhGZ0BgG/1UYCH3rjAJp2sZqOCRJGxwbessc5
         WXzO40/bewmhaPiprHlD0BHpdWmc29eV4+Be/dAWrPuy//9fwtdhCc+jjda1TtXfYCk0
         wXmYq2U0Hf0pHukx9weObbpIXFtqj/8L63p39smEyKxm62niJXxvnmc3+c62uWyszrvD
         h9HIqzHgpPzWg6cYjlGE8hRZiBr4YvsrlFJND/HGK5prX2VFOoVjJZ6d4FFjukki8uIU
         1ctLEpgQZFmeCKlNVrEQ8TD/zWalS32gWi8BH5grp5rVON74z6iHM61xGrVPh4kmLcj6
         R5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687613880; x=1690205880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NpgYDLt7ykmx7/GBz8c/ahah0KCZNV3w9qSaAm6EvU=;
        b=XZFeW2Lm6MWdXSHweM0LSTN4qR+PxsXrdzxaR7jnyywHRFDWipOrcHvEXtC/J3VuWz
         CaMUasC30wmTfLm95oN00Z7Yis/VHRVHUWSWPm+vv8R4GDe+qVxDDSqYRvhYTvk60nWv
         Lgq3d8D+EUEct4+Tgu7yyk4bVsuXNpy+qHCZaKKIjpC3Avj27A20OZjOawncai3mhhVE
         k1+g50IO2ljK3C1sILDYltXXgEQCWgWeTuP72u9/XGJAuGf30vvXR3VbrGgo0PYcSaZj
         WIRRHUpbO5kYJADxZ+aOGVqoGkxpzvDdYMTWV2Wmaaxwuy/bWb2YqaYZ2WGjtzvIOCJm
         KMIQ==
X-Gm-Message-State: AC+VfDycB+V8fmLNyEMtF3xhPxZNj44NJnlXePysCY54Dc3eEQ0aweiC
        wtVgs7l+zb4mGIael4tTWPP41+A09HY=
X-Google-Smtp-Source: ACHHUZ6V44Tndn5ml2kjocIFPsFTxXO8qKdLIwVxeQsbsd+EIpx/Kp3v6/zQcvm96N+sDFeKXF+fdA==
X-Received: by 2002:a17:90b:4b4c:b0:25b:eeb3:adc4 with SMTP id mi12-20020a17090b4b4c00b0025beeb3adc4mr23645752pjb.15.1687613880146;
        Sat, 24 Jun 2023 06:38:00 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:6f5f:ba7d:3496:54ff])
        by smtp.gmail.com with ESMTPSA id w29-20020a63161d000000b0052871962579sm1248150pgl.63.2023.06.24.06.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 06:37:59 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: rearrange show_stack output
Date:   Sat, 24 Jun 2023 06:37:55 -0700
Message-Id: <20230624133755.621724-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minimal stack alignment on xtensa is 16 bytes, having stack dump in
32-byte lines may be visually misleading as the stack frame border may
be in the middle of the line.
Arrange stack dump in 16-byte lines. Mark lines at stack frame borders
with arrows.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/traps.c | 57 ++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 71588bf55632..a2a9a460ec9e 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -549,31 +549,58 @@ static void show_trace(struct task_struct *task, unsigned long *sp,
 }
 
 #define STACK_DUMP_ENTRY_SIZE 4
-#define STACK_DUMP_LINE_SIZE 32
+#define STACK_DUMP_LINE_SIZE 16
 static size_t kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
-void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
+struct stack_fragment
 {
-	size_t len, off = 0;
-
-	if (!sp)
-		sp = stack_pointer(task);
+	size_t len;
+	size_t off;
+	u8 *sp;
+	const char *loglvl;
+};
 
-	len = min((-(size_t)sp) & (THREAD_SIZE - STACK_DUMP_ENTRY_SIZE),
-		  kstack_depth_to_print * STACK_DUMP_ENTRY_SIZE);
+static int show_stack_fragment_cb(struct stackframe *frame, void *data)
+{
+	struct stack_fragment *sf = data;
 
-	printk("%sStack:\n", loglvl);
-	while (off < len) {
+	while (sf->off < sf->len) {
 		u8 line[STACK_DUMP_LINE_SIZE];
-		size_t line_len = len - off > STACK_DUMP_LINE_SIZE ?
-			STACK_DUMP_LINE_SIZE : len - off;
+		size_t line_len = sf->len - sf->off > STACK_DUMP_LINE_SIZE ?
+			STACK_DUMP_LINE_SIZE : sf->len - sf->off;
+		bool arrow = sf->off == 0;
 
-		__memcpy(line, (u8 *)sp + off, line_len);
-		print_hex_dump(loglvl, " ", DUMP_PREFIX_NONE,
+		if (frame && frame->sp == (unsigned long)(sf->sp + sf->off))
+			arrow = true;
+
+		__memcpy(line, sf->sp + sf->off, line_len);
+		print_hex_dump(sf->loglvl, arrow ? "> " : "  ", DUMP_PREFIX_NONE,
 			       STACK_DUMP_LINE_SIZE, STACK_DUMP_ENTRY_SIZE,
 			       line, line_len, false);
-		off += STACK_DUMP_LINE_SIZE;
+		sf->off += STACK_DUMP_LINE_SIZE;
+		if (arrow)
+			return 0;
 	}
+	return 1;
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
+{
+	struct stack_fragment sf;
+
+	if (!sp)
+		sp = stack_pointer(task);
+
+	sf.len = min((-(size_t)sp) & (THREAD_SIZE - STACK_DUMP_ENTRY_SIZE),
+		     kstack_depth_to_print * STACK_DUMP_ENTRY_SIZE);
+	sf.off = 0;
+	sf.sp = (u8 *)sp;
+	sf.loglvl = loglvl;
+
+	printk("%sStack:\n", loglvl);
+	walk_stackframe(sp, show_stack_fragment_cb, &sf);
+	while (sf.off < sf.len)
+		show_stack_fragment_cb(NULL, &sf);
 	show_trace(task, sp, loglvl);
 }
 
-- 
2.30.2

