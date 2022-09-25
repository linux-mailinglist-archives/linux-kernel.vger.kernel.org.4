Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFDB5E91CF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 11:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiIYJTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 05:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiIYJT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 05:19:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753A22873E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 02:19:26 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b6so4425689ljr.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=368OU+vVpaFCtqSQaJEf+298vxwgD9NGVsMG3FOMcdw=;
        b=nXAB/th8Vwrfu+8p1UQ0VShfbwN0GFCazi3tfumEis2y8v7ndrH1H/QvIZbUghtCnk
         /ctQ2WIKgnYFkH/2u9iAbSRF0l8u07ESHhvt6s76UnAT4nvtPvBCTkNgmm8M2xhBuo3Q
         xXPZSX+eeMjxY+2GU2Plh/23hSF5n4QIiDu43hoNI7fCfxOaubD5mBRvYxis7r3hv+7z
         0mBZ9JEz4h2uUnMpU6ismGI3JvdPQQs+TSV7PYFb+7JEI776XbH89EpTS1nGHgj6rHwL
         uWhK/MlIRhyNrOEG1d6GWEFmiLmqdANh6csgGkahYeyzOBAnuS5KiH99K1VfBvkl+/nU
         P61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=368OU+vVpaFCtqSQaJEf+298vxwgD9NGVsMG3FOMcdw=;
        b=Msl7pmSQ1HD3nWz1pz0J2Dji0I5MddI13coX/RYualxCETKE30W48cCUHYcq7MBl1i
         LFY8KCsFH9T3O1BK5gJ6qniTyDFbg7/clgKFpjY7myD8jsKIEsrCa9US0bKOTuJilZbP
         s/yOecRRU+GkeQQlQsMdm1A7OxndRfdUHD+A+V1o/KWbQHa8JkeEC4j/WsUWm51+7nuo
         goz+NVH2wBaLWb08eZO3jFZG7zVCaCg+9W3UDIu3JlNJMttrP0JCHEKPyg2LTdcVaLw7
         cqVGqOnVmayK5aEpELTpZvCviWQI03HTmw9bhJxeNpSvzj1h8zBG1uyN26j1Stpq0V4p
         m7hA==
X-Gm-Message-State: ACrzQf3CVo/7BhrPjPZFahgnmPCoGpXkVoeLtEYbmHmgzkTJLh4T3e/S
        0esyfl9FNQevflFGi60zJr9FQQ==
X-Google-Smtp-Source: AMsMyM5yL9vBIWrDWnG6jH67KlGT5c8UPZGHbjXGA6KLbDyJbjMzRjoUPG+dLFsQwpenhLh1VD0SRw==
X-Received: by 2002:a2e:9b89:0:b0:26a:a203:3b54 with SMTP id z9-20020a2e9b89000000b0026aa2033b54mr6047570lji.478.1664097564772;
        Sun, 25 Sep 2022 02:19:24 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p1-20020a2ea4c1000000b00261b4df9ec4sm2023455ljm.138.2022.09.25.02.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 02:19:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: defconfig: enable rest of Qualcomm ARMv8 SoCs pinctrl drivers
Date:   Sun, 25 Sep 2022 11:19:20 +0200
Message-Id: <20220925091920.34891-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925091920.34891-1-krzysztof.kozlowski@linaro.org>
References: <20220925091920.34891-1-krzysztof.kozlowski@linaro.org>
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
QCM2290).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5a4ba141d15c..fcb3d03d7719 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -529,9 +529,11 @@ CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_IPQ6018=y
 CONFIG_PINCTRL_MSM8916=y
+CONFIG_PINCTRL_MSM8953=y
 CONFIG_PINCTRL_MSM8994=y
 CONFIG_PINCTRL_MSM8996=y
 CONFIG_PINCTRL_MSM8998=y
+CONFIG_PINCTRL_QCM2290=y
 CONFIG_PINCTRL_QCS404=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
-- 
2.34.1

