Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D79657695
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiL1Mnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiL1Mnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:43:40 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C10F3C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:43:39 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so23489908lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wyLEEKIyqkAjb9IQ0Oi9TdXRS+RdmpHpVD+IMGR2Kbs=;
        b=Y2dv+v5dkIAzONv9TPRC7w/+PzHLta6hYhIHZA/4acoueQatOfsspyB144denkYekh
         DuJ+mf9M+cyqWx//dBNZLvQTnyDQF06A5/ilUVpYmS5LgDZMWRDVwORd9kDBj+1CxTLY
         qOXWKtrgCb0n6HOCoYN3in5OJHIzAoBVOW6OtIv3/yeLi+0TJ1b+oM2Ib9nJ28ThxNwf
         y55psogOh1MG0bszg1YtBGJ0F4+fqqnxsNCm/nIkIoSSRIQ27vxyX391u3EtdCUyV6F6
         zqNKnm1ObLwQMYxYNLaareaMMPDTUIA6la9CXa5VTuPVyYN0dzSRgyyKWwz3knS0tl+r
         9KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyLEEKIyqkAjb9IQ0Oi9TdXRS+RdmpHpVD+IMGR2Kbs=;
        b=g4+8AIVgyvAKgzOnsfOVSR2+zG/yu4I0TOp8yJMVrqNY/xPdt+vpcjoibpZ3v4j047
         Ht3ULygVwu8xhFnfx4/zIZAHfRQCZOxMGqZsl/2xPRvTmX9Hni0F+lCG0iRHgX0Xp5GZ
         /WebfUT6bvDDigHeu/6l1NckuuYwAvIC3CnixFSwasY16WM26yb3cYZxHlbyppYJ5Yg1
         3Rkfbxa/JaPDT99/KehOCpuFRjv/2hwRUe/fMmMWwfEiFwumguC4pB6Kl4fLe/vZWvZB
         dmz424w9pf9VOoDZKyiJtdgApOZliZa5U2Xq0d0f5SmPyHI42U0nwfDOOsqZmBrufbIM
         PDhg==
X-Gm-Message-State: AFqh2krzwR559I6IcxwtP67jW35QbaHJG/EMqmGGlPjJGdExJUBP/s+3
        DuNvponv3MwJGDV2aBf1uFqEng==
X-Google-Smtp-Source: AMrXdXtJknrPqpsSn+QPvuHwcVlU6sMMhCqPKVdgnUPn88kT7MU7FTU5h/obHREzhpHJTWFCmh6zMA==
X-Received: by 2002:a05:6512:398c:b0:4ac:ec52:e063 with SMTP id j12-20020a056512398c00b004acec52e063mr7993973lfu.29.1672231417668;
        Wed, 28 Dec 2022 04:43:37 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c1-20020ac25f61000000b0049f54c5f2a4sm2647356lfc.229.2022.12.28.04.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 04:43:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: ufs: qcom,ufs: document required-opps
Date:   Wed, 28 Dec 2022 13:43:31 +0100
Message-Id: <20221228124331.258416-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

UFS device node on SC8280XP uses required-opps:

  sc8280xp-crd.dtb: ufs@1d84000: Unevaluated properties are not allowed ('required-opps' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index e53c6e203ac8..41ac2fe861f3 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -75,6 +75,9 @@ properties:
     minItems: 1
     maxItems: 2
 
+  required-opps:
+    maxItems: 1
+
   resets:
     maxItems: 1
 
-- 
2.34.1

