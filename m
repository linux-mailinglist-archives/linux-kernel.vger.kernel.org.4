Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3724636F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKXAtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiKXAsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:48:46 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83927F1DBA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id t4so241453wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+k5fH615JqiFsP7tNa0DK5jiBnHb78Vs4d6jr8q48o=;
        b=HZlfh6U6lIrNSFoHiUXC4H5BGYR8JWCmyUon8xnAvLCVukXkfbzf7i9ekoTKRSnUKL
         G725IXSmVSx/E8f4FAAKG9idiFXsFneHXZCMS0rRB6QRDvOsXvj9Uoq8Em9lIDs5AZhD
         3D9VRngp/LjR1V54VOunrhXurcfwcC+5UGIIc+ptx2mcJoxUdejH3UAEaVh+Ljs6uE3Z
         BnfOpmhZdO0NVytUjaR9UB8t3FHzGFs5++P9eakcjkAVRJVhlftNPPYkeXs8incbW8VK
         6wmB8XZlOI0xj7ZJHyDXztuCLA7FmRGKVCXdJs1TNx16JweFmJkpglJPhmExCEJv6oKz
         zRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+k5fH615JqiFsP7tNa0DK5jiBnHb78Vs4d6jr8q48o=;
        b=vu1QtGLdCxOMGyR8pXe6EqkQji+7otu6bb3L3zXVOZgMtAfto7Qq14Rb8zTtZUK1Me
         Ve1/A64ChGAk9TsMMQnlsyuPKN3ZoRvxJdfCq4Kq6NaY5FbeNU+94TcIngv1QKTvSSYK
         NGNZJrPOaLHRGMkzROsSeW4g2F359CjvOw/DnfNQ5uuFhXNz9qqkApahp2eWXYgsYD/2
         BmHoGFizc4FA7opcgz3CZuhb8K+1tGpmtIPywPUJr3jjVMX85nIXAEdsj0CraWWDzrtY
         vjrfyfGL4fE4VEMDILEscoagpq0CbN01r3Ni9uVd1Yx92Tpy7naGCD60tQX3cmupFWkS
         X7Rw==
X-Gm-Message-State: ANoB5pkLp/yZJEb11CTjkr5Iq474xJerSf3D8kqT1qfWzcMf9qFUId3e
        AmZpjb4JJ9l/4BIWCBdfJ4j3pQ==
X-Google-Smtp-Source: AA0mqf4PnVQZ+5TxNNbiaKv4WegvybTXylYzzZSe2sLB2eHHUB9bGvqfhr99Xzjp2z/BIWPw1jw/sA==
X-Received: by 2002:a1c:7404:0:b0:3cf:b091:e5a1 with SMTP id p4-20020a1c7404000000b003cfb091e5a1mr21589916wmc.44.1669250896906;
        Wed, 23 Nov 2022 16:48:16 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b003c6bbe910fdsm5245076wms.9.2022.11.23.16.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 16:48:16 -0800 (PST)
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
Subject: [PATCH v3 10/18] ARM: dts: qcom: msm8974: Add compat qcom,msm8974-dsi-ctrl
Date:   Thu, 24 Nov 2022 00:47:53 +0000
Message-Id: <20221124004801.361232-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
References: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,msm8974-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for msm8974 against the yaml documentation.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 21d943d4b02d7..b4361f4318ece 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1545,7 +1545,8 @@ mdp5_intf1_out: endpoint {
 			};
 
 			dsi0: dsi@fd922800 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8974-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0xfd922800 0x1f8>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

