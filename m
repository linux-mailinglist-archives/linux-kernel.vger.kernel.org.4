Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD3639E25
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 00:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiK0XKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 18:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0XKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 18:10:49 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A772BE8;
        Sun, 27 Nov 2022 15:10:48 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id r12so14919824lfp.1;
        Sun, 27 Nov 2022 15:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8JXtlo4DWFyHURdtAccWfZAXE3cOsEDHes1809eE/U=;
        b=QW9F8xXcDk6+dTNytDZQt+FDxATthPJl4PyRcDASxAZnVPMrhSGrtAqYfMauiA2RC4
         qX3sAEj2SgBWgdSJ9mgXapjj8gjYXO8e6aPIVmEf7zfftdfZFQloCpPS1MukHL7KCc5p
         nywgoMZfSNUk9LQoSg2VVwtmXEk9pM9n1F8LKMOl3SwSTRZ0YHm3iWi3j/nkHElM6L1q
         oX4ULjLTHXgzr1h4oXqyYo4497dTUu9irJ55DryuzE9fv2+Ov49HNWzK/rlgNv9kThPv
         jrhpPLMQo+K1ROIYZmtgwWUUeFq3IisZdawefHcj5JWHF/p6/1Og1Y7wYH0lqXM6KWvw
         zpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8JXtlo4DWFyHURdtAccWfZAXE3cOsEDHes1809eE/U=;
        b=sL/pMeC78qQY6M22X1rBS9zKk3wU0JGSWOkZdM9hl/2Q0Xsk/jkjymzQB3e9anh2ft
         /Au55/qCimwTkWHayoz7W66wenA9VRwlX1ZCaef8OsOcXwMYQU9A5cS914Vmo1yj6hqX
         kluPMI3iD4pov+EFy25XHztj2ebKWoxfKTSOmr33bAc8OAdxYCJogQYrQhN5SOBl4Lav
         CV+oZLzrPOGtBxoNgJUaH9BucCdIwI5jf/0ajP87zc4g6XfTYmszTBAgHvGbQcy0tWZr
         UZRtKMUh/+x0CZYGUiI8zGH4bPdJzHDt/xpg/4MiC38MT27klrmnVwQ7LnEnihebbTTe
         64Fg==
X-Gm-Message-State: ANoB5plz++7wLURrY5XB2X3YDBj9FLtSJfc3VfIp6mhWal2w1pSmyv41
        Y0q8TGRzqdX7iL+tbJzNi4M=
X-Google-Smtp-Source: AA0mqf7sUKQqb/1PAv8GCFQE+7LTmVRJLj315wSetO38JXCWb7+qDuuRDemCeeABGvrEU3plpkHwYw==
X-Received: by 2002:a05:6512:210d:b0:4a2:741f:1909 with SMTP id q13-20020a056512210d00b004a2741f1909mr17557432lfr.484.1669590646981;
        Sun, 27 Nov 2022 15:10:46 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id d17-20020a0565123d1100b004b4ea0f4e7fsm1439984lfv.299.2022.11.27.15.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 15:10:46 -0800 (PST)
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
Subject: [PATCH 1/2] nvmem: core: refactor .cell_post_process() CB arguments
Date:   Mon, 28 Nov 2022 00:10:34 +0100
Message-Id: <20221127231035.17547-1-zajec5@gmail.com>
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

