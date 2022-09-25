Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252095E92B2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiIYLVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiIYLVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:21:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39702E69D
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:21:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a8so6757163lff.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tmgRMVajfJ/rcrn228aspdr1S7/uuIkhYN/dmuBPsdc=;
        b=AVE4jDkSvxgPIFRsMAM7jDsIKLl+8gYT8k73hGCY2YjUWEp6C7oan5f5V35FrXG+nS
         LAvs7PRCrAh50q8+og+0pMJnnurj8yUYY/25pUDtDpxbhZJL9O1WFWm/HuvaGWWKqiGF
         o7ADIBvVGGf4UxATwQTUf9gf0kEXnz9wL8g3GpMlfi0aCvYA9PeoJPn8R74jzr9+ocmz
         3+z6X/7KZ9YL3gBV4mZDKsW/wSaOJ3LPvrHwy0kvkbUi/a4WMlnfoNChSIodfRH95j+f
         zG0GbghmOuLxCRc5+UbEqZTMABmVKmvbRaxgoRwkOKpwNcAm3gr55RIFBip5RC3yUw5K
         OsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tmgRMVajfJ/rcrn228aspdr1S7/uuIkhYN/dmuBPsdc=;
        b=IOXYizjVjshjLmdldbOjmF1aeo2CUUa2zuVGA/7mr781X0rli0QgI0ZNXeddJL213L
         1NAh+1sC+YAKmzAEbBbom5pZza48aoxVPyXD+ABxJvvyXZk59QCm7Yketvntqni4r3YE
         q15FhpiwGrzE9fw3cAhc1zH/XrJgGNycZvaSz6HS8kKnPQXI6in9a8spzE1otA3WHvgw
         Z0lvTXc/dwu5wodCLCf5cr0L5EflzAvhSpX/0GtlVEkaMZ+ZY3np3NgET7V6arEAu2bT
         BKRT4kFdvlsrTpAoHaJ8qoSua6ZOv6OCrft36TY5vkb10InqZnlmxTEvvP0w5QMsbNd+
         IVbw==
X-Gm-Message-State: ACrzQf2GK0SxSF32mBE99O+yFlzX6wZxU6rOMFigvxrCXDhdsu/NmOho
        3vL1AqWTdl8Ykhz54Nry6HnqTQ==
X-Google-Smtp-Source: AMsMyM4kONuHhMPkXDCvEuCUoF5bDQfzA2AoUTOe4vdPSAQEggpBbJIs/cl6wa9yskO0SVgPNxw4+A==
X-Received: by 2002:a05:6512:3b0b:b0:49a:d44b:428 with SMTP id f11-20020a0565123b0b00b0049ad44b0428mr7173041lfv.0.1664104888207;
        Sun, 25 Sep 2022 04:21:28 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c16-20020ac25f70000000b004946748ad4dsm2178053lfc.159.2022.09.25.04.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 04:21:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] arm64: defconfig: enable rest of Qualcomm ARMv8 SoCs pinctrl drivers
Date:   Sun, 25 Sep 2022 13:21:23 +0200
Message-Id: <20220925112123.148897-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925112123.148897-1-krzysztof.kozlowski@linaro.org>
References: <20220925112123.148897-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable rest of Qualcomm ARMv8 SoCs pin controller drivers (MSM8953,
MSM8976, QCM2290).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Enable MSM8976 (Stephan)
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5a4ba141d15c..1138386952b5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -529,9 +529,12 @@ CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_IPQ6018=y
 CONFIG_PINCTRL_MSM8916=y
+CONFIG_PINCTRL_MSM8953=y
+CONFIG_PINCTRL_MSM8976=y
 CONFIG_PINCTRL_MSM8994=y
 CONFIG_PINCTRL_MSM8996=y
 CONFIG_PINCTRL_MSM8998=y
+CONFIG_PINCTRL_QCM2290=y
 CONFIG_PINCTRL_QCS404=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
-- 
2.34.1

