Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B668A65F274
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjAERT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbjAERSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:18:17 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C687E5C1E4;
        Thu,  5 Jan 2023 09:11:06 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g1so39418512edj.8;
        Thu, 05 Jan 2023 09:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Rha6d9hLLk+vltlf40Zf83zL1DAznh3btmFm0dmpPc=;
        b=OPcdb4OPK2QbdDbj7B8kKYxmQ0+r6GZLYmG8jBXT93j75CoBCwssxZc1nZJwLH12tC
         mXC7QfbDKU6uBBoVE5DNquE+gInwQ0sxfALkM1oRm9vWj+HDxLpIfz2bTWV3c8bLtl50
         7lzf5tilIguW8pqZnJD9y3l90pduLM9+Z1q7hubWHj6sqnHTem/z7EX/Muv3VKvRgdFD
         4HTHDnjYkU2Rev1hxp/xL92Hb0zahH6B/qJIp5tE1CoN+5gss2JU/hgJsqaoxllEiZNk
         NYgi+tHNr7RMDVWLwtfP+/EFE4c0OBBYQ8ibOpUEvSuU6hd/cHS8i8CPYImu+/HgVOwJ
         Onpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Rha6d9hLLk+vltlf40Zf83zL1DAznh3btmFm0dmpPc=;
        b=AJ6IKpL22C5BOaXYrlnihEVnpOnakXW+MPyE4xncnt78a5SW05w0ZII1Z1eBaAreio
         3ZNQdYmp1m4MvUehPmtO3znvjef4JKPeoK/bOSQ+dlhqY6VenKKHn/a5L1R58bWi6XXW
         bKmz6JJ0ZZu5EPk/+0HywXvLkJI42MSjX//P7/OcAZ5Q0XCtEMj5LsPq3toK5vN0Hq4l
         fQdp4JUWcwIICYtPb+06CND4Mu7AvXw7US4XCa4YmYGDc8hXlqQeNHOsqH0UeX1DBLaK
         mK1bblhRumBjJIdefrXfgEdh9+rh6OGuvzhIgM5jsEZPKv1ut+TmgCTzYZswOXlZjhzR
         uPBw==
X-Gm-Message-State: AFqh2kqI0+sT1NfomftCRTLtQ6Di9OZRddJ+5q0k4ARTjSXJkGyl96Lp
        n+4pVOcVxn0KjVuKoV1c/O4=
X-Google-Smtp-Source: AMrXdXt7rrdKfh+/K7o3yJL8MQzXVPDGlQayf/5oiuaD1PKk0PY3KvshJfQSqYpsOiDPZRCovanbtw==
X-Received: by 2002:a05:6402:1654:b0:474:a583:2e25 with SMTP id s20-20020a056402165400b00474a5832e25mr46531093edx.5.1672938665304;
        Thu, 05 Jan 2023 09:11:05 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id cn9-20020a0564020ca900b0048fdf37c441sm1714829edb.3.2023.01.05.09.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:11:04 -0800 (PST)
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
Subject: [PATCH 2/3] nvmem: core: allow .read_post_process() callbacks to adjust data length
Date:   Thu,  5 Jan 2023 18:10:37 +0100
Message-Id: <20230105171038.13649-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230105171038.13649-1-zajec5@gmail.com>
References: <20230105171038.13649-1-zajec5@gmail.com>
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

Sometimes reading NVMEM cell value involves some data reformatting. It
requires passing updated size value to the caller. Support that.

It's required e.g. to provide properly formatted MAC address in case
it's stored in a non-binary format (e.g. using ASCII).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/core.c             | 5 +++--
 drivers/nvmem/imx-ocotp.c        | 6 +++---
 drivers/nvmem/layouts/onie-tlv.c | 2 +-
 drivers/nvmem/layouts/sl28vpd.c  | 4 ++--
 include/linux/nvmem-provider.h   | 2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1b61c8bf0de4..1daf5a1d3ec7 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1537,6 +1537,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 			     struct nvmem_cell_entry *cell,
 			     void *buf, size_t *len, const char *id, int index)
 {
+	size_t bytes = cell->bytes;
 	int rc;
 
 	rc = nvmem_reg_read(nvmem, cell->offset, buf, cell->bytes);
@@ -1550,13 +1551,13 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 
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
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index ac0edb6398f1..ebd0e9e0314e 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -223,15 +223,15 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 }
 
 static int imx_ocotp_cell_pp(void *context, const char *id, int index,
-			     unsigned int offset, void *data, size_t bytes)
+			     unsigned int offset, void *data, size_t *bytes)
 {
 	u8 *buf = data;
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
index 074c7c700845..2cb7112229ba 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -76,7 +76,7 @@ static const char *onie_tlv_cell_name(u8 type)
 
 static int onie_tlv_mac_read_cb(void *priv, const char *id, int index,
 				unsigned int offset, void *buf,
-				size_t bytes)
+				size_t *bytes)
 {
 	eth_addr_add(buf, index);
 
diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index a36800f201a3..63c0da58ad60 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -23,9 +23,9 @@ struct sl28vpd_v1 {
 
 static int sl28vpd_mac_address_pp(void *priv, const char *id, int index,
 				  unsigned int offset, void *buf,
-				  size_t bytes)
+				  size_t *bytes)
 {
-	if (bytes != ETH_ALEN)
+	if (*bytes != ETH_ALEN)
 		return -EINVAL;
 
 	if (index < 0)
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 0cf9f9490514..5d896eec2f1c 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -21,7 +21,7 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 /* used for vendor specific post processing of cell data */
 typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int index,
 					 unsigned int offset, void *buf,
-					 size_t bytes);
+					 size_t *bytes);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
-- 
2.34.1

