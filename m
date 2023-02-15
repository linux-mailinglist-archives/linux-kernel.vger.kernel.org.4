Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46814698215
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjBORcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBORcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:32:21 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F9B2A6C5;
        Wed, 15 Feb 2023 09:32:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676482320; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HQvqT92bUalYDEXcdWaXhiyY/rvg7K6sYAq3GVh1o6qml7ccm1TDu4Fkgts0OKwncU
    iNcLQpB83UwJj7eMv4smMaZPsipNrCyaQVxvPKAr4l3JtpbcnrELKVIegvvGpXf36+yz
    2DWVq0EblirVEPw5LNMm/2O8ts7IfttqQBUKtY2dsZqIxBAhJOoe5SyeD3Iy8vtMN4ji
    4nwDBCDgBBezsvOiRXrlDiN5unaVC4bNvZJvU2I3HTwa4itX2CAiVJqIB01Jh6t6+pHu
    Vun2RCCOwEtRp2AdJ7xtlfAiZKEPVfbI9u0ZA0VLIWqAU5TKisiZQ8tn0unMY6ZIz0xj
    D4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1676482320;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=POPnc3DgxELJpdHFCNQYcK/7farU8e90UR7vp24J0Pg=;
    b=TAmr9DJ/o8yHciZS3o5KhVX84JFKJaPtcukPskoj7HXZdZETNrZeDBtNzTQGmtQtOb
    KH84QspR2JVoQkgdd9w3FL4pSQHrKmDjU9rWKAs5gALevIo7Ze7giJYrlHaWU3hzVMnR
    Z7mkmuAL5mRvjRhG3vWC0uf7MTH/SwjT4fiujRhTY0AB0oL21uPiB/XclnRYw+Zz+w/4
    yDIxiNQ9c0NuFZbbPZBLt6GHI2vDvRL+GGgMbClB4SDeJywIE2oyeYzg0MjpTw8C2+UJ
    cZJ5t9B06+AkUjSDQ46VkXuSFjiKrGnFNKpGUNoqH6HS5p5wHdzOp5pTqZUZz5DL+O8h
    hJIA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1676482320;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=POPnc3DgxELJpdHFCNQYcK/7farU8e90UR7vp24J0Pg=;
    b=tFwpzl5lxKyU4IxiJvVMotxkgk3/0CIATG7/ooLO/fwa0cAleNrsK6cS8xrNIehBa7
    egEYhBlVTMdy7u8twWdXBwvtnSSSZoTCFSSF4K0+bGIiib6FUykjs0ElCe32aM9c7Ugm
    rKptTEv6qpb0byvfBTADkx4qOfma2p70+vI9nWLoVEI1Xx9UGo81KdVx6H2yu9YqbNqv
    9E2TINqxDnZmyYk7TVFz5OODD1qg+UhI2f8SZPJqGEbuw7eirrY4WGeDFElzXj4LN1C+
    W80+0M7vf90rlD45xFD32BZ3AwpjjQofr30xMlzccCAz2DH+Twoe5V2ZMRlcTdJwlL3u
    pv8A==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1iTDUhfN4hi3qVZrWLJ"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 49.3.0 DYNA|AUTH)
    with ESMTPSA id 326d57z1FHW0ZCP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 15 Feb 2023 18:32:00 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     riccardo Mottola <riccardo.mottola@libero.it>, paul@boddie.org.uk,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 1/3] MIPS: DTS: jz4780: add #clock-cells to rtc_dev
Date:   Wed, 15 Feb 2023 18:31:56 +0100
Message-Id: <77bcc96a2b81e42b32d48a041d7fac31e7240e56.1676482318.git.hns@goldelico.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676482318.git.hns@goldelico.com>
References: <cover.1676482318.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the driver present the clk32k signal if requested.
It is needed to clock the PMU of the BCM4330 WiFi and Bluetooth
module of the CI20 board.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index c182a656d63bc..18affff85ce38 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -155,6 +155,8 @@ rtc_dev: rtc@10003000 {
 
 		clocks = <&cgu JZ4780_CLK_RTCLK>;
 		clock-names = "rtc";
+
+		#clock-cells = <0>;
 	};
 
 	pinctrl: pin-controller@10010000 {
-- 
2.38.1

