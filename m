Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE9F62BB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbiKPLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbiKPLRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:17:04 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0553549B6F;
        Wed, 16 Nov 2022 03:05:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso1185512wmp.5;
        Wed, 16 Nov 2022 03:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt8q54IUjG8fYZGllQ5PibnFEuFeXBcb2ZdQ9kqflsc=;
        b=NqMS/k9x7OCLXkiVB/M6SRtzbLqnvSefXDCcNF4681VtRicjMHUZdDb467XItyzKPk
         AfpTcuAuyapgKR057L39vb4DCZz+QOOv4bQ0ZrX4Agj09RArmsW+JgMURhqP08BrcHY8
         +29zTda1y5S8FNUH0rznaNQfBMeb0oyicLmRQ+Aw0U4rpxgldnPoPmejkJv2K2QZnACX
         yhsv7x5BuWkuaFwiChUcjETiF/V4JS3WcEZYltst/i6C3FAe82B4z59yTWC8grfewC0w
         lZgBpAzZx5YHxUiTJFfrNEpPMmddA+0vp22AHYfQd97mwSiX5Y2ePbDm2PZnJt42C9gY
         qhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt8q54IUjG8fYZGllQ5PibnFEuFeXBcb2ZdQ9kqflsc=;
        b=huCkGSZsAJ3w+Df09756gYhtUheAuDtg9PoNd9t9lgmYw/JWXuCt4OkXGzmhRJ+emI
         BZS1S3F3PFPzdsi2HRQtrmqE4Whkl08U86yggXye3nR0foafDQ/M8E7Bol01dxPGwryW
         x2tOQD0oOpIc5T/ZR5/XbMzmfz01qiIP1NxWBbEZfSgjBtIxUWk9JRCgnkzPEzZeSLKh
         JEM5bZsuZB84m+DibmbZf+lBdobwyxoomg1q0Mj5faFWDZ1gNbDL4zexT7AdD9gjfOGR
         fn402nOXGjefB+dsoi7QRcSa3GYFMLAodo6iKeoowZ+TfHUMonkuPB4rAabanF8rB79J
         yHNA==
X-Gm-Message-State: ANoB5pmYFKw15Pi+nLB3PlkuXr7oVHE5v+dHFmfG0ghA9Vl3JKSHUAfK
        gR+tqY8jIqtkV7MZ+VZAsJyni+xkiHQ=
X-Google-Smtp-Source: AA0mqf5vxmmcTH1fH17jwPxcH/8LGgjrFM8xrkw7QSUdiXmyDyzdHIII54vZlYmnyQVMhLrZrl/2cQ==
X-Received: by 2002:a1c:29c5:0:b0:3cf:6263:bfc5 with SMTP id p188-20020a1c29c5000000b003cf6263bfc5mr1807409wmp.137.1668596707374;
        Wed, 16 Nov 2022 03:05:07 -0800 (PST)
Received: from felia.fritz.box (200116b826c55000c59461cca0b9a159.dip.versatel-1u1.de. [2001:16b8:26c5:5000:c594:61cc:a0b9:a159])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c2cae00b003cfd0bd8c0asm1841370wmc.30.2022.11.16.03.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:05:06 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] usb: dwc3: improve the config dependency of USB_DWC3_XILINX
Date:   Wed, 16 Nov 2022 12:04:44 +0100
Message-Id: <20221116110444.8340-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A request to Manish Narani (see Link) asked for clarification of the
reference to the config ARCH_VERSAL in the support of Xilinx SoCs with
DesignWare Core USB3 IP.

As there is no response, clean up the reference to the non-existing config
symbol. While at it, follow up on Felipe Balbi's request to add the
alternative COMPILE_TEST dependency.

Link: https://lore.kernel.org/all/CAKXUXMwgWfX8+OvY0aCwRNukencwJERAZzU7p4eOLXQ2zv6rAg@mail.gmail.com/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/usb/dwc3/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 03ededa86da1..b2f72b0e75c6 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -152,11 +152,11 @@ config USB_DWC3_IMX8MP
 
 config USB_DWC3_XILINX
 	tristate "Xilinx Platforms"
-	depends on (ARCH_ZYNQMP || ARCH_VERSAL) && OF
+	depends on (ARCH_ZYNQMP || COMPILE_TEST) && OF
 	default USB_DWC3
 	help
 	  Support Xilinx SoCs with DesignWare Core USB3 IP.
-	  This driver handles both ZynqMP and Versal SoC operations.
+	  This driver handles ZynqMP SoC operations.
 	  Say 'Y' or 'M' if you have one such device.
 
 config USB_DWC3_AM62
-- 
2.17.1

