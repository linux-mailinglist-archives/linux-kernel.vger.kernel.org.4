Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5DE6562BB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiLZMz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiLZMzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:55:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4761B638A;
        Mon, 26 Dec 2022 04:55:12 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ay40so7519028wmb.2;
        Mon, 26 Dec 2022 04:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrvtidJ8xPFZfQ460af+rLN0IIOJjCAfOAN34f+mtgs=;
        b=i8mWrqY68XdaYSWJhe8ZGyoitTjfSNsZDeBZiEfXUkARctGNy7OSchlJI5NAmoEyMu
         YROHsAKlvyWYNtzb6l37n7KcN6ARWBUWunLc8yIaKgoxjr+QESRRDMiOBXY9tTRg8QFc
         Yfzx56iZa7qK3taqFXzMFDO1qm81kUvoLeIkFv+pP2hxYvAJl3iHUlNSUQTtoY3hr/R5
         d55Upl/4wDEEeL+7xn16zRY1SQF+P/4DFaKpwI82gr+hgxH6kFgUj0nr8pnt2+HlSZ8v
         PRh7rN73iw6xRsQaBdiMPYi4e66SVaxWqwq2petY8i0851W4acbHiWTtuKvC/F1lLmY9
         yHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrvtidJ8xPFZfQ460af+rLN0IIOJjCAfOAN34f+mtgs=;
        b=jKjAJ3+GVEQISfrBCsX+o8A9LOlbaQvcPBiiFDlWTNvXDdbgunv55iHwk1hLYOHjo9
         5K2dk8ZAdGJOAf7RxqdV2nyLNRHCFsUmrIm8XR6a14Dk3d1PH1G0yeP1O7lfXg9gCMUL
         t9CSz42khzWdoMNR3FKpqVkzDN4xeCe4cmOLxLcGADzKVHd8FFu07seP6QXWBJZH2KRG
         2CsVk2HQIgS4l7uLqAJe7hWbgGzLVMbY7vD1jXpD4dhNae/7h7j/R4Fyk+VbSsLsmjKz
         27lA1I84AJtQk6+9cb5M6cNgY5TTRNYhhok+oqAEQMetWbFk/zLH1pi9VIh3ai3sZKvC
         Cc2A==
X-Gm-Message-State: AFqh2kpzO8JRYslDq0Xq5D1YD0hcVnc/Xfz/HlWf2f1/grJpM1lIZb87
        czZrOuoAMKEgQ0/v01mcQPc=
X-Google-Smtp-Source: AMrXdXu/pX3Ym6ZUtRfmyjt7cLay9jEvon1AhK13Hkw97UsPvQ8GhrGyZtxg6k0izbJ731iU96HpYw==
X-Received: by 2002:a1c:5442:0:b0:3cf:7385:677f with SMTP id p2-20020a1c5442000000b003cf7385677fmr12686996wmi.35.1672059310708;
        Mon, 26 Dec 2022 04:55:10 -0800 (PST)
Received: from localhost.localdomain ([94.73.32.212])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003cf894dbc4fsm13684497wmq.25.2022.12.26.04.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 04:55:10 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Mia Kanashi <chad@redpilled.dev>,
        Andreas Grosse <andig.mail@t-online.de>
Subject: [PATCH 3/6] HID: uclogic: Refactor UGEEv2 probe magic data
Date:   Mon, 26 Dec 2022 13:54:51 +0100
Message-Id: <20221226125454.16106-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221226125454.16106-1-jose.exposito89@gmail.com>
References: <20221226125454.16106-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A fututure patch will need to use the array of magic data that the
UGEEv2 devices expect on probe and the endpoint number. Move them to a
common place.

Refactor, no functional changes.

Tested-by: Mia Kanashi <chad@redpilled.dev>
Tested-by: Andreas Grosse <andig.mail@t-online.de>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 11 +++++------
 drivers/hid/hid-uclogic-rdesc.c  |  6 ++++++
 drivers/hid/hid-uclogic-rdesc.h  |  5 +++++
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 37cf4a93eafa..b6a515973942 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1021,8 +1021,8 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
  * Returns:
  *	Zero, if successful. A negative errno code on error.
  */
-static int uclogic_probe_interface(struct hid_device *hdev, u8 *magic_arr,
-				   int magic_size, int endpoint)
+static int uclogic_probe_interface(struct hid_device *hdev, const u8 *magic_arr,
+				   size_t magic_size, int endpoint)
 {
 	struct usb_device *udev;
 	unsigned int pipe = 0;
@@ -1311,9 +1311,6 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	__u8 *rdesc_pen = NULL;
 	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
 	enum uclogic_params_frame_type frame_type;
-	__u8 magic_arr[] = {
-		0x02, 0xb0, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
-	};
 	/* The resulting parameters (noop) */
 	struct uclogic_params p = {0, };
 
@@ -1344,7 +1341,9 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	 * The specific data was discovered by sniffing the Windows driver
 	 * traffic.
 	 */
-	rc = uclogic_probe_interface(hdev, magic_arr, sizeof(magic_arr), 0x03);
+	rc = uclogic_probe_interface(hdev, uclogic_ugee_v2_probe_arr,
+				     uclogic_ugee_v2_probe_size,
+				     uclogic_ugee_v2_probe_endpoint);
 	if (rc) {
 		uclogic_params_init_invalid(&p);
 		goto output;
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index fb40775f5f5b..b6dfdf6356a6 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -859,6 +859,12 @@ const __u8 uclogic_rdesc_v2_frame_dial_arr[] = {
 const size_t uclogic_rdesc_v2_frame_dial_size =
 			sizeof(uclogic_rdesc_v2_frame_dial_arr);
 
+const __u8 uclogic_ugee_v2_probe_arr[] = {
+	0x02, 0xb0, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+const size_t uclogic_ugee_v2_probe_size = sizeof(uclogic_ugee_v2_probe_arr);
+const int uclogic_ugee_v2_probe_endpoint = 0x03;
+
 /* Fixed report descriptor template for UGEE v2 pen reports */
 const __u8 uclogic_rdesc_ugee_v2_pen_template_arr[] = {
 	0x05, 0x0d,         /*  Usage Page (Digitizers),                */
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index a1f78c07293f..906d068f50a9 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -164,6 +164,11 @@ extern const size_t uclogic_rdesc_v2_frame_dial_size;
 /* Report ID for tweaked UGEE v2 battery reports */
 #define UCLOGIC_RDESC_UGEE_V2_BATTERY_ID 0xba
 
+/* Magic data expected by UGEEv2 devices on probe */
+extern const __u8 uclogic_ugee_v2_probe_arr[];
+extern const size_t uclogic_ugee_v2_probe_size;
+extern const int uclogic_ugee_v2_probe_endpoint;
+
 /* Fixed report descriptor template for UGEE v2 pen reports */
 extern const __u8 uclogic_rdesc_ugee_v2_pen_template_arr[];
 extern const size_t uclogic_rdesc_ugee_v2_pen_template_size;
-- 
2.38.1

