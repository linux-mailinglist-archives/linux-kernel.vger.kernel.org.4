Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DBE6D6A68
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbjDDRXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbjDDRW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:22:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB3B10E6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so133657356edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zAXST4Nx4xfK+O/wFtRAfJTRPqAOZA61Mnbi399eiE=;
        b=Ibh+vkIVA/B9MIyIeo/zKjYCCiCdU6s62YbIRrBhUlCwGqqkotTUnSLVN4UBwT3mai
         KgHF3f4y+mhzb4A04EsLjGgVaGPzTl3txVHpePqRLy5YT2nYAGzb5oorMrgNJPDjUJuE
         jU+E544BJWdDvseGmwZ4sUXx0G7jd3nqhEdhEjmQo3YeeQUqQVjGMTLSVicJNOOXJauW
         XGZ4sc6d2b41NGqGJHFZZ8YCmGGmyP/15xfpZk/NJAgn32J+uBzmH+fwpis3zMgjnpLH
         6YBGgzBli46MfL+pvf+hve4LNWswiezvzb597ehWaHKEAGfdK88gqqfGEotRWvacUuLl
         GF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zAXST4Nx4xfK+O/wFtRAfJTRPqAOZA61Mnbi399eiE=;
        b=lZ+/jPt2sBZ9cXk8zHjKWC8h0X4NcBunOzYN2lF7kdl9845wcDs5XhT7g4ZrNGp7WO
         /t90cPnmJBw99zo0ziZbjNmrwXAIRxgtKc9omd9/f/7QeWUN5COrFFvy5O72Pb6PcZNN
         WbwYTBIy5cOsvN5P7lC4HnXwauxqbP+V2M1UFqXcAEU0zDkuHJLQnas+6FIxDhiUPUvI
         OLPBcaI/RjmOyl/mWxqdVnJmJzaCwQO8QY1EaedmG0ndBNeAm7lh0OmO3pxVrqKr1kM4
         P2LJK7e/o+dWvKcjeo7xkPxET3S9WRa0RuILkOxVCqdTCwohcQMCojgMo/CJZguyvGNL
         ZQjg==
X-Gm-Message-State: AAQBX9dGQNVzlo0vjanOqd3POc8UDduIN/Vo+oIoHmfJnnDE7DUwrDZ9
        kzs7yE52zH8+FLu99Xy9wCnfAQ==
X-Google-Smtp-Source: AKy350bw0MoPwPqWHq9QXrOIF/s36ny2mf2pGQCIQy8RRO4DgVI4jD81qcIpPxXG7AeyXPZ8N8fzUw==
X-Received: by 2002:a17:907:388:b0:93a:6c59:4247 with SMTP id ss8-20020a170907038800b0093a6c594247mr272730ejb.13.1680628951728;
        Tue, 04 Apr 2023 10:22:31 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sebastian Reichel <sre@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/40] of: Rename of_modalias_node()
Date:   Tue,  4 Apr 2023 18:21:16 +0100
Message-Id: <20230404172148.82422-9-srinivas.kandagatla@linaro.org>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

This helper does not produce a real modalias, but tries to get the
"product" compatible part of the "vendor,product" compatibles only. It
is far from creating a purely useful modalias string and does not seem
to be used like that directly anyway, so let's try to give this helper a
more meaningful name before moving there a real modalias helper (already
existing under of/device.c).

Also update the various documentations to refer to the strings as
"aliases" rather than "modaliases" which has a real meaning in the Linux
kernel.

