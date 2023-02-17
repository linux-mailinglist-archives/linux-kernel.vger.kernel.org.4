Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7450C69B0A9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBQQUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjBQQUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:20:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95AA718E9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHHBVj1YcIn0KCl3Qd3GIK4smjO76vu9fFe/d1GedaA=;
        b=PUjbEtSzz3YCn45bOw0TH5msghPGQlpHXCzDqAKLw51uJtkOSdSkTbWkFzSDQEVBuFMr0c
        yPqH8gdbDvAKKSCBIMQy3P8SmD8tka+jL9UokPYbantg8TJnThSL1Yx9rBzzZGRgBzyyB2
        0mATJ+WuMN5A4NY1ki4tQX6KU6JihPc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-MZo6XbBbPi6zY7T_YRp5aw-1; Fri, 17 Feb 2023 11:18:57 -0500
X-MC-Unique: MZo6XbBbPi6zY7T_YRp5aw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC3063C21C25;
        Fri, 17 Feb 2023 16:18:56 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.193.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07AD8C15BA0;
        Fri, 17 Feb 2023 16:18:54 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 17 Feb 2023 17:18:01 +0100
Subject: [PATCH 07/11] selftests: hid: import hid-tools wacom tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-import-hid-tools-tests-v1-7-d1c48590d0ee@redhat.com>
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
In-Reply-To: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jason Gerecke <killertofu@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676650715; l=126277;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=mxLx8nClhVhwvjwcL3TwU8nIm85CP+kOrIySZMR2Mus=;
 b=xS50VwTYuHZjG3aOkPh0KC3bWeHbKFAv5BNrTa17HMlA3OyDkhKVooWMs0OKfHtSvPjSM0PIg
 V7CsrrA2SABAN9ljxMaZ7bXnzgLSiv486oZ6LW7Am5xIpG2pN4FJ7dC
X-Developer-Key: i=benjamin.tissoires@redhat.com; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These tests have been developed in the hid-tools[0] tree for a while.
Now that we have  a proper selftests/hid kernel entry and that the tests
are more reliable, it is time to directly include those in the kernel
tree.

[0] https://gitlab.freedesktop.org/libevdev/hid-tools

Cc: Jason Gerecke <killertofu@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/Makefile               |    1 +
 tools/testing/selftests/hid/config                 |    3 +
 tools/testing/selftests/hid/hid-wacom.sh           |    7 +
 .../selftests/hid/tests/descriptors_wacom.py       | 1360 ++++++++++++++++++++
 .../selftests/hid/tests/test_wacom_generic.py      |  844 ++++++++++++
 5 files changed, 2215 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index d8ad104c3863..4f11e865bbb3 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -11,6 +11,7 @@ TEST_PROGS += hid-keyboard.sh
 TEST_PROGS += hid-mouse.sh
 TEST_PROGS += hid-multitouch.sh
 TEST_PROGS += hid-tablet.sh
+TEST_PROGS += hid-wacom.sh
 
 CXX ?= $(CROSS_COMPILE)g++
 
diff --git a/tools/testing/selftests/hid/config b/tools/testing/selftests/hid/config
index 96ae99efcbaa..266fbd84ae9c 100644
--- a/tools/testing/selftests/hid/config
+++ b/tools/testing/selftests/hid/config
@@ -19,4 +19,7 @@ CONFIG_HIDRAW=y
 CONFIG_HID=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_UHID=y
+CONFIG_USB=y
+CONFIG_USB_HID=y
 CONFIG_HID_MULTITOUCH=y
