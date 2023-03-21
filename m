Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B356C3D21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCUV4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCUV4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:56:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDDC3E633;
        Tue, 21 Mar 2023 14:56:30 -0700 (PDT)
Received: from localhost (unknown [188.24.179.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C3DB66030D8;
        Tue, 21 Mar 2023 21:56:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679435789;
        bh=LuZwe7bTMqmCqjiHWWchmraD16aQHXj8HS9LSc1Ljfk=;
        h=From:To:Cc:Subject:Date:From;
        b=edLkylBsVvkmnZKiwqZHTkYbZEwGbNfmRImklUR10H7Mg6YnVIbOIFv1p0CQjjdAt
         LE6eaUFJL6kBiMfjWE+78/760zRywE2C90+6P3iXPqHGB2swj7A+k4dJ89tNL4nMS4
         N15IsfCJWCOGDYhuq+EwLL3qL7IlTH0PA3wxnVCl2uyQ8qYc0WpHDjbyTTuh819kPE
         c8poUMEq22cd5kZVShRByIfYFj1xdIdARjZXUOpcCZ7HcZPoamnyOGcDQp+iFkm8gw
         sKXu5EJ8Vv2hG77WmMblrybY9mDLxiMUyNAlE6eauIkFwJpF9Jvzsj0BOSFj9XBmmn
         S86+p7khrGDRA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 00/10] Enable I2S support for RK3588/RK3588S SoCs
Date:   Tue, 21 Mar 2023 23:56:14 +0200
Message-Id: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are five I2S/PCM/TDM controllers and two I2S/PCM controllers embedded in
the RK3588 and RK3588S SoCs. Furthermore, RK3588 provides four additional
I2S/PCM/TDM controllers.

This patch series adds the required device tree nodes to support all the above.

Additionally, it enables analog audio support for the Rock 5B SBC, which has
been used to test both audio playback and recording.

Note that some of the DT bindings fixes in this series are not particularly
related to I2S, but are required for a proper dtbs_check validation.

Changes in v2:
 - Rebased onto next-20230321 and drop patches 03-08/11 already applied by Mark
 - Replaced patch 01/11 with v2 07/10
 - Reworked patch 02/11 to v2 01-06/10
 - v1: https://lore.kernel.org/lkml/20230315114806.3819515-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (10):
  dt-bindings: serial: snps-dw-apb-uart: Switch dma-names order
  ARM: dts: sun6i: a31: Switch dma-names order for snps,dw-apb-uart
    nodes
  ARM: dts: sun8i: a23/a33: Switch dma-names order for snps,dw-apb-uart
    nodes
  ARM: dts: sun8i: v3s: Switch dma-names order for snps,dw-apb-uart
    nodes
  ARM: dts: sunxi: h3/h5: Switch dma-names order for snps,dw-apb-uart
    nodes
  riscv: dts: allwinner: d1: Switch dma-names order for snps,dw-apb-uart
    nodes
  arm64: dts: rockchip: rk3588s: Move
    assigned-clocks/assigned-clock-rates out of scmi
  arm64: dts: rockchip: rk3588s: Add I2S nodes
  arm64: dts: rockchip: rk3588: Add I2S nodes
  arm64: dts: rockchip: rk3588-rock-5b: Add analog audio

 .../bindings/serial/snps-dw-apb-uart.yaml     |   2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi              |  12 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi          |  10 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi              |   6 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |   8 +-
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |  62 +++++++
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  68 ++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 156 +++++++++++++++++-
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +-
 9 files changed, 307 insertions(+), 29 deletions(-)

-- 
2.40.0

