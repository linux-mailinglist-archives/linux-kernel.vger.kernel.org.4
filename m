Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF30461548C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKAV6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiKAV6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:58:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C9F3894;
        Tue,  1 Nov 2022 14:58:29 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A1Lw5Lt131020;
        Tue, 1 Nov 2022 16:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667339885;
        bh=3BYt3dkrH0h6SL5Lpbf8NEOYEhnfb6iG5Rt+02IgEGU=;
        h=From:To:CC:Subject:Date;
        b=iYvV5EDdsIasYznoa8DTk8hw6HbFAmIBTPtZpnIFgeYoNWNL/e+eWqYgU2Txbmta1
         c3uTIoxbZRMEPP2jkKEimQHV0jeYu6vjAUjH9XkaWlsEN2vt17uG5sxc07HULJHCj+
         wHxGcrsdJBaapKkysF4VJPotO3fx71L2ACh1dsx0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A1Lw5jP021615
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Nov 2022 16:58:05 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 1 Nov
 2022 16:58:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 1 Nov 2022 16:58:05 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A1Lw44l117953;
        Tue, 1 Nov 2022 16:58:04 -0500
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
Subject: [PATCH v4 0/9] TI-Nspire cleanups
Date:   Tue, 1 Nov 2022 16:57:55 -0500
Message-ID: <20221101215804.16262-1-afd@ti.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

 .../bindings/mfd/ti,nspire-misc.yaml          | 55 +++++++++++
 arch/arm/boot/dts/nspire-clp.dts              | 90 +++++++++++++-----
 arch/arm/boot/dts/nspire-cx.dts               | 92 ++++++++++++++-----
 arch/arm/boot/dts/nspire-tp.dts               | 90 +++++++++++++-----
 arch/arm/boot/dts/nspire.dtsi                 | 24 ++++-
 arch/arm/mach-nspire/Kconfig                  |  2 +
 arch/arm/mach-nspire/mmio.h                   | 16 ----
 arch/arm/mach-nspire/nspire.c                 | 24 -----
 8 files changed, 283 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
 delete mode 100644 arch/arm/mach-nspire/mmio.h

-- 
2.37.3

