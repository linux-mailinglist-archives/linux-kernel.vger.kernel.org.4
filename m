Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B726AE77F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCGQ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCGQ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:04 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE8690B6C;
        Tue,  7 Mar 2023 08:54:24 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 057ACC0003;
        Tue,  7 Mar 2023 16:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678208060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AydJWfzDv7AL2c1bg6r1qVLfZawbDxF4QfVTKj9aXJ8=;
        b=AHsGXlzY3Nw33pWY6CJr1qEs8mDDyRKQGWt3GGuQ/gcRXvLeJcq+cliV15TR2f4+IaVPpK
        tw8nrnOuZWrwDRjLy6yy0er15hi/OTtOFIffXi/wrp/2OOzc7s7KbjsjcKuVvFLMDngfnm
        YwtUn4zCIH+x09s+U4gRDrJTpQvtwfciIh2K6kwaKJ9+7UFPReCrZwi4VAUL6ocnxoOM3f
        IL4nFf6aBIgiA86TW6bLVfIXayr761VarJKtbURSIcAYLD0X0T2BHdudGomlD1FPA49Cxl
        /Uv/6GhB03BEno8OwYhhObh68mnw81cWHXPSFTnkL0he97ToLcl/Cn/BazbKdw==
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sebastian Reichel <sre@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 03/21] of: Rename of_modalias_node()
Date:   Tue,  7 Mar 2023 17:53:41 +0100
Message-Id: <20230307165359.225361-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307165359.225361-1-miquel.raynal@bootlin.com>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
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
---
 drivers/acpi/bus.c                |  7 ++++---
 drivers/gpu/drm/drm_mipi_dsi.c    |  2 +-
 drivers/hsi/hsi_core.c            |  2 +-
 drivers/i2c/busses/i2c-powermac.c |  2 +-
 drivers/i2c/i2c-core-of.c         |  2 +-
 drivers/of/base.c                 | 15 ++++++++-------
 drivers/spi/spi.c                 |  4 ++--
 include/linux/of.h                |  2 +-
 8 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 0c05ccde1f7a..6eea487a1de6 100644
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
index 497ef4b6a90a..0f0a715704ba 100644
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
index 884066109699..8066e31bbece 100644
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
index 3ed74aa4b44b..df21c2b69bed 100644
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
index d5a5c35eba72..fd98a302a07f 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1208,19 +1208,20 @@ struct device_node *of_find_matching_node_and_match(struct device_node *from,
 EXPORT_SYMBOL(of_find_matching_node_and_match);
 
 /**
- * of_modalias_node - Lookup appropriate modalias for a device node
+ * of_alias_from_compatible - Lookup appropriate alias for a device node
+ *			      depending on compatible
  * @node:	pointer to a device tree node
- * @modalias:	Pointer to buffer that modalias value will be copied into
- * @len:	Length of modalias value
+ * @modalias:	Pointer to buffer that alias value will be copied into
+ * @len:	Length of alias value
  *
  * Based on the value of the compatible property, this routine will attempt
- * to choose an appropriate modalias value for a particular device tree node.
+ * to choose an appropriate alias value for a particular device tree node.
  * It does this by stripping the manufacturer prefix (as delimited by a ',')
  * from the first entry in the compatible list property.
  *
  * Return: This routine returns 0 on success, <0 on failure.
  */
-int of_modalias_node(struct device_node *node, char *modalias, int len)
+int of_alias_from_compatible(struct device_node *node, char *alias, int len)
 {
 	const char *compatible, *p;
 	int cplen;
@@ -1229,10 +1230,10 @@ int of_modalias_node(struct device_node *node, char *modalias, int len)
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
index 3cc7bb4d03de..e4447ae59892 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2333,8 +2333,8 @@ of_register_spi_device(struct spi_controller *ctlr, struct device_node *nc)
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
index 98c252d2d851..fc7ada57df33 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -362,7 +362,7 @@ extern int of_n_addr_cells(struct device_node *np);
 extern int of_n_size_cells(struct device_node *np);
 extern const struct of_device_id *of_match_node(
 	const struct of_device_id *matches, const struct device_node *node);
-extern int of_modalias_node(struct device_node *node, char *modalias, int len);
+extern int of_alias_from_compatible(struct device_node *node, char *alias, int len);
 extern void of_print_phandle_args(const char *msg, const struct of_phandle_args *args);
 extern int __of_parse_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name, int cell_count,
-- 
2.34.1

