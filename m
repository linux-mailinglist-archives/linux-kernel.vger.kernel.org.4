Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C287617A93
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiKCKEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiKCKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:04:28 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0789394;
        Thu,  3 Nov 2022 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3I6cduE/0VLYX77KsgcKyS/YAJZf7qjM4jfGtEfeI/M=; b=mfql3DQCBqVXhPG5MwjUzLku6D
        Yr8akr9e+8qulTiDKL1Gsd/rQ8+DUXTH7SnyAmd04LMW7/JHUwaQxvHm3dI+WlKOLYyfxZltMZuPK
        NjDIEuE6mYsSF/YAPN6TSre0pM2N0XciY6yi1UOOZOO1VMbDvOiMK0wTF57aTpjPo8biBqo2rl7Fa
        JUwIZczyWCrECSn70eok5mBEg5p319EOx1Sye6zebgq+vRGG/s3pjclIveQPKt9tHgoecsozbTBWv
        qQ/Uv3fBYOM6TUSUW5UImHANT074A48HajbHRm7zbX2PJntJBJnIa42G75EJ7gvVZT2S2K55J132Q
        zmd0cUYg==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:37996 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1oqX52-008HsM-9z;
        Thu, 03 Nov 2022 11:04:20 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Suspending i.MX watchdog in WAIT mode
Date:   Thu,  3 Nov 2022 11:03:55 +0100
Message-Id: <20221103100358.176099-1-andrej.picej@norik.com>
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

Here is v1: https://lore.kernel.org/lkml/20221019111714.1953262-1-andrej.picej@norik.com/

Here is v2: https://lore.kernel.org/all/20221025072533.2980154-1-andrej.picej@norik.com/#t

Change log in the corresponding patches.

Andrej Picej (3):
  watchdog: imx2_wdg: suspend watchdog in WAIT mode
  dt-bindings: watchdog: fsl-imx: document suspend in wait mode
  ARM: dts: imx6ul/ull: suspend i.MX6UL watchdog in wait mode

 .../bindings/watchdog/fsl-imx-wdt.yaml        | 33 +++++++++++
 .../boot/dts/imx6ul-phytec-phycore-som.dtsi   |  4 ++
 drivers/watchdog/imx2_wdt.c                   | 55 ++++++++++++++++++-
 3 files changed, 89 insertions(+), 3 deletions(-)

-- 
2.25.1

