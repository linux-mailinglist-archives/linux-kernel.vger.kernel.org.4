Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551066C1A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjCTP6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjCTP5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:57:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4B910D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:49:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v1so4714142wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1679327338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bIVnlHmt6qvzfXTr0gBom9xZmGvzExFYpzsX6hvpJY=;
        b=q88V4GL+E1vQ/bHN+zeLAv+QcGxuAQPcfJaJOzetHXhl0pjJuU9CQEjqiJY7PyDiwO
         N/jJSlYo3J6yL0XrTdyTTxghmTr00gqk9rrPzCWR8UF3THHiXi4TtIUzaJd/0KaWSbJp
         bXI7Eo0PQ0OHaMmobZ2HC+sGxF0wgOlSNX4JLmo/AxYvgcJcC/7x7aFLbdrjmCFpzq4f
         HkgG28YEh19fhqOafwqCxB35pk0BVIBZcAA6qugnJYEeZ6nAFPQJWYrCxFyRjgueroSo
         EUEnSx2o+x1YTkVPDVDJSRzfS+lMz1cj7T9KQYiDH5/uTnqz9XDWozxc7o9r74TpL4tk
         3LTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679327338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bIVnlHmt6qvzfXTr0gBom9xZmGvzExFYpzsX6hvpJY=;
        b=5VAdekVFup4mw4ftUHxUN/nephqFilOSise4/Uotbwi3URHOGGAKHLRe1v/k5tUMyP
         fDrvqndxpMLDqieqjmzUDWR8Ek2aSlWozUrs5zJRCLmv5Q4i3ERhePsMQYcfwlW25FEr
         p+N2XQWTuvkjOkOQn5Ugb05z8AyOGAPJ6HJWqW6LkcnC9vyo4SLrXfkrSxyr/Fv+ZBTD
         GqYUvwcyCBl+V2EPr6JclG2IzJ5b39JgF8ISfCQrDEFG0FCCvSFe2cSPV3TFWtyKUzep
         vEp04+TYhAE/IR2+CjxcTRK5vWgVq0cpdTWRDhcKWxlOoCRCGFQgoNmCWnSc7trk5fN4
         RnbQ==
X-Gm-Message-State: AO0yUKVc7Ix5CAlw9sruyBsBypDvI+AeRUqyjX6Hxg0GwseTf37SaikR
        nBZdJvoBaz4mn41j/gwaqCaK4g==
X-Google-Smtp-Source: AK7set8J7aJZqSQ67pSg3XGy00Mialw4KBQ9UAZFJFSx47qid1zi1AcZPSW94/dphPVVK2YuFXb7sw==
X-Received: by 2002:adf:e74b:0:b0:2c7:1324:dba8 with SMTP id c11-20020adfe74b000000b002c71324dba8mr12235569wrn.49.1679327338602;
        Mon, 20 Mar 2023 08:48:58 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d7d9:4f38:38b4:82b4])
        by smtp.gmail.com with ESMTPSA id o6-20020adfeac6000000b002c71a32394dsm9202578wrn.64.2023.03.20.08.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:48:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 08/15] arm64: dts: qcom: sa8775p-ride: enable PMIC support
Date:   Mon, 20 Mar 2023 16:48:34 +0100
Message-Id: <20230320154841.327908-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230320154841.327908-1-brgl@bgdev.pl>
References: <20230320154841.327908-1-brgl@bgdev.pl>
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

