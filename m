Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433CD627843
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiKNI5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbiKNI5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:57:06 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6FF1CB0E;
        Mon, 14 Nov 2022 00:57:04 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0D581100005;
        Mon, 14 Nov 2022 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=k2j6CxMZEOK01Mf9+pd0g+M9UjH0hv+Kntrva20WZTw=;
        b=M/WYY38Hd3U/+XsOUV3QJXiwV6RA4mactiMrmaAuEl0Y6d4dIVOy2st9N0xrK1MYxXj5nZ
        1+qLLfPkkYJ7IE9j1dTxB1BOskjcKtf4iIj/rXKBTys4w/aznhBHu5sjv19WBV8rRVSNHC
        6WNP0pVJbhaHjY3hUwQsS8mPXDWL/wWuk82DxQz7w5K5swjj8nhyvkS6XYIEIf4l7K7K+9
        5mNGnLaWYeo0Ag5QhWN3k897ah1sM4hXl5MuyKgx/fhL2ldDnCfl6xEwA4QrjigSCwEANY
        pT3AZny6wRIfy/H/Yzd+hoeW0pJqIgPB5edJL+6KydCpH+glKvxWWKBfSXeeCg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 0/5] Bindings for NVMEM layouts
Date:   Mon, 14 Nov 2022 09:56:54 +0100
Message-Id: <20221114085659.847611-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A month ago, Michael was sending a new iteration of his series bringing
nvmem layout support. The idea is: we currently can produce nvmem cells
statically defined on top of nvmem devices (which themselves may be MTD
devices sometimes) but in some cases we may need more advanced parsing,
which is possible thanks to the introduction of nvmem layout parsers.

I am not taking over the entire series but I recently tried to make use
of these layouts for the ONIE tlv table layout and Rob (rightfully)
pointed out that the description was messy, because of the mix between
nvmem devices and nvmem parsers. This was known to Michael which
initially argued that it was simpler to handle like that.

So here is a new proposal for the bindings which is described in details
within "dt-bindings: nvmem: Introduce the nvmem-layout container". The
idea to avoid mixing different node contents is to use a container node
when relevant (suggested by Rob) which I named nvmem-layout. This
container will have a compatible that describes the parser (plus
possible additional properties).

Michael, I have a few fixup! patches which apply directly to your former
series in order to support this additional container. I propose we first
settle the bindings (including the two direct use cases as examples) and
once merged, we can move forward and respin both the nvmem series + the
layout drivers.

# Original series (v2) from Michael
Link: https://lore.kernel.org/linux-arm-kernel/20220921115813.208ff789@xps-13/T/#mb97d5376647ff3e686b9c55e3d5e0dc80879e84a

Cheers, Miquèl

Changes since v3:
* Added 'select: false' into the sl28 vpd layout
* Added 'type: objec' and 'additionalProperties: false' to each and
  every nvmem-cell that could be produced by the onie layout to properly
  describe all the subnodes.

Michael Walle (1):
  dt-bindings: nvmem: add YAML schema for the sl28 vpd layout

Miquel Raynal (4):
  dt-bindings: nvmem: Introduce the nvmem-layout container
  dt-bindings: eeprom: Inherit from nvmem.yaml
  dt-bindings: vendor-prefixes: Add ONIE
  dt-bindings: nvmem: add YAML schema for the ONIE tlv layout

 .../devicetree/bindings/eeprom/at24.yaml      |   5 +-
 .../devicetree/bindings/eeprom/at25.yaml      |   1 +
 .../bindings/eeprom/microchip,93lc46b.yaml    |   1 +
 .../nvmem/layouts/kontron,sl28-vpd.yaml       |  62 ++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  34 ++++
 .../nvmem/layouts/onie,tlv-layout.yaml        | 147 ++++++++++++++++++
 .../devicetree/bindings/nvmem/nvmem.yaml      |   7 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 8 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml

-- 
2.34.1

