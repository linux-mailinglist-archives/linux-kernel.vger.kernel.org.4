Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C294A71F221
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjFAScb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjFAScI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:32:08 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9306D1A4;
        Thu,  1 Jun 2023 11:32:05 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 351IVrAt014490;
        Thu, 1 Jun 2023 13:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685644313;
        bh=2VUuyHFSKVTgqy5FS7onxI5CWMUgHFfocdfhtBzQ7BE=;
        h=From:To:CC:Subject:Date;
        b=c/n1m+SxGXSsaMARfFlKuig1uttIs4ls9haB+ZTHI5CO/eul6unJ3g967wdPyDWDp
         LyqQZcvfBPdAfPgkaIJsMzDt9jv3JyEYxz+U3B8Gj3lcy7q6nKYsjPaESPEXM/7FxD
         MX8oiE6fc9cvba+gQMVOgw/t/DE+/EhdXBBb0rQI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 351IVrVR069833
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 13:31:53 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 13:31:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 13:31:53 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 351IVrOP002963;
        Thu, 1 Jun 2023 13:31:53 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 0/9] arm64: dts: ti: k3-j721e-*: Fix up pinmux and aliases
Date:   Thu, 1 Jun 2023 13:31:42 -0500
Message-ID: <20230601183151.1000157-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series cleansup k3-j721e platforms for pinmuxes and aliases.
Provide complete description of uart and i2c instead of piggy-backing on
bootloader configurations, ensure board detection eeproms are defined,
aliases be defined in the board files as well.

Many of these changes were maintained in u-boot tree, and this moves
those orphan changes to the super set definition in kernel.

Sample bootlog: j721e-common-proc-board in idk-gw configuration:
	https://gist.github.com/nmenon/65fee02cb7a5207ac0d078f6abac6b6e

Nishanth Menon (9):
  arm64: dts: ti: k3-j721e-sk: Add missing uart pinmuxes
  arm64: dts: ti: k3-j721e-sk: Enable wakeup_i2c0 and eeprom
  arm64: dts: ti: j721e-som/common-proc-board: Add product links
  arm64: dts: ti: j721e-common-proc-board: Add uart pinmux
  arm64: dts: ti: k3-j721e-som-p0: Enable wakeup_i2c0 and eeprom
  arm64: dts: ti: k3-j721e-beagleboneai64: Add wakeup_uart pinmux
  arm64: dts: ti: k3-j721e-sk: Define aliases at board level
  arm64: dts: ti: k3-j721e-common-proc-board: Define aliases at board
    level
  arm64: dts: ti: k3-j721e: Drop SoC level aliases

 .../boot/dts/ti/k3-j721e-beagleboneai64.dts   |  9 +++
 .../dts/ti/k3-j721e-common-proc-board.dts     | 76 ++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 53 ++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 15 ++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          | 19 -----
 5 files changed, 147 insertions(+), 25 deletions(-)

-- 
2.40.0

