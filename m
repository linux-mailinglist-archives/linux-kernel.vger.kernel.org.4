Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE06F68CE3D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBGEfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBGEfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:35:44 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB6D11E9B;
        Mon,  6 Feb 2023 20:35:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b5so14452232plz.5;
        Mon, 06 Feb 2023 20:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4way9QTXZHFbfuc+6QFzaPryT6l4vDL5l15qmSZzzs=;
        b=Q/453Bq2aSJflRjWmkS02U4poIzaNsNdJy16H/OND5w6la7hRVC5SiagS/mtcg92oN
         7bHlTok0YPEn1yQo0rH/DdRmz+ZSaphAwCTJ+X2S9Qi8FB6ESUdrd/F7byZ2VjB8sJ3Y
         Z4q7aK6BqQq4Q1DNt+060mHjG0mIoelGGmrNqdlACCiOm8OyULbOzwAptAObDnWq6cC5
         u6OHYCRoitHa6wGSXo/duFb4XgEJHQChP0LiiOICLUnOrUpZLGLImMyXQiwuRyukdumo
         Ufw8oC2FkYK1GuxPjb1jmf4b7Z62tOeGgSgfnAX94LzRnk+75qFzz346RLHRNdqQaPUx
         zR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4way9QTXZHFbfuc+6QFzaPryT6l4vDL5l15qmSZzzs=;
        b=Wd6Ffpu7NaulFGrqAoDm7lZXqOisJrF+w6JRiQeFK6YZA+XN5IlJ3upGkmwdgnKUcM
         ix7pjbCReAkESQK10KwxHxRctSfThqDWRvVimQO66mt7k9eA3m0Bib5VHts/1JIpGbfS
         hW2tct2HPDeiz/Lril0djIVzq1vJ/+k8ChIsv6FPDuQtwQL9+kWwXqBwITCVAJ/IIdxc
         D1RQW/xUHb2Qccpid4R7oISpxFIu6F8MLeGF7ybFLpPmym4+BPKIqdGrfRFnmDeBlMaK
         ITskr/cpj41fcmiiWUFW0Lsl+V++4s6JzWU1LJBkiKKQRqgjlH6wKafpfPpmypDDZ3Em
         i8RQ==
X-Gm-Message-State: AO0yUKXVHAxHF0q14UrW0l4nEku8AiYARLqZINVx9bVBuOtHytNbWY7W
        e+kQAn5uO2VcSscKB3EmFS9BerPZyOhYFiPowmE43Q==
X-Google-Smtp-Source: AK7set/bVaUZx+FqAYxHDlWtNfXsYzxYS5EQGgf3TbqGtPEv0BK9cohUq3YIT37V2RG3oFOgzliEKA==
X-Received: by 2002:a17:90b:1bc6:b0:230:e025:9c55 with SMTP id oa6-20020a17090b1bc600b00230e0259c55mr2305018pjb.35.1675744541420;
        Mon, 06 Feb 2023 20:35:41 -0800 (PST)
Received: from d.home.yangfl.dn42 ([222.69.200.222])
        by smtp.gmail.com with ESMTPSA id p4-20020a63ab04000000b00499a90cce5bsm6695310pgf.50.2023.02.06.20.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 20:35:40 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] HID: kye: Rewrite tablet descriptor fixup routine
Date:   Tue,  7 Feb 2023 12:33:14 +0800
Message-Id: <20230207043318.23842-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207043318.23842-1-mmyangfl@gmail.com>
References: <20230207043318.23842-1-mmyangfl@gmail.com>
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

Genius digitizer tablets send incorrect (vendor-defined) report descriptors
by default. Descriptors for several models were added to override original
ones. Since they share the same structure and are handled by the same
Windows driver routine, extract the descriptor template and dynamic
parameters for easier new device adoption.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/hid/hid-kye.c | 114 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 102 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index da903138eee4..d8ac16bdb094 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -5,11 +5,10 @@
  *  Copyright (c) 2009 Jiri Kosina
  *  Copyright (c) 2009 Tomas Hanak
  *  Copyright (c) 2012 Nikolai Kondrashov
+ *  Copyright (c) 2023 David Yang
  */
 
