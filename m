Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8066E725C62
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbjFGK62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239988AbjFGK5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:57:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E2E270F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:56:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f7e7fc9fe6so24454445e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686135394; x=1688727394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQnjXf6n+PPSf2TGQIgc/Oatr1C9hNRqkqVyGgL0I84=;
        b=WJfmJDzTP1/s8YeBsI1ZO6cn+0kZZcZTlHiP4g+Fr6zDi2b2M4C8LLyHYLKvSOx+JS
         tMIDq0jOUbF5U4PHnQPjLVcIGcoclSB18f5A95dFafu8Efk8curpv41riEISFGiofdt7
         3Alc71e2Fq+i67JfCAmngArykk4rmiLY6KCp0AweFaaSg5wIAVQZoXsKq7TDA70G5b5K
         baJCExWizsz8sRAoCigGFyoxUY2JcE2OPpjy6WmWdf2nDNmZvR1/9Y0dYNBKNH+cbegS
         EJti5oqo/DVhK/+nJh+mungcdQpnCi9hHRKrZqMDbI0ePd5iOQeb2SNa2AN5pV931UpP
         HniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686135394; x=1688727394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQnjXf6n+PPSf2TGQIgc/Oatr1C9hNRqkqVyGgL0I84=;
        b=Y+/KwDF7S7HAigNDH5PjzzKUIhJS6xlhoa9M/DGPr1WTPDTRAU+894PVejRin7lG4S
         BGA+2cbq/SL7ZvF3FUGo9gr/M1dLxMpHJZF0SiAiwovWN8lH1wteuaPmbzo+cZzZ1Ot/
         a5IcoiU4uieGeTuRx1cqM2xRZWW06tlz7zIXfo0j2HqFiqRBY983635DWCv8RIrhIMQJ
         M7mVz/H2jAMnusLn2SETSfFtI+Uz/x/ZdvFVCT8b4MsDUogByt3AAEYjG0ucJg7DV6Tw
         8HC8HcaT9JcWIEwJ6k1qQRcPao/TxfiAjdeW0eKo85Q8mZGALh31zgLwELTKTD9k2kcL
         sZ0g==
X-Gm-Message-State: AC+VfDy+PZhROrq4P6jq9z9zGyCmQdpaZ1WsX2VboDOKDECjFyPnXOar
        xQ1+7G17vfnmDXqn6TnkIA/k3Q==
X-Google-Smtp-Source: ACHHUZ5cXwmo/MWfhNmypSHBzjwjn9NyullgQyxGvM4scW2aLrMKTD+jwMVb/dse1YAMp/lapkodtg==
X-Received: by 2002:a05:600c:da:b0:3f7:f446:927 with SMTP id u26-20020a05600c00da00b003f7f4460927mr537815wmm.37.1686135394708;
        Wed, 07 Jun 2023 03:56:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f60faa4612sm1761879wmd.22.2023.06.07.03.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:56:34 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 12:56:23 +0200
Subject: [PATCH 12/18] dt-bindings: clk: amlogic,a1-pll-clkc: expose all
 clock ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-12-9676afa6b22c@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gAuzOf3W8TAOyXHYRakDqce4wcc2Qi6BuxU2eHHrAzM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgGJTmt/qkyDAbM3CpeCJiJ/KvV7WI5GoKcib9fF5
 1rR1fmSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIBiUwAKCRB33NvayMhJ0d3gD/
 wMTpGb5jYDYphrziFGF+VTrlmX9gs8hgVj6hhc3B0hCLCfl1ii5VVcR12dHiwOKooraws72ETnC7Cb
 gUuIF4j688cOQzkGrvvDKup4fDhW9zeon1luucR3iTOPecW99SANg73knW+QYNG+fPxofwXOkU2qBv
 iTJeauWpv/OQ0N0ik+G8akarLcqaxCfx7pOeL3dxw7FBIQlwVOeoMpeMQ61LCyS+vAMDL5BUk1/V1L
 UIIp0W/kWeGP9vMD52Cm8wUG5lBCzZzoWB37obmNGa1seebAwhpdR0sqKw7j+Liw0LsUUtnverCiqQ
 I5Nwojl+X9yF8pW2Nl699DKZa698qwseydNpUxOi3gBwkHvdc6bShEw3Xob+CBgtKWoI2vCTobB2dr
 dNAF+K7zxb/Tz9OC02CHFTPCOLDJ9UWJ/KrDLv24dQAn+pFuZijXLxiKeujFMQb533oz/K4tWZCuMJ
 AUZLCFKHsooLRRsGp+hpPXN1VNGO6SQv0SbOaD+hQtasQgmip/FhAxgQMevqjEronv5CoK0+9ewL0U
 tmgZVE9DKO6QKntdpGl1spuVrUkGvcdRqRRvb16kMkqpBg1ud0t48VVAslIQGgs3iqdtsOtxVfMoJF
 sGzpAy0yyvqIa7HARcbhZU5Nkwh6W/TCm4+Zq/uGw1EtW09MRbqTkphp8hzQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a policy change in clock ID bindings handling, expose
all the "private" clock IDs to the public clock dt-bindings
to move out of the previous maintenance scheme.

This refers to a discussion at [1] & [2] with Krzysztof about
the issue with the current maintenance.

It was decided to move every A1 pll ID to the public clock
dt-bindings headers to be merged in a single tree so we
can safely add new clocks without having merge issues.

[1] https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
[2] https://lore.kernel.org/all/2fabe721-7434-43e7-bae5-088a42ba128d@app.fastmail.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/a1-pll.h                      | 15 ---------------
 include/dt-bindings/clock/amlogic,a1-pll-clkc.h |  5 +++++
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
index 82570759e6a2..0add1c7ea9f5 100644
--- a/drivers/clk/meson/a1-pll.h
+++ b/drivers/clk/meson/a1-pll.h
@@ -28,19 +28,4 @@
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
 
-/*
- * CLKID index values for internal clocks
- *
- * These indices are entirely contrived and do not map onto the hardware.
- * It has now been decided to expose everything by default in the DT header:
- * include/dt-bindings/clock/a1-pll-clkc.h. Only the clocks ids we don't want
- * to expose, such as the internal muxes and dividers of composite clocks,
- * will remain defined here.
- */
-#define CLKID_FIXED_PLL_DCO	0
-#define CLKID_FCLK_DIV2_DIV	2
-#define CLKID_FCLK_DIV3_DIV	3
-#define CLKID_FCLK_DIV5_DIV	4
-#define CLKID_FCLK_DIV7_DIV	5
-
 #endif /* __A1_PLL_H */
diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
index 01fb8164ac29..2b660c0f2c9f 100644
--- a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
+++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
@@ -10,7 +10,12 @@
 #ifndef __A1_PLL_CLKC_H
 #define __A1_PLL_CLKC_H
 
+#define CLKID_FIXED_PLL_DCO	0
 #define CLKID_FIXED_PLL		1
+#define CLKID_FCLK_DIV2_DIV	2
+#define CLKID_FCLK_DIV3_DIV	3
+#define CLKID_FCLK_DIV5_DIV	4
+#define CLKID_FCLK_DIV7_DIV	5
 #define CLKID_FCLK_DIV2		6
 #define CLKID_FCLK_DIV3		7
 #define CLKID_FCLK_DIV5		8

-- 
2.34.1

