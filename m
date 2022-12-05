Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE88643662
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiLEVFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiLEVEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:04:48 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173CB10F;
        Mon,  5 Dec 2022 13:04:21 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c13so5505490pfp.5;
        Mon, 05 Dec 2022 13:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpZoCNuVtqWmqXfOBYxoJCLHU/tCYzYlfr7fdZ1HLBU=;
        b=PC0oDyi/tmGrc1uhDSRSEHyMY+H+R9uB+dmHF3Y35EYWmpVS2VY+Xrv+sssREll6lq
         KttFq0viN82AH9/OKk8DWaa5QQK5ITu/FGFnPaWo9T5LoNcWu4JgQ/t7xCCmrcFH/YqH
         ga0N38vcc6CnlDsoxLkPblh8QNaxgUeBdq48dpKPheV6rGGoymBeHbxEYLJykrEqyvnx
         taVNEOLElceyej6h+5pnu+EXV1mO/UBcm0nW7pzjXmi15UfUryXUkLjuufdfbShiAjYf
         L++8MxBQTBq4c7EwPMxFF0V1lCVC19SK/3ArAuunrKXHJhV1ub+9rk8sTm/wuR9MxKUV
         hiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpZoCNuVtqWmqXfOBYxoJCLHU/tCYzYlfr7fdZ1HLBU=;
        b=V7MrBsWYPCjhQRkotbS3yDL4rOl1zi4xbIcnf+bVupPNVrvq8i+RPzkmvUXdziyyQU
         gtXsPuYmnZLw1mi32NPo0AqRpK7jFDPTCQ/LfX5HywOmclwqsDsxPv8fRUryPyjO5aQO
         UJ/50/LHd/+hDw8FbDn/drycsB+U0mgefWOdYbth6XpXGMnnx1EB8M1FbdNPrht40Fnw
         Pfl0tEi9RxDMf/yvvtYszg0IA6PR7b2Dh4tGjz9ymBvSALiMjWW5Pp+b41m/HY2+KOn5
         PfM+DFnZMg8dqNJZMwDSJYBDYmTaV8NOCVTsY+m3J3glwov/XJm7w6wY+ykuJSVE/RFT
         UobQ==
X-Gm-Message-State: ANoB5pkpbsOxs55nzua0L2xwpA3PUtFIMoGTUu1IK+/RygB7ADYQJrkI
        LitVxDpUXgKz3DHmVnl/TvEi+OLBKjM=
X-Google-Smtp-Source: AA0mqf7BOcx8t21C04DWALOygV4H7r6nlIrgg9PhDxbAEYd1rUS67q8msfI3NTisCzD6lpfLLjlSNQ==
X-Received: by 2002:a63:ea17:0:b0:477:9a46:f57b with SMTP id c23-20020a63ea17000000b004779a46f57bmr58686536pgi.319.1670274260086;
        Mon, 05 Dec 2022 13:04:20 -0800 (PST)
Received: from charizard.lan (c-67-183-167-205.hsd1.wa.comcast.net. [67.183.167.205])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b0017ec1b1bf9fsm3209863plh.217.2022.12.05.13.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:04:19 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        David Rheinsberg <david.rheinsberg@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH 2/2] HID: usbhid: Don't include report ID zero into returned data
Date:   Mon,  5 Dec 2022 13:03:54 -0800
Message-Id: <20221205210354.11846-3-andrew.smirnov@gmail.com>
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

Report ID of zero is a special case for ID-less reports, which by
definition do not have report ID as a part of their payload. Not
returning an extra zero also matches hidraw documentation,
specifically:

      For devices which do not use numbered reports, set the first
      byte to 0.  The returned report buffer will contain the report
      number in the first byte, followed by the report data read from
      the device.  For devices which do not use numbered reports, the
      report data will begin at the first byte of the returned buffer.

Cc: David Rheinsberg <david.rheinsberg@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index be4c731aaa65..575f09003602 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -874,18 +874,8 @@ static int usbhid_get_raw_report(struct hid_device *hid,
 	struct usb_device *dev = hid_to_usb_dev(hid);
 	struct usb_interface *intf = usbhid->intf;
 	struct usb_host_interface *interface = intf->cur_altsetting;
-	int skipped_report_id = 0;
 	int ret;
 
-	/* Byte 0 is the report number. Report data starts at byte 1.*/
-	buf[0] = report_number;
-	if (report_number == 0x0) {
-		/* Offset the return buffer by 1, so that the report ID
-		   will remain in byte 0. */
-		buf++;
-		count--;
-		skipped_report_id = 1;
-	}
 	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
 		HID_REQ_GET_REPORT,
 		USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
@@ -893,10 +883,6 @@ static int usbhid_get_raw_report(struct hid_device *hid,
 		interface->desc.bInterfaceNumber, buf, count,
 		USB_CTRL_SET_TIMEOUT);
 
-	/* count also the report id */
-	if (ret > 0 && skipped_report_id)
-		ret++;
-
 	return ret;
 }
 
-- 
2.34.1

