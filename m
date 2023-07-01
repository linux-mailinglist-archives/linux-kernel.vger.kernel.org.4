Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0A2744792
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 09:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjGAHMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 03:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGAHLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:11:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D7449F;
        Sat,  1 Jul 2023 00:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688195286; x=1719731286;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0foLCd5FDntKJ3VTEUvPb19jE3I03iB99n4sbpf5QFk=;
  b=m7eFuFpBFfQPWhCL7BbgO38gebNzwVycPYhCSQtgSRRPqIT0REeHd7Yf
   g0wObe4RS2sQxkCOA/ywTX4cFNxJAPVHEVxrCh1cqPw3hm+SgnA8zi+98
   SfJXH+fpI8BLN5a8x9HyA9VFzpr3nut3TX06IwOvS8V2T21MsaRripQP5
   ca34OUVtIYOI1rxY4j6LtDWoC5Rn02LrD7uM7uIk7FGBvwsQQwDu7M+2x
   HqoE8VrWuzsvR5dukQDQ+oEfhB7S4P1Nu3Rc/Pvn1Pkw5Ao8zxXpKPA5N
   Qa3IDmUoSDygHTBYzK4rh1OBcGWjtJ5p8KUxgd2PBZ/1mTdaIstAT4q2L
   w==;
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="159408554"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2023 00:08:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 1 Jul 2023 00:08:02 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Sat, 1 Jul 2023 00:07:59 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kumaravel.thiagarajan@microchip.com>,
        <tharunkumar.pasumarthi@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <michael@walle.cc>
Subject: [PATCH RESEND v13 char-misc-next 0/2] Add OTP/EEPROM functionality to the PCI1XXXX switch
Date:   Sat, 1 Jul 2023 12:38:17 +0530
Message-ID: <20230701070819.3992094-1-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>

Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
industrial, and automotive applications. This switch integrates OTP and
EEPROM to enable customization of the part in the field. This patch adds
OTP/EEPROM functionality to the pci1xxxx switch.
---
v12 -> v13:
- Moved release_sys_lock() from patch#2 to patch#1

v11 -> v12:
- EEPROM is registered for NVMEM only if EEPROM is responsive

v10 -> v11:
- Fixed error handling during timouts by releasing sys_locks

v9 -> v10:
- Removed unused include header files
- Removed null check for priv pointer
- Removed debug messages
- Returned error during timeouts
- Added corner case checks for offset and count values

v8 -> v9:
- Changed architecture from sysfs bin interface to NVMEM interface

v7 -> v8:
- Fixed error handling in probe function of mchp_pci1xxxx_gp driver
- Added bin attribute groups to eliminate userspace from racing
- Implemented short read and write for OTP/EEPROM

v6 -> v7:
- Handled corner cases such as failure of sysfs bin creation and removal
- Added function to check whether device is responsive
- Removed un-necessary parenthesis
- Added function for repetitive tasks

v5 -> v6:
- Changed architecture from Block interface to sysfs interface
- Replaced busy loops with read_poll_timeout()

v4 -> v5:
- Used proper errno
- Removed un-necessary prints

v3 -> v4:
- Remove extra space, tab, un-necessary casting, paranthesis,
  do while(false) loops
- Used read_poll_timeout for polling BUSY_BIT

v2 -> v3:
- Modified commit description to include build issues reported by Kernel
  test robot <lkp@intel.com> which are fixed in this patch

v1 -> v2:
- Resolve build issue reported by kernel test robot <lkp@intel.com>

Kumaravel Thiagarajan (2):
  misc: microchip: pci1xxxx: Add support to read and write into PCI1XXXX
    OTP via NVMEM sysfs
  misc: microchip: pci1xxxx: Add support to read and write into PCI1XXXX
    EEPROM via NVMEM sysfs

 MAINTAINERS                                   |   2 +
 drivers/misc/mchp_pci1xxxx/Kconfig            |   1 +
 drivers/misc/mchp_pci1xxxx/Makefile           |   2 +-
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c | 443 ++++++++++++++++++
 4 files changed, 447 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c

-- 
2.34.1

