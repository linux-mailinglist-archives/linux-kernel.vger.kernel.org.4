Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F2A67E5DB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjA0M5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjA0M5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:57:22 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D393646E;
        Fri, 27 Jan 2023 04:57:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x10so4631961edd.10;
        Fri, 27 Jan 2023 04:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEAkJYnxqrZMOhdPjkEBTuVRB27vVAzsdoVajeGwdl8=;
        b=IPo67SYQlof0606s8wMwkmMpL/q0CXu3HyeKevsPA+c+dLT+aacZA70ccJyyJPXKHa
         JyVuSpAun8AGzuLGmIE1Az6ZKxT6zSb5QuMCdwtPlhZIuBj94hvgKpExZvP2zLeWd4QL
         dmFGB1uKDmK9IGCiKHS86D8mA1xHn8hKtO7Wu8pTE1SZsLpoc2aKy3VhNuMauJVaeJVt
         W/rCXahEbFLLQZ+AtziBCgl5XZOXu7WWGjk/scynd/HdrTkHLHUugmZcaGnCoiTHW6/6
         rLJV4jR7n0ONzD4vLSfKtApgGqBn8SicP1Pi+ii7qTp+QcUlENMCymZ4hyR2tYL+31X2
         9tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEAkJYnxqrZMOhdPjkEBTuVRB27vVAzsdoVajeGwdl8=;
        b=5quF1hgmq1jihhwgisIVJPpC1TKWwqqwbvD026u0DAOVu9Gq2+/6TP9livVEU1I9g3
         5OyjrvnKFu4hL6JHx/kbEJeg2h2tu4rHTdM/Jbhg+SIciAG7DdoRaD3JEKOw2LZDR+4F
         ex5CtFh5CwS01SDEmAa7Km2xjHezGdn4Iwbn6i7sbQmtkJrvYLUmoWfBdTJxgpODj2Ap
         Baulnw8oDPtmnYW0eRxPpk8PCk+VQvjWghobR9Dpzazze7iysCUXVSAfu0+6Z87YmP9C
         Ib9QB+Luq1HFsHqmKLBGKTxZpShrf1hafBeiDdVE7bkaVC4oR/EpIaknc5KRHZUN7/+b
         E8vA==
X-Gm-Message-State: AFqh2kp3tYGhxSIAlRz/LYmG+XZcNQ6TbRnLr0oNupsYURbA+RHGOmEg
        V/hlyg8BJzB1dS1l/3mlRUs=
X-Google-Smtp-Source: AMrXdXv1VGvpGnLHajmv7FN4PDBZj7ATbtCd+SBuuqResrWCvlqMmRgrewKY9buZwbBdhoSSNZKIPQ==
X-Received: by 2002:a05:6402:3909:b0:499:bcd7:a968 with SMTP id fe9-20020a056402390900b00499bcd7a968mr43322323edb.22.1674824240299;
        Fri, 27 Jan 2023 04:57:20 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y5-20020a056402358500b00482e0c55e2bsm2248136edc.93.2023.01.27.04.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 04:57:19 -0800 (PST)
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
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 2/6] nvmem: core: allow .read_post_process() callbacks to adjust buffer
Date:   Fri, 27 Jan 2023 13:57:05 +0100
Message-Id: <20230127125709.32191-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127125709.32191-1-zajec5@gmail.com>
References: <20230127125709.32191-1-zajec5@gmail.com>
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
V2: Pass buffer pointer to allow krealloc() if needed
V3: Don't move unnecessarily code setting *len
---
 drivers/nvmem/core.c             | 21 +++++++++++++--------
 drivers/nvmem/imx-ocotp.c        |  8 ++++----
 drivers/nvmem/layouts/onie-tlv.c |  5 ++---
 drivers/nvmem/layouts/sl28vpd.c  | 10 +++++-----
 include/linux/nvmem-provider.h   |  5 ++---
 5 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9e77af0164aa..162054a39fa1 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1540,28 +1540,29 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void
 
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
 		rc = cell->read_post_process(cell->priv, id, index,
-					     cell->offset, buf, cell->bytes);
+					     cell->offset, buf, &bytes);
 		if (rc)
 			return rc;
 	}
 
 	if (len)
-		*len = cell->bytes;
+		*len = bytes;
 
 	return 0;
 }
@@ -1579,7 +1580,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 {
 	struct nvmem_device *nvmem = cell->entry->nvmem;
-	u8 *buf;
+	void *buf;
 	int rc;
 
 	if (!nvmem)
@@ -1589,7 +1590,7 @@ void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
-	rc = __nvmem_cell_read(nvmem, cell->entry, buf, len, cell->id, cell->index);
+	rc = __nvmem_cell_read(nvmem, cell->entry, &buf, len, cell->id, cell->index);
 	if (rc) {
 		kfree(buf);
 		return ERR_PTR(rc);
@@ -1906,11 +1907,15 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
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
index ac0edb6398f1..e17500bc0acc 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -223,15 +223,15 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 }
 
 static int imx_ocotp_cell_pp(void *context, const char *id, int index,
-			     unsigned int offset, void *data, size_t bytes)
+			     unsigned int offset, void **data, size_t *bytes)
 {
-	u8 *buf = data;
+	u8 *buf = *data;
 	int i;
 
 	/* Deal with some post processing of nvmem cell data */
 	if (id && !strcmp(id, "mac-address"))
-		for (i = 0; i < bytes / 2; i++)
-			swap(buf[i], buf[bytes - i - 1]);
+		for (i = 0; i < *bytes / 2; i++)
+			swap(buf[i], buf[*bytes - i - 1]);
 
 	return 0;
 }
diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 767f39fff717..f26bcce2a44d 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -75,10 +75,9 @@ static const char *onie_tlv_cell_name(u8 type)
 }
 
 static int onie_tlv_mac_read_cb(void *priv, const char *id, int index,
-				unsigned int offset, void *buf,
-				size_t bytes)
+				unsigned int offset, void **buf, size_t *bytes)
 {
-	eth_addr_add(buf, index);
+	eth_addr_add(*buf, index);
 
 	return 0;
 }
diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index a36800f201a3..869cb513d79a 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -22,19 +22,19 @@ struct sl28vpd_v1 {
 } __packed;
 
 static int sl28vpd_mac_address_pp(void *priv, const char *id, int index,
-				  unsigned int offset, void *buf,
-				  size_t bytes)
+				  unsigned int offset, void **buf,
+				  size_t *bytes)
 {
-	if (bytes != ETH_ALEN)
+	if (*bytes != ETH_ALEN)
 		return -EINVAL;
 
 	if (index < 0)
 		return -EINVAL;
 
-	if (!is_valid_ether_addr(buf))
+	if (!is_valid_ether_addr(*buf))
 		return -EINVAL;
 
-	eth_addr_add(buf, index);
+	eth_addr_add(*buf, index);
 
 	return 0;
 }
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 0cf9f9490514..e70766013f97 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -19,9 +19,8 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
 /* used for vendor specific post processing of cell data */
-typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int index,
-					 unsigned int offset, void *buf,
-					 size_t bytes);
+typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int index, unsigned int offset,
+					 void **buf, size_t *bytes);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
-- 
2.34.1

