Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487F667E30A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjA0LTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjA0LS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCD5820D5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:23 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b7so4678577wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgSSD3uLqDr7SGSKLQ1i7dmWi7XiSm1LY65hwRVkN5w=;
        b=BFgvAPrL0k1hXojloExewzlBKb1DVKu31ibVn1znitxflx4cMuxLDS6GWsVX2OLK2H
         VhD2ZVGg7vFN8ijiGZi1CGde7f2sjnFMjG2ljcRYzCABS1GCuzqBA/lOJiEowJoOHE3m
         1xL7BJmbMJHJDpH7UEesTCyinqEt3yp2Ch5tXuikv7iq12i2/dVCNmGSJ6MMi4ZMJfKT
         X8I+oyhEcXWR/LsjbOrmMmmeXeMUI36kPOdp755ltBbaEJhoaI2SchGYBgRbrRQSqpQc
         QkF6emgWknnz+Z7K+1c+bdilsJ3xHzGgp48N1P0GU14My3pQ8G9oNSTUPkqd/PPXnHIp
         K0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgSSD3uLqDr7SGSKLQ1i7dmWi7XiSm1LY65hwRVkN5w=;
        b=pbo6bhnJGxUIPl2d64vwST6RtF996FNde77tXlj8V13nWopiPoUP1qgZQzSomliBih
         vH5AH9lcvId+YaxxfvCLZVhq1rgafEQkG74GWDjje8QhyARP3dpRXpL6Ip2SoU3AL+RF
         iRXYn+rdxlHnBo5kATomSiUN3g07EvtdhX9KNLRbZGbaQrATTC3YtGxbC17WjkYIWQJ0
         GixjLT/W/7pFESLXO9pdOld0YUdqNOnbJQV8GUQMiIeat6EA2azn/2beNDbzTDMNH9z0
         Y7D397WXHycLHKR/xbDp9nKH+ai745lY1v/F4VdBFgACkTXmMswaJecYaZtRPgx6RJPe
         47rA==
X-Gm-Message-State: AFqh2kq85180XxyEWzIyyd5+TgzSxmayWcZa+ALG8LezsxABVJAAh5ea
        xOmf+iVEVz5ji8fILJ6vmNMTNk454rJZSNqa
X-Google-Smtp-Source: AMrXdXuy1iy+vhbbeeFexkzejJxxRDe0vD25bZvmzZEFO7c4Cyv+ahY/EWQ8SFFz/yaAY5Z15zKaeA==
X-Received: by 2002:a5d:4c4e:0:b0:2bb:4b40:2d1a with SMTP id n14-20020a5d4c4e000000b002bb4b402d1amr35278751wrt.56.1674818303277;
        Fri, 27 Jan 2023 03:18:23 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:22 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 32/37] nvmem: stm32: detect bsec pta presence for STM32MP15x
Date:   Fri, 27 Jan 2023 11:16:00 +0000
Message-Id: <20230127111605.25958-33-srinivas.kandagatla@linaro.org>
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

