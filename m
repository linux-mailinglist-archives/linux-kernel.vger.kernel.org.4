Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436B76AA971
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 13:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjCDMde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 07:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDMdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 07:33:32 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E602F11162
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 04:33:30 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u9so20601985edd.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 04:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677933209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwTzw4guUx/lmKZKp9FZAIf2Iof4nlld7Lfmrz0x5hU=;
        b=g0M5abk9yetoeCh1MvLSCStFIhC2kotpRDtZm9RXd1GT8H0qbqE93GWruGz3ez+ik3
         DrSlthpwkgcCzfWFZ2LYun5SrfHRF/9eV2absC1CGIliOIVl/Mlcj+bQRrxsNsSTwG4V
         zSd/H8e6iJ1si5OfympFT8LvfTIID+L0RhGMlSmVQsVXnZiLjiSVQGASaSv+PCJ/2F5X
         wrUCguBT4WC1AMpTWRIDDZbxni66gnFBXz9G3lqMe38jsFN/zGr46KCpCgA/cQJQP1gI
         5MAL2xEytqf/ejRMeDaKhW5vl6M3BI/3vLmTyVbn212a9rq/W222/hQY8zlvnWoCtmp7
         yDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677933209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwTzw4guUx/lmKZKp9FZAIf2Iof4nlld7Lfmrz0x5hU=;
        b=LJjBaxBHaUy6QmWlOxtbrDbQdVzoW2V+hIKhpkGQhLucvvMF00ZOHAS6Y2iIT7EMjE
         q60rSV2lwCmCfPvpZ9VH3m5U6Mob+cP/l6C9VnQQxW8dALDS5NoPbYBxBpXDrLmC0g7z
         brVALQYDEnClp/ZOMgqngA5m20UZ+4OoiEfqY0WrwMGWLcc3VDOrdpRd/9kGYq4p/ufR
         Kkzr7XfLJ/5QhYhQlu5jEdpFkscaEq/6Hw3qbQwRlZFx68NU18PKX9O9HvAZk4+tcuRp
         m8zNm7I+UX74G/bcHZI5pFJEIBKvSEnYPtvtvLK6hvj2ReyaJNv9TXbT/L0rcvhvj1o8
         S3Sw==
X-Gm-Message-State: AO0yUKXsjSB81oIsJID3DRlM33vfDv4+MkV4A8z7V4jRskKVurgs/rDW
        i4pyhbi1Rj304wVNAPec0bSRK7gyznMJpQ8CwAY=
X-Google-Smtp-Source: AK7set8fNgHrOb48YLQc+6jt7WeWZgjA4V1pBu4H5fd3OnTyex77l70mE02EF96wpTJcyjLTMPKYtg==
X-Received: by 2002:a17:906:3a48:b0:8b1:2f0e:e3a4 with SMTP id a8-20020a1709063a4800b008b12f0ee3a4mr4557869ejf.26.1677933209401;
        Sat, 04 Mar 2023 04:33:29 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b758:6326:1292:e2aa])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906081600b008d1693c212csm2021300ejd.8.2023.03.04.04.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 04:33:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: mediatek: mt8173: correct GPIO keys wakeup
Date:   Sat,  4 Mar 2023 13:33:01 +0100
Message-Id: <20230304123301.33952-1-krzysztof.kozlowski@linaro.org>
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

gpio-keys,wakeup is a deprecated property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index d452cab28c67..d77f6af19065 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -58,7 +58,7 @@ switch-lid {
 			gpios = <&pio 69 GPIO_ACTIVE_LOW>;
 			linux,code = <SW_LID>;
 			linux,input-type = <EV_SW>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		switch-power {
@@ -66,7 +66,7 @@ switch-power {
 			gpios = <&pio 14 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_POWER>;
 			debounce-interval = <30>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		switch-tablet-mode {
@@ -74,7 +74,7 @@ switch-tablet-mode {
 			gpios = <&pio 121 GPIO_ACTIVE_HIGH>;
 			linux,code = <SW_TABLET_MODE>;
 			linux,input-type = <EV_SW>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		switch-volume-down {
-- 
2.34.1

