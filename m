Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3DD6724C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjARRXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjARRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:22:57 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B5E56EE7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:22:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id q8so13439198wmo.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTHrIMlF4V0ckFLxeB8DR9WhaVsZX5PbMH6MIzdQoL0=;
        b=OIPxQXahRqIyc5S3hnGhKnpU7KIAvICxeR/SBr7HP2wZIIz4A9gnLFxLRxkHKn03aD
         goy0kke/murf5dzTgMiZrklMxeeAlCQO+rLg553Dho2NwigPzGTo6wTf7eMDkxPDDKXO
         1WyY9nS75tuJlM/cW7yNuVcMLK3KzY+z98jLzpWIKSP8Zf3m3eUDUTS0bw9avJGdVsMK
         co131aVlmKeyoBU991VDl+S3DsSGDhA6CboymqEvmLiy6Cqlhf3rzaSTa6DPrSiC8Bwt
         dQ62n5lydam+cz4AW26aoLKUcVw9rwZWh5tN93Y7fMZv+6PlsuPMXRb2CfysyPTf30jk
         JiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTHrIMlF4V0ckFLxeB8DR9WhaVsZX5PbMH6MIzdQoL0=;
        b=ZLA7F1xg9FDjwrUoXP7T0796qMPaNq4BsKix+w772B3lB26TZpJdyFH7WPqT7dlMv5
         jnya10gD2+mWGernAhTpN/nzSOpqfMizlWRLHAR/ZQa1ILOOPDf7zEFJEWtPBMckqWUA
         XwkoKS0tzH3IM3azhH4Qv966mAqSJ27tJxM3tWuAbc/plUqPpbwJysfSgVpMgzskL90N
         MFfYb4yz2uwWJmEFkoZb5htSoETFNd1hRfJnR3xKPb5LsTwt1YYtuL4jGjqmYxcozv/h
         EyAEFxe4YNdJguj1CNVO0XX6PiWvAbrgu+uJXS9cCxx+6uTINH0HHUiMvztz0HG04KSu
         4ETg==
X-Gm-Message-State: AFqh2kr6JfHLmM8/1gcogKGL8kG35+XFKIXK7721ZcRTyaR58Thny58D
        x7oYDcbSzc+yrtZ7ui0AN/K8Gw==
X-Google-Smtp-Source: AMrXdXvGjjiLYQ6mh5t+ATqJa4pO1oWDgd9qn6J8/i6FO8XyLtcEOWAPZhSbqIBeo1hXusYDmYMDvg==
X-Received: by 2002:a05:600c:1d12:b0:3da:ff82:f627 with SMTP id l18-20020a05600c1d1200b003daff82f627mr7760045wms.25.1674062573622;
        Wed, 18 Jan 2023 09:22:53 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c215400b003d358beab9dsm2434746wml.47.2023.01.18.09.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:22:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>, Kun Yi <kunyi@google.com>,
        Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: hwmon: adi,ltc2992: correct unit address in example
Date:   Wed, 18 Jan 2023 18:22:36 +0100
Message-Id: <20230118172237.349111-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

lower-case hex is expected for unit addresses:

  adi,ltc2992.example.dts:22.24-38.15: Warning (i2c_bus_reg): /example-0/i2c/ltc2992@6F: I2C bus unit address format error, expected "6f"

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add Rb tag
2. Reorder patches to silence warnings.
---
 Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
index 64a8fcb7bc46..ec984248219e 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
@@ -59,12 +59,12 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        ltc2992@6F {
+        ltc2992@6f {
                 #address-cells = <1>;
                 #size-cells = <0>;
 
                 compatible = "adi,ltc2992";
-                reg = <0x6F>;
+                reg = <0x6f>;
 
                 channel@0 {
                         reg = <0x0>;
-- 
2.34.1

