Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF1704838
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjEPIwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjEPIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:52:42 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA114C0E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:52:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7577ef2fa31so179230385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1684227148; x=1686819148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Fsp/r/3X/nR5Dw9Y1Zsp/W7/PyEi0YNOAlMQBXhdvU=;
        b=IpHvYlsdGHRVrxdSldGKJOZaCDHvYa3054Jl2mOcEZkIz44x3oKuYk+VAZ+abkVCHZ
         ryThXyKnU22y2lO87uWBgHjsmA7Y4yXjB1rq8PBl1o688QRwuYjGDJhG83VlUfZpCZxG
         1X3Wv34o5BGtgOQW3TLfRUXLewQFbYKu23RfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684227148; x=1686819148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Fsp/r/3X/nR5Dw9Y1Zsp/W7/PyEi0YNOAlMQBXhdvU=;
        b=HNZi12v75oBzYyMO2dA3av6HnU81wPOL6Evy4GEaUd9LDhKfUBulO66+tOEFPmRhhg
         5qVpLkTzxJmQ/Ob8/aMCSLUYgOiqa6YvwlCZy2xF+tsxAig3hPFEIknr+eib0+UO5OE7
         cbcyvcw6LQXXcA1sQpCB5bOiONzeV4IqBtBCXbNC9hGeLQgNCGkVu4eK1PndWd7xsQOQ
         Qpu2qFbpiH71HJQw2qmi48/ZOUe3KXnycEdUpfDdfL9QvMEaN5CJUVh+y5m7tpbHkQ2I
         uepPbXBnJC5TuYqU4yQwuDP5oKo5fRsxGLMlOWCG/hSdN9W9tHxSZ8dEFac19ceWsblY
         vfJA==
X-Gm-Message-State: AC+VfDyq6PSlnu7OyOhRzcF5DQbwrQz0Z9m5SA+5b6a0TFi0CVPC/xZr
        LJQeZ1CUD2mw5nNYUh360u9/2SFHJH0EE3/x6RMVPg==
X-Google-Smtp-Source: ACHHUZ58ENGBVYW2227e7XYFPh3fQ4T1J9FrMj5V0IlG55RxHnBgxuqmrqQC6uWuWy8Rx9ld0qpIlA==
X-Received: by 2002:a05:6214:29c7:b0:56e:c066:3cd2 with SMTP id gh7-20020a05621429c700b0056ec0663cd2mr58463378qvb.2.1684227147882;
        Tue, 16 May 2023 01:52:27 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (mob-5-90-62-17.net.vodafone.it. [5.90.62.17])
        by smtp.gmail.com with ESMTPSA id d10-20020a0ce44a000000b005ef54657ea0sm5480337qvm.126.2023.05.16.01.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 01:52:27 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: use RCC macro for CRC node on stm32f746
Date:   Tue, 16 May 2023 10:52:19 +0200
Message-Id: <20230516085219.3797677-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch replaces the number 12 with the appropriate numerical constant
already defined in the file stm32f7-rcc.h.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/boot/dts/stm32f746.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index dc868e6da40e..e3564b74a779 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -515,7 +515,7 @@ pwrcfg: power-config@40007000 {
 		crc: crc@40023000 {
 			compatible = "st,stm32f7-crc";
 			reg = <0x40023000 0x400>;
-			clocks = <&rcc 0 12>;
+			clocks = <&rcc 0 STM32F7_AHB1_CLOCK(CRC)>;
 			status = "disabled";
 		};
 
-- 
2.32.0

