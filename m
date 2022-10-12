Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C85F5FC03B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 07:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJLF4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 01:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJLF4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 01:56:44 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736E29D509;
        Tue, 11 Oct 2022 22:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1665554179; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=WTV4I9AqtF8NEWKXiyfe37p9e+3uoQyKfYMMKC12oZwAqz4QMe1JsRy0FOu6vtNPkZZOx44lwIrjHLxj5Ft++yIKburl2OVO1e1Gfl66Iqdk79W7+QcsxShPpG3e7vSbUx8IITKC8jd69cc8e0offrgSAMPoQiOWjXJwYGLIAUs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1665554179; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=KU9sLoTveoefxunUD/xdovaMeWXf7cwcD0GVI0joPoM=; 
        b=b6n5b7nv2V1N5TSB4RwZK0omSrjLg+YImusPP3qRMMRygR1wb6J6JC4hb0aKS9iAi9CwS6g3H+CAMcUb707DHFxAIZzENW6shhWF7osZ1bLpQvAM3+h1XKSg1W0EqOaiC1pl+VWUlAwBbekhzptXkucPt54L3wTSDYDRd31Ecmo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665554179;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=KU9sLoTveoefxunUD/xdovaMeWXf7cwcD0GVI0joPoM=;
        b=I0EvLcljuAF5RCf6YxJRtkrDKcdbE147s35vorQxWDUg3pV+1dbVCelleqy6AOkf
        f3LXbzBFjoena2/XcwRiiz/RBkuQAZhEA1JosuPLeduMBqm0QEg33YBxS7A9blXtzWf
        RfZTwSpNaVmwBaIZHIELyvyQrPAb1p5pZ/+9I7DQ=
Received: from edelgard.fodlan.icenowy.me (112.94.102.144 [112.94.102.144]) by mx.zohomail.com
        with SMTPS id 1665554178267857.678933146887; Tue, 11 Oct 2022 22:56:18 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 00/10] SUNIV USB and PopStick support (and updating mailmap)
Date:   Wed, 12 Oct 2022 13:55:52 +0800
Message-Id: <20221012055602.1544944-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces support for F1C100s' USB and SourceParts
PopStick board.

As I switched to a new mail address, and this patchset contains patches
authored before this change, a mailmap update is added.

The DT binding and driver support for SUNIV USB PHY/MUSB are added, in
addition to DT changes to the DTSI and Lichee Nano DT. A new DT is added
for SourceParts PopStick v1.1 board.

Icenowy Zheng (10):
  mailmap: update Icenowy Zheng's mail address
  dt-bindings: phy: add binding document for Allwinner F1C100s USB PHY
  dt-bindings: usb: sunxi-musb: add F1C100s MUSB compatible string
  phy: sun4i-usb: add support for the USB PHY on F1C100s SoC
  musb: sunxi: add support for the F1C100s MUSB controller
  ARM: suniv: add USB-related device nodes
  ARM: suniv: f1c100s: enable USB on Lichee Pi Nano
  dt-bindings: vendor-prefixes: add Source Parts
  dt-binding: arm: sunxi: add compatible strings for PopStick v1.1
  ARM: dts: suniv: add device tree for PopStick v1.1

 .mailmap                                      |   3 +
 .../devicetree/bindings/arm/sunxi.yaml        |   7 ++
 .../phy/allwinner,suniv-f1c100s-usb-phy.yaml  |  83 ++++++++++++++
 .../usb/allwinner,sun4i-a10-musb.yaml         |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 .../boot/dts/suniv-f1c100s-licheepi-nano.dts  |  16 +++
 arch/arm/boot/dts/suniv-f1c100s.dtsi          |  26 +++++
 .../boot/dts/suniv-f1c200s-popstick-v1.1.dts  | 101 ++++++++++++++++++
 drivers/phy/allwinner/phy-sun4i-usb.c         |  11 ++
 drivers/usb/musb/sunxi.c                      |   8 +-
 11 files changed, 258 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml
 create mode 100644 arch/arm/boot/dts/suniv-f1c200s-popstick-v1.1.dts

-- 
2.37.1

