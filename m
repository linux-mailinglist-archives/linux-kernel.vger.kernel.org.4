Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1662D68BA25
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjBFK2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjBFK2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:33 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4F3196AE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so10376170wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXDBpITirucrehQ9ezP0AqqR7r7iazhcEnMQ2xV42Tk=;
        b=dOnPmfyYu1HYKBcyQgBB2ZCy1MdR1u2zmVl68Se00KFlS4rS8sJ0VgQmvYXxJGfF4x
         /NyyPn2ywoKgwrnbSQRi3ryBozKD4mIlh2kqO31N6K06WYYdTnOhJoU9m1lV/TSITJIn
         CD7FtjnUl8wdF1OvogSL0bxRtYBZsMoeBGzaQtXkZ3DfEefPc+KL6yEyw8XdS27HMMCW
         ATmV4OxmGucNC/ij1Wc9YZLNyCjBUCxx0KC/+CYYAZd5dRCGAlGfulhNLBw+9+WCpMii
         DKFvGdWV3X2w7KPcDdegHcrzfci8Vh3xF2Fw/M6Vemq+ImzZqWfsAFcCfSk6kTy70FoG
         2MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXDBpITirucrehQ9ezP0AqqR7r7iazhcEnMQ2xV42Tk=;
        b=xKGvJt0h5q7Hi/J8pAarkP4iaJ/wp5U+ZkY+Ia6Nu8WNf7v5n2461IJpIBrEcbt0If
         /WGrj162gDAa9u5woPQi8jpnbZivYsnnge7dTng0yepCol1qFfqEGoVadgEAKYwrsv2R
         RF+qEJgdNfaQE3g6cpECBLcHlKsnk/zCYCNc2rgxWrDIJAfY5BRCQ4P5cJ42ajfO8RRs
         4qG9lAM0A3ZIzhayuA+BjLXtUzd/kEQK5l60CLngjZJ+IV8nL4SUK2icpwUdAMlUfxJl
         yH+3wbjWaXidharewaBDpAzN/lq1fcrz+WJuo2K/Na97+FPEadyqpAoISxvG/wMiBEu+
         Znww==
X-Gm-Message-State: AO0yUKV4av21Vykbml16p+tGWEwuzU8CdMsHRC67tuNmNq4bzuJ1s7Ch
        EyvMXt0OiYn2IrBK9W1zG+VlOA==
X-Google-Smtp-Source: AK7set8wQwyzJo7cACuwZCM2gtXUEj5GHELBNe4HpXFlQ0zaKi4QYHTgEMJHDkBhU9KfQC22cH1EPQ==
X-Received: by 2002:a7b:cbd8:0:b0:3df:e69a:2175 with SMTP id n24-20020a7bcbd8000000b003dfe69a2175mr7571010wmi.35.1675679308479;
        Mon, 06 Feb 2023 02:28:28 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:27 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 12/37] nvmem: core: add an index parameter to the cell
Date:   Mon,  6 Feb 2023 10:27:34 +0000
Message-Id: <20230206102759.669838-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
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

Sometimes a cell can represend multiple values. For example, a base
ethernet address stored in the NVMEM can be expanded into multiple
discreet ones by adding an offset.

For this use case, introduce an index parameter which is then used to
distiguish between values. This parameter will then be passed to the
post process hook which can then use it to create different values
during reading.

At the moment, there is only support for the device tree path. You can
add the index to the phandle, e.g.

  &net {
          nvmem-cells = <&base_mac_address 2>;
          nvmem-cell-names = "mac-address";
  };

  &nvmem_provider {
          base_mac_address: base-mac-address@0 {
                  #nvmem-cell-cells = <1>;
                  reg = <0 6>;
          };
  };

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 37 ++++++++++++++++++++++++----------
 drivers/nvmem/imx-ocotp.c      |  4 ++--
 include/linux/nvmem-provider.h |  4 ++--
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 233c6c275031..30567dd51fba 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -60,6 +60,7 @@ struct nvmem_cell_entry {
 struct nvmem_cell {
 	struct nvmem_cell_entry *entry;
 	const char		*id;
+	int			index;
 };
 
 static DEFINE_MUTEX(nvmem_mutex);
@@ -1122,7 +1123,8 @@ struct nvmem_device *devm_nvmem_device_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL_GPL(devm_nvmem_device_get);
 
-static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry, const char *id)
+static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry,
+					    const char *id, int index)
 {
 	struct nvmem_cell *cell;
 	const char *name = NULL;
@@ -1141,6 +1143,7 @@ static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry, cons
 
 	cell->id = name;
 	cell->entry = entry;
+	cell->index = index;
 
 	return cell;
 }
