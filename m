Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AB4677F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjAWPQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjAWPPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:15:50 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2762A2887F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y1so6628671wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nj10iQ8+lBJbvUvk0vNNGH/05Uq4O5uL7ih+Ic+fc78=;
        b=xtQf5O7Zlp8+rL93G8XJKyuJqZrlSdSE9DpZQmi5j0uR21dRObuXDttvpCy9stfYmz
         6k8I/vGAO+IzpOUp2ebpft+VAXVuW4SaWy33AJlx6USCGksIuiDbg3UhlrurM6qYqcNa
         q1wOF9kNvanf7VYn6b6En6KOIKo2ieZrNxtrdMaaqqpBK0iYQP5jbfKg1RT7yDMHojnV
         y8Nn5orFlQya+QFTbVhin9HCT4+nn36ZJUS0WY7KdrZXGJA814N7uDB3AEcTejPuTO0x
         Uz6YgIH2i6xtN5d/BkyHN2666masspU1BBWqhKKPOkRpUDOmwZ+7ZV5DjCT+5rSr+0Lg
         l2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj10iQ8+lBJbvUvk0vNNGH/05Uq4O5uL7ih+Ic+fc78=;
        b=m8OwG0JHHOrMVOB2eFtm0hhRwDQ0bieQCCwqVC65ZrmPy5qXoqWPqAsvdxbQxwjW2+
         jZhx8FeZ/6Kf3VStzMqxlu2b7qXfFp/gtmXl7gysfOXJT/YzWFZjup2fdGr5IypKTNLT
         dqx+EJ5hRaRi28YkF9dHlXf7jPUcS8KFycBTLsmOTmH1/qRcMl9SdjVsYBZ5KaKFVMtS
         rb26ZwYGTw7tlKKUxn/qTlWA6ve8aFbdaJOukCnrZ96/rf+Y1uu+kXhYU2OCruGU/mpJ
         SJg3iUimzOwBXaG2BVF0Co2kHZdTrRSy079opSiG/Ri43OogKC5mc8WO4mB2QPQmEa5R
         ulfA==
X-Gm-Message-State: AFqh2kqnVCqrrxCCXoUxj8brbGOU8v2E46RmPQfr8JzffsBg9aCoNqDe
        GtXZ1yep0JbHOAoaOVLY0dd5zw==
X-Google-Smtp-Source: AMrXdXuARq/ZwPTOQeVn2L6tcoSC+rLBeIr8OFg93X9Z1ConDmL2/PsUmJqmr8iDCpl1mdUnFoN7MQ==
X-Received: by 2002:a05:6000:1085:b0:2be:4e3e:fa0f with SMTP id y5-20020a056000108500b002be4e3efa0fmr13592141wrw.71.1674486925308;
        Mon, 23 Jan 2023 07:15:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q4-20020adfdfc4000000b002bc6c180738sm41992825wrn.90.2023.01.23.07.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:15:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: mstar: align UART node name with bindings
Date:   Mon, 23 Jan 2023 16:15:23 +0100
Message-Id: <20230123151523.369225-1-krzysztof.kozlowski@linaro.org>
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

Bindings expect UART/serial node names to be "serial".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index c26ba9b7b6dd..3eeafd8c7121 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -174,7 +174,7 @@ gpio: gpio@207800 {
 				status = "disabled";
 			};
 
-			pm_uart: uart@221000 {
+			pm_uart: serial@221000 {
 				compatible = "ns16550a";
 				reg = <0x221000 0x100>;
 				reg-shift = <3>;
-- 
2.34.1

