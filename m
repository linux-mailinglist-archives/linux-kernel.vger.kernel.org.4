Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFF95E7394
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiIWF66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIWF64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:58:56 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9E1122616
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:58:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so4391567pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rwMiBvWSS/3nWfWiA9SzAK1R2kw10DliI9eL/5r27lE=;
        b=Sd8bjcCNxsBL5738H1v/jVDN6nn+TV/uZ36+gx02vOKcYnnKjYJgZtKFDaRV3QKPDb
         dbjiB+L6pEsvw2kXoMM8lbjmQWPOMAO1qX5VeTNHnFgnzmeMZbhlkTtNY+6ZEW4tKbLJ
         0EmvW3nTVx+rz2LwcmoN9YK+Po4pZiOPT/O8rpmyaIejvuZ4bT9RlGkVx0KxzTHPpxxV
         0NKE3DAzTLQwJjp+Y3u4AegaDEqBkcNnN3PaFLOYqCU7yI2d6wWTPJ1xQUChkKUwj7qs
         8Q6uGi+tIjT83RWW4EJi00S+GoRImtwS49vmMD1B/SxqERiIrJqxTwbKUx+CPebQtPmF
         bduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rwMiBvWSS/3nWfWiA9SzAK1R2kw10DliI9eL/5r27lE=;
        b=NhddMnwCZ7+IsGkUOg3BDPwfP7Qk7njaAAhxU0ZElA1E5cHplduRYcaAAFIcY/rtPY
         ZvwScoLDx6XDarXAwVIqzaOXBD+4c2vh4WonT3TTMQsFEfcbyEu2VSJZ1DD3va7SfEd3
         Incgv6M4+Hxfz9VRZ9Bjv2pJiQ+1IrNtxxwTRw+dkPNIK3YVjefwByccjKBjCY46U1dY
         FZ7QsfhHrk+qLuMK2DPmB4+a/1h8ECNUQSgxQaYmYADShrvjbv7/x33hGj1z88vp1P0q
         KsxnuQ+ojK/OeKYESFDZkL0x8l/HBJIG8Ji4dIzna8fBTAga7R2O+JA09J+vJ/YL7kZS
         KpZw==
X-Gm-Message-State: ACrzQf2HyxbxvVEj+HaOeNjNXkPBIkjVOIKRoZBS+8Xqc+JTViaDjN4C
        FWvmugxDbf8/P0XhFy4bUySNqc3rGqDtrA==
X-Google-Smtp-Source: AMsMyM6tuR6y4a/Y5bPUPxWspG58kKyakm4lsVIgZPPXHbjbyWtwBF3iFyw113NWgKSGgQHjzp1eUQ==
X-Received: by 2002:a17:903:240b:b0:178:a475:6644 with SMTP id e11-20020a170903240b00b00178a4756644mr7087596plo.96.1663912735328;
        Thu, 22 Sep 2022 22:58:55 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b0017532e01e3fsm5075638pls.276.2022.09.22.22.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 22:58:54 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Separete LTE/WIFI SKU for sc7280-evoker
Date:   Fri, 23 Sep 2022 13:58:05 +0800
Message-Id: <20220923135629.1.Ide53082044aac56877c4ff5725777769e377476a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923055806.2556746-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20220923055806.2556746-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

evoker will have WIFI/LTE SKU, separete it for each different setting.

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
---

 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index b6257683a700c..065d9cc4421e0 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -575,6 +575,11 @@ properties:
           - const: google,evoker
           - const: qcom,sc7280
 
+      - description: Google Evoker with LTE (newest rev)
+        items:
+          - const: google,evoker-sku512
+          - const: qcom,sc7280
+
       - description: Google Herobrine (newest rev)
         items:
           - const: google,herobrine
-- 
2.34.1

