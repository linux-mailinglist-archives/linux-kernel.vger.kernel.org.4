Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3089648E71
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 12:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLJLeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 06:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLJLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 06:33:54 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6839B1FFA7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:33:52 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id cf42so11036056lfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URRro+4XX09lfePnlfX+cuftntixCoSXWYcsOGncqAo=;
        b=aq8CKviacqI/QZfGiKvuEjpgfc+qwXOLLCXUflmXpjAA1FBBcOaoS7d9lCyIKc9wVb
         GpPBMmDzQCnhD6mtmnNyJvFlLLBUjdGTXOqt/Jv5VtJPJDzqA7PwL8SGCF9Qbwp6yxOQ
         n7kUs7lpiV9gFvTfMY7NvT/xjgNPEzldV5COFiUUFWM8354yW9LiwBsI+6kOb9LsJIz/
         esxcPAjLuwfBoaagdpXg/n2eE3v5zInmuh0Fzs01tGdj0XT2n9XWICC+3WSjq0WhHHMF
         ukpWz5cxwwzOTx8CnQxRZ/Zah7fRHu4U9jYS5zgYSRiQXCNPx2YKKYv32b5V5rRQ6MUg
         etHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URRro+4XX09lfePnlfX+cuftntixCoSXWYcsOGncqAo=;
        b=uigSaYyK65+Yu2TsSvLzeopExsxE6EtqlXIr4hE/qdX0gmh92U2l1dfJS/iqKEMo+h
         Ksc1UA3GAVfSZzlz/drkpk486VLfv4EIlhOzIUuaVxTs7cf6/QgFA8rR5LWP4xAE117t
         G4KOgagQ7xBqw3F3COh1Enp6yZ6i24ibzo0vzOsQoQJ/iPBJvlSuLhmwDpu/Ikl85CPw
         OvY8wcK3PgYUCgJszAvDSnGdvRzWX13uKnjaLQVKOwxE1EbvbxSmJt/eXRlkZQESZv80
         gPCn7B5xKaWD3wx5tZQ7zC7LLpfvz8H8TPU75N//sCcxB+DMhHfK66lVbcyIRLpP8ghU
         MHqw==
X-Gm-Message-State: ANoB5pls0aS0excprPKoQFXuy8R+uvlD/WgtAjMd3Jm7c2QhnTId4HTS
        qxrL8VwJEd3jrahrZpqc+Zxp8g==
X-Google-Smtp-Source: AA0mqf7tJCLnKxMsYTZ5QXjiJ3vKVFvFIsyxfOf4rKOGbqw84xRl0BnHjassHTS0/A1uZcwXy1tBYQ==
X-Received: by 2002:a05:6512:3084:b0:4af:acbf:1506 with SMTP id z4-20020a056512308400b004afacbf1506mr3541558lfd.1.1670672030698;
        Sat, 10 Dec 2022 03:33:50 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f5-20020a056512360500b004b55a1c4649sm687787lfs.38.2022.12.10.03.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 03:33:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: socfpga: drop 0x from unit address
Date:   Sat, 10 Dec 2022 12:33:49 +0100
Message-Id: <20221210113349.63971-1-krzysztof.kozlowski@linaro.org>
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

By coding style, unit address should not start with 0x.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/socfpga.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 6eda6fdc101b..3fee80bbae21 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -749,7 +749,7 @@ L2: cache-controller@fffef000 {
 			arm,prefetch-offset = <7>;
 		};
 
-		l3regs@0xff800000 {
+		l3regs@ff800000 {
 			compatible = "altr,l3regs", "syscon";
 			reg = <0xff800000 0x1000>;
 		};
-- 
2.34.1

