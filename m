Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE326B4773
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjCJOuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjCJOta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:49:30 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984BF1220B3;
        Fri, 10 Mar 2023 06:47:48 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id o4-20020a9d6d04000000b00694127788f4so3036933otp.6;
        Fri, 10 Mar 2023 06:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnkBIbnz4vOeZORUW8cnuffMpZ7B9RlqYee18NB6XoY=;
        b=kSegSH2ge9meEexopNwscw/mDo77fJCwsRmMJScGL1VeeDdaHcWV5eYwZepHe6smNv
         bkCR8kKrCbJraxKBt0ZtXv8s0FEKXyYFoay/i0n1H1Ayhld0vj1gr8WLFtPKb7xzc590
         Z8G1oJ0xx3o446DGEooOeon8cxnmnE+HHkr7K4nZ9J2gBFoHT1Kx7CXlv3rBwpH3klSa
         eyyvCRora78tts8LJbdOH+Fxb1tSiN/gy62v4m2RyujmFrJ9o0+sa4eViIL8bHS7eGxH
         GxJRse477MkTPQXBsXaEHG3N2VCUGxPToXrNRZoI/UNEj59cTpHRNLn0Bh+NOActnd0a
         ZDHQ==
X-Gm-Message-State: AO0yUKWkKPxfaxm62rfYJwqbTLZ1cJw8dMM2unOu9psWtkp1W6eCSRO2
        uYeoYHmoBsndfGR6CJ6beA==
X-Google-Smtp-Source: AK7set/5K9xkOxRXHTghD5+c/dagxGmwvMLb3ksbgoSl8gw3zLJtj8L8jtL7TmDHtKFFm8q9QTWPPg==
X-Received: by 2002:a05:6830:1f42:b0:68d:41b2:5b75 with SMTP id u2-20020a0568301f4200b0068d41b25b75mr11972670oth.11.1678459668155;
        Fri, 10 Mar 2023 06:47:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q19-20020a05683022d300b0068bd20cf07dsm115038otc.48.2023.03.10.06.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:47 -0800 (PST)
Received: (nullmailer pid 1545656 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH] serial: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:26 -0600
Message-Id: <20230310144727.1545630-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/imx.c      | 3 +--
 drivers/tty/serial/sh-sci.c   | 2 +-
 drivers/tty/serial/sunzilog.c | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 523f296d5747..5712a4f29607 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2269,8 +2269,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 	if (of_get_property(np, "fsl,dte-mode", NULL))
 		sport->dte_mode = 1;
 
-	if (of_get_property(np, "rts-gpios", NULL))
-		sport->have_rtsgpio = 1;
+	sport->have_rtsgpio = of_property_present(np, "rts-gpios");
 
 	if (of_get_property(np, "fsl,inverted-tx", NULL))
 		sport->inverted_tx = 1;
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7bd080720929..a3e12e985e0d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1573,7 +1573,7 @@ static void sci_request_dma(struct uart_port *port)
 	 * Don't request a dma channel if no channel was specified
 	 * in the device tree.
 	 */
-	if (!of_find_property(port->dev->of_node, "dmas", NULL))
+	if (!of_property_present(port->dev->of_node, "dmas"))
 		return;
 
 	chan = sci_request_dma_chan(port, DMA_MEM_TO_DEV);
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index ccb809216e94..0fbeb3dbd843 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1403,7 +1403,7 @@ static int zs_probe(struct platform_device *op)
 	int keyboard_mouse = 0;
 	int err;
 
-	if (of_find_property(op->dev.of_node, "keyboard", NULL))
+	if (of_property_present(op->dev.of_node, "keyboard"))
 		keyboard_mouse = 1;
 
 	/* uarts must come before keyboards/mice */
@@ -1553,7 +1553,7 @@ static int __init sunzilog_init(void)
 
 	for_each_node_by_name(dp, "zs") {
 		num_sunzilog++;
-		if (of_find_property(dp, "keyboard", NULL))
+		if (of_property_present(dp, "keyboard"))
 			num_keybms++;
 	}
 
-- 
2.39.2

