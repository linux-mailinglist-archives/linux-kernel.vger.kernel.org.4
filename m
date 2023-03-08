Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685E26B107C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCHRzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjCHRzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:55:20 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C18DC48AB;
        Wed,  8 Mar 2023 09:55:17 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 328GtvmT046087;
        Wed, 8 Mar 2023 10:55:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678294557;
        bh=K7IHF7+UstWFxZtDSa0HAMg1EDco2fgoiSsKWkjkgVs=;
        h=From:To:CC:Subject:Date;
        b=Dy3aHNe5LN+9T+BCsix/y8yh9FpC0GDF98XBhJo7N77mUDPKkwImwCuOo+fPuLQ7U
         nF2i4ifwg6Rz0FohHaNF0DNuo0vJXWMWErubiyrBeMouDes3lCdN5pXdkRr6yG2MZq
         wWykJ62udcL/SiO15qWq2vGnhxjtABdsAPPID4wQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 328GtvuF126391
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Mar 2023 10:55:57 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 8
 Mar 2023 10:55:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 8 Mar 2023 10:55:57 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 328Gtvai014057;
        Wed, 8 Mar 2023 10:55:57 -0600
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
Subject: [PATCH v6 0/9] TI-Nspire cleanups
Date:   Wed, 8 Mar 2023 10:55:47 -0600
Message-ID: <20230308165557.2242-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes from v5:
 - Rebase on latest master
 - Fix DT binding comments from Rob and add ACK

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
2.39.2

