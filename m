Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB9C67E16C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjA0KTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjA0KTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:19:02 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E90384B6B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h16so4477313wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BoKkFfJ0Fk92LbTvoBFf7NwEBaApVAxl7Aw9TV9hAQk=;
        b=rMGL9ObmxIzaVsPFfjKb+QgBL6d1niOZkYINWDnOFWPqia491IYUTfzNN57ouNTfEL
         ZtxHJ0wC+zzcJyqZWXVCYz6uIOk0Op1KbEhwNq6TiRuJvRSK7f51hSIpIP4MTaeTgixb
         VK1TjdtHYgZqTfnfyguUCkltFtuzU6yVzdX7umcUuvhUEBs5Ia2KBLHRpmlTRsZrN4iE
         lwesQCF82Yb/zBgRmoJtkqUxTiAp1e/NzhYpTmP1GyJ2ld3TEVpfpnuSPVFTEqe3Ffpf
         C3gFyscA+itfaRr6Vib/CbAV1RgZ7lTadaPPLF2vEdXRuE7GvEj+VsmrsG6HI0XInbpQ
         GEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoKkFfJ0Fk92LbTvoBFf7NwEBaApVAxl7Aw9TV9hAQk=;
        b=x5oJ192LS6VE5j5bQlY/zT23OeJIqxcXxFB/RDmINCdFzEFmOBHNU2QTG8ir4WKptT
         WvlvQ2iMoIDbdX3dVBy4uk5KMP6wE+P8RKIEwWyV/UjZSMx8uChwZvdZxsflydKYLNS+
         iVIym4RKPxMxyNP8Lz7zv1xC21LnSkTMT00iAwrtrkbMjLTV2w+U48XSzM4WHgBpimcu
         0AP5MtY+raf7AaN1cSBX3FTS+LOqozvl97OM296ZOM2AKG3rQKlbNre5ofyuqF0C4Ulp
         /ihPfvpnJaqR1xE8Tep8uw2XPgDue6pd0mR7Du0GnaYZ8hu2H8I6rDkQgvR4Ej8QsVhF
         YAag==
X-Gm-Message-State: AO0yUKU9LgJ0eJjGZMl7btR81o8dMXLSWAPoRHRH30evuzFuo5KH5KhW
        1WJu5pEAuU3brHdjT0C0++WEyQ==
X-Google-Smtp-Source: AK7set9rwKIXSSWB+5XUvREJg5b3C+Qetm8Hv6j2TPeocxYUYecsEJJ9v71vEacK6ITeW5OBUbkYzA==
X-Received: by 2002:adf:f842:0:b0:2bf:c9e9:a654 with SMTP id d2-20020adff842000000b002bfc9e9a654mr4651362wrq.10.1674814721151;
        Fri, 27 Jan 2023 02:18:41 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6b47000000b002bbed1388a5sm3602021wrw.15.2023.01.27.02.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:18:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: marvell: use "okay" for status
Date:   Fri, 27 Jan 2023 11:18:38 +0100
Message-Id: <20230127101839.93873-1-krzysztof.kozlowski@linaro.org>
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

"okay" over "ok" is preferred for status property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/armada-388-db.dts | 2 +-
 arch/arm/boot/dts/dove.dtsi         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index 2bcec5419b66..45cc784659fd 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -62,7 +62,7 @@ ethernet@30000 {
 			};
 
 			usb@58000 {
-				status = "ok";
+				status = "okay";
 			};
 
 			ethernet@70000 {
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 9aee3cfd3e98..75ff597a9fa1 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -427,7 +427,7 @@ sata_phy0: sata-phy@a2000 {
 				clocks = <&gate_clk 3>;
 				clock-names = "sata";
 				#phy-cells = <0>;
-				status = "ok";
+				status = "okay";
 			};
 
 			audio0: audio-controller@b0000 {
-- 
2.34.1

