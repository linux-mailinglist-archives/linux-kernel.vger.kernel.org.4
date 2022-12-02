Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2047C6401E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiLBITR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiLBISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:18:33 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E645E1EAC6;
        Fri,  2 Dec 2022 00:17:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669969031; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fcVewZldKncb6j1PoPnBElDnLVox713Ohq+ymTPuOo8IvxTOaFptP10ejYPnlmEvHvczFp5OW8VD4608FYsT2ykMULwTlEaFgG38g6ZttwB1xLa498jkiqrC7rqiBPahO+BqqmGzRFEUH1Oli+fW/TZ4Ab+1jtK7hxIio51sRGI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669969031; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=YIzz/PGBcPTlSH8dJ/HBResd3KIZPeXPFBtcS7AZsGk=; 
        b=U0BI5HzvkqmG3tyLOdEf7w0a0xOgqCvQqlrm02qHJ9M1uhB9sm5nDTUQEl1SxvWTzS8BtJY0vfFY5IT3Lu3frFihwaKUaIjwULaaB3f7KjzSArpDvHzapaUNiwaNjhMAlLGFIq4/YOLnd/maYXyYUu0sM+K8A1FPEGbHsKjvMtg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669969031;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=YIzz/PGBcPTlSH8dJ/HBResd3KIZPeXPFBtcS7AZsGk=;
        b=R/h50a77guC0LJhHmS5oRs+RJ5RY5hXNaghsbJn8Zd8lYCJ9bilII3xBTELK4f/N
        ieMSubjtbnfmdSSy1tG2XuvNfp8olpwaacCsZJdNbq03YU6Tw0+TKv+Dkcm9P+w061/
        Zg1WhNIFNaqKnywKJZ2nuWg0JbiVxpj1hVexVkAQ=
Received: from edelgard.fodlan.icenowy.me (120.85.99.229 [120.85.99.229]) by mx.zohomail.com
        with SMTPS id 1669969029673596.6798764411155; Fri, 2 Dec 2022 00:17:09 -0800 (PST)
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
Subject: [PATCH v2 0/6] Rongpin RP-H6B support (and support for GL850G)
Date:   Fri,  2 Dec 2022 16:16:41 +0800
Message-Id: <20221202081647.3183870-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
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
 .../bindings/usb/genesys,gl850g.yaml          |  47 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../boot/dts/allwinner/sun50i-h6-rp-h6b.dts   | 239 ++++++++++++++++++
 .../boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi  | 180 +++++++++++++
 drivers/usb/misc/onboard_usb_hub.c            |   2 +
 drivers/usb/misc/onboard_usb_hub.h            |   5 +
 8 files changed, 484 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6b.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi

-- 
2.38.1

