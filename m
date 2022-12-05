Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC797643663
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiLEVF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiLEVEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:04:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEDD2B27C;
        Mon,  5 Dec 2022 13:04:19 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so4115941pjj.2;
        Mon, 05 Dec 2022 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6oMfPCt+VzMyZOzVwetr+D2O/Sy+iM3cliiKh9kVZk=;
        b=JuM7gtZPmUahPjEzpRJ/D0IW/rRSE5knEYmUm5AwygVdwzx6Vg56SynSTVXmZ+YUPy
         nfCONatVNQI5AHc5dUKtRL5s6hab06jjg07/RSdZptm6KqoYEGdR6ltqROa5On7BN7eY
         /jUwDaaCcDqABPUXjvKjh8N8RKTSV4m7JdvQQQ+MhBVHZGDPMhx9uLrDJlYkr2rKnHde
         s4kn+/5GoRHQ3S33uQGqld26AkN7q8BTlQ7wPUkm+oFuAQm1mnzenf/GuHD6B3GI9gaF
         KsLKeUIU3Fr4CWM6fTDE4jDMKZPPlEpiUEOl23GfmGahGmzVrlcsI9nRtRwwaBdXeuxF
         8VFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6oMfPCt+VzMyZOzVwetr+D2O/Sy+iM3cliiKh9kVZk=;
        b=Tfh9UeVjGpm3Ti5Kpds7RonyINADtphYhBZfEPHfz7Ew9umeINIwpEHb4yTGQ1v573
         P0LzlZEcgiqapBDqheCiWcirQX17kIDBFc6srC1mjNhomoeTfMAhEBZy69bTH0X6WOfH
         cnIyTC+GcEQY/SEwOebtEb27w+m1Pibs9Msmkkw8HUbv/Mkf2iO1LAglPhe2OH8mqZru
         VxTx1J7f+I991eYHzpNlAUXtacvPhplt3GZlwYaHEeElSA+OneHeRb21mQy5zRFxb8hr
         RbJ/1hK/31pAF9YRrbA8k/E5B0xwfyv1rcvZFgUGZjuTbsK/hoyFa7J4e+GBWWk4mhzo
         tDTw==
X-Gm-Message-State: ANoB5plf2OW33Qaw8xk4PfGSl8QQEDh2Fo1QhOFbJXeqi5ySRvxe0nth
        y64ts9xSzzRyO4GKXiCSRkPOK9n//Ck=
X-Google-Smtp-Source: AA0mqf74olyjf+s3Y8t+RD/34XVAbfMxraSD+RW1xhTt1KUdzA0EUKA/dQ0ENsJdBFajU8bQt8yAkQ==
X-Received: by 2002:a17:902:d550:b0:189:7bfe:1eb5 with SMTP id z16-20020a170902d55000b001897bfe1eb5mr22835674plf.9.1670274258003;
        Mon, 05 Dec 2022 13:04:18 -0800 (PST)
Received: from charizard.lan (c-67-183-167-205.hsd1.wa.comcast.net. [67.183.167.205])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b0017ec1b1bf9fsm3209863plh.217.2022.12.05.13.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:04:17 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        David Rheinsberg <david.rheinsberg@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH 1/2] HID: uhid: Don't send the report ID if it's zero
Date:   Mon,  5 Dec 2022 13:03:53 -0800
Message-Id: <20221205210354.11846-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221205210354.11846-1-andrew.smirnov@gmail.com>
References: <20221205210354.11846-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report ID of zero is a special case handling ID-less reports and in
that case we should omit report ID from the payload being sent to the
backend.

Without this change UHID_DEV_NUMBERED_{FEATURE,OUTPUT}_REPORTS doesn't
represent a semantical difference.

Cc: David Rheinsberg <david.rheinsberg@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/hid/uhid.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 2a918aeb0af1..7551120215e8 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -273,11 +273,11 @@ static int uhid_hid_get_report(struct hid_device *hid, unsigned char rnum,
 }
 
 static int uhid_hid_set_report(struct hid_device *hid, unsigned char rnum,
-			       const u8 *buf, size_t count, u8 rtype)
+			       u8 *buf, size_t count, u8 rtype)
 {
 	struct uhid_device *uhid = hid->driver_data;
 	struct uhid_event *ev;
-	int ret;
+	int ret, skipped_report_id = 0;
 
 	if (!READ_ONCE(uhid->running) || count > UHID_DATA_MAX)
 		return -EIO;
@@ -286,6 +286,15 @@ static int uhid_hid_set_report(struct hid_device *hid, unsigned char rnum,
 	if (!ev)
 		return -ENOMEM;
 
+	/* Byte 0 is the report number. Report data starts at byte 1.*/
+	buf[0] = rnum;
+	if (buf[0] == 0x0) {
+		/* Don't send the Report ID */
+		buf++;
+		count--;
+		skipped_report_id = 1;
+	}
+
 	ev->type = UHID_SET_REPORT;
 	ev->u.set_report.rnum = rnum;
 	ev->u.set_report.rtype = rtype;
@@ -306,7 +315,7 @@ static int uhid_hid_set_report(struct hid_device *hid, unsigned char rnum,
 	if (uhid->report_buf.u.set_report_reply.err)
 		ret = -EIO;
 	else
-		ret = count;
+		ret = count + skipped_report_id;
 
 unlock:
 	mutex_unlock(&uhid->report_lock);
-- 
2.34.1

