Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D356046AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiJSNQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiJSNPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:15:53 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A965E78;
        Wed, 19 Oct 2022 06:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XOXKSdEYSGaB7TrIJqdXmUIfhtXAEMTKYNQDMHu+5+o=; b=iAftC1DlOniMYlNZSSECpiAdeK
        LccPSIzdRYsfUO01CsO4alVE/fGnwRYwuh8yCWnIyezwJNnfoiLw0dKNibZEPkgoU07mbmtoHlk6D
        v8nmmHEq6NPHZRQybIes4CrRSzpAzY5RERGXNFZYXgDwYO/fEz2pA+H53F/Jahf9Wr0EEGdCGqxVN
        EhK9t8DAknnY4QX0DtgQ3cJ9AAKS3DqF95q3OFiRP66AP5SNMKSz3pDVKLdEEZHu92HTyylPMN7QH
        fI+2Lzgv5u7mBvsVw+h7SmvW6hAakvBc7xYTQxIJvQltEk6GgkxRFjR734Ybh+4A5r58CcKpokDcO
        IVu/kW/A==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:45936 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1ol74W-007ZXa-71;
        Wed, 19 Oct 2022 13:17:16 +0200
From:   Andrej Picej <andrej.picej@norik.com>
To:     linux-watchdog@vger.kernel.org
Cc:     shawnguo@kernel.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, festevam@gmail.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, robh+dt@kernel.org
Subject: [PATCH 0/3] Suspending i.MX watchdog in WAIT mode
Date:   Wed, 19 Oct 2022 13:17:11 +0200
Message-Id: <20221019111714.1953262-1-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX6 watchdog can't be stopped once started. This means that
special hardware suspend needs to be configured when the device enters
low-power modes.
Usually i.MX devices have two bits which deal with this:
- WDZST bit disables the timer in "deeper" low power modes and
- WDW bit disables the timer in "WAIT" mode which corresponds with
Linux's "freeze" low-power mode.

WDZST bit support is already in place since 1a9c5efa576e ("watchdog: imx2_wdt: disable watchdog timer during low power mode").
WDW bit is not common for all imx2-wdt supported devices, therefore use
a new device-tree property "fsl,suspend-in-wait" which suspends the
watchdog in "WAIT" mode.

Andrej Picej (3):
  watchdog: imx2_wdg: suspend watchdog in WAIT mode
  dt-bindings: watchdog: fsl-imx: document suspend in wait mode
  ARM: dts: imx6ul/ull: suspend i.MX6UL watchdog in wait mode

 .../devicetree/bindings/watchdog/fsl-imx-wdt.yaml          | 5 +++++
 arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi           | 4 ++++
 drivers/watchdog/imx2_wdt.c                                | 7 +++++++
 3 files changed, 16 insertions(+)

-- 
2.25.1

