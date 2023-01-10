Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1125663EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbjAJKzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjAJKyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:54:43 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF36AD9F;
        Tue, 10 Jan 2023 02:54:37 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i15so16947054edf.2;
        Tue, 10 Jan 2023 02:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rYqNvw1clZ8LqYgMptRErDOAS/Q5a8tz7ExdHTB2xE=;
        b=OzrLT3uMZnZyonsG0BfQLaW4dNc5Lqk8do1tjuMdzVPGNz693KtSsJOaedcQlns/Uy
         ZuE6fhfng2yKAZ84snlCvjb7Qrut0A3m6cMw4eD1WskGiQR/YGeseIKN0s6J7dd0eNkO
         i8mC5N4E6lIkmGERUywImret5/YH3fLrSLq0bKpn/azpV6uRyOrAndCFF9rDyh3qh7Pm
         azUULhHJVAII0iMvKZKcJ8/x/6Uj51K+ITZCwFRH7+EF1AGIecFlVlVoEQZ1HXq2fL4Z
         bePoRLTBUJNmKymydIkHaZkmkdeubcCM4ztbDGK4txOlspd5ilxKUz3n9zZmJcpJItpK
         46RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rYqNvw1clZ8LqYgMptRErDOAS/Q5a8tz7ExdHTB2xE=;
        b=NpDGIi5FBzJKnAXNwjzCfJ9F6HnLCySaDoPM1MyPnW3BNbhmxrB0/k9J4aUCmKPbQX
         NOCVR8E9nlQTnRUSrrD2DLMQT+a+8mGyW2Fi4jbZzdL+Rc76iqdVuxduEdv34Pr8YhDZ
         17Nc6ci2y27M0GUeRDpSMLdz2nZBIxQXCVJ8dd+7UiNKUdBgMvi4VzGyW1ZshfV4HQ89
         V+l87KM96YAXFjOLtL+suseP3XkmfRLouSxq2eVLpi75dVl37AoiGNHJkg46g4DP99+5
         5KonAm5S8pWAy+QqYxep+s33TO5eQ1ymu73D72f0lH6DVwkstxmMvH85urFvUzPIkVAV
         8+Jw==
X-Gm-Message-State: AFqh2kroLHclbaxr648a+DDOvsBMLRVZDt7qPZLOpBsoiTAX+oSKWfnS
        Gmc+DSF1mEw3HoUmnnqVOr0=
X-Google-Smtp-Source: AMrXdXtp3wN8YWvbU8A8T8icWXq0xBr4Xw4SxejizDnsm3B8V9o3Pk0WFVdao8d16D7SJi3bb4++kA==
X-Received: by 2002:a05:6402:3887:b0:496:4d2f:1b4b with SMTP id fd7-20020a056402388700b004964d2f1b4bmr13847018edb.7.1673348076271;
        Tue, 10 Jan 2023 02:54:36 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7c541000000b00495c3573b36sm4818199edr.32.2023.01.10.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 02:54:35 -0800 (PST)
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
Subject: [PATCH 2/6] nvmem: core: allow .read_post_process() callbacks to adjust data length
Date:   Tue, 10 Jan 2023 11:54:21 +0100
Message-Id: <20230110105425.13188-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110105425.13188-1-zajec5@gmail.com>
References: <20230110105425.13188-1-zajec5@gmail.com>
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
index 81743ae8793b..f4040776e96c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1541,6 +1541,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 			     struct nvmem_cell_entry *cell,
 			     void *buf, size_t *len, const char *id, int index)
 {
+	size_t bytes = cell->bytes;
 	int rc;
 
 	rc = nvmem_reg_read(nvmem, cell->offset, buf, cell->bytes);
@@ -1554,13 +1555,13 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 
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
index 767f39fff717..1e1f8935abe7 100644
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

