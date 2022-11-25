Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233A1638E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKYQEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiKYQEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:04:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D9F4C258;
        Fri, 25 Nov 2022 08:04:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6457521AE8;
        Fri, 25 Nov 2022 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669392285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E1AvnYKtYn+8yPFjM7D+vldgE+4/Vf2jmsQdzXTBl9E=;
        b=YH4sWQhvo3bUc46XnpcapEyvmEHVazGhnrtaoNqthyKYb6WcxFZ/r2vbqutAQ9p0t7MzMR
        Qa23IcwODRjyX8JSftO9cTRtUKBDahWfAAyoBM01qBxdPiE/vR0EaUvJvrwGy5lxJmf3e0
        84luV89ft2qZizlR/8Q7FezuRJdHPjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669392285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E1AvnYKtYn+8yPFjM7D+vldgE+4/Vf2jmsQdzXTBl9E=;
        b=4Bs+nm4bCab40+zSX3tganHTBUkvJ/m2m6bBnsOMy8YqdKRud8HwAfk7kG69T66GDHv94l
        DDu6ou8hgfwmF4BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CBD61361C;
        Fri, 25 Nov 2022 16:04:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1TxMBZ3ngGOHHAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Fri, 25 Nov 2022 16:04:45 +0000
Date:   Fri, 25 Nov 2022 17:04:44 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-usb@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] usb: gadget: udc: drop obsolete dependencies on
 COMPILE_TEST
Message-ID: <20221125170444.36620123@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/usb/gadget/udc/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-6.0.orig/drivers/usb/gadget/udc/Kconfig
+++ linux-6.0/drivers/usb/gadget/udc/Kconfig
@@ -33,7 +33,7 @@ menu "USB Peripheral Controller"
 config USB_AT91
 	tristate "Atmel AT91 USB Device Port"
 	depends on ARCH_AT91
-	depends on OF || COMPILE_TEST
+	depends on OF
 	help
 	   Many Atmel AT91 processors (such as the AT91RM2000) have a
 	   full speed USB Device Port with support for five configurable
@@ -430,7 +430,7 @@ config USB_EG20T
 config USB_GADGET_XILINX
 	tristate "Xilinx USB Driver"
 	depends on HAS_DMA
-	depends on OF || COMPILE_TEST
+	depends on OF
 	help
 	  USB peripheral controller driver for Xilinx USB2 device.
 	  Xilinx USB2 device is a soft IP which supports both full


-- 
Jean Delvare
SUSE L3 Support
