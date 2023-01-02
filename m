Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F182A65B6FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 20:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjABTvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 14:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjABTvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 14:51:14 -0500
Received: from ryne.moe (ryne.moe [157.90.134.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA350C6B;
        Mon,  2 Jan 2023 11:51:09 -0800 (PST)
Received: from localhost.localdomain (unknown [170.55.83.2])
        by ryne.moe (Postfix) with ESMTPSA id 670F1190038E;
        Mon,  2 Jan 2023 19:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redstrate.com;
        s=default; t=1672689068;
        bh=zPWXEAOgDew7btbTb3OjmAdtyJXaSUcLhZvldFVbyWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GvmD02TmAQ3KUFmXklNMdUgBZRD/CToQzlevMl2MQKiNmvJ06pTZWjChowbzx1VHn
         310y8YdSRjZiLB74CwpYX83ggyGOVwSn12Ak1B22yqB2Qy46puU1yuLNvpcQRfYgOO
         NJToNiB1LbQqOlCMQLsvCoJ/a/cKioKCNBmxlLgw=
From:   Joshua Goins <josh@redstrate.com>
To:     linux-input@vger.kernel.org
Cc:     jose.exposito89@gmail.com, Joshua Goins <josh@redstrate.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: uclogic: Add support for XP-PEN Artist 22R Pro
Date:   Mon,  2 Jan 2023 14:49:10 -0500
Message-Id: <20230102194911.56083-1-josh@redstrate.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <2068502.VLH7GnMWUR@adrastea>
References: <2068502.VLH7GnMWUR@adrastea>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
v2 changes:
  - rewrote initialization code to be more concise, and less error-prone, thanks
  Dan Carpenter & José Expósito for pointers!
  - less struct duplication, it now uses compatiable UGEE v2 ones.
  - uclogic_extra_input_mapping is now static, thanks José again!
  - straightened out dial transformation, now there's just the two cases and
  they're decimal.
  - fixed the patch formatting, it should be easier to apply now.
  - rebased onto 6.2-rc2

I kept the new initialization functions seperate, please review and tell me if
they are better suited being merged into their UGEE v2 counterparts (which would
involve a lot of branching). I don't have another UGEE v2 tablet to test, so I
won't be able to test for regressions for those devices myself, so I refrained
from those changes in this patch.

Original message:
I did not do the research for this hardware, or the original patch - that work
has been done by Aren Villanueva. For some reason they decided not to merge
it. My changes include remapping the stupid amount of tablet frame buttons,
cleaning up the code to match kernel style, and other small stuff.

The tablet is (almost) fully functional even when uclogic doesn't handle it.
Without initialization, the tablet has some sort of "basic driverless mode"
that allows the tablet frame buttons to have some default keys associated with
them (CTRL-S, CTRL-Z, that kind of stuff), but unfortunately the stylus pen
semi-works. While pressure sensitivity works, only one stylus button functions
correctly. Since the initialization process differs for Pro series tablets, the
new function uclogic_params_init_ugee_xppen_pro had to be introduced. I also
added USB HID IDs for this tablet too, but it's classified under the UGEE
vendor ID.

One of the more strange things I had to do is figure out a way to remap the
buttons since there are 20 of them in total, and of course there are more
buttons than there are BTN constants defined for us. When running without
uclogic, it starts at BTN_0, ends at BTN_8 and the tablet starts reporting
nonsensical keycodes so just leaving it alone isn't an option. I'm testing
this under a libinput system, which has a list of buttons it considers "tablet
pad buttons" which are notably BTN_0, BTN_1, so on and some
gamepad/joystick buttons. So I created a new array called
uclogic_extra_input_mapping for 20 working inputs.

Another weird feature of this tablet is the second dial, which the original
patchset introduced a new uclogic_frame param to handle since it seems it
throws both dials values into one byte. The left wheel is considered EV_WHEEL
and the other, EV_HWHEEL which seems fine to me. I also added the new param to
the debug messages too.


 drivers/hid/hid-ids.h            |   1 +
 drivers/hid/hid-uclogic-core.c   |  66 +++++++++++-
 drivers/hid/hid-uclogic-params.c | 180 +++++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-params.h |   5 +
 drivers/hid/hid-uclogic-rdesc.c  |  50 +++++++++
 drivers/hid/hid-uclogic-rdesc.h  |   9 ++
 6 files changed, 307 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 82713ef3aaa6..81d04054229a 100644
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
index 7fa6fe04f1b2..8d92e984f984 100644
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
+		if (key > 0 && key < ARRAY_SIZE(uclogic_extra_input_mapping)) {
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
@@ -531,6 +587,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
+				USB_DEVICE_ID_UGEE_XPPEN_TABLET_22R_PRO) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, uclogic_devices);
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index cd1233d7e253..d53c464a1b15 100644
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
@@ -1418,6 +1420,174 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	return rc;
 }
 
