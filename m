Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E00769FA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjBVRX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjBVRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:23:18 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5886093D4;
        Wed, 22 Feb 2023 09:23:17 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id y14so1477324ljq.4;
        Wed, 22 Feb 2023 09:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3duNGI0HfLu2PQ/Hpn1IXizpNMVGcpGhUax+XUrkwo=;
        b=Qw2n8KB0aHET9DR0jdhZl6RxgAHDB/IFzEnlmka1iyJ+lBiFBGMzav4Wl5mEAX8NIu
         UQ5xSppwLtUR2UzSE/DmYGcX34P6FbWPz6IHe7hwRUllahOaNT8/mwk3QEhEfqloTKv+
         tHFO0YztbXODEUPXySlJtGt5VAhR6JJmH3E7YfCqmRf/CsukcrBwnsLJxjAo9PI/lQP5
         CQEQSh7/FVsKFR3vW/GiZwswpGADkDKDnVlQLTIMCjcTRKRf8pitHw8ErIcBp4O2ZW+z
         jTjtQGJkYhLWwyMGQrSn/G+x7UKhKtzU0QHnbI1MEBixoBaBICkXzJcL90KJWIGLc2te
         tUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3duNGI0HfLu2PQ/Hpn1IXizpNMVGcpGhUax+XUrkwo=;
        b=AWIgeozVkLvq0nwbRZI2SKay5izKHaku0yfN+pH9N6Ms6vQ8weYG9D+chVqtkWfORo
         hjHR/Pocsi57V0205nfEjajoW08QlAp4Q8iMjSSijIZElW4h5vx67JbtDe20WD6k4OGc
         5IlQgPl5eBtF3HCAlOsc2VzA+gk5WTdAg/gy/ZkQTVPcheMjklaLSLd2nYYvZdRPNT05
         b/wZQvtuUzFfVhZMynC5yD0j6Eq47infhFgvUZ2ZCJOqlhJXNbJtUBTLCRtkUMm+IE7h
         6lznHZsf5pPWJqG8gPXQBBTBbvodMl0u0RLJFYV03iZgh4ZDi736mSxQJnRDaDKcNzcP
         1HsQ==
X-Gm-Message-State: AO0yUKVzbLtQXILEPehWZ+h9HrTfAlTwBnvBnQnSGPReUYjVJx1Ntm56
        sERF8sqgHDWER0XceJU9tdU=
X-Google-Smtp-Source: AK7set/KJLsv+oD6LfWtc4pxWzpcUiaIY23jTLgt93cV4yoo1N1fURWA5VgfO5rHjBRIYPdvtPraeQ==
X-Received: by 2002:a2e:b5ab:0:b0:294:7028:c672 with SMTP id f11-20020a2eb5ab000000b002947028c672mr3147761ljn.44.1677086595638;
        Wed, 22 Feb 2023 09:23:15 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p2-20020a2e93c2000000b0029477417d80sm721513ljh.85.2023.02.22.09.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 09:23:15 -0800 (PST)
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
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de
Subject: [PATCH 1/4] nvmem: core: add per-cell post processing
Date:   Wed, 22 Feb 2023 18:22:42 +0100
Message-Id: <20230222172245.6313-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222172245.6313-1-zajec5@gmail.com>
References: <20230222172245.6313-1-zajec5@gmail.com>
MIME-Version: 1.0
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

From: Michael Walle <michael@walle.cc>

Instead of relying on the name the consumer is using for the cell, like
it is done for the nvmem .cell_post_process configuration parameter,
provide a per-cell post processing hook. This can then be populated by
the NVMEM provider (or the NVMEM layout) when adding the cell.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 17 +++++++++++++++++
 include/linux/nvmem-provider.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6783cd8478d7..c5c9a4654241 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -52,6 +52,7 @@ struct nvmem_cell_entry {
 	int			bytes;
 	int			bit_offset;
 	int			nbits;
+	nvmem_cell_post_process_t read_post_process;
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
@@ -465,6 +466,7 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 	cell->offset = info->offset;
 	cell->bytes = info->bytes;
 	cell->name = info->name;
+	cell->read_post_process = info->read_post_process;
 
 	cell->bit_offset = info->bit_offset;
 	cell->nbits = info->nbits;
@@ -1429,6 +1431,13 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 	if (cell->bit_offset || cell->nbits)
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
+	if (cell->read_post_process) {
+		rc = cell->read_post_process(nvmem->priv, id, index,
+					     cell->offset, buf, cell->bytes);
+		if (rc)
+			return rc;
+	}
+
 	if (nvmem->cell_post_process) {
 		rc = nvmem->cell_post_process(nvmem->priv, id, index,
 					      cell->offset, buf, cell->bytes);
@@ -1537,6 +1546,14 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
 	    (cell->bit_offset == 0 && len != cell->bytes))
 		return -EINVAL;
 
+	/*
+	 * Any cells which have a read_post_process hook are read-only because
+	 * we cannot reverse the operation and it might affect other cells,
+	 * too.
+	 */
+	if (cell->read_post_process)
+		return -EINVAL;
+
 	if (cell->bit_offset || cell->nbits) {
 		buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
 		if (IS_ERR(buf))
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index b3c14ce87a65..f87fd64eee8f 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -54,6 +54,8 @@ struct nvmem_keepout {
  * @bit_offset:	Bit offset if cell is smaller than a byte.
  * @nbits:	Number of bits.
  * @np:		Optional device_node pointer.
+ * @read_post_process:	Callback for optional post processing of cell data
+ *			on reads.
  */
 struct nvmem_cell_info {
 	const char		*name;
@@ -62,6 +64,7 @@ struct nvmem_cell_info {
 	unsigned int		bit_offset;
 	unsigned int		nbits;
 	struct device_node	*np;
+	nvmem_cell_post_process_t read_post_process;
 };
 
 /**
-- 
2.34.1