@@ -1179,7 +1182,7 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 				__nvmem_device_put(nvmem);
 				cell = ERR_PTR(-ENOENT);
 			} else {
-				cell = nvmem_create_cell(cell_entry, con_id);
+				cell = nvmem_create_cell(cell_entry, con_id, 0);
 				if (IS_ERR(cell))
 					__nvmem_device_put(nvmem);
 			}
@@ -1227,15 +1230,27 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 	struct nvmem_device *nvmem;
 	struct nvmem_cell_entry *cell_entry;
 	struct nvmem_cell *cell;
+	struct of_phandle_args cell_spec;
 	int index = 0;
+	int cell_index = 0;
+	int ret;
 
 	/* if cell name exists, find index to the name */
 	if (id)
 		index = of_property_match_string(np, "nvmem-cell-names", id);
 
-	cell_np = of_parse_phandle(np, "nvmem-cells", index);
-	if (!cell_np)
-		return ERR_PTR(-ENOENT);
+	ret = of_parse_phandle_with_optional_args(np, "nvmem-cells",
+						  "#nvmem-cell-cells",
+						  index, &cell_spec);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (cell_spec.args_count > 1)
+		return ERR_PTR(-EINVAL);
+
+	cell_np = cell_spec.np;
+	if (cell_spec.args_count)
+		cell_index = cell_spec.args[0];
 
 	nvmem_np = of_get_parent(cell_np);
 	if (!nvmem_np) {
@@ -1257,7 +1272,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 		return ERR_PTR(-ENOENT);
 	}
 
-	cell = nvmem_create_cell(cell_entry, id);
+	cell = nvmem_create_cell(cell_entry, id, cell_index);
 	if (IS_ERR(cell))
 		__nvmem_device_put(nvmem);
 
@@ -1410,8 +1425,8 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void
 }
 
 static int __nvmem_cell_read(struct nvmem_device *nvmem,
-		      struct nvmem_cell_entry *cell,
-		      void *buf, size_t *len, const char *id)
+			     struct nvmem_cell_entry *cell,
+			     void *buf, size_t *len, const char *id, int index)
 {
 	int rc;
 
@@ -1425,7 +1440,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
 	if (nvmem->cell_post_process) {
-		rc = nvmem->cell_post_process(nvmem->priv, id,
+		rc = nvmem->cell_post_process(nvmem->priv, id, index,
 					      cell->offset, buf, cell->bytes);
 		if (rc)
 			return rc;
@@ -1460,7 +1475,7 @@ void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
-	rc = __nvmem_cell_read(nvmem, cell->entry, buf, len, cell->id);
+	rc = __nvmem_cell_read(nvmem, cell->entry, buf, len, cell->id, cell->index);
 	if (rc) {
 		kfree(buf);
 		return ERR_PTR(rc);
@@ -1773,7 +1788,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 	if (rc)
 		return rc;
 
-	rc = __nvmem_cell_read(nvmem, &cell, buf, &len, NULL);
+	rc = __nvmem_cell_read(nvmem, &cell, buf, &len, NULL, 0);
 	if (rc)
 		return rc;
 
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 14284e866f26..e9b52ecb3f72 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -222,8 +222,8 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 	return ret;
 }
 
-static int imx_ocotp_cell_pp(void *context, const char *id, unsigned int offset,
-			     void *data, size_t bytes)
+static int imx_ocotp_cell_pp(void *context, const char *id, int index,
+			     unsigned int offset, void *data, size_t bytes)
 {
 	struct ocotp_priv *priv = context;
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index bb15c9234e21..55181d837969 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -20,8 +20,8 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
 /* used for vendor specific post processing of cell data */
-typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, unsigned int offset,
-					  void *buf, size_t bytes);
+typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int index,
+					 unsigned int offset, void *buf, size_t bytes);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
-- 
2.25.1

