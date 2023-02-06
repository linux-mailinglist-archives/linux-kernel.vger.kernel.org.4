Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD868BA36
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjBFKag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjBFK3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:44 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405A219697
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id u10so5232924wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgSSD3uLqDr7SGSKLQ1i7dmWi7XiSm1LY65hwRVkN5w=;
        b=fFENw3keV/o+jIwwd3UnUip+TBBpP/Uvya7LKSwgGbZ/aMCNUrnpXpNUa3IBBDiWfv
         laTJt5bZq6c8dM9p+mDa61bGdZXvNfOJFExjhF8VtOjFlx9w6wV4GabbmAIxFn2fPy/V
         PucfwQbiBp9m+K/BSXP0ReqDANrP+aZXenxa6ipKNaxwY5ZzNSv7cLu2rkRpoY4aWEqs
         RdNRJtD6qc8AyFM76h1LapIn2XZZsfCFNrgK/m3l5XVXfaaHZ4IY/DpJ3/+CHzRsoGh7
         zUR2dFwBQHEeKPajJeKreCuAkZb3+nqUC4JhEZlOoJ5W2WsuoQ44OCoftklG5e47yKlI
         617g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgSSD3uLqDr7SGSKLQ1i7dmWi7XiSm1LY65hwRVkN5w=;
        b=VoH6vbRGbF1RIEov7rLkg5iOaehsUff8ypK55K2sFHh6n8OKzjy5mhMw5Uo3vlN1CC
         BLuWHKX9cuAWRohsOU56NZmKdn+yjp/XyWgJmC1JWiEMeBMsXDKhm2xrpsbqrVaXSzID
         UyAi8bB9RON5dQrvSDuMXtLKVbjYpoaOGYjgu2P1u8AR5epmM/st1UFrlHdZHK9hDu1a
         a2RZlricHR9l+thRrbFsnAlKX8SpsGgnYF11b1NRcCxc88XuewsjhTAVBiA5ERwU/VBx
         nKZ5Pr1LtVkFpXL48tiuw2zHLZMy481jKtv389oIV6sS8lQGZXK5MaiZ+qNK0Gnv0yHa
         Yksg==
X-Gm-Message-State: AO0yUKWcifnv5cUYlSsMjej80i6U8NXHZEx6YtM+3i6DB4iZRiy0VAKp
        qkfCDTshwkZP8PR8rhuWjRReKA==
X-Google-Smtp-Source: AK7set+EJ3AfLMOBdGvkD/j+TxqrcpJUsiJmnejUkBZkWm0tOARF5wEx72zrC6jXq8UU4LkwpFQ7VA==
X-Received: by 2002:a05:600c:348a:b0:3d1:caf1:3f56 with SMTP id a10-20020a05600c348a00b003d1caf13f56mr10574113wmq.9.1675679333828;
        Mon, 06 Feb 2023 02:28:53 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:53 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 32/37] nvmem: stm32: detect bsec pta presence for STM32MP15x
Date:   Mon,  6 Feb 2023 10:27:54 +0000
Message-Id: <20230206102759.669838-33-srinivas.kandagatla@linaro.org>
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

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

On STM32MP15x SoC, the SMC backend is optional when OP-TEE is used;
the PTA BSEC should be used as it is done on STM32MP13x platform,
but the BSEC SMC can be also used: it is a legacy mode in OP-TEE,
not recommended but used in previous OP-TEE firmware.

The presence of OP-TEE is dynamically detected in STM32MP15x device tree
and the supported NVMEM backend is dynamically detected:
- PTA with stm32_bsec_pta_find
- SMC with stm32_bsec_check

With OP-TEE but without PTA and SMC detection, the probe is deferred for
STM32MP15x devices.

On STM32MP13x platform, only the PTA is supported with cfg->ta = true
and this detection is skipped.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Reviewed-by: Etienne Carriere <etienne.carriere@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/stm32-romem.c | 38 +++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 978a63edf297..ba779e26937a 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -159,6 +159,31 @@ static int stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
 	return stm32_bsec_optee_ta_write(priv->ctx, priv->lower, offset, buf, bytes);
 }
 
+static bool stm32_bsec_smc_check(void)
+{
+	u32 val;
+	int ret;
+
+	/* check that the OP-TEE support the BSEC SMC (legacy mode) */
+	ret = stm32_bsec_smc(STM32_SMC_READ_SHADOW, 0, 0, &val);
+
+	return !ret;
+}
+
+static bool optee_presence_check(void)
+{
+	struct device_node *np;
+	bool tee_detected = false;
+
+	/* check that the OP-TEE node is present and available. */
+	np = of_find_compatible_node(NULL, NULL, "linaro,optee-tz");
+	if (np && of_device_is_available(np))
+		tee_detected = true;
+	of_node_put(np);
+
+	return tee_detected;
+}
+
 static int stm32_romem_probe(struct platform_device *pdev)
 {
 	const struct stm32_romem_cfg *cfg;
@@ -195,11 +220,16 @@ static int stm32_romem_probe(struct platform_device *pdev)
 	} else {
 		priv->cfg.size = cfg->size;
 		priv->lower = cfg->lower;
-		if (cfg->ta) {
+		if (cfg->ta || optee_presence_check()) {
 			rc = stm32_bsec_optee_ta_open(&priv->ctx);
-			/* wait for OP-TEE client driver to be up and ready */
-			if (rc)
-				return rc;
+			if (rc) {
+				/* wait for OP-TEE client driver to be up and ready */
+				if (rc == -EPROBE_DEFER)
+					return -EPROBE_DEFER;
+				/* BSEC PTA is required or SMC not supported */
+				if (cfg->ta || !stm32_bsec_smc_check())
+					return rc;
+			}
 		}
 		if (priv->ctx) {
 			rc = devm_add_action_or_reset(dev, stm32_bsec_optee_ta_close, priv->ctx);
-- 
2.25.1

