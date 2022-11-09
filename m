Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991AD6229DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKILMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKILMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:12:44 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A16286D9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:12:43 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v17so26697759edc.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdDDG+VwCgLPntFF4oa/ykOGwGyduN4fHiF8yU6o5TA=;
        b=w4s581JvQ2Mn8GOCY2YVAROxVhZovQ9F6aNxHdQUXuymakEOCP2ZNLp6bqPiYK7s6A
         4BW3fGjCZuZwV5NgN9p8Vg9pir2tqs3jr/ebZJPupmDhMxMXpJhTrMRCcVrYmypedaEE
         ee8A3Isajf/DU8pb9GPHuqc1u8s3bLijg/X/0inlV3eVtSSMl1mhQJZIdQQOknulHBFs
         6AgTOizdTJY77Iyilk3DbIagWrgza8v513pO8KYfT1CM6Z/spqAYZdDMZsXnlrP7RXt6
         qvl73H5cSVpXUFxRJFB/4qwcz/cBhYWfLKzvRdwr57mWPxV+Em9gbbnZUXecwwcYYkmG
         aLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdDDG+VwCgLPntFF4oa/ykOGwGyduN4fHiF8yU6o5TA=;
        b=o9eawc+AR2zKVOktq/65KS9k5Ojdub9lxe9QlEzkiRDzxXbTafVfGAYXM2mX5kQYVb
         yLPAV680PpLF5J2t/2RtPR2zCxV1Zy/Mj6l/ZxuYu6eb6LqwY4jw+pqtZrGkeL+lpkCT
         iCmLlSI/uHO4gJc7ljHQLuT32f90i4pIPvMAU5robDm4DMoMIyDSHd3jZoIW/cqj0NSB
         z/Enl/f24t3BJqUpkuETlkE/C83j1xOTJXb9VJ9Stv/D2Sb/9T4y5ed+c29JeOLyFnY+
         wmmB4IdYh3Syau+1NCaqU9zDQiNO1gXmi30hjCcWx/B5kvzRyXCp90vgHQVBiqzKUNo0
         P1sg==
X-Gm-Message-State: ACrzQf2/AaIW8t+KZeNrqTjOIQ3rSPFaGBbIEWiyjVYrbkMYhhoQdHsf
        jELAicn6dht7xC8Na5t5cJ/Q+w==
X-Google-Smtp-Source: AMsMyM6s7MoJlv0Fg8yZvsH1IMDvfa7NtIwgSGlQvWA4gVOn/ZBLMC2W12W0VttsA8gaNjq3FwuIZw==
X-Received: by 2002:aa7:ca50:0:b0:461:9845:d9d2 with SMTP id j16-20020aa7ca50000000b004619845d9d2mr59012120edt.163.1667992361655;
        Wed, 09 Nov 2022 03:12:41 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709062a4800b007ad9c826d75sm5825899eje.61.2022.11.09.03.12.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 03:12:41 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] dt-bindings: arm-smmu: Allow up to 3 power-domains
Date:   Wed,  9 Nov 2022 12:12:26 +0100
Message-Id: <20221109111236.46003-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109111236.46003-1-konrad.dybcio@linaro.org>
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
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

Some SMMUs require that a vote is held on as much as 3 separate PDs
(hello Qualcomm). Allow it in bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 9066e6df1ba1..1897d0d4d820 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -159,7 +159,7 @@ properties:
           through the TCU's programming interface.
 
   power-domains:
-    maxItems: 1
+    maxItems: 3
 
   nvidia,memory-controller:
     description: |
-- 
2.38.1

