Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E42636835
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbiKWSEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbiKWSCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:30 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146D5B85;
        Wed, 23 Nov 2022 10:02:26 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id AE81A27BF;
        Wed, 23 Nov 2022 19:02:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669226544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPNHYJ7cdASLHAEjEX3cpHT6PEI/wCz5wvyevFbTiJM=;
        b=w86O7N3OKtp8gWhowSQtXL8imOvtNFWH65d7LXHQkMQA8N+Lio0/i8k3YGeixS0gr59oUU
        tXX17iGKPUfrspytGuLqtk6KK4MWzq5iSjkL07jzHSHE0kSZmJg2xJCOe5rMZjjW1xY8Ds
        jdpSwNbRk+bSdioshV2RHL26JgkettVKKEQkTjBXCm6o/uoDuUWUc0S8ptQNArh/n4LvBr
        NtMaJOT2AuRQtQ2XSot9eaSIidHffSTlWSxWmnc+iRTEl3aSceRoUQZgUNO7CKoos7fzUX
        VaAfCK+yaSa0XxcxiQkm6wXimeKKUGGRtyZBzeJiXyVqlHMO5aAFWY8aaTMo5Q==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 14/20] nvmem: imx-ocotp: replace global post processing with layouts
Date:   Wed, 23 Nov 2022 19:01:45 +0100
Message-Id: <20221123180151.2160033-15-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123180151.2160033-1-michael@walle.cc>
References: <20221123180151.2160033-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of retiring the global post processing hook change this
driver to use layouts. The layout will be supplied during registration
and will be used to add the post processing hook to all added cells.

Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Michael Walle <michael@walle.cc> # on kontron-pitx-imx8m
---
changes since v3:
 - none

changes since v2:
 - none

changes since v1:
 - new patch

 drivers/nvmem/imx-ocotp.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index e9b52ecb3f72..ac0edb6398f1 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -225,18 +225,13 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 static int imx_ocotp_cell_pp(void *context, const char *id, int index,
 			     unsigned int offset, void *data, size_t bytes)
 {
-	struct ocotp_priv *priv = context;
+	u8 *buf = data;
+	int i;
 
 	/* Deal with some post processing of nvmem cell data */
-	if (id && !strcmp(id, "mac-address")) {
-		if (priv->params->reverse_mac_address) {
-			u8 *buf = data;
-			int i;
-
-			for (i = 0; i < bytes/2; i++)
-				swap(buf[i], buf[bytes - i - 1]);
-		}
-	}
+	if (id && !strcmp(id, "mac-address"))
+		for (i = 0; i < bytes / 2; i++)
+			swap(buf[i], buf[bytes - i - 1]);
 
 	return 0;
 }
@@ -488,7 +483,6 @@ static struct nvmem_config imx_ocotp_nvmem_config = {
 	.stride = 1,
 	.reg_read = imx_ocotp_read,
 	.reg_write = imx_ocotp_write,
-	.cell_post_process = imx_ocotp_cell_pp,
 };
 
 static const struct ocotp_params imx6q_params = {
@@ -595,6 +589,17 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
 
+static void imx_ocotp_fixup_cell_info(struct nvmem_device *nvmem,
+				      struct nvmem_layout *layout,
+				      struct nvmem_cell_info *cell)
+{
+	cell->read_post_process = imx_ocotp_cell_pp;
+}
+
+struct nvmem_layout imx_ocotp_layout = {
+	.fixup_cell_info = imx_ocotp_fixup_cell_info,
+};
+
 static int imx_ocotp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -619,6 +624,9 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	imx_ocotp_nvmem_config.size = 4 * priv->params->nregs;
 	imx_ocotp_nvmem_config.dev = dev;
 	imx_ocotp_nvmem_config.priv = priv;
+	if (priv->params->reverse_mac_address)
+		imx_ocotp_nvmem_config.layout = &imx_ocotp_layout;
+
 	priv->config = &imx_ocotp_nvmem_config;
 
 	clk_prepare_enable(priv->clk);
-- 
2.30.2

