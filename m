Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C52C68AC15
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 20:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjBDTVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 14:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjBDTVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 14:21:13 -0500
Received: from ryne.moe (ryne.moe [157.90.134.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ACC02BEC8;
        Sat,  4 Feb 2023 11:21:11 -0800 (PST)
Received: from localhost.localdomain (unknown [170.55.83.2])
        by ryne.moe (Postfix) with ESMTPSA id 7BCE81900DDC;
        Sat,  4 Feb 2023 19:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redstrate.com;
        s=default; t=1675538470;
        bh=hjmODvm3DHh9Nfizhq3ggVMFejW33OjDdGr6i3lMPiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IBwTk9WriRJ+0mmjqO0UicdMM2hOGt9lIT6pUj0rc9BGCfdzDV4wDfhrQGmSPenxB
         fsiqicijgGVZIfKhmhC6+vd303+gxyp8zf87isEMT8dGFvsOQrkzyB6WRDuW7YAag1
         sJO3lwYZa7hoRrcvey/4ZkzjEm1oaEiXkvphX3c8=
From:   Joshua Goins <josh@redstrate.com>
To:     linux-input@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Joshua Goins <josh@redstrate.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 2/2] HID: uclogic: Add support for XP-PEN Artist 22R Pro
Date:   Sat,  4 Feb 2023 14:20:51 -0500
Message-Id: <20230204192051.1287369-3-josh@redstrate.com>
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

Adds support for the XP-PEN Artist 22R Pro, including stylus, tablet frame
and pen pressure.

The tablet has 20 buttons, but need to be remapped in order since the
device reports invalid keycodes. Existing tablet functionality should
not be inhibited, as BTN0-8 is still used.

New initialization functions are added since the device differs slightly
from other UGEE v2 devices.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Reported-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Joshua Goins <josh@redstrate.com>
---
 drivers/hid/hid-ids.h            |   1 +
 drivers/hid/hid-uclogic-core.c   |  66 +++++++++++++++-
 drivers/hid/hid-uclogic-params.c | 132 +++++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-params.h |   5 ++
 drivers/hid/hid-uclogic-rdesc.c  |  44 +++++++++++
 drivers/hid/hid-uclogic-rdesc.h  |   4 +
 6 files changed, 248 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0f8c11842a3a..ac8b06fed870 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1298,6 +1298,7 @@
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L	0x0935
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S	0x0909
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06	0x0078
+#define USB_DEVICE_ID_UGEE_XPPEN_TABLET_22R_PRO	0x091b
 #define USB_DEVICE_ID_UGEE_TABLET_G5		0x0074
 #define USB_DEVICE_ID_UGEE_TABLET_EX07S		0x0071
 #define USB_DEVICE_ID_UGEE_TABLET_RAINBOW_CV720	0x0055
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index cfbbc39807a6..75d1fea0764c 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -81,6 +81,30 @@ static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+/* Buttons considered valid tablet pad inputs. */
+static const unsigned int uclogic_extra_input_mapping[] = {
+	BTN_0,
+	BTN_1,
+	BTN_2,
+	BTN_3,
+	BTN_4,
+	BTN_5,
+	BTN_6,
+	BTN_7,
+	BTN_8,
+	BTN_RIGHT,
+	BTN_MIDDLE,
+	BTN_SIDE,
+	BTN_EXTRA,
+	BTN_FORWARD,
+	BTN_BACK,
+	BTN_B,
+	BTN_A,
+	BTN_BASE,
+	BTN_BASE2,
+	BTN_X
+};
+
 static int uclogic_input_mapping(struct hid_device *hdev,
 				 struct hid_input *hi,
 				 struct hid_field *field,
@@ -91,9 +115,27 @@ static int uclogic_input_mapping(struct hid_device *hdev,
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 	struct uclogic_params *params = &drvdata->params;
 
-	/* Discard invalid pen usages */
-	if (params->pen.usage_invalid && (field->application == HID_DG_PEN))
-		return -1;
+	if (field->application == HID_GD_KEYPAD) {
+		/*
+		 * Remap input buttons to sensible ones that are not invalid.
+		 * This only affects previous behavior for devices with more than ten or so buttons.
+		 */
+		const int key = (usage->hid & HID_USAGE) - 1;
+
+		if (key < ARRAY_SIZE(uclogic_extra_input_mapping)) {
+			hid_map_usage(hi,
+				      usage,
+				      bit,
+				      max,
+				      EV_KEY,
+				      uclogic_extra_input_mapping[key]);
+			return 1;
+		}
+	} else if (field->application == HID_DG_PEN) {
+		/* Discard invalid pen usages */
+		if (params->pen.usage_invalid)
+			return -1;
+	}
 
 	/* Let hid-core decide what to do */
 	return 0;
@@ -403,8 +445,22 @@ static int uclogic_raw_event_frame(
 
 	/* If need to, and can, transform the bitmap dial reports */
 	if (frame->bitmap_dial_byte > 0 && frame->bitmap_dial_byte < size) {
-		if (data[frame->bitmap_dial_byte] == 2)
+		switch (data[frame->bitmap_dial_byte]) {
+		case 2:
 			data[frame->bitmap_dial_byte] = -1;
+			break;
+
+		/* Everything below here is for tablets that shove multiple dials into 1 byte */
+		case 16:
+			data[frame->bitmap_dial_byte] = 0;
+			data[frame->bitmap_second_dial_destination_byte] = 1;
+			break;
+
+		case 32:
+			data[frame->bitmap_dial_byte] = 0;
+			data[frame->bitmap_second_dial_destination_byte] = -1;
+			break;
+		}
 	}
 
 	return 0;
@@ -533,6 +589,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
+				USB_DEVICE_ID_UGEE_XPPEN_TABLET_22R_PRO) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, uclogic_devices);
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index d68cb99a03de..0f94715bb627 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -103,6 +103,8 @@ static void uclogic_params_frame_hid_dbg(
 		frame->touch_flip_at);
 	hid_dbg(hdev, "\t\t.bitmap_dial_byte = %u\n",
 		frame->bitmap_dial_byte);
+	hid_dbg(hdev, "\t\t.bitmap_second_dial_destination_byte = %u\n",
+			frame->bitmap_second_dial_destination_byte);
 }
 
 /**
@@ -1417,6 +1419,126 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	return rc;
 }
 
+/*
+ * uclogic_params_init_ugee_xppen_pro_22r() - Initializes a UGEE XP-Pen Pro 22R tablet device.
+ *
+ * @hdev:	The HID device of the tablet interface to initialize and get
+ *		parameters from. Cannot be NULL.
+ * @params:	Parameters to fill in (to be cleaned with
+ *		uclogic_params_cleanup()). Not modified in case of error.
+ *		Cannot be NULL.
+ *
+ * Returns:
+ *	Zero, if successful. A negative errno code on error.
+ */
+static int uclogic_params_init_ugee_xppen_pro_22r(struct uclogic_params *params,
+						  struct hid_device *hdev,
+						  const u8 rdesc_frame_arr[],
+						  const size_t rdesc_frame_size)
+{
+	int rc = 0;
+	struct usb_interface *iface;
+	__u8 bInterfaceNumber;
+	const int str_desc_len = 12;
+	u8 *str_desc = NULL;
+	__u8 *rdesc_pen = NULL;
+	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
+	enum uclogic_params_frame_type frame_type;
+	/* The resulting parameters (noop) */
+	struct uclogic_params p = {0, };
+
+	if (!hdev || !params) {
+		rc = -EINVAL;
+		goto cleanup;
+	}
+
+	iface = to_usb_interface(hdev->dev.parent);
+	bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
+
+	/* Ignore non-pen interfaces */
+	if (bInterfaceNumber != 2) {
+		uclogic_params_init_invalid(&p);
+		goto output;
+	}
+
+	/*
+	 * Initialize the interface by sending magic data.
+	 * This magic data is the same as other UGEE v2 tablets.
+	 */
+	rc = uclogic_probe_interface(hdev,
+				     uclogic_ugee_v2_probe_arr,
+				     uclogic_ugee_v2_probe_size,
+				     uclogic_ugee_v2_probe_endpoint);
+	if (rc) {
+		uclogic_params_init_invalid(&p);
+		goto output;
+	}
+
+	/**
+	 * Read the string descriptor containing pen and frame parameters.
+	 * These are slightly different than typical UGEE v2 devices.
+	 */
+	rc = uclogic_params_get_str_desc(&str_desc, hdev, 100, str_desc_len);
+	if (rc != str_desc_len) {
+		hid_err(hdev, "failed retrieving pen and frame parameters: %d\n", rc);
+		uclogic_params_init_invalid(&p);
+		goto output;
+	}
+
+	rc = uclogic_params_parse_ugee_v2_desc(str_desc, str_desc_len,
+					       desc_params,
+					       ARRAY_SIZE(desc_params),
+					       &frame_type);
+	if (rc)
+		goto cleanup;
+
+	// str_desc doesn't report the correct amount of buttons, so manually fix it
+	desc_params[UCLOGIC_RDESC_FRAME_PH_ID_UM] = 20;
+
+	kfree(str_desc);
+	str_desc = NULL;
+
+	/* Initialize the pen interface */
+	rdesc_pen = uclogic_rdesc_template_apply(
+				uclogic_rdesc_ugee_v2_pen_template_arr,
+				uclogic_rdesc_ugee_v2_pen_template_size,
+				desc_params, ARRAY_SIZE(desc_params));
+	if (!rdesc_pen) {
+		rc = -ENOMEM;
+		goto cleanup;
+	}
+
+	p.pen.desc_ptr = rdesc_pen;
+	p.pen.desc_size = uclogic_rdesc_ugee_v2_pen_template_size;
+	p.pen.id = 0x02;
+	p.pen.subreport_list[0].value = 0xf0;
+	p.pen.subreport_list[0].id = UCLOGIC_RDESC_V1_FRAME_ID;
+
+	/* Initialize the frame interface */
+	rc = uclogic_params_frame_init_with_desc(
+		&p.frame_list[0],
+		rdesc_frame_arr,
+		rdesc_frame_size,
+		UCLOGIC_RDESC_V1_FRAME_ID);
+	if (rc < 0) {
+		hid_err(hdev, "initializing frame params failed: %d\n", rc);
+		goto output;
+	}
+
+	p.frame_list[0].bitmap_dial_byte = 7;
+	p.frame_list[0].bitmap_second_dial_destination_byte = 8;
+
+output:
+	/* Output parameters */
+	memcpy(params, &p, sizeof(*params));
+	memset(&p, 0, sizeof(p));
+	rc = 0;
+cleanup:
+	kfree(str_desc);
+	uclogic_params_cleanup(&p);
+	return rc;
+}
+
 /**
  * uclogic_params_init() - initialize a tablet interface and discover its
  * parameters.
@@ -1729,6 +1851,16 @@ int uclogic_params_init(struct uclogic_params *params,
 			uclogic_params_init_invalid(&p);
 		}
 
+		break;
+	case VID_PID(USB_VENDOR_ID_UGEE,
+			USB_DEVICE_ID_UGEE_XPPEN_TABLET_22R_PRO):
+		rc = uclogic_params_init_ugee_xppen_pro_22r(&p,
+			hdev,
+			uclogic_rdesc_xppen_artist_22r_pro_frame_arr,
+			uclogic_rdesc_xppen_artist_22r_pro_frame_size);
+		if (rc != 0)
+			goto cleanup;
+
 		break;
 	}
 
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index a97477c02ff8..6621a75a4b1a 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -171,6 +171,11 @@ struct uclogic_params_frame {
 	 * counterclockwise, as opposed to the normal 1 and -1.
 	 */
 	unsigned int bitmap_dial_byte;
+	/*
+	 * Destination offset for the second bitmap dial byte, if the tablet
+	 * supports a second dial at all.
+	 */
+	unsigned int bitmap_second_dial_destination_byte;
 };
 
 /*
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index b6dfdf6356a6..86293ae8c995 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -1191,6 +1191,50 @@ const __u8 uclogic_rdesc_xppen_deco01_frame_arr[] = {
 const size_t uclogic_rdesc_xppen_deco01_frame_size =
 			sizeof(uclogic_rdesc_xppen_deco01_frame_arr);
 
+/* Fixed report descriptor for XP-Pen Arist 22R Pro frame */
+const __u8 uclogic_rdesc_xppen_artist_22r_pro_frame_arr[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),                       */
+	0x09, 0x07,         /*  Usage (Keypad),                             */
+	0xA1, 0x01,         /*  Collection (Application),                   */
+	0x85, UCLOGIC_RDESC_V1_FRAME_ID,
+	/*      Report ID (Virtual report),             */
+	0x05, 0x0D,         /*     Usage Page (Digitizer),                  */
+	0x09, 0x39,         /*      Usage (Tablet Function Keys),           */
+	0xA0,               /*      Collection (Physical),                  */
+	0x14,               /*          Logical Minimum (0),                */
+	0x25, 0x01,         /*          Logical Maximum (1),                */
+	0x75, 0x01,         /*          Report Size (1),                    */
+	0x95, 0x08,         /*          Report Count (8),                   */
+	0x81, 0x01,         /*          Input (Constant),                   */
+	0x05, 0x09,         /*          Usage Page (Button),                */
+	0x19, 0x01,         /*          Usage Minimum (01h),                */
+	0x29, 0x14,         /*          Usage Maximum (14h),                */
+	0x95, 0x14,         /*          Report Count (20),                  */
+	0x81, 0x02,         /*          Input (Variable),                   */
+	0x95, 0x14,         /*          Report Count (20),                  */
+	0x81, 0x01,         /*          Input (Constant),                   */
+	0x05, 0x01,         /*          Usage Page (Desktop),               */
+	0x09, 0x38,         /*          Usage (Wheel),                      */
+	0x75, 0x08,         /*          Report Size (8),                    */
+	0x95, 0x01,         /*          Report Count (1),                   */
+	0x15, 0xFF,         /*          Logical Minimum (-1),               */
+	0x25, 0x08,         /*          Logical Maximum (8),                */
+	0x81, 0x06,         /*          Input (Variable, Relative),         */
+	0x05, 0x0C,         /*          Usage Page (Consumer Devices),      */
+	0x0A, 0x38, 0x02,   /*          Usage (AC PAN),                     */
+	0x95, 0x01,         /*          Report Count (1),                   */
+	0x81, 0x06,         /*          Input (Variable, Relative),         */
+	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),              */
+	0x75, 0x08,         /*          Report Size (8),                    */
+	0x95, 0x01,         /*          Report Count (1),                   */
+	0x81, 0x02,         /*          Input (Variable),                   */
+	0xC0,               /*      End Collection                          */
+	0xC0,               /*  End Collection                              */
+};
+
+const size_t uclogic_rdesc_xppen_artist_22r_pro_frame_size =
+				sizeof(uclogic_rdesc_xppen_artist_22r_pro_frame_arr);
+
 /**
  * uclogic_rdesc_template_apply() - apply report descriptor parameters to a
  * report descriptor template, creating a report descriptor. Copies the
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index 906d068f50a9..c3cb2c75dda5 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -210,4 +210,8 @@ extern const size_t uclogic_rdesc_ugee_g5_frame_size;
 /* Least-significant bit of Ugee G5 frame rotary encoder state */
 #define UCLOGIC_RDESC_UGEE_G5_FRAME_RE_LSB 38
 
+/* Fixed report descriptor for XP-Pen Arist 22R Pro frame */
+extern const __u8 uclogic_rdesc_xppen_artist_22r_pro_frame_arr[];
+extern const size_t uclogic_rdesc_xppen_artist_22r_pro_frame_size;
+
 #endif /* _HID_UCLOGIC_RDESC_H */
-- 
2.39.1

