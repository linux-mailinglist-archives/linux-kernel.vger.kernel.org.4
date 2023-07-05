Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4672A74871E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjGEO77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjGEO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:59:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BC8173B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:59:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e285ac32eso754360a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569178; x=1691161178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Jbk+GrWXDexVqnWJ/1va7NItqVD0HkC3GiT6ZEg3Yc=;
        b=fK2EPjYFw/ijpKsZKC+bw0iFvlSWpUD+K4DYqdNoGQngMXWNU9aceANHgicTbCX60L
         0CBAp9xf3Th+PdylZIMWgukI/UvHqnTVm4qoKRd7XvAZMvWIV1ZUiqOgG6dODyIj20oB
         mT+D0E99hQxOAhTkUpLsn9Lv9n1gfOFCuuQ/FI46NZFut9tDjXRE71EnsWwgfzdjsK0q
         O3mCUFIxOgvi5OBzJkS/gqW9HuWo43sf0P+IV9ovFej85dVk6DC9MnPWhvLQlFbDujG0
         y78gqmfkXwTzHd74ixD0ml3GF1bX6j+pZ1SNPVN5XmvhkQHxFgZ4A2vdeUBty+an0pNx
         nutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569178; x=1691161178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Jbk+GrWXDexVqnWJ/1va7NItqVD0HkC3GiT6ZEg3Yc=;
        b=aoO9/hLNBzSBh4VxKhXygWevUePfLIxyAx6UZq0AG/KbZ2c850JRmywE4zcDD+uXHV
         gVOmgV2fnuRQaBL3iX/fkvXZuelPIkBvDf8wYLGr7fRi0XO+/6txcCUp7z4EZ/0pU6Zd
         ObApnUMYKI3KVPseJl/UouEPkez13h0WmAa8AOUwe09f4mzFVRwnGLzidh9lQxGWwMJP
         Oa+C0R28B28k8bjAiNhMcSU932psIbtqBepJRaTY742k1X3/8qr6MfTVQ9w0uGhLPasw
         0ZzN/p+4Y8aRWsJRBHpqabycQmGm0qZzdriQgF+oGsKxVt1wgf6rtcTUnJUN280tN4pT
         2WMQ==
X-Gm-Message-State: AC+VfDxCCq0BGB2/LjIEJRDCz1WgzuoLZZZLNKkW+TtXZ3it5SdvasHE
        5VnW2pSgJKOjoq/ewvi8m+ZZBg==
X-Google-Smtp-Source: APBJJlGgCUrobs6mk6UJNWYfXH0UbxvXlhRf3TpnJayB6qhxY+ux6nGqCHyd2IUdj74DoKiUHo/lbQ==
X-Received: by 2002:a17:906:8699:b0:973:d06d:545f with SMTP id g25-20020a170906869900b00973d06d545fmr9997061ejx.24.1688569177870;
        Wed, 05 Jul 2023 07:59:37 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lf1-20020a170907174100b0098d2261d189sm6425869ejc.19.2023.07.05.07.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:59:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Khuong Dinh <khuong@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: apm: add missing space before {
Date:   Wed,  5 Jul 2023 16:59:34 +0200
Message-Id: <20230705145934.293487-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 2 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index 377660d705d1..65ebac3082e2 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -728,7 +728,7 @@ porta: gpio-controller@0 {
 			};
 		};
 
-		sbgpio: gpio@17001000{
+		sbgpio: gpio@17001000 {
 			compatible = "apm,xgene-gpio-sb";
 			reg = <0x0 0x17001000 0x0 0x400>;
 			#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index efa79209f4b2..988928c60f15 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -946,7 +946,7 @@ usb1: usb@19800000 {
 			dr_mode = "host";
 		};
 
-		sbgpio: gpio@17001000{
+		sbgpio: gpio@17001000 {
 			compatible = "apm,xgene-gpio-sb";
 			reg = <0x0 0x17001000 0x0 0x400>;
 			#gpio-cells = <2>;
-- 
2.34.1

