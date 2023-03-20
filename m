Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC74C6C230E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCTUmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCTUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:42:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B7C1EBDF;
        Mon, 20 Mar 2023 13:41:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x15so3137214pjk.2;
        Mon, 20 Mar 2023 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679344891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1nihvRARKpi6tkVd5cEgKMlSNEP4XWbbAUmPmevZWQ=;
        b=a0HcIxFpIjo1lSgr+MxW8pudqshXcHw+BiPZWFvBtQqePhHvgvVEQVZdmnTDBmMDK7
         CmY91u5/YP6ybN/4gdZa8q8Mgky1m5JbY7TEnEZvulms39aEHxjr7Gf+psuJinYYj9cj
         tQAAVEnc4BPk5+UErXx38+ddx4LMuOzQaHgrcnEVEkmD1KOxTkCCqgAEGWlyOb7pT4SK
         LH9Rs8k5OVkK8NEwmDJmgpHNxtKcCBuGfvxI4+gLk40kdj/ZBp/MpdPdAjQbjiscQZd4
         BS0SF8pqdy9NPUsz8F4A8dlnswapEQueHbN8FdH3agnrJmmSH0HgmvtdrgUKAAgRryhY
         UHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1nihvRARKpi6tkVd5cEgKMlSNEP4XWbbAUmPmevZWQ=;
        b=ei/3sFtFHynA7Q8IIOVuBQd69OGvue3l/NSyT/M0lzf1MvboJMfCqUCWvCZ/JI+rG+
         W4Cj35DMfanwiyY9zuFH+noJ6qSGaoFHC3QX830quLGZihZ/VaLvF6uH8ebaP7DwXZYC
         NGZXGuDH68wd0RTSuktNawsnZ2+19qqs+cah15wQm2FfjJzCKx3suqELsN9YLvQS46Ec
         n6iJbEJgICydnj3SxvJuwYsqjxNj1bqZm1+Hvw9LpvJMgf3SVvQnArTn9MffOLjkQ/uR
         oXxJSOK1H0oSerb8us5ItJbWK0aOEWUED0j9KT+m2PVam7Xvyy+TzyoiqpmEr9NLL34z
         rlIA==
X-Gm-Message-State: AO0yUKUAyFu/8q6U+32qUcXxjCbSQ8rMJyAjfACTtZVIY+T8seQBNibt
        E84jvl+C9rndy1ZbnwWrI9M=
X-Google-Smtp-Source: AK7set8RQR+fc+qe2esmHZrxVXZ0nOPF1zAz+mZWdv/urEMxOguZoqyh1B3Hr75AJXbELY1VcDLbxA==
X-Received: by 2002:a17:90b:1a8e:b0:234:e3f:f53b with SMTP id ng14-20020a17090b1a8e00b002340e3ff53bmr454210pjb.21.1679344891331;
        Mon, 20 Mar 2023 13:41:31 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090aa60300b0023b29b464f9sm6580943pjq.27.2023.03.20.13.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:41:31 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 4/5] dt-bindings: clock: Add Hi3798MV100 CRG
Date:   Tue, 21 Mar 2023 04:40:37 +0800
Message-Id: <20230320204042.980708-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320204042.980708-1-mmyangfl@gmail.com>
References: <20230320204042.980708-1-mmyangfl@gmail.com>
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

