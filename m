Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306A768AC14
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 20:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjBDTVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 14:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjBDTVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 14:21:12 -0500
Received: from ryne.moe (ryne.moe [157.90.134.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E58AC22781;
        Sat,  4 Feb 2023 11:21:09 -0800 (PST)
Received: from localhost.localdomain (unknown [170.55.83.2])
        by ryne.moe (Postfix) with ESMTPSA id 3FF561900DD9;
        Sat,  4 Feb 2023 19:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redstrate.com;
        s=default; t=1675538469;
        bh=O/I3Hm6ejuFiQJp1YQSUTHsvunYFgf87CK9e8LDPii8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Gy6lD6DxplWSK+vheXjGeebfShYaa0vYgKbebmgKwjc4ZrGaho7TsUphJx4bg4BwB
         dYE3RKgLgZVedqFTsfLgNlH52AWj/RDhZdpGZJ0hbfhZ+RuFz15JGgg5GELea5RYxT
         qtD1V7BvqorUO6vCYtJ9u/ef6lcIkwnc+bPVcFts=
From:   Joshua Goins <josh@redstrate.com>
To:     linux-input@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Mia Kanashi <chad@redpilled.dev>,
        Andreas Grosse <andig.mail@t-online.de>,
        Joshua Goins <josh@redstrate.com>
Subject: [PATCH v3 1/2] HID: uclogic: Refactor UGEEv2 probe magic data
Date:   Sat,  4 Feb 2023 14:20:50 -0500
Message-Id: <20230204192051.1287369-2-josh@redstrate.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230204192051.1287369-1-josh@redstrate.com>
References: <20230204192051.1287369-1-josh@redstrate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: José Expósito <jose.exposito89@gmail.com>

A fututure patch will need to use the array of magic data that the
UGEEv2 devices expect on probe and the endpoint number. Move them to a
common place.

Refactor, no functional changes.

Tested-by: Mia Kanashi <chad@redpilled.dev>
Tested-by: Andreas Grosse <andig.mail@t-online.de>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Joshua Goins <josh@redstrate.com>
---
 drivers/hid/hid-uclogic-params.c | 11 +++++------
 drivers/hid/hid-uclogic-rdesc.c  |  6 ++++++
 drivers/hid/hid-uclogic-rdesc.h  |  5 +++++
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 3c5eea3df328..d68cb99a03de 100644
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
@@ -1305,9 +1305,6 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	__u8 *rdesc_pen = NULL;
 	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
 	enum uclogic_params_frame_type frame_type;
-	__u8 magic_arr[] = {
-		0x02, 0xb0, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
-	};
 	/* The resulting parameters (noop) */
 	struct uclogic_params p = {0, };
 
@@ -1337,7 +1334,9 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
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
2.39.1

