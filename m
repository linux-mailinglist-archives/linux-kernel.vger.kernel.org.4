Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FA56CD2CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjC2HRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjC2HRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:17:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C0D2698;
        Wed, 29 Mar 2023 00:17:29 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so59378873ede.8;
        Wed, 29 Mar 2023 00:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680074247;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6w306TzGpctk6hvXcFo39ZzdVVVQM4aAQXrijEamw0=;
        b=oxANxCOrfYNq0f+pxsecoWRxXAT22T4S5kZ+KhrxvKUxz66yIZiDSxPu/kpbAl/ip8
         nDCpQGvoahygcFKMiyTKIhtP8pZMzeYm9CGzY/oyb9FC82zYPf7Dx9kGh05DvxoBE/ef
         BvJPD2YIAIdAg0KMCbcjZ4wDlbFM7GLiAro6ZjXjJtrBBQVqKNUy0hd7BvNc76edxArq
         E1E56yfO4PfhWYwUuiS3l57xISMGLifELbb/RUlM+d3JQaDPIU4odvz5+ib4sauYYIjK
         oV2gZdH0OoOl5Aj/jNHI0rjjHN0HtgN6uOtA93G+rz5t53jrlOrENwjUeNBbDE2h8p8r
         FuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680074247;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6w306TzGpctk6hvXcFo39ZzdVVVQM4aAQXrijEamw0=;
        b=eF5Hs1lONezoTLLbTA3bm3GGb7Te3LGXtIz9SIYJZ5Gny1pwp9+l3elkL2pagEdKIB
         aLJgGohMn2B407rRDzl/Zc27dWRNX2WDr9hnIh3uDP9X8fxnf436TyjirhL/kI8PZw4k
         H6pofXmXYAPWVtAB9ZEYLmexFgETcanZT9sqbGTm1N/5NiejO8GvAz45O8x8+KL+21yQ
         5rqC5RtppGYSqCWJ/kCD761P8/EFnvo+ws6sJlH5cTV6Vw6YxnFn8jS85xkAphAvwNaN
         wLOX4LUl57MAlmZi2h2xdn1TBl0bpKQxZMJkCpAe6oE2cAQqoaMUxIkNQITVYclSGASZ
         AvXg==
X-Gm-Message-State: AAQBX9di8xCS1BtcuN6LTKg+f8IqGZ/ihmETesKZ4TRpyh0D7sn5fvz/
        EW7atl3ifacU8d3BAb1zTG8=
X-Google-Smtp-Source: AKy350YiIPa0oLJjIORcV/riwkXuF9fsTDSbMAHX+11Cpugi5xNTQAICKyBUuIcT92rGfYpJ5NlwrA==
X-Received: by 2002:a17:907:7b9e:b0:8b1:fc:b06d with SMTP id ne30-20020a1709077b9e00b008b100fcb06dmr21532742ejc.77.1680074247296;
        Wed, 29 Mar 2023 00:17:27 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:d1ab:705f:18f7:3e0a])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906c30f00b00922a79e79c2sm16093178ejz.217.2023.03.29.00.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:17:26 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RFC PATCH] usb: move config USB_USS720 to usb's misc Kconfig
Date:   Wed, 29 Mar 2023 09:17:24 +0200
Message-Id: <20230329071724.11082-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USS720 parport driver source code is in drivers/usb/misc/, the
corresponding config is defined in drivers/usb/Kconfig. Some digging in the
kernel's history revealed no good reason why it needs to be defined in
USB's top-level Kconfig file, and why the config for the USS720 parport
driver should be the first in the list of USB port drivers, while all other
configs for drivers in drivers/usb/misc are in the USB Miscellaneous driver
configuration file.

Most probably, it was simply considered a bit more special when the USB
Miscellaneous driver configuration file (drivers/usb/misc/Config.in back
then) was initially created, and this config simply survived to remain at
the top-level USB Kconfig file with all further code/Kconfig
transformations and additions later on. Users rarely notice this config
being at this position, as CONFIG_PARPORT (Parallel port support) needs to
be enabled and only few users enable that. Nowadays, this USB_USS720 driver
is probably not that special that it needs to be listed as first item of
the USB port drivers.

