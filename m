Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DACC70B1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 01:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjEUXAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 19:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEUW7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:59:51 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AEAC1;
        Sun, 21 May 2023 15:59:49 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPSA id 35D0E1C0004;
        Sun, 21 May 2023 22:59:47 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 2/2] input: joystick: Fix buffer data parsing
Date:   Mon, 22 May 2023 00:59:01 +0200
Message-Id: <20230521225901.388455-3-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521225901.388455-1-contact@artur-rojek.eu>
References: <20230521225901.388455-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't try to access buffer data of a channel by its scan index. Instead,
calculate its offset in the buffer.

This is necessary, as the scan index of a channel does not represent its
position in a buffer - the buffer will contain data for enabled channels
only, affecting data offsets and alignment.

While at it, also fix minor style issue in probe.

Reported-by: Chris Morgan <macromorgan@hotmail.com>
Closes: https://lore.kernel.org/linux-input/20220408212857.9583-1-macroalpha82@gmail.com/
Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
---

v2: - provide new implementation for calculating channel offsets 
    - cache the resulting offsets
    - fix minor style issue in probe
    - drop the "Fixes" tag

 drivers/input/joystick/adc-joystick.c | 102 +++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 12 deletions(-)

diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index c0deff5d4282..2f9f0cae8f95 100644
--- a/drivers/input/joystick/adc-joystick.c
+++ b/drivers/input/joystick/adc-joystick.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/sort.h>
 
 #include <asm/unaligned.h>
 
@@ -25,6 +26,7 @@ struct adc_joystick {
 	struct iio_cb_buffer *buffer;
 	struct adc_joystick_axis *axes;
 	struct iio_channel *chans;
+	int *offsets;
 	int num_chans;
 	bool polled;
 };
@@ -47,35 +49,38 @@ static int adc_joystick_handle(const void *data, void *private)
 {
 	struct adc_joystick *joy = private;
 	enum iio_endian endianness;
-	int bytes, msb, val, idx, i;
-	const u16 *data_u16;
+	int bytes, msb, val, off, i;
+	const u8 *chan_data;
 	bool sign;
 
 	bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
 
 	for (i = 0; i < joy->num_chans; ++i) {
-		idx = joy->chans[i].channel->scan_index;
 		endianness = joy->chans[i].channel->scan_type.endianness;
 		msb = joy->chans[i].channel->scan_type.realbits - 1;
 		sign = tolower(joy->chans[i].channel->scan_type.sign) == 's';
+		off = joy->offsets[i];
+
+		if (off < 0)
+			return -EINVAL;
+
+		chan_data = (const u8 *)data + off;
 
 		switch (bytes) {
 		case 1:
-			val = ((const u8 *)data)[idx];
+			val = *chan_data;
 			break;
 		case 2:
-			data_u16 = (const u16 *)data + idx;
-
 			/*
 			 * Data is aligned to the sample size by IIO core.
 			 * Call `get_unaligned_xe16` to hide type casting.
 			 */
 			if (endianness == IIO_BE)
-				val = get_unaligned_be16(data_u16);
+				val = get_unaligned_be16(chan_data);
 			else if (endianness == IIO_LE)
-				val = get_unaligned_le16(data_u16);
+				val = get_unaligned_le16(chan_data);
 			else /* IIO_CPU */
-				val = *data_u16;
+				val = *(const u16 *)chan_data;
 			break;
 		default:
 			return -EINVAL;
@@ -94,6 +99,69 @@ static int adc_joystick_handle(const void *data, void *private)
 	return 0;
 }
 
+static int adc_joystick_si_cmp(const void *a, const void *b, const void *priv)
+{
+	const struct iio_channel *chans = priv;
+
+	return chans[*(int *)a].channel->scan_index -
+	       chans[*(int *)b].channel->scan_index;
+}
+
+static int *adc_joystick_get_chan_offsets(struct iio_channel *chans, int count)
+{
+	struct iio_dev *indio_dev = chans[0].indio_dev;
+	const struct iio_chan_spec *ch;
+	int *offsets, *si_order;
+	int idx, i, si, length, offset = 0;
+
+	offsets = kmalloc_array(count, sizeof(int), GFP_KERNEL);
+	if (!offsets)
+		return ERR_PTR(-ENOMEM);
+
+	si_order = kmalloc_array(count, sizeof(int), GFP_KERNEL);
+	if (!si_order) {
+		kfree(offsets);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (i = 0; i < count; ++i)
+		si_order[i] = i;
+	/* Channels in buffer are ordered by scan index. Sort to match that. */
+	sort_r(si_order, count, sizeof(int), adc_joystick_si_cmp, NULL, chans);
+
+	for (i = 0; i < count; ++i) {
+		idx = si_order[i];
+		ch = chans[idx].channel;
+		si = ch->scan_index;
+
+		if (si < 0 || !test_bit(si, indio_dev->active_scan_mask)) {
+			offsets[idx] = -1;
+			continue;
+		}
+
+		/* Channels sharing scan indices also share the samples. */
+		if (idx > 0 && si == chans[idx - 1].channel->scan_index) {
+			offsets[idx] = offsets[idx - 1];
+			continue;
+		}
+
+		offsets[idx] = offset;
+
+		length = ch->scan_type.storagebits / 8;
+		if (ch->scan_type.repeat > 1)
+			length *= ch->scan_type.repeat;
+
+		/* Account for channel alignment. */
+		if (offset % length)
+			offset += length - (offset % length);
+		offset += length;
+	}
+
+	kfree(si_order);
+
+	return offsets;
+}
+
 static int adc_joystick_open(struct input_dev *dev)
 {
 	struct adc_joystick *joy = input_get_drvdata(dev);
@@ -101,10 +169,19 @@ static int adc_joystick_open(struct input_dev *dev)
 	int ret;
 
 	ret = iio_channel_start_all_cb(joy->buffer);
-	if (ret)
+	if (ret) {
 		dev_err(devp, "Unable to start callback buffer: %d\n", ret);
+		return ret;
+	}
 
-	return ret;
+	joy->offsets = adc_joystick_get_chan_offsets(joy->chans,
+						     joy->num_chans);
+	if (IS_ERR(joy->offsets)) {
+		dev_err(devp, "Unable to allocate channel offsets\n");
+		return PTR_ERR(joy->offsets);
+	}
+
+	return 0;
 }
 
 static void adc_joystick_close(struct input_dev *dev)
@@ -112,6 +189,7 @@ static void adc_joystick_close(struct input_dev *dev)
 	struct adc_joystick *joy = input_get_drvdata(dev);
 
 	iio_channel_stop_all_cb(joy->buffer);
+	kfree(joy->offsets);
 }
 
 static void adc_joystick_cleanup(void *data)
@@ -269,7 +347,7 @@ static int adc_joystick_probe(struct platform_device *pdev)
 
 		error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
 						 joy->buffer);
-		if (error)  {
+		if (error) {
 			dev_err(dev, "Unable to add action\n");
 			return error;
 		}
-- 
2.40.1

