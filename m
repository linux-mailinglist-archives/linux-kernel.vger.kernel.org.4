Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FDB7431DF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjF3ApT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF3ApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:45:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6E110;
        Thu, 29 Jun 2023 17:45:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6689430d803so868157b3a.0;
        Thu, 29 Jun 2023 17:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688085915; x=1690677915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gS76Agew+AFD2zmlX7au8D9T4ETaBDOuwZWs80WLt0A=;
        b=k/IG2FldiYn7BTYy4VbCLoO4o/I454g7fHLPapqNgnb3Iq6oEcRF5RPWfEKPrcoioa
         zqt6z/ne+9U/wKX9V1ilVQSp+TH2nnsHa6Xnl3NOPORD7IPpFgk+1NV7brS8kG91GGYX
         EW9SoyG0R+qwwLndO3/YE0sH1AWZAM/g0CXy9p9neLQUCW2RWp4TXBWvWExKa1pZlA/f
         EEBhBx0ANwxZH4pf/0cTiiawL91VHg5eLENHT6kMPZ6FbfG9ni5kBBNIOTWZsaa9960a
         L6ZlD9RnXrfh9qPx/SsVuSnJCL3+1ulj7Sd/zH3JjG8jvuUX4KolBv6etc8+Nanc09Vx
         mEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688085915; x=1690677915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gS76Agew+AFD2zmlX7au8D9T4ETaBDOuwZWs80WLt0A=;
        b=aiOLYEbGGDuA71OvNUUDsWHn9j0Vjsp6GUdJFUPpAn31n2wLV6dJETwQphZOUw49Jj
         5YUjpHSQZIYudJITOVRHODeBUHHO9KCEdhEaa2gfPdlZFqm+/qBqYQI6qwZ3XTR3u7oQ
         /YKDW6gmaYuAuj3s8/v6axzMLGEoEWc0JOdAmEAW8yOVZqJEpfbnkFIOh6Qojp7lYLo1
         PuMR3Xi1Qj+y4GX5PiXMQaEV0bl16vJiPY+3qGmVBIfSsQhhSfLRc4CiYFljyNhyEUtO
         77tSr1kJJ17kgGBCzJrNPmbd8JJSMpuHUphPm2xvFpNhQgX/S3jngLjeDuuxc1YMP8fI
         8PHw==
X-Gm-Message-State: AC+VfDxHzSIPnDjuhlSatLSiATrSEslwz4ltxaq/5A0CxoUxHQ9hLOGd
        UIUQJIh31otN5HrXjc8Jhug=
X-Google-Smtp-Source: ACHHUZ76EwTQl/a9hBE2O3g6/fJ45PdJdwO4k2n+AqjcehRvtheafg/LKZrnDQNw0wJ5lHowR/x1HQ==
X-Received: by 2002:a05:6a20:8f0c:b0:117:a2f3:3c93 with SMTP id b12-20020a056a208f0c00b00117a2f33c93mr1382663pzk.2.1688085914744;
        Thu, 29 Jun 2023 17:45:14 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001b69303db65sm9675106plh.26.2023.06.29.17.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 17:45:14 -0700 (PDT)
From:   Ruihong Luo <colorsu1922@gmail.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, luoruihong@xiaomi.com,
        weipengliang@xiaomi.com, wengjinfei@xiaomi.com,
        Ruihong Luo <colorsu1922@gmail.com>
Subject: [PATCH v3] serial: 8250_dw: Preserve original value of DLF register
Date:   Fri, 30 Jun 2023 08:38:08 +0800
Message-Id: <20230630003806.66112-1-colorsu1922@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Preserve the original value of the Divisor Latch Fraction (DLF) register.
When the DLF register is modified without preservation, it can disrupt
the baudrate settings established by firmware or bootloader, leading to
data corruption and the generation of unreadable or distorted characters.

Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
Signed-off-by: Ruihong Luo <colorsu1922@gmail.com>
---
v3:
- modify the commit message
- use personal email to sign
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
2.39.2

