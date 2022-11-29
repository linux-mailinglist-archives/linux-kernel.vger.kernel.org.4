Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58E463BE72
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiK2LAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiK2LAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:00:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE360E9B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:00:23 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso14003473wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EonL2PwB0Makj2JepNmLczYfWSZatIPogqShuTJezMI=;
        b=oC3RvrZh+uD/rIN/OhFpct3sfNNCaF6rodg7ivYc3KKlgkwKPvt1s3rlHtq05ZuK83
         ByMi14bSTIY6u1CzO3uSSE2/0xiVhGKcK6YfPCo7wrZCk3dxci49pvh3E0WUKOlssDQB
         hdDj+gtyTMlQtchdsdLyRFI08Fh2q+VSksE35RSjGojbbww20MP/87IQUOXYsKZVuULU
         BiAAyvI5y43cfac0R8NKk9BWUeGfjNVpIkmxeNTYU1qkIxUUtD/I0oyAcSF9QYDd630h
         YKSrvI30htxcWGuxwvd3/RVnSHvGOp8THzBZcMX3Y5hszJ+8XhAZhWhhlNZDkpejFM3J
         wCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EonL2PwB0Makj2JepNmLczYfWSZatIPogqShuTJezMI=;
        b=vvmEwqMATn48Zp6fKT0rQRfv/opgQwDAtLz1kdJJ98p2+4msNEroewrUDyf62dxZMX
         WQOW5W9qDSZgU+zor1qC0DiLawHEgZ8bNKBwIXp5HrQKdc3bhWzEL7s/A1gF5uRepfC9
         7ph+eUlQA2PQ+IWUYZD/iVl1TaA6X3V2zDF0le/FRTJutRCl2kVzr7UK85HlSFKgYeQk
         G0C24BWlw+M2/FWDHbusPA4YCLof20dmENkpV1/XVvfRFvdukRKYxstXEX+1rZh3gb2A
         41ANmb/dUlgnp9dMKxp3ob4cJhUvSjpdZpKyIuGGch9FP+ghWU5K7YMuucPKfxmaV9gi
         0SnA==
X-Gm-Message-State: ANoB5pk9WdA7j7b7hxlnervGXX+t9pM7itb1vU4zNRd4ZmtOMjukvVj0
        LsXYDqDsRIC4x7RVsd7fQxnfjQ==
X-Google-Smtp-Source: AA0mqf5j5YyHdMnLTqWYWWktLVBD+0Xy9WBNz2pgYLzaZzBHz4S0NpFwwlF5MmZrsdP9vWOUwOJhCw==
X-Received: by 2002:a05:600c:1d9c:b0:3c6:e369:e856 with SMTP id p28-20020a05600c1d9c00b003c6e369e856mr40758892wms.35.1669719622444;
        Tue, 29 Nov 2022 03:00:22 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6b19:1d8e:fbca:fd02])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003a3170a7af9sm1617658wmq.4.2022.11.29.03.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:00:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 05/13] tty: serial: qcom-geni-serial: remove stray newlines
Date:   Tue, 29 Nov 2022 12:00:04 +0100
Message-Id: <20221129110012.224685-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129110012.224685-1-brgl@bgdev.pl>
References: <20221129110012.224685-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Remove stray newlines around #ifdefs for consistency with the rest
of the driver code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e4139718e084..ec2523736e99 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -320,7 +320,6 @@ static void qcom_geni_serial_abort_rx(struct uart_port *uport)
 }
 
 #ifdef CONFIG_CONSOLE_POLL
-
 static int qcom_geni_serial_get_char(struct uart_port *uport)
 {
 	struct qcom_geni_private_data *private_data = uport->private_data;
@@ -545,7 +544,6 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 {
 	return -EPERM;
 }
-
 #endif /* CONFIG_SERIAL_QCOM_GENI_CONSOLE */
 
 static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
-- 
2.37.2

