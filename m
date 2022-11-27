Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC68639E27
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 00:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiK0XLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 18:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiK0XK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 18:10:59 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584CEFD22;
        Sun, 27 Nov 2022 15:10:53 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id d6so14869792lfs.10;
        Sun, 27 Nov 2022 15:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44xs7cQ6Cza924S+PWNfvtVgJyd+csfrYDPNush93DA=;
        b=dcCRE3/yjOIPoUAIJRWPvdkLOmTLO/UNEPjAijvzfGDUBgV25ejhUlrihqSjBpRKRs
         vCk669JGtPhOHwF5GaK12F/FaDY0o8LtOVw3wxejm3AijcTtZoPj1qQtvY49Sjd2N0Z2
         quvzUTKkG3tozQVoe/haD35aBci34NXMYeCUduZGWxz20gXH/f0yaagLBAnurPCKzEqM
         HVtNBJGIyBev0aeVY1eW/7HW1aQDb46npx0NpAN8Et/FFF06HOA8AcvyN2ICOxE0oL8o
         5nsGnF26uj1QA+ld5pxcdGBO7Id3cA85kxrxwcGNpS0SkzGJ2GlxgnPzv/KGRojwV+/H
         XDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44xs7cQ6Cza924S+PWNfvtVgJyd+csfrYDPNush93DA=;
        b=xDaZbNaFQOIvzzAidQxkvLBNq5+cKjCJ8xXjirjdVsbcj/BKjRbkZEQmCG6VGIygZX
         /oZ/6YMhPY+ulnIIlI3CW/wVPujLDffGdJy21jdmmWD/SSYgy3YyCmqJTRCglKTDaGGs
         NmTOhvZOWWyTiqih+VNj5wX4Ij0QrUjkL1P+GlXXnX/hCXI3hYgNtGM47iae+uzbnAKz
         yhXGG91XhgQa+GJVmIZKUkVNPdMBo6eh7p9CpHUU7TBs21wsy9RJyYn4Tyo63XYoP5/x
         HL2rp797zggLdc3zosW9pqBVz4yney9DBciu/I7ufnrnyQTM/YynnDaJuZFAzDbBrZ+E
         0orw==
X-Gm-Message-State: ANoB5pn0gpa8Jw4LVn+7xQS3BGMR9M0KFwAV9SX7ph7qCNZ5YzMNAx0p
        swBrHCYK04e4Shrq4WzLZvA=
X-Google-Smtp-Source: AA0mqf5bGsZx5aHPFgT0mbXBwTIQVCg2ZADAZiOGHR44KvhEqlhqur+3NjsGAXM/v1FyHtWC2gfPnw==
X-Received: by 2002:ac2:5e26:0:b0:4b1:4602:3f9 with SMTP id o6-20020ac25e26000000b004b1460203f9mr10079217lfg.80.1669590651716;
        Sun, 27 Nov 2022 15:10:51 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id d17-20020a0565123d1100b004b4ea0f4e7fsm1439984lfv.299.2022.11.27.15.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 15:10:51 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] nvmem: u-boot-env: reformat MAC in "ethaddr" cell when reading
Date:   Mon, 28 Nov 2022 00:10:35 +0100
Message-Id: <20221127231035.17547-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221127231035.17547-1-zajec5@gmail.com>
References: <20221127231035.17547-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

NVMEM consumers expect MAC in a byte-based format (see e.g.
nvmem_get_mac_address()). U-Boot environment data stores all values in
ASCII form.

Add post processing callback detecting "ethaddr" reads and reformat data
as expected. This fixes Ethernet drivers reading MAC from NVMEM devices.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/u-boot-env.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 2a87dda45188..d103a52e0008 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/crc32.h>
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
@@ -70,6 +72,24 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
 	return 0;
 }
 
+static int u_boot_env_cell_post_process(void *context, struct nvmem_cell_entry *cell,
+					const char *id, void *buf, size_t *len)
+{
+	struct u_boot_env *priv = context;
+
+	if (!strcmp(cell->name, "ethaddr")) {
+		u8 mac[ETH_ALEN];
+
+		if (mac_pton(buf, mac)) {
+			ether_addr_copy(buf, mac);
+			if (len)
+				*len = ETH_ALEN;
+		}
+	}
+
+	return 0;
+}
+
 static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 				size_t data_offset, size_t data_len)
 {
@@ -179,6 +199,7 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	struct nvmem_config config = {
 		.name = "u-boot-env",
 		.reg_read = u_boot_env_read,
+		.cell_post_process = u_boot_env_cell_post_process,
 	};
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-- 
2.34.1

