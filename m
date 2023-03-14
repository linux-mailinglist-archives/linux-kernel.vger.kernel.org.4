Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27406B9E82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjCNSba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjCNSbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:31:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D09134C3E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:31:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso10806723wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678818659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bIVnlHmt6qvzfXTr0gBom9xZmGvzExFYpzsX6hvpJY=;
        b=ZewGe8JODcxm8N4lkEAmiZACO9UYNA8LS27Av68xAGVjmTY0Y0qH4+L5NgVK1MKr5k
         Lw5r98+JhKhss3uxnUSW21Va2cUq9qOyFqYISkZ45yCsQYs7ORGk+0iHQ0WVH9UOp1js
         qw5reT72dUevLljlqfifNyaf61dLinbFPtB9XNGUNThjlwrvrND7ZPzgIyRPc9ad0VIP
         SVAErNCyZfNP7619XkHpQn+rkp5xVaMBQwweETgPEMDHejGbmsFWcORJo8+K6t0XsZNP
         UXeX0zw3pTyJAicF86+JPxsU+yxZJ34hEWVD28ZFDNEb7WvCfAP7myvpvPjHxGugkJAL
         DVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bIVnlHmt6qvzfXTr0gBom9xZmGvzExFYpzsX6hvpJY=;
        b=MRNX0Ncdy9icUj4K6p8dKxI9C5ujhdFQHh54quj0Y6Pcn3pMleWapHuuuXBKc5XThz
         +8kwG+tKFTXd8jn1B7I00DxBaJg3SxAgBvf2OurkTKjeFg83gGgMwhxUKqguQ4govzao
         Mfmq4yktWptntXhsF29XD2ucSbNzf+CKJz1w0PemXw5ndeYUw/un+q/07pryARqNcNgc
         SYNbZPmk4P6vD/b3G3kw9EkZDZSBRSb+8Pkhf8u7F2Bja02LBMlhrqVbT/cuDpVXLTKh
         RMrwrnnUhaWolXMGt4mmqjqkmWgxQuBz3JIBC/Duy4Bo+qWhwGpJrgxoNrBcdXiTRZ8s
         jcGg==
X-Gm-Message-State: AO0yUKUTIo/x/XQqPV/DIYDYdc1WPfr5rHAZ5+u4w4grmS51oVFkS7cD
        bUoFIvoAremGnUVUtN7bjf8f0A==
X-Google-Smtp-Source: AK7set/nKHX2wRJy6hNhNP/sgA34E70MD8dHqidIvZL0NhP/gMaiEJgIB8b7sf8ZgG8GrGzmdjOPyQ==
X-Received: by 2002:a05:600c:a4c:b0:3e2:589:2512 with SMTP id c12-20020a05600c0a4c00b003e205892512mr14964571wmq.21.1678818659533;
        Tue, 14 Mar 2023 11:30:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:fd14:bd52:b53b:d94c])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b003e209b45f6bsm4083938wms.29.2023.03.14.11.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:30:59 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 06/14] arm64: dts: qcom: sa8775p-ride: enable PMIC support
Date:   Tue, 14 Mar 2023 19:30:35 +0100
Message-Id: <20230314183043.619997-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314183043.619997-1-brgl@bgdev.pl>
References: <20230314183043.619997-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Include the PMIC .dtsi file in the board's .dts to enable PMIC support
on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 1020dfd21da2..b7ee4cc676b5 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sa8775p.dtsi"
+#include "sa8775p-pmics.dtsi"
 
 / {
 	model = "Qualcomm SA8775P Ride";
-- 
2.37.2

