Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68078677B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjAWMjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjAWMjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:39:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615B8E383;
        Mon, 23 Jan 2023 04:39:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F10C660EBA;
        Mon, 23 Jan 2023 12:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88658C433D2;
        Mon, 23 Jan 2023 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674477571;
        bh=s+8hHnAKl0gi0VZ8wv/8dNvLtUyZNn3XDnnpjynGmVo=;
        h=From:To:Cc:Subject:Date:From;
        b=qmrseFreLw/EdK/11ZPWq19bvD2AtPVI6dg2av1UzqzdoO982G2Pb+44tBCOIF9OR
         dcPar4I/PMeBxf36CtGr/5tK/srU8sp5nHZqx+9bHnKmcE1DlZYZf+p2WZgXMvdXhF
         M9UCKD94gy+yzQLr0pcjkgXXBqzga+F/osMz3tCqMSFfvnKCUvBX6QHpMNZjCTS0QV
         Ya69I1N3vmS9ZHgl8ixs83oF4RN04bHaMtC+i1OxqWzft4BWwiKuK4804LgU6rhk2y
         A8bVqpo4D3LT/SroRMJWRJxj+LQq8gD7zuIPodGisnHjoroKwbQEXyCLy4zYP8zl3b
         JdzjYGeQeWWng==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com,
        avid.rheinsberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v2 1/2] HID: core: Provide new max_buffer_size attribute to over-ride the default
Date:   Mon, 23 Jan 2023 12:39:11 +0000
Message-Id: <20230123123912.360651-1-lee@kernel.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
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

Presently, when a report is processed, its proposed size, provided by
the user of the API (as Report Size * Report Count) is compared against
the subsystem default HID_MAX_BUFFER_SIZE (16k).  However, some
low-level HID drivers allocate a reduced amount of memory to their
buffers (e.g. UHID only allocates UHID_DATA_MAX (4k) buffers), rending
this check inadequate in some cases.

In these circumstances, if the received report ends up being smaller
than the proposed report size, the remainder of the buffer is zeroed.
That is, the space between sizeof(csize) (size of the current report)
and the rsize (size proposed i.e. Report Size * Report Count), which can
be handled up to HID_MAX_BUFFER_SIZE (16k).  Meaning that memset()
shoots straight past the end of the buffer boundary and starts zeroing
out in-use values, often resulting in calamity.

This patch introduces a new variable into 'struct hid_ll_driver' where
individual low-level drivers can over-ride the default maximum value of
HID_MAX_BUFFER_SIZE (16k) with something more sympathetic to the
interface.

Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - Edit the commit message to be less focused on UHID
 
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
2.39.0.246.g2a6d74b583-goog

