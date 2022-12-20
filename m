Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D034D6520B8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiLTMiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiLTMhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:37:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CFD1A05E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:57 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m14so11583007wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRPNlaD7hsiz/pUuk0p12dcLjCcNShs9xK43XVBNgQw=;
        b=AlOKjm0oELLxx+jAkVNSqFql6WmyOmKrY0zPkfu429Ka7TM8KTOFeu5pL4iqSanszP
         z7K4VzLV3SzRee1yY24jMo4UevNeGiqw2suAvaddBaeTi49rp33SSAcCobTBxGFap0Ay
         rSemFk2D29mD075eKojO3JXVDCzUPAo7Tzjri6200GWCC2XEQtjEKbj+dgjNhTRRECrJ
         7WgHNv3KVs3IfMo/mIx1t3xPZeHvVZf1EkZ0RQPLGMNjLLUL8Go2lSK/ZGW9AESd6cVu
         IU5K8T9ypzdhv1elkWQ0uwYiPjZnWPYlFETxLrITDc+0YwqqJed/8n0fBkGjB5nbQUvh
         m/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRPNlaD7hsiz/pUuk0p12dcLjCcNShs9xK43XVBNgQw=;
        b=7iZ4CZ4M/0MfvByagautam7k6pUDhfWgoAFnoe5s0yuDkTzZiwA+3WgoxFMkWr8tIB
         WNTCBnZyuR12PeuZzfJSdgF3+39/Y78PqWM91ffUdNAxnGQPDPsINRFnoPWX51rBKt3H
         /GZwTJ6uRVrN3bb1c7oCwIpdr/cue8oy65DTDutX+JryKDwClscY605t59heHIeLXKnX
         pP5fzaDnpSiEYEleK1gp+Dsqn2ap+2G0ADMU28SbU2tTmOps98PIkm1MPbr1OUC+Q9Ju
         xZaNbuDMt1FCovD2C3lasjBzlyzLARKkn0AVNZoCkuNEsOVSqYyjXRMaRN33zRhSXaYF
         B6Hg==
X-Gm-Message-State: ANoB5pmIAvb8HmJVPvxw+BuWx2kEVsd2y1nZn3bSCij6IwWaGp8YtdsJ
        iPIyX1iQZZD6Bb033Z8KxPn36A==
X-Google-Smtp-Source: AA0mqf4Qwn1lOj+RanfIZTDmk0766KngiFyW+bGOmLbGxRnfVPSk39xJNcAUZxRbEff+9dYOHJXFRQ==
X-Received: by 2002:adf:ec86:0:b0:242:31ba:1389 with SMTP id z6-20020adfec86000000b0024231ba1389mr27047390wrn.31.1671539817207;
        Tue, 20 Dec 2022 04:36:57 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id da13-20020a056000408d00b00242257f2672sm12641208wrb.77.2022.12.20.04.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:36:56 -0800 (PST)
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
Subject: [PATCH v5 17/21] arm64: dts: qcom: sc7280: Add compat qcom,sc7280-dsi-ctrl
Date:   Tue, 20 Dec 2022 12:36:30 +0000
Message-Id: <20221220123634.382970-18-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add silicon specific compatible qcom,sc7280-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for sc7280 against the yaml documentation.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 0adf13399e649..a437ad4047f52 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3906,7 +3906,8 @@ opp-506666667 {
 			};
 
 			mdss_dsi: dsi@ae94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sc7280-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

