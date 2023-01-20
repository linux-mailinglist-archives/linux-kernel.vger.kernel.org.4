Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E667674DE1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjATHR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjATHR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:17:27 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19B18198B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:17:24 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n7so4000777wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0I1MbD84bKa2Xlc/6S1re+opXt5OEOEJKlQhPxCq9t0=;
        b=DRUlODin9ntS3nq2rmjeh6+Lc4AnEgK20U7U0G7oUOmj7jwTv4dGaNBltMxzb6gGx3
         Jhs1lpUoeARdHpluvezerVyL1fXOsnEIiPMUDkFLIg1rBnJcKqj3cF3Eq97cTCu96Iac
         v5yBGDcrEDP1zPqHZM09HgBVfq9Tf8fL4cOGEB/Ji42muZ6Skl7D0lAT7XkwNppmYwvy
         Oyd1BjBEAsotrqAoz1y9gXXiQ0Z36frv7sxfGsoM75eNdTzPhDalj4KM3FOSfjdYUWjp
         4vmCEuxlNnBEC+2rMPXuXV8odg7HKra7SegRU5MVEA311SecBAo71LyKvEr0zx+JEmDU
         KhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0I1MbD84bKa2Xlc/6S1re+opXt5OEOEJKlQhPxCq9t0=;
        b=eFGxM6xiDlW1yCDvP4T/C1FR6uXrDOU+BpAe2jDnBWzmnuFvDmBBjOXhMsUNhzgcVf
         1XzPlkcWZBI8p8EZuapJm9maOW3T2lsb8dq54Z2R7HK2lfifSiPpu7mTa0DWn+1KItxl
         7T3fLAQn2S8TzaL/c2qDX9cBJM5RDRQH15pft+7dIg9th9Ksm7l0bZ/cMg7zK0VhBk56
         9Q6CZpwnWaU3bIfqmLG/xAntQASh7/Ck73R8PYoNuieOd9RUG4LQZXhFJ8HxcDPvwAFW
         RY8ltY/vFhFCsjm4het4q1oDr5PTwW31+D6vj6e5QL5IoexXXhkc61AI7T5bDYp9rZxY
         lYiQ==
X-Gm-Message-State: AFqh2kqX9pI02CbNDDxUXbbvPlfJ5Xt44HfEeLMmw7Gw1mmfo+7cnuZc
        oED7XiyPREaLhtVH+ZrgNXZMWA==
X-Google-Smtp-Source: AMrXdXvWGkvKB592MVNtDb2FZfxVxbKvpLYaZHuZ4rFrXSsHrmI0EiRosGb8A/z7KZaOmSqE9GgZZQ==
X-Received: by 2002:adf:f605:0:b0:2bd:be31:cd77 with SMTP id t5-20020adff605000000b002bdbe31cd77mr11451144wrp.30.1674199043291;
        Thu, 19 Jan 2023 23:17:23 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6152000000b002425be3c9e2sm34642789wrt.60.2023.01.19.23.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:17:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] dt-bindings: power: fsl,imx-gpc: correct compatibles
Date:   Fri, 20 Jan 2023 08:17:16 +0100
Message-Id: <20230120071717.138188-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120071717.138188-1-krzysztof.kozlowski@linaro.org>
References: <20230120071717.138188-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl,imx6qp-gpc, fsl,imx6sl-gpc and fsl,imx6sx-gpc use generic fallback
fsl,imx6q-gpc in the DTS, even though these are different devices.  The
common part (thus the fallback) is a interrupt controller routing back
to GIC.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
index 85658da3672f..a5ea45b8c04e 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
@@ -26,11 +26,11 @@ properties:
     oneOf:
       - enum:
           - fsl,imx6q-gpc
-          - fsl,imx6qp-gpc
-          - fsl,imx6sl-gpc
-          - fsl,imx6sx-gpc
       - items:
           - enum:
+              - fsl,imx6qp-gpc
+              - fsl,imx6sl-gpc
+              - fsl,imx6sx-gpc
               - fsl,imx6ul-gpc
           - const: fsl,imx6q-gpc
 
-- 
2.34.1