There is no functional change.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/acpi/bus.c                |  7 ++++---
 drivers/gpu/drm/drm_mipi_dsi.c    |  2 +-
 drivers/hsi/hsi_core.c            |  2 +-
 drivers/i2c/busses/i2c-powermac.c |  2 +-
 drivers/i2c/i2c-core-of.c         |  2 +-
 drivers/of/base.c                 | 18 +++++++++++-------
 drivers/spi/spi.c                 |  4 ++--
 include/linux/of.h                |  3 ++-
 8 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9531dd0fef50..fc74c786a867 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -817,9 +817,10 @@ static bool acpi_of_modalias(struct acpi_device *adev,
  * @modalias:   Pointer to buffer that modalias value will be copied into
  * @len:	Length of modalias buffer
  *
- * This is a counterpart of of_modalias_node() for struct acpi_device objects.
- * If there is a compatible string for @adev, it will be copied to @modalias
- * with the vendor prefix stripped; otherwise, @default_id will be used.
+ * This is a counterpart of of_alias_from_compatible() for struct acpi_device
+ * objects. If there is a compatible string for @adev, it will be copied to
+ * @modalias with the vendor prefix stripped; otherwise, @default_id will be
+ * used.
  */
 void acpi_set_modalias(struct acpi_device *adev, const char *default_id,
 		       char *modalias, size_t len)
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index b41aaf2bb9f1..b62f5e4425f4 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -160,7 +160,7 @@ of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 	int ret;
 	u32 reg;
 
-	if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
+	if (of_alias_from_compatible(node, info.type, sizeof(info.type)) < 0) {
 		drm_err(host, "modalias failure on %pOF\n", node);
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
index 8fda8f1d064d..acbf82f755a8 100644
--- a/drivers/hsi/hsi_core.c
+++ b/drivers/hsi/hsi_core.c
@@ -207,7 +207,7 @@ static void hsi_add_client_from_dt(struct hsi_port *port,
 	if (!cl)
 		return;
 
-	err = of_modalias_node(client, name, sizeof(name));
+	err = of_alias_from_compatible(client, name, sizeof(name));
 	if (err)
 		goto err;
 
diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 2e74747eec9c..ec706a3aba26 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -284,7 +284,7 @@ static bool i2c_powermac_get_type(struct i2c_adapter *adap,
 	 */
 
 	/* First try proper modalias */
-	if (of_modalias_node(node, tmp, sizeof(tmp)) >= 0) {
+	if (of_alias_from_compatible(node, tmp, sizeof(tmp)) >= 0) {
 		snprintf(type, type_size, "MAC,%s", tmp);
 		return true;
 	}
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index bce6b796e04c..8941a30574e3 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -27,7 +27,7 @@ int of_i2c_get_board_info(struct device *dev, struct device_node *node,
 
 	memset(info, 0, sizeof(*info));
 
-	if (of_modalias_node(node, info->type, sizeof(info->type)) < 0) {
+	if (of_alias_from_compatible(node, info->type, sizeof(info->type)) < 0) {
 		dev_err(dev, "of_i2c: modalias failure on %pOF\n", node);
 		return -EINVAL;
 	}
diff --git a/drivers/of/base.c b/drivers/of/base.c
index ac6fde53342f..161fe3192c46 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1208,19 +1208,23 @@ struct device_node *of_find_matching_node_and_match(struct device_node *from,
 EXPORT_SYMBOL(of_find_matching_node_and_match);
 
 /**
- * of_modalias_node - Lookup appropriate modalias for a device node
+ * of_alias_from_compatible - Lookup appropriate alias for a device node
+ *			      depending on compatible
  * @node:	pointer to a device tree node
- * @modalias:	Pointer to buffer that modalias value will be copied into
- * @len:	Length of modalias value
+ * @alias:	Pointer to buffer that alias value will be copied into
+ * @len:	Length of alias value
  *
  * Based on the value of the compatible property, this routine will attempt
- * to choose an appropriate modalias value for a particular device tree node.
+ * to choose an appropriate alias value for a particular device tree node.
  * It does this by stripping the manufacturer prefix (as delimited by a ',')
  * from the first entry in the compatible list property.
  *
+ * Note: The matching on just the "product" side of the compatible is a relic
+ * from I2C and SPI. Please do not add any new user.
+ *
  * Return: This routine returns 0 on success, <0 on failure.
  */
-int of_modalias_node(struct device_node *node, char *modalias, int len)
+int of_alias_from_compatible(const struct device_node *node, char *alias, int len)
 {
 	const char *compatible, *p;
 	int cplen;
@@ -1229,10 +1233,10 @@ int of_modalias_node(struct device_node *node, char *modalias, int len)
 	if (!compatible || strlen(compatible) > cplen)
 		return -ENODEV;
 	p = strchr(compatible, ',');
-	strscpy(modalias, p ? p + 1 : compatible, len);
+	strscpy(alias, p ? p + 1 : compatible, len);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(of_modalias_node);
+EXPORT_SYMBOL_GPL(of_alias_from_compatible);
 
 /**
  * of_find_node_by_phandle - Find a node given a phandle
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 44b85a8d47f1..3bbdc5fe3b99 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2354,8 +2354,8 @@ of_register_spi_device(struct spi_controller *ctlr, struct device_node *nc)
 	}
 
 	/* Select device driver */
-	rc = of_modalias_node(nc, spi->modalias,
-				sizeof(spi->modalias));
+	rc = of_alias_from_compatible(nc, spi->modalias,
+				      sizeof(spi->modalias));
 	if (rc < 0) {
 		dev_err(&ctlr->dev, "cannot find modalias for %pOF\n", nc);
 		goto err_out;
diff --git a/include/linux/of.h b/include/linux/of.h
index 0af611307db2..b1eea8569043 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -373,7 +373,8 @@ extern int of_n_addr_cells(struct device_node *np);
 extern int of_n_size_cells(struct device_node *np);
 extern const struct of_device_id *of_match_node(
 	const struct of_device_id *matches, const struct device_node *node);
-extern int of_modalias_node(struct device_node *node, char *modalias, int len);
+extern int of_alias_from_compatible(const struct device_node *node, char *alias,
+				    int len);
 extern void of_print_phandle_args(const char *msg, const struct of_phandle_args *args);
 extern int __of_parse_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name, int cell_count,
-- 
2.25.1

