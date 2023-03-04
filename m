Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BA66AA860
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 07:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCDGfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 01:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCDGfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 01:35:45 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BD75B5DD;
        Fri,  3 Mar 2023 22:35:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id i5so5010304pla.2;
        Fri, 03 Mar 2023 22:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677911731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWZVzjzMOpNR5BEvh4Q6TcLUcrqDcqkAnRC7oIHscP0=;
        b=jKnsb7cqslqYpiZZN6tyMLK2/CeN9KUmwEdLMbQXPjfsmIa5mtXaKnOBCKjn3T9izT
         Q0OYWAc4p5Ms5ne6bF0jqKmPDMePuqGmQJJXIaAuL7QTrGQtbM3XLS/MBhNdZLH0tfJK
         ZrqgLDqs/H9OkYyJOASutYH3rkPyAOrQKwFFpaBGlohsnICoYx4VzM1w3T9IqCWQ3Uk5
         ym99PhUE6JKMiC/ODqStKqMgvtbhJR0Xh3P6IpbYyFEA520qaQ33uHOHFmh/FivtyauK
         93BdOYgS90o8EcXuQKBnfs9jL/ozjFz3HEAkzvbbYCWIkBzuobRZBYQTnllya8Bnx2Dp
         +F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677911731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWZVzjzMOpNR5BEvh4Q6TcLUcrqDcqkAnRC7oIHscP0=;
        b=oTGY75+5uoKS01aeEK6o/uUG1D9vja/N4Oyiw4Hi8b/roWWpLOXjctgLdL5ufJVgPH
         Zmewc42lwfo0mzLBhymJxxBVpDbPqgsG9fmbtz+KCgYe2jxodxjOM1uO4YNDMyTmOsSW
         A91KOQDM59ihxNLpfB5dz8TDfjhE5S+U/LjRxxZ+zaqgt4Pj9wlYUWxccllO3plyZ4Vg
         45A8LziKqxpe/OsOWGm41R9xR0o82Aw74uY9BVo5hILj9b99DPWLuXxj8dx95f0YjOQr
         JLq9nI9OjGiHCBaZEkL6s+pwJ2pMeCxaGeuTs4eKDCdZUBsHvrq5lt/NdISHfaOetWl0
         DtQw==
X-Gm-Message-State: AO0yUKUZ50jIG3wW0zoJetVFG3IE72RK7Hq5SqYGWQXJgQnjR/50NI3i
        dU/3YF1oQAVLwj0Y+aw6/Wc=
X-Google-Smtp-Source: AK7set+/kaC4WKts9NrpX3aVCCBlIdNAy0IYKIlmL+ZdGq3SaJ6/DhieMyzuYo7EI5L3V5LIPgj0CQ==
X-Received: by 2002:a17:902:bc42:b0:19e:6a4c:9fa0 with SMTP id t2-20020a170902bc4200b0019e6a4c9fa0mr3840032plz.49.1677911730939;
        Fri, 03 Mar 2023 22:35:30 -0800 (PST)
Received: from y.ha.lan ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b0019aa6bf4450sm2520938plg.188.2023.03.03.22.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 22:35:30 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] dt-bindings: clk: Add Hi3798MV100 CRG driver binding
Date:   Sat,  4 Mar 2023 14:33:25 +0800
Message-Id: <20230304063333.162309-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304063333.162309-1-mmyangfl@gmail.com>
References: <20230304063333.162309-1-mmyangfl@gmail.com>
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

Add CRG driver for Hi3798MV100 SoC. CRG (Clock and Reset Generator) module
generates clock and reset signals used by other module blocks on SoC.

Signed-off-by: David Yang <mmyangfl@gmail.com>
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

