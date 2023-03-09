Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AD86B25AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCINmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjCINmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:42:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69461ED6B4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678369269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OJclciNwKVwJw6IIzt5prbM3eWs+xgxvHsGVYny+uR0=;
        b=axLY14E352wwMGB7hnwFj+YWeu5Oq6ZoBkwkHjYtyaciJgn2UPlCOnkabQpOSTYS0UZYiD
        Gpj71aasmTwR7T28RS+Xg4PM1O6826I8hzARO7VH1rPd8wW6h4SHglTrYxmuBJ8rrLnIUN
        dX0e8mTjhsNfuUn03bSj+wvuFG567jk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-8quo7QNoMjGx7a4H28IlRQ-1; Thu, 09 Mar 2023 08:41:06 -0500
X-MC-Unique: 8quo7QNoMjGx7a4H28IlRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2841857A84;
        Thu,  9 Mar 2023 13:41:05 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.194.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DB77C15BA0;
        Thu,  9 Mar 2023 13:41:04 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 09 Mar 2023 14:40:51 +0100
Subject: [PATCH] gpiolib: acpi: use the fwnode in acpi_gpiochip_find()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230309-fix-acpi-gpio-v1-1-b392d225efe8@redhat.com>
X-B4-Tracking: v=1; b=H4sIAOPhCWQC/x3NQQqDMBCF4avIrB1IE6HUqxQXk3TUWRjDjEghe
 PfGLn8eH6+CsQobjF0F5VNM9tzi0XeQVsoLo3xag3c+uOBeOMsXKRXBpciOFD3NIQwDPyM0E8k
 Yo1JO6602soP1Hopyk/+j93RdP0HQIKx4AAAA
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Daniel Kaehn <kaehndan@gmail.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678369264; l=2531;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=XR4WGpf39AuZ6vh9qE6GCktK9QBOCoYIsi5+VzFHgXA=;
 b=JRt/hGs0iewIH7p/jE1XmlWVicVopazOpWn0zmGWmHFgOlpdGeudrtsopI/xAXi0MBVDKA5vj
 MNYxPdZ5776C1wKGq3pddnc6qY1/S+PAa36wOKrywqL3BolLEAFwlvp
X-Developer-Key: i=benjamin.tissoires@redhat.com; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to set up an SSDT override for a USB-2-I2C chip [0],
I realized that the function acpi_gpiochip_find() was using the parent
of the gpio_chip to do the ACPI matching.

This works fine on my icelake laptop because AFAICT, the DSDT presents
the PCI device INT3455 as the "Device (GPI0)", but is in fact handled
by the pinctrl driver in Linux.
The pinctrl driver then creates a gpio_chip device. This means that the
gc->parent device in that case is the GPI0 device from ACPI and everything
works.

However, in the hid-cp2112 case, the parent is the USB device, and the
gpio_chip is directly under that USB device. Which means that in this case
gc->parent points at the USB device, and so we can not do an ACPI match
towards the GPIO device.

I think it is safe to resolve the ACPI matching through the fwnode
because when we call gpiochip_add_data(), the first thing it does is
setting a proper gc->fwnode: if it is not there, it borrows the fwnode
of the parent.

So in my icelake case, gc->fwnode is the one from the parent, meaning
that the ACPI handle we will get is the one from the GPI0 in the DSDT
(the pincrtl one). And in the hid-cp2112 case, we get the actual
fwnode from the gpiochip we created in the HID device, making it working.

Link: https://lore.kernel.org/linux-input/20230227140758.1575-1-kaehndan@gmail.com/T/#m592f18081ef3b95b618694a612ff864420c5aaf3 [0]
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
Hi,

As mentioned on the commit, I believe there is a bug on
the gpiolib-acpi matching. It relies on the parent of the gpiochip
when it should IMO trust the fwnode that was given to it.

Tested on both the hid-cp2112 I am refering in the commit
description and my XPS on Intel Icelake.

Cheers,
Benjamin
---
 drivers/gpio/gpiolib-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index d8a421ce26a8..5aebc266426b 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -126,7 +126,7 @@ static bool acpi_gpio_deferred_req_irqs_done;
 
 static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
 {
-	return gc->parent && device_match_acpi_handle(gc->parent, data);
+	return ACPI_HANDLE_FWNODE(gc->fwnode) == data;
 }
 
 /**

---
base-commit: 6c71297eaf713ece684a367ce9aff06069d715b9
change-id: 20230309-fix-acpi-gpio-ab2af3344e7b

Best regards,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

