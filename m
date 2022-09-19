Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154AA5BD37C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiISRQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiISRQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:16:56 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32DA14083;
        Mon, 19 Sep 2022 10:16:54 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id a3so36032577lfk.9;
        Mon, 19 Sep 2022 10:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qfmpocwGFcvxn/kfW/YixA1qZZ0ZnBfI95e5FNSla5w=;
        b=6W9oSie1rr+YzUanoiae8R2/4bL3nOA1ujQouSTEiwv8fKy08xr5c7s2hg6fYYZGUl
         eVkawaeU9m3PM6Y3/OqwyvFcaaF4H40WwErFDKPlglvOCM1w0hO6yhjz+1x5v+dBu4Qu
         AmWxq1uRIc3l+wGZC26WGV4YOBkdbY4DAUdEyi/KaDOnYjj6mmYnw7l7j4JqhevTLPfk
         rP5qjuMs1iOAgq4NHOp19Ee3JgB3rVbW/4lrrZdVkTkp0EqXULVpXz2SnEp6YR+ZrdqM
         Q4K5a57GXq4evdAJPVwS+qlzU0f3A5LwsXWklvzgrxojUlj/Fop/azgFs3jwMI5KC1TE
         E0Bg==
X-Gm-Message-State: ACrzQf1yrgLBqyh+FQI8/ubahhsNzOeo9xb0d/BbAxbrFraVe4UasIkN
        rJu2HUedjDLG0Fd2aLximLoCtrYkH48=
X-Google-Smtp-Source: AMsMyM6e2vNq8a+W4zhW2FfI4fcJloJ1eCZNRlpVLQyDkjM94DR2+AAnmViqaXJa2P7NujmNrK4wXA==
X-Received: by 2002:ac2:4c46:0:b0:49d:c0ff:b172 with SMTP id o6-20020ac24c46000000b0049dc0ffb172mr6350196lfk.19.1663607813182;
        Mon, 19 Sep 2022 10:16:53 -0700 (PDT)
Received: from localhost (88-112-11-246.elisa-laajakaista.fi. [88.112.11.246])
        by smtp.gmail.com with ESMTPSA id e19-20020a05651236d300b004994117b0fdsm5262323lfs.281.2022.09.19.10.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:16:52 -0700 (PDT)
From:   Hannu Hartikainen <hannu@hrtk.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hannu Hartikainen <hannu@hrtk.in>
Subject: [PATCH] USB: add RESET_RESUME quirk for NVIDIA Jetson devices in RCM
Date:   Mon, 19 Sep 2022 20:16:10 +0300
Message-Id: <20220919171610.30484-1-hannu@hrtk.in>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA Jetson devices in Force Recovery mode (RCM) do not support
suspending, ie. flashing fails if the device has been suspended. The
devices are still visible in lsusb and seem to work otherwise, making
the issue hard to debug. This has been discovered in various forum
posts, eg. [1].

The patch has been tested on NVIDIA Jetson AGX Xavier, but I'm adding
all the Jetson models listed in [2] on the assumption that they all
behave similarly.

[1]: https://forums.developer.nvidia.com/t/flashing-not-working/72365
[2]: https://docs.nvidia.com/jetson/archives/l4t-archived/l4t-3271/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/quick_start.html

Signed-off-by: Hannu Hartikainen <hannu@hrtk.in>
---
 drivers/usb/core/quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f99a65a64588..11b27953ccd0 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -388,6 +388,15 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Kingston DataTraveler 3.0 */
 	{ USB_DEVICE(0x0951, 0x1666), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* NVIDIA Jetson devices in Force Recovery mode */
+	{ USB_DEVICE(0x0955, 0x7018), .driver_info = USB_QUIRK_RESET_RESUME },
+	{ USB_DEVICE(0x0955, 0x7019), .driver_info = USB_QUIRK_RESET_RESUME },
+	{ USB_DEVICE(0x0955, 0x7418), .driver_info = USB_QUIRK_RESET_RESUME },
+	{ USB_DEVICE(0x0955, 0x7721), .driver_info = USB_QUIRK_RESET_RESUME },
+	{ USB_DEVICE(0x0955, 0x7c18), .driver_info = USB_QUIRK_RESET_RESUME },
+	{ USB_DEVICE(0x0955, 0x7e19), .driver_info = USB_QUIRK_RESET_RESUME },
+	{ USB_DEVICE(0x0955, 0x7f21), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	/* X-Rite/Gretag-Macbeth Eye-One Pro display colorimeter */
 	{ USB_DEVICE(0x0971, 0x2000), .driver_info = USB_QUIRK_NO_SET_INTF },
 
-- 
2.37.3

