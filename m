Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D65669BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjAMPPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjAMPOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:14:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EDF7CBEA;
        Fri, 13 Jan 2023 07:06:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32A0E620D8;
        Fri, 13 Jan 2023 15:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0429C433EF;
        Fri, 13 Jan 2023 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673622376;
        bh=5FHAU4CRUTRF2wPnZzEpiA7n2B+tgqdfKPUVa8IaClA=;
        h=From:To:Cc:Subject:Date:From;
        b=XJJJUsjWWNPce70xJFTKC6DrPbie0JCA4MU+WdIzNkY5pPCHGb8X6YbEu2uc0R9LT
         oqBcNZCo4u4vo1pjPqgalREBGvRIkUh2vrin2PN9AxWk82jxujb0DJLRm23K0wTOw5
         DHOIAlWimF3ipb4opuUZXlQatDgGYPllRKsAQpZiiRvJK0VSIxyAkUNtAPIPac/Ni+
         QnZTTcx9XSVEZl8s3A5kbmBvF8m4k5NfFkJ0mnrCk9angkMXoZM57h3aGf1b4z/XGa
         V+ymjl/7H8m2cM80I2vtWOpccBBZyUfJeGZo7eNVLpDhvthnVGIQH77WjhwiDegbe4
         1jXx3x+/LVmfg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com,
        avid.rheinsberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH 1/2] HID: core: Provide new max_buffer_size attribute to over-ride the default
Date:   Fri, 13 Jan 2023 15:05:56 +0000
Message-Id: <20230113150557.1308176-1-lee@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently, when a report is processed, its size is compared solely
against the value specified by user-space.  If the received report ends
up being smaller than this, the remainder of the buffer is zeroed.  That
is, the space between sizeof(csize) (size of the current report) and the
rsize (size provided by the user - i.e. Report Size * Report Count),
which can be handled up to HID_MAX_BUFFER_SIZE (16k).

This is an issue.  In the case of some low-level drivers, the buffers
are significantly smaller than the default 16k.  For instance, in the
case of uhid, the data buffer is a mere UHID_DATA_MAX (4k).  Meaning
that memset() shoots straight past the end of the buffer boundary and
starts zeroing out in-use values, often resulting in calamity.

This patch introduces a new variable into 'struct hid_ll_driver' where
individual low-level drivers can over-ride the default maximum value of
HID_MAX_BUFFER_SIZE (16k) with something more sympathetic to the
interface.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-core.c | 32 +++++++++++++++++++++++++-------
 include/linux/hid.h    |  3 +++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bd47628da6be0..b10383ca8fc05 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -261,6 +261,7 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
 {
 	struct hid_report *report;
 	struct hid_field *field;
+	unsigned int max_buffer_size = HID_MAX_BUFFER_SIZE;
 	unsigned int usages;
 	unsigned int offset;
 	unsigned int i;
@@ -291,8 +292,11 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
 	offset = report->size;
 	report->size += parser->global.report_size * parser->global.report_count;
 
+	if (parser->device->ll_driver->max_buffer_size)
+		max_buffer_size = parser->device->ll_driver->max_buffer_size;
+
 	/* Total size check: Allow for possible report index byte */
-	if (report->size > (HID_MAX_BUFFER_SIZE - 1) << 3) {
+	if (report->size > (max_buffer_size - 1) << 3) {
 		hid_err(parser->device, "report is too long\n");
 		return -1;
 	}
@@ -1963,6 +1967,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 	struct hid_report_enum *report_enum = hid->report_enum + type;
 	struct hid_report *report;
 	struct hid_driver *hdrv;
+	int max_buffer_size = HID_MAX_BUFFER_SIZE;
 	u32 rsize, csize = size;
 	u8 *cdata = data;
 	int ret = 0;
@@ -1978,10 +1983,13 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 
 	rsize = hid_compute_report_size(report);
 
-	if (report_enum->numbered && rsize >= HID_MAX_BUFFER_SIZE)
-		rsize = HID_MAX_BUFFER_SIZE - 1;
-	else if (rsize > HID_MAX_BUFFER_SIZE)
-		rsize = HID_MAX_BUFFER_SIZE;
+	if (hid->ll_driver->max_buffer_size)
+		max_buffer_size = hid->ll_driver->max_buffer_size;
+
+	if (report_enum->numbered && rsize >= max_buffer_size)
+		rsize = max_buffer_size - 1;
+	else if (rsize > max_buffer_size)
+		rsize = max_buffer_size;
 
 	if (csize < rsize) {
 		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
@@ -2384,7 +2392,12 @@ int hid_hw_raw_request(struct hid_device *hdev,
 		       unsigned char reportnum, __u8 *buf,
 		       size_t len, enum hid_report_type rtype, enum hid_class_request reqtype)
 {
-	if (len < 1 || len > HID_MAX_BUFFER_SIZE || !buf)
+	unsigned int max_buffer_size = HID_MAX_BUFFER_SIZE;
+
+	if (hdev->ll_driver->max_buffer_size)
+		max_buffer_size = hdev->ll_driver->max_buffer_size;
+
+	if (len < 1 || len > max_buffer_size || !buf)
 		return -EINVAL;
 
 	return hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
@@ -2403,7 +2416,12 @@ EXPORT_SYMBOL_GPL(hid_hw_raw_request);
  */
 int hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len)
 {
-	if (len < 1 || len > HID_MAX_BUFFER_SIZE || !buf)
+	unsigned int max_buffer_size = HID_MAX_BUFFER_SIZE;
+
+	if (hdev->ll_driver->max_buffer_size)
+		max_buffer_size = hdev->ll_driver->max_buffer_size;
+
+	if (len < 1 || len > max_buffer_size || !buf)
 		return -EINVAL;
 
 	if (hdev->ll_driver->output_report)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8677ae38599e4..f9b500b26f67c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -826,6 +826,7 @@ struct hid_driver {
  * @output_report: send output report to device
  * @idle: send idle request to device
  * @may_wakeup: return if device may act as a wakeup source during system-suspend
+ * @max_buffer_size: over-ride maximum data buffer size (default: HID_MAX_BUFFER_SIZE)
  */
 struct hid_ll_driver {
 	int (*start)(struct hid_device *hdev);
@@ -851,6 +852,8 @@ struct hid_ll_driver {
 
 	int (*idle)(struct hid_device *hdev, int report, int idle, int reqtype);
 	bool (*may_wakeup)(struct hid_device *hdev);
+
+	unsigned int max_buffer_size;
 };
 
 extern struct hid_ll_driver i2c_hid_ll_driver;
-- 
2.39.0.314.g84b9a713c41-goog

