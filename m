Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED066EB4C5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjDUWbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjDUWbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:31:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C281BF0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9505214c47fso375015166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116300; x=1684708300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2g3U63nRIt+0pZO4KBKXppHA/6UeQmjuddRYWTRF7E=;
        b=F6upLZwIvvNvwwzJXLj+OvRpi6fNfxlbXVIpY81r7ZwWu/nf/ydLHW87vk+kwodkSm
         lZKObOzLcmWD/TEax62R60QIqt23aunSUl2/aiNAYAscyLTXDH1flZSO8sLSfyf4yp8M
         9q0YJZPCGyj5lcHLWzTdPlP1QfGCMrZfGvmjXL0Obazfr8CKEY9xrqxIj2lPlzVXBS/V
         e3VRs6a0Pf4csuYVRrZQ4HIcBWPaWAUDmuyA5iFG0wPlpdHkbVP9ScxPQXYa0I2EnfkD
         I0nbm6PcD1n7YnHSG1h7mowsTtdvf2eEJNSr2vUTD5WQtT1IfJNQkRqPB9CsWyKNLAnl
         PWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116300; x=1684708300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2g3U63nRIt+0pZO4KBKXppHA/6UeQmjuddRYWTRF7E=;
        b=KFDUI6LD0hwKII6Lq6gOzBnMUX3SuCNhLPJKWtTa+lGEOWk0Ii39GUPVYbPQL7cLIB
         F5zX74iXdL4Qu3w4UzlSnSBAygpRO8AbD5BDQaOjaMCbdwNCgQFNyMPjPOZWuCbB7sry
         3/nGCMmbSdk8m41jdykfkVNV7X7nT+FZk0VtrR2XK1op64g6YW1jS5C3u7U4jxyMAN/c
         ddH7IOwGFnxfqyYxV4ZmjgKcu3sH60AmqT/ibKzAztInalQh9HpXbUtK9T8rUHJLAYVW
         RAM9yyP9AS/W374orbWkFp7BqljuXp9kOGmeyAVlRryY8hM+y9NjrCRVrZ6P2YaiUaVD
         obhg==
X-Gm-Message-State: AAQBX9eDahAl8LoYQVGS/UOxpNf8nwFUlpgrek2+RLr+2qP6peMtQZNp
        43qvwbhiT0CmdG9X93LXyfBUrg==
X-Google-Smtp-Source: AKy350YX4OiqSAW2vhECCVWVlHSJArUAJhNXSTm+C+pQdqSci6dlw9nXkZA9D9scqFJHk8F1NLEYcg==
X-Received: by 2002:a17:907:d29:b0:94a:6953:602d with SMTP id gn41-20020a1709070d2900b0094a6953602dmr3911628ejc.37.1682116300670;
        Fri, 21 Apr 2023 15:31:40 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709064a8400b0094ecf61289esm2576710eju.152.2023.04.21.15.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:31:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Khuong Dinh <khuong@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: apm: add missing cache properties
Date:   Sat, 22 Apr 2023 00:31:39 +0200
Message-Id: <20230421223139.115044-1-krzysztof.kozlowski@linaro.org>
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

  apm-mustang.dtb: l2-cache-0: 'cache-level' is a required property
  apm-mustang.dtb: l2-cache-0: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 8 ++++++++
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index 70a10bcafcff..377660d705d1 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -97,15 +97,23 @@ cpu@301 {
 		};
 		xgene_L2_0: l2-cache-0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 		xgene_L2_1: l2-cache-1 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 		xgene_L2_2: l2-cache-2 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 		xgene_L2_3: l2-cache-3 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index d73e809fe41a..efa79209f4b2 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -81,15 +81,23 @@ cpu@301 {
 		};
 		xgene_L2_0: l2-cache-0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 		xgene_L2_1: l2-cache-1 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 		xgene_L2_2: l2-cache-2 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 		xgene_L2_3: l2-cache-3 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1

