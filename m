Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E971B6BFBC6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCRRO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCRROV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:14:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD98149AA;
        Sat, 18 Mar 2023 10:14:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 20so999521lju.0;
        Sat, 18 Mar 2023 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679159658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHNZ4cJK3nDs1ydwUCLlZnjoqV5tGqCoWiDTUvwcqRM=;
        b=WkZKmx6klWxMG9Yhh6CNKVShzb8jM9M8AVTmW4QGOw49tN/DI+rUgtiFzLe4A4ARq5
         je81EJy0/oXIQFj6lsrgco/A1NyrlwXB0mW4VIoVKIEc2i+WGn6ZPTnpk4DJY7qDkaGj
         kYpFndkBxTGgLvXoAQkp1LhU8Vi4tdyg+Xxnc3R+D1TB/rAbLImqZcSIKBNnzOuFaneR
         KqeIRdkKye4gxP3tyUJlKxYDhpkyJE0yrZ4iSEy+bS/cFYK8oO5BDrL1RqUWrkTdqHO9
         2iWrSRbGtitCmfIIPsUWFwAeqg8/5rh1lVXqDGHVjuHOAE/9SBJtKFltr+mjTajbz1U8
         Xn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679159658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHNZ4cJK3nDs1ydwUCLlZnjoqV5tGqCoWiDTUvwcqRM=;
        b=Ad4oW3JKLuZBf7wDl20g5h87BN2vNCJEHb4dzzg2qq1kA/ATZDZd1dmqsnKuy0WRmm
         hR1SCsc5Y0RXoa55Nu8Yf6hxDqG1lc2z0P9JeIobMLXGTdA1Re+sIPnRrQxy0b+Xpb4K
         WLqgM39P3WTiXQNrzrOCXsgk6nbNf6lUrmot+Vi0koXX7lFcx0NoInmggnOtgdpYkyJE
         KUkX9JrJh/EggKYPAE8qkLB3KZIKC7hKnQ05RFTUkUI218CSndNRoRbM2U03lFBZSY6H
         Fgs1b1aDR1K18vp6PaYYEkLj9n6fgTwdXSrXI6v+qHixSExfjKDRVWMbKnRwF1WJjOsh
         2IQA==
X-Gm-Message-State: AO0yUKXr2bbpyUBtU4m+VdhMkavtzfxRYAVRzbn3dcAgUB+DZZDSpi0I
        z5Jm6P4NazFw2ItHv+w7DMo=
X-Google-Smtp-Source: AK7set/Al0LN4OHWbI9yra477vbTqV3Ei5RvLaohUdA4IP6+DO1j48nhcE19Pco6txBWopNJt4iN+w==
X-Received: by 2002:a2e:b895:0:b0:295:a958:2bca with SMTP id r21-20020a2eb895000000b00295a9582bcamr5373412ljp.6.1679159658495;
        Sat, 18 Mar 2023 10:14:18 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id r9-20020a2e80c9000000b0029573844d03sm929221ljg.109.2023.03.18.10.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 10:14:18 -0700 (PDT)
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
Subject: [PATCH V2 2/3] nvmem: core: support specifying both: cell raw data & post read lengths
Date:   Sat, 18 Mar 2023 18:13:55 +0100
Message-Id: <20230318171356.29515-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318171356.29515-1-zajec5@gmail.com>
References: <20230318171356.29515-1-zajec5@gmail.com>
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

Callback .read_post_process() is designed to modify raw cell content
before providing it to the consumer. So far we were dealing with
modifications that didn't affect cell size (length). In some cases
however cell content needs to be reformatted and resized.

It's required e.g. to provide properly formatted MAC address in case
it's stored in a non-binary format (e.g. using ASCII).

There were few discussions how to optimally handle that. Following
possible solutions were considered:
1. Allow .read_post_process() to realloc (resize) content buffer
2. Allow .read_post_process() to adjust (decrease) just buffer length
3. Register NVMEM cells using post-read sizes

The preferred solution was the last one. The problem is that simply
adjusting "bytes" in NVMEM providers would result in core code NOT
passing whole raw data to .read_post_process() callbacks. It means
callback functions couldn't do their job without somehow manually
reading original cell content on their own.

This patch deals with that by registering NVMEM cells with both lengths:
raw content one and post read one. It allows:
1. Core code to read whole raw cell content
2. Callbacks to return content they want

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/core.c           | 11 +++++++----
 include/linux/nvmem-provider.h |  2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 212c5ba5789f..a62973d010ff 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -50,6 +50,7 @@ struct nvmem_device {
 struct nvmem_cell_entry {
 	const char		*name;
 	int			offset;
+	size_t			raw_len;
 	int			bytes;
 	int			bit_offset;
 	int			nbits;
@@ -469,6 +470,7 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 {
 	cell->nvmem = nvmem;
 	cell->offset = info->offset;
+	cell->raw_len = info->raw_len ?: info->bytes;
 	cell->bytes = info->bytes;
 	cell->name = info->name;
 	cell->read_post_process = info->read_post_process;
@@ -1560,7 +1562,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 {
 	int rc;
 
-	rc = nvmem_reg_read(nvmem, cell->offset, buf, cell->bytes);
+	rc = nvmem_reg_read(nvmem, cell->offset, buf, cell->raw_len);
 
 	if (rc)
 		return rc;
@@ -1571,7 +1573,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 
 	if (cell->read_post_process) {
 		rc = cell->read_post_process(cell->priv, id, index,
-					     cell->offset, buf, cell->bytes);
+					     cell->offset, buf, cell->raw_len);
 		if (rc)
 			return rc;
 	}
@@ -1594,14 +1596,15 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
  */
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 {
-	struct nvmem_device *nvmem = cell->entry->nvmem;
+	struct nvmem_cell_entry *entry = cell->entry;
+	struct nvmem_device *nvmem = entry->nvmem;
 	u8 *buf;
 	int rc;
 
 	if (!nvmem)
 		return ERR_PTR(-EINVAL);
 
-	buf = kzalloc(cell->entry->bytes, GFP_KERNEL);
+	buf = kzalloc(max_t(size_t, entry->raw_len, entry->bytes), GFP_KERNEL);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 0cf9f9490514..8ffb42ba0f62 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -51,6 +51,7 @@ struct nvmem_keepout {
  * struct nvmem_cell_info - NVMEM cell description
  * @name:	Name.
  * @offset:	Offset within the NVMEM device.
+ * @raw_len:	Length of raw data (without post processing).
  * @bytes:	Length of the cell.
  * @bit_offset:	Bit offset if cell is smaller than a byte.
  * @nbits:	Number of bits.
@@ -62,6 +63,7 @@ struct nvmem_keepout {
 struct nvmem_cell_info {
 	const char		*name;
 	unsigned int		offset;
+	size_t			raw_len;
 	unsigned int		bytes;
 	unsigned int		bit_offset;
 	unsigned int		nbits;
-- 
2.34.1

