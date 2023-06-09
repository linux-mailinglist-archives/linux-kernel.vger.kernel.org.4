Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D2D729B98
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbjFIN31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjFIN30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:29:26 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97369A3;
        Fri,  9 Jun 2023 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686317364; x=1717853364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JAIRug1n6Vg8kLavFuz85RwEkI8s8IGW/QfdDqdEKuk=;
  b=cCYWzRYH0zxenAIaljMO5uvAOzlUkEaunpmZbNpfROBrQ6R2nzLhY49O
   u55gFR2epFXuNlEyu+L8YIgVoG/Fno+QoQM31Hi9wqXqI0p7fdv9StCdF
   D2qhI/M36uqKOc/gicypBdFrvB4+up7Q+csLymO8pW/Tgwq3o8C8EjBQT
   /TeS0MpLRiMmh7mXGbdgGIbdjO0rImPvMKMYJihL3F4Na0m8k4bO68yNz
   oqlSV3KB+Z29wxO2ZZYRC+K2b5TZbOJQyQQ0tJ6HkXmPP4OlkNC/2px1S
   iqXRN/CAjsf4Wp8GSwbA1v+2Ryo/CTUY94Nvj0subB4i7WVA/nfciMKdh
   A==;
X-IronPort-AV: E=Sophos;i="6.00,229,1681164000"; 
   d="scan'208";a="31366198"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Jun 2023 15:29:22 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 09 Jun 2023 15:29:22 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 09 Jun 2023 15:29:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686317362; x=1717853362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JAIRug1n6Vg8kLavFuz85RwEkI8s8IGW/QfdDqdEKuk=;
  b=fgRyrcmCNO0A6Qryke9uewuR9hn7l7fhj1SRNuDna+je0OBjP58afA8u
   aGLsKqP4x6moXWEacPeMl+l0u0+Rg6UxX9dHFCrFeeF9eNvXiG5CMwmmU
   LWA6q3xVjCeEf+1gaSSn219x1WCG0erHA4zhGIgOm9LXZGhh1OkXfuf0/
   XG/OrDFqfIl4USPEL+shJQMXY6byJ17wksXPGPWIvBSbZvNxndCTGnuHr
   +Z1ZU0vU/jhDaemlMgwmauF/CYq10n3uyb2edEuByvb/T4JRirdZkAWd7
   OKZqHYq/aCKMk1gG3ch9SkKKmMMP/b49E9mozcvGaMHMBbBHlbHPiEzZb
   A==;
X-IronPort-AV: E=Sophos;i="6.00,229,1681164000"; 
   d="scan'208";a="31366197"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Jun 2023 15:29:22 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DE9BB280087;
        Fri,  9 Jun 2023 15:29:21 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: [PATCH 0/3] TQMa93xxLA support
Date:   Fri,  9 Jun 2023 15:29:12 +0200
Message-Id: <20230609132915.634338-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series adds initial support for TQMa93xxLA soldered on MBa93xxLA.
As the name indicates this is an i.MX93 based SBC board. The initial support
includes typical interfaces like UART, eMMC, I2C, Ethernet.
Support for USB, LVDS and PMIC is still pending, which require additional
patches.
Patch 1 adds the compatible to dt bindings
Patch 2 adds .dts[i] files for module and sbc board support
Patch 3 adds more i.MX93 drivers to arm64 defconfig

Best regards,
Alexander

Alexander Stein (2):
  arm64: dts: freescale: add initial device tree for MBa93xxLA SBC board
  arm64: defconfig: Enable i.MX93 devices

Markus Niebel (1):
  dt: bindings: add bindings for TQMa93xxLA SOM

 .../devicetree/bindings/arm/fsl.yaml          |  19 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 629 ++++++++++++++++++
 .../boot/dts/freescale/imx93-tqma9352.dtsi    | 213 ++++++
 arch/arm64/configs/defconfig                  |   4 +
 5 files changed, 866 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi

-- 
2.34.1

