Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D740E73A073
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjFVMC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjFVMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:02:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4051FFD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:02:04 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b4790ff688so68517821fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687435315; x=1690027315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1Al/KG8NWTXmmsHWuavPIHFHpGDFDNwIi35fFm7FN0=;
        b=U9P0aS+UztwhUk4ABb5ZDvNcBVmCIgBCsV8VfNfDtitYmRWYQET7J5c0DFMOw+d7dZ
         zvTNvXhuxAabHZzHm4QafkgiMgBBxpINh2zvWgOJpWTJmJb4rGspsxLQheIL66LUFXHj
         Yt+U787FTEzp/b8uTCnLVFffAki7u/kEjGsTRHclJ9ASoiQgh7r/oouajARq5zLE5TYW
         LDmbjlvV0YUebsvgddD6E1Hgm5LhB3tvmZe2XYXyzpb2bqv1WwAcvOSJ691qY+/XSZut
         bq6J0Zevrrc09SxaZqrsEdSBgAvge5RdBwjdXUkuH4zKW2iRSSD/esQGuTffrMG9+YGc
         mseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435315; x=1690027315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1Al/KG8NWTXmmsHWuavPIHFHpGDFDNwIi35fFm7FN0=;
        b=SIhgKyHo0DzqgDsETdM2a42sLGzYfTyqibJMzauCJrksrtnr6XlBjv2OSZEgHNRJW0
         Ji0zLRtpA/ffz2Vc3nmu8MfFRmXTPe+u/w4Z7Khpah4VZS47DD/o86YK1L39UD95oUyD
         I0lCMkD+kGSk87IifuA8Z84PPYk0zm5AFj5Xuxh3pd5y6jGSOtP8QuAgXuQGlXDMesFQ
         3x7Ql9qFaNvUl26pXVBZpwSESaGLF49jk21vNSG7cT3xCn3RPAlq+PJG7uQG5Xy77iVs
         JnVoAE7h+OF3lAfMkcVI56JWrrc22xXj/pnGwdwGA+PUbeGjSmP6GL2fFzt2t6QYeERS
         SB0g==
X-Gm-Message-State: AC+VfDzscBu5FuQ3TMZ6mHvf6vuIpAtJ1fNGnERdh93onRKeBX7j2YP7
        NDbIllR8TtsMox1Oa0paxaYGXA==
X-Google-Smtp-Source: ACHHUZ5Iw3ceu0CeLPuoLzLk3WrUr2o7YGVcOMhEUkPE6fCCm+zDhYFvaATSM07vU182TfL5QYBVgQ==
X-Received: by 2002:a05:6512:44c:b0:4f8:7803:5559 with SMTP id y12-20020a056512044c00b004f878035559mr5862309lfk.6.1687435315353;
        Thu, 22 Jun 2023 05:01:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d785:af3e:3bf5:7f36])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c231100b003f8ec58995fsm7594296wmo.6.2023.06.22.05.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:01:54 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 4/5] arm64: dts: qcom: sa8775p-ride: add pin functions for ethernet0
Date:   Thu, 22 Jun 2023 14:01:41 +0200
Message-Id: <20230622120142.218055-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622120142.218055-1-brgl@bgdev.pl>
References: <20230622120142.218055-1-brgl@bgdev.pl>
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

Add the MDC and MDIO pin functions for ethernet0 on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 9f39ab59c283..bf90f825ff67 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -371,6 +371,22 @@ &spi16 {
 };
 
 &tlmm {
+	ethernet0_default: ethernet0-default-state {
+		ethernet0_mdc: ethernet0-mdc-pins {
+			pins = "gpio8";
+			function = "emac0_mdc";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		ethernet0_mdio: ethernet0-mdio-pins {
+			pins = "gpio9";
+			function = "emac0_mdio";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+	};
+
 	qup_uart10_default: qup-uart10-state {
 		pins = "gpio46", "gpio47";
 		function = "qup1_se3";
-- 
2.39.2

