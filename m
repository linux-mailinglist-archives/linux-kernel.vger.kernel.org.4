Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E66E6A54
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjDRQ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjDRQ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:58:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2305EB46A;
        Tue, 18 Apr 2023 09:58:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2f4214b430aso1663528f8f.0;
        Tue, 18 Apr 2023 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681837121; x=1684429121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsjrWeJDS0vk5OQeX1xNeaaHVlqwkpL/lA1GzVaExE0=;
        b=Wz0DNOoWPaENkMPFAAXoY8ecWpRbn4qgyPIWRm/JKmI0ymPM/rY929zRGFR/WfGKxH
         khI1tdAgqdy2FkWQ08ZGrULt27Oc7usqrfhZb5oyqX8ly8uEJ3SgLeXPHVBQRNyI+UF9
         vYSlBJba8tGeuzdEFGM6RLALarCqJxdNCgXyp6n9gdAOcFcMtd9awmqDEDGRPcaK2jEx
         yGw+QuZlzcPf39J0g9xJH1n5lCPJdrUvkUIVFZTDbPEHd+lVt8YWR1uOx8K8TTFpDiZ1
         7gt2hpGhIuGcDi402gGokxml2hD2JMEwuw5QgGQueevT4HUe4wgVa3kl3VnBKxHZZtOE
         KYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837121; x=1684429121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsjrWeJDS0vk5OQeX1xNeaaHVlqwkpL/lA1GzVaExE0=;
        b=PKaQg5+O57QyUk+RW9DvzkkRlI7GBhA9bPQw4Cpv4aY9EEd08k4060rw1+Wz7qvMSh
         ba/EWgOjMPSfS4xEI1Rd8jZgHMISGz7CURGxnCIaJ+XMYGbzTKNdl/YGHjqynzyNTVaC
         6I6vBm8iLbFl6ndY7l9fgd1+K+NPfdcnePO9Ulr4Gbljj+Beef6/I4M/KeM5buMmCHWW
         0zJbaC8HjjekbBH+aLEByHJWhOGN1NtI5wlCBnd3eS+shOQIjOqRI+iGW/BGsjClYfzp
         NeRDXiliz/qnL4s6DAWA+peEbtbiW2Fe4Cb26mZ+DFfdhDyszsemCAaEFVtHvxNu5/dr
         rHbg==
X-Gm-Message-State: AAQBX9fJb0/x1LByaTLZZSGPULg9MYFWn7Wr/fvveeqMhRg2d43Bnh+z
        h0ouMMTEfePCWD4MpMHp6Xy31Nt4YBQ=
X-Google-Smtp-Source: AKy350Zcnt+zvmgVLvgW1/BQ8Cp7TXtP9Sb2BmRpO/CXHzyVsEYESTvpXVVf8w2mPOxG51raYiHFiQ==
X-Received: by 2002:adf:e710:0:b0:2c7:bb13:e23f with SMTP id c16-20020adfe710000000b002c7bb13e23fmr2885313wrm.24.1681837120873;
        Tue, 18 Apr 2023 09:58:40 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id n25-20020a05600c181900b003f173a00304sm6468978wmp.17.2023.04.18.09.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:58:40 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH 4/4] openrisc: Add floating point regset
Date:   Tue, 18 Apr 2023 17:58:13 +0100
Message-Id: <20230418165813.1900991-5-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230418165813.1900991-1-shorne@gmail.com>
References: <20230418165813.1900991-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define REGSET_FPU to allow reading and writing the FPCSR fpu state
register.  This will be used primarily by debuggers like GDB.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/ptrace.c | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index 85ace93fc251..f1fc276d46bb 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -84,11 +84,40 @@ static int genregs_set(struct task_struct *target,
 	return ret;
 }
 
+/*
+ * As OpenRISC shares GPRs and floating point registers we don't need to export
+ * the floating point registers again.  So here we only export the fpcsr special
+ * purpose register.
+ */
+static int fpregs_get(struct task_struct *target,
+		       const struct user_regset *regset,
+		       struct membuf to)
+{
+	const struct pt_regs *regs = task_pt_regs(target);
+
+	return membuf_store(&to, regs->fpcsr);
+}
+
+static int fpregs_set(struct task_struct *target,
+		       const struct user_regset *regset,
+		       unsigned int pos, unsigned int count,
+		       const void *kbuf, const void __user *ubuf)
+{
+	struct pt_regs *regs = task_pt_regs(target);
+	int ret;
+
+	/* FPCSR */
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &regs->fpcsr, 0, 4);
+	return ret;
+}
+
 /*
  * Define the register sets available on OpenRISC under Linux
  */
 enum or1k_regset {
 	REGSET_GENERAL,
+	REGSET_FPU,
 };
 
 static const struct user_regset or1k_regsets[] = {
@@ -100,6 +129,14 @@ static const struct user_regset or1k_regsets[] = {
 			    .regset_get = genregs_get,
 			    .set = genregs_set,
 			    },
+	[REGSET_FPU] = {
+			    .core_note_type = NT_PRFPREG,
+			    .n = sizeof(struct __or1k_fpu_state) / sizeof(long),
+			    .size = sizeof(long),
+			    .align = sizeof(long),
+			    .regset_get = fpregs_get,
+			    .set = fpregs_set,
+			    },
 };
 
 static const struct user_regset_view user_or1k_native_view = {
-- 
2.39.1

