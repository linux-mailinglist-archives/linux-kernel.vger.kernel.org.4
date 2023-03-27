Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDB36CA754
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjC0OSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjC0OSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:18:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A8D4EF8;
        Mon, 27 Mar 2023 07:16:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y20so11692049lfj.2;
        Mon, 27 Mar 2023 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679926581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yqch5jULqmWEWTHXX6KBVjnq6Ntet8zuoOYrwUTgPMo=;
        b=iCqbpfjj6D1JBfCpFPNBkQSPAcBZYhPKbCt0RxB7YdZxNLaFoqp9xbqChvpQjwUnLq
         ls5bH6NXww9DQc5NzTNJmcNQAHKRZLSdXTQyEioMetMlCfO44zQa9DTQrytKESz64n48
         JZqD3TDGasafpqxVruF3SR8YO6p4aRzFmVqHZNq3cvdGBaUEMiMDrdRvM9dwR+d9R+if
         I5Lt03q6u2yw25MhJH4yBbduGDLgxO9FLvk1hKtl01YBctxzfdC/hzUSjreK3GJTuB5z
         bjPZiJYv/GkmQYlbqJvNXtm01B9ke+Eh9JewNZZIQuuYcUPKKajGOHluDW4vwbriWGME
         eKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679926581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yqch5jULqmWEWTHXX6KBVjnq6Ntet8zuoOYrwUTgPMo=;
        b=MyVD7rC5mS/g8/VcEMs0SvLqmJ8ieAZVSoMdmxnkSpD4tnvz4ASx+ybO0SprwOZ+eL
         8IPgP22He+7YB5vnkBOGPtEiDpo9DTTz9ssRf2GePhY6Jrcd+R/tiw9XrHEcut+x0tEz
         4mfPNu3W6fpGey1MDR8qQFz/SYhIlMvLCqkLC9HiLDqKKQkH+i8HeTPaBg+vERo/GpKr
         ei8LgCKw0ffbF5LX+ARV1TrQE315O6HfFYJR2jgHjV+qnBfMqdwnCGFIch5xkp4x7+MO
         epeTbNqLowFuaAqos9B23A5fw9mHYw/hEWW6J8E1oqDYlWLatynNo4aEiaCff55HO/ZX
         bpBg==
X-Gm-Message-State: AAQBX9dhe8rvbCf/g19F56LCqErMF2o7IkZughlZuV+7DNdngNSZmmsH
        eI6BZFm76hqZxijBhCPOawY=
X-Google-Smtp-Source: AKy350b78cuprR1O5sE51wMcHwOQEtVA5k89dnr3VjwgN6PHM/VYjLse09v9ge6ZtU9BpvOX1ra0EA==
X-Received: by 2002:ac2:5290:0:b0:4d8:6492:5689 with SMTP id q16-20020ac25290000000b004d864925689mr3290297lfm.31.1679926580982;
        Mon, 27 Mar 2023 07:16:20 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004e977970721sm4444519lfl.219.2023.03.27.07.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 07:16:20 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V6 3/3] nvmem: core: add support for fixed cells *layout*
Date:   Mon, 27 Mar 2023 16:16:11 +0200
Message-Id: <20230327141611.25131-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327141611.25131-1-zajec5@gmail.com>
References: <20230327141611.25131-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This adds support for the "fixed-layout" NVMEM layout binding. It allows
defining NVMEM cells in a layout DT node named "nvmem-layout".

While NVMEM subsystem supports layout drivers it has been discussed that
"fixed-layout" may actually be supperted internally. It's because:
1. It's a very basic layout
2. It allows sharing code with legacy syntax parsing
3. It's safer for soc_device_match() due to -EPROBE_DEFER
4. This will make the syntax transition easier

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Michael Walle <michael@walle.cc>
---
V6: s/nvmem_add_cells_fixed/nvmem_add_cells_from_fixed_layout/
---
 drivers/nvmem/core.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a62973d010ff..b3d5a29477f9 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -696,7 +696,7 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 	return 0;
 }
 
-static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
+static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np)
 {
 	struct nvmem_layout *layout = nvmem->layout;
 	struct device *dev = &nvmem->dev;
@@ -704,7 +704,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 	const __be32 *addr;
 	int len, ret;
 
-	for_each_child_of_node(dev->of_node, child) {
+	for_each_child_of_node(np, child) {
 		struct nvmem_cell_info info = {0};
 
 		addr = of_get_property(child, "reg", &len);
@@ -742,6 +742,28 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 	return 0;
 }
 
+static int nvmem_add_cells_from_legacy_of(struct nvmem_device *nvmem)
+{
+	return nvmem_add_cells_from_dt(nvmem, nvmem->dev.of_node);
+}
+
+static int nvmem_add_cells_from_fixed_layout(struct nvmem_device *nvmem)
+{
+	struct device_node *layout_np;
+	int err = 0;
+
+	layout_np = of_nvmem_layout_get_container(nvmem);
+	if (!layout_np)
+		return 0;
+
+	if (of_device_is_compatible(layout_np, "fixed-layout"))
+		err = nvmem_add_cells_from_dt(nvmem, layout_np);
+
+	of_node_put(layout_np);
+
+	return err;
+}
+
 int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner)
 {
 	layout->owner = owner;
@@ -972,7 +994,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
-	rval = nvmem_add_cells_from_of(nvmem);
+	rval = nvmem_add_cells_from_legacy_of(nvmem);
 	if (rval)
 		goto err_remove_cells;
 
@@ -982,6 +1004,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
+	rval = nvmem_add_cells_from_fixed_layout(nvmem);
+	if (rval)
+		goto err_remove_cells;
+
 	rval = nvmem_add_cells_from_layout(nvmem);
 	if (rval)
 		goto err_remove_cells;
-- 
2.34.1

