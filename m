Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED4D6789F1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjAWVtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjAWVts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:49:48 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015CC301A8;
        Mon, 23 Jan 2023 13:49:46 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30NLnQdN013738;
        Mon, 23 Jan 2023 15:49:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674510566;
        bh=MyyqQRxSD79PO6CaKNfPh36id7qYZrAxiSssyuBnDrw=;
        h=From:To:CC:Subject:Date;
        b=N0rC57oRpAw1yc8u3CPmgsHg8TKdefoQcTblpV2hP7UWW+PdNXpPlDCYnzGYSEk83
         0FKNP8gGw2l5LpV7yEkaJUy2b04/lbgKr47rAX2CimjP+KdRxt1BKvGCgKFHIHe5S0
         7d3cWmONYlEOoE6spNg14Mu1NSr6cJApXi+Sg5HI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30NLnQrc011958
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jan 2023 15:49:26 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 23
 Jan 2023 15:49:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 23 Jan 2023 15:49:26 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30NLnPZk065237;
        Mon, 23 Jan 2023 15:49:25 -0600
From:   Andrew Davis <afd@ti.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v5 0/9] TI-Nspire cleanups
Date:   Mon, 23 Jan 2023 15:49:15 -0600
Message-ID: <20230123214924.27476-1-afd@ti.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This series is an extended version of the series started here[0]
and here[1].

We break out what was the first patch into one for DTS change and
one for code changes as suggested by Krzysztof. Those are now patches
2 and 8 of this series (I kept the ACKs, hope that is okay).

As also pointed out by Krzysztof syscon nodes need a specific
compatible, add that as patch 1.

While I was adding that, I noticed some other dtbs_check issues,
so while here fixed some of those up too (patches 3-6).

Thanks,
Andrew

[0] https://lore.kernel.org/lkml/20221026161302.5319-1-afd@ti.com/
[1] https://lore.kernel.org/linux-arm-kernel/20221027181337.8651-1-afd@ti.com/

Changes from v4:
 - Rebase on latest master

Changes from v3:
 - Add Reviewed-by
 - Make new binding for patch #1

Changes from v2:
 - See cover letter message

Changes from v1:
 - Add ACKs
 - Rebase on latest

Andrew Davis (9):
  dt-bindings: mfd: Add TI-Nspire misc registers
  ARM: dts: nspire: Use syscon-reboot to handle restart
  ARM: dts: nspire: Fix cpu node to conform with DT binding
  ARM: dts: nspire: Fix sram node to conform with DT binding
  ARM: dts: nspire: Fix vbus_reg node to conform with DT binding
  ARM: dts: nspire: Fix uart node to conform with DT binding
  ARM: dts: nspire: Use MATRIX_KEY macro for linux,keymap
  ARM: nspire: Use syscon-reboot to handle restart
  ARM: nspire: Remove unused header file mmio.h

 .../bindings/mfd/ti,nspire-misc.yaml          | 51 ++++++++++
 arch/arm/boot/dts/nspire-clp.dts              | 90 +++++++++++++-----
 arch/arm/boot/dts/nspire-cx.dts               | 92 ++++++++++++++-----
 arch/arm/boot/dts/nspire-tp.dts               | 90 +++++++++++++-----
 arch/arm/boot/dts/nspire.dtsi                 | 24 ++++-
 arch/arm/mach-nspire/Kconfig                  |  2 +
 arch/arm/mach-nspire/mmio.h                   | 16 ----
 arch/arm/mach-nspire/nspire.c                 | 24 -----
 8 files changed, 279 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
 delete mode 100644 arch/arm/mach-nspire/mmio.h

-- 
2.38.1

