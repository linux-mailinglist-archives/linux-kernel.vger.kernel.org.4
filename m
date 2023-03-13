Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7719B6B7ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjCMOtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjCMOtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:49:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9017A4DBEC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:49:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id da10so49859299edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678718966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vwg4yABFUSU+Yq5FpxlJ4Dfi9ND5H6cSeznAZm/x2I=;
        b=zZrbG7NNaNf1SBc7U01gPx58WzsR6/YTcmdAlFgXjkbSMLa8g3DVEN+96OinmSr3n0
         gZGjzikDBYrd8EqUdKxm3DDAssqYTskyuprKxq97Yo9yCN3dDQH7ea7Axq7/Pa0vAcTQ
         mM+34UkaSG68fu4pTG8XPQebAsgmgHeGgWMgKBxV/CodCJq4zROg7kOqKCgGACbKu6JD
         WY9bgA6jb6PHv5TA1N7JNVuG7u1oF8tII4P1PTyhaM3k6OkcK1VB5/DmUMREmRolkF2/
         UswbUhTxcsjQJqm6PLDI4pwSbbgb5mtKzfK0ewcna2jp2yo2ZzZfUnmgiRyhJMJaATpY
         tfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678718966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vwg4yABFUSU+Yq5FpxlJ4Dfi9ND5H6cSeznAZm/x2I=;
        b=YTmk1piurs3VIs/SPVGM6RLeZMmboTz9PL2vHH1t1CkKy+fR9UPv1Gu8C9EsXMWu+4
         rn0T6y3EZGD4V838EJ3Dr67eWTM0BEs/tPrrX2fuFCsXobPODVSIN3SEtXVikFfWUzDr
         fdG6vO60Bgivj5oyWA3BaUGqzWsn16k3sdc2W2BOMp/sAsNFUk1hZXj4jTOEEujJU4Wh
         1nSGbCaaSN1tRDq+PfUfv0vdQTBfO5GwHJfEbmj8IGbWqGPCk/mVBPmgstXFWJMIu98W
         zhsswQHv3dzSv/GWuQyPzc2eMNnnTKcwrMbtZ1o4u01eJ1yRv8pj6qGv3+fSKvWqJCwX
         6HlA==
X-Gm-Message-State: AO0yUKUQ8BR3D+xOwf73Io6/WFVOs5N3Qa+BmtOP58XGZlpedHDl2s+f
        9NjBjJ2sCh/HWbY6EYpmd4fCJw==
X-Google-Smtp-Source: AK7set8hIpebM4m3xhGovmCuv0a7Pkiilhx+ToMIq0NBZEmOhTnVnfdZkcXsiXoapkKnC+McBoCZ0g==
X-Received: by 2002:a17:906:58c9:b0:923:6958:edf7 with SMTP id e9-20020a17090658c900b009236958edf7mr8185871ejs.23.1678718966049;
        Mon, 13 Mar 2023 07:49:26 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:69db:4882:d071:27c4])
        by smtp.gmail.com with ESMTPSA id ia17-20020a170907a07100b0092153c6b549sm3030164ejc.22.2023.03.13.07.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 07:49:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 01/10] media: dt-bindings: samsung-fimc: drop simple-bus
Date:   Mon, 13 Mar 2023 15:49:07 +0100
Message-Id: <20230313144916.511884-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313144916.511884-1-krzysztof.kozlowski@linaro.org>
References: <20230313144916.511884-1-krzysztof.kozlowski@linaro.org>
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

The FIMC camera node wrapper is not a bus, so using simple-bus fallback
compatible just to instantiate its children nodes was never correct.
Drop the simple-bus compatible and expect driver to explicitly populate
children devices.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. None
---
 Documentation/devicetree/bindings/media/samsung-fimc.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/samsung-fimc.txt b/Documentation/devicetree/bindings/media/samsung-fimc.txt
index 20447529c985..f90267f1180e 100644
--- a/Documentation/devicetree/bindings/media/samsung-fimc.txt
+++ b/Documentation/devicetree/bindings/media/samsung-fimc.txt
@@ -15,7 +15,7 @@ Common 'camera' node
 
 Required properties:
 
-- compatible: must be "samsung,fimc", "simple-bus"
+- compatible: must be "samsung,fimc"
 - clocks: list of clock specifiers, corresponding to entries in
   the clock-names property;
 - clock-names : must contain "sclk_cam0", "sclk_cam1", "pxl_async0",
@@ -156,8 +156,8 @@ Example:
 		};
 	};
 
-	camera {
-		compatible = "samsung,fimc", "simple-bus";
+	camera@11800000 {
+		compatible = "samsung,fimc";
 		clocks = <&clock 132>, <&clock 133>, <&clock 351>,
 			 <&clock 352>;
 		clock-names = "sclk_cam0", "sclk_cam1", "pxl_async0",
@@ -166,6 +166,7 @@ Example:
 		clock-output-names = "cam_a_clkout", "cam_b_clkout";
 		pinctrl-names = "default";
 		pinctrl-0 = <&cam_port_a_clk_active>;
+		ranges;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-- 
2.34.1