Move the configuration of the USS720 parport driver to the top of the USB
Miscellaneous drivers section, as the configurations does not have a lot of
specific ordering USB Miscellaneous drivers. This way, the USS720 parport
driver is moved to the comment "USB Miscellaneous drivers", fitting to the
driver's source code location, but still is at the top of the list for
those few acquainted users of Kconfig UIs that might be looking for the
config that was once at the top of the list of the USB port drivers.

Put this config definition to a more local place. No semantic change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---

Details to the historic digging:

https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit?id=fa67c3c55d814169652a26b625096a48c2d3701c
moved all other configs of misc drivers into misc/Config.in.

https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/drivers/usb/Config.in?id=7a2deb32924142696b8174cdf9b38cd72a11fc96
shows the USS720 parport driver to exist already at the beginning of the
kernel history.git.

All of this is more than two decades ago, and the rationales from those
historic times are probably outdated at this point in time anyway.


 drivers/usb/Kconfig      | 29 -----------------------------
 drivers/usb/misc/Kconfig | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index a871a988829d..7f33bcc315f2 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -133,35 +133,6 @@ comment "USB port drivers"
 
 if USB
 
-config USB_USS720
-	tristate "USS720 parport driver"
-	depends on PARPORT
-	select PARPORT_NOT_PC
-	help
-	  This driver is for USB parallel port adapters that use the Lucent
-	  Technologies USS-720 chip. These cables are plugged into your USB
-	  port and provide USB compatibility to peripherals designed with
-	  parallel port interfaces.
-
-	  The chip has two modes: automatic mode and manual mode. In automatic
-	  mode, it looks to the computer like a standard USB printer. Only
-	  printers may be connected to the USS-720 in this mode. The generic
-	  USB printer driver ("USB Printer support", above) may be used in
-	  that mode, and you can say N here if you want to use the chip only
-	  in this mode.
-
-	  Manual mode is not limited to printers, any parallel port
-	  device should work. This driver utilizes manual mode.
-	  Note however that some operations are three orders of magnitude
-	  slower than on a PCI/ISA Parallel Port, so timing critical
-	  applications might not work.
-
-	  Say Y here if you own an USS-720 USB->Parport cable and intend to
-	  connect anything other than a printer to it.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called uss720.
-
 source "drivers/usb/serial/Kconfig"
 
 source "drivers/usb/misc/Kconfig"
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index a5f7652db7da..801c87e0dd29 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -4,6 +4,35 @@
 #
 comment "USB Miscellaneous drivers"
 
+config USB_USS720
+	tristate "USS720 parport driver"
+	depends on PARPORT
+	select PARPORT_NOT_PC
+	help
+	  This driver is for USB parallel port adapters that use the Lucent
+	  Technologies USS-720 chip. These cables are plugged into your USB
+	  port and provide USB compatibility to peripherals designed with
+	  parallel port interfaces.
+
+	  The chip has two modes: automatic mode and manual mode. In automatic
+	  mode, it looks to the computer like a standard USB printer. Only
+	  printers may be connected to the USS-720 in this mode. The generic
+	  USB printer driver ("USB Printer support", above) may be used in
+	  that mode, and you can say N here if you want to use the chip only
+	  in this mode.
+
+	  Manual mode is not limited to printers, any parallel port
+	  device should work. This driver utilizes manual mode.
+	  Note however that some operations are three orders of magnitude
+	  slower than on a PCI/ISA Parallel Port, so timing critical
+	  applications might not work.
+
+	  Say Y here if you own an USS-720 USB->Parport cable and intend to
+	  connect anything other than a printer to it.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called uss720.
+
 config USB_EMI62
 	tristate "EMI 6|2m USB Audio interface support"
 	help
-- 
2.17.1

