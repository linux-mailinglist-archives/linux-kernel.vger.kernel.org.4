Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1B1641EE1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 19:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiLDSdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 13:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiLDSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 13:33:48 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF0612D23
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 10:33:46 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d6so15339707lfs.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 10:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhyv5obJO05pgLR8K6bKL4W/XWvPLVM9OMLPNej/i4s=;
        b=D6DItwIylWFUvf6qAi7r7s7S2xPsf3J5mgFJFrSeGyMxiEFCyxJ/w9inu5R1slLLDN
         2agPAZ3zb5tkvMqGA73PEJT0Yo6DhE3fO+MRvcPmrw77yeKkP6du414lnRktouE4QwHk
         v3EJ7+8gfm3q2Ijvf6rPL0ULxJSz6cPxShFKcR2B//+rpQ6t+/qnNvKKSme61ZXrDV3+
         exKLFL3Axiw/5evjgRooib4DOKGvGkEJcYo3oQ5R2XbQL21VpjxZbAtOYPGaUN2U0O7B
         WVklTL404hwDf/HCqTKQMMXxHkp/b1LKN/wiKWbLKpvHlDA4Bc8hASFTGfjAB/YACroT
         c4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xhyv5obJO05pgLR8K6bKL4W/XWvPLVM9OMLPNej/i4s=;
        b=IZFH6dqAydr6Q/JPJoJYwnl2mbM1RSM27VY/5P5CxQSZCuDLbrwc8VRlNu+FQFH3iI
         lWKh0hLh3i3Xe7zIZuTkiL/0OE6/u5bpY69jVjVlNI3cA1hi2dNR/dbS7BQn9L6n+wM8
         XsliiRbaynVSkzl0gFpZqAFX62DWLZrdKn5uW1EutemWuxbyDl0VovHq+ovMtRdHvA7j
         hDYeNyymZiTZ/3ho2gyTXhSLLnVmz61xTo33rrQ9MD4ZMzDU39q6BlqoqqPDyXTA24Kr
         EGWUTKhmcEFXRSAePHpr+5kL8KZDVhnYq9e//w6YTKP3lX591xmwmTHeJfn1v5f747hT
         iuww==
X-Gm-Message-State: ANoB5pne3yEkhvp3MCHtcUzYMQxruhQvkfsXiQfvo2CKxFc0yrUT56ix
        dIE2WF1rVaJbl1TrUL+tI8/ENg==
X-Google-Smtp-Source: AA0mqf5OecpLenAlLa+W0DN996G16//de1xxTcSQAySGFZ/MZwJBK376I/ToiMFM/z60GTYZPXRoVQ==
X-Received: by 2002:a05:6512:3090:b0:4b4:f33e:8628 with SMTP id z16-20020a056512309000b004b4f33e8628mr15585253lfd.189.1670178825178;
        Sun, 04 Dec 2022 10:33:45 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w15-20020a056512098f00b004947984b385sm1835878lft.87.2022.12.04.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 10:33:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: sun8i: h3-beelink-x2: align HDMI CEC node names with dtschema
Date:   Sun,  4 Dec 2022 19:33:41 +0100
Message-Id: <20221204183341.139946-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The bindings expect "cec" for HDMI CEC node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

See also:
https://lore.kernel.org/all/20221204182908.138910-3-krzysztof.kozlowski@linaro.org/
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 27a0d51289dd..a6d38ecee141 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -57,7 +57,7 @@ aliases {
 		ethernet1 = &sdiowifi;
 	};
 
-	cec-gpio {
+	cec {
 		compatible = "cec-gpio";
 		cec-gpios = <&pio 0 14 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PA14 */
 		hdmi-phandle = <&hdmi>;
-- 
2.34.1

