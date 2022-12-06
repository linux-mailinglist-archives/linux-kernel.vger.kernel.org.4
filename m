Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874B2643CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 06:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiLFFxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 00:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiLFFxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:53:02 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD3C1C92A;
        Mon,  5 Dec 2022 21:53:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670305961; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=eHUppgzpTBO7P6Lj0flr8iHol2Iqh9Me9093vkjxkY7bYpE4dYj6W2hhEh6Qs7Olr4LaPC4UpbhFzvoGmRpZSiAS7VbzXTE6Htd43EC/8DcE7A16aIwdd5d8DSkZ+gS724befRKx5giFe75il62MSksZeZNoQTgZR2viyNO3z8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670305961; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=8OQhkFZBuQ+Ya1Ot1lELUxMRAjlXTh0qx4g/rKP2seQ=; 
        b=jASkVWIbn4+tmFLqv1K6zWfEojjyZfEToxajyAyMXXN4d7rGLb/Dl5TuoyO+Fjhso/QNaDbHDr7TR6fX+FYMeHThWUHdSfSyClAdmdjlg9KdqqsVR1TFAQexIxZrriBNEBEinFjT1YARnW8kR7tSlR10JnNZZ5TXwBWvgoznynM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670305961;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=8OQhkFZBuQ+Ya1Ot1lELUxMRAjlXTh0qx4g/rKP2seQ=;
        b=hNNjZcXFn4B4I5MWpTIt2KTE5gPT+OZWRvKLpeL812ku817GSwZoSdmEefZ8DGBH
        JAQK1bC9D+dgQOR5Gcz5qcLWZgo2lesxeew/DL1Wu7JTwa9FqdNrdwYuP4yebqnzC/4
        oJMj+UzakYc3vyGAeejAAkjX3iZ8TJA58TgnSZF4=
Received: from edelgard.fodlan.icenowy.me (120.85.99.143 [120.85.99.143]) by mx.zohomail.com
        with SMTPS id 1670305959289556.1373358007419; Mon, 5 Dec 2022 21:52:39 -0800 (PST)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v3 0/6] Rongpin RP-H6B support (and support for GL850G)
Date:   Tue,  6 Dec 2022 13:52:22 +0800
Message-Id: <20221206055228.306074-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for Rongpin RP-H6B, and as a dependency,
power sequence support for its onboard USB hub, GL850G.

The first 3 patches are for GL850G, adding a binding for it and adding
its support to onboard_usb_hub driver.

The last 3 patches are for RP-H6B, also 2 for adding a binding and 1 for
the real DT.

Icenowy Zheng (6):
  dt-bindings: vendor-prefixes: add Genesys Logic
  dt-bindings: usb: Add binding for Genesys Logic GL850G hub controller
  usb: misc: onboard_usb_hub: add Genesys Logic GL850G hub support
  vendor-prefixes: Add Shenzhen Rongpin Electronics Co., Ltd
  dt-bindings: arm: sunxi: add Rongpin RP-H6B board
  arm64: dts: allwinner: h6: add Rongpin RP-H6C SoM and RP-H6B board

 .../devicetree/bindings/arm/sunxi.yaml        |   6 +
 .../bindings/usb/genesys,gl850g.yaml          |  48 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../boot/dts/allwinner/sun50i-h6-rp-h6b.dts   | 241 ++++++++++++++++++
 .../boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi  | 179 +++++++++++++
 drivers/usb/misc/onboard_usb_hub.c            |   2 +
 drivers/usb/misc/onboard_usb_hub.h            |   5 +
 8 files changed, 486 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6b.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi

-- 
2.38.1

