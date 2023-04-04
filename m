Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07F66D6A72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbjDDRXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjDDRXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E98F5B9C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cn12so133620575edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dd46+0TAGQ78Me5bR3fENN5XDlibu+aAg1Xm4nj3Mm0=;
        b=v0IqlDIhJcw/5kQ6iNgBZ+9wh6fMuUHIs6HnTmiMj8mFay3fh9eL87PsQZILbx28U4
         DtrzhUp6OKf6FjIQzcmDrAVEDlAAmwR5R2qzuXukiQahP8+mXUs7ADGwThrNz9qNQtdd
         TbmfO7j5OXVP3z+X7gfCHJFlE8AMMPZTq6jh6pybodTiHT7ZYNFtgMXxcnT06Rm3lwHg
         8RXUtWAhRXt0aYsrz1DIL+TCwlbwucsqblIuGslZSr47sORffpyKGQ4yd9tpq71sqM4Y
         ZodZBPNDv46AjgiBiSBCcH5rGkvlMB7HnylwpVAUz73umBodWvJJ5UsZQnnXuRtwfIv1
         Q9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dd46+0TAGQ78Me5bR3fENN5XDlibu+aAg1Xm4nj3Mm0=;
        b=70g6AyX7XJVZQGbFsC6Vw8jkoOe3iRhZ7fL6lnTYdBjY6FIQL8kv2fngiXb0WO6gwW
         MB36Uk4uzUHX7K21mK00GZueCjkpZnV+n4iW6yq4I4bJS14relI+mUIqO686tO7ZvNfc
         MhKivpa9tuZAnguxjnsY+eT6CfCL8V1pusk206ztc6m5gUYALlvRD6GvQ21xQFAeIXXN
         pFwGYL+eIVHQJ964Gc6P88ZeQc8OGIDC8RCWuhKqT2VdZtMX4NZX2J9hpVBpXSMRwByu
         gbYSFlIfw8xUCYGq7vOWdUtMQW7QwQv1wrCYMfoEK4nx49KAn0+iN9qtBWgjEAWK1yuh
         KKEw==
X-Gm-Message-State: AAQBX9dGjQzD50UhX1OeXBuwFx6b4nAT/ASRGoBq8R2tXGw/KjX7oEEm
        LcQTns87hM+5dXwbHXBBWcHu0Q==
X-Google-Smtp-Source: AKy350bvdwp5VOqnBlKEdtQsQLi6cP6a74vqta3Eqav7yiAh5EHPrv15yy5NuPfeiO53yuf+VDfHJQ==
X-Received: by 2002:a17:906:c2c2:b0:933:2f77:ca78 with SMTP id ch2-20020a170906c2c200b009332f77ca78mr329348ejb.28.1680628967979;
        Tue, 04 Apr 2023 10:22:47 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 18/40] nvmem: imx-ocotp: replace global post processing with layouts
Date:   Tue,  4 Apr 2023 18:21:26 +0100
Message-Id: <20230404172148.82422-19-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

In preparation of retiring the global post processing hook change this
driver to use layouts. The layout will be supplied during registration
and will be used to add the post processing hook to all added cells.

Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Michael Walle <michael@walle.cc> # on kontron-pitx-imx8m
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
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
2.25.1

