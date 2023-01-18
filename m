Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B66717D8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjARJeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjARJZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:25:14 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1963448607
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:50:36 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k16so3463530wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQ/ZvoGlN8LNm1TDQttciwGvM6ENGTWfyYnICnRN+aE=;
        b=PcF4OplwqjX1KXFL2FelWVB30I4kMpxRa55XaRWxO5qcq3mfBaj+NG07Ae4+vBzgRz
         BeuyNzs2T2vyF9onERuH7vuSzPT1jnuWFiGdpPsY1vREwU8fcAL3UD2WM62KYOI0bbK4
         YxCqh5n5gZyAnr2MMuqh9sy69q4RhR/5LWuds9jlhmQtKg2W0cWVCAQIea65jBJ9RiHo
         Xk2f61FMu6pyZM0cyFU1VgUbdexRn8PRCW9/sLK894G8wSV9iGphlVlshR4JpEb6vYBx
         Lm3FO2vdkDoSBsrkk/LD7hK4dU1orJlk29f5G5mBHGdUXAIST8GKiWEf8hos8z66eKT9
         rGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQ/ZvoGlN8LNm1TDQttciwGvM6ENGTWfyYnICnRN+aE=;
        b=61XNnR3lNW9/DIMWAJCToQjPDomMWllW6VfF8KuLHTzftwz/pX/j14ECoblsdb68Q2
         UzV5vvX8CuHUTHJZzdxz7TXgeVS+pICsdVMV0+Zz+CMXdo3blelq8w/i2em5e3hbK4oC
         VVLLa6ObYntkPbE60qFDzNKNo+l1TwfBlFaOGw+guUQg7MwQaA5Q+qDkWdmGgXsAdmOV
         ilhX8JHOYMTyfcr4k+BrQOGAalJ9LR9pCa6/xiqv7HGVYKl7Kcp+gau5nQXForc7VQJX
         wApNFkTy6PfwaXHo0iXJSSkS7xZcdT4HSfWwYhJ2zAFKnaJwYfqIBmEkKxd+NEar/JrX
         4atA==
X-Gm-Message-State: AFqh2kpq3KPXmIaSVj94R9Uxh3BYMRJcMOiOQzf4OzzNsdYwfpqZE/dP
        L6F4EPw54MNn2Izn0ix+g86Edx/yjhVrm5b2
X-Google-Smtp-Source: AMrXdXslM4nFmjBRTwdrJ0RxoH21KiqWdRsHyjBtqRvMQHwq63sg7no12cXMj+h4zA5f/ynLG7i22w==
X-Received: by 2002:a05:600c:538e:b0:3da:516:19ed with SMTP id hg14-20020a05600c538e00b003da051619edmr5746276wmb.29.1674031834660;
        Wed, 18 Jan 2023 00:50:34 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ay22-20020a05600c1e1600b003dafbd859a6sm1272231wmb.43.2023.01.18.00.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:50:34 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 18 Jan 2023 09:50:30 +0100
Subject: [PATCH v3 1/2] arm64: defconfig: enable SM8550 DISPCC clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-topic-sm8550-disp-defconfig-v3-1-11b558f7ff5d@linaro.org>
References: <20230110-topic-sm8550-disp-defconfig-v3-0-11b558f7ff5d@linaro.org>
In-Reply-To: <20230110-topic-sm8550-disp-defconfig-v3-0-11b558f7ff5d@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build the Qualcomm SM8550 Display Clock Controller driver as a module

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 851e8f9be06d..c9011e1438c0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1107,6 +1107,7 @@ CONFIG_SDM_GPUCC_845=y
 CONFIG_SDM_VIDEOCC_845=y
 CONFIG_SDM_DISPCC_845=y
 CONFIG_SM_DISPCC_8250=y
+CONFIG_SM_DISPCC_8550=m
 CONFIG_SM_GCC_6115=y
 CONFIG_SM_GCC_8350=y
 CONFIG_SM_GCC_8450=y

-- 
2.34.1
