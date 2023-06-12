Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF7872BCBB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjFLJcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjFLJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:31:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D94199B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:25:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso29775935e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686561900; x=1689153900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4hcroDV0hdKX/DQDft+g0yZ5ckCppngKltjTy4swGs=;
        b=MAMjiLP/Ub2YMkZrYMQu9I+vzT6+M/KG3XopFjXfiAgrNHxfkR1XAmH5b8FPhTzsfl
         AqRdT7fKsLe1LsAM2ySEpkmdoZpmATyl8UlCZdD0WerCqDDnXfaLcu9TW+BsqAjtpDP3
         h4Y8lowLuAZMm8+6vaV2+O5tZ4JOtojf9TOohwrc3VXLVH0Lp62NqHuEEzvSQ7XMsIgJ
         FjwcfKOhlAEOQ+sWQqGMbhR8naVGQyOA17XnUN5/G+unqZS2uYPEfzRepIdPMJ3pNCJT
         C2VSAmBfiHnpDcna93MrdqjGaOpKmOoY5f4NTJ2Krkj/Qavu3TIAsxqxZqX2d9tNvUnX
         YUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561900; x=1689153900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4hcroDV0hdKX/DQDft+g0yZ5ckCppngKltjTy4swGs=;
        b=QWm0pwBdK6FUcHyjmgAlWSX/nStBj2abHIb4tTrNYN3fDtX8Bh77VKGgohC/4gNolQ
         dzvFtZiHNIybFigy3UMxlCUY/UioeBmiAMi6X+Uy0CyVUme7fUf9KlMXnkIzSuTTbWl/
         wPt04RWmjmWpKkpaRJq0KGy+/worKM0wICknpP8rMkiwWLT/3Q/8Q32tgIZPfjfcJGCh
         9kJkiLuRVPi+B+hfeOO5+I4C5kFHparcRUhX8OsrwGlXnOuIYwY3zPUJ+87U9x5acGAY
         ix1Lq7vGGP/2wqx/bvDxhOxvTGO+umjXgCZ5qmC/TAkAhl7e93HqLsHw1EZUvc1+8432
         hX1A==
X-Gm-Message-State: AC+VfDz6gRtXthJyu0JiS8MWGreelsYP8cSSZOvhfgcSG3ZBmmqfy1cj
        pfGRK9kt1Cf8P5TaBQ9XQbRjrA==
X-Google-Smtp-Source: ACHHUZ61vW/FRawgaaHnvQGC2M+qoPMGa2BJ9bPXYYT98KJ/c8JNEM8dFY2uCnSfW5vwruY6E+eizg==
X-Received: by 2002:a7b:c047:0:b0:3f8:1b55:ac08 with SMTP id u7-20020a7bc047000000b003f81b55ac08mr1200775wmc.28.1686561900531;
        Mon, 12 Jun 2023 02:25:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a222:bbe9:c688:33ae])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f727764b10sm10892044wma.4.2023.06.12.02.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:25:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 24/26] arm64: dts: qcom: sa8775p-ride: enable the SerDes PHY
Date:   Mon, 12 Jun 2023 11:23:53 +0200
Message-Id: <20230612092355.87937-25-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612092355.87937-1-brgl@bgdev.pl>
References: <20230612092355.87937-1-brgl@bgdev.pl>
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

Enable the internal PHY on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index ab767cfa51ff..7754788ea775 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -355,6 +355,10 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&serdes_phy {
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32764>;
 };
-- 
2.39.2