+/**
+ * uclogic_params_parse_ugee_xppen_pro_desc - parse the string descriptor
+ * containing pen and frame parameters returned by XP-PEN Pro devices.
+ *
+ * @str_desc:		String descriptor, cannot be NULL.
+ * @str_desc_size:	Size of the string descriptor.
+ * @desc_params:	Output description params list.
+ * @desc_params_size:	Size of the output description params list.
+ *
+ * Returns:
+ *	Zero, if successful. A negative errno code on error.
+ */
+static int uclogic_params_parse_ugee_xppen_pro_desc(const __u8 *str_desc,
+					     size_t str_desc_size,
+					     s32 *desc_params,
+					     size_t desc_params_size)
+{
+	s32 pen_x_lm, pen_y_lm;
+	s32 pen_x_pm, pen_y_pm;
+	s32 pen_pressure_lm;
+	s32 resolution;
+
+	/* Minimum descriptor length required, maximum seen so far is 14 */
+	const int min_str_desc_size = 12;
+
+	if (!str_desc || str_desc_size < min_str_desc_size)
+		return -EINVAL;
+
+	if (desc_params_size != UCLOGIC_RDESC_PH_ID_NUM)
+		return -EINVAL;
+
+	pen_x_lm = get_unaligned_le16(str_desc + 2);
+	pen_y_lm = get_unaligned_le16(str_desc + 4);
+	pen_pressure_lm = get_unaligned_le16(str_desc + 8);
+
+	resolution = get_unaligned_le16(str_desc + 10);
+	if (resolution == 0) {
+		pen_x_pm = 0;
+		pen_y_pm = 0;
+	} else {
+		pen_x_pm = pen_x_lm * 1000 / resolution;
+		pen_y_pm = pen_y_lm * 1000 / resolution;
+	}
+
+	desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM] = pen_x_lm;
+	desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_PM] = pen_x_pm;
+	desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] = pen_y_lm;
+	desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] = pen_y_pm;
+	desc_params[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] = pen_pressure_lm;
+
+	return 0;
+}
+
+/*
+ * uclogic_params_init_ugee_xppen_pro() - Initializes a UGEE XP-Pen Pro tablet device.
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
+static int uclogic_params_init_ugee_xppen_pro(struct uclogic_params *params,
+					      struct hid_device *hdev,
+					      const u8 rdesc_frame_arr[],
+					      const size_t rdesc_frame_size)
+{
+	int rc = 0;
+	struct usb_interface *iface;
+	__u8 bInterfaceNumber;
+	const int str_desc_len = 12;
+	u8 *str_desc = NULL;
+	__u8 *rdesc_pen = NULL;
+	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
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
+				     0x03);
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
+	rc = uclogic_params_parse_ugee_xppen_pro_desc(str_desc, str_desc_len,
+						      desc_params,
+						      ARRAY_SIZE(desc_params));
+	if (rc)
+		goto cleanup;
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
@@ -1728,6 +1898,16 @@ int uclogic_params_init(struct uclogic_params *params,
 			uclogic_params_init_invalid(&p);
 		}
 
+		break;
+	case VID_PID(USB_VENDOR_ID_UGEE,
+			USB_DEVICE_ID_UGEE_XPPEN_TABLET_22R_PRO):
+		rc = uclogic_params_init_ugee_xppen_pro(&p,
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
index fb40775f5f5b..86293ae8c995 100644
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
@@ -1185,6 +1191,50 @@ const __u8 uclogic_rdesc_xppen_deco01_frame_arr[] = {
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
index a1f78c07293f..c3cb2c75dda5 100644
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
@@ -205,4 +210,8 @@ extern const size_t uclogic_rdesc_ugee_g5_frame_size;
 /* Least-significant bit of Ugee G5 frame rotary encoder state */
 #define UCLOGIC_RDESC_UGEE_G5_FRAME_RE_LSB 38
 
+/* Fixed report descriptor for XP-Pen Arist 22R Pro frame */
+extern const __u8 uclogic_rdesc_xppen_artist_22r_pro_frame_arr[];
+extern const size_t uclogic_rdesc_xppen_artist_22r_pro_frame_size;
+
 #endif /* _HID_UCLOGIC_RDESC_H */

base-commit: 88603b6dc419445847923fcb7fe5080067a30f98
-- 
2.38.2

