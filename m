Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC43F6C48DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCVLQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCVLQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:16:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D934DE3A;
        Wed, 22 Mar 2023 04:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA53FB81C25;
        Wed, 22 Mar 2023 11:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F67C433EF;
        Wed, 22 Mar 2023 11:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679483802;
        bh=yqsVMZSFa5CHTkdXUK3mvMZizZ/0pAtToVHTZzG7V08=;
        h=From:To:Cc:Subject:Date:From;
        b=uXPsblQ4hdJoTyh88MHVK7pYObNP7FBOJMP85AqLZOstUZf0ZWR0iEcDMmh+ZI6s7
         63UZTr5VUAqE8w7PYUVM0h9YSCuFqg3V39BUvUfvHt2bFi3b1ZcjgAckvHaRgYWFVp
         RQlI86egWs9j3QNWSRr2TQB0MTkLFThXz2TsdAOfHiRksgRIh2gEzdq2saMQ6zSieo
         klpbpF3WrlotXM6fACaL6MF+sAh96zMo/+I4EOlOg2FZQE6WjrECjNxzhjFChpT5bF
         LX6l/XmQqk+q+mFzb/nutpb7RJIErp2HGcGLrOh0ynw3P4K1IgcES8fsOjS5rh2F4j
         z8mtJpdzXUxKA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: NXP: select CONFIG_CRC8
Date:   Wed, 22 Mar 2023 12:16:27 +0100
Message-Id: <20230322111636.1028838-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The driver needs both CRC32 and CRC8 to link correctly:

ld.lld: error: undefined symbol: crc8_populate_msb
>>> referenced by btnxpuart.c
>>>               drivers/bluetooth/btnxpuart.o:(nxp_serdev_probe) in archive vmlinux.a
ld.lld: error: undefined symbol: crc8
>>> referenced by btnxpuart.c
>>>               drivers/bluetooth/btnxpuart.o:(nxp_send_ack) in archive vmlinux.a

Fixes: 3e662aa4453a ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 0703bdd44140..f84322d375de 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -469,6 +469,7 @@ config BT_NXPUART
 	tristate "NXP protocol support"
 	depends on SERIAL_DEV_BUS
 	select CRC32
+	select CRC8
 	help
 	  NXP is serial driver required for NXP Bluetooth
 	  devices with UART interface.
-- 
2.39.2

