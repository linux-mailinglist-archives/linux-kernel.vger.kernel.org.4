Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06832638A47
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiKYMjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiKYMhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:37:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D375B4C241
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:56 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o30so3356697wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7afU0zY2iy3fcGz+GawNZWOfW2OGctpWqTEihbQc8o=;
        b=RtfCLuTjMOeEDfRS48uKivIdq58YtbVd6zFyIyPNRNT8PGIH0gITEYukf/jWJNGTNc
         KPEsrwq6GE/Cm5tlna11JjJ4pS+W56jS03C2RCdCvkzTIQWF8Q8V9lF2UHYXxfnBNSni
         P+en2LB13pE+PZeqPmBIH2Z7PJ1F3+W5pD8V6oedNSPOYuHZTy/EKSULOZtUsBqzilxX
         I46MszbXaU02kyT2GLc8vBBFr0OTmbtfEuWaXoQcelq6K93pDuS+n3mbHXejdoZYgcge
         7L6WUFknD4r6YWwKV+acOzAS/i38hYNKM+oVijhVA54yLRxkK1JL8WRF8UHOQ/A69Eqy
         ferA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7afU0zY2iy3fcGz+GawNZWOfW2OGctpWqTEihbQc8o=;
        b=z0fLBPWaIlauD/qyGwW7qvdOayiWZlLhE68BvguZ+4ldV+MalbZv6f6pZQeJOo4M3O
         Ufagy2+J9VF4vPG/MLGP3lgB9WeTJMbPqCczEO9Ex4J0oXorTu6QcGXExgRk5LMieT3c
         dskuBSk+aRTmMiHcBO/FdPRhMvIg2x9brOueHODaEk3L0FYZWruyFks4oaAG3Go21DR/
         XHakp7mOnsf8upCneAsLOU/8pvt4ctWN7Kz/aK4HyW0eQrVq1FIQi2n9bpJ4DxP/VS7+
         fQ/LQzyqbXBQmnBfhKsa1hLAYL6JapCo5M4ohY+oRoaWNmOievBO/HtEg78V9OgHeUc2
         Hlhg==
X-Gm-Message-State: ANoB5pmZzxMiqm9Lf3GId0/0JLDsIiwjVl7IC3tXmN06XobBXK0TLbiU
        arX98scjurzNk+OZGWOnfZUIWg==
X-Google-Smtp-Source: AA0mqf4zbOnZG7Lcv6nwc1RMCswiHsVB+h3CFBFo7Ogg96m69jqkj5cPX3nRzaNd0SrYH+9uusDcXg==
X-Received: by 2002:a7b:c3d2:0:b0:3d0:475f:d390 with SMTP id t18-20020a7bc3d2000000b003d0475fd390mr1852235wmj.149.1669379815380;
        Fri, 25 Nov 2022 04:36:55 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6d4f000000b002366dd0e030sm3574111wri.68.2022.11.25.04.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:36:54 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v4 11/18] arm64: dts: qcom: msm8916: Add compat qcom,msm8916-dsi-ctrl
Date:   Fri, 25 Nov 2022 12:36:31 +0000
Message-Id: <20221125123638.823261-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,msm8916-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for msm8916 against the yaml documentation.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c1d8a1b388d27..20e72038cadfe 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1021,7 +1021,8 @@ mdp5_intf1_out: endpoint {
 			};
 
 			dsi0: dsi@1a98000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8916-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0x01a98000 0x25c>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

