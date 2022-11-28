Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCCD63A1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiK1HAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiK1HAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:00:17 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3E860F9;
        Sun, 27 Nov 2022 23:00:15 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id bn5so12064249ljb.2;
        Sun, 27 Nov 2022 23:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8JXtlo4DWFyHURdtAccWfZAXE3cOsEDHes1809eE/U=;
        b=gQ9JYrQsicj8eAsKvk3R5rm/zo+h46O6J6weTbBj9yLpvDA99c4s1v3auMmpe7RItY
         sjg66lnFysPwh5muJgAa9KfewShQtjN4D7Qom/G7fQftbKwZV5EG6FmZnM37TQemuxz/
         fxaopkm8qbg0aQ+c0hf/QaM3D+XJhDCIfGk8oTWKGrcT5lkbaazP7MfG53/aEkWV+/Il
         uo4rb4N6Jp01OgYB47EvF+ED/GTiz9wJlT/GeGiqPvx0NXSMBtH+oJ0+Ce8gbMHUEX1w
         w77jiS3hv3FUIcMCgYJWYIDZ5nMJJMJADIsx/obBsjRLU8S0jNuui3FBlAjdE4SM6Ag3
         FkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8JXtlo4DWFyHURdtAccWfZAXE3cOsEDHes1809eE/U=;
        b=1n2rObdAp3an1Yg33ogaJ6BzDE2kc16ItaY8lnSIru82MOwCrrlKSgbUP8pCBRA7St
         HD9fOpOZ8AeuIEd8PMlx0EBDj3grg6Qz8OfWUzcLEUCN80aNfSmHfqdDE1Zx5sbBdfL1
         8EpPSDOf88bBr5jOnL9yEumMHIlYFFVzQrQrY94JpKATsyEkmmQuh189/B01WhfiNMem
         r8tMadJn50E1JAJMAPVZ6hWvzHWblps5c+S1L0JBy6QPQHztfT2esJXN54MXBgpeAQ3s
         xQic9lefmqqpVuqjEBySxXUJ7Putx1mvudEKE5k4T7+ac4IYX/KwOUzCzNRPplA/JK7u
         iHGQ==
X-Gm-Message-State: ANoB5pnL8KKJFlWPkdTyoiLYfm6m+0ojXvIoQ53vThFzFKL25DAYaWQx
        6aePk+Gwg0djDM121SxQzaQ=
X-Google-Smtp-Source: AA0mqf5jXColcAENepdyWUW3CDWbxMRsZ4OcZhdqOP2i1kldSqZax7lMxZ1fVluk7O0mb8Qwdk74vA==
X-Received: by 2002:a05:651c:19ab:b0:276:66a4:47c3 with SMTP id bx43-20020a05651c19ab00b0027666a447c3mr9874524ljb.49.1669618813964;
        Sun, 27 Nov 2022 23:00:13 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id t12-20020a2e780c000000b002770a7e320esm1129686ljc.81.2022.11.27.23.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 23:00:13 -0800 (PST)
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
Subject: [PATCH V2 1/2] nvmem: core: refactor .cell_post_process() CB arguments
Date:   Mon, 28 Nov 2022 07:59:22 +0100
Message-Id: <20221128065923.1180-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Pass whole NVMEM cell struct and length pointer as arguments to callback
functions.

This allows:

1. Cells content to be modified based on more info
   Some cells (identified by their names) contain specific data that
   needs further processing. This can be e.g. MAC address stored in an
   ASCII format. NVMEM consumers expect MAC to be read in a binary form.
   More complex cells may be additionally described in DT. This change
   allows also accessing relevant DT nodes and reading extra info.

2. Adjusting data length
   If cell processing results in reformatting it, it's required to
   adjust length. This again applies e.g. to the MAC format change from
   ASCII to the byte-based.

