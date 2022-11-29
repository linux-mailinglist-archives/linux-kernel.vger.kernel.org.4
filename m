Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8E663C997
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiK2UrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbiK2Uq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:46:59 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1D6264AE;
        Tue, 29 Nov 2022 12:46:58 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g12so23914416lfh.3;
        Tue, 29 Nov 2022 12:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0asAoMqwEnbLM8XD1/hLqCKMeXNAQ5meWtedT2j2eo=;
        b=mC4SrMSQU9Ksm7Z9Zz4jeSxnSoYtCEjCxvFktqIAj+LxH95z+9D/kcRn/sivbsj0pJ
         m6Ef20QJ3hJyPV0SpJr8TSDW0iofCGBAHDv+HSRNVa9CKihjvv6DQlXDRkP3olec+3iZ
         AxyBeHJcfmXbdDZrzOn5AaGQTga/gLhTz62cOY75YE0ftZypE9KiTXIJae8IggVONOl/
         2rx7e5gD9MvqzMaSNEWba2lUja6yHzCHFb5ptxvvShDAfHGIGobYrW0D6IK24q+rv5cY
         JgG44YqwSbFbhA4htr5UgOCHOAjhzoIZRdHlHLo8HPi9rdJdFUbMbPEJvy2f+LbtvZ3Z
         iW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0asAoMqwEnbLM8XD1/hLqCKMeXNAQ5meWtedT2j2eo=;
        b=g92lK8ih6wgWxK9ZlElT4r4farJhVhhmffXpSqglK8qmf6eu0KUoANZXp8fHn+oVej
         IRfC0EQxxViQB0MgCS2eeZwbLK3IR8c1eNie6zqGYm7da060bJXg6hlENHPcOXXKZ4wK
         Ke5nKMWEzclQitLj23EenX87Ou1yWWO2zQ2dT6q02fsIp41sZ4zqjnCoCXySgCmb6xr7
         yJAEVx9bWGO+jM4t4QR3IhL1Gb4vt6kFBgGR/bE0y8CjANK6agA4QQWBGbuQk09ZFfC8
         XqBRygLnqKlxt7Ime+nNNeNmWbY0PnEbBVVZz/+HopstNRmAgKxkbz186pbQqlaollby
         9WTw==
X-Gm-Message-State: ANoB5pmIT3PJ2iypzlqWGoPmMltKZBx/KVVMdg3bKi4P4by6ueF76DVL
        8OW2SIX8eC6UzJPTr/2IogkwNANR+Nw=
X-Google-Smtp-Source: AA0mqf4sjfz5XraQ8YjoH//addmVdAEiibnccbFxPDlqD/xvyEbpMKoICP3OOzm3EoNjkzLiIeTwEg==
X-Received: by 2002:a19:674a:0:b0:4b1:3931:af with SMTP id e10-20020a19674a000000b004b1393100afmr15582699lfj.394.1669754816507;
        Tue, 29 Nov 2022 12:46:56 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b004ae24368195sm2325620lfr.233.2022.11.29.12.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:46:56 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 02/12] dt-bindings: thermal: tsens: Add SM6115 compatible
Date:   Tue, 29 Nov 2022 21:46:06 +0100
Message-Id: <20221129204616.47006-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129204616.47006-1-a39.skl@gmail.com>
References: <20221129204616.47006-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document compatible for tsens on Qualcomm SM6115 platform
according to downstream dts it ship v2.4 of IP

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 038d81338fcf..c41fcf404117 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -53,6 +53,7 @@ properties:
               - qcom,sc8280xp-tsens
               - qcom,sdm630-tsens
               - qcom,sdm845-tsens
+              - qcom,sm6115-tsens
               - qcom,sm6350-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
-- 
2.25.1

