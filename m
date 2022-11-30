Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A52463E176
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiK3UMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiK3ULU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:11:20 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B24F99F19;
        Wed, 30 Nov 2022 12:10:14 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id d3so22188784ljl.1;
        Wed, 30 Nov 2022 12:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiwkmaUk+kjHEaXyaNwbQEqrPkyA7kZAaaBGjnhG2Z8=;
        b=oWRD1+WUXaaxMS5Mg/1rdrbTt8T2V+mdEPBWLT3DExbd71SkO5nzdxGM3PGNxuLF8i
         9n9+7oEnRsw3840Vw2qEDBHGOfiL6vG94R3YhmB2IcEesj6Of7wcSR0AqOplJy7ON7tp
         Zwh/f6efCKHmGMqxaWYRnWoEaIgA6v36Cpc2j5mgoP7Z4C+to6ZYLQNoZVfTZudO1M9M
         kesLWt97H9oeOH8sngOs02k49FZ9fTGzT91FWBC8Lk1hij2gnJZAg3Q88vN2y/IE5Fcr
         hOLH7YADsyu8aOAYNBRq8/roA1a2oLmcG5G6hwf+HIo2l7QVMJMo8zW1qQrntVPR5a6o
         V5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiwkmaUk+kjHEaXyaNwbQEqrPkyA7kZAaaBGjnhG2Z8=;
        b=JKNzJYYll5gug//evC4IA3AmVWIXdVLM9H7o0D2bwHUS/ZXPYY948TStgDaKK7MVk5
         J0HObHQrcU/wmEHX1GNJjQwVQEu5aQvLp5/w3y2PLx5RvMYIOXa9LMKFl0Rjuwbr9bOM
         wsxBENiyiKN+47MMRntco/nXHbLd5h/XY4DV/jpaJxGiqehomzSTTng3I1CHXJCtEIiJ
         17FWAKIl21f211H0wbimepQ2luYFgyBWTC0HQZbVpPYwoRKHcwgmDOjfWDqNaIOehx9M
         yj439YDajIxgzdSqu5IBkrzOhR/7Lv0/TK7JPi2mH9/BerwJuTwj2hETPuoENZ2yiL8U
         RySA==
X-Gm-Message-State: ANoB5pnHzmoPk87p62bOcGDJSofZZagk2wooepATA7kRn5x90dI5rsNe
        xfrwjZY2KkRNz0BmSUqhlTlYJ07DB8A=
X-Google-Smtp-Source: AA0mqf7H8jFJmIp9vGhj3Np3GgraaEdLHNj5o6/9BuD0+raVoHuCn9Fl71toHFP3Ere3LMIP9RxUNA==
X-Received: by 2002:a05:651c:198f:b0:277:6a5:109b with SMTP id bx15-20020a05651c198f00b0027706a5109bmr16196943ljb.42.1669839009907;
        Wed, 30 Nov 2022 12:10:09 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b004b4e9580b1asm369754lfb.66.2022.11.30.12.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:10:09 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 06/12] arm64: dts: qcom: sm6115: Add rpm-stats node
Date:   Wed, 30 Nov 2022 21:09:44 +0100
Message-Id: <20221130200950.144618-7-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200950.144618-1-a39.skl@gmail.com>
References: <20221130200950.144618-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rpm stats node.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 6f4c36f3da40..d0928f19965f 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -546,6 +546,11 @@ rpm_msg_ram: sram@45f0000 {
 			reg = <0x045f0000 0x7000>;
 		};
 
+		sram@4690000 {
+			compatible = "qcom,rpm-stats";
+			reg = <0x04690000 0x10000>;
+		};
+
 		sdhc_1: mmc@4744000 {
 			compatible = "qcom,sm6115-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x04744000 0x1000>, <0x04745000 0x1000>, <0x04748000 0x8000>;
-- 
2.25.1

