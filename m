Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F675742387
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjF2JwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjF2Jv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:51:57 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DF510B;
        Thu, 29 Jun 2023 02:51:56 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-54fb23ff7d3so280743a12.0;
        Thu, 29 Jun 2023 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688032316; x=1690624316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCVMSh+Gk7RDucVnKBNJ47jVZEjgab0+pY4wh/BjYmA=;
        b=rJZQYkVlRrCwXyjUd1VxsL/89t9+rbNH9Vn8RGDDYB1utPax3YE7YtaM7jINyNL9Uk
         mM/MeD2Ys4O/TbpQ60UelcpoXBiu4Y/T/63lw5JKTXpkB3UZmNnW/YmvX23JuNTDjr1k
         S+4//VjOQYwhEHDfLigBOSEid1qrHpP+WRtiB4T7sy1yUdIDJ8lQEaBF7HsdMq+3UT3s
         336vBe21TrPs7b8xkiHoq8Nv0G0wBdpmKO7op56Y3jOlKG6HiWn3ee553ckcuVM4zJQi
         dttYYhKx54eoVJMAgkHdJdfa4YiR1y/ccYTXp2o4E0aWfWZF1HY3TSSYXINYl/y3ZK0F
         tHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688032316; x=1690624316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCVMSh+Gk7RDucVnKBNJ47jVZEjgab0+pY4wh/BjYmA=;
        b=aalMKdZsw0AIU+bo7ELjML3bSPIAtrp98y6QoAVpcRDNpLwX2HYo6ygDSVsEybGWGW
         iESJg7FQO+Pmo4GjQ53LlVwKOX+FNySF5nlOpQKjadiD915iYNuDDaVGFCF60j6ccEZ7
         MNZyGGXoFga7Sl+Hx4PqaVYeJEn7j/8Lt62H979bure6tLd00dhnD4y0rx3P4DdsFMON
         7z/rb15KTfZwO8rlKj8FJyAhdV/IjlMJ9+VeLs9gSfAjGK+y2lLnp8St9+T/TXXqbFUj
         bXZdj4z6zxHF8Q2NwOdUR6qgNpjOgLaHY4VBPn/5ChJedvvBt303Zh3HerUdduyCxNnU
         xwAw==
X-Gm-Message-State: AC+VfDyfV7O1k+YuOHoT4QEcjXZ6q7r1ry1F/42T5F0muTHxbRlvxzm0
        Bk2uqmrrjMtCcZm772ITKUQ=
X-Google-Smtp-Source: ACHHUZ6KvjHX1bdqc4J+WW2IvvT5dOtpHWA8sqwO0KOM07SCJ3+GVZ155FnzXHavmTxfYkKmNvyc9Q==
X-Received: by 2002:a05:6a20:244a:b0:12b:b9c0:aa61 with SMTP id t10-20020a056a20244a00b0012bb9c0aa61mr6503693pzc.29.1688032315991;
        Thu, 29 Jun 2023 02:51:55 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902dacb00b001b20dc1b3b9sm8776905plx.104.2023.06.29.02.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:51:55 -0700 (PDT)
From:   ruihongluo <colorsu1922@gmail.com>
X-Google-Original-From: ruihongluo <luoruihong@xiaomi.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     colorsu1922@gmail.com, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        luoruihong@xiaomi.com, wengjinfei@xiaomi.com,
        weipengliang@xiaomi.com
Subject: [PATCH v2 1/1] serial: 8250: Preserve original value of DLF register
Date:   Thu, 29 Jun 2023 17:42:05 +0800
Message-Id: <20230629094204.60246-1-luoruihong@xiaomi.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZJ1M5QvyWzgWNlpE@smile.fi.intel.com>
References: <ZJ1M5QvyWzgWNlpE@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is aimed at preserving the original value of the
DLF(Divisor Latch Fraction Register). When the DLF register is
modified without preservation, it can disrupt the baudrate settings
established by firmware or bootloader , leading to data corruption
and the generation of unreadable or distorted characters.

Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")

Signed-off-by: ruihongluo <luoruihong@xiaomi.com>
---
v2:
- added fixes tag
 
 drivers/tty/serial/8250/8250_dwlib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 75f32f054ebb..d30957722da8 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -244,7 +244,7 @@ void dw8250_setup_port(struct uart_port *p)
 	struct dw8250_port_data *pd = p->private_data;
 	struct dw8250_data *data = to_dw8250_data(pd);
 	struct uart_8250_port *up = up_to_u8250p(p);
-	u32 reg;
+	u32 reg, orig;
 
 	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
 	if (pd->hw_rs485_support) {
@@ -270,9 +270,11 @@ void dw8250_setup_port(struct uart_port *p)
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	/* Preserve value written by firmware or bootloader  */
+	orig = dw8250_readl_ext(p, DW_UART_DLF);
 	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
 	reg = dw8250_readl_ext(p, DW_UART_DLF);
-	dw8250_writel_ext(p, DW_UART_DLF, 0);
+	dw8250_writel_ext(p, DW_UART_DLF, orig);
 
 	if (reg) {
 		pd->dlf_size = fls(reg);
-- 
Just wanted to drop a quick note to say thanks for your help with git
send-email and code modifications.
Your assistance on the details was much appreciated.

Best regards,
Ruihong Luo

