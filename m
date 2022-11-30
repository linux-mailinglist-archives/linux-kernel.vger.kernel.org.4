Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7995863D39F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiK3Kjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiK3Kjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:39:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6086547324
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:39:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y16so6630770wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhZDD8xcpBnTbaSUo6s6vdqxM8BkGMuykHbcqOykd/I=;
        b=N+hKwobZLw583rgJbQooZK/PUsqCwa98+M62Pu3RuPW/I8QRqcx0ND8ZYej0IQiiAp
         69+ejO2EYvCPwRz+kg312KIVWBqZ9fyxnBdYJjD66n2qgBNnNgVo4/Uw4v69gm5iFnwr
         PkkiU8/ftu8YTjo7WIXFsuwoUnU5gb2I4SYsbTOBnrqlIkJJgKDjIw6D9lYPaxxj7LSS
         zH217mONbVLzXf7NBlKjSwr0UGVVUqiRrfkGZzBy9OtjXtofLI8jtyMDhdALBGJoR5Mq
         0kj6u+hQwd9Igp/imPoeoAK4nYUrRRBesVoC+bL5pIvoyt9mIr37egt/Q0SbWE9Br/Xa
         B62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhZDD8xcpBnTbaSUo6s6vdqxM8BkGMuykHbcqOykd/I=;
        b=3PiFr/mwxJmkUu8ekiVtJDmWLCR/8uiYeWGRxnxtE2Ro7rEZKuoa77L4An39MSs9ip
         hUPVusCMqa4JlFl1SVAcvHEtTR9C+K+H/1gcP3dQeos2mgqD+EzFJ1gbRFDMUxITFTgR
         coR+hxNGzsURkKHxxAM1NWnZwVawVN+o5vKcXrHB+TxxfFOa5SN7bqGj1EWUXhG7VOU3
         tQMWPe3wjkMVgdMAQtBU0KyvbD0gEyqkCii8yQr96+fv4xts0OsOYswoWfLgSgN0z4sb
         TGwvDFbVb+01osX68DEwl7n40dbjoKC/ccMR0RX+2+hAd+FdPdoKJaIIrKB+Zm3zjO2a
         LXUw==
X-Gm-Message-State: ANoB5plx4NAR+Jilap3M5YM+X4rTXe87GFeHK7ZcVFxmGV2FuugU6kqT
        TIjwpxuNhT1Bh5p7cVlF7NCsklJ5Q3W/3db5
X-Google-Smtp-Source: AA0mqf5h9a44Qk+VSI2o38nmpW3OEiE+U0GtxIoqKrj/ZgtcMEb2SqP66ATO89ZasQqMqAsnXCiRwg==
X-Received: by 2002:a5d:4143:0:b0:242:1551:9759 with SMTP id c3-20020a5d4143000000b0024215519759mr9603989wrq.476.1669804765957;
        Wed, 30 Nov 2022 02:39:25 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe8c9000000b00241f632c90fsm1261174wrn.117.2022.11.30.02.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:39:25 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 30 Nov 2022 11:39:23 +0100
Subject: [PATCH v2 1/3] arm64: dts: qcom: sm8550: Add interconnect path to SCM node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221115-topic-sm8550-upstream-dts-remoteproc-v2-1-98f7a6b35b34@linaro.org>
References: <20221115-topic-sm8550-upstream-dts-remoteproc-v2-0-98f7a6b35b34@linaro.org>
In-Reply-To: <20221115-topic-sm8550-upstream-dts-remoteproc-v2-0-98f7a6b35b34@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

Add the interconnect path to SCM dts node.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d7eeed0f62d6..98026d56cf01 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -268,6 +268,7 @@ CLUSTER_SLEEP_1: cluster-sleep-1 {
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-sm8550", "qcom,scm";
+			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
 		};
 	};
 

-- 
b4 0.10.1
