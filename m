Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E310638C86
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKYOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKYOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:41:59 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960073F06E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:38 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d6so7192086lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=njud4xqq274bpbwus33xYwY3Vs5r+wFEXFrEEoEu/J8=;
        b=I+rMTxd0holP4+mHqW9f3Ic0bSJrXy+E2J4Wn2B+enbKIFu4Rl1r7s4ZvdFz478h9N
         jQ8zTMqN4LjrAd0LY9z2j6ZXU2yJaWl6+pK39PTNCFfWkUQtnA3cY2GkvdANYOhJr08o
         QSDZZH0fOXBI1BcI+rFqhm8rtgzO6XqVqHeCe/ag5x8XZSUe0ZU1lYb5erq1V+HJkWpV
         0KIOf2xtZ2OPzbu6gc1QlUURMWF0ovYNDxKSiOyJyuYf2qvEagXmMMG7XOB6PP+FM6VW
         2khNsp/xAop8kFseJMmf6sKoBDQFsAieQWcx1qVgnfW4UJ8V2+Yb26VS3/AVgY6UPnn8
         bYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njud4xqq274bpbwus33xYwY3Vs5r+wFEXFrEEoEu/J8=;
        b=fpTa5YKaBwqiOJ1S3Zpg2KWttrmMXD86CUOvqRtOADU3zQePU1ihefNnMeSq9hCuvW
         ni6cw9zCctwdAVuOF3PvvCwCRHqIXttZaFSU91cElSzY9pgN6lTXNGhzabL1eP1gcKkZ
         lQGFq2j3vrfkHDsDt3/GQDqbYWpMrFsvwTTBvMyaixNeCCktwzdf7dCdGjezDjxBEnJX
         y0RiDfxhk/pfGTvfGRcOWsMQHTPejHLvpsYyc9ckBTn598tb9WMZh26Y2LwQnkaeMVie
         H/yN6O2akaphOJvdDzrxdNehl0/mxpIbjoxP6fv64vpKZMrNmOFN3YkQu3TMR1fWAZsK
         j9pQ==
X-Gm-Message-State: ANoB5pkY5psWe+Gi8pWMEXmhckO4e8l15VWD1fBiaEOl9zSbMLONSehe
        aDKiMZIjoVd7rlnFbh9BZ0dY5Q==
X-Google-Smtp-Source: AA0mqf457dG/Zneu4HP5vPQymw7lWN6txp4hBVttYKTzJajEVM+FVhOg6D5e3JejzY1TnqfidKPvNQ==
X-Received: by 2002:a05:6512:3b88:b0:4a3:9533:f4c9 with SMTP id g8-20020a0565123b8800b004a39533f4c9mr7381181lfv.615.1669387298167;
        Fri, 25 Nov 2022 06:41:38 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a22-20020a056512201600b00492dbf809e8sm541757lfb.118.2022.11.25.06.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:41:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: xilinx: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 15:41:36 +0100
Message-Id: <20221125144136.477171-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern:

  xilinx/zynqmp-zcu100-revC.dtb: leds: 'vbus-det' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index d61a297a2090..6948fd40554b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -86,7 +86,7 @@ led-ds5 {
 			linux,default-trigger = "bluetooth-power";
 		};
 
-		vbus-det { /* U5 USB5744 VBUS detection via MIO25 */
+		led-vbus-det { /* U5 USB5744 VBUS detection via MIO25 */
 			label = "vbus_det";
 			gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
-- 
2.34.1

