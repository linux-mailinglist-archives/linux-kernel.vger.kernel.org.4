Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6597689B81
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjBCOXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBCOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:23:20 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB5017CD3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:23:15 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bk15so15729671ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 06:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrpekdfBnuZdpOMig/MdY4DX2twN+6+zh9yRntM5/rg=;
        b=ek1gBgVXY2mwhavFpt5kt9wRzQn/Jkvjf0TasZj3tdIHZT+aXjKjPFLcyjxX1BB9Xj
         +VWhxWfIAPMjM6C8PYaIFTOa79HONL+vc/C5TyubDcazVPx/nb6unz6nhiPtC4NVKd0t
         RPL1+yoYjMbIkxucAJlL1YRLUSqV+MizTwtnrUmI+GginMkTKJnnqwdQXBDzNUeVhni4
         pO4gUJdH9E0L8wY2t60tyzh4yCqOIBVjrzM1KhYdJ0hU4R/SZv3MBZzLAO3eHvcTfllj
         4qzIFB23AaHiTWT8RUcjdf6FHe9Y6QYYOai82J8+Qfxw0VYNZI3a5N0bTAWyOqyn4lcV
         koLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrpekdfBnuZdpOMig/MdY4DX2twN+6+zh9yRntM5/rg=;
        b=JMcnsf8XH7Emb1YHAjqjRjNZzcTRecGCVeSUWJVDXNE5WQmfvhM2+uBbwayu5ZqCkS
         7HjZn9C/mQMIVJ0GN5A69mLBOTLczXvcGwBk2wRHNr0nH5QkJF1IhQsWr6wA8vUa4R9o
         Dda0wCJLLP7vyx7Dz7bqWYY+0k7bTzyC48PlIRoT73myokgUiFEts61Sb9/kq3gpvybt
         lHWZohKSEtAMueQetESfNMQFdMQEi+E8WMCbWC2ldzVt0PKe3KrPOdfILWZWFeOpveHi
         u9xla7mvx8rh6JBq/FBXxmyReqZ1GEm6EhrXqRhBgqVw3RVSRcqCWq27A9VoERRjfvpK
         Hfwg==
X-Gm-Message-State: AO0yUKXg6HkcvAGde/v5UQfAc5aSJ4Db0xcQ7pjhvKzkGH4JXJ2hgqPL
        HLF8J0KdltWifk/+9ztzuTvkNQ==
X-Google-Smtp-Source: AK7set/vS8Zwf2QJYKpOKaAw9XVXRWcYCx/Ya9PjzC8Xa1zWhjudq/NNa+/hUOCtjyMtVxiFZWZbQw==
X-Received: by 2002:a17:906:135a:b0:881:d1ad:1640 with SMTP id x26-20020a170906135a00b00881d1ad1640mr10198956ejb.57.1675434194035;
        Fri, 03 Feb 2023 06:23:14 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id h10-20020a1709070b0a00b0087758f5ecd1sm1415008ejl.194.2023.02.03.06.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 06:23:13 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm8450-nagara: Correct firmware paths
Date:   Fri,  3 Feb 2023 15:23:09 +0100
Message-Id: <20230203142309.1106349-1-konrad.dybcio@linaro.org>
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

Nagara is definitely not SM8350, fix it!

Fixes: c53532f7825c ("arm64: dts: qcom: pdx223: correct firmware paths")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index 68d15f7651f3..d503899f3947 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -891,17 +891,17 @@ &pon_resin {
 };
 
 &remoteproc_adsp {
-	firmware-name = "qcom/sm8350/Sony/nagara/adsp.mbn";
+	firmware-name = "qcom/sm8450/Sony/nagara/adsp.mbn";
 	status = "okay";
 };
 
 &remoteproc_cdsp {
-	firmware-name = "qcom/sm8350/Sony/nagara/cdsp.mbn";
+	firmware-name = "qcom/sm8450/Sony/nagara/cdsp.mbn";
 	status = "okay";
 };
 
 &remoteproc_slpi {
-	firmware-name = "qcom/sm8350/Sony/nagara/slpi.mbn";
+	firmware-name = "qcom/sm8450/Sony/nagara/slpi.mbn";
 	status = "okay";
 };
 
-- 
2.39.1

