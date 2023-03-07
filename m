Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86296AD5AF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCGDZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCGDZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:25:29 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC74474E0;
        Mon,  6 Mar 2023 19:25:18 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y11so12764877plg.1;
        Mon, 06 Mar 2023 19:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678159517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+r5LB1ScCiwCaXz98J1ydT384/M87g4C2BNKjaKZ/lk=;
        b=WLMvzGKPPRcQ8jNslhBYT9iea2kUra3wGW5/jJyVJmnY/7mPGDQAYhJb6g3IOqiPRz
         EUfu6rZRQQGcDQnpQF8uPKkWy8ue5xMRGEjatKD6a1E6QMQa6BzMXxA9Dq5UfTUcxLxJ
         4DznQ4ewyURITugOncQMo+plShsUa3yW+hhvb7TgWBZckQPJR9Uy+ucKf/vCvEGXGYLr
         gQzUA7LDDxvjbz0IqYPQUjXRgBSfjyNNsvTo6MrZOJ9jr0VTNrWoLDYLKyNzN6QDHoj3
         Qj0Zxsa653pD4O5DUaNDsFsUXzRVt8wlHEfuaK15XDXXg/5KZL3aCCB+Ir4rBVXq8mBK
         yFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678159517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+r5LB1ScCiwCaXz98J1ydT384/M87g4C2BNKjaKZ/lk=;
        b=pvgfGt51ewpodBV5dci880g998sO4e9JJPlkDeMhARe8hSZ/uBG7K6vO85HVXFCt5G
         n52B83YvjGgp1AXThAtjyqt1GUB7CpcAWf1oAPZu6rjzY8O9nq+0ck6pKNPhBHQAXBxI
         oHE6OCR/yWTXqzhi7d+aY1Bo1svbLRkuXJXrSO+nlaI02TI/gv+Q4RP0WQttwpX49TCc
         4ohdVf3+0PZrxBOsh8y4wvDjXxQMXOveTn9or5D0ZaK1MiAed57JgSv12GnS14hxD3LT
         610e2aCf6Mqt6QTZH08PWXYhIgYJ43an6DOUqiYQC0ukBRob1KNACuoZsndXH8A8A3dD
         SNAQ==
X-Gm-Message-State: AO0yUKW1BmrWd17awlytUHDazrZzL/9f3FvRiRAODLSokCNR9qUFmj/M
        Dok27Z8YMdjGGmz5YPGDjo4=
X-Google-Smtp-Source: AK7set+NrokHDJczFcHChaYwmN7CegfzCttEbjNrMljgi8vPigmLHwGYnG2djMLVH6w/Nca3feEAFQ==
X-Received: by 2002:a17:902:c40d:b0:19d:e58:66da with SMTP id k13-20020a170902c40d00b0019d0e5866damr15334897plk.24.1678159517575;
        Mon, 06 Mar 2023 19:25:17 -0800 (PST)
Received: from y.ha.lan ([2a09:bac5:21b4:1246::1d2:a])
        by smtp.gmail.com with ESMTPSA id d16-20020a170903231000b0019a997bca5csm7380022plh.121.2023.03.06.19.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 19:25:17 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/4] dt-bindings: clock: Add Hi3798MV100 CRG
Date:   Tue,  7 Mar 2023 11:22:37 +0800
Message-Id: <20230307032243.14988-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307032243.14988-1-mmyangfl@gmail.com>
References: <20230307032243.14988-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CRG bindings for Hi3798MV100 SoC. CRG (Clock and Reset Generator)
module generates clock and reset signals used by other module blocks on
SoC.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/clock/hisi-crg.txt |  2 ++
 include/dt-bindings/clock/histb-clock.h              | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/hisi-crg.txt b/Documentation/devicetree/bindings/clock/hisi-crg.txt
index cc60b3d42..972c038c8 100644
--- a/Documentation/devicetree/bindings/clock/hisi-crg.txt
+++ b/Documentation/devicetree/bindings/clock/hisi-crg.txt
@@ -13,6 +13,8 @@ Required Properties:
   - "hisilicon,hi3516cv300-crg"
   - "hisilicon,hi3516cv300-sysctrl"
   - "hisilicon,hi3519-crg"
+  - "hisilicon,hi3798mv100-crg"
+  - "hisilicon,hi3798mv100-sysctrl"
   - "hisilicon,hi3798cv200-crg"
   - "hisilicon,hi3798cv200-sysctrl"
 
diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
index e64e5770a..5042c2a7a 100644
--- a/include/dt-bindings/clock/histb-clock.h
+++ b/include/dt-bindings/clock/histb-clock.h
@@ -58,6 +58,16 @@
 #define HISTB_USB3_UTMI_CLK1		48
 #define HISTB_USB3_PIPE_CLK1		49
 #define HISTB_USB3_SUSPEND_CLK1		50
+#define HISTB_USB2_UTMI_CLK1		51
+#define HISTB_USB2_2_BUS_CLK		52
+#define HISTB_USB2_2_PHY_CLK		53
+#define HISTB_USB2_2_UTMI_CLK		54
+#define HISTB_USB2_2_UTMI_CLK1		55
+#define HISTB_USB2_2_12M_CLK		56
+#define HISTB_USB2_2_48M_CLK		57
+#define HISTB_USB2_2_OTG_UTMI_CLK		58
+#define HISTB_USB2_2_PHY1_REF_CLK		59
+#define HISTB_USB2_2_PHY2_REF_CLK		60
 
 /* clocks provided by mcu CRG */
 #define HISTB_MCE_CLK			1
-- 
2.39.2

