Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0775EDD96
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiI1NU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiI1NUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:20:23 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777FE77EA9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:20:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u18so20305351lfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=RRNTzceZaqHDiT7tFNItA9BVbwZc1ms7T50MCemBqpU=;
        b=rVkVuZcZqaqAfme+jh1CDACtX+SwjXoV0UESeIDb/J0HFkb+9oXE7cUVeFcBaHH0Te
         6SwOKSUy0wEFq5dcEWyhMTV+e5KEjWnhA+td+2kJhcVq5gRYVtEtcgT04Fn+3TpbN4Zy
         bV42wGyJ31F/XiPJMuT74R1Q7BSb7FEcUHvPI5zrv1759dlvQ5bzIDb/oGmd0HQv2BZR
         yGLGAoKB4d1Xhz+zClWSd6vfgrFUzFEu0vMflGAFxtHtWc7g9LXdF081rrKk+WLUFqOQ
         gXKuymnh4lLO4r4ZJ0O0zKeX8f/M66/6URraNrbJA7e8ark0hpe733WKUK6vCHoysy4r
         R1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RRNTzceZaqHDiT7tFNItA9BVbwZc1ms7T50MCemBqpU=;
        b=e/RWfWfNqABDW8WB0DcIlpSWx3qGZ9Q3N7b+Yx0RTrx+9ukyz9afhmoM6wISajEfsz
         H+FgaEPoLOCh8Ie4B5MaipX+gtejw7opZQ2nBah8pEs8eJ1W01GgWEQxQpwhBcKkPzdT
         l7+y+vf6mdYTg01DCZCIPW/4TbvPBSRhDmEDj4sNr1BMnZTTrcUJiKu3NtyJmMSJKmGY
         aPFKBt3L7PNC9tppD5QicI8jn6NVbch4gTVomnXcdmBJiaxhPByOozO8LY6JyCEf+tvH
         PgNbqmld1dngOJ/2aRR3B5jBoQDLrbg1RNZlpc+mJlZtIEV2CAxJl4xbNCyCZuYwBdAD
         bRsA==
X-Gm-Message-State: ACrzQf0lOWYu/S/CVTKrwP9G7zSBV1NS0UeYD+noidGxLEb608LqF8fC
        LoDs0jatDjpG234jkNyE1RbSyutSkw97nQ==
X-Google-Smtp-Source: AMsMyM7AaHNbIOeJKncxN0eTy/GThqjSlw30ZOShYas28fF/AtZNvH2FVKtnPvrEx45dIben3y+maQ==
X-Received: by 2002:ac2:54a4:0:b0:498:f55c:7fc0 with SMTP id w4-20020ac254a4000000b00498f55c7fc0mr12420848lfk.420.1664371219806;
        Wed, 28 Sep 2022 06:20:19 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p11-20020ac246cb000000b00497ad9ae486sm478484lfo.62.2022.09.28.06.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:20:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
Subject: [PATCH 1/2] slimbus: qcom-ngd-ctrl: check for device runtime PM status during ISR
Date:   Wed, 28 Sep 2022 15:20:10 +0200
Message-Id: <20220928132011.455347-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Slimbus core interrupt is getting fired after suspend. At this point
ADSP slimbus hardware is off with gated clocks which is leading to an
unclocked access when HLOS slimbus tried to read the interrupt
status register in the ISR.

Co-developed-by: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
Signed-off-by: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index cec11aa106bf..ba36eb5c0de3 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -763,7 +763,14 @@ static irqreturn_t qcom_slim_ngd_interrupt(int irq, void *d)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = d;
 	void __iomem *base = ctrl->ngd->base;
-	u32 stat = readl(base + NGD_INT_STAT);
+	u32 stat;
+
+	if (pm_runtime_suspended(ctrl->ctrl.dev)) {
+		dev_warn_once(ctrl->dev, "Interrupt received while suspended\n");
+		return IRQ_NONE;
+	}
+
+	stat = readl(base + NGD_INT_STAT);
 
 	if ((stat & NGD_INT_MSG_BUF_CONTE) ||
 		(stat & NGD_INT_MSG_TX_INVAL) || (stat & NGD_INT_DEV_ERR) ||
-- 
2.34.1

