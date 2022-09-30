Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025415F0426
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiI3FNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiI3FNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:13:12 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BC153A71;
        Thu, 29 Sep 2022 22:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
        Content-Description:In-Reply-To:References:X-Debbugs-Cc;
        bh=n+CAzKhijUMiUbAxRPeYjENYTWUoQz/5++2HQzml4QQ=; b=yDT6ZUylaDhJhDZXAJhIGBWiLh
        nBWtRdbx549cGBuROjRctgRH/nzgvC10f4Op4Xcew/fHg88YaCCEVL3EZhhj2xFBfD5Vgt7xJJ2ul
        Mh5xUMXhyqMxc9T8KU3n2QQx1XNjVl2SjACji43OQekOml1mIfhWDuiN+b4A3Ki03ahztQILuwICJ
        RTBjEw5FvfrzlJSM3oBbC8kMZPecgr14hviEue9MDA0sISyYZuCyBeU8T3QTkDYsDEWz6vXJwjHtg
        1LYhU31BmJceWa0C1Gz9Vabdii2kP69m5Lx3bddvNM6+yAJPsWrtQlOC6psTy7VNXvLJj8MZ7YuXp
        ADuqIEug==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1oe8Kb-00Dje3-Py; Fri, 30 Sep 2022 07:13:01 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1oe8Kb-001duB-0j;
        Fri, 30 Sep 2022 07:13:01 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list)
Cc:     Dongjin Kim <tobetter@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v3 00/13] Add support for the Hardkernel ODROID-M1 board
Date:   Fri, 30 Sep 2022 07:12:33 +0200
Message-Id: <20220930051246.391614-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the ODROID forum, Dongjin Kim said he is not planning to submit a new
version of the patchset adding support for the Hardkernel ODROID-M1
board. I therefore decided to address the issues reported during the
initial review, and I also did some small fixes either because some
things changed in the meantime on the kernel side or because I noticed
some warning or issues when using the hardware.

I continued writing some additional patches to complete the ODROID M1
DTS to almost fully support the hardware, the drivers being already
present in the kernel.

This new version includes feedback from the linux-rockchip mailing list
and from the Odroid forum.

Changes since v2:
* Renamed "Rockchip RK3568 Hardkernel ODROID-M1" into "Hardkernel Odroid
  M1" and fix the sorting.
* Fix sorting of arch/arm64/boot/dts/rockchip/Makefile
* Collected Acked-by and Tested-by
* Switched the NOR flash to dual I/O from quad I/O to solve a pin
  conflicts with the EMMC.
* Added a comment about the pull-up on the IR receiver GPIO

Changes since v1 (patches 1 & 2):
* Added Acked-by to the first patch
* Fixed indentation
* Removed unneeded labels
* Renamed labels to not use underscore
* Renamed regulator nodes
* Added -pin to pinctrl bindings
* Changed GPU related regulators to always on (see 2cda380102ff)
* Added phy-supply to gmac0
* Added supplies to sdhci
* Changed SD card speed to SDR50 from SDR104 (see 1ea90b2d293f)
* Fixed power LED polarity and set the default-state to "keep"

Aurelien Jarno (11):
  arm64: dts: rockchip: add thermal support to ODROID-M1
  arm64: dts: rockchip: Add NOR flash to ODROID-M1
  arm64: dts: rockchip: Add analog audio on ODROID-M1
  arm64: dts: rockchip: Enable vop2 and hdmi tx on ODROID-M1
  arm64: dts: rockchip: Enable HDMI audio on ODROID-M1.
  arm64: dts: rockchip: Enable the GPU on ODROID-M1
  arm64: dts: rockchip: Enable the USB 2.0 ports on ODROID-M1
  arm64: dts: rockchip: Enable the USB 3.0 ports on ODROID-M1
  arm64: dts: rockchip: Add SATA support to ODROID-M1
  arm64: dts: rockchip: Add PCIEe v3 nodes to ODROID-M1
  arm64: dts: rockchip: Add IR receiver node to ODROID-M1

Dongjin Kim (2):
  dt-bindings: rockchip: Add Hardkernel ODROID-M1 board
  arm64: dts: rockchip: Add Hardkernel ODROID-M1 board

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-odroid-m1.dts    | 744 ++++++++++++++++++
 3 files changed, 750 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts

-- 
2.35.1

