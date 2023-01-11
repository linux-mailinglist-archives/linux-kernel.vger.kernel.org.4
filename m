Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E27B665C66
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjAKNY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjAKNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:23:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967D925EF;
        Wed, 11 Jan 2023 05:23:52 -0800 (PST)
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 232EB6602D25;
        Wed, 11 Jan 2023 13:23:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673443431;
        bh=fUtBuXNZZN6sJKtz2foNJG/6jjIQDx2/dDnnSykJHZs=;
        h=From:To:Cc:Subject:Date:From;
        b=EN4P/vZqd9Y5m2xJ9EycGck64+cXiD/B1l2qxGj+uDH+L05h6B0ckIYRmT3X/TzuI
         cM+vH6ZnUw9aNqcsR39fmkWWYe+r+Bqmmv3cy1sD0JFhI3eiuwjzbV3Z8Mv5i1+kwo
         mA6g2lNvMtKoIBvffuCOZ4xwYwEb5U+ZBG6bbDIceSJ5GKJSzqYFOQ/dXJhXVCttgG
         ItTnx1k00qwLMApezJGkOTht6s7IqhtnvIam+AEFCg/b++EMAAc4Db8oizsetH7F5i
         NOWMRQ6WDF9ZeU7IlzBu4Kxc5MSK4ue6TWgvJFFjwm2jGrfKg0Wk6aPqY3HSF8xCpl
         BhwUxm0nxK71A==
Received: by beast.luon.net (Postfix, from userid 1000)
        id A36A460ABD63; Wed, 11 Jan 2023 14:23:48 +0100 (CET)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     kernel@collabora.com, Nitin Yadav <n-yadav@ti.com>,
        martyn.welch@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Improve K3-am625-sk support (USB, MMC)
Date:   Wed, 11 Jan 2023 14:23:44 +0100
Message-Id: <20230111132348.553061-1-sjoerd@collabora.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series picks up a few patches from the TI BSP tree that
unfortunately didn't make it upstream thusfar.

The first patch improve SD card compatibility (allowing U1 class cards
to be used), the remaining ones add USB support.

The type-c connector isn't entirely modelled with these changes as
it goes through a TPS6598 PD controller. Unfortunately the dtb bindings
for that currently require an irq line, which is not connected on E1 and
E2 version boards. The patchese to support this setup unfortunately didn't land
yet[0].. As such the last patch ignored the PD controller and simply
configures usb0 as periphal only rather then mode switch capable, which
at least gives some basic usability of that USB port.

0: https://lore.kernel.org/lkml/f714ee55-ef47-317d-81b9-57020dda064b@ti.com/T/

Changes in v3:
- Rebased against current ti-next aka 6.2-rc1
- Add Martyn's tested-by

Changes in v2:
- Rebase against linux-next 20221220

Aswath Govindraju (2):
  arm64: dts: ti: k3-am62-main: Add support for USB
  arm64: dts: ti: k3-am625-sk: Add support for USB

Nitin Yadav (1):
  arm64: dts: ti: k3-am62-main: Update OTAP and ITAP delay select

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 90 ++++++++++++++++++------
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 50 +++++++++++++
 2 files changed, 118 insertions(+), 22 deletions(-)

-- 
2.39.0

