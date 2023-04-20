Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF56E8A83
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjDTGgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjDTGgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:36:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357184C37
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:36:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fy21so3899219ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681972579; x=1684564579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e07kv/4q6KeHpZgMzvQluY3QgK3NgwgMWFjGACLw8Y=;
        b=CuzL+F/bOCk0vKDAq2RYc1Om8HkP3oHnFLGVDMn9JVHrHaacgZ+deX3dH5iwRJfoAS
         jv2/HaVAgJQVbBqQcgWIMoSQYoMN8D0kqfvIO6b+5R9h9aRPbw21JoDLJe2U3TEusbTU
         heEIDYF9Q4ubBnExtQLDNSFfYwf0f3Qo+qIwQRcMLIWq50MR23qNd+kTRM30gBMssGaB
         mGa5y2WASbYeeYbHlnpxzNRQpj6Ee0LpFg87W3U6OA2u4bmoJX1OeqwhgnX3+Tj0GEUN
         H2eSPnJya8CTdrsUMMiIaRVPFNVvQd449VmPm/bsDb6Ay+QIQFvgopzdU9147fGQyDIP
         71Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681972579; x=1684564579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4e07kv/4q6KeHpZgMzvQluY3QgK3NgwgMWFjGACLw8Y=;
        b=TUSDAoajFso89hvrckVywEvY39Wl2flG6RhPf1SO8VPHQG+NIolfIkBVD6lrW5D1uR
         iyhyG7tcbIWNevANHKy5dgy3h/IceLNpzuLG4AVzmxl2M/pPNuWjq+EmJV8Y5ioZEAwz
         jQm/dzL8kCtTdQyi2MACg89GYHgDuIVxdTz/XKAqvyCvqZGcizVvWoMj0yvfU3wVC06a
         ePWUao8AzZqOZBIxetcTyd4J1bTl00iJkkcvZ69G9jPNdAMvEnVBMxKXP4tivpKKdiPi
         nHEQXKXhK8jiI2O5DqC80bJESFJtD9a6L/DimsufwV7pF4e8FuWjtpgJxSgmegzN8dMf
         y8IA==
X-Gm-Message-State: AAQBX9cGVldZrPyOlcHCzMR49uBRn17KaWYi06LAY5v92t4ZpFHa311x
        5uZT8ZbmwnQZFxJBvXi4QHwPJUNS29ujIE9H1E5aMQ==
X-Google-Smtp-Source: AKy350bqe1e1XIOfR/Oepw5GKFqb1ykVNLs/2QCxPskYa55yeAANnIE8vp9q0wKOvtMJoi4xGhN5sQ==
X-Received: by 2002:a17:907:990c:b0:94a:7da2:d339 with SMTP id ka12-20020a170907990c00b0094a7da2d339mr606952ejc.26.1681972579673;
        Wed, 19 Apr 2023 23:36:19 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id f7-20020a05640214c700b004fa380a14e7sm395342edx.77.2023.04.19.23.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 23:36:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/7] arm64: dts: qcom: sdm630: add unit address to soc node
Date:   Thu, 20 Apr 2023 08:36:09 +0200
Message-Id: <20230420063610.11068-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420063610.11068-1-krzysztof.kozlowski@linaro.org>
References: <20230420063610.11068-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"soc" node is supposed to have unit address:

  Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index b31424544b19..a7d475f23bea 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -548,7 +548,7 @@ modem_smp2p_in: slave-kernel {
 		};
 	};
 
-	soc {
+	soc@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
-- 
2.34.1