+CONFIG_HID_WACOM=y
diff --git a/tools/testing/selftests/hid/hid-wacom.sh b/tools/testing/selftests/hid/hid-wacom.sh
new file mode 100755
index 000000000000..1630c22726d2
--- /dev/null
+++ b/tools/testing/selftests/hid/hid-wacom.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Runs tests for the HID subsystem
+
+export TARGET=test_wacom_generic.py
+
+bash ./run-hid-tools-tests.sh
diff --git a/tools/testing/selftests/hid/tests/descriptors_wacom.py b/tools/testing/selftests/hid/tests/descriptors_wacom.py
new file mode 100644
index 000000000000..91c16e005c12
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/descriptors_wacom.py
@@ -0,0 +1,1360 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# fmt: off
+wacom_pth660_v145 = [
+    0x05, 0x01,                     # . Usage Page (Desktop),
+    0x09, 0x02,                     # . Usage (Mouse),
+    0xA1, 0x01,                     # . Collection (Application),
+    0x85, 0x01,                     # .     Report ID (1),
+    0x09, 0x01,                     # .     Usage (Pointer),
+    0xA1, 0x00,                     # .     Collection (Physical),
+    0x05, 0x09,                     # .         Usage Page (Button),
+    0x19, 0x01,                     # .         Usage Minimum (01h),
+    0x29, 0x03,                     # .         Usage Maximum (03h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x01,                     # .         Report Size (1),
+    0x95, 0x03,                     # .         Report Count (3),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x75, 0x01,                     # .         Report Size (1),
+    0x95, 0x05,                     # .         Report Count (5),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0x05, 0x01,                     # .         Usage Page (Desktop),
+    0x09, 0x30,                     # .         Usage (X),
+    0x09, 0x31,                     # .         Usage (Y),
+    0x15, 0x81,                     # .         Logical Minimum (-127),
+    0x25, 0x7F,                     # .         Logical Maximum (127),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x02,                     # .         Report Count (2),
+    0x81, 0x06,                     # .         Input (Variable, Relative),
+    0xC0,                           # .     End Collection,
+    0xC0,                           # . End Collection,
+    0x06, 0x0D, 0xFF,               # . Usage Page (FF0Dh),
+    0x09, 0x01,                     # . Usage (01h),
+    0xA1, 0x01,                     # . Collection (Application),
+    0x85, 0x10,                     # .     Report ID (16),
+    0x09, 0x20,                     # .     Usage (20h),
+    0xA1, 0x00,                     # .     Collection (Physical),
+    0x09, 0x42,                     # .         Usage (42h),
+    0x09, 0x44,                     # .         Usage (44h),
+    0x09, 0x5A,                     # .         Usage (5Ah),
+    0x09, 0x45,                     # .         Usage (45h),
+    0x09, 0x3C,                     # .         Usage (3Ch),
+    0x09, 0x32,                     # .         Usage (32h),
+    0x09, 0x36,                     # .         Usage (36h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x01,                     # .         Report Size (1),
+    0x95, 0x07,                     # .         Report Count (7),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0x0A, 0x30, 0x01,               # .         Usage (0130h),
+    0x65, 0x11,                     # .         Unit (Centimeter),
+    0x55, 0x0D,                     # .         Unit Exponent (13),
+    0x35, 0x00,                     # .         Physical Minimum (0),
+    0x47, 0x80, 0x57, 0x00, 0x00,   # .         Physical Maximum (22400),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x27, 0x00, 0xAF, 0x00, 0x00,   # .         Logical Maximum (44800),
+    0x75, 0x18,                     # .         Report Size (24),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x0A, 0x31, 0x01,               # .         Usage (0131h),
+    0x47, 0xD0, 0x39, 0x00, 0x00,   # .         Physical Maximum (14800),
+    0x27, 0xA0, 0x73, 0x00, 0x00,   # .         Logical Maximum (29600),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x30,                     # .         Usage (30h),
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x65, 0x00,                     # .         Unit,
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x26, 0xFF, 0x1F,               # .         Logical Maximum (8191),         # !!! Errata: Missing Physical Max = 0
+    0x75, 0x10,                     # .         Report Size (16),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x3D,                     # .         Usage (3Dh),
+    0x09, 0x3E,                     # .         Usage (3Eh),
+    0x65, 0x14,                     # .         Unit (Degrees),
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x35, 0xC0,                     # .         Physical Minimum (-64),
+    0x45, 0x3F,                     # .         Physical Maximum (63),
+    0x15, 0xC0,                     # .         Logical Minimum (-64),
+    0x25, 0x3F,                     # .         Logical Maximum (63),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x02,                     # .         Report Count (2),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x41,                     # .         Usage (41h),
+    0x65, 0x14,                     # .         Unit (Degrees),
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x36, 0x4C, 0xFF,               # .         Physical Minimum (-180),
+    0x46, 0xB3, 0x00,               # .         Physical Maximum (179),
+    0x16, 0x7C, 0xFC,               # .         Logical Minimum (-900),
+    0x26, 0x83, 0x03,               # .         Logical Maximum (899),
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x0A,                     # .         Input (Variable, Wrap),
+    0x0A, 0x03, 0x0D,               # .         Usage (0D03h),
+    0x65, 0x00,                     # .         Unit,
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x26, 0xFF, 0x07,               # .         Logical Maximum (2047),         # !!! Errata: Missing Physical Min/Max = 0
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x0A, 0x32, 0x01,               # .         Usage (0132h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x3F,                     # .         Logical Maximum (63),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x5B,                     # .         Usage (5Bh),
+    0x09, 0x5C,                     # .         Usage (5Ch),
+    0x17, 0x00, 0x00, 0x00, 0x80,   # .         Logical Minimum (-2147483648),
+    0x27, 0xFF, 0xFF, 0xFF, 0x7F,   # .         Logical Maximum (2147483647),
+    0x75, 0x20,                     # .         Report Size (32),
+    0x95, 0x02,                     # .         Report Count (2),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x77,                     # .         Usage (77h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x26, 0xFF, 0x0F,               # .         Logical Maximum (4095),
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0xC0,                           # .     End Collection,
+    0x85, 0x11,                     # .     Report ID (17),
+    0x09, 0x39,                     # .     Usage (39h),
+    0xA1, 0x00,                     # .     Collection (Physical),
+    0x1A, 0x10, 0x09,               # .         Usage Minimum (0910h),
+    0x2A, 0x17, 0x09,               # .         Usage Maximum (0917h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x01,                     # .         Report Size (1),
+    0x95, 0x08,                     # .         Report Count (8),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x1A, 0x40, 0x09,               # .         Usage Minimum (0940h),
+    0x2A, 0x47, 0x09,               # .         Usage Maximum (0947h),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x0A, 0x95, 0x09,               # .         Usage (0995h),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x95, 0x07,                     # .         Report Count (7),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0x0A, 0x38, 0x01,               # .         Usage (0138h),
+    0x65, 0x14,                     # .         Unit (Degrees),
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x35, 0x00,                     # .         Physical Minimum (0),
+    0x46, 0x67, 0x01,               # .         Physical Maximum (359),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x47,                     # .         Logical Maximum (71),
+    0x75, 0x07,                     # .         Report Size (7),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x0A,                     # .         Input (Variable, Wrap),
+    0x0A, 0x39, 0x01,               # .         Usage (0139h),
+    0x65, 0x00,                     # .         Unit,
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),            # !!! Errata: Missing Physical Max = 0
+    0x75, 0x01,                     # .         Report Size (1),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x04,                     # .         Report Count (4),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0xC0,                           # .     End Collection,
+    0x85, 0x13,                     # .     Report ID (19),
+    0x0A, 0x13, 0x10,               # .     Usage (1013h),
+    0xA1, 0x00,                     # .     Collection (Physical),
+    0x0A, 0x3B, 0x04,               # .         Usage (043Bh),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x64,                     # .         Logical Maximum (100),
+    0x75, 0x07,                     # .         Report Size (7),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x0A, 0x04, 0x04,               # .         Usage (0404h),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x01,                     # .         Report Size (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x0A, 0x52, 0x04,               # .         Usage (0452h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x01,                     # .         Report Size (1),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x95, 0x06,                     # .         Report Count (6),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0x0A, 0x54, 0x04,               # .         Usage (0454h),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x06,                     # .         Report Count (6),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0xC0,                           # .     End Collection,
+    0x09, 0x0E,                     # .     Usage (0Eh),
+    0xA1, 0x02,                     # .     Collection (Logical),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x85, 0x02,                     # .         Report ID (2),
+    0x09, 0x01,                     # .         Usage (01h),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x03,                     # .         Report ID (3),
+    0x0A, 0x03, 0x10,               # .         Usage (1003h),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x04,                     # .         Report ID (4),
+    0x0A, 0x04, 0x10,               # .         Usage (1004h),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x07,                     # .         Report ID (7),
+    0x0A, 0x09, 0x10,               # .         Usage (1009h),
+    0x25, 0x02,                     # .         Logical Maximum (2),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x03,                     # .         Feature (Constant, Variable),
+    0x0A, 0x07, 0x10,               # .         Usage (1007h),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x0A, 0x08, 0x10,               # .         Usage (1008h),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x27, 0xFF, 0xFF, 0x00, 0x00,   # .         Logical Maximum (65535),
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x06,                     # .         Report Count (6),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x03,                     # .         Feature (Constant, Variable),
+    0x85, 0x0C,                     # .         Report ID (12),
+    0x0A, 0x30, 0x0D,               # .         Usage (0D30h),
+    0x0A, 0x31, 0x0D,               # .         Usage (0D31h),
+    0x0A, 0x32, 0x0D,               # .         Usage (0D32h),
+    0x0A, 0x33, 0x0D,               # .         Usage (0D33h),                  # !!! Errata: Missing Non-zero Physical Max
+    0x65, 0x11,                     # .         Unit (Centimeter),
+    0x55, 0x0D,                     # .         Unit Exponent (13),
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x04,                     # .         Report Count (4),
+    0xB1, 0x03,                     # .         Feature (Constant, Variable),
+    0x85, 0x0D,                     # .         Report ID (13),
+    0x65, 0x00,                     # .         Unit,
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x0A, 0x0D, 0x10,               # .         Usage (100Dh),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x14,                     # .         Report ID (20),
+    0x0A, 0x14, 0x10,               # .         Usage (1014h),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x95, 0x0D,                     # .         Report Count (13),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x31,                     # .         Report ID (49),
+    0x0A, 0x31, 0x10,               # .         Usage (1031h),
+    0x25, 0x64,                     # .         Logical Maximum (100),
+    0x95, 0x05,                     # .         Report Count (5),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x32,                     # .         Report ID (50),
+    0x0A, 0x31, 0x10,               # .         Usage (1031h),
+    0x25, 0x64,                     # .         Logical Maximum (100),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x0A, 0x32, 0x10,               # .         Usage (1032h),
+    0x25, 0x03,                     # .         Logical Maximum (3),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x34,                     # .         Report ID (52),
+    0x0A, 0x34, 0x10,               # .         Usage (1034h),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x95, 0x04,                     # .         Report Count (4),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x35,                     # .         Report ID (53),
+    0x0A, 0x35, 0x10,               # .         Usage (1035h),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x95, 0x0A,                     # .         Report Count (10),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x36,                     # .         Report ID (54),
+    0x0A, 0x35, 0x10,               # .         Usage (1035h),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x96, 0x01, 0x01,               # .         Report Count (257),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0xCC,                     # .         Report ID (204),
+    0x0A, 0xCC, 0x10,               # .         Usage (10CCh),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x95, 0x02,                     # .         Report Count (2),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0xC0,                           # .     End Collection,
+    0x0A, 0xAC, 0x10,               # .     Usage (10ACh),
+    0xA1, 0x02,                     # .     Collection (Logical),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x85, 0xAC,                     # .         Report ID (172),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0xBF,                     # .         Report Count (191),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x85, 0x33,                     # .         Report ID (51),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x12,                     # .         Report Count (18),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x64,                     # .         Report ID (100),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x0C,                     # .         Report Count (12),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x15,                     # .         Report ID (21),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x0E,                     # .         Report Count (14),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x12,                     # .         Report ID (18),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x04,                     # .         Report Count (4),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x16,                     # .         Report ID (22),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x0E,                     # .         Report Count (14),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x40,                     # .         Report ID (64),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x41,                     # .         Report ID (65),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x42,                     # .         Report ID (66),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x04,                     # .         Report Count (4),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x43,                     # .         Report ID (67),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x0D,                     # .         Report Count (13),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x44,                     # .         Report ID (68),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x3F,                     # .         Report Count (63),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x45,                     # .         Report ID (69),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x20,                     # .         Report Count (32),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x60,                     # .         Report ID (96),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x3F,                     # .         Report Count (63),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x61,                     # .         Report ID (97),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x3E,                     # .         Report Count (62),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x62,                     # .         Report ID (98),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x3E,                     # .         Report Count (62),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0xC0,                           # .     End Collection,
+    0x85, 0xD0,                     # .     Report ID (208),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x08, 0x00,               # .     Report Count (8),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD1,                     # .     Report ID (209),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x01,               # .     Report Count (260),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD2,                     # .     Report ID (210),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x01,               # .     Report Count (260),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD3,                     # .     Report ID (211),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD4,                     # .     Report ID (212),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD5,                     # .     Report ID (213),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD6,                     # .     Report ID (214),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD7,                     # .     Report ID (215),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x08, 0x00,               # .     Report Count (8),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD8,                     # .     Report ID (216),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x0C, 0x00,               # .     Report Count (12),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD9,                     # .     Report ID (217),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x00, 0x0A,               # .     Report Count (2560),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDA,                     # .     Report ID (218),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x04,               # .     Report Count (1028),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDB,                     # .     Report ID (219),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x06, 0x00,               # .     Report Count (6),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDC,                     # .     Report ID (220),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x02, 0x00,               # .     Report Count (2),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDD,                     # .     Report ID (221),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDE,                     # .     Report ID (222),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDF,                     # .     Report ID (223),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x22, 0x00,               # .     Report Count (34),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE0,                     # .     Report ID (224),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x01, 0x00,               # .     Report Count (1),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE1,                     # .     Report ID (225),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x02, 0x00,               # .     Report Count (2),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE2,                     # .     Report ID (226),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x02, 0x00,               # .     Report Count (2),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE3,                     # .     Report ID (227),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x02, 0x00,               # .     Report Count (2),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE4,                     # .     Report ID (228),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0xFF, 0x01,               # .     Report Count (511),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0xC0                            # . End Collection
+]
+# fmt: on
+
+# Report ID (20), Usage (1014h), Report Count (13) -> 15
+wacom_pth660_v150 = wacom_pth660_v145.copy()
+wacom_pth660_v150[0x2CB] = 0x0F
+
+# fmt: off
+wacom_pth860_v145 = [
+    0x05, 0x01,                     # . Usage Page (Desktop),
+    0x09, 0x02,                     # . Usage (Mouse),
+    0xA1, 0x01,                     # . Collection (Application),
+    0x85, 0x01,                     # .     Report ID (1),
+    0x09, 0x01,                     # .     Usage (Pointer),
+    0xA1, 0x00,                     # .     Collection (Physical),
+    0x05, 0x09,                     # .         Usage Page (Button),
+    0x19, 0x01,                     # .         Usage Minimum (01h),
+    0x29, 0x03,                     # .         Usage Maximum (03h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x01,                     # .         Report Size (1),
+    0x95, 0x03,                     # .         Report Count (3),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x95, 0x05,                     # .         Report Count (5),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0x05, 0x01,                     # .         Usage Page (Desktop),
+    0x09, 0x30,                     # .         Usage (X),
+    0x09, 0x31,                     # .         Usage (Y),
+    0x15, 0x80,                     # .         Logical Minimum (-128),
+    0x25, 0x7F,                     # .         Logical Maximum (127),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x02,                     # .         Report Count (2),
+    0x81, 0x06,                     # .         Input (Variable, Relative),
+    0xC0,                           # .     End Collection,
+    0xC0,                           # . End Collection,
+    0x06, 0x0D, 0xFF,               # . Usage Page (FF0Dh),
+    0x09, 0x01,                     # . Usage (01h),
+    0xA1, 0x01,                     # . Collection (Application),
+    0x85, 0x10,                     # .     Report ID (16),
+    0x09, 0x20,                     # .     Usage (20h),
+    0xA1, 0x00,                     # .     Collection (Physical),
+    0x09, 0x42,                     # .         Usage (42h),
+    0x09, 0x44,                     # .         Usage (44h),
+    0x09, 0x5A,                     # .         Usage (5Ah),
+    0x09, 0x45,                     # .         Usage (45h),
+    0x09, 0x3C,                     # .         Usage (3Ch),
+    0x09, 0x32,                     # .         Usage (32h),
+    0x09, 0x36,                     # .         Usage (36h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x01,                     # .         Report Size (1),
+    0x95, 0x07,                     # .         Report Count (7),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0x0A, 0x30, 0x01,               # .         Usage (0130h),
+    0x65, 0x11,                     # .         Unit (Centimeter),
+    0x55, 0x0D,                     # .         Unit Exponent (13),
+    0x35, 0x00,                     # .         Physical Minimum (0),
+    0x47, 0x7C, 0x79, 0x00, 0x00,   # .         Physical Maximum (31100),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x27, 0xF8, 0xF2, 0x00, 0x00,   # .         Logical Maximum (62200),
+    0x75, 0x18,                     # .         Report Size (24),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x0A, 0x31, 0x01,               # .         Usage (0131h),
+    0x47, 0x60, 0x54, 0x00, 0x00,   # .         Physical Maximum (21600),
+    0x27, 0xC0, 0xA8, 0x00, 0x00,   # .         Logical Maximum (43200),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x30,                     # .         Usage (30h),                    # !!! Errata: Missing Physical Max = 0
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x65, 0x00,                     # .         Unit,
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x26, 0xFF, 0x1F,               # .         Logical Maximum (8191),
+    0x75, 0x10,                     # .         Report Size (16),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x3D,                     # .         Usage (3Dh),
+    0x09, 0x3E,                     # .         Usage (3Eh),
+    0x65, 0x14,                     # .         Unit (Degrees),
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x35, 0xC0,                     # .         Physical Minimum (-64),
+    0x45, 0x3F,                     # .         Physical Maximum (63),
+    0x15, 0xC0,                     # .         Logical Minimum (-64),
+    0x25, 0x3F,                     # .         Logical Maximum (63),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x02,                     # .         Report Count (2),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x41,                     # .         Usage (41h),
+    0x65, 0x14,                     # .         Unit (Degrees),
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x36, 0x4C, 0xFF,               # .         Physical Minimum (-180),
+    0x46, 0xB3, 0x00,               # .         Physical Maximum (179),
+    0x16, 0x7C, 0xFC,               # .         Logical Minimum (-900),
+    0x26, 0x83, 0x03,               # .         Logical Maximum (899),
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x0A,                     # .         Input (Variable, Wrap),
+    0x0A, 0x03, 0x0D,               # .         Usage (0D03h),
+    0x65, 0x00,                     # .         Unit,
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x26, 0xFF, 0x07,               # .         Logical Maximum (2047),         # !!! Errata: Missing Physical Min/Max = 0
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x0A, 0x32, 0x01,               # .         Usage (0132h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x3F,                     # .         Logical Maximum (63),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x5B,                     # .         Usage (5Bh),
+    0x09, 0x5C,                     # .         Usage (5Ch),
+    0x17, 0x00, 0x00, 0x00, 0x80,   # .         Logical Minimum (-2147483648),
+    0x27, 0xFF, 0xFF, 0xFF, 0x7F,   # .         Logical Maximum (2147483647),
+    0x75, 0x20,                     # .         Report Size (32),
+    0x95, 0x02,                     # .         Report Count (2),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x77,                     # .         Usage (77h),
+    0x16, 0x00, 0x00,               # .         Logical Minimum (0),
+    0x26, 0xFF, 0x0F,               # .         Logical Maximum (4095),
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0xC0,                           # .     End Collection,
+    0x85, 0x11,                     # .     Report ID (17),
+    0x09, 0x39,                     # .     Usage (39h),
+    0xA1, 0x00,                     # .     Collection (Physical),
+    0x1A, 0x10, 0x09,               # .         Usage Minimum (0910h),
+    0x2A, 0x17, 0x09,               # .         Usage Maximum (0917h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x01,                     # .         Report Size (1),
+    0x95, 0x08,                     # .         Report Count (8),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x1A, 0x40, 0x09,               # .         Usage Minimum (0940h),
+    0x2A, 0x47, 0x09,               # .         Usage Maximum (0947h),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x0A, 0x95, 0x09,               # .         Usage (0995h),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x95, 0x07,                     # .         Report Count (7),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0x0A, 0x38, 0x01,               # .         Usage (0138h),
+    0x65, 0x14,                     # .         Unit (Degrees),
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x35, 0x00,                     # .         Physical Minimum (0),
+    0x46, 0x67, 0x01,               # .         Physical Maximum (359),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x47,                     # .         Logical Maximum (71),
+    0x75, 0x07,                     # .         Report Size (7),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x0A,                     # .         Input (Variable, Wrap),
+    0x0A, 0x39, 0x01,               # .         Usage (0139h),
+    0x65, 0x00,                     # .         Unit,
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),            # !!! Errata: Missing Physical Max = 0
+    0x75, 0x01,                     # .         Report Size (1),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x04,                     # .         Report Count (4),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0xC0,                           # .     End Collection,
+    0x85, 0x13,                     # .     Report ID (19),
+    0x0A, 0x13, 0x10,               # .     Usage (1013h),
+    0xA1, 0x00,                     # .     Collection (Physical),
+    0x0A, 0x3B, 0x04,               # .         Usage (043Bh),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x64,                     # .         Logical Maximum (100),
+    0x75, 0x07,                     # .         Report Size (7),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x0A, 0x04, 0x04,               # .         Usage (0404h),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x01,                     # .         Report Size (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x0A, 0x52, 0x04,               # .         Usage (0452h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x01,                     # .         Report Size (1),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x95, 0x06,                     # .         Report Count (6),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0x0A, 0x54, 0x04,               # .         Usage (0454h),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x06,                     # .         Report Count (6),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0xC0,                           # .     End Collection,
+    0x09, 0x0E,                     # .     Usage (0Eh),
+    0xA1, 0x02,                     # .     Collection (Logical),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x85, 0x02,                     # .         Report ID (2),
+    0x09, 0x01,                     # .         Usage (01h),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x03,                     # .         Report ID (3),
+    0x0A, 0x03, 0x10,               # .         Usage (1003h),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x04,                     # .         Report ID (4),
+    0x0A, 0x04, 0x10,               # .         Usage (1004h),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x07,                     # .         Report ID (7),
+    0x0A, 0x09, 0x10,               # .         Usage (1009h),
+    0x25, 0x02,                     # .         Logical Maximum (2),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x03,                     # .         Feature (Constant, Variable),
+    0x0A, 0x07, 0x10,               # .         Usage (1007h),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x0A, 0x08, 0x10,               # .         Usage (1008h),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x27, 0xFF, 0xFF, 0x00, 0x00,   # .         Logical Maximum (65535),
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x06,                     # .         Report Count (6),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x03,                     # .         Feature (Constant, Variable),
+    0x85, 0x0C,                     # .         Report ID (12),
+    0x0A, 0x30, 0x0D,               # .         Usage (0D30h),
+    0x0A, 0x31, 0x0D,               # .         Usage (0D31h),
+    0x0A, 0x32, 0x0D,               # .         Usage (0D32h),
+    0x0A, 0x33, 0x0D,               # .         Usage (0D33h),                  # !!! Errata: Missing Non-zero Physical Max
+    0x65, 0x11,                     # .         Unit (Centimeter),
+    0x55, 0x0D,                     # .         Unit Exponent (13),
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x04,                     # .         Report Count (4),
+    0xB1, 0x03,                     # .         Feature (Constant, Variable),
+    0x85, 0x0D,                     # .         Report ID (13),
+    0x65, 0x00,                     # .         Unit,
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x0A, 0x0D, 0x10,               # .         Usage (100Dh),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x14,                     # .         Report ID (20),
+    0x0A, 0x14, 0x10,               # .         Usage (1014h),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x95, 0x0D,                     # .         Report Count (13),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x31,                     # .         Report ID (49),
+    0x0A, 0x31, 0x10,               # .         Usage (1031h),
+    0x25, 0x64,                     # .         Logical Maximum (100),
+    0x95, 0x05,                     # .         Report Count (5),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x32,                     # .         Report ID (50),
+    0x0A, 0x31, 0x10,               # .         Usage (1031h),
+    0x25, 0x64,                     # .         Logical Maximum (100),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x0A, 0x32, 0x10,               # .         Usage (1032h),
+    0x25, 0x03,                     # .         Logical Maximum (3),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x34,                     # .         Report ID (52),
+    0x0A, 0x34, 0x10,               # .         Usage (1034h),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x95, 0x04,                     # .         Report Count (4),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x35,                     # .         Report ID (53),
+    0x0A, 0x35, 0x10,               # .         Usage (1035h),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x95, 0x0A,                     # .         Report Count (10),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x36,                     # .         Report ID (54),
+    0x0A, 0x35, 0x10,               # .         Usage (1035h),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x96, 0x01, 0x01,               # .         Report Count (257),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0xCC,                     # .         Report ID (204),
+    0x0A, 0xCC, 0x10,               # .         Usage (10CCh),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x95, 0x02,                     # .         Report Count (2),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0xC0,                           # .     End Collection,
+    0x0A, 0xAC, 0x10,               # .     Usage (10ACh),
+    0xA1, 0x02,                     # .     Collection (Logical),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x85, 0xAC,                     # .         Report ID (172),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0xBF,                     # .         Report Count (191),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x85, 0x33,                     # .         Report ID (51),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x12,                     # .         Report Count (18),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x64,                     # .         Report ID (100),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x0C,                     # .         Report Count (12),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x15,                     # .         Report ID (21),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x0E,                     # .         Report Count (14),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x12,                     # .         Report ID (18),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x04,                     # .         Report Count (4),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x16,                     # .         Report ID (22),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x0E,                     # .         Report Count (14),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x40,                     # .         Report ID (64),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x41,                     # .         Report ID (65),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x42,                     # .         Report ID (66),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x04,                     # .         Report Count (4),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x43,                     # .         Report ID (67),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x0D,                     # .         Report Count (13),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x44,                     # .         Report ID (68),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x3F,                     # .         Report Count (63),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x45,                     # .         Report ID (69),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x20,                     # .         Report Count (32),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x60,                     # .         Report ID (96),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x3F,                     # .         Report Count (63),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x61,                     # .         Report ID (97),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x3E,                     # .         Report Count (62),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x62,                     # .         Report ID (98),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x3E,                     # .         Report Count (62),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0xC0,                           # .     End Collection,
+    0x85, 0xD0,                     # .     Report ID (208),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x08, 0x00,               # .     Report Count (8),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD1,                     # .     Report ID (209),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x01,               # .     Report Count (260),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD2,                     # .     Report ID (210),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x01,               # .     Report Count (260),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD3,                     # .     Report ID (211),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD4,                     # .     Report ID (212),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD5,                     # .     Report ID (213),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD6,                     # .     Report ID (214),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD7,                     # .     Report ID (215),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x08, 0x00,               # .     Report Count (8),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD8,                     # .     Report ID (216),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x0C, 0x00,               # .     Report Count (12),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD9,                     # .     Report ID (217),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x00, 0x0A,               # .     Report Count (2560),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDA,                     # .     Report ID (218),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x04,               # .     Report Count (1028),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDB,                     # .     Report ID (219),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x06, 0x00,               # .     Report Count (6),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDC,                     # .     Report ID (220),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x02, 0x00,               # .     Report Count (2),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDD,                     # .     Report ID (221),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDE,                     # .     Report ID (222),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDF,                     # .     Report ID (223),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x22, 0x00,               # .     Report Count (34),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE0,                     # .     Report ID (224),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x01, 0x00,               # .     Report Count (1),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE1,                     # .     Report ID (225),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x02, 0x00,               # .     Report Count (2),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE2,                     # .     Report ID (226),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x02, 0x00,               # .     Report Count (2),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE3,                     # .     Report ID (227),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x02, 0x00,               # .     Report Count (2),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE4,                     # .     Report ID (228),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0xFF, 0x01,               # .     Report Count (511),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0xC0                            # . End Collection
+]
+# fmt: on
+
+# Report ID (20), Usage (1014h), Report Count (13) -> 15
+wacom_pth860_v150 = wacom_pth860_v145.copy()
+wacom_pth860_v150[0x2CA] = 0x0F
+
+# fmt: off
+wacom_pth460_v105 = [
+    0x06, 0x0D, 0xFF,               # . Usage Page (FF0Dh),
+    0x09, 0x01,                     # . Usage (01h),
+    0xA1, 0x01,                     # . Collection (Application),
+    0x85, 0x10,                     # .     Report ID (16),
+    0x09, 0x20,                     # .     Usage (20h),
+    0x35, 0x00,                     # .     Physical Minimum (0),
+    0x45, 0x00,                     # .     Physical Maximum (0),
+    0x15, 0x00,                     # .     Logical Minimum (0),
+    0x25, 0x01,                     # .     Logical Maximum (1),
+    0xA1, 0x00,                     # .     Collection (Physical),
+    0x09, 0x42,                     # .         Usage (42h),
+    0x09, 0x44,                     # .         Usage (44h),
+    0x09, 0x5A,                     # .         Usage (5Ah),
+    0x09, 0x45,                     # .         Usage (45h),
+    0x09, 0x3C,                     # .         Usage (3Ch),
+    0x09, 0x32,                     # .         Usage (32h),
+    0x09, 0x36,                     # .         Usage (36h),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x01,                     # .         Report Size (1),
+    0x95, 0x07,                     # .         Report Count (7),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0x0A, 0x30, 0x01,               # .         Usage (0130h),
+    0x65, 0x11,                     # .         Unit (Centimeter),
+    0x55, 0x0D,                     # .         Unit Exponent (13),
+    0x47, 0x58, 0x3E, 0x00, 0x00,   # .         Physical Maximum (15960),
+    0x27, 0xB0, 0x7C, 0x00, 0x00,   # .         Logical Maximum (31920),
+    0x75, 0x18,                     # .         Report Size (24),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x0A, 0x31, 0x01,               # .         Usage (0131h),
+    0x47, 0xF7, 0x26, 0x00, 0x00,   # .         Physical Maximum (9975),
+    0x27, 0xEE, 0x4D, 0x00, 0x00,   # .         Logical Maximum (19950),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x30,                     # .         Usage (30h),
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x65, 0x00,                     # .         Unit,
+    0x26, 0xFF, 0x1F,               # .         Logical Maximum (8191),         # !!! Errata: Missing Physical Max = 0
+    0x75, 0x10,                     # .         Report Size (16),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x3D,                     # .         Usage (3Dh),
+    0x09, 0x3E,                     # .         Usage (3Eh),
+    0x65, 0x14,                     # .         Unit (Degrees),
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x35, 0xC0,                     # .         Physical Minimum (-64),
+    0x45, 0x3F,                     # .         Physical Maximum (63),
+    0x15, 0xC0,                     # .         Logical Minimum (-64),
+    0x25, 0x3F,                     # .         Logical Maximum (63),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x02,                     # .         Report Count (2),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x41,                     # .         Usage (41h),
+    0x65, 0x14,                     # .         Unit (Degrees),
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x36, 0x4C, 0xFF,               # .         Physical Minimum (-180),
+    0x46, 0xB3, 0x00,               # .         Physical Maximum (179),
+    0x16, 0x7C, 0xFC,               # .         Logical Minimum (-900),
+    0x26, 0x83, 0x03,               # .         Logical Maximum (899),
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x0A,                     # .         Input (Variable, Wrap),
+    0x0A, 0x03, 0x0D,               # .         Usage (0D03h),
+    0x65, 0x00,                     # .         Unit,
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x35, 0x00,                     # .         Physical Minimum (0),
+    0x45, 0x00,                     # .         Physical Maximum (0),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x26, 0xFF, 0x07,               # .         Logical Maximum (2047),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x0A, 0x32, 0x01,               # .         Usage (0132h),
+    0x25, 0x3F,                     # .         Logical Maximum (63),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x5B,                     # .         Usage (5Bh),
+    0x09, 0x5C,                     # .         Usage (5Ch),
+    0x17, 0x00, 0x00, 0x00, 0x80,   # .         Logical Minimum (-2147483648),
+    0x27, 0xFF, 0xFF, 0xFF, 0x7F,   # .         Logical Maximum (2147483647),
+    0x75, 0x20,                     # .         Report Size (32),
+    0x95, 0x02,                     # .         Report Count (2),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x09, 0x77,                     # .         Usage (77h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x26, 0xFF, 0x0F,               # .         Logical Maximum (4095),
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x02,                     # .         Input (Variable),
+    0xC0,                           # .     End Collection,
+    0x85, 0x11,                     # .     Report ID (17),
+    0x65, 0x00,                     # .     Unit,
+    0x55, 0x00,                     # .     Unit Exponent (0),
+    0x35, 0x00,                     # .     Physical Minimum (0),
+    0x45, 0x00,                     # .     Physical Maximum (0),
+    0x09, 0x39,                     # .     Usage (39h),
+    0xA1, 0x00,                     # .     Collection (Physical),
+    0x09, 0x39,                     # .         Usage (39h),
+    0xA1, 0x00,                     # .         Collection (Physical),
+    0x35, 0x00,                     # .             Physical Minimum (0),
+    0x45, 0x00,                     # .             Physical Maximum (0),
+    0x15, 0x00,                     # .             Logical Minimum (0),
+    0x1A, 0x10, 0x09,               # .             Usage Minimum (0910h),
+    0x2A, 0x15, 0x09,               # .             Usage Maximum (0915h),
+    0x15, 0x00,                     # .             Logical Minimum (0),
+    0x25, 0x01,                     # .             Logical Maximum (1),
+    0x75, 0x01,                     # .             Report Size (1),
+    0x95, 0x06,                     # .             Report Count (6),
+    0x81, 0x02,                     # .             Input (Variable),
+    0x95, 0x02,                     # .             Report Count (2),
+    0x81, 0x03,                     # .             Input (Constant, Variable),
+    0xC0,                           # .         End Collection,
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x01,                     # .         Report Count (1),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0x09, 0x39,                     # .         Usage (39h),
+    0xA1, 0x00,                     # .         Collection (Physical),
+    0x35, 0x00,                     # .             Physical Minimum (0),
+    0x45, 0x00,                     # .             Physical Maximum (0),
+    0x0A, 0x95, 0x09,               # .             Usage (0995h),
+    0x15, 0x00,                     # .             Logical Minimum (0),
+    0x25, 0x01,                     # .             Logical Maximum (1),
+    0x75, 0x01,                     # .             Report Size (1),
+    0x95, 0x01,                     # .             Report Count (1),
+    0x81, 0x02,                     # .             Input (Variable),
+    0x95, 0x07,                     # .             Report Count (7),
+    0x81, 0x03,                     # .             Input (Constant, Variable),
+    0xC0,                           # .         End Collection,
+    0x09, 0x39,                     # .         Usage (39h),
+    0xA1, 0x00,                     # .         Collection (Physical),
+    0x35, 0x00,                     # .             Physical Minimum (0),
+    0x15, 0x00,                     # .             Logical Minimum (0),
+    0x0A, 0x38, 0x01,               # .             Usage (0138h),
+    0x65, 0x14,                     # .             Unit (Degrees),
+    0x55, 0x00,                     # .             Unit Exponent (0),
+    0x35, 0x00,                     # .             Physical Minimum (0),
+    0x46, 0x67, 0x01,               # .             Physical Maximum (359),
+    0x15, 0x00,                     # .             Logical Minimum (0),
+    0x25, 0x47,                     # .             Logical Maximum (71),
+    0x75, 0x07,                     # .             Report Size (7),
+    0x95, 0x01,                     # .             Report Count (1),
+    0x81, 0x4A,                     # .             Input (Variable, Wrap, Null State),
+    0x0A, 0x39, 0x01,               # .             Usage (0139h),
+    0x65, 0x00,                     # .             Unit,
+    0x55, 0x00,                     # .             Unit Exponent (0),
+    0x45, 0x00,                     # .             Physical Maximum (0),
+    0x25, 0x01,                     # .             Logical Maximum (1),
+    0x75, 0x01,                     # .             Report Size (1),
+    0x95, 0x01,                     # .             Report Count (1),
+    0x81, 0x02,                     # .             Input (Variable),
+    0xC0,                           # .         End Collection,
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x04,                     # .         Report Count (4),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0xC0,                           # .     End Collection,
+    0x85, 0x13,                     # .     Report ID (19),
+    0x65, 0x00,                     # .     Unit,
+    0x55, 0x00,                     # .     Unit Exponent (0),
+    0x35, 0x00,                     # .     Physical Minimum (0),
+    0x45, 0x00,                     # .     Physical Maximum (0),
+    0x0A, 0x13, 0x10,               # .     Usage (1013h),
+    0xA1, 0x00,                     # .     Collection (Physical),
+    0x0A, 0x13, 0x10,               # .         Usage (1013h),
+    0xA1, 0x00,                     # .         Collection (Physical),
+    0x35, 0x00,                     # .             Physical Minimum (0),
+    0x45, 0x00,                     # .             Physical Maximum (0),
+    0x15, 0x00,                     # .             Logical Minimum (0),
+    0x0A, 0x3B, 0x04,               # .             Usage (043Bh),
+    0x15, 0x00,                     # .             Logical Minimum (0),
+    0x25, 0x64,                     # .             Logical Maximum (100),
+    0x75, 0x07,                     # .             Report Size (7),
+    0x95, 0x01,                     # .             Report Count (1),
+    0x81, 0x02,                     # .             Input (Variable),
+    0x0A, 0x04, 0x04,               # .             Usage (0404h),
+    0x25, 0x01,                     # .             Logical Maximum (1),
+    0x75, 0x01,                     # .             Report Size (1),
+    0x81, 0x02,                     # .             Input (Variable),
+    0xC0,                           # .         End Collection,
+    0x0A, 0x13, 0x10,               # .         Usage (1013h),
+    0xA1, 0x00,                     # .         Collection (Physical),
+    0x35, 0x00,                     # .             Physical Minimum (0),
+    0x45, 0x00,                     # .             Physical Maximum (0),
+    0x0A, 0x52, 0x04,               # .             Usage (0452h),
+    0x15, 0x00,                     # .             Logical Minimum (0),
+    0x25, 0x01,                     # .             Logical Maximum (1),
+    0x75, 0x01,                     # .             Report Size (1),
+    0x95, 0x01,                     # .             Report Count (1),
+    0x81, 0x02,                     # .             Input (Variable),
+    0x0A, 0x41, 0x04,               # .             Usage (0441h),
+    0x15, 0x00,                     # .             Logical Minimum (0),
+    0x25, 0x07,                     # .             Logical Maximum (7),
+    0x75, 0x03,                     # .             Report Size (3),
+    0x95, 0x02,                     # .             Report Count (2),
+    0x81, 0x02,                     # .             Input (Variable),
+    0x0A, 0x54, 0x04,               # .             Usage (0454h),
+    0x15, 0x00,                     # .             Logical Minimum (0),
+    0x25, 0x01,                     # .             Logical Maximum (1),
+    0x75, 0x01,                     # .             Report Size (1),
+    0x95, 0x01,                     # .             Report Count (1),
+    0x81, 0x02,                     # .             Input (Variable),
+    0xC0,                           # .         End Collection,
+    0x0A, 0x13, 0x10,               # .         Usage (1013h),
+    0xA1, 0x00,                     # .         Collection (Physical),
+    0x35, 0x00,                     # .             Physical Minimum (0),
+    0x45, 0x00,                     # .             Physical Maximum (0),
+    0x15, 0x00,                     # .             Logical Minimum (0),
+    0x0A, 0x3C, 0x04,               # .             Usage (043Ch),
+    0x55, 0x00,                     # .             Unit Exponent (0),
+    0x65, 0x00,                     # .             Unit,
+    0x15, 0xFB,                     # .             Logical Minimum (-5),
+    0x25, 0x32,                     # .             Logical Maximum (50),
+    0x75, 0x08,                     # .             Report Size (8),
+    0x95, 0x01,                     # .             Report Count (1),
+    0x81, 0x02,                     # .             Input (Variable),
+    0xC0,                           # .         End Collection,
+    0x0A, 0x13, 0x10,               # .         Usage (1013h),
+    0xA1, 0x00,                     # .         Collection (Physical),
+    0x35, 0x00,                     # .             Physical Minimum (0),
+    0x45, 0x00,                     # .             Physical Maximum (0),
+    0x15, 0x00,                     # .             Logical Minimum (0),
+    0x0A, 0x3D, 0x04,               # .             Usage (043Dh),
+    0x55, 0x00,                     # .             Unit Exponent (0),
+    0x65, 0x00,                     # .             Unit,
+    0x15, 0x00,                     # .             Logical Minimum (0),
+    0x26, 0xFF, 0x0F,               # .             Logical Maximum (4095),
+    0x75, 0x10,                     # .             Report Size (16),
+    0x95, 0x01,                     # .             Report Count (1),
+    0x81, 0x02,                     # .             Input (Variable),
+    0xC0,                           # .         End Collection,
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x03,                     # .         Report Count (3),
+    0x81, 0x03,                     # .         Input (Constant, Variable),
+    0xC0,                           # .     End Collection,
+    0x09, 0x0E,                     # .     Usage (0Eh),
+    0xA1, 0x02,                     # .     Collection (Logical),
+    0x85, 0x02,                     # .         Report ID (2),
+    0x0A, 0x02, 0x10,               # .         Usage (1002h),
+    0x15, 0x02,                     # .         Logical Minimum (2),
+    0x25, 0x02,                     # .         Logical Maximum (2),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x03,                     # .         Report ID (3),
+    0x0A, 0x03, 0x10,               # .         Usage (1003h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x04,                     # .         Report ID (4),
+    0x0A, 0x04, 0x10,               # .         Usage (1004h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x07,                     # .         Report ID (7),
+    0x0A, 0x09, 0x10,               # .         Usage (1009h),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0xB1, 0x03,                     # .         Feature (Constant, Variable),
+    0x0A, 0x07, 0x10,               # .         Usage (1007h),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x0A, 0x08, 0x10,               # .         Usage (1008h),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x27, 0xFF, 0xFF, 0x00, 0x00,   # .         Logical Maximum (65535),
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x06,                     # .         Report Count (6),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x25, 0x00,                     # .         Logical Maximum (0),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x03,                     # .         Feature (Constant, Variable),
+    0x85, 0x0C,                     # .         Report ID (12),
+    0x0A, 0x30, 0x0D,               # .         Usage (0D30h),
+    0x0A, 0x31, 0x0D,               # .         Usage (0D31h),
+    0x0A, 0x32, 0x0D,               # .         Usage (0D32h),
+    0x0A, 0x33, 0x0D,               # .         Usage (0D33h),
+    0x65, 0x11,                     # .         Unit (Centimeter),
+    0x55, 0x0D,                     # .         Unit Exponent (13),
+    0x35, 0x00,                     # .         Physical Minimum (0),
+    0x46, 0xC8, 0x00,               # .         Physical Maximum (200),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x26, 0x90, 0x01,               # .         Logical Maximum (400),
+    0x75, 0x10,                     # .         Report Size (16),
+    0x95, 0x04,                     # .         Report Count (4),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x0D,                     # .         Report ID (13),
+    0x0A, 0x0D, 0x10,               # .         Usage (100Dh),
+    0x65, 0x00,                     # .         Unit,
+    0x55, 0x00,                     # .         Unit Exponent (0),
+    0x45, 0x00,                     # .         Physical Maximum (0),
+    0x25, 0x01,                     # .         Logical Maximum (1),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x95, 0x01,                     # .         Report Count (1),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x14,                     # .         Report ID (20),
+    0x0A, 0x14, 0x10,               # .         Usage (1014h),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x95, 0x0D,                     # .         Report Count (13),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0xCC,                     # .         Report ID (204),
+    0x0A, 0xCC, 0x10,               # .         Usage (10CCh),
+    0x95, 0x02,                     # .         Report Count (2),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0xC0,                           # .     End Collection,
+    0x09, 0x0E,                     # .     Usage (0Eh),
+    0xA1, 0x02,                     # .     Collection (Logical),
+    0x85, 0x31,                     # .         Report ID (49),
+    0x0A, 0x31, 0x10,               # .         Usage (1031h),
+    0x25, 0x64,                     # .         Logical Maximum (100),
+    0x95, 0x03,                     # .         Report Count (3),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x95, 0x02,                     # .         Report Count (2),
+    0xB1, 0x03,                     # .         Feature (Constant, Variable),
+    0xC0,                           # .     End Collection,
+    0x0A, 0xAC, 0x10,               # .     Usage (10ACh),
+    0xA1, 0x02,                     # .     Collection (Logical),
+    0x15, 0x00,                     # .         Logical Minimum (0),
+    0x26, 0xFF, 0x00,               # .         Logical Maximum (255),
+    0x75, 0x08,                     # .         Report Size (8),
+    0x85, 0xAC,                     # .         Report ID (172),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x96, 0xBF, 0x00,               # .         Report Count (191),
+    0x81, 0x02,                     # .         Input (Variable),
+    0x85, 0x15,                     # .         Report ID (21),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x0E,                     # .         Report Count (14),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x33,                     # .         Report ID (51),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x12,                     # .         Report Count (18),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x44,                     # .         Report ID (68),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x04,                     # .         Report Count (4),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x45,                     # .         Report ID (69),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x20,                     # .         Report Count (32),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x60,                     # .         Report ID (96),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x3F,                     # .         Report Count (63),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x61,                     # .         Report ID (97),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x3E,                     # .         Report Count (62),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x62,                     # .         Report ID (98),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x3E,                     # .         Report Count (62),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x65,                     # .         Report ID (101),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x04,                     # .         Report Count (4),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x66,                     # .         Report ID (102),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x04,                     # .         Report Count (4),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x67,                     # .         Report ID (103),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x04,                     # .         Report Count (4),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x68,                     # .         Report ID (104),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x11,                     # .         Report Count (17),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x6F,                     # .         Report ID (111),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x3E,                     # .         Report Count (62),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0xCD,                     # .         Report ID (205),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x02,                     # .         Report Count (2),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x16,                     # .         Report ID (22),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x0E,                     # .         Report Count (14),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0x85, 0x35,                     # .         Report ID (53),
+    0x09, 0x00,                     # .         Usage (00h),
+    0x95, 0x0A,                     # .         Report Count (10),
+    0xB1, 0x02,                     # .         Feature (Variable),
+    0xC0,                           # .     End Collection,
+    0x85, 0xD1,                     # .     Report ID (209),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x01,               # .     Report Count (260),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD2,                     # .     Report ID (210),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x01,               # .     Report Count (260),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD3,                     # .     Report ID (211),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD4,                     # .     Report ID (212),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD5,                     # .     Report ID (213),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD6,                     # .     Report ID (214),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD7,                     # .     Report ID (215),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x08, 0x00,               # .     Report Count (8),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD8,                     # .     Report ID (216),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x0C, 0x00,               # .     Report Count (12),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xD9,                     # .     Report ID (217),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x00, 0x0A,               # .     Report Count (2560),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDA,                     # .     Report ID (218),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x04,               # .     Report Count (1028),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDB,                     # .     Report ID (219),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x06, 0x00,               # .     Report Count (6),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDC,                     # .     Report ID (220),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x02, 0x00,               # .     Report Count (2),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDD,                     # .     Report ID (221),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDE,                     # .     Report ID (222),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x04, 0x00,               # .     Report Count (4),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xDF,                     # .     Report ID (223),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x22, 0x00,               # .     Report Count (34),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE0,                     # .     Report ID (224),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x01, 0x00,               # .     Report Count (1),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE1,                     # .     Report ID (225),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x02, 0x00,               # .     Report Count (2),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE2,                     # .     Report ID (226),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x02, 0x00,               # .     Report Count (2),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE3,                     # .     Report ID (227),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x02, 0x00,               # .     Report Count (2),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xE4,                     # .     Report ID (228),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0xFF, 0x01,               # .     Report Count (511),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0x85, 0xCB,                     # .     Report ID (203),
+    0x09, 0x01,                     # .     Usage (01h),
+    0x96, 0x1F, 0x00,               # .     Report Count (31),
+    0xB1, 0x02,                     # .     Feature (Variable),
+    0xC0                            # . End Collection
+]
+# fmt: on
diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/tools/testing/selftests/hid/tests/test_wacom_generic.py
new file mode 100644
index 000000000000..b1eb2bc787fc
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
@@ -0,0 +1,844 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8 -*-
+#
+# Copyright (c) 2017 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+# Copyright (c) 2017 Red Hat, Inc.
+# Copyright (c) 2020 Wacom Technology Corp.
+#
+# Authors:
+#     Jason Gerecke <jason.gerecke@wacom.com>
+
+"""
+Tests for the Wacom driver generic codepath.
+
+This module tests the function of the Wacom driver's generic codepath.
+The generic codepath is used by devices which are not explicitly listed
+in the driver's device table. It uses the device's HID descriptor to
+decode reports sent by the device.
+"""
+
+from .descriptors_wacom import (
+    wacom_pth660_v145,
+    wacom_pth660_v150,
+    wacom_pth860_v145,
+    wacom_pth860_v150,
+    wacom_pth460_v105,
+)
+
+import attr
+from enum import Enum
+from hidtools.hut import HUT
+from hidtools.hid import HidUnit
+from . import base
+import libevdev
+import pytest
+
+import logging
+
+logger = logging.getLogger("hidtools.test.wacom")
+
+KERNEL_MODULE = ("wacom", "wacom")
+
+
+class ProximityState(Enum):
+    """
+    Enumeration of allowed proximity states.
+    """
+
+    # Tool is not able to be sensed by the device
+    OUT = 0
+
+    # Tool is close enough to be sensed, but some data may be invalid
+    # or inaccurate
+    IN_PROXIMITY = 1
+
+    # Tool is close enough to be sensed with high accuracy. All data
+    # valid.
+    IN_RANGE = 2
+
+    def fill(self, reportdata):
+        """Fill a report with approrpiate HID properties/values."""
+        reportdata.inrange = self in [ProximityState.IN_RANGE]
+        reportdata.wacomsense = self in [
+            ProximityState.IN_PROXIMITY,
+            ProximityState.IN_RANGE,
+        ]
+
+
+class ReportData:
+    """
+    Placeholder for HID report values.
+    """
+
+    pass
+
+
+@attr.s
+class Buttons:
+    """
+    Stylus button state.
+
+    Describes the state of each of the buttons / "side switches" that
+    may be present on a stylus. Buttons set to 'None' indicate the
+    state is "unchanged" since the previous event.
+    """
+
+    primary = attr.ib(default=None)
+    secondary = attr.ib(default=None)
+    tertiary = attr.ib(default=None)
+
+    @staticmethod
+    def clear():
+        """Button object with all states cleared."""
+        return Buttons(False, False, False)
+
+    def fill(self, reportdata):
+        """Fill a report with approrpiate HID properties/values."""
+        reportdata.barrelswitch = int(self.primary or 0)
+        reportdata.secondarybarrelswitch = int(self.secondary or 0)
+        reportdata.b3 = int(self.tertiary or 0)
+
+
+@attr.s
+class ToolID:
+    """
+    Stylus tool identifiers.
+
+    Contains values used to identify a specific stylus, e.g. its serial
+    number and tool-type identifier. Values of ``0`` may sometimes be
+    used for the out-of-range condition.
+    """
+
+    serial = attr.ib()
+    tooltype = attr.ib()
+
+    @staticmethod
+    def clear():
+        """ToolID object with all fields cleared."""
+        return ToolID(0, 0)
+
+    def fill(self, reportdata):
+        """Fill a report with approrpiate HID properties/values."""
+        reportdata.transducerserialnumber = self.serial & 0xFFFFFFFF
+        reportdata.serialhi = (self.serial >> 32) & 0xFFFFFFFF
+        reportdata.tooltype = self.tooltype
+
+
+@attr.s
+class PhysRange:
+    """
+    Range of HID physical values, with units.
+    """
+
+    unit = attr.ib()
+    min_size = attr.ib()
+    max_size = attr.ib()
+
+    CENTIMETER = HidUnit.from_string("SILinear: cm")
+    DEGREE = HidUnit.from_string("EnglishRotation: deg")
+
+    def contains(self, field):
+        """
+        Check if the physical size of the provided field is in range.
+
+        Compare the physical size described by the provided HID field
+        against the range of sizes described by this object. This is
+        an exclusive range comparison (e.g. 0 cm is not within the
+        range 0 cm - 5 cm) and exact unit comparison (e.g. 1 inch is
+        not within the range 0 cm - 5 cm).
+        """
+        phys_size = (field.physical_max - field.physical_min) * 10 ** (field.unit_exp)
+        return (
+            field.unit == self.unit.value
+            and phys_size > self.min_size
+            and phys_size < self.max_size
+        )
+
+
+class BaseTablet(base.UHIDTestDevice):
+    """
+    Skeleton object for all kinds of tablet devices.
+    """
+
+    def __init__(self, rdesc, name=None, info=None):
+        assert rdesc is not None
+        super().__init__(name, "Pen", input_info=info, rdesc=rdesc)
+        self.buttons = Buttons.clear()
+        self.toolid = ToolID.clear()
+        self.proximity = ProximityState.OUT
+        self.offset = 0
+        self.ring = -1
+        self.ek0 = False
+
+    def match_evdev_rule(self, application, evdev):
+        """
+        Filter out evdev nodes based on the requested application.
+
+        The Wacom driver may create several device nodes for each USB
+        interface device. It is crucial that we run tests with the
+        expected device node or things will obviously go off the rails.
+        Use the Wacom driver's usual naming conventions to apply a
+        sensible default filter.
+        """
+        if application in ["Pen", "Pad"]:
+            return evdev.name.endswith(application)
+        else:
+            return True
+
+    def create_report(
+        self, x, y, pressure, buttons=None, toolid=None, proximity=None, reportID=None
+    ):
+        """
+        Return an input report for this device.
+
+        :param x: absolute x
+        :param y: absolute y
+        :param pressure: pressure
+        :param buttons: stylus button state. Use ``None`` for unchanged.
+        :param toolid: tool identifiers. Use ``None`` for unchanged.
+        :param proximity: a ProximityState indicating the sensor's ability
+             to detect and report attributes of this tool. Use ``None``
+             for unchanged.
+        :param reportID: the numeric report ID for this report, if needed
+        """
+        if buttons is not None:
+            self.buttons = buttons
+        buttons = self.buttons
+
+        if toolid is not None:
+            self.toolid = toolid
+        toolid = self.toolid
+
+        if proximity is not None:
+            self.proximity = proximity
+        proximity = self.proximity
+
+        reportID = reportID or self.default_reportID
+
+        report = ReportData()
+        report.x = x
+        report.y = y
+        report.tippressure = pressure
+        report.tipswitch = pressure > 0
+        buttons.fill(report)
+        proximity.fill(report)
+        toolid.fill(report)
+
+        return super().create_report(report, reportID=reportID)
+
+    def create_report_heartbeat(self, reportID):
+        """
+        Return a heartbeat input report for this device.
+
+        Heartbeat reports generally contain battery status information,
+        among other things.
+        """
+        report = ReportData()
+        report.wacombatterycharging = 1
+        return super().create_report(report, reportID=reportID)
+
+    def create_report_pad(self, reportID, ring, ek0):
+        report = ReportData()
+
+        if ring is not None:
+            self.ring = ring
+        ring = self.ring
+
+        if ek0 is not None:
+            self.ek0 = ek0
+        ek0 = self.ek0
+
+        if ring >= 0:
+            report.wacomtouchring = ring
+            report.wacomtouchringstatus = 1
+        else:
+            report.wacomtouchring = 0x7F
+            report.wacomtouchringstatus = 0
+
+        report.wacomexpresskey00 = ek0
+        return super().create_report(report, reportID=reportID)
+
+    def event(self, x, y, pressure, buttons=None, toolid=None, proximity=None):
+        """
+        Send an input event on the default report ID.
+
+        :param x: absolute x
+        :param y: absolute y
+        :param buttons: stylus button state. Use ``None`` for unchanged.
+        :param toolid: tool identifiers. Use ``None`` for unchanged.
+        :param proximity: a ProximityState indicating the sensor's ability
+             to detect and report attributes of this tool. Use ``None``
+             for unchanged.
+        """
+        r = self.create_report(x, y, pressure, buttons, toolid, proximity)
+        self.call_input_event(r)
+        return [r]
+
+    def event_heartbeat(self, reportID):
+        """
+        Send a heartbeat event on the requested report ID.
+        """
+        r = self.create_report_heartbeat(reportID)
+        self.call_input_event(r)
+        return [r]
+
+    def event_pad(self, reportID, ring=None, ek0=None):
+        """
+        Send a pad event on the requested report ID.
+        """
+        r = self.create_report_pad(reportID, ring, ek0)
+        self.call_input_event(r)
+        return [r]
+
+    def get_report(self, req, rnum, rtype):
+        if rtype != self.UHID_FEATURE_REPORT:
+            return (1, [])
+
+        rdesc = None
+        for v in self.parsed_rdesc.feature_reports.values():
+            if v.report_ID == rnum:
+                rdesc = v
+
+        if rdesc is None:
+            return (1, [])
+
+        result = (1, [])
+        result = self.create_report_offset(rdesc) or result
+        return result
+
+    def create_report_offset(self, rdesc):
+        require = [
+            "Wacom Offset Left",
+            "Wacom Offset Top",
+            "Wacom Offset Right",
+            "Wacom Offset Bottom",
+        ]
+        if not set(require).issubset(set([f.usage_name for f in rdesc])):
+            return None
+
+        report = ReportData()
+        report.wacomoffsetleft = self.offset
+        report.wacomoffsettop = self.offset
+        report.wacomoffsetright = self.offset
+        report.wacomoffsetbottom = self.offset
+        r = rdesc.create_report([report], None)
+        return (0, r)
+
+
+class OpaqueTablet(BaseTablet):
+    """
+    Bare-bones opaque tablet with a minimum of features.
+
+    A tablet stripped down to its absolute core. It is capable of
+    reporting X/Y position and if the pen is in contact. No pressure,
+    no barrel switches, no eraser. Notably it *does* report an "In
+    Range" flag, but this is only because the Wacom driver expects
+    one to function properly. The device uses only standard HID usages,
+    not any of Wacom's vendor-defined pages.
+    """
+
+    # fmt: off
+    report_descriptor = [
+        0x05, 0x0D,                     # . Usage Page (Digitizer),
+        0x09, 0x01,                     # . Usage (Digitizer),
+        0xA1, 0x01,                     # . Collection (Application),
+        0x85, 0x01,                     # .     Report ID (1),
+        0x09, 0x20,                     # .     Usage (Stylus),
+        0xA1, 0x00,                     # .     Collection (Physical),
+        0x09, 0x42,                     # .         Usage (Tip Switch),
+        0x09, 0x32,                     # .         Usage (In Range),
+        0x15, 0x00,                     # .         Logical Minimum (0),
+        0x25, 0x01,                     # .         Logical Maximum (1),
+        0x75, 0x01,                     # .         Report Size (1),
+        0x95, 0x02,                     # .         Report Count (2),
+        0x81, 0x02,                     # .         Input (Variable),
+        0x95, 0x06,                     # .         Report Count (6),
+        0x81, 0x03,                     # .         Input (Constant, Variable),
+        0x05, 0x01,                     # .         Usage Page (Desktop),
+        0x09, 0x30,                     # .         Usage (X),
+        0x27, 0x80, 0x3E, 0x00, 0x00,   # .         Logical Maximum (16000),
+        0x47, 0x80, 0x3E, 0x00, 0x00,   # .         Physical Maximum (16000),
+        0x65, 0x11,                     # .         Unit (Centimeter),
+        0x55, 0x0D,                     # .         Unit Exponent (13),
+        0x75, 0x10,                     # .         Report Size (16),
+        0x95, 0x01,                     # .         Report Count (1),
+        0x81, 0x02,                     # .         Input (Variable),
+        0x09, 0x31,                     # .         Usage (Y),
+        0x27, 0x28, 0x23, 0x00, 0x00,   # .         Logical Maximum (9000),
+        0x47, 0x28, 0x23, 0x00, 0x00,   # .         Physical Maximum (9000),
+        0x81, 0x02,                     # .         Input (Variable),
+        0xC0,                           # .     End Collection,
+        0xC0,                           # . End Collection,
+    ]
+    # fmt: on
+
+    def __init__(self, rdesc=report_descriptor, name=None, info=(0x3, 0x056A, 0x9999)):
+        super().__init__(rdesc, name, info)
+        self.default_reportID = 1
+
+
+class OpaqueCTLTablet(BaseTablet):
+    """
+    Opaque tablet similar to something in the CTL product line.
+
+    A pen-only tablet with most basic features you would expect from
+    an actual device. Position, eraser, pressure, barrel buttons.
+    Uses the Wacom vendor-defined usage page.
+    """
+
+    # fmt: off
+    report_descriptor = [
+        0x06, 0x0D, 0xFF,               # . Usage Page (Vnd Wacom Emr),
+        0x09, 0x01,                     # . Usage (Digitizer),
+        0xA1, 0x01,                     # . Collection (Application),
+        0x85, 0x10,                     # .     Report ID (16),
+        0x09, 0x20,                     # .     Usage (Stylus),
+        0x35, 0x00,                     # .     Physical Minimum (0),
+        0x45, 0x00,                     # .     Physical Maximum (0),
+        0x15, 0x00,                     # .     Logical Minimum (0),
+        0x25, 0x01,                     # .     Logical Maximum (1),
+        0xA1, 0x00,                     # .     Collection (Physical),
+        0x09, 0x42,                     # .         Usage (Tip Switch),
+        0x09, 0x44,                     # .         Usage (Barrel Switch),
+        0x09, 0x5A,                     # .         Usage (Secondary Barrel Switch),
+        0x09, 0x45,                     # .         Usage (Eraser),
+        0x09, 0x3C,                     # .         Usage (Invert),
+        0x09, 0x32,                     # .         Usage (In Range),
+        0x09, 0x36,                     # .         Usage (In Proximity),
+        0x25, 0x01,                     # .         Logical Maximum (1),
+        0x75, 0x01,                     # .         Report Size (1),
+        0x95, 0x07,                     # .         Report Count (7),
+        0x81, 0x02,                     # .         Input (Variable),
+        0x95, 0x01,                     # .         Report Count (1),
+        0x81, 0x03,                     # .         Input (Constant, Variable),
+        0x0A, 0x30, 0x01,               # .         Usage (X),
+        0x65, 0x11,                     # .         Unit (Centimeter),
+        0x55, 0x0D,                     # .         Unit Exponent (13),
+        0x47, 0x80, 0x3E, 0x00, 0x00,   # .         Physical Maximum (16000),
+        0x27, 0x80, 0x3E, 0x00, 0x00,   # .         Logical Maximum (16000),
+        0x75, 0x18,                     # .         Report Size (24),
+        0x95, 0x01,                     # .         Report Count (1),
+        0x81, 0x02,                     # .         Input (Variable),
+        0x0A, 0x31, 0x01,               # .         Usage (Y),
+        0x47, 0x28, 0x23, 0x00, 0x00,   # .         Physical Maximum (9000),
+        0x27, 0x28, 0x23, 0x00, 0x00,   # .         Logical Maximum (9000),
+        0x81, 0x02,                     # .         Input (Variable),
+        0x09, 0x30,                     # .         Usage (Tip Pressure),
+        0x55, 0x00,                     # .         Unit Exponent (0),
+        0x65, 0x00,                     # .         Unit,
+        0x47, 0x00, 0x00, 0x00, 0x00,   # .         Physical Maximum (0),
+        0x26, 0xFF, 0x0F,               # .         Logical Maximum (4095),
+        0x75, 0x10,                     # .         Report Size (16),
+        0x81, 0x02,                     # .         Input (Variable),
+        0x75, 0x08,                     # .         Report Size (8),
+        0x95, 0x06,                     # .         Report Count (6),
+        0x81, 0x03,                     # .         Input (Constant, Variable),
+        0x0A, 0x32, 0x01,               # .         Usage (Z),
+        0x25, 0x3F,                     # .         Logical Maximum (63),
+        0x75, 0x08,                     # .         Report Size (8),
+        0x95, 0x01,                     # .         Report Count (1),
+        0x81, 0x02,                     # .         Input (Variable),
+        0x09, 0x5B,                     # .         Usage (Transducer Serial Number),
+        0x09, 0x5C,                     # .         Usage (Transducer Serial Number Hi),
+        0x17, 0x00, 0x00, 0x00, 0x80,   # .         Logical Minimum (-2147483648),
+        0x27, 0xFF, 0xFF, 0xFF, 0x7F,   # .         Logical Maximum (2147483647),
+        0x75, 0x20,                     # .         Report Size (32),
+        0x95, 0x02,                     # .         Report Count (2),
+        0x81, 0x02,                     # .         Input (Variable),
+        0x09, 0x77,                     # .         Usage (Tool Type),
+        0x15, 0x00,                     # .         Logical Minimum (0),
+        0x26, 0xFF, 0x0F,               # .         Logical Maximum (4095),
+        0x75, 0x10,                     # .         Report Size (16),
+        0x95, 0x01,                     # .         Report Count (1),
+        0x81, 0x02,                     # .         Input (Variable),
+        0xC0,                           # .     End Collection,
+        0xC0                            # . End Collection
+    ]
+    # fmt: on
+
+    def __init__(self, rdesc=report_descriptor, name=None, info=(0x3, 0x056A, 0x9999)):
+        super().__init__(rdesc, name, info)
+        self.default_reportID = 16
+
+
+class PTHX60_Pen(BaseTablet):
+    """
+    Pen interface of a PTH-660 / PTH-860 / PTH-460 tablet.
+
+    This generation of devices are nearly identical to each other, though
+    the PTH-460 uses a slightly different descriptor construction (splits
+    the pad among several physical collections)
+    """
+
+    def __init__(self, rdesc=None, name=None, info=None):
+        super().__init__(rdesc, name, info)
+        self.default_reportID = 16
+
+
+class BaseTest:
+    class TestTablet(base.BaseTestCase.TestUhid):
+        kernel_modules = [KERNEL_MODULE]
+
+        def sync_and_assert_events(
+            self, report, expected_events, auto_syn=True, strict=False
+        ):
+            """
+            Assert we see the expected events in response to a report.
+            """
+            uhdev = self.uhdev
+            syn_event = self.syn_event
+            if auto_syn:
+                expected_events.append(syn_event)
+            actual_events = uhdev.next_sync_events()
+            self.debug_reports(report, uhdev, actual_events)
+            if strict:
+                self.assertInputEvents(expected_events, actual_events)
+            else:
+                self.assertInputEventsIn(expected_events, actual_events)
+
+        def get_usages(self, uhdev):
+            def get_report_usages(report):
+                application = report.application
+                for field in report.fields:
+                    if field.usages is not None:
+                        for usage in field.usages:
+                            yield (field, usage, application)
+                    else:
+                        yield (field, field.usage, application)
+
+            desc = uhdev.parsed_rdesc
+            reports = [
+                *desc.input_reports.values(),
+                *desc.feature_reports.values(),
+                *desc.output_reports.values(),
+            ]
+            for report in reports:
+                for usage in get_report_usages(report):
+                    yield usage
+
+        def assertName(self, uhdev):
+            """
+            Assert that the name is as we expect.
+
+            The Wacom driver applies a number of decorations to the name
+            provided by the hardware. We cannot rely on the definition of
+            this assertion from the base class to work properly.
+            """
+            evdev = uhdev.get_evdev()
+            expected_name = uhdev.name + " Pen"
+            if "wacom" not in expected_name.lower():
+                expected_name = "Wacom " + expected_name
+            assert evdev.name == expected_name
+
+        def test_descriptor_physicals(self):
+            """
+            Verify that all HID usages which should have a physical range
+            actually do, and those which shouldn't don't. Also verify that
+            the associated unit is correct and within a sensible range.
+            """
+
+            def usage_id(page_name, usage_name):
+                page = HUT.usage_page_from_name(page_name)
+                return (page.page_id << 16) | page[usage_name].usage
+
+            required = {
+                usage_id("Generic Desktop", "X"): PhysRange(
+                    PhysRange.CENTIMETER, 5, 150
+                ),
+                usage_id("Generic Desktop", "Y"): PhysRange(
+                    PhysRange.CENTIMETER, 5, 150
+                ),
+                usage_id("Digitizers", "X Tilt"): PhysRange(PhysRange.DEGREE, 90, 180),
+                usage_id("Digitizers", "Y Tilt"): PhysRange(PhysRange.DEGREE, 90, 180),
+                usage_id("Digitizers", "Twist"): PhysRange(PhysRange.DEGREE, 358, 360),
+                usage_id("Wacom", "X Tilt"): PhysRange(PhysRange.DEGREE, 90, 180),
+                usage_id("Wacom", "Y Tilt"): PhysRange(PhysRange.DEGREE, 90, 180),
+                usage_id("Wacom", "Twist"): PhysRange(PhysRange.DEGREE, 358, 360),
+                usage_id("Wacom", "X"): PhysRange(PhysRange.CENTIMETER, 5, 150),
+                usage_id("Wacom", "Y"): PhysRange(PhysRange.CENTIMETER, 5, 150),
+                usage_id("Wacom", "Wacom TouchRing"): PhysRange(
+                    PhysRange.DEGREE, 358, 360
+                ),
+                usage_id("Wacom", "Wacom Offset Left"): PhysRange(
+                    PhysRange.CENTIMETER, 0, 0.5
+                ),
+                usage_id("Wacom", "Wacom Offset Top"): PhysRange(
+                    PhysRange.CENTIMETER, 0, 0.5
+                ),
+                usage_id("Wacom", "Wacom Offset Right"): PhysRange(
+                    PhysRange.CENTIMETER, 0, 0.5
+                ),
+                usage_id("Wacom", "Wacom Offset Bottom"): PhysRange(
+                    PhysRange.CENTIMETER, 0, 0.5
+                ),
+            }
+            for field, usage, application in self.get_usages(self.uhdev):
+                if application == usage_id("Generic Desktop", "Mouse"):
+                    # Ignore the vestigial Mouse collection which exists
+                    # on Wacom tablets only for backwards compatibility.
+                    continue
+
+                expect_physical = usage in required
+
+                phys_set = field.physical_min != 0 or field.physical_max != 0
+                assert phys_set == expect_physical
+
+                unit_set = field.unit != 0
+                assert unit_set == expect_physical
+
+                if unit_set:
+                    assert required[usage].contains(field)
+
+        def test_prop_direct(self):
+            """
+            Todo: Verify that INPUT_PROP_DIRECT is set on display devices.
+            """
+            pass
+
+        def test_prop_pointer(self):
+            """
+            Todo: Verify that INPUT_PROP_POINTER is set on opaque devices.
+            """
+            pass
+
+
+class TestOpaqueTablet(BaseTest.TestTablet):
+    def create_device(self):
+        return OpaqueTablet()
+
+    def test_sanity(self):
+        """
+        Bring a pen into contact with the tablet, then remove it.
+
+        Ensure that we get the basic tool/touch/motion events that should
+        be sent by the driver.
+        """
+        uhdev = self.uhdev
+
+        self.sync_and_assert_events(
+            uhdev.event(
+                100,
+                200,
+                pressure=300,
+                buttons=Buttons.clear(),
+                toolid=ToolID(serial=1, tooltype=1),
+                proximity=ProximityState.IN_RANGE,
+            ),
+            [
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_TOOL_PEN, 1),
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_X, 100),
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_Y, 200),
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH, 1),
+            ],
+        )
+
+        self.sync_and_assert_events(
+            uhdev.event(110, 220, pressure=0),
+            [
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_X, 110),
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_Y, 220),
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH, 0),
+            ],
+        )
+
+        self.sync_and_assert_events(
+            uhdev.event(
+                120,
+                230,
+                pressure=0,
+                toolid=ToolID.clear(),
+                proximity=ProximityState.OUT,
+            ),
+            [
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_TOOL_PEN, 0),
+            ],
+        )
+
+        self.sync_and_assert_events(
+            uhdev.event(130, 240, pressure=0), [], auto_syn=False, strict=True
+        )
+
+
+class TestOpaqueCTLTablet(TestOpaqueTablet):
+    def create_device(self):
+        return OpaqueCTLTablet()
+
+    def test_buttons(self):
+        """
+        Test that the barrel buttons (side switches) work as expected.
+
+        Press and release each button individually to verify that we get
+        the expected events.
+        """
+        uhdev = self.uhdev
+
+        self.sync_and_assert_events(
+            uhdev.event(
+                100,
+                200,
+                pressure=0,
+                buttons=Buttons.clear(),
+                toolid=ToolID(serial=1, tooltype=1),
+                proximity=ProximityState.IN_RANGE,
+            ),
+            [
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_TOOL_PEN, 1),
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_X, 100),
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_Y, 200),
+                libevdev.InputEvent(libevdev.EV_MSC.MSC_SERIAL, 1),
+            ],
+        )
+
+        self.sync_and_assert_events(
+            uhdev.event(100, 200, pressure=0, buttons=Buttons(primary=True)),
+            [
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS, 1),
+                libevdev.InputEvent(libevdev.EV_MSC.MSC_SERIAL, 1),
+            ],
+        )
+
+        self.sync_and_assert_events(
+            uhdev.event(100, 200, pressure=0, buttons=Buttons(primary=False)),
+            [
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS, 0),
+                libevdev.InputEvent(libevdev.EV_MSC.MSC_SERIAL, 1),
+            ],
+        )
+
+        self.sync_and_assert_events(
+            uhdev.event(100, 200, pressure=0, buttons=Buttons(secondary=True)),
+            [
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS2, 1),
+                libevdev.InputEvent(libevdev.EV_MSC.MSC_SERIAL, 1),
+            ],
+        )
+
+        self.sync_and_assert_events(
+            uhdev.event(100, 200, pressure=0, buttons=Buttons(secondary=False)),
+            [
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS2, 0),
+                libevdev.InputEvent(libevdev.EV_MSC.MSC_SERIAL, 1),
+            ],
+        )
+
+
+PTHX60_Devices = [
+    {"rdesc": wacom_pth660_v145, "info": (0x3, 0x056A, 0x0357)},
+    {"rdesc": wacom_pth660_v150, "info": (0x3, 0x056A, 0x0357)},
+    {"rdesc": wacom_pth860_v145, "info": (0x3, 0x056A, 0x0358)},
+    {"rdesc": wacom_pth860_v150, "info": (0x3, 0x056A, 0x0358)},
+    {"rdesc": wacom_pth460_v105, "info": (0x3, 0x056A, 0x0392)},
+]
+
+PTHX60_Names = [
+    "PTH-660/v145",
+    "PTH-660/v150",
+    "PTH-860/v145",
+    "PTH-860/v150",
+    "PTH-460/v105",
+]
+
+
+class TestPTHX60_Pen(TestOpaqueCTLTablet):
+    @pytest.fixture(
+        autouse=True, scope="class", params=PTHX60_Devices, ids=PTHX60_Names
+    )
+    def set_device_params(self, request):
+        request.cls.device_params = request.param
+
+    def create_device(self):
+        return PTHX60_Pen(**self.device_params)
+
+    @pytest.mark.xfail
+    def test_descriptor_physicals(self):
+        # XFAIL: Various documented errata
+        super().test_descriptor_physicals()
+
+    def test_heartbeat_spurious(self):
+        """
+        Test that the heartbeat report does not send spurious events.
+        """
+        uhdev = self.uhdev
+
+        self.sync_and_assert_events(
+            uhdev.event(
+                100,
+                200,
+                pressure=300,
+                buttons=Buttons.clear(),
+                toolid=ToolID(serial=1, tooltype=0x822),
+                proximity=ProximityState.IN_RANGE,
+            ),
+            [
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_TOOL_PEN, 1),
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_X, 100),
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_Y, 200),
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH, 1),
+            ],
+        )
+
+        # Exactly zero events: not even a SYN
+        self.sync_and_assert_events(
+            uhdev.event_heartbeat(19), [], auto_syn=False, strict=True
+        )
+
+        self.sync_and_assert_events(
+            uhdev.event(110, 200, pressure=300),
+            [
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_X, 110),
+            ],
+        )
+
+    def test_empty_pad_sync(self):
+        self.empty_pad_sync(num=3, denom=16, reverse=True)
+
+    def empty_pad_sync(self, num, denom, reverse):
+        """
+        Test that multiple pad collections do not trigger empty syncs.
+        """
+
+        def offset_rotation(value):
+            """
+            Offset touchring rotation values by the same factor as the
+            Linux kernel. Tablets historically don't use the same origin
+            as HID, and it sometimes changes from tablet to tablet...
+            """
+            evdev = self.uhdev.get_evdev()
+            info = evdev.absinfo[libevdev.EV_ABS.ABS_WHEEL]
+            delta = info.maximum - info.minimum + 1
+            if reverse:
+                value = info.maximum - value
+            value += num * delta // denom
+            if value > info.maximum:
+                value -= delta
+            elif value < info.minimum:
+                value += delta
+            return value
+
+        uhdev = self.uhdev
+        uhdev.application = "Pad"
+        evdev = uhdev.get_evdev()
+
+        print(evdev.name)
+        self.sync_and_assert_events(
+            uhdev.event_pad(reportID=17, ring=0, ek0=1),
+            [
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_0, 1),
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_WHEEL, offset_rotation(0)),
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_MISC, 15),
+            ],
+        )
+
+        self.sync_and_assert_events(
+            uhdev.event_pad(reportID=17, ring=1, ek0=1),
+            [libevdev.InputEvent(libevdev.EV_ABS.ABS_WHEEL, offset_rotation(1))],
+        )
+
+        self.sync_and_assert_events(
+            uhdev.event_pad(reportID=17, ring=2, ek0=0),
+            [
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_WHEEL, offset_rotation(2)),
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_0, 0),
+            ],
+        )

-- 
2.39.1

