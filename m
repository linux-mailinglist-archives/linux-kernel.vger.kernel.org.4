Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A279F5EB01F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiIZSh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiIZShn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:37:43 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E2467150;
        Mon, 26 Sep 2022 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
        Content-Description:In-Reply-To:References:X-Debbugs-Cc;
        bh=pOTtI3CgLRKXnWV3PLfmDj3rDB3dPXMnNTFNvS5R1M4=; b=io1bzKI2bzAgHPSr558LWj0zdn
        MTPE34E4bTgdsSUEEABuJEp8w/PFryyOatFrKRYnZpdTP3ujPMzuEBgPW0cE1Fv6NQ+suxuvx+RYD
        DmBtLzEJbKmqKB9EhkeDd7mTfuS/t1xjfo96gP2b16HucYeSMtLPoKNxYAYBF7eTgMu1SLTz65ckd
        nCSl+RvXd45fQIjA+0u9DdVKhgutqDDUG1N0Lkj1yo/hSTPV4QNSMBYWBb2WVaqcTim4m1qsxYm9u
        sTMXANKIVA8A+wxa8HCXqZj2i4g7WslPiQ85aK1d3YDfPE4sUqziAlK+FVgjQ9KIymRK9TJixdb/+
        d18aW38g==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsz2-00B9PR-Io; Mon, 26 Sep 2022 20:37:36 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsz1-007wbn-1C;
        Mon, 26 Sep 2022 20:37:35 +0200
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
Subject: [PATCH v2 00/13] Add support for the Hardkernel ODROID-M1 board
Date:   Mon, 26 Sep 2022 20:37:14 +0200
Message-Id: <20220926183727.1893566-1-aurelien@aurel32.net>
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
 .../boot/dts/rockchip/rk3568-odroid-m1.dts    | 727 ++++++++++++++++++
 3 files changed, 733 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts

-- 
2.35.1

