Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E7B72B23F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjFKOGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbjFKOFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:05:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3123C15
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so24077795e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492257; x=1689084257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aDJD561UaoCOC9DP1D2+rVxWk6+oNUTudG6ggpWLDg=;
        b=JYbgEpVSgCJxyGfeBIfD9NEB1OsR4pyKgBVCZcbV2FFt3f3NKXGrO8vIc5hODNO1qx
         2XYIHq+bMZ/Sc/Eu6UV/Tn1xTu2K+3TVbDX6BqNSIi1tq0iBuglbWavPiyxXUyhO/jh2
         RqPfBcqaiqRu3pbJ3zPb6fNg3pnmInNx/hkUoAmKTCCAYX1iz3pADu9yT/0nlXEjgjN+
         T0LdQ1ka2XyrmNq58N1kCLZm3Qu06Z9qKr78JYI2JiRJ3kHotkwacI28rY9eOhEneEsz
         VgI7+LsgjgTNSnLzHTcTtIY7sosgjU6WcLujA7GHaUO4ZCUTYNQ35b8hAiRTZMFOPUF0
         4T2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492257; x=1689084257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aDJD561UaoCOC9DP1D2+rVxWk6+oNUTudG6ggpWLDg=;
        b=M61vuAnpjiveiO2k/fr7/E5k607nivqnMfeIVM9N9Oa8uEqqRxM/74URwGPhmMESea
         4/K8dzAnfuW8AjcBnzz8a6+oTONzQQf5DWlOLmhh2whx7bgj3WRkK8QSYq8UhINZ/nsi
         CMdvEMCd8J4uV2i/ZaUX8JF5lN05XaRcpYivlscMYY0XloA3AcBzyIvZX4RAIVbFUPAz
         CoXlGrYzqmFtq6WUJ08etEZUjHcACMcwqandLaWITL3Kh2qLFNwtyGH24Oitf4NKi5DY
         aXOW6bQXf1VKm2k8CHneSgwL4hqPWY7AxSUhAXjCddcF8h6K31IC05HMpnkVdEN+dJQn
         IkMw==
X-Gm-Message-State: AC+VfDw4xf74F2FjzvYxWEaveTsIR0YPNVjve1O4rL/l+H+z9Ikh7Uzq
        x9j4AHZ4mTsYl4Y4kTeRmB8+IIkdL4Ao1X84u4k=
X-Google-Smtp-Source: ACHHUZ7IQ9/318S/+6UqK7FF15rLnL3swCRNperveyJXz+Tgrnz547jADPJDK0hzPEvJWbiOzv43EQ==
X-Received: by 2002:a1c:4c15:0:b0:3f1:70a2:ceb5 with SMTP id z21-20020a1c4c15000000b003f170a2ceb5mr4302810wmf.13.1686492257736;
        Sun, 11 Jun 2023 07:04:17 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:17 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 25/26] nvmem: core: add support for fixed cells *layout*
Date:   Sun, 11 Jun 2023 15:03:29 +0100
Message-Id: <20230611140330.154222-26-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 342cd380b420..3f8c7718412b 100644
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
2.25.1

