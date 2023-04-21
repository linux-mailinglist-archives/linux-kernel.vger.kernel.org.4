Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDC36EB4DF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjDUWdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjDUWc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:32:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C1840E7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-957dbae98b4so46825766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116322; x=1684708322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGbqKEibd3fwhC1p0xTa7f0+Nt4UVwQ3Dda/SlXVXMo=;
        b=ejgwU/zLFMJU30IbRhhwfB981rOb/bUuGuoab2cmHftraQ7iAh0wotFxpmHg8lXVtg
         Q1ZLSKudQF38x30PUGTgPldHr3KyF7ryHaLx7QzobSIp0TfdOXlvIkkjMkzcfKuyIAY5
         Esk3WeBUVc9cP1QHTg7W1ZKoR/jzd8BAD9JIOVexUYHz+yAMsP16K/YtHea/NJKJbvSP
         viQfnReOf5B2eD2asqT8LyrTWwkeHJuuQ3Zuq3ireJKjaR3Yj91WnQ+WsuoRNUybPRtD
         45kBROCsb2EB+MwdsoXhuqHN6rxQOpLHo1vlDFP6iJ3FwQ5JgbY+qZ60hk1po26S+p/e
         qE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116322; x=1684708322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGbqKEibd3fwhC1p0xTa7f0+Nt4UVwQ3Dda/SlXVXMo=;
        b=fXC/jgz08lOwCgQyB+ajZbzNHhb+XEgNlQqnbKRT68/LxTsgXRULQk3h1LhzkgIFt7
         e0zBLyydRXG793RJxEtwUNLO1vZXD4/9UKyzqy7Lf8465o4jh293CUeNXvIZoURs0n8R
         N+l7r5PM/T/wJRJGMutHniQavjwb9neHIRCi19NjfhCkjSX4mHYAE8JMf8iGdQR/ZWHd
         bmdJuxW+qJFKFzSp1dJdS9IcGmqo+b95M2FprwWrDza2vTW9h0sle6+TodkPPVDDFIQf
         mnNGd2Y5vUgROcigqS2wl03pmP0zOLTmNlNDex1i9pGdnuBIHS8KvuFCdbJt1gbDT6gT
         uIOg==
X-Gm-Message-State: AAQBX9ej7nsnaOblmitgxPM7jtvwPCJIeZkw5OuPE/C8XxXO9MEm/3nl
        1z5IVXPe+QKaZyX1lpdL+0Hw5Q==
X-Google-Smtp-Source: AKy350bnFpPMzRk4epjWaB7TZnJc7V//aWJ9SyUhjyPnekgQx2AWh4A6ghkP5rVUGe80GAvnDKw9yQ==
X-Received: by 2002:a17:906:3a81:b0:94f:3eec:f6b5 with SMTP id y1-20020a1709063a8100b0094f3eecf6b5mr3568883ejd.57.1682116322467;
        Fri, 21 Apr 2023 15:32:02 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id w15-20020a170906b18f00b0094f2c74401csm2534399ejy.203.2023.04.21.15.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:32:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Chanho Min <chanho.min@lge.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: lg: add missing cache properties
Date:   Sat, 22 Apr 2023 00:32:01 +0200
Message-Id: <20230421223201.115439-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all level 2 and level 3 caches are unified, add required
cache-unified and cache-level properties to fix warnings like:

  lg1312-ref.dtb: l2-cache0: 'cache-level' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/lg/lg1312.dtsi | 2 ++
 arch/arm64/boot/dts/lg/lg1313.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
index 78ae73d0cf36..48ec4ebec0a8 100644
--- a/arch/arm64/boot/dts/lg/lg1312.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
@@ -48,6 +48,8 @@ cpu3: cpu@3 {
 		};
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
index 2173316573be..3869460aa5dc 100644
--- a/arch/arm64/boot/dts/lg/lg1313.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
@@ -48,6 +48,8 @@ cpu3: cpu@3 {
 		};
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1

