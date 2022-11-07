Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5934861F453
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiKGN3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiKGN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:29:18 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF211CB0D;
        Mon,  7 Nov 2022 05:29:05 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id d26so30036373eje.10;
        Mon, 07 Nov 2022 05:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4s/Ptq8qmBpFC+qJpngwSoeByDBagm3Zx2Ag2l+arII=;
        b=L2PeUV/vUgUVmloujR/vHOf91PEBnyAq+3zmOkc/1hunmGtWrlLICfsUgd0JwBoOUT
         bBfomTM43fmiMli/d4SrMTUHLjvFhvkyF1DF+Bw66b+QdZoHOJwJ4pIeLR/jVT7tlnii
         jU1gZJL2rRk6pTzfGaEw1Dmx4kN+yaw88/ofOkt57hseoZ7yMjh4TNuAWbhwmQ8GCCAD
         HMlgfNfW790FXoM50zTC/NTBLGefApdwayg6+JAmL6phIFVMnuwk5AQlTbZ1k3kDanhm
         5bHu9GL2FfO9hRr+XK9phvhMELcg9otEYnT0mTBj4kkBtsqN9rXK+wzYUYJpC5BP3LGs
         rBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4s/Ptq8qmBpFC+qJpngwSoeByDBagm3Zx2Ag2l+arII=;
        b=LlCfFSGoE4BWaqBZ+DKn2oaQ4PNye78Gh4e3niJ7SKSd8UHuQqMB6D8erSVD/D0UbD
         HxCvlAfgDaX0nX8JxJN00BdO9YUuyf6RZhkhLda/CD2KjluK+skiDU/bucL8Cng7KOFK
         hmO9Ouy4QAMlpfDeY+Y5TG/ODOSHLlll1nOmqtrq8gh6ndS5A3eq0EIFyBf6S8JL4lcx
         86CX5bOrtIh2Hos66Ob7fnPsgWofRuTcDIQ9+QdBxOh18nb33KrxsAKD59LHXCpSFlJi
         A8007s43AHYCQb8W8JhQmY4VRRzeVHDanyu7JuxvWpCJa1ikiGv3MllaT1ebVYXcQNjI
         nMYg==
X-Gm-Message-State: ACrzQf2bCe75t8Fpl7jXXxqiwfmkg4APsAKqMaAVwzubFBHqz7IRXKVP
        /g77w1NXwwlf1LPg+fB4Bek=
X-Google-Smtp-Source: AMsMyM4TLYEv7krxKJO9xwNS3FvCmLCYf5ofH5o7VJkH2pssMqj/zXD3EyEdd1qPST+FPuEXv2IuXg==
X-Received: by 2002:a17:906:794a:b0:7a0:72b8:2368 with SMTP id l10-20020a170906794a00b007a072b82368mr47657792ejo.601.1667827744013;
        Mon, 07 Nov 2022 05:29:04 -0800 (PST)
Received: from fedora.. (dh207-98-26.xnet.hr. [88.207.98.26])
        by smtp.googlemail.com with ESMTPSA id ky14-20020a170907778e00b0073c8d4c9f38sm3446037ejc.177.2022.11.07.05.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 05:29:03 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/3] clk: qcom: reset: support resetting multiple bits
Date:   Mon,  7 Nov 2022 14:28:59 +0100
Message-Id: <20221107132901.489240-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the support for giving the complete bitmask
in reset structure and reset operation will use this bitmask
for all reset operations.

Currently, reset structure only takes a single bit for each reset
and then calculates the bitmask by using the BIT() macro.

However, this is not sufficient anymore for newer SoC-s like IPQ8074,
IPQ6018 and more, since their networking resets require multiple bits
to be asserted in order to properly reset the HW block completely.

So, in order to allow asserting multiple bits add "bitmask" field to
qcom_reset_map, and then use that bitmask value if its populated in the
driver, if its not populated, then we just default to existing behaviour
and calculate the bitmask on the fly.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/reset.c | 4 ++--
 drivers/clk/qcom/reset.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 2a16adb572d2..0e914ec7aeae 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -30,7 +30,7 @@ qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	rst = to_qcom_reset_controller(rcdev);
 	map = &rst->reset_map[id];
-	mask = BIT(map->bit);
+	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
 	return regmap_update_bits(rst->regmap, map->reg, mask, mask);
 }
@@ -44,7 +44,7 @@ qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	rst = to_qcom_reset_controller(rcdev);
 	map = &rst->reset_map[id];
-	mask = BIT(map->bit);
+	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
 	return regmap_update_bits(rst->regmap, map->reg, mask, 0);
 }
diff --git a/drivers/clk/qcom/reset.h b/drivers/clk/qcom/reset.h
index b8c113582072..9a47c838d9b1 100644
--- a/drivers/clk/qcom/reset.h
+++ b/drivers/clk/qcom/reset.h
@@ -12,6 +12,7 @@ struct qcom_reset_map {
 	unsigned int reg;
 	u8 bit;
 	u8 udelay;
+	u32 bitmask;
 };
 
 struct regmap;
-- 
2.38.1

