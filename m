Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD12B6C2EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCUKZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCUKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:24:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F541A663;
        Tue, 21 Mar 2023 03:24:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t11so18465585lfr.1;
        Tue, 21 Mar 2023 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679394268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWn/7mbklD+A+VP8Q0o9PMepwQzDExkOlaUCk9c90go=;
        b=iquuKDMl6Sqaw/4fFi35QnrEmF2ISe0CqEPGKCaT2wkhZo/3Yz10fW2lj6LbTbJymI
         bdxwZ4WL3jPu8LAnQQa08mrHlhJ7VTpicEm/DuObAWhtOFTiU07Upmk5Sdw6Wk1r9+7m
         5YLoSxx4zCZ3IqIu4es5M2p05CPoScm4iH2Pz7QEFiyrzCVctSVdsT/viItWjJrhv7fi
         zYV0KK1ACS9w+6/SoEVz8zouJZPqndunovcm82iQVZ6Kgu3xbuSjUarTTbuPekjzCR7Z
         jKpTmL5DWjmERKHOSYfcZzSDX0f7X69xk2x3PUPpwODw9qC2cB3ab/Y1UDpnA3rw99Ft
         e77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679394268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWn/7mbklD+A+VP8Q0o9PMepwQzDExkOlaUCk9c90go=;
        b=4pB18e+OUD232VBcLkxhZiu2dDASgvDC4lOyfx9k3ck/kWGNM7ZGjFqsJv7hkiQVDW
         YsV/a7yS04NKr0m5J9ChaY/iDw7lS6EbD4fNgwITGi6wozuISEzY2Xc6RfGNmW9WDQlB
         je2Fv0FzHLLxLrRyKG2Uw7yIQvEKnqZvSwf/NGJ9pVyC5Nv589pkX/81zLm5NgpT7QOQ
         OdVgddg5cEhsdu1mMt/p9SuKOQJElWFhgcA+16BvHYc1AZWFST0iVWU1E48BCZkeGP+6
         bK5WsNy/IKwn8eB+umZAaQrE1ZXirujs4lQQaB+4WPs+vuFP3Z65ylCUCIDjpxzHXTyy
         Jf5Q==
X-Gm-Message-State: AO0yUKWfyJ14lC//UsA9LgG5hGOlw6BS92za7kjT4fC3hOSXdEh66OdK
        nsTJD4uAHOAFjt8oZE+cvmo=
X-Google-Smtp-Source: AK7set93b9KqwqqM62J0DlhGRHnZZnYDPOjuVLEwX5LJ42AC3bEXCYrx2vBUX/maekAuvfP/Gvo5PQ==
X-Received: by 2002:ac2:4ac8:0:b0:4e0:2455:3ade with SMTP id m8-20020ac24ac8000000b004e024553ademr603297lfp.60.1679394268654;
        Tue, 21 Mar 2023 03:24:28 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e904c000000b00299f0194108sm2163069ljg.31.2023.03.21.03.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:24:28 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V5 3/3] nvmem: core: add support for fixed cells *layout*
Date:   Tue, 21 Mar 2023 11:24:18 +0100
Message-Id: <20230321102418.4190-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321102418.4190-1-zajec5@gmail.com>
References: <20230321102418.4190-1-zajec5@gmail.com>
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

This adds support for the "fixed-layout" NVMEM layout binding. It allows
defining NVMEM cells in a layout DT node named "nvmem-layout".

While NVMEM subsystem supports layout drivers it has been discussed that
"fixed-layout" may actually be supperted internally. It's because:
1. It's a very basic layout
2. It allows sharing code with legacy syntax parsing
3. It's safer for soc_device_match() due to -EPROBE_DEFER
4. This will make the syntax transition easier

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/core.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 212c5ba5789f..591b640f53dd 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -694,7 +694,7 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 	return 0;
 }
 
-static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
+static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np)
 {
 	struct nvmem_layout *layout = nvmem->layout;
 	struct device *dev = &nvmem->dev;
@@ -702,7 +702,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 	const __be32 *addr;
 	int len, ret;
 
-	for_each_child_of_node(dev->of_node, child) {
+	for_each_child_of_node(np, child) {
 		struct nvmem_cell_info info = {0};
 
 		addr = of_get_property(child, "reg", &len);
@@ -740,6 +740,28 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 	return 0;
 }
 
+static int nvmem_add_cells_from_legacy_of(struct nvmem_device *nvmem)
+{
+	return nvmem_add_cells_from_dt(nvmem, nvmem->dev.of_node);
+}
+
+static int nvmem_add_cells_fixed(struct nvmem_device *nvmem)
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
@@ -970,7 +992,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
-	rval = nvmem_add_cells_from_of(nvmem);
+	rval = nvmem_add_cells_from_legacy_of(nvmem);
 	if (rval)
 		goto err_remove_cells;
 
@@ -980,6 +1002,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
+	rval = nvmem_add_cells_fixed(nvmem);
+	if (rval)
+		goto err_remove_cells;
+
 	rval = nvmem_add_cells_from_layout(nvmem);
 	if (rval)
 		goto err_remove_cells;
-- 
2.34.1

