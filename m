Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB586CCAC9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjC1Tg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjC1Tgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:36:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686CF7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:36:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so9784275wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680032204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDi0sPSTLB7eAuIgWAobS9FE/uMoxKTeXL5+WCsqXmk=;
        b=pAE/Anb4jFNCU0zI5aj4Mfm2iU/Z7FnB4DYmMXvDmdmyiMf9Qn4ZBBTpWyncIA3SfS
         43Ispb70wyVjSu7L+eA7Iuza0GXA03kZGHWuLNfIBuX8kMhsqwUbwaFq82mUStZIIY4O
         fecJSxQ34AVdEQgF67ZzlhAHtKpRfc5fBsGXAlzA6+x19K6jDqS7ya+GxWzdEEpbNhDz
         fkSzSJKq6jAevPF5ffIm8A8nxp0X+5n+A3GLid8wJh9H7Dz1gYaHfS1CAtep4SWWq93K
         vr1sz2HjPeU84WZjR/Quzo6TKbwhHTbqKXh1zz3kjKJUMUhMqtdnNq8aJnHBql77QHE4
         x74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680032204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDi0sPSTLB7eAuIgWAobS9FE/uMoxKTeXL5+WCsqXmk=;
        b=KxHV4F9x0tU0FZ53kpkqK78+yjItLIX6t0RNqYTNtKgGlR1h1drClvUZChbP6gZKdp
         tPDGTOaku9n2zoHqHaOm/BVkni5awME/hKAHbSa2C/OA0JbKmshwQL1juCDoQ1rBZ133
         rAtPaIImGtRUmnwOPSEA/mU4Bxy7WAZkHN5AiuXqI+xVQo5LTSijOfUPqV1r5mVdL97A
         JHuQlPyUAHHO0SB2YSHp4pPychf7B4K42vnwJK3MoBWjzcFHk+D08l/xp6xT1jNTRan2
         MgkhD0Ky5VHkbkDr2Sisv235PqUVMjjylpaEyFFvUucr990/ByUEpxOybwQZWWxlkb94
         TmGQ==
X-Gm-Message-State: AO0yUKV4kBQlJCtSIDwqj3QA8fWUfLYY06JGr2HEbtVUSi0v8sLZ5e5Q
        zUX3HvO2If4+3KjklZCKOdl4ng==
X-Google-Smtp-Source: AK7set8Wd12xTw8Uw2pNxpWv2ZIHiOMK3NQRpNv6gyaRe3GY5utq1XGMTUhwO7Kg9/gsp87NhnJlRw==
X-Received: by 2002:a1c:f013:0:b0:3ed:ac66:9445 with SMTP id a19-20020a1cf013000000b003edac669445mr13661092wmb.8.1680032203957;
        Tue, 28 Mar 2023 12:36:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7b39:552d:b2f1:d7e8])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b003eb5ce1b734sm18060544wmk.7.2023.03.28.12.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 12:36:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 3/7] arm64: defconfig: enable the SA8775P GPUCC driver
Date:   Tue, 28 Mar 2023 21:36:28 +0200
Message-Id: <20230328193632.226095-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230328193632.226095-1-brgl@bgdev.pl>
References: <20230328193632.226095-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the GPUCC module for SA8775P platforms in the arm64 defconfig.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d206a9120ee4..fa0a145defe2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1161,6 +1161,7 @@ CONFIG_MSM_MMCC_8998=m
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SA_GCC_8775P=y
+CONFIG_SA_GPUCC_8775P=y
 CONFIG_SC_DISPCC_8280XP=m
 CONFIG_SC_GCC_7180=y
 CONFIG_SC_GCC_7280=y
-- 
2.37.2

