Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ABA7486A4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjGEOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjGEOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:43:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CBF1BC8;
        Wed,  5 Jul 2023 07:43:03 -0700 (PDT)
Received: from obbardc-t14.home (unknown [IPv6:2a00:23c8:b70a:ae01:7599:ed26:1798:f430])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 35DA16606FBC;
        Wed,  5 Jul 2023 15:43:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688568182;
        bh=V58cBnqk19ExhjbGA1KcziLl4pEqWwYt10fdubSKHPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCJKws57Os/TNHkGMeIsQr10uHdrPTuGAqhHwMGkGzhXWzoLTs/dveUTQt1OORGV4
         zZPvfXH8fWegzcL8oWKoyo3tj6O/hH0bfnk4QetgKnhnehDuzjz8XMT2t6VFpew2AC
         1POWAKxZYd8H5VPN19pq2sxa/JstaXv6OA1pKpYgJnc1xQitaAXdlDZbWxhce+cJvN
         Yk2yevmq98l4+mdFH9UMguG/ajpF5msAfU7717QMFixGXDzzWpy9Z8lJeRXFsSzqfZ
         lAT0m+b5KleRUF/HjvYs2xNoLbqGSSiBjJWs8gejxZQIIRq697yJjEho5m8YAJrUUa
         lSWp4dDn1isLA==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Chen <stephen@radxa.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+
Date:   Wed,  5 Jul 2023 15:42:55 +0100
Message-Id: <20230705144255.115299-3-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705144255.115299-1-chris.obbard@collabora.com>
References: <20230705144255.115299-1-chris.obbard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some instablity with some eMMC modules on ROCK Pi 4 SBCs running
in HS400 mode. This ends up resulting in some block errors after a while
or after a "heavy" operation utilising the eMMC (e.g. resizing a
filesystem). An example of these errors is as follows:

    [  289.171014] mmc1: running CQE recovery
    [  290.048972] mmc1: running CQE recovery
    [  290.054834] mmc1: running CQE recovery
    [  290.060817] mmc1: running CQE recovery
    [  290.061337] blk_update_request: I/O error, dev mmcblk1, sector 1411072 op 0x1:(WRITE) flags 0x800 phys_seg 36 prio class 0
    [  290.061370] EXT4-fs warning (device mmcblk1p1): ext4_end_bio:348: I/O error 10 writing to inode 29547 starting block 176466)
    [  290.061484] Buffer I/O error on device mmcblk1p1, logical block 172288
    [  290.061531] Buffer I/O error on device mmcblk1p1, logical block 172289
    [  290.061551] Buffer I/O error on device mmcblk1p1, logical block 172290
    [  290.061574] Buffer I/O error on device mmcblk1p1, logical block 172291
    [  290.061592] Buffer I/O error on device mmcblk1p1, logical block 172292
    [  290.061615] Buffer I/O error on device mmcblk1p1, logical block 172293
    [  290.061632] Buffer I/O error on device mmcblk1p1, logical block 172294
    [  290.061654] Buffer I/O error on device mmcblk1p1, logical block 172295
    [  290.061673] Buffer I/O error on device mmcblk1p1, logical block 172296
    [  290.061695] Buffer I/O error on device mmcblk1p1, logical block 172297

Disabling the Command Queue seems to stop the CQE recovery from running,
but doesn't seem to improve the I/O errors. Until this can be investigated
further, disable HS400 mode on the ROCK Pi 4 SBCs to at least stop I/O
errors from occurring.

Fixes: 246450344dad ("arm64: dts: rockchip: rk3399: Radxa ROCK 4C+")
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
index 028eb508ae30..8bfd5f88d1ef 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
@@ -548,9 +548,8 @@ &saradc {
 &sdhci {
 	max-frequency = <150000000>;
 	bus-width = <8>;
-	mmc-hs400-1_8v;
+	mmc-hs200-1_8v;
 	non-removable;
-	mmc-hs400-enhanced-strobe;
 	status = "okay";
 };
 
-- 
2.40.1

