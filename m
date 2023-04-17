Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8C86E4967
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjDQNIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjDQNH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:07:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45860B47A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:06:03 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f167d293c7so9003135e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681736725; x=1684328725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+pN7CHTmhcpk+kvQFe2Qj4nSZeBGIjHXqqKasTb6lhk=;
        b=Bgg3k2q1I4LWyoS114Sz0KymTKA2sEwO4Aef31BG8tNohuz0BdZB2B6nEsGZrY1GEo
         wOL+m/NcuDjyrWBSVrXOiH+20/n5djMM3Dj1qAOIbHSAXzClWaMolmUBcuAsxBtLFHk4
         HfxfOH2gCCClo5PVsp5KjDQEOY9g6s6MYLKtYEtkXErOp5Hxzh7wj5jce0B1LY4YewB+
         eE2pEIyZuyiVlWF7hMpadTMqa+h7dYLiQ/adwFBbZdTwXXm+6wt4KdRNMGo4T8XyxzPG
         gk8CmhFlPuxt4gFWkzqSI0ID94xRb4AU70e6df5XjkEEnTizT1/rtIICx00xrshMzWfP
         0ySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681736725; x=1684328725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pN7CHTmhcpk+kvQFe2Qj4nSZeBGIjHXqqKasTb6lhk=;
        b=VAvZku/lRbmnXvHu89Db2cGZY2n8sMugtsX3aiq4gqhgtA0vJysQyUySaqIqNg6AVc
         b5eUuVK8HRFCLyEZUSixQSYQ9elPD951YcO0vZSOmem7tLmpO05PgsDifel6147b+ByZ
         7xlmwydBgPLDKG2IELL7v/gRn7pTIfq3r5eMnHl2a24OAa8wFtzLnTUva6xTYwexVtvW
         HbeKbc2fo/l7E8omxnGZ6kaQaOrhWmdVnx71x/7WrfIxiEdL74zm+/t53HSshHmmSSbC
         IzXktcy13RkfN9nCPURyXbG36DGz5bFLAK5WTzqVNhaI580aeHR/Oh2J36eUL3GyOjVh
         NrZQ==
X-Gm-Message-State: AAQBX9fri9QvPblngcEas+8dI8UwygNuELEpKnBvv7fjk3IHTDisKzKD
        EhLwI/W2UU8AJ5KAvaTrKD4hFQ==
X-Google-Smtp-Source: AKy350Ya7/njYFXhgTJTc7VF5jmgWE3WlJqHe1HiKD8ysBAxGWWzpzzvX4+3LSjuaxGp4l/qwi72Uw==
X-Received: by 2002:a5d:4576:0:b0:2f2:501b:bca6 with SMTP id a22-20020a5d4576000000b002f2501bbca6mr6649069wrc.17.1681736725582;
        Mon, 17 Apr 2023 06:05:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:374a:ffae:fd26:4893])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600000ce00b002f0075ccf7bsm10509938wrx.71.2023.04.17.06.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 06:05:25 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] dt-bindings: phy: qmp-ufs: fix clock and clock-names for sa8775p
Date:   Mon, 17 Apr 2023 15:05:22 +0200
Message-Id: <20230417130522.401605-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We must set *minItems* to 3, not maxItems as this platform requires
exactly three clocks and maxItems is already set to 3 globally.

Fixes: e5796a9cdf73 ("dt-bindings: phy: qmp-ufs: describe the UFS PHY for sa8775p")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 94c0fab065a8..a1897a7606df 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -78,9 +78,9 @@ allOf:
     then:
       properties:
         clocks:
-          maxItems: 3
+          minItems: 3
         clock-names:
-          maxItems: 3
+          minItems: 3
     else:
       properties:
         clocks:
-- 
2.37.2

