Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CF5619D76
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiKDQin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKDQij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:38:39 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4750425EA4;
        Fri,  4 Nov 2022 09:38:37 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D5003C0004;
        Fri,  4 Nov 2022 16:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667579915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=e9XKbe2mUkU1EoIARk/XvvxHVyrHP8xE0gIy/lmQxXA=;
        b=KB7Fp9zuC/EYFOWRALKkPfEfxYDcoTiHGV/qk2YYJITg9bTX71VBVidxLZeKrXlkBVeTE0
        CVE8HOwuYSUB6SAhXirCD2gyIKNJM9jvZYtglktmK6kxGb+0PRcoSYa85dVbFGJEAhHhRV
        8TD/fZoyLSJBw3C3rlEabcUKK/NzERPfYXgEL0G7TOW6GjkYiqwMSwiKvogKfh0yme024K
        R197zicfdH44NXKG1qFWZIojGqwDm5WH3SwOpYr0Vf6nNMYmGa+zVj+SvxR2apGN8eEWvz
        hSJoW1Cc0lDrWvNyHFCqHbsi1YSyTbNA0XMv7F3++tQ1NMrw9eF2ARvDB4KxPA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Eggers <ceggers@arri.de>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 0/6] Bindings for NVMEM layouts
Date:   Fri,  4 Nov 2022 17:38:27 +0100
Message-Id: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Michael Walle (1):
  dt-bindings: nvmem: add YAML schema for the sl28 vpd layout

Miquel Raynal (5):
  dt-bindings: nvmem: Fix example
  dt-bindings: nvmem: Introduce the nvmem-layout container
  dt-bindings: eeprom: Inherit from nvmem.yaml
  dt-bindings: vendor-prefixes: Add ONIE
  dt-bindings: nvmem: add YAML schema for the ONIE tlv layout

 .../devicetree/bindings/eeprom/at24.yaml      |   5 +-
 .../devicetree/bindings/eeprom/at25.yaml      |   1 +
 .../bindings/eeprom/microchip,93lc46b.yaml    |   1 +
 .../nvmem/layouts/kontron,sl28-vpd.yaml       |  60 +++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  34 ++++++
 .../nvmem/layouts/onie,tlv-layout.yaml        | 115 ++++++++++++++++++
 .../devicetree/bindings/nvmem/nvmem.yaml      |   8 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 8 files changed, 225 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml

-- 
2.34.1

