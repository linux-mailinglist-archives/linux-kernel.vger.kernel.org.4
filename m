Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4157E6B6A37
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCLSiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjCLSiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:38:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AF093EB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:37:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id er25so12126166edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678646188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWTPQ02vuBT1r5z+H1cMz9z3i2niGER+DvQv2eqXzik=;
        b=efgLkO/QN0WP5+9+ACLqF+Xkmx1MNhEuJwyUpR6Bp6Cx9l4hl/3U0u0hbixN4IaEUB
         o/I/Hy+58at1+okQ06LYaQLBdKX++NRW9B5oTF6YegKdWCji1zPI+OinNTCLgoKJLR6e
         2BoAjgWg077RZru16Lff9KHEXFwt5Z03Vzu7MBCNo4oapBpIM40ifKFpDhu8fb2shcEl
         5jSYZ1ql4EagmTDouigaSU9ZHQi5YBtZX0QZmuuf0WNP61EnilrtkdbnE7fyVxFu/+cg
         9GEBYJ2UkILOaqP9qfV9rTqVtS7Zd33Sa0dwVz/2PTWfF0G04uxTHjbti6UWwXz+NH40
         AIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWTPQ02vuBT1r5z+H1cMz9z3i2niGER+DvQv2eqXzik=;
        b=ycyp2zcXsQ4HP7RnO5VQjgkNs6HWWjs557jPV1ouvdYgY39ZICHaIHZ8C0ef55ToZn
         VDmfB/8pOeIwSj5mxAqghBWRH+uwtgJ8TqCy1QyNXZCPlKawV9JD1C33YseIoXT9/b8I
         LlV97YXjx+IPFgbgbzWRhqyFEaOZ2gxM+nwSd5VDTuBf19c3L4wBxBl3pLy791GH54kO
         o6DqUhRMsotYZBG1pL25RZnkTuUSj/nlWJTujYHIs77taNipXya//GSWT6amKQbVmA6G
         mVPposUrf/f2wOAPSSyZe0973QgxXfxNDSlT/trZ9SmappdW2VYHMqjv9CMH5myCLQs1
         +wDg==
X-Gm-Message-State: AO0yUKU8Bht6bHW8nQMkNUZxXv63eZRfe7hUuLqGV3MiBlvNThmeb3x5
        Omy8QRIlUcQfQVLb3n33R18xlw==
X-Google-Smtp-Source: AK7set/WGNPq8Sahke70gY475lQztFWZITyEmeH7usMJmano13yLx1Bx8xzuLEBG6kc7fqhzkIcaMQ==
X-Received: by 2002:a17:906:a882:b0:8aa:a802:adcd with SMTP id ha2-20020a170906a88200b008aaa802adcdmr28388691ejb.30.1678646187904;
        Sun, 12 Mar 2023 11:36:27 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709060dce00b0092669fb4ba1sm893806eji.130.2023.03.12.11.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:36:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Gustave Monce <gustave.monce@outlook.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/8] arm64: dts: qcom: sc7280-herobrine-villager: correct trackpad supply
Date:   Sun, 12 Mar 2023 19:36:16 +0100
Message-Id: <20230312183622.460488-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org>
References: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org>
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

The hid-over-i2c takes VDD, not VCC supply.  Fix copy-pasta from other
Herobrine boards which use elan,ekth3000 with valid VCC:

  sc7280-herobrine-villager-r1-lte.dtb: trackpad@2c: 'vcc-supply' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: ee2a62116015 ("arm64: dts: qcom: sc7280: Add device tree for herobrine villager")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
index 818d4046d2c7..38c8a3679fcb 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
@@ -33,7 +33,7 @@ trackpad: trackpad@2c {
 		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 
 		hid-descr-addr = <0x20>;
-		vcc-supply = <&pp3300_z1>;
+		vdd-supply = <&pp3300_z1>;
 
 		wakeup-source;
 	};
-- 
2.34.1

