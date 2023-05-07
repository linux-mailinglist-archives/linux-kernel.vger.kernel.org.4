Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1266F9904
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjEGOs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjEGOsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:48:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C484918146
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 07:48:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so5421055a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683470900; x=1686062900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QNL3G/zxSdZ+IvZ1XOfmqIgPpnWosZByJqwjHAEj6R4=;
        b=kP5r1EYAU+Scv98scofN1apJWRF5MqDhL5gWvbtaCxQdQeXv2g0RbB/tDd3IgrjHBS
         A7DtU7kEPnIw9gSV0X/oCzGGxq2Y85xjBka/zC5nthJ54wq9/IdE5dlCUswDoyoKebln
         ypTwJ13SnJlbAHZZTkf6+1VJTa/8beRpZd2P9dR+1Rbbr6jQLyxiciiGOJMjUCJze6i0
         ruNEKncCHZDzGsy2rDT9r1wygasmtBozUEHBVjJR2DdZGHcQBTvqsc5CdfR/uZRvVZ2A
         WzsADWwRBKvK0gzEQqYnxpd6LOUETYVfrK4Hwr24d4fZqkS85LEv2jqkpkxTdTuGkKOX
         TSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683470900; x=1686062900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNL3G/zxSdZ+IvZ1XOfmqIgPpnWosZByJqwjHAEj6R4=;
        b=lFp2G5GJbror8DMU3+FNEl/kdjnrG804K8iCEsEpkVdV0YOlz8TzUUfnki5OAhZABQ
         HdpZQwF6KCLfFcGgSqB7xYxBrnggCvTzgFs1XJPuiGf1d0016nlfnmV3NSr46iyAUxAB
         c5gTd8XnaZ/1ZmhPtJi6KZbkZp74QDQIOedDxti5cON0EAbD6dXXH79J7CKlEFafBwge
         mfz2Ny15s66EDkb7Vxxi7utIaYRsV9RYKGZOcwndD/9UHaMD5hLq5mqFlcwwsO6rzOb2
         ngMCg30pZ+1i8AVkqLsb3SBmtGI295uJrLT3Sc1UGrHsrpYML6qh9tQTdZIsBCSAovxL
         l0uA==
X-Gm-Message-State: AC+VfDwy902xupz5sIBYjq+P6OQhPJrsADPy9AkOcxazx+qevduToE+s
        ApXKtbL1dRO4Jy3k8ZqWS1hZ6xMEx+08AmZj3f106Q==
X-Google-Smtp-Source: ACHHUZ412dZZ69NMaMdAVVC/Kr8y7ymxj5N27OqooAVSH+e0ZyzqbU3bA+hcjnoiYD9ORaKf7TaPLQ==
X-Received: by 2002:aa7:d901:0:b0:50b:d1a6:116a with SMTP id a1-20020aa7d901000000b0050bd1a6116amr6338818edr.32.1683470900249;
        Sun, 07 May 2023 07:48:20 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:1757:b51a:9965:e81])
        by smtp.gmail.com with ESMTPSA id y21-20020aa7ccd5000000b00506a09795e6sm5026724edt.26.2023.05.07.07.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 07:48:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] phy: qcom-snps: correct struct qcom_snps_hsphy kerneldoc
Date:   Sun,  7 May 2023 16:48:18 +0200
Message-Id: <20230507144818.193039-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update kerneldoc of struct qcom_snps_hsphy to fix:

  drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c:135: warning: Function parameter or member 'update_seq_cfg' not described in 'qcom_snps_hsphy'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index a59063596214..6c237f3cc66d 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -115,11 +115,11 @@ struct phy_override_seq {
  *
  * @cfg_ahb_clk: AHB2PHY interface clock
  * @ref_clk: phy reference clock
- * @iface_clk: phy interface clock
  * @phy_reset: phy reset control
  * @vregs: regulator supplies bulk data
  * @phy_initialized: if PHY has been initialized correctly
  * @mode: contains the current mode the PHY is in
+ * @update_seq_cfg: tuning parameters for phy init
  */
 struct qcom_snps_hsphy {
 	struct phy *phy;
-- 
2.34.1

