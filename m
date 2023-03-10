Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632456B4B27
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjCJPcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjCJPbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:31:44 -0500
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A397114DA38;
        Fri, 10 Mar 2023 07:19:46 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-53852143afcso103831717b3.3;
        Fri, 10 Mar 2023 07:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678461569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vK9rI6mTHq76BhXmDPa7BjkMjKI93uQSgJiPM86yG6U=;
        b=6VqlLQXC7BmbB/VX5PZZ50Xl6IFIafmjbUQJd8+3mv5RmeaIsOANDlfbD3uXH3RB7h
         hspipZwHp4fMYQqfSbkeNB7lyC6kteMZrh1qC1G0MofdlJG17ZWZ+0dHDdtLPigwGXz9
         TvW4s4oKKhx5NX8ABgiL2WJg615gF4YPeabF+iRPhWT1wxRkq5wRsrAiDpn/CtUH1XCV
         Z+NWIwYtR3HNeIJyaWEhh/Y+Nk/tYVQzS2gsP5jgL4nrT/N7200ZzC4bUVI+ZKttXo/z
         bs50BYFTGCUtBKXd7MltpnVk7EHljZU37D+Jnt6+ibiq9B20C/MpdQiN7dnL+B5JuvbN
         mZVw==
X-Gm-Message-State: AO0yUKUJZTtzygRntLFepC9V+AXW/xJh4zUJZd/drsc8D/t5NUIRz5Lx
        CHWematmYPH9eFcyP5mNsE+MUanZTg==
X-Google-Smtp-Source: AK7set+EbOmyZ/AksMSYYEuG7lFqQ6jiaAPpDlPQ5Tum+fcZZiV0qWudibu3pk/iibkSVwuFhfXHxg==
X-Received: by 2002:a9d:2e9:0:b0:684:dbfd:f239 with SMTP id 96-20020a9d02e9000000b00684dbfdf239mr1088619otl.9.1678459718677;
        Fri, 10 Mar 2023 06:48:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t18-20020a9d7292000000b0068bc476d777sm132335otj.13.2023.03.10.06.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:38 -0800 (PST)
Received: (nullmailer pid 1545743 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Timur Tabi <timur@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] serial: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:27 -0600
Message-Id: <20230310144727.1545699-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/imx.c       | 14 +++++---------
 drivers/tty/serial/mxs-auart.c |  4 ++--
 drivers/tty/serial/ucc_uart.c  |  2 +-
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 5712a4f29607..be168792b635 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2262,20 +2262,16 @@ static int imx_uart_probe(struct platform_device *pdev)
 	}
 	sport->port.line = ret;
 
-	if (of_get_property(np, "uart-has-rtscts", NULL) ||
-	    of_get_property(np, "fsl,uart-has-rtscts", NULL) /* deprecated */)
-		sport->have_rtscts = 1;
+	sport->have_rtscts = of_property_read_bool(np, "uart-has-rtscts") ||
+		of_property_read_bool(np, "fsl,uart-has-rtscts"); /* deprecated */
 
-	if (of_get_property(np, "fsl,dte-mode", NULL))
-		sport->dte_mode = 1;
+	sport->dte_mode = of_property_read_bool(np, "fsl,dte-mode");
 
 	sport->have_rtsgpio = of_property_present(np, "rts-gpios");
 
-	if (of_get_property(np, "fsl,inverted-tx", NULL))
-		sport->inverted_tx = 1;
+	sport->inverted_tx = of_property_read_bool(np, "fsl,inverted-tx");
 
-	if (of_get_property(np, "fsl,inverted-rx", NULL))
-		sport->inverted_rx = 1;
+	sport->inverted_rx = of_property_read_bool(np, "fsl,inverted-rx");
 
 	if (!of_property_read_u32_array(np, "fsl,dma-info", dma_buf_conf, 2)) {
 		sport->rx_period_length = dma_buf_conf[0];
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ef6e7bb6105c..a368f4293967 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1587,8 +1587,8 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	}
 	s->port.line = ret;
 
-	if (of_get_property(np, "uart-has-rtscts", NULL) ||
-	    of_get_property(np, "fsl,uart-has-rtscts", NULL) /* deprecated */)
+	if (of_property_read_bool(np, "uart-has-rtscts") ||
+	    of_property_read_bool(np, "fsl,uart-has-rtscts") /* deprecated */)
 		set_bit(MXS_AUART_RTSCTS, &s->flags);
 
 	if (s->port.line >= ARRAY_SIZE(auart_port)) {
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 32c7a5b43f8e..676840847962 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1179,7 +1179,7 @@ static int soft_uart_init(struct platform_device *ofdev)
 	struct qe_firmware_info *qe_fw_info;
 	int ret;
 
-	if (of_find_property(np, "soft-uart", NULL)) {
+	if (of_property_read_bool(np, "soft-uart")) {
 		dev_dbg(&ofdev->dev, "using Soft-UART mode\n");
 		soft_uart = 1;
 	} else {
-- 
2.39.2

