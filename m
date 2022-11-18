Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9305362FB13
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbiKRRDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiKRRCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:02:52 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CFD87564;
        Fri, 18 Nov 2022 09:02:50 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m14so5048516pji.0;
        Fri, 18 Nov 2022 09:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sLTJOW58qEMnvyde+G1ONR5iNscDQCTf/dCwM8qW96w=;
        b=aMrvoD24ysb6PngqTRy1y2/b3jLGiR6TwNcfW9xWdTUun7eKRtSgLMKFlvIrj4CZ6g
         nIWu/5ayN+Kf0NQToVu3F3MsXnUiO6TK5HywiPwhqFvJiTiXZrr5uT7BNMjQRl3nGfFV
         KrIYi9mQcwDHyT9roApDtCdKQYxIBd6RDAe55uD5Kg9J6R0bNMXvOZK1Cx+8l6hF+6sF
         /A/68aSNJdvFxfsjlIXETo+boV9LyI9skmoxeirjOMv6AlRCx7si9RJgtlfP08KudvKN
         19THyTepXmQmmsyGbs4FAQnt8kJxtblNJo97JqLI1PNi3K+I44egs8vL2U9D7xjVBF5j
         7jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLTJOW58qEMnvyde+G1ONR5iNscDQCTf/dCwM8qW96w=;
        b=PAar0inn/bmdVhCPHBPu+T4YWkbs3Trkk4EV8hAkv03tCJPO6Mv+cy6X2D/niEMXcO
         3vOZlpQbnDtmlgtBbCMg8AL6FHhqj46d7P7ZVYZSs5SJuGrI7kHGgPvszUzLllLn8kZX
         eC5z5RNHfhXVysEsT8gLR/CX8cwWzBcf7MPdIiUU2Tb527EZm1uetwuO+BvpVER5kGj8
         R2PYdATY4Wsv3JKso1kn7StaEXvXlNUSECNKG+5twyfqlx5plrqY75cjQDH0OQMf0mtk
         GvgWVNQKbpKCx64NTqOVupcm2NDhszCkbIvNrX6tYPcwzKIzlgbw2MZk++FlzxXgj9Pv
         Sjxw==
X-Gm-Message-State: ANoB5pm6zcMFm+cnIyRZm41YWxwp+JTOmAhCwWxzoDVftODokSWq4aF7
        x00LY4cQJoOmwh2BzgBagYA=
X-Google-Smtp-Source: AA0mqf4jGMQ4O/Iide/V22JQ+9pyt4T7M8EiKa7LD6j5OSPK8LZr1HhvGxNnLL6lMSUzEuexCji6YQ==
X-Received: by 2002:a17:902:e492:b0:186:5f71:7939 with SMTP id i18-20020a170902e49200b001865f717939mr265130ple.162.1668790969817;
        Fri, 18 Nov 2022 09:02:49 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:e4c5:c31d:4c68:97a0])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a788700b0020ad53b5883sm3047337pjk.14.2022.11.18.09.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 09:02:48 -0800 (PST)
Date:   Fri, 18 Nov 2022 09:02:45 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Marge Yang <Marge.Yang@tw.synaptics.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hid: i2c: let RMI devices decide what constitutes wakeup
 event
Message-ID: <Y3e6tcmg1YAKsj9c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HID-RMI is special in the sense that it does not carry HID events
directly, but rather uses HID protocol as a wrapper/transport for RMI
protocol.  Therefore we should not assume that all data coming from the
device via interrupt is associated with user activity and report wakeup
event indiscriminately, but rather let HID-RMI do that when appropriate.

HID-RMI devices tag responses to the commands issued by the host as
RMI_READ_DATA_REPORT_ID whereas motion and other input events from the
device are tagged as RMI_ATTN_REPORT_ID. Change hid-rmi to report wakeup
events when receiving the latter packets. This allows ChromeOS to
accurately identify wakeup source and make correct decision on the mode
of the resume the system should take ("dark" where the display stays off
vs normal one).

Fixes: d951ae1ce803 ("HID: i2c-hid: Report wakeup events")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-rmi.c              | 2 ++
 drivers/hid/i2c-hid/i2c-hid-core.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index bb1f423f4ace..84e7ba5314d3 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -326,6 +326,8 @@ static int rmi_input_event(struct hid_device *hdev, u8 *data, int size)
 	if (!(test_bit(RMI_STARTED, &hdata->flags)))
 		return 0;
 
+	pm_wakeup_event(hdev->dev.parent, 0);
+
 	local_irq_save(flags);
 
 	rmi_set_attn_data(rmi_dev, data[1], &data[2], size - 2);
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 0667b6022c3b..a9428b7f34a4 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -554,7 +554,8 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 	i2c_hid_dbg(ihid, "input: %*ph\n", ret_size, ihid->inbuf);
 
 	if (test_bit(I2C_HID_STARTED, &ihid->flags)) {
-		pm_wakeup_event(&ihid->client->dev, 0);
+		if (ihid->hid->group != HID_GROUP_RMI)
+			pm_wakeup_event(&ihid->client->dev, 0);
 
 		hid_input_report(ihid->hid, HID_INPUT_REPORT,
 				ihid->inbuf + sizeof(__le16),
-- 
2.38.1.584.g0f3c55d4c2-goog


-- 
Dmitry
