Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085BA62EDEC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbiKRGwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbiKRGwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:52:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B513520BCD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:40 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id x5so3735265wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAzXZzO+yszcBqWvLdE5BOhfmNlhU/EX4tpKB13mknE=;
        b=LbCQHzP7ipavjxmzgE07LxC+8U+AXksWXXFgTY9RGwcI45LWjyeP8rvXW/9l58pcHJ
         yLyx8xV4GR/LvDC5wE2P8R9votR8d147n3VWnCyy/38allY4Rx9z+E8fRqW+f+vts3kM
         u3TuQ6pzpNP2Y1nQq7QwfGwdI+Eb44hozZmpPX45PqqCM0qvtdiMtlCZJcF/CPHg4mQF
         LKII9InjFT4LEf7rPHP+yRwUT+17diLf/Uzq9nZvRRKA65p2fZ7ocqWtizhMcMPF4Lmw
         zhWNlbmVAvKfunCEoFhfuJVlgAuOhYa8Jj48Yj6dcvWxpyhy7Ym5XJEEfHATjFPxGpww
         tMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAzXZzO+yszcBqWvLdE5BOhfmNlhU/EX4tpKB13mknE=;
        b=5wHPoRSgOpfyj0N+wvdIyHsevVrAoPToBZsucdg9sfPHlaeul2gvVeuIrdyNaDzpES
         egterWYNFgauvSRLNvvjHwR9l7EYfRlm6vF5tcsDGPRIBLy52aGILZjcezzqCdeYkClY
         P6uD5hBOj99NhmPNSrzokHisQ67stdb3BH4SYp3g/MYsgNYJWr8gNKGfbvchJn7CZfhk
         80TPE/+h1bixpXFr78TZMnFpnkkmVIpxm/yipSWszPpQysGpxfEfn64c40O6hClmMtte
         Xnf2SazwTzsUC/I3ri+aTrBJSvf4Zaiej9p2D7Tk3XoSelNkiOS/xyuMyIsqoWK0A+Nn
         bMqA==
X-Gm-Message-State: ANoB5pmNNQ/YQBGeRe9aB3y6NMj+JFM23Vn3pgZCvZXjj4jSFYh/4rrR
        nce8fs2m+nlJ1RbGeI5IB0yL/g==
X-Google-Smtp-Source: AA0mqf6GXGEIIYvm3UsMCu0eNo6pjIlpURQ9tOn/dKiMYd7qXdvaen0OUnzqy5b6ZxnJyixQfaC9gg==
X-Received: by 2002:a05:6000:258:b0:236:74c5:7e2 with SMTP id m24-20020a056000025800b0023674c507e2mr3357423wrz.3.1668754359274;
        Thu, 17 Nov 2022 22:52:39 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003c5571c27a1sm4400165wmo.32.2022.11.17.22.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:52:38 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Zheng Bin <zhengbin13@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] slimbus: qcom-ngd: Fix build error when CONFIG_SLIM_QCOM_NGD_CTRL=y && CONFIG_QCOM_RPROC_COMMON=m
Date:   Fri, 18 Nov 2022 06:52:27 +0000
Message-Id: <20221118065228.6773-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118065228.6773-1-srinivas.kandagatla@linaro.org>
References: <20221118065228.6773-1-srinivas.kandagatla@linaro.org>
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

From: Zheng Bin <zhengbin13@huawei.com>

If CONFIG_SLIM_QCOM_NGD_CTRL=y, CONFIG_QCOM_RPROC_COMMON=m, COMPILE_TEST=y,
bulding fails:

drivers/slimbus/qcom-ngd-ctrl.o: In function `qcom_slim_ngd_ctrl_probe':
qcom-ngd-ctrl.c:(.text+0x330): undefined reference to `qcom_register_ssr_notifier'
qcom-ngd-ctrl.c:(.text+0x5fc): undefined reference to `qcom_unregister_ssr_notifier'
drivers/slimbus/qcom-ngd-ctrl.o: In function `qcom_slim_ngd_remove':
qcom-ngd-ctrl.c:(.text+0x90c): undefined reference to `qcom_unregister_ssr_notifier'

Make SLIM_QCOM_NGD_CTRL depends on QCOM_RPROC_COMMON || (COMPILE_TEST && !QCOM_RPROC_COMMON) to fix this.

Fixes: e291691c6977 ("slimbus: qcom-ngd-ctrl: allow compile testing without QCOM_RPROC_COMMON")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 2ed821f75816..a0fdf9d792cb 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -23,7 +23,7 @@ config SLIM_QCOM_CTRL
 config SLIM_QCOM_NGD_CTRL
 	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
 	depends on HAS_IOMEM && DMA_ENGINE && NET
-	depends on QCOM_RPROC_COMMON || COMPILE_TEST
+	depends on QCOM_RPROC_COMMON || (COMPILE_TEST && !QCOM_RPROC_COMMON)
 	depends on ARCH_QCOM || COMPILE_TEST
 	select QCOM_QMI_HELPERS
 	select QCOM_PDR_HELPERS
-- 
2.25.1

