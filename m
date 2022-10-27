Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2A160F328
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiJ0JDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbiJ0JDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:03:49 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC11889AF8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:03:48 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id gn34-20020a1709070d2200b0079330e196c8so618406ejc.16
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iTr70DtRX5dCDfAbqlnnnZ499B2Ss7MujMAGG+uKbJ8=;
        b=fh8RaZQmCnFN93SvEg9vAlawCR0caXXFB3UqU+vvhSxkUGYv4qsFIY5TKS3lmsYUpg
         k5qzbsesTTx9X5M/Cx9Ev9Yf64YnOTFe3DUa5aGOCV8qfXyIBhmTZym8dorWimQlNfH1
         4sDPm/MZZUPG4sKVyVt0AYZH7+fz5xNghtBAwYgRwSy3rBi7N6G/wbovVYrdNSMSMj10
         VhjlPK1vEah1WeVoe9ZxdYDRoG57LB6zhnc95wC1WRLVk0gsh+DM5p2RZMWXHzRBTypf
         Uy4IxlCQYoDTJAAnJD1mNpU1r4hJdBH/ayksv6jXselX3mTGL2MCWXif1O+Uci3Hvfxg
         JqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTr70DtRX5dCDfAbqlnnnZ499B2Ss7MujMAGG+uKbJ8=;
        b=tl9ob4FJs4BVkAzZH0dLqxLXT3zSWDiw2xDGMLSgNcJ8an0J+fJf0lQ7e++OPCPLqS
         ct+ri1nXT+ODsj2zhijU1LcdBkgJDMl4H9xDyqTR3PRUvM9O+5n13AsQQ1tgpDQ8RoS8
         UKQWM43p4ko35yFzqcTWk+g2i8F8F5l7h7C5GEtZJqyThRkcpntL5WiQzAsA9ridPWfO
         Ghwlfw7SS9Pu6kCoIBNv7I6+5hTbAYY/+HlBw5tVWqOEgG4LwHUVxMfEjvxBvAfhF4pO
         5FvJ+KzTaQnBRLUhJRtAt3ZcGAPyBzkZ7QEdh0oD4l0540Hl+yjkFDZla6yY+KjovXDA
         wnTw==
X-Gm-Message-State: ACrzQf02ikjVMcXkIrIklgBlrdxUDKteLGrIiXDmws2KLVq0jMpxMeoz
        bKukoJgKyRF0zjN+vRENF7WJhm9IbScavw==
X-Google-Smtp-Source: AMsMyM6/TQlrI8rBZTi+nkUz/grj7uWJdKC6mjGtvE1qiKHrwLI0etzOQ3hFekBjfLMd5qG3AU2vF2uXCRSF5Q==
X-Received: from bistanclaque.zrh.corp.google.com ([2a00:79e0:42:204:34aa:3c10:4b35:5e84])
 (user=ndumazet job=sendgmr) by 2002:aa7:c302:0:b0:461:85d7:b82 with SMTP id
 l2-20020aa7c302000000b0046185d70b82mr24493592edq.354.1666861427143; Thu, 27
 Oct 2022 02:03:47 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:03:42 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221027090342.38928-1-ndumazet@google.com>
Subject: [PATCH v2] usb: add NO_LPM quirk for Realforce 87U Keyboard
From:   Nicolas Dumazet <ndumazet@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Francois Le Fillatre <jflf_kernel@gmx.com>
Cc:     Petar Kostic <petar@kostic.dev>, Oliver Neukum <oneukum@suse.com>,
        Ole Ernst <olebowle@gmx.com>,
        Hannu Hartikainen <hannu@hrtk.in>,
        Jimmy Wang <wangjm221@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Dumazet <ndumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before adding this quirk, this (mechanical keyboard) device would not be
recognized, logging:

  new full-speed USB device number 56 using xhci_hcd
  unable to read config index 0 descriptor/start: -32
  chopping to 0 config(s)

It would take dozens of plugging/unpuggling cycles for the keyboard to
be recognized. Keyboard seems to simply work after applying this quirk.

This issue had been reported by users in two places already ([1], [2])
but nobody tried upstreaming a patch yet. After testing I believe their
suggested fix (DELAY_INIT + NO_LPM + DEVICE_QUALIFIER) was probably a
little overkill. I assume this particular combination was tested because
it had been previously suggested in [3], but only NO_LPM seems
sufficient for this device.

[1]: https://qiita.com/float168/items/fed43d540c8e2201b543
[2]: https://blog.kostic.dev/posts/making-the-realforce-87ub-work-with-usb30-on-Ubuntu/
[3]: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1678477

---
Changes in v2:
  - add the entry to the right location (sorting entries by
    vendor/device id).

Cc: stable@vger.kernel.org
Signed-off-by: Nicolas Dumazet <ndumazet@google.com>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 0722d2131305..079e183cf3bf 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -362,6 +362,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0781, 0x5583), .driver_info = USB_QUIRK_NO_LPM },
 	{ USB_DEVICE(0x0781, 0x5591), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* Realforce 87U Keyboard */
+	{ USB_DEVICE(0x0853, 0x011b), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* M-Systems Flash Disk Pioneers */
 	{ USB_DEVICE(0x08ec, 0x1000), .driver_info = USB_QUIRK_RESET_RESUME },
 
-- 
2.38.0.135.g90850a2211-goog

