Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0931374869F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjGEOnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjGEOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:43:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A401717;
        Wed,  5 Jul 2023 07:43:03 -0700 (PDT)
Received: from obbardc-t14.home (unknown [IPv6:2a00:23c8:b70a:ae01:7599:ed26:1798:f430])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3E2906601F5E;
        Wed,  5 Jul 2023 15:43:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688568181;
        bh=P5Fm2OLmai5YtKVyYGBI2DmPwndevSpJJeqkn7lP5ck=;
        h=From:To:Cc:Subject:Date:From;
        b=TmpRt2quPRUL1+pIUMicinQ4wqcXrxe0QccFxpINEWL3onIO1SDx8kBo9oPwvQttb
         YSPGD2baFTCg/3ZKSYAcE9g8ToOViebdtTp/NyUFB16m0n9PSNXfE3W4txR94K5mSh
         C3CF6d6HUGiDZkIpX3twktyeyTfEP5QmFJFSYEQIMmp6oDWpdaSerOEkZpv2zFL1tC
         MW6QBVkgr45bzi5s1kQj9dLP+i3AK/XubqOg/7Dh+UeBKRQ5rxAwRpKbyoUYVB2gWO
         XwJgW8iTMNzqMntbv9h0hT/yP54688jSGNv40jJG3a2Kkgr5VRCdkUU2GBjgKrp61q
         GoaBsdzHk03qg==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        Conor Dooley <conor+dt@kernel.org>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Chen <stephen@radxa.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Disable HS400 for eMMC on Radxa ROCK 4 SBCs
Date:   Wed,  5 Jul 2023 15:42:53 +0100
Message-Id: <20230705144255.115299-1-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.40.1
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


Christopher Obbard (2):
  arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
  arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+

 arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts | 3 +--
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.40.1

