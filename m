Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD2F634403
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiKVSxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKVSxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:53:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CD98C088
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669143129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aep8RFMu1+GiUZaTPB9joRtRtN+HkoJa3LBopYYK188=;
        b=VUwGJdexXBQH0NdexVRtOoXO9aRjo7QqwpysrOHu/h2NqX9u92cEJ13qm3CHk0/Q2BHpiF
        Ql6C2l8dQbqI3CneZMAEgfSfj+CZMZFwzfNBWlKzHfX88Px8Dl03rDUGgv3el8eYg0rzUQ
        LA8ZVSGbF5xeGTH8n3GPkwdW368AaFQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-35--K2UBD72OwWH5vlJbE9XAQ-1; Tue, 22 Nov 2022 13:52:08 -0500
X-MC-Unique: -K2UBD72OwWH5vlJbE9XAQ-1
Received: by mail-pl1-f200.google.com with SMTP id o7-20020a170902d4c700b001868cdac9adso12256682plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aep8RFMu1+GiUZaTPB9joRtRtN+HkoJa3LBopYYK188=;
        b=7QLOxFVkPA52ek3+efdTUm9U2yylTcoSzuXuVVjf49RQpZeOIH4MQMWBmgxJbHcIWJ
         EBj+3je7rmmIj+0lEV9s1HtS8fSF4cBSTwHz2pza81HkaucGR0YIOm2pfVa49GJbOZVl
         +Fm94hRZGfGv3DGaNwcb8/fiBck6mZaJteoJmlyjE+kdUW17Vmv6Q2IIzxYVTjCP8L/n
         KoMjs7OMMPYoj1olgJBHGrjwREmaA2y1pBTDi2k/7lLYV43V4hcxMfb+800qScoyZto+
         sTIpg9tC5haHuLlm1xNV2HnRMOGCoe8kLD8v5X7cC9L6u+x9qm120iL09cLjCc2lY+ic
         annQ==
X-Gm-Message-State: ANoB5pnpx+HTMmPYkHw3V9s4OfuHff0g9BdjQHIYHc6WBaQKvSokMubS
        AaXTGvLvv6jREYgJiALVluva6orFReSp3Wt9PG4S8Xkus/Qr4HP5ehG9JJLy4yDff3K6LZoZMlC
        rLdWk3aB7MP9EdEmAKyJZ/KSK
X-Received: by 2002:a63:f354:0:b0:476:db6f:e79d with SMTP id t20-20020a63f354000000b00476db6fe79dmr4471104pgj.399.1669143126988;
        Tue, 22 Nov 2022 10:52:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Z+51TBzvK+WApZPtmfv/cY2Dyq8KHaQoYEX+J7yPOkn9D/KL6gvCIltzBARHLl6qQLK4iww==
X-Received: by 2002:a63:f354:0:b0:476:db6f:e79d with SMTP id t20-20020a63f354000000b00476db6fe79dmr4471079pgj.399.1669143126697;
        Tue, 22 Nov 2022 10:52:06 -0800 (PST)
Received: from ryzen.. ([240d:1a:c0d:9f00:fc9c:8ee9:e32c:2d9])
        by smtp.gmail.com with ESMTPSA id y63-20020a623242000000b0056be1d7d4a3sm10950745pfy.73.2022.11.22.10.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 10:52:06 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+9ca7a12fd736d93e0232@syzkaller.appspotmail.com
Subject: [PATCH] media: si470x: Fix use-after-free in si470x_int_in_callback()
Date:   Wed, 23 Nov 2022 03:51:59 +0900
Message-Id: <20221122185159.1184593-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported use-after-free in si470x_int_in_callback() [1].  This
indicates that urb->context, which contains struct si470x_device
object, is freed when si470x_int_in_callback() is called.

The cause of this issue is that si470x_int_in_callback() is called for
freed urb.

si470x_usb_driver_probe() calls si470x_start_usb(), which then calls
usb_submit_urb() and si470x_start().  If si470x_start_usb() fails,
si470x_usb_driver_probe() doesn't kill urb, but it just frees struct
si470x_device object, as depicted below:

si470x_usb_driver_probe()
  ...
  si470x_start_usb()
    ...
    usb_submit_urb()
    retval = si470x_start()
    return retval
  if (retval < 0)
    free struct si470x_device object, but don't kill urb

This patch fixes this issue by killing urb when si470x_start_usb()
fails and urb is submitted.  If si470x_start_usb() fails and urb is
not submitted, i.e. submitting usb fails, it just frees struct
si470x_device object.

Reported-by: syzbot+9ca7a12fd736d93e0232@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=94ed6dddd5a55e90fd4bab942aa4bb297741d977 [1]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/media/radio/si470x/radio-si470x-usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/radio/si470x/radio-si470x-usb.c b/drivers/media/radio/si470x/radio-si470x-usb.c
index 6b2768623c88..aa7a580dbecc 100644
--- a/drivers/media/radio/si470x/radio-si470x-usb.c
+++ b/drivers/media/radio/si470x/radio-si470x-usb.c
@@ -727,8 +727,10 @@ static int si470x_usb_driver_probe(struct usb_interface *intf,
 
 	/* start radio */
 	retval = si470x_start_usb(radio);
-	if (retval < 0)
+	if (retval < 0 && !radio->int_in_running)
 		goto err_buf;
+	else if (retval < 0)	/* in case of radio->int_in_running == 1 */
+		goto err_all;
 
 	/* set initial frequency */
 	si470x_set_freq(radio, 87.5 * FREQ_MUL); /* available in all regions */
-- 
2.38.1

