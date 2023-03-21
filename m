Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB986C3B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjCUUCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCUUCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:02:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3754955048;
        Tue, 21 Mar 2023 13:01:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id iw3so17244228plb.6;
        Tue, 21 Mar 2023 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679428895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1nihvRARKpi6tkVd5cEgKMlSNEP4XWbbAUmPmevZWQ=;
        b=CjACuUfhyvhaIzXzGcaoe9QWTR5Jz/iqQtv6C0/yrMk5u1TKxx1Hk8JipBXNwxq/yL
         +jG8sep1y3TnQmNSC9tbOb9zRT2iZwO9qRh/jq2wt4KRfjDY+Gnj09wX6WPfKw/kLxnH
         xN5/fUxqNoOLk3AMr4hcD2jP7wdNwEzzzlABLMLONUXXCieDyctkiFJk5Q1JC9NRT4US
         +SKLhetuSId8aiAjAmVqWCZG+Oc4zXKkOEgo2YP97ZOvE+7H5bi1IcrL8LVV+RGaxX+8
         CNhikD0yxRDCeUt7B73EQe6qCMzv4J89zmd/jypGKleLXslt4l9cCVkXMS7t2zacC/MH
         XCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679428895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1nihvRARKpi6tkVd5cEgKMlSNEP4XWbbAUmPmevZWQ=;
        b=nqjkygd0poQHRLuwgn4FJfXPE3tvzbqppUjetLw2ogI5OHtIrtY/aln6CHgFIsG76U
         S//oF2Nh3udF5isQvTm8hrSjTy+j1yxpUY/orItyIUah0fR0FzsO2hb5vbRTsW0E8gRG
         DQgjikt/0jpPD/3LdKyWOyJOOrxZyVLWGQmHt9vQJOvVDuZzZsuL8vBcR3ImjYNLJsZU
         tPOSqngq79cSihfOEMQYNMyYwX9M+8ErEi4DVg9Wj9LPlWCzR7UgG/swJk+mf/LFr9BI
         gYezlvjB/SXVDHjDWXc0Q63WJbylfAOJmZAc1JunsyiNGtBK33p9kq8bCicniJblvjrj
         doiA==
X-Gm-Message-State: AO0yUKW/xOmb2dvwJGnFGqx8gevQXKu9aEOXOVQqofJQoAu1k2+61tQD
        nxURSa+9U1xr6ltRMUjtcVU=
X-Google-Smtp-Source: AK7set8F65JGe3wLTlK+YBdnlSnoz0RsDKfPXUc5L9bSgdAL4Lckyv6SQkMu6m0vj+U87dovplxOuQ==
X-Received: by 2002:a17:90b:1b42:b0:23d:2532:ae34 with SMTP id nv2-20020a17090b1b4200b0023d2532ae34mr885924pjb.2.1679428894863;
        Tue, 21 Mar 2023 13:01:34 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id mt19-20020a17090b231300b0023b5528b8d4sm930557pjb.19.2023.03.21.13.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:01:34 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v6 5/6] dt-bindings: clock: Add Hi3798MV100 CRG
Date:   Wed, 22 Mar 2023 04:00:26 +0800
Message-Id: <20230321200031.1812026-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321200031.1812026-1-mmyangfl@gmail.com>
References: <20230321200031.1812026-1-mmyangfl@gmail.com>
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

Add CRG bindings for Hi3798MV100 SoC. CRG (Clock and Reset Generator)
module generates clock and reset signals used by other module blocks on
SoC.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/clock/hisi-crg.txt          |  2 ++
 include/dt-bindings/clock/histb-clock.h             | 13 +++++++++++++
 2 files changed, 15 insertions(+)

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
index e64e5770a..126b1f839 100644
--- a/include/dt-bindings/clock/histb-clock.h
+++ b/include/dt-bindings/clock/histb-clock.h
@@ -58,6 +58,19 @@
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
+#define HISTB_USB2_2_OTG_UTMI_CLK	58
+#define HISTB_USB2_2_PHY1_REF_CLK	59
+#define HISTB_USB2_2_PHY2_REF_CLK	60
+#define HISTB_FEPHY_CLK			61
+#define HISTB_GPU_BUS_CLK		62
+#define HISTB_GPU_CORE_CLK		63
 
 /* clocks provided by mcu CRG */
 #define HISTB_MCE_CLK			1
-- 
2.39.2

