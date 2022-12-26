Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D504656531
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 22:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiLZVq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 16:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLZVq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 16:46:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4010D3;
        Mon, 26 Dec 2022 13:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rKsradsR1qNIDtKy7iZzhnI6sTf0ohOoWP+lvLxzTq4=; b=vZQ+UoShfOG3nPX/VfYIFRRGqS
        I9jlRS5DOX6pcGT1fgJnZ37IkuhjsH+a1cA3uCVAQw4IHt+cW0rpk6W/iVapO8LmXXUV9DB6XdJQu
        Ah6FppWhkefWF/IQAsIqQnk4ljiKppQiWjEkx+VbL8Jk/TOjgm7O9LA4zGXzwY1U3Wy6pKCrIrHMd
        p/D/Ov5JX7ZM+78S6uaPF7Z1CxNG/UHV5UTnMwxBKsmct1pd9DwTuS8G5+GPfanmN3E2uEQ97Gun9
        IzOUKP7C2ZO01N0wKzzTIlEmfid3Tjx1Epj/Zta4A0UAB6g+g0q7VtTN8GDiRWVMVscHi+wpNU8I1
        9g8uOq/g==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p9vJD-007YPp-PO; Mon, 26 Dec 2022 21:47:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        linux-input@vger.kernel.org
Subject: [PATCH -next] HID: amd-sfh-hid: also depends on INPUT
Date:   Mon, 26 Dec 2022 13:46:44 -0800
Message-Id: <20221226214644.17339-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD_SFH_HUB selects HID, which depends on INPUT, but since 'select'
does not follow any dependency chains, AMD_SFH_HUB should also
depend on INPUT.

Fixes multiple kconfig warnings and 90+ build errors (samples):

WARNING: unmet direct dependencies detected for HID
  Depends on [m]: HID_SUPPORT [=y] && INPUT [=m]
  Selected by [y]:
  - AMD_SFH_HID [=y] && HID_SUPPORT [=y] && (X86_64 || COMPILE_TEST [=y]) && PCI [=y]
  Selected by [m]:
  - I2C_HID_CORE [=m] && HID_SUPPORT [=y]
  - USB_HID [=m] && HID_SUPPORT [=y] && USB [=y] && INPUT [=m]

WARNING: unmet direct dependencies detected for INPUT_VIVALDIFMAP
  Depends on [m]: INPUT [=m]
  Selected by [y]:
  - HID_VIVALDI [=y] && HID_SUPPORT [=y] && HID [=y]

WARNING: unmet direct dependencies detected for INPUT_FF_MEMLESS
  Depends on [m]: INPUT [=m]
  Selected by [y]:

ERROR: modpost: "input_ff_create_memless" [drivers/hid/hid-logitech.ko] undefined!
ERROR: modpost: "input_ff_create_memless" [drivers/hid/hid-mf.ko] undefined!
ERROR: modpost: "input_ff_create_memless" [drivers/input/misc/gpio-vibra.ko] undefined!
ERROR: modpost: "input_ff_create_memless" [drivers/input/misc/regulator-haptic.ko] undefined!
riscv64-linux/bin/riscv64-linux-ld: hid-input.c:(.text+0x77e): undefined reference to `input_event'
riscv64-linux/bin/riscv64-linux-ld: hid-input.c:(.text+0xac2): undefined reference to `input_allocate_device'
riscv64-linux/bin/riscv64-linux-ld: hid-input.c:(.text+0xba8): undefined reference to `input_free_device'
riscv64-linux/bin/riscv64-linux-ld: hid-input.c:(.text+0xf4c): undefined reference to `input_scancode_to_scalar'

Fixes: 25621bcc8976 ("HID: Kconfig: split HID support and hid-core compilation")
Fixes: 7e41b2e9776d ("HID: force HID depending on INPUT")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Basavaraj Natikar <basavaraj.natikar@amd.com>
Cc: linux-input@vger.kernel.org
---
 drivers/hid/amd-sfh-hid/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/drivers/hid/amd-sfh-hid/Kconfig b/drivers/hid/amd-sfh-hid/Kconfig
--- a/drivers/hid/amd-sfh-hid/Kconfig
+++ b/drivers/hid/amd-sfh-hid/Kconfig
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 menu "AMD SFH HID Support"
 	depends on X86_64 || COMPILE_TEST
-	depends on PCI
+	depends on PCI && INPUT
 
 config AMD_SFH_HID
 	tristate "AMD Sensor Fusion Hub"
+	depends on INPUT
 	select HID
 	help
 	  If you say yes to this option, support will be included for the
