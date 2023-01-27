Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E741B67E2FF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjA0LTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjA0LSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7437A490
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:09 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso3191271wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qJxrwfcLTXBaQBmmE6as0L4veHi/uh8tjNkkwxbsmQ=;
        b=Q+yGL6NNnK5ULiY1gOtIA9YoTYj2eYM7WABKdQ6QlDnB0YNUfVvOEItzU616iRORdS
         eyV7u0hxCafKwXzYKI7B+ndFg8N14s/Ru7/1Df9ex32Ozts+pK3eglrkT+c8K+8nxnm6
         UhhUsyTBYl7pv4g071VYZiDLI+oUYH0IydUWG7Y78uf/EEsd1Onjnddt3F6X8WwYPkUK
         7E3lUUHV3oWoQRv66i6YzstNANN7aMudRSKuLdVQ92mm8sQUOL6hmEjEjhfE1lS6VjGG
         raTYwwm5k9eFJJT1M5zoA22u4EHi9oSAcdNJDdke1nQ+mEnXr4KX9Cw/acbfZiZ/a4g2
         ovaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qJxrwfcLTXBaQBmmE6as0L4veHi/uh8tjNkkwxbsmQ=;
        b=zGQRefIK+P6cq97LsXJtCnuY7ec7UGrMVMGSncqMWU4qnXAPX2wUiHmHPtNPQrhSqV
         Iw6zWRDmEMG2U/6dOIitoFCJT9xjZtkrFER8htrD8et2+cSV7mnNTVcF1/SzX4ZeDV9s
         LgPzxA5HWmAEy9OMZIwf9BIWEGCrX7FfcLWj7hpwCSk80RIRSujkrqFUm4K2vduLvO3l
         kIBPey2S0OiWZjUd45kzzaxQTJrYKemw9Q8D9Gd0sonMlYAK1M8hZx7Kw0PTeFdYcNaw
         +KY2wdw/H/Njb9szYTzNg0krgMHo4MMsOdKb2oJAQmT6NzHlR/Q9pu5LBKafesuHW+D6
         FRiA==
X-Gm-Message-State: AFqh2kpJmE1dzkxZS35PStEkFVYiXrzFJWD+l67mtfXo/fV2K9pjCRWb
        D4n4UyRYv/zlbI6CgEAzUQEYWA==
X-Google-Smtp-Source: AMrXdXvwVkC92YnC3DyPPSpEJzf1FVRZ9RyPCo0MGRHmPBu2zJdkdKC/jyU0AXMzQ3dQlGDaBkRiLQ==
X-Received: by 2002:a05:600c:3b84:b0:3da:fd7c:98b3 with SMTP id n4-20020a05600c3b8400b003dafd7c98b3mr39161014wms.25.1674818287177;
        Fri, 27 Jan 2023 03:18:07 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:06 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 20/37] nvmem: imx-ocotp: replace global post processing with layouts
Date:   Fri, 27 Jan 2023 11:15:48 +0000
Message-Id: <20230127111605.25958-21-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