Later on we may consider more cleanups & features like:
1. Dropping "const char *id" and just using NVMEM cell name
2. Adding extra argument for cells providing multiple values

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
This solution conflicts with 1 part of Michael's work:
[PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
https://lore.kernel.org/linux-arm-kernel/20220901221857.2600340-1-michael@walle.cc/

Instead of:
1. Adding NVMEM cell-level post_process callback
2. Adding callback (.fixup_cell_info()) for setting callbacks
3. Dropping NVMEM device-level post_process callback
I decided to refactor existing callback.

Michael's work on adding #nvmem-cell-cells should be possible to easily
rebase on top of those changes.

This doen't add support for 1 cell providing multiple values. That needs
to be added later once we sort out #nvmem-cell-cells bindings. This
fixes the basic case with reformatting cells data.
---
 drivers/nvmem/core.c           | 19 +++----------------
 drivers/nvmem/imx-ocotp.c      |  8 ++++----
 include/linux/nvmem-provider.h | 17 ++++++++++++++---
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 321d7d63e068..0bc3e26e4ca8 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -46,16 +46,6 @@ struct nvmem_device {
 #define to_nvmem_device(d) container_of(d, struct nvmem_device, dev)
 
 #define FLAG_COMPAT		BIT(0)
-struct nvmem_cell_entry {
-	const char		*name;
-	int			offset;
-	int			bytes;
-	int			bit_offset;
-	int			nbits;
-	struct device_node	*np;
-	struct nvmem_device	*nvmem;
-	struct list_head	node;
-};
 
 struct nvmem_cell {
 	struct nvmem_cell_entry *entry;
@@ -1416,24 +1406,21 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 	int rc;
 
 	rc = nvmem_reg_read(nvmem, cell->offset, buf, cell->bytes);
-
 	if (rc)
 		return rc;
+	if (len)
+		*len = cell->bytes;
 
 	/* shift bits in-place */
 	if (cell->bit_offset || cell->nbits)
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
 	if (nvmem->cell_post_process) {
-		rc = nvmem->cell_post_process(nvmem->priv, id,
-					      cell->offset, buf, cell->bytes);
+		rc = nvmem->cell_post_process(nvmem->priv, cell, id, buf, len);
 		if (rc)
 			return rc;
 	}
 
-	if (len)
-		*len = cell->bytes;
-
 	return 0;
 }
 
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 14284e866f26..d383989d48bf 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -222,8 +222,8 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 	return ret;
 }
 
-static int imx_ocotp_cell_pp(void *context, const char *id, unsigned int offset,
-			     void *data, size_t bytes)
+static int imx_ocotp_cell_pp(void *context, struct nvmem_cell_entry *cell,
+			     const char *id, void *data, size_t *len)
 {
 	struct ocotp_priv *priv = context;
 
@@ -233,8 +233,8 @@ static int imx_ocotp_cell_pp(void *context, const char *id, unsigned int offset,
 			u8 *buf = data;
 			int i;
 
-			for (i = 0; i < bytes/2; i++)
-				swap(buf[i], buf[bytes - i - 1]);
+			for (i = 0; i < cell->bytes / 2; i++)
+				swap(buf[i], buf[cell->bytes - i - 1]);
 		}
 	}
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 50caa117cb62..b0d2b6af9f37 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -14,14 +14,25 @@
 #include <linux/gpio/consumer.h>
 
 struct nvmem_device;
-struct nvmem_cell_info;
+
+struct nvmem_cell_entry {
+	const char		*name;
+	int			offset;
+	int			bytes;
+	int			bit_offset;
+	int			nbits;
+	struct device_node	*np;
+	struct nvmem_device	*nvmem;
+	struct list_head	node;
+};
+
 typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
 /* used for vendor specific post processing of cell data */
-typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, unsigned int offset,
-					  void *buf, size_t bytes);
+typedef int (*nvmem_cell_post_process_t)(void *priv, struct nvmem_cell_entry *cell, const char *id,
+					 void *buf, size_t *len);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
-- 
2.34.1

