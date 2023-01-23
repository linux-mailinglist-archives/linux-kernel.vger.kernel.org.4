Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B7A677F62
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjAWPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjAWPRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:17:07 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7614D2A17B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:16:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k16so9279685wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDagDVuTw97PsrwBo815Sg4TXF+qVDL0QTDGxQIG7EE=;
        b=TxF1shXGFnnhvEuPq/MGXBxFzVUaKfv+QXx93477hf5+2xOrwKsS4LLLs8SIZiR30m
         1Bdyn9cO4PpAdLYfbZ0vDE0muZ0CqIr/xkW+AEbe33/P143p16ubDdpreRVwBxwVAUC3
         9uI9VxmXiRM4klss66ILSgnj9D9bfpoU6I5zgQ3QGW7kpashRN7/CiNzwciBYrF35W66
         FxVOSFXTymspb6WO7XlnzP34YGsM+rPscQdB+oRcLxS15uWvjN5KV3Afs4o1DAgoDeM0
         jWV1DDbQpZgqP50Uw+Qs1L+xN3+b3+zuw8KNyj8dbQDG4o3HqzhDc0Y6Anb82yO6inVR
         bgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDagDVuTw97PsrwBo815Sg4TXF+qVDL0QTDGxQIG7EE=;
        b=EdZz/neXXv2wGg26kaKuonvc0Qi6ko+jKFhvmJRiwZfIOgAzlnRNxVf2QeWf/+9VVR
         pSujcZM1WXe4bJdwMwWntqrAUMSWZZRcbcuqIO4g2B3WwDrtlPGqMSlvQWO98qg7TyE1
         23AHa0Nq3AM4TE5RVzUntUwLI427kxKGfzR97vkYzCxhSTzJhoWSgL4hnhXaXe/iAghr
         AbJyL1EHtzG/9uoqI8IMIQ8jSiVRH6yKoi0FIJELour16j6y+++cpiCk/70tp44z7/OU
         TjLr81CuMNg5rznT37xA3s0LcOg/HIQF41kP+K66PMwy2QGLKzdYn8Ewwabi8A5rju+R
         WUuA==
X-Gm-Message-State: AFqh2koyV7f1gc+ucMBPyd2AuV3CxvlH0WI8W+/TX09TM1k47BQ1ngXz
        rtMUw2LcstHXrgMI6qeX6xN93A==
X-Google-Smtp-Source: AMrXdXu20Kbz7zc+FfNmwfMjg+8Aec9itiZvQhfCVjyGJxree08weA+1J3H2twybXrnYYg9Pfc8YjA==
X-Received: by 2002:a1c:750e:0:b0:3da:fcf6:7146 with SMTP id o14-20020a1c750e000000b003dafcf67146mr24529079wmc.14.1674486979176;
        Mon, 23 Jan 2023 07:16:19 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f13-20020a7bcc0d000000b003d9780466b0sm10697414wmh.31.2023.01.23.07.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:16:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: broadcom: drop deprecated serial device_type
Date:   Mon, 23 Jan 2023 16:16:15 +0100
Message-Id: <20230123151616.369963-1-krzysztof.kozlowski@linaro.org>
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

The device_type property is deprecated by Devicetree specification and
bindings do not allow it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index b8b8c0e78cc6..a9186166c068 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -475,7 +475,6 @@ i2c1: i2c@e0000 {
 		};
 
 		uart0: serial@100000 {
-			device_type = "serial";
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00100000 0x1000>;
 			reg-shift = <2>;
@@ -486,7 +485,6 @@ uart0: serial@100000 {
 		};
 
 		uart1: serial@110000 {
-			device_type = "serial";
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00110000 0x1000>;
 			reg-shift = <2>;
@@ -497,7 +495,6 @@ uart1: serial@110000 {
 		};
 
 		uart2: serial@120000 {
-			device_type = "serial";
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00120000 0x1000>;
 			reg-shift = <2>;
@@ -508,7 +505,6 @@ uart2: serial@120000 {
 		};
 
 		uart3: serial@130000 {
-			device_type = "serial";
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00130000 0x1000>;
 			reg-shift = <2>;
-- 
2.34.1

