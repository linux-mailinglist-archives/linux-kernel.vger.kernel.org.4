Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46CD6A2AC2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 17:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBYQk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 11:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBYQk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 11:40:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6117012059
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 08:40:56 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so4360451wmb.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 08:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8UdSbnxnovWYaD1qvI9kf5ZeJ330c4affjZYTPUmJTc=;
        b=iq7xMDV8TcMdkpZBVLPqqXgernHW9WbD2rEo/DPd6KjP3TNfrl4K/vc9u6dQZ+IwVB
         w5EvW8uy3m4TlE4vqXYUWK/AtBnqa0/SM1bgJbPtGx5sl0lVTbeO/gPnPjc4rVyKWbP1
         Xo/IZgp9yEZEJe9u7KA5wUIDRu+UVD/Ip1vpXh3tzAtab5ayagC5ea2qZDZqaYoVbWeM
         fWBC+NYpKsoPRj4CXeWORvr6fXL+6F/qCXOAs/lQRptMq+9hj4vfnNjpBUx6YUk5NLv1
         YGnCwASNlji/AoLyb1m7qypkHY+IOjIgTW0MRUh9IMuRt9dQkobYTjr/wqhMvYdvMZ0a
         vv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UdSbnxnovWYaD1qvI9kf5ZeJ330c4affjZYTPUmJTc=;
        b=DoMrehLcct8/rnGuZifsPindzRCZnTc08WPRPT9r6CIfB1Xa8x8WnofDRqgUQn1Xww
         AuCFf1Gudn8L/q0c1qo1jZEIKsOVg/XmykxNDuk07Mlw0wxrxWzo6tNIPKyBboenOkzJ
         h1UZxB7FfIV+goIEorDu5gF3ZfBfQDZ/LfmUY80pavBwW+sLIeAGdH2EG2Lh9sxkuMVJ
         QE2vFyu8bk8Wdbj4QONopijgDQKIgDP175hirW7LW5BPYZbAwr1eCKfHQ2zYzHpMsvD9
         Qx8weU+UUW04SSYr7zDgS7DWK2YxiH0nULqc6lwUJ1DYD9frNJI2oAzX2MaMs+NrRJtp
         ZAFg==
X-Gm-Message-State: AO0yUKWJTt/S7K4CiYjnv+uKRL/9WeVCxL9BpH+SZKFxBwnQ4FO7j0YX
        7idSWhMkOPwr18iWpzB5SUJPhEWghzlD/OCJ
X-Google-Smtp-Source: AK7set+ipNlrvKEWy9XUrjaibIEjpo8ugCIBL8JhksuS+K2OjMFS1weYUHqZOCvuWGoRqXMWFYotEQ==
X-Received: by 2002:a05:600c:331b:b0:3eb:2da4:f32d with SMTP id q27-20020a05600c331b00b003eb2da4f32dmr3679192wmp.26.1677343254919;
        Sat, 25 Feb 2023 08:40:54 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s17-20020adff811000000b002c758fe9689sm2189163wrp.52.2023.02.25.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 08:40:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: exynos: align STMPE ADC node name with bindings in P4 Note
Date:   Sat, 25 Feb 2023 17:40:49 +0100
Message-Id: <20230225164050.42522-1-krzysztof.kozlowski@linaro.org>
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

The node name should be generic thus rename STMPE ADC child to "adc".
Bindings will expect such name as well.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4412-p4note.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index 3e05a49f29ff..84db696d543a 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -195,7 +195,7 @@ adc@41 {
 			st,ref-sel = <0>;
 			st,sample-time = <3>;
 
-			stmpe_adc {
+			adc {
 				compatible = "st,stmpe-adc";
 				#io-channel-cells = <1>;
 				st,norequest-mask = <0x2f>;
-- 
2.34.1

