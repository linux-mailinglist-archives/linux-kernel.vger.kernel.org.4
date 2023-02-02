Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F4687816
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjBBJAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjBBJAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:00:07 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC49B2D46
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:00:06 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso775483wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0KvHUQYIqU3JhTy0BEGMF/3U69tNws+YECbp0Y0ZcQw=;
        b=0AAk3DCRZ9FNcs8Awka/8Ay/wufkGBvDUTSneCXcY+ONfJlxOU4a6TWqJCcpVyuKQe
         oqGKhA5c1bmVXP4IlYn57UJEbeUhJ3w7RJQM1D0lvkGxSvCheZ1oeStT8KIkQTl6x0LL
         ojl3bcosxzW8ZsIOn8jLzPgrjrvCA4KM8OOfe3lVOHo1w9xX5Fq8DEkgYsMxRqYilEFy
         4fiPKo4cc9hTu9QfOMv1jESKInqXFtZVuuPGFfBuCPiU6EUhcZHUIzTHjWQRFbxMkJVm
         dnZTP+xoCg8LkcOmPb+GBc/W2fyOuJLO/Aamu5/ffWU4k5SoGGwM1HssUzG0iabbeYla
         iL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KvHUQYIqU3JhTy0BEGMF/3U69tNws+YECbp0Y0ZcQw=;
        b=7FuqP+KH0wrff9i3xonAIaT0Epzo16mKh4+ZDKXoeaL4Lby2dKQEw2g9IGU2KDCoDu
         nN1qyk7D6OXrKXZHeMxOCF3B0yBga/vXwrdGY5xwaqFbw29hE4wW6zpuHYtPp9t69NSJ
         0cXSe8D5XGdOLPBOo7mRBZWfsFPslU1+EqYd2YLiKCiIPdi6Pbipr0LFcSwgCiqP2L+j
         zLOm+A0tby2s4QFaQq5n9PMWy1+qZ0XmJuv0VNo9ISf9uFEaRPEwN40NrPwRW5vgbQyC
         a1mN4eBtdQtBvnCT6Lxy88/EyT4MxfH1eJTN06dXUUblAWgZJLDwFHDuebaSCmp47NSm
         GGVg==
X-Gm-Message-State: AO0yUKW0XyuS8vBTsisWRY34q7i8hcOpGIGnaGZHqN2zy4PM2DzA9lcP
        7NO0ASThhkSGddR0sTBLltT6wg==
X-Google-Smtp-Source: AK7set9TE0ceLCqmypT6IXrk6n16nsHYFmbKSwRvXNJe8tq88rqWZnFlWUl4XGIEjYT1X8niiI965A==
X-Received: by 2002:a05:600c:4395:b0:3df:9858:c02c with SMTP id e21-20020a05600c439500b003df9858c02cmr1331757wmn.1.1675328405216;
        Thu, 02 Feb 2023 01:00:05 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bca7:7154:c412:82ab])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003dc22ee5a2bsm4374694wmq.39.2023.02.02.01.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:00:04 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH] arm64: defconfig: enable drivers required by the Qualcomm SA8775P platform
Date:   Thu,  2 Feb 2023 09:59:58 +0100
Message-Id: <20230202085958.11055-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the pinctrl, GCC clock and interconnect drivers in order to allow
booting SA8775P boards. The drivers need to be built-in for QUPv3 and
subsequently UART console to work.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
All drivers are now in next so let's enable them.

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 984553d55e17..998ca0e07689 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -560,6 +560,7 @@ CONFIG_PINCTRL_QCM2290=y
 CONFIG_PINCTRL_QCS404=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
+CONFIG_PINCTRL_SA8775P=y
 CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SC7280=y
 CONFIG_PINCTRL_SC8180X=y
@@ -1352,6 +1353,7 @@ CONFIG_INTERCONNECT_QCOM_MSM8916=m
 CONFIG_INTERCONNECT_QCOM_MSM8996=m
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
 CONFIG_INTERCONNECT_QCOM_QCS404=m
+CONFIG_INTERCONNECT_QCOM_SA8775P=y
 CONFIG_INTERCONNECT_QCOM_SC7180=y
 CONFIG_INTERCONNECT_QCOM_SC7280=y
 CONFIG_INTERCONNECT_QCOM_SC8180X=y
-- 
2.37.2

