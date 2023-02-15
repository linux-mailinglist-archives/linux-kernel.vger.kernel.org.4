Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FF8698217
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjBORc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBORcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:32:21 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F532A154;
        Wed, 15 Feb 2023 09:32:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676482321; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rPLM5Xcac2m513xoxbe7CbXNY+eksezz2EH8vfK0XSh1jKjbkbhWHD0XQDpuFx5Arq
    uXc5cHP2f7cG3QE+4ZMEQq+EUHABEX1VBiuLlxt2sN50TguobVJi+nIg7n3ft+KrvhTs
    1QPKzMRvE1z9y1C2WzA7HpCZdQSa+jDy7GODpazcWWav2KZu8gas0vvFCUTCLwt/uRVJ
    0VRnQ6ojvpLB40j2ZRvt7tBaq1qFuPP2zEQmu4cU+/9YFR9/D/rd9xburoZW2BSBasB7
    HaT0Ssyw9ofmctB03QSWfqoWj5wEsYoUVb0JEU2/jk1NJIGZSOUbZkjUMc6gz4l5q6S1
    PoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1676482321;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=8fAdvo57eZc8KJao/TwLnUz6LYRm479MPxgqta+3GVI=;
    b=fC3mjvh7LdQQJla+UJ+rwikleHYx2UVuLvMldagLkveZ0300oFFgFecNAWkSmLdwEH
    a3znXc60QtG1wdq2QxuFKHnUQxTaeBDnVbLaVWrbSZdQghtad+JIIpcXvoyOMIduW5rT
    gKQn9vpbitTSF/TWov6Dsd5DZJmhfohvw4NSek9ZGiNp2/mOgcn+fKyjwRfeIUw2VAaZ
    VCfm/YyvR6U24XbJM+xRiBXY7tMt1Z/QkfgZDO7kJZ4kdmDrvb5rTR/fqeHLMQAQuHQA
    yp3O8LqNqTaCUMduZY0i/WrZqw9p8nBPMjhKulb0IapSzVSeW9mi8HcbsyvIS9SMxuh9
    MX/Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1676482321;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=8fAdvo57eZc8KJao/TwLnUz6LYRm479MPxgqta+3GVI=;
    b=HbLT82TzhXD9Ki5sbLMBLUsn9tMbinjMLuSXfBWCGe9rmCIZYMCLcBTaBcRD1s96Q7
    DXtel95SmJLEUypDQax8O7nOErJ6B02wI9o+LsaqoOFWEkm73MKMNfVeQfZYwkPp57kv
    Rrg/VDK1ji4t/9NNjxPpyq3IRyjBxHINGqQG7RAaldGUrHNOarS4hM7B3SBQyhNzFPkV
    LKrjOXIGIcy53merFOlc/qhOC1cjharVkOI2MC67RIn1eQoCP2QbWqgmtCqE42DHZdVJ
    g/8hx4rdVjOmTqOqXqWYN3xWfdC68c0E3ZT+lHAyDu/nDIAwVHvKKo4RxF106POwm5p2
    hkYw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1iTDUhfN4hi3qVZrWLJ"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 49.3.0 DYNA|AUTH)
    with ESMTPSA id 326d57z1FHW1ZCR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 15 Feb 2023 18:32:01 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     riccardo Mottola <riccardo.mottola@libero.it>, paul@boddie.org.uk,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 3/3] MIPS: configs: ci20: enable drivers we need for WiFi/Bluetooth
Date:   Wed, 15 Feb 2023 18:31:58 +0100
Message-Id: <5cc861c6df2fdc5c762408cbae118b90b9d579e9.1676482318.git.hns@goldelico.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676482318.git.hns@goldelico.com>
References: <cover.1676482318.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to add CONFIG to load the serdev Bluetooth driver
from the DTS hints.

Bluetooth must be configured as built into the kernel, otherwise
some components will be loaded in the wrong order.

WLAN must be configured as a kernel module, otherwise the driver will
not be loaded properly by the SDIO subsystem. If it is started too early,
there is no root file system (if initrd is not present) with the
required brcm/BCM4330B1.hcd firmware.

The pcf8563 driver should not be enabled because it can interrupt the
32 kHz clock after the modules are already powered on, depending on the
random driver probe sequence.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/configs/ci20_defconfig | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index 11f08b6a3013f..2f58d4da30ffb 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -68,7 +68,17 @@ CONFIG_DM9000_FORCE_SIMPLE_PHY_POLL=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
-# CONFIG_WLAN is not set
+CONFIG_WLAN=y
+CONFIG_WLAN_VENDOR_BROADCOM=y
+CONFIG_WIRELESS_EXT=y
+CONFIG_WEXT_CORE=y
+CONFIG_WEXT_PROC=y
+CONFIG_WEXT_PRIV=y
+CONFIG_CFG80211=m
+CONFIG_CFG80211_WEXT=y
+CONFIG_MAC80211=m
+CONFIG_BRCMFMAC=m
+CONFIG_BRCMFMAC_SDIO=y
 CONFIG_KEYBOARD_GPIO=m
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_VT_HW_CONSOLE_BINDING=y
@@ -211,3 +221,9 @@ CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon console=ttyS4,115200 clk_ignore_unused"
+# CONFIG_RTC_DRV_PCF8563 is not set
+CONFIG_BT=y
+CONFIG_BT_HCIUART=y
+CONFIG_BT_HCIUART_BCM=y
+CONFIG_SERIAL_DEV_BUS=y
+CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
-- 
2.38.1