-/*
- */
-
+#include <asm-generic/unaligned.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
@@ -554,8 +553,25 @@ static __u8 easypen_m406xe_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
+static const struct kye_tablet_info {
+	__u32 product;
+	__s32 x_logical_maximum;
+	__s32 y_logical_maximum;
+	__s32 pressure_logical_maximum;
+	__s32 x_physical_maximum;
+	__s32 y_physical_maximum;
+	__s8 unit_exponent;
+	__s8 unit;
+	bool has_punk;
+	unsigned int control_rsize;
+	const __u8 *control_rdesc;
+} kye_tablets_info[] = {
+	{}
+};
+
 static __u8 *kye_consumer_control_fixup(struct hid_device *hdev, __u8 *rdesc,
-		unsigned int *rsize, int offset, const char *device_name) {
+		unsigned int *rsize, int offset, const char *device_name)
+{
 	/*
 	 * the fixup that need to be done:
 	 *   - change Usage Maximum in the Consumer Control
@@ -574,6 +590,79 @@ static __u8 *kye_consumer_control_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+/*
+ * Fix tablet descriptor of so-called "DataFormat 2".
+ *
+ * Though we may achieve a usable descriptor from original vendor-defined one,
+ * some problems exist:
+ *  - Their Logical Maximum never exceed 32767 (7F FF), though device do report
+ *    values greater than that;
+ *  - Physical Maximums are arbitrarily filled (always equal to Logical
+ *    Maximum);
+ *  - Detail for control buttons are not provided (a vendor-defined Usage Page
+ *    with fixed content).
+ *
+ * Thus we use a pre-defined parameter table rather than digging it from
+ * original descriptor.
+ *
+ * We may as well write a fallback routine for unrecognized kye tablet, but it's
+ * clear kye are unlikely to produce new models in the foreseeable future, so we
+ * simply enumerate all possible models.
+ */
+static __u8 *kye_tablet_fixup(struct hid_device *hdev, __u8 *rdesc, unsigned int *rsize)
+{
+	const struct kye_tablet_info *info;
+	unsigned int newsize;
+
+	if (*rsize < sizeof(kye_tablet_rdesc)) {
+		hid_warn(hdev,
+			 "tablet report size too small, or kye_tablet_rdesc unexpectedly large\n");
+		return rdesc;
+	}
+
+	for (info = kye_tablets_info; info->product; info++) {
+		if (hdev->product == info->product)
+			break;
+	}
+
+	if (!info->product) {
+		hid_err(hdev, "tablet unknown, someone forget to add kye_tablet_info entry?\n");
+		return rdesc;
+	}
+
+	newsize = info->has_punk ? sizeof(kye_tablet_rdesc) : 112;
+	memcpy(rdesc, kye_tablet_rdesc, newsize);
+
+	put_unaligned_le32(info->x_logical_maximum, rdesc + 66);
+	put_unaligned_le32(info->x_physical_maximum, rdesc + 72);
+	rdesc[77] = info->unit;
+	rdesc[79] = info->unit_exponent;
+	put_unaligned_le32(info->y_logical_maximum, rdesc + 87);
+	put_unaligned_le32(info->y_physical_maximum, rdesc + 92);
+	put_unaligned_le32(info->pressure_logical_maximum, rdesc + 104);
+
+	if (info->has_punk) {
+		put_unaligned_le32(info->x_logical_maximum, rdesc + 156);
+		put_unaligned_le32(info->x_physical_maximum, rdesc + 162);
+		rdesc[167] = info->unit;
+		rdesc[169] = info->unit_exponent;
+		put_unaligned_le32(info->y_logical_maximum, rdesc + 177);
+		put_unaligned_le32(info->y_physical_maximum, rdesc + 182);
+	}
+
+	if (info->control_rsize) {
+		if (newsize + info->control_rsize > *rsize)
+			hid_err(hdev, "control rdesc unexpectedly large");
+		else {
+			memcpy(rdesc + newsize, info->control_rdesc, info->control_rsize);
+			newsize += info->control_rsize;
+		}
+	}
+
+	*rsize = newsize;
+	return rdesc;
+}
+
 static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
@@ -654,14 +743,6 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
-/**
- * kye_tablet_enable() - Enable fully-functional tablet mode by setting a special feature report.
- *
- * @hdev:	HID device
- *
- * The specific report ID and data were discovered by sniffing the
- * Windows driver traffic.
- */
 static int kye_tablet_enable(struct hid_device *hdev)
 {
 	struct list_head *list;
@@ -688,6 +769,15 @@ static int kye_tablet_enable(struct hid_device *hdev)
 
 	value = report->field[0]->value;
 
+	/*
+	 * The code is for DataFormat 2 of config xml. They have no obvious
+	 * meaning (at least not configurable in Windows driver) except enabling
+	 * fully-functional tablet mode (absolute positioning). Otherwise, the
+	 * tablet acts like a relative mouse.
+	 *
+	 * Though there're magic codes for DataFormat 3 and 4, no devices use
+	 * these DataFormats.
+	 */
 	value[0] = 0x12;
 	value[1] = 0x10;
 	value[2] = 0x11;
-- 
2.39.1

