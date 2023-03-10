Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592076B409D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCJNjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjCJNjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:39:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA1646092
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678455505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j2OR9fIPJYHr1cJflr+8XvQFdV93TGp9o5m8EX8cFoI=;
        b=ZsT6edn/8cf+eX0MBtQ9ldBv+oR3wTKV+Lz55uEmbkKtsCGyHDzNbaBr1LTUPSshvdaAqa
        3mNZPo4vk/ZD+KV2aTYl2QlFsBgBXb+2uuCi8WHHHUZwI3POUZojhStpCniA7NrAVSQeEy
        MdF8QtvLX2XX+hsgfRKJQlHB8CHkl1I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-O4uCNK7HNYGvW62_WP5abw-1; Fri, 10 Mar 2023 08:38:22 -0500
X-MC-Unique: O4uCNK7HNYGvW62_WP5abw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DD24185A78B;
        Fri, 10 Mar 2023 13:38:20 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.194.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21B1E492C3E;
        Fri, 10 Mar 2023 13:38:19 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 10 Mar 2023 14:38:10 +0100
Subject: [PATCH v2] gpiolib: acpi: use the fwnode in acpi_gpiochip_find()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230309-fix-acpi-gpio-v2-1-9eb20a1fd42c@redhat.com>
X-B4-Tracking: v=1; b=H4sIAMEyC2QC/3WNMQ6DMAxFr4Iy1xU4VC2deo+KwQmGeIAgB6FWi
 Ls3sHd8/+vpbSaxCifzLDajvEqSOGXAS2F8oGlgkC6zwRJtacsGevkA+VlgmCUCOaTe2rrmuzP
 ZcZQYnNLkw2GNlBbW45iVs3mG3m3mIGmJ+j27a3Ws/xJrBRU422CHeOOeHy/lLtBy9XE07b7vP
 2hmkJzEAAAA
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Daniel Kaehn <kaehndan@gmail.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678455498; l=2737;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=flBfYltySue3KVmhGsoXQ/zcqrinrRTi7aXDpYk9Y7E=;
 b=F+hEj5C3qLWtzIjuLE97GOReGRIFFpR+wpJj1q0vcQyJybqnS1E8wYsk7ubcnt5EK565IQCBe
 o4StTHgOZhyCvj6X1OK3S3CqRl1p0P1AT0Tn2+n3I7mygPOVPXWbWj4
X-Developer-Key: i=benjamin.tissoires@redhat.com; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

This works fine on my Ice Lake laptop because AFAICT, the DSDT presents
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

So in my Ice Lake case, gc->fwnode is the one from the parent, meaning
that the ACPI handle we will get is the one from the GPI0 in the DSDT
(the pincrtl one). And in the hid-cp2112 case, we get the actual
fwnode from the gpiochip we created in the HID device, making it working.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
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
Changes in v2:
- Fix commit description
- Link to v1: https://lore.kernel.org/r/20230309-fix-acpi-gpio-v1-1-b392d225efe8@redhat.com
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

