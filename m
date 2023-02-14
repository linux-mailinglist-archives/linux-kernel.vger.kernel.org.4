Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58901695E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjBNJKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjBNJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:09:59 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950FF24CB5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:08:54 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mc25so1023685ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWt3LYH3/eszNoBF9DRl58MX49iUtC5j5NaUzoPgKC4=;
        b=BLKgk2uYVpYd623GhmXngbIem3o5/4Ja7wB5VVqk5/GGO3MIFMhn+cqLX6OGFYNXrp
         VBUx001ombc1Sz9nqm/BGmlQy6PIrQalqePysVkGDYA26+La3PhmcP3OUcn1NhdDoGGb
         6c4MeKMCjOOPMF4Tf3EdaBgbhsL4FBek1InjKBBv3IPFDF4XumE4hFj/a/azdWqT9Cop
         4qJYHV/4Enqd1NlMC5HWvNN3Wh31/uE3M0nRqtKRLNn4nCpYxh3GL45yzAlsHk1BHRMf
         NRnTgQ7fD5CXmQs6FwSCVbRQr2GGob3mfeEQdWwV30qGDkDVq5KSQuf6k4NfACzoC3Zv
         SsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWt3LYH3/eszNoBF9DRl58MX49iUtC5j5NaUzoPgKC4=;
        b=Xc/VPM65o2BWMk8wMDqO/x5J8fmj5GQJv/waj6tqHHmYOzk7ocheaMBDMtZNcCqk7k
         vJ6E3Wu1VdfJkcBOMP3kWH3QIuYkfzAOCAO+PTX2vTNK3Z7D4D0fNdjav+Amok2ILSGH
         NxZduJfguuHe8TxbdljxukeswjL1sob0w/5mBUWH9I00fe1rZ9dHo1Y5beZwj0m8fPB1
         0hHbTzRRlbAzwpSAd2juX02R7RSH773pWmEn4YSV6KapcMpOsKTlUuHv4HCRVFV0R/7I
         B3UyGuyPtQEZ8WnLM+2b9P8K6GUlvjTYerrDkgm/ngo+vIKwWpvMBLNW0iW4W3xjtxLQ
         Ujyg==
X-Gm-Message-State: AO0yUKUUPyOkcCHbv9Q8alQQcO06Tbpbr36EARfrIs8jxSeecpT6Cq6t
        ktLpJfZ6GKI+lx+CFXV+gseRjQxH0ueypfxG
X-Google-Smtp-Source: AK7set9Tp2XWrms9/AHj3EygmaZhp6J5Dtlo4+AuLB/kDv9YuT76Sh6vm1MiOGttQGNwsgdEwlfJeA==
X-Received: by 2002:a17:906:5fca:b0:8aa:9a03:356a with SMTP id k10-20020a1709065fca00b008aa9a03356amr2277522ejv.49.1676365733194;
        Tue, 14 Feb 2023 01:08:53 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id d6-20020a170906040600b008838b040454sm7998110eja.95.2023.02.14.01.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:08:52 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: power: supply: pm8941-coincell: Add PM8998 compatible
Date:   Tue, 14 Feb 2023 10:08:47 +0100
Message-Id: <20230214090849.2186370-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

Add a specific compatible for the coincell charger present on PM8998.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:

- Pick up ab

 .../bindings/power/supply/qcom,pm8941-coincell.yaml       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
index 0450f4dd4e51..b7b58aed3f3c 100644
--- a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
@@ -16,7 +16,13 @@ maintainers:
 
 properties:
   compatible:
-    const: qcom,pm8941-coincell
+    oneOf:
+      - items:
+          - enum:
+              - qcom,pm8998-coincell
+          - const: qcom,pm8941-coincell
+
+      - const: qcom,pm8941-coincell
 
   reg:
     maxItems: 1
-- 
2.39.1

