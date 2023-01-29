Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003D0680098
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 18:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjA2Ry2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 12:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjA2Ry1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 12:54:27 -0500
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Jan 2023 09:54:25 PST
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30DA1BEF;
        Sun, 29 Jan 2023 09:54:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675014501; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nEv2Qjex5GrWowG4Tg2/4TJVTzLYTIcr8lE7dLcoLejZpSUxZlaL+MyLsAXwBke0dA
    LdDX1YKPYWsHDSdwihLuG50+y+nlcUB6pjN0O3ZB99hZk158j7Ac5W5ZOl8wrlxAaa2D
    ch2NKCcEwRFdKd337RUsB/x44/d3ich7P9WIuQ3NBlKZg2VQhAibOC1RAFbBkCLupGea
    gXqdGcNrDN/KrRB1L/Ezut8nfaPM8MY6HM7kwodXdl1ynPiLgwYz111gdO0xvWiAuqxt
    f/t3mMudYL8pKiJw3MitUZ7pOngnKLiJePhIzdssTFZQ9YAKdT8p6wJxqWEvgeO3dsa/
    WdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675014501;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yGRM7cEfo5aFqSY1gp1TMJFXgu2PUQKG5rOicfC2/UM=;
    b=Ubxu5ZB2rt/ZvfyyeiCisvS8yfUt1Bzp8/KU7Rkv+dTy02cr7cWGXkkd7xz5bqTTG0
    9UuisNmN9WKlSIJGf1wspIAhhZpdMcVrONCpCeU8abxZ1JFy8R9M9sf3DHZCwHUn6uwL
    JikBlaHih4d/0P+c+LCJBLUFX/df5XJZoVl/IIe/DtkuQQT08qs3LIvWp3P1nYrcwsgE
    O9uy9+kjZANSCPJHYIHkkDBtSJ01UxoOP1b8SUan0gNYmIshn2m9jM9M/Q2xXWfySFCn
    HPitcJnM8pOtYWFdy20vXv3QeE85bOffFu535T9gtR1d5fjOIxzvNj8Sto9iW+SzxBKe
    YCyw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675014501;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yGRM7cEfo5aFqSY1gp1TMJFXgu2PUQKG5rOicfC2/UM=;
    b=YGgxX1rZkRfkfhsomTXlfklMo3l8Zp1Nhf75BARGaQ+UPfWUZ5f8VhF/vgj5grWvTg
    5UGfMx+do+BhUeIfKPgJ04r1ENzjWTQMYqavts/CHPdqRMkEuXVhYJWo54YEBg6zMW/K
    ypyFoAVsrA/K1GS5osDkyowWE2AJ2Q61aM3dPHgFmC+6FULVI5jc/89+x9D8kHZVPGr5
    wLoSlKMs7HVEXpw0UpUoqpsL9lMFG3htTB68j1HpOzU02UeytGKu6tnoIYW45WrDKSMZ
    +O1dx0E1SML60oa+nRoPTCoz37Ej45GYXgdYe3t2N+fGw0ZFKhaq1BpwOgfE+BRt5mkT
    /xqg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1iTDUhfN4hi3qVZrW/J"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 49.2.2 SBL|AUTH)
    with ESMTPSA id e4ab20z0THmKHyv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 29 Jan 2023 18:48:20 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] MIPS: DTS: CI20: fix otg power gpio
Date:   Sun, 29 Jan 2023 18:48:15 +0100
Message-Id: <1e102159b4be526af88883374d112d558e3ac3f5.1675014494.git.hns@goldelico.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to schematics it is PF15 and not PF14 (MIC_SW_EN).
Seems as if it was hidden and not noticed during testing since
there is no sound DT node.

Fixes: 158c774d3c64 ("MIPS: Ingenic: Add missing nodes for Ingenic SoCs and boards.")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 9819abb2465dd..a276488c0f752 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -115,7 +115,7 @@ otg_power: fixedregulator@2 {
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 
-		gpio = <&gpf 14 GPIO_ACTIVE_LOW>;
+		gpio = <&gpf 15 GPIO_ACTIVE_LOW>;
 		enable-active-high;
 	};
 };
-- 
2.38.1

