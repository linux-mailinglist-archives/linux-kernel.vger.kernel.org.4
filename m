Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BBF629657
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbiKOKv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbiKOKvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:51:05 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D76264A2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:50:52 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id l8so16950216ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UGjykOjceH4eYkA7OZEc1299a3XbmJI2Br4/Li5jEVM=;
        b=cBr/yYY16FlBIk3qt3jawqz+aPmJnbY0pIyIaUIaC7Rtk6pnVEY+LQRpkjN/ea2Nz5
         DjWZcwrOEdPVVnXCACMW8wOuTZD+pLY9FTpyDWesS9nyP7p/qwEZMAwmOHWIOcrWz3oF
         yfAqFpVBEpRlY4RVQGQF433onjyEpReK6C1JekAtImZMjYTANSX+QllIPzkEB1u8pbK3
         Jt3EX5gXA42IKRG8/2JKVdT9xiQY4e7Rft60LJZ9z5gUB2Dl3DZ1rRQ1pz+uV9eOBn2P
         kTJi2KE9iw450+Flkg5irVl0qxJlNUfut0KaoR1msv7OqRqjB6b2Eh3D4QIuWuHx56X/
         746g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGjykOjceH4eYkA7OZEc1299a3XbmJI2Br4/Li5jEVM=;
        b=QVPHWmt/51/wuF/wC1uNtuu634kzoHxAcqMyfeoJEGqAy0++Xmfm0JZTEdshHHtXa0
         lhjJmBnR1tx7duEkmx7QgqoZkNaIhC1K1B/jL2be6476VgyG9sh46MOoXj5/tRGj9cbf
         fSy5+YOmfeXtPQaypT1/6UelKGFxiITuTT+rtWZgL85VVpbQu/EV3KVOzhKgJd4e3qTD
         Yejx9ZZ+KWjkU0VRJF5eZaipgmklIw2+/Eyh5OrIMSlOEAme8B3/juVgRvLEMV26Y4ha
         qhPA8tSfjnwOawuM7URs8fGIrsA80l4eaU4a3Xzl6p2l4gQwRedOJ+OYMHZOZgMfqACm
         mAyQ==
X-Gm-Message-State: ANoB5pmoLmHkM94h+o/1ZKUH4iSCq8ZVmLGtcOBvaGEE72BP397aCWne
        k/7UVESVwqXzqv9laRTfKNFb0g==
X-Google-Smtp-Source: AA0mqf6e3Kr3P7XLgfpzxF2LZl6/IBo6LGm0frKLjBHLqkLntXEDdNgjrK38Vf9CriEVLAdkbdvhlQ==
X-Received: by 2002:a2e:b706:0:b0:277:d75:f1de with SMTP id j6-20020a2eb706000000b002770d75f1demr6035466ljo.272.1668509451209;
        Tue, 15 Nov 2022 02:50:51 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n25-20020a2e86d9000000b0026dcfc2bf4csm2468872ljj.57.2022.11.15.02.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:50:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: lpc32xx: trim addresses to 8 digits
Date:   Tue, 15 Nov 2022 11:50:49 +0100
Message-Id: <20221115105049.95313-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hex numbers in addresses and sizes should be rather eight digits, not
nine.  Drop leading zeros.  No functional change (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index c87066d6c995..974410918f35 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -315,7 +315,7 @@ fab {
 			/* System Control Block */
 			scb {
 				compatible = "simple-bus";
-				ranges = <0x0 0x040004000 0x00001000>;
+				ranges = <0x0 0x40004000 0x00001000>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 
-- 
2.34.1

