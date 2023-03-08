Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF10C6B0CDD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjCHPdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjCHPc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:32:58 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216725D259;
        Wed,  8 Mar 2023 07:32:30 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 71657FF817;
        Wed,  8 Mar 2023 15:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678289549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/ImksdSBrmaV0urK8R+sWRAcEcl9MKuKFJL/MM1X44=;
        b=UdT+678g6P+qOlbMDH0Z1fjEu1gOEcMJgU8+4g1tZ8k33FtN0HFlb9D/L3WV3domz6fOV+
        VN3ujGIXt9jepInYoazwxUCsYww837N663VJajS8aVaF2RriflzrzIvgGW/ZmEIhKfGv+x
        WqdWco6FuZ9Hhb1u8eEzlVKjkCnbNSQBL7i8ANSnE750zjeuNwyLInPX1QzAoM2p5/YWH+
        VcnjNc78M0CMyFJKJ0ScxyJ9gn1fe+UJ2fqCesxZ7sdc6O2TczLamDg/NIzsb5fQq74M5x
        EORFsmezHZ7kREEENV6hyYbRsiG0m8We37exUA994hHtATr/Mn/6alwAaSEAmQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 15/20] nvmem: cell: drop global cell_post_process
Date:   Wed,  8 Mar 2023 16:31:55 +0100
Message-Id: <20230308153200.682248-16-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308153200.682248-1-miquel.raynal@bootlin.com>
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

There are no users anymore for the global cell_post_process callback
anymore. New users should use proper nvmem layouts.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c           | 9 ---------
 include/linux/nvmem-provider.h | 2 --
 2 files changed, 11 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f43025ad315b..fccb2728193a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -39,7 +39,6 @@ struct nvmem_device {
 	unsigned int		nkeepout;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
-	nvmem_cell_post_process_t cell_post_process;
 	struct gpio_desc	*wp_gpio;
 	struct nvmem_layout	*layout;
 	void *priv;
@@ -903,7 +902,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
-	nvmem->cell_post_process = config->cell_post_process;
 	nvmem->keepout = config->keepout;
 	nvmem->nkeepout = config->nkeepout;
 	if (config->of_node)
@@ -1576,13 +1574,6 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 			return rc;
 	}
 
-	if (nvmem->cell_post_process) {
-		rc = nvmem->cell_post_process(nvmem->priv, id, index,
-					      cell->offset, buf, cell->bytes);
-		if (rc)
-			return rc;
-	}
-
 	if (len)
 		*len = cell->bytes;
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index be81cc88eabc..d3d7af86a283 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -85,7 +85,6 @@ struct nvmem_cell_info {
  * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
- * @cell_post_process:	Callback for vendor specific post processing of cell data
  * @size:	Device size.
  * @word_size:	Minimum read/write access granularity.
  * @stride:	Minimum read/write access stride.
@@ -118,7 +117,6 @@ struct nvmem_config {
 	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
-	nvmem_cell_post_process_t cell_post_process;
 	int	size;
 	int	word_size;
 	int	stride;
-- 
2.34.1

