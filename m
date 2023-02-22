Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FD269FA10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjBVRXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjBVRXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:23:22 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B978619F;
        Wed, 22 Feb 2023 09:23:19 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id y14so1477443ljq.4;
        Wed, 22 Feb 2023 09:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPXTaQZVL1HaoQxVYcZ7bgZixI9kr2H6DQ4AJLyVX08=;
        b=JVTkaMHZYEnCKdfREkIj6XRcyyViNk24I0n/UWNbyLNb2A7GtCYUtJSpVDxiQArYmi
         CG4e3yzPEfNfYp47Ma1bMw6mJ30JkEiZSIuaFfTK29X1cMqStblNJQxU+tx7gy+b2Uyn
         d/MtlK4o91g5oq9Tvv5nPp7+zmBUi/coznt6APtwb969s1OQTxRwOXTETGfi9MtvV7/R
         7ZOIkkf+ubHto2YRcnk7rvriD9BQWOGwiB2K9A5xyM6oKXJCfrqDRUqGjByMBmbacnij
         t96xUlk5Z0k9bTUEsHI1VLaLzxGZ+FnS0Db+299mJZWcoSvO0kLBSurak0T2KWHjl1Ct
         xzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPXTaQZVL1HaoQxVYcZ7bgZixI9kr2H6DQ4AJLyVX08=;
        b=oRwDsHYJ64IapYjyPAT0RtlYFbLVIMTRQp4Px5aF/NTAYmzvO8uP1ScRYPdKPMo0wi
         sHFjTWTidblsSJh4uuWzQLQG5z+uxsvHVurDO4Ake4NhA752PcfN2pSVN9fmCBz+XYDl
         xNUoTzgDTGwVDQmNTTfsJUEQxNrvmdwdWjK4tuxLPd4ydVUayOBsKWQngGTbl+Np8uB3
         9ReJemO1Ysw1KS4dPOX4AQ7nZlcn7d3n10/zJGrwFcWQ9X+vfElCkzr5FrO1leMdcpoL
         076ESKcnTRsLa+UWvKMA3qxOCsarr4p/+fwfTW7yrOx1ac84mxJMFopuH2XlOOlZlPnS
         UuLQ==
X-Gm-Message-State: AO0yUKW+R6ga9QGsmhzF6sScaxk75+TwYQ2cINxt4SZ/r0dZo/c2A5AW
        9pZKoCEl0KPQhb9yQpeE2i0=
X-Google-Smtp-Source: AK7set/EU7q0KWY7dsZ7Mukk83wrPkUwjZvHgB1oGSC/JUNVtEHyNq1yZkTIBojqrPd25FkooTqkJA==
X-Received: by 2002:a05:651c:b06:b0:295:733a:3463 with SMTP id b6-20020a05651c0b0600b00295733a3463mr4824738ljr.29.1677086597753;
        Wed, 22 Feb 2023 09:23:17 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p2-20020a2e93c2000000b0029477417d80sm721513ljh.85.2023.02.22.09.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 09:23:17 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/4] nvmem: core: allow nvmem_cell_post_process_t callbacks to adjust buffer
Date:   Wed, 22 Feb 2023 18:22:43 +0100
Message-Id: <20230222172245.6313-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222172245.6313-1-zajec5@gmail.com>
References: <20230222172245.6313-1-zajec5@gmail.com>
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

Sometimes reading NVMEM cell value involves some data reformatting. it
may require resizing available buffer. Support that.

It's required e.g. to provide properly formatted MAC address in case
it's stored in a non-binary format (e.g. using ASCII).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/core.c           | 23 ++++++++++++++---------
 drivers/nvmem/imx-ocotp.c      |  8 ++++----
 include/linux/nvmem-provider.h |  4 ++--
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index c5c9a4654241..18fbfbf61ec3 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1418,35 +1418,36 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void
 
 static int __nvmem_cell_read(struct nvmem_device *nvmem,
 			     struct nvmem_cell_entry *cell,
-			     void *buf, size_t *len, const char *id, int index)
+			     void **buf, size_t *len, const char *id, int index)
 {
+	size_t bytes = cell->bytes;
 	int rc;
 
-	rc = nvmem_reg_read(nvmem, cell->offset, buf, cell->bytes);
+	rc = nvmem_reg_read(nvmem, cell->offset, *buf, bytes);
 
 	if (rc)
 		return rc;
 
 	/* shift bits in-place */
 	if (cell->bit_offset || cell->nbits)
-		nvmem_shift_read_buffer_in_place(cell, buf);
+		nvmem_shift_read_buffer_in_place(cell, *buf);
 
 	if (cell->read_post_process) {
 		rc = cell->read_post_process(nvmem->priv, id, index,
-					     cell->offset, buf, cell->bytes);
+					     cell->offset, buf, &bytes);
 		if (rc)
 			return rc;
 	}
 
 	if (nvmem->cell_post_process) {
 		rc = nvmem->cell_post_process(nvmem->priv, id, index,
-					      cell->offset, buf, cell->bytes);
+					      cell->offset, buf, &bytes);
 		if (rc)
 			return rc;
 	}
 
 	if (len)
-		*len = cell->bytes;
+		*len = bytes;
 
 	return 0;
 }
@@ -1464,7 +1465,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 {
 	struct nvmem_device *nvmem = cell->entry->nvmem;
-	u8 *buf;
+	void *buf;
 	int rc;
 
 	if (!nvmem)
@@ -1474,7 +1475,7 @@ void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
-	rc = __nvmem_cell_read(nvmem, cell->entry, buf, len, cell->id, cell->index);
+	rc = __nvmem_cell_read(nvmem, cell->entry, &buf, len, cell->id, cell->index);
 	if (rc) {
 		kfree(buf);
 		return ERR_PTR(rc);
@@ -1791,11 +1792,15 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 	if (!nvmem)
 		return -EINVAL;
 
+	/* Cells with read_post_process hook may realloc buffer we can't allow here */
+	if (info->read_post_process)
+		return -EINVAL;
+
 	rc = nvmem_cell_info_to_nvmem_cell_entry_nodup(nvmem, info, &cell);
 	if (rc)
 		return rc;
 
-	rc = __nvmem_cell_read(nvmem, &cell, buf, &len, NULL, 0);
+	rc = __nvmem_cell_read(nvmem, &cell, &buf, &len, NULL, 0);
 	if (rc)
 		return rc;
 
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index e37a82f98ba6..0e0ab27cbfe3 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -223,18 +223,18 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 }
 
 static int imx_ocotp_cell_pp(void *context, const char *id, int index,
-			     unsigned int offset, void *data, size_t bytes)
+			     unsigned int offset, void **data, size_t *bytes)
 {
 	struct ocotp_priv *priv = context;
 
 	/* Deal with some post processing of nvmem cell data */
 	if (id && !strcmp(id, "mac-address")) {
 		if (priv->params->reverse_mac_address) {
-			u8 *buf = data;
+			u8 *buf = *data;
 			int i;
 
-			for (i = 0; i < bytes/2; i++)
-				swap(buf[i], buf[bytes - i - 1]);
+			for (i = 0; i < *bytes / 2; i++)
+				swap(buf[i], buf[*bytes - i - 1]);
 		}
 	}
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index f87fd64eee8f..9c212f7bb7d1 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -19,8 +19,8 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
 /* used for vendor specific post processing of cell data */
-typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int index,
-					 unsigned int offset, void *buf, size_t bytes);
+typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int index, unsigned int offset,
+					 void **buf, size_t *bytes);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
-- 
2.34.1

