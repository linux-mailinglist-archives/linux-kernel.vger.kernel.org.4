Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B996ADCA4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCGK57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjCGK5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:57:16 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87465BC96
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=4mm8gzugz/LKPOnrSnGBA1wGuYK
        TmbMwr1Q5F6dfzyo=; b=jiW8Bw5NAthQuCyLBvVfzMtIHrXPqoKloOTrFBfEiJM
        A0OVrCPSovkd7Nwduov14OzTo4pzHjWSJaK1JP4VpCkrtiP78dMkjF0hO0sES5BP
        FovAlCmSXh4E2oqrcexBjCIQ2XEfUtOCabhXHDRbRv+nvV3AfHAwNwE3H7pIxftE
        =
Received: (qmail 650815 invoked from network); 7 Mar 2023 11:57:02 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 11:57:02 +0100
X-UD-Smtp-Session: l3s3148p1@JaBNRU32HoggAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] renesas: remove support for H3 ES1
Date:   Tue,  7 Mar 2023 11:56:36 +0100
Message-Id: <20230307105645.5285-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because H3 ES1 becomes an increasing maintenance burden and was only
available to a development group, we decided to remove upstream support
for it. It doesn't even boot since v6.3-rc1. Here are the patches to
remove the architecture and core bits. Other driver changes will be sent
individually. Review tags have been gathered before during an internal
discussion. Only change since the internal version is a plain rebase to
v6.3-rc1. A branch with all removals is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/h3es1-removal


Wolfram Sang (5):
  pinctrl: renesas: remove R-Car H3 ES1.* handling
  arm64: dts: renesas: remove R-Car H3 ES1.* devicetrees
  dt-bindings: soc: renesas: remove R-Car H3 ES1.*
  soc: renesas: rcar-sysc: remove R-Car H3 ES1.* handling
  soc: renesas: remove r8a77950 arch

 .../bindings/soc/renesas/renesas.yaml         |    8 +-
 arch/arm64/boot/dts/renesas/Makefile          |    4 -
 .../boot/dts/renesas/r8a77950-salvator-x.dts  |   49 -
 .../boot/dts/renesas/r8a77950-ulcb-kf.dts     |   16 -
 arch/arm64/boot/dts/renesas/r8a77950-ulcb.dts |   37 -
 arch/arm64/boot/dts/renesas/r8a77950.dtsi     |  330 -
 arch/arm64/configs/defconfig                  |    1 -
 drivers/pinctrl/renesas/Kconfig               |    5 -
 drivers/pinctrl/renesas/Makefile              |    1 -
 drivers/pinctrl/renesas/core.c                |   41 +-
 drivers/pinctrl/renesas/pfc-r8a77950.c        | 5947 -----------------
 drivers/pinctrl/renesas/sh_pfc.h              |    1 -
 drivers/soc/renesas/Kconfig                   |    7 -
 drivers/soc/renesas/r8a7795-sysc.c            |   10 -
 drivers/soc/renesas/renesas-soc.c             |    2 +-
 include/dt-bindings/power/r8a7795-sysc.h      |    1 -
 16 files changed, 8 insertions(+), 6452 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dts
 delete mode 100644 arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dts
 delete mode 100644 arch/arm64/boot/dts/renesas/r8a77950-ulcb.dts
 delete mode 100644 arch/arm64/boot/dts/renesas/r8a77950.dtsi
 delete mode 100644 drivers/pinctrl/renesas/pfc-r8a77950.c

-- 
2.35.1

