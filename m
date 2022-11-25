Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F04638A22
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKYMhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiKYMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:37:07 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDD131F97
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:37:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bs21so6570821wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6CoppLmCTxX9uttSJKGwFNEqGwRPNJKx/ekxUEKy2g=;
        b=QhbOYxb24tTuaJPbVyoyscVgvUQklvpSVDXsx9WjqI2r5xzEhHybpTSzd8awQZbxIV
         4D23eXP1EvTW49UIDC/e//hFc4Tap4xKpms/VtfLCYeU9rNO5O5D91EvbdYnr+6BfcFm
         xZrUzQ/ZnqmWeu/xSJZkJmgvJzp1MxzNbVyHC3MfLdcQFgIOZ2bPsMv/co/l0UTQfvJV
         KON9mzH2i4u/Wf7rBcFz41QcHqpgsWUoUGE4xHmx1yLFFo1jzIfWdnGGGdKN1G/Co7kr
         XqWcVxBatWu5jp4IYcFCKzprgcGywsq0ODeRAfKbAyuAKjMu9cK3FJMbk0JYbKpgHQXE
         Lkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6CoppLmCTxX9uttSJKGwFNEqGwRPNJKx/ekxUEKy2g=;
        b=yurxNbSrbk+pytmvotxoSSNYgq3Z9T0QcHnOMclZIzODuNfSfQBaLVwa/YnFE1WZbz
         ZQwBG8zkSfKB24mTBq0RMb06JBXVR7aE2OI5BQHxWry39UfV+jLGH0padJa4ywxztqi+
         vbspSNKlLAwdzL7nuueGMwiG/L6LWkvmDhCarpKfNI5wA1zT8tSMamkeemkS0mSXK8xZ
         E6Po8/eGSGdwKSwQzmLOPA+x//pEEbPG2itBKiwvqhmkMli61FKxNpFxjO1udvnJy59D
         AdmIaUahOQyn2DhYKRbv1PQFRQDQZ+eGThkVjvNcJM5VCDpPlXtmjMcB0ZxRxpoPxmBe
         P5ow==
X-Gm-Message-State: ANoB5pm6+pujvhFlT7EFGiiSzuhONAf3YjkoFcxeVv44vpUUQTEtubwf
        Lh4jVtAryYXB+d5CN2QmkAyAwQ==
X-Google-Smtp-Source: AA0mqf55hAMSzFjdkZQ4JxF9PUCqhQHWHHpTkmkzfVRF9q8V26H+eq8i5T1OqxBEyWaUd0YhBfMTMA==
X-Received: by 2002:a5d:6e56:0:b0:241:d8e7:2b18 with SMTP id j22-20020a5d6e56000000b00241d8e72b18mr14541843wrz.388.1669379820342;
        Fri, 25 Nov 2022 04:37:00 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6d4f000000b002366dd0e030sm3574111wri.68.2022.11.25.04.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:36:59 -0800 (PST)
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
Subject: [PATCH v4 15/18] arm64: dts: qcom: sdm630: Add compat qcom,sdm630-dsi-ctrl
Date:   Fri, 25 Nov 2022 12:36:35 +0000
Message-Id: <20221125123638.823261-16-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,sdm630-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for sdm630 against the yaml documentation.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 0e7764f66b104..905ddb57318dd 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1581,7 +1581,8 @@ opp-412500000 {
 			};
 
 			dsi0: dsi@c994000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sdm630-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0x0c994000 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

