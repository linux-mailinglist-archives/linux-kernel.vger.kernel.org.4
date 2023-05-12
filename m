Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6D7008B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbjELNMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241004AbjELNL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:11:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DB611579
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:11:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f4ec041fc3so12923635e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683897114; x=1686489114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCif7crIj/Q+cQYJxHIAitbk8dIOcZs5cJxa+/QObN0=;
        b=d8ReaVAZ8FGgRG41sHZjy5aJxvI3k2Wxp4ywR4UuUr6DVd2z5pq9ae5LRlfNCDj1+p
         7fCHM6i6ltr+pof+tk+/99AhTvsaEROv0fDEUbnyqZ3GkOOcMGSFiVJZf83V58DI6SKF
         d3cVUKbXyCUEN2qE1ckHhgmX7K0Q634+q/QgMoI8DzozrrSaDV0OnDnHyDa5ITpUY6Lb
         1+I0C8qZ+RDN5waxpoQSRXmhDt50GuLNA17VlhKV4STibWDY1vJmE1bCPSfHe9qsHm0m
         xyl+25xAA/ZflITwDnuw3j0QLRIaeLpdQRZNUXmjOUQ7XVTr8bs6vjUW1fz8zVwJt9Qu
         mnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683897114; x=1686489114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCif7crIj/Q+cQYJxHIAitbk8dIOcZs5cJxa+/QObN0=;
        b=PZBkQP2+aNNbkYFxrWJ/ltLjvMIDchYs5o5gD5nhRZCfRb/uc218+BQ7T2dK5IJieu
         GbheUb93a4AC3dKmTWHCivaJCswJ6mP2Z8TbTLPw78O4i9WW96f55thE0n3hy0MpqghB
         RsfI1tMKujRbXgtpcsug0hvzhSW3bgS1hH8uZnjmpSb4qyDdMhBZrrm4LQ55vvm0soCX
         U6w+qUA5E1LGtEEYiPFEx3+8ZeM+Xt+8Ury123wvawouUddZM8z64GqAwg8qMWxlYaeZ
         Yn+LBvi3k9oLARhuEEq/JKT9g5uJRhVA0rRhPRQ7H5svJxIMBQilS26FAPzjm2AAeyGd
         DOwQ==
X-Gm-Message-State: AC+VfDx3hX3l0o2QJHnFRjdwLMHjI+TzvEYK9XHiuxxYe1m5/sjdjjLM
        QczphwPHMMjWxRJ7w5Fioj+iqA==
X-Google-Smtp-Source: ACHHUZ67QEpRyPnXTffp6qINy4JaH1a0QStphnwTn26loxuM1R3NTviMro+OSSlZwLxGVtNT1UsisA==
X-Received: by 2002:a1c:c908:0:b0:3f1:662a:93d0 with SMTP id f8-20020a1cc908000000b003f1662a93d0mr18456984wmb.15.1683897113972;
        Fri, 12 May 2023 06:11:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d610a000000b0030647449730sm23461965wrt.74.2023.05.12.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:11:53 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 12 May 2023 15:11:32 +0200
Subject: [PATCH v4 01/13] dt-bindings: clk: g12a-clkc: export VCLK2_SEL and
 add CTS_ENCL clock ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-1-2592c29ea263@linaro.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Amfvy8AIRpoaKCjLWius5WoZ7OLXQo8QlfjTgDRK50c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkXjsS/xb78nbVwpTmjP+QuEB7+O3NBa/QB86INXFY
 Y60FIeGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZF47EgAKCRB33NvayMhJ0X5HEA
 Cv0kyCcpaM9ud6vdmE+8t+V2OnX+Mm51tFsvYR9LjCMrDENGe0d+m2dWigi7JMMIeeuq/6n5RPjxHH
 RvrZm2Za0/sedwLuQ4DCdU+GT31rwcEEb/bE1Qp8lxgke+/bOTdNEiEhRNy2HlmjDgJ/AbdJ62Gfjk
 wlJVjS03B3cCwn5+/LxSlkhS9PBZIUXb0DKUkagnejQemxgKwBzAHCbjRCIYe1zQqE8x8Tbs0hHdUM
 xTRkhuRQfna7zLvtOHJezV8ZhjrOFjri6gFf12S/7KQtmDLIUkd8U4AzuHnRCPsj7iKHM+l9jQi36J
 FwZjxKeKUN+Jl2tAdqe2eO4odBHCCVWri4iDCwteEusAI/HwBQp7A0seEAxMvHMXei/sK5uFclitUk
 WdQlZAmmF5uSUi4Yk8krjGgRhsOGNA6euakrseK4XeCZ2dVRJGDH4qR52yWQsT3Jrw2qmrc7QyQ1kP
 vO/+xWZbE+kCjpmCxsXoxo9i4A1SCCjeo1Uw/EAOLfoNagbC+3eFG01Q2ERk7O0seC3PshCSNCyhee
 WpRXRRmnh5L5RXeKBAzbkh3d9/YoJGNY77075Pdm2Flgu4BS58cjeOvLP9b5cN6X82ehnyPfaxKuS1
 66zRZSxKi92sCRDxQUDmdLQ1MtYZNR4in/ZxcB/sXPzen1Y+6sbOwNSl0BUg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose VCLK2_SEL clock id and add new ids for the CTS_ENCL and CTS_ENCL_SEL
clocks on G12A compatible SoCs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/g12a.h              | 1 -
 include/dt-bindings/clock/g12a-clkc.h | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index a97613df38b3..1a4a626c2c63 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -168,7 +168,6 @@
 #define CLKID_VID_PLL_SEL			130
 #define CLKID_VID_PLL_DIV			131
 #define CLKID_VCLK_SEL				132
-#define CLKID_VCLK2_SEL				133
 #define CLKID_VCLK_INPUT			134
 #define CLKID_VCLK2_INPUT			135
 #define CLKID_VCLK_DIV				136
diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index a93b58c5e18e..80421d7982dd 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -108,6 +108,7 @@
 #define CLKID_VAPB				124
 #define CLKID_HDMI_PLL				128
 #define CLKID_VID_PLL				129
+#define CLKID_VCLK2_SEL				133
 #define CLKID_VCLK				138
 #define CLKID_VCLK2				139
 #define CLKID_VCLK_DIV1				148
@@ -149,5 +150,7 @@
 #define CLKID_NNA_CORE_CLK			267
 #define CLKID_MIPI_DSI_PXCLK_SEL		269
 #define CLKID_MIPI_DSI_PXCLK			270
+#define CLKID_CTS_ENCL				271
+#define CLKID_CTS_ENCL_SEL			272
 
 #endif /* __G12A_CLKC_H */

-- 
2.34.1

