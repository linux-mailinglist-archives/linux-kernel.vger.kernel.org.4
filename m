Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6914060C50E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiJYH0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiJYH0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:26:00 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2AD112A8D;
        Tue, 25 Oct 2022 00:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hGXhW6u7vYKwy9A2hNsUWM+US9sTwavux1Peo1AKLrY=; b=DC42333jw/J629nGM+epNrcUC9
        AtQT/jMSsf8mKBmzf8DBmCq8VFHCh1q3p2WZLMr5PEnrXa5K3o5syY2KRxC7oheRAeQryOQ+GtMIM
        w2tPehhGzTcHcZ/CNCMHys9GcythGf/tIihfr/7nlFxgOBwL4uxJIwK7jiLBc03g2I+DbsJ+w97GM
        GBAk1IUdqMnRBWuZJZMuuW4sLaPhBxC9UwM6kFKclrymI7jNiM2n0UWTLVDzlEcS7kDDqbdFQpfv3
        eJM1gAFOgPcTev/GAByNzoDdGpaoyWC0JxxgrjJiiagh0av1UchZsuKPfr6QrSYaX1ADliqlfZOYE
        R5guxMDg==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:33544 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1onEJZ-006HEZ-Bv;
        Tue, 25 Oct 2022 09:25:40 +0200
From:   Andrej Picej <andrej.picej@norik.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Suspending i.MX watchdog in WAIT mode
Date:   Tue, 25 Oct 2022 09:25:30 +0200
Message-Id: <20221025072533.2980154-1-andrej.picej@norik.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX6 watchdog can't be stopped once started. Additionally, watchdog
hardware configuration needs to be able to handle low-power modes of the
SoC. For low-power modes, there are two configuration bits in the TRM:
- WDZST bit disables the watchdog timer in "deeper" low power modes and
- WDW bit disables the watchdog timer in "WAIT" mode

WDZST bit support is already in place since 1a9c5efa576e ("watchdog: imx2_wdt: disable watchdog timer during low power mode").
On the other hand, handling of WDZST bit was omitted so far but now
these patch series bring support for it.

SoC's "WAIT" low-power mode corresponds to Linux's freeze or
Suspend-to-Idle (S0) mode which can be activated with:

$ echo freeze > /sys/power/state

Without these patches, board would be reset by the watchdog after
timeout of 128 seconds since watchdog would not be stopped when SoC
entered Suspend-to-Idle mode. With patches in place, boards using
imx2-wdt are able to stay in Suspend-to-Idle mode indefinitely.

Last but not least, WDW bit is not found on all imx2-wdt supported i.MX
devices, therefore a new device-tree property "fsl,suspend-in-wait" has
been introduced for this.

Here is a v1: https://lore.kernel.org/lkml/20221019111714.1953262-1-andrej.picej@norik.com/

Change log for v2 in the corresponding patches.

Andrej Picej (3):
  watchdog: imx2_wdg: suspend watchdog in WAIT mode
  dt-bindings: watchdog: fsl-imx: document suspend in wait mode
  ARM: dts: imx6ul/ull: suspend i.MX6UL watchdog in wait mode

 .../bindings/watchdog/fsl-imx-wdt.yaml        | 22 +++++++++++
 .../boot/dts/imx6ul-phytec-phycore-som.dtsi   |  4 ++
 drivers/watchdog/imx2_wdt.c                   | 37 +++++++++++++++++++
 3 files changed, 63 insertions(+)

-- 
2.25.1

