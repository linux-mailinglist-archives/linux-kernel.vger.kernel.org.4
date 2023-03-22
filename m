Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF096C510F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCVQoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjCVQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:43:53 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7AC64218;
        Wed, 22 Mar 2023 09:43:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u38so6710957pfg.10;
        Wed, 22 Mar 2023 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679503412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1nihvRARKpi6tkVd5cEgKMlSNEP4XWbbAUmPmevZWQ=;
        b=V0EKSYZIC9FkSe8GbuaSY3APPPQpgWUoWtgg+WIZJiUIQO7w0pRIzHbTXp+MYKKRmT
         4RXjX8la9khETyIjcM4rxZ+/PkVHmtXjsWzCL7wW6sA82Fgmg7DQSOoyGiZoC+P2ERVG
         UzVffFvJcQo0LB4Gt4GEpdSmYWm8tbsVQ0/MoblSj53UBEXknLRN/NegufSI0ruU4HGN
         nZxNwdmrNz8m9kouwR22QNCjmhxlVfDM5kQwvuXDyQqX3cAKIviaElO60WjbXaAyG5jy
         yiSlwRRgF0uw3ENRkjSg1emtGfufHHkDqmOC4Auk12wd2lWvMcUHkVEudqn/nnqvLk/q
         9cdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1nihvRARKpi6tkVd5cEgKMlSNEP4XWbbAUmPmevZWQ=;
        b=2/7aGkeW9rFoBVFwZkebWEDzIaN33+4LauEflCq2hpeC+6RcHXDWeb8C/vl5roOP6c
         3cXRr3A6k7pRIfYi8b86IUFjSyvyzzOU4eoZ19h0kYWket1R1xNOylB1M4z3/y7RJsBD
         R9O0XlNsjVIHhVFnCw+dO9aZRbOdbnrnScvk43sbRKpEcXeluoC8z6zZNHbYL8SruW3O
         +tr3EC7JhhtKddqQ/a4qDNoFi+P5mEFqzpkJE/y1BuO2CZLSbuMAIJZVrf/AanNQOuPv
         7GHLOWROk6l4lWGjRniuhKtVxDATnI+iK6qQxPeEhgKc16UyQpjHVEGfMbJ/Ne9JXIuD
         pWKg==
X-Gm-Message-State: AO0yUKV6uxuSvcqYsUbnD9jJ2zOLQzC7RUPT50o8IEbtYtvSA6sV0chq
        y2lQinJYmsyUFxFAexoP7UT9E8hpZhwYLI3zX2I=
X-Google-Smtp-Source: AK7set878e0TqrgGmu7WR2arqbldMx0Lis8xvmtncUtfD0g3yw1Sx9IhgqiDXib9zjHjcmZQ5IUo+A==
X-Received: by 2002:a62:17c9:0:b0:625:ce21:3b1b with SMTP id 192-20020a6217c9000000b00625ce213b1bmr3871105pfx.3.1679503412638;
        Wed, 22 Mar 2023 09:43:32 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id g6-20020a62e306000000b005a8bf239f5csm10300830pfh.193.2023.03.22.09.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:43:32 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v7 8/9] dt-bindings: clock: Add Hi3798MV100 CRG
Date:   Thu, 23 Mar 2023 00:41:56 +0800
Message-Id: <20230322164201.2454771-9-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322164201.2454771-1-mmyangfl@gmail.com>
References: <20230322164201.2454771-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

