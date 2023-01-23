Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8289678730
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjAWUGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjAWUGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:06:00 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5210F0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:05:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x10so15964836edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5MC6KGc3cRiZF9BcIVjcLfOK28zR5T5Wv5X79abU14w=;
        b=huNXA4bfb5melawHGwOTU1BeN6ATBg/ACreBHcGB3M6Ro+YxvIJLEIhFKVsQSu8ODN
         XgzMz6yYFq9je3iV0dpeVQHyyklZJX7NBNzGVg16Kjc9D/McZrKz0xYjezIwf872RTWy
         ku4pAxm43upIiMMJI554Dls8jmbviWVHSpXmS0+3tLvBGogsOCVUXFXnAAFzL8r/kjvg
         uIvH8SS/QsVGvaDcU6AFJiOTCwOSPque/ZTmp69WTwi6zWpe23E5vJvYQ8MJ/ITVzOs7
         mbpr/9IoHlMgpVusBg0LiZMzY0Nfb9+jlnF1zed5XdVeafN9mLYIFJ5V6G4TxzpwoBr0
         Zx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MC6KGc3cRiZF9BcIVjcLfOK28zR5T5Wv5X79abU14w=;
        b=Ub57KF2ffupmErY+DlQ/Ntv5I4c8s3KHYz9Ot7TOfKNuqqYYLbqxNSjFeG4088XeEO
         jJdBCYr80RMXKinzHT7MQlUm0qZ94HKvfmdiWykjaOOHR/3ek8cuJ/F/L8XSJfsuoYdK
         0SIaGjoPHfU1sUOO+EiPmqJhskmAcejg+ECfYxHqbSyL3zjA/P599hVEwvPsWcIQRd50
         jHdesJ7KtQVtxDTLnzV7soOAqoJ90fQu5xUtQGel7f2W/pwoDoE8ujGI9zzaZsGCBkFp
         aLwtCh+7CKKlndJC7ezvJF83eclH5uvKd+9jFs54XK1gQTLxaHiFIXxygNhaL3+YuGSg
         iIjA==
X-Gm-Message-State: AFqh2koi8RhWTE8H9wTd/96Dmo4n1mKOtvbRoca9dnMnJYCb3oP+ZWxC
        uvvgJbk4zEzCPX9oIZUDJLKuuzrqA6cYePye
X-Google-Smtp-Source: AMrXdXsHfZHaGMQ/BCp8uUyimW37lMTfF3CI256IDoEWA98mNXMTJ4DB2O4dsnEwNGZprTWa37Ymcg==
X-Received: by 2002:a05:6402:2207:b0:49d:f444:ed04 with SMTP id cq7-20020a056402220700b0049df444ed04mr23903120edb.17.1674504357472;
        Mon, 23 Jan 2023 12:05:57 -0800 (PST)
Received: from localhost.localdomain (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id cq9-20020a056402220900b004610899742asm146081edb.13.2023.01.23.12.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:05:57 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm8450: Fix DSIn PHY compatible
Date:   Mon, 23 Jan 2023 21:05:52 +0100
Message-Id: <20230123200552.553181-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

Use the correct compatible so that the driver can probe properly.

Fixes: a6dd1206e45a ("arm64: dts: qcom: sm8450: add display hardware devices")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d66dcd8fe61f..8d85a3139849 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2873,7 +2873,7 @@ opp-358000000 {
 			};
 
 			mdss_dsi0_phy: phy@ae94400 {
-				compatible = "qcom,dsi-phy-5nm-8450";
+				compatible = "qcom,sm8450-dsi-phy-5nm";
 				reg = <0 0x0ae94400 0 0x200>,
 				      <0 0x0ae94600 0 0x280>,
 				      <0 0x0ae94900 0 0x260>;
@@ -2946,7 +2946,7 @@ mdss_dsi1_out: endpoint {
 			};
 
 			mdss_dsi1_phy: phy@ae96400 {
-				compatible = "qcom,dsi-phy-5nm-8450";
+				compatible = "qcom,sm8450-dsi-phy-5nm";
 				reg = <0 0x0ae96400 0 0x200>,
 				      <0 0x0ae96600 0 0x280>,
 				      <0 0x0ae96900 0 0x260>;
-- 
2.39.1

