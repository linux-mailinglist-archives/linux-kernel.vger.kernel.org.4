Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F9B748718
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjGEO7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjGEO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:59:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C02E1998
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:59:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98e011f45ffso674251266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569158; x=1691161158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KmKoQmxevAlDr8GWoC0x/IRg+Abm5jjahWJpZI9534=;
        b=CahXrZzX5G78sto6/yKaMIx/9seqEqvUG+kVsIwdTjj/VTJKB2eWt1osnlwaDCJXOJ
         UCRprFp1YLaTIQ9teLiw8qs0UYfdigWrFmTiH2TLkHh+vUaH+wDA9efiHX6RkxF/hnME
         PheFt8VDZz9UgNusVZvQJetOTczGWBfqza1kU+pbrLCWkuJ5ea+atlr3Eg+DBWhX+egS
         Rv2ExdRMpo4T3M/Y9T42pufTs0A8FPVAkr/YtGa4wpH95cyavKuIY+LrWOlN4lWu8j8l
         MsfqIk0MZskP+d9X/VkxuSzyTN9A2q4QhKlj8M/iFw3u6RRe+RW5A3T6C0fYC+lzpuWR
         hq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569158; x=1691161158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KmKoQmxevAlDr8GWoC0x/IRg+Abm5jjahWJpZI9534=;
        b=eZ43Dwxstu27k+EDQtdy72inFbLl6P50ONk6qPC0KUHmkbcnvG6jQ7gtfs7YQLWH5i
         vWPBuRLdTU8+vcnT9rQozDLpw74WHRkTQtZIC9hRshtXOftwDQjg3mkkhIoL6lgjMIRG
         Cb0/LSL8JZPr+Vtu4ZViEhLMCnYeXFh/oL8Zw+A7zR1n6NS9qXVoT/XHqiHY4dTK8Iwa
         jk8NB5xMH75H8LDLBZQN0rpdRApbeenldvp9s3NOlkt0CxbD7CrlthdFM8qeh7qjJN/B
         Mt0WF1dmGb7Xv6EMj98AiRt9aMw0YHQ3XPsGw0axdEJ0nVDdrRt+vaSnIG3nDb9LjcmI
         VzcA==
X-Gm-Message-State: ABy/qLY8XERHJ+aFa3IuYMhyEegNTOZp1hxwdAV8tLsF5FIT8fmGJyht
        CxT705XjsXWZZ8QbduOUHjLw8w==
X-Google-Smtp-Source: APBJJlF2nHsUoLIzfCr8pWpO/KLvyvSWrmgJ8X+J5oE20VFYjBfpdT9MSi0qg/SxxlvR+WAtHIRsxw==
X-Received: by 2002:a17:906:fa89:b0:988:7d1:f5a5 with SMTP id lt9-20020a170906fa8900b0098807d1f5a5mr11016880ejb.28.1688569158644;
        Wed, 05 Jul 2023 07:59:18 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id b22-20020a17090636d600b0099293cdbc98sm9419972ejc.145.2023.07.05.07.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:59:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: renesas: add missing space before {
Date:   Wed,  5 Jul 2023 16:59:11 +0200
Message-Id: <20230705145912.293315-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts b/arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts
index c18bbd7141c4..31cdca3e623c 100644
--- a/arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts
+++ b/arch/arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dts
@@ -67,7 +67,7 @@ &mii_conv5 {
 	status = "okay";
 };
 
-&pinctrl{
+&pinctrl {
 	pins_can0: pins_can0 {
 		pinmux = <RZN1_PINMUX(162, RZN1_FUNC_CAN)>,	/* CAN0_TXD */
 			 <RZN1_PINMUX(163, RZN1_FUNC_CAN)>;	/* CAN0_RXD */
-- 
2.34.1

