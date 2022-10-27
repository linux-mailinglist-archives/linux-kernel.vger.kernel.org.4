Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA23760F164
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiJ0HrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ0HrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:47:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FA1168E68;
        Thu, 27 Oct 2022 00:46:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso695584pjc.5;
        Thu, 27 Oct 2022 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVj2OYA35z1rSXJ+3f5hZK8nYVXD1srUvtRewkk0Cmw=;
        b=O9ooqwgFAsZHesA0Czqn7eG2fuaEknuY94kVun3oSV5B0ADMbzw0OZVQdqfPyWfPgH
         R7/XM0/IcADAr4k7MUcQmn63724j8VS52D0jvcDsxnBe2wve8ot/DZk1AaFYOlSVYz1w
         aW7nKN5BRMvd2bY0rAZFbEkKYYw7HpSKxn7SJ55DZgn8QOLBsTcshn2CF7HmsV4DPaaf
         UQlQU3S6sUsYEEd+RaSGr5Ds06HchKKFzxz8PQ4b1pQDyiJPrsh8ZopQfF6SNTqO6sRc
         AjkF3dzizFR0p+q/qLrj1T/Lpg8Wuo6OAzntRHeOTdwWPf9hV6QUM5SQgNltd3Ys/A+j
         rz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVj2OYA35z1rSXJ+3f5hZK8nYVXD1srUvtRewkk0Cmw=;
        b=brMLOOuuHu2uJMI912EeaqSWHCojrmLOVWBfw+p5whamertl6ax2FxME8G5WmUVlQg
         vI2a/NuuqRkNKc/LVud3dumrO5FA+LS1hZGTCk4dtOWCN5b7Mqb6Jv5LxB8EoDWXhxtM
         WuDiW7gsvguRen8luO1W9qQg+ixevOGd1qwua4kdfvczdGcDyYhr1JGqxRqPbO7TyntS
         099VjarhqGl3XsAh9CCKrobdQzkRSclda1kbmn/NooJMbP35I7bfmNWYmXLSvSwt+3CY
         bpEJSTfApFGn06gxu9XcCeGExAWjl2uEGoV+DqksZyr4xvdLddupTQQfRboCOW4VBCjk
         /wPw==
X-Gm-Message-State: ACrzQf2ovGx0MtCOuw9YPNy5aoiQ72tuwhHR8sfLFsQ0jzFfbwmSSaXj
        wb3mrdvsEmlQf48plX4rSeY=
X-Google-Smtp-Source: AMsMyM7L1Nx0LeMvp30aX4Ygwo/qJy5jODl4ET/X+HffNWtZaL6taN+7ORXZGHHKhRULYGL+YtO2TA==
X-Received: by 2002:a17:90b:1c0d:b0:213:1a9c:5b1 with SMTP id oc13-20020a17090b1c0d00b002131a9c05b1mr8494089pjb.188.1666856819163;
        Thu, 27 Oct 2022 00:46:59 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:99d6:ae15:f9aa:1819])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b0056ba02feda1sm611386pfk.94.2022.10.27.00.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 00:46:58 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: qcom: sm8250-mtp: fix reset line polarity
Date:   Thu, 27 Oct 2022 00:46:49 -0700
Message-Id: <20221027074652.1044235-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
References: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver for the codec, when resetting the chip, first drives the line
low, and then high. This means that the line is active low. Change the
annotation in the DTS accordingly.

Fixes: 36c9d012f193 ("arm64: dts: qcom: use GPIO flags for tlmm")
Fixes: 5a263cf629a8 ("arm64: dts: qcom: sm8250-mtp: Add wcd9380 audio codec node")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 9db6136321b4..391806c62ccc 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -635,7 +635,7 @@ &soc {
 	wcd938x: codec {
 		compatible = "qcom,wcd9380-codec";
 		#sound-dai-cells = <1>;
-		reset-gpios = <&tlmm 32 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
 		vdd-buck-supply = <&vreg_s4a_1p8>;
 		vdd-rxtx-supply = <&vreg_s4a_1p8>;
 		vdd-io-supply = <&vreg_s4a_1p8>;
-- 
2.38.0.135.g90850a2211-goog

