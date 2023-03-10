Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2AF6B53A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjCJWAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjCJV7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:59:52 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86E814B00A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:56:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l25so6333867wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678485384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6R58u+pco5SwiyuNgUjgOgUh5UTBCxq4L8biqsKSRA=;
        b=mWS+4qFcBmAUsvwKvaxCkq2NVC0Zf4njkBgPVEoE0t3ffHs3o5LpuB7FxiNZqwinFM
         7TwUsQurrmEdhhe9PNAvWK2Sx81SekYyWlekDo4bxQhB0+77vVV1clOmvkrKdEKW81h8
         9KuonJXOJM5ivmun15KOvkIShxsUmHwz+SIGj1x/0YP74vAER5arvPnzuMY/dnylA1L0
         I9S+6iaDhXNiDGMBQDMiEap571OBIzW+mvvteeK7ymL0veN02sW6m+veBJkOL+jPu5En
         Z6sPZs+4XEwRMbMY06dWvoK6YlsoYb1cmz6WPB89+FI1D31FjmUYXt/Y/v/w8e6t40O+
         KEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678485384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6R58u+pco5SwiyuNgUjgOgUh5UTBCxq4L8biqsKSRA=;
        b=PNrz5D/ZNX8TjUqYNUVwSI7rs3qBh4gYDOTJuOvFrhC5v3v9UL4lbdzNKRn/kxasMU
         W2KZbTIz/sQP2Cbmr8zII4rz1UZJJGpcQkYoU703yYzdhhavbfkpUcCIh+Myv7aaLtY6
         3f8ZiXj1CLnrvxd1qau9fM3ZhcceBRH+hC7zXDNXSk4c5IhOUBlVMPcrWHu3Yi3q6T2S
         i2bxP452hWqAuGN0rhqa9mgxZCdxrTcbcQTx8N72/B1z4DJetSTJ8xSny3Xlla4+YCmA
         BEeN8FXIfApG+Q/u8Ck652xBP0lKmms79nZZ2Kx0QJUEbUiUj3+BneEMO/jQupYLahr4
         oGPw==
X-Gm-Message-State: AO0yUKXd0UH0oXk2XPX0aHmKE+0J+c/ZVqM8o8prBNMJ4pL1c9T6zSVw
        L8Te9fBBB3kkaPjMeMNQIVzNlRQg3dzoIjMh/H4=
X-Google-Smtp-Source: AK7set+FDz8JZEWAMgcBwbvkCP7C1J/GKrOFdld1I4i17Xvc2r83YnSVN8MhDyC9T68rpj0eW9DONA==
X-Received: by 2002:aa7:c2d1:0:b0:4ca:4a5:91bb with SMTP id m17-20020aa7c2d1000000b004ca04a591bbmr26053986edp.13.1678484764382;
        Fri, 10 Mar 2023 13:46:04 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id u7-20020a50d507000000b004be11e97ca2sm471873edi.90.2023.03.10.13.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:46:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/9] regulator: rpi-panel-attiny: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 22:45:51 +0100
Message-Id: <20230310214553.275450-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
References: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  drivers/regulator/rpi-panel-attiny-regulator.c:390:34: error: ‘attiny_dt_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/rpi-panel-attiny-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index 34514976475e..3953fc1f389f 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -396,7 +396,7 @@ MODULE_DEVICE_TABLE(of, attiny_dt_ids);
 static struct i2c_driver attiny_regulator_driver = {
 	.driver = {
 		.name = "rpi_touchscreen_attiny",
-		.of_match_table = of_match_ptr(attiny_dt_ids),
+		.of_match_table = attiny_dt_ids,
 	},
 	.probe_new = attiny_i2c_probe,
 	.remove	= attiny_i2c_remove,
-- 
2.34.1

