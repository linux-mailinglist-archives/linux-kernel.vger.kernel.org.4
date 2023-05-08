Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931316FAF2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjEHLx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbjEHLxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:53:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0542441555
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:53:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ab0c697c84so32982055ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683546800; x=1686138800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd6PQ1vE/SZdiXRk2V4YVd/9ukw5PfEy62nQ6sf0Uk0=;
        b=Wj+BdFY08go+Klnkl9ikMjatb5QJpTO2cewG54fs1b3lW77HcXNjgQTN2vzRD/j8ke
         U3yyKNS6ssEcggGMDfAXgwZPVb+FBmqfOr+Em+1ArsfHhZf2wSJZfgC6VkUq+JwWgyLn
         g+RLMWOOtmon/m7EVa2DCP+ETl1ECCK4M3nMIjFho7LKvb2yNVDCezwfPiVlDcs9QJCj
         8LW7073DSm3mdChDFXxsHRRaDLUKp6u28cqpHj2tCtL9vO7xzRypFejOqMQyJUAGg7RB
         COx5W+bUevsvQur/1Cp+1+YUYxa7JkuqnS6OOhyy6oxt/zn2DyhnlYWkHpifR+QPUO6n
         siaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546800; x=1686138800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd6PQ1vE/SZdiXRk2V4YVd/9ukw5PfEy62nQ6sf0Uk0=;
        b=LvnT5fe5iYufqlQw7BB1dU8jIB6DStGkJ95D9iZSvgEP+AU/f9R6LF9iDhHvIZfnja
         0JzeU6LpH6v+P2buXubxxD7tdTBIMwqT4opzHcdH0TRQ3bqRoQ3j+TsVRA3taCgc0ri0
         V1tSXi1h0hiMNJL/uVXAXb2SAeRiDm+nbc5bHzq/WhUOPmhngYLenv3Nw5t9ZDWYjXGj
         riMJ65iC1ZBK6vB+jo4q2sD+W/rfReruNM+AWsw3Sb05q+CMM8ETjiS+kh4mTPo0/o1G
         QUasrJB1RTII7UUPdq0Q9zACcNtfAiFT68OXQxMinW8xf+dGjqFrDzqqYX13b1SDYcG9
         RXxg==
X-Gm-Message-State: AC+VfDzOHRZpOToWmIEmOry+ytD6voYy2B+a3AcV8ofxodfQvX6Xsa23
        biOukCzqSAWiIahnW2GZM+Vnqw==
X-Google-Smtp-Source: ACHHUZ44JOKf09v8SpLqQAPymUJYFxrBhM0oK44TrPeFKd+o5n6tK/8ozBu8m8cH4Q+O9X7/qncP4w==
X-Received: by 2002:a17:903:1252:b0:1aa:f0a7:933 with SMTP id u18-20020a170903125200b001aaf0a70933mr12699535plh.25.1683546800261;
        Mon, 08 May 2023 04:53:20 -0700 (PDT)
Received: from sunil-laptop.. ([106.51.189.144])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902904900b001aaed524541sm7015149plz.227.2023.05.08.04.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:53:19 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH V5 03/21] crypto: hisilicon/qm: Fix to enable build with RISC-V clang
Date:   Mon,  8 May 2023 17:22:19 +0530
Message-Id: <20230508115237.216337-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508115237.216337-1-sunilvl@ventanamicro.com>
References: <20230508115237.216337-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_ACPI enabled for RISC-V, this driver gets enabled in
allmodconfig build. However, build fails with clang and below
error is seen.

drivers/crypto/hisilicon/qm.c:627:10: error: invalid output constraint '+Q' in asm
                       "+Q" (*((char __iomem *)fun_base))
                       ^
This is expected error with clang due to the way it is designed.

To fix this issue, move arm64 assembly code under #if.

Link: https://github.com/ClangBuiltLinux/linux/issues/999
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
[sunilvl@ventanamicro.com: Moved tmp0 and tmp1 into the #if]
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/crypto/hisilicon/qm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index ad0c042b5e66..2eaeaac2e246 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -610,13 +610,9 @@ EXPORT_SYMBOL_GPL(hisi_qm_wait_mb_ready);
 static void qm_mb_write(struct hisi_qm *qm, const void *src)
 {
 	void __iomem *fun_base = qm->io_base + QM_MB_CMD_SEND_BASE;
-	unsigned long tmp0 = 0, tmp1 = 0;
 
-	if (!IS_ENABLED(CONFIG_ARM64)) {
-		memcpy_toio(fun_base, src, 16);
-		dma_wmb();
-		return;
-	}
+#if IS_ENABLED(CONFIG_ARM64)
+	unsigned long tmp0 = 0, tmp1 = 0;
 
 	asm volatile("ldp %0, %1, %3\n"
 		     "stp %0, %1, %2\n"
@@ -626,6 +622,11 @@ static void qm_mb_write(struct hisi_qm *qm, const void *src)
 		       "+Q" (*((char __iomem *)fun_base))
 		     : "Q" (*((char *)src))
 		     : "memory");
+#else
+	memcpy_toio(fun_base, src, 16);
+	dma_wmb();
+#endif
+
 }
 
 static int qm_mb_nolock(struct hisi_qm *qm, struct qm_mailbox *mailbox)
-- 
2.34.1

