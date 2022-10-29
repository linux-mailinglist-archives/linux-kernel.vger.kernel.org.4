Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DBE612465
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 18:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJ2QN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJ2QNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 12:13:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2378C33A38
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:13:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so12485727pjk.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3x0jiWcFWFmlhFBUgMb/KV3f2D1GeO0pHu9fsc01t/c=;
        b=oh1fOxrXrHC1s7Xx/PRQIpepIGCcPhMFGriWCy6k7pwIZedMIRMqP2sZlVxV3KHvxe
         wAR9wKr20eolR6fz3BxmjYwCaw23dAZ+0h3cAtwH1Df0qcBVKSSLI+Cc7L3WG5/+8yWg
         xpt3gFgp6elqtCaxmu07IP1wv0pak33E1jkEovMn24PyvJEO0fJEhMengp7EQU6k0gbZ
         e1Ci7X0f+4WSn7zmuO4bJ7J3DU0QFQA9urW7C3MCl329pXCoJ8nNFjRDJOYRf40Q/L9P
         kbFAtIC6A8uYsUOMlbuUJX4KWdjnUAJJX86WaKfRvKbnRYIrl9pNj6qVlIsHf0F9JIbJ
         ooLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3x0jiWcFWFmlhFBUgMb/KV3f2D1GeO0pHu9fsc01t/c=;
        b=mHXvscm2CMEo3eEIDi8rbSWNRtN4e8/AWcVs0jWCkSa48SU/B/0Nny5zrjwDLWut02
         yq1CnxXFE5JIt3lqwARajcGfCYIMbFZ7cfy7j1rX5Beb76IRxV0e6mZyluRMXVmBNs+6
         rfn4yfG1c24YimTu4R39RDUyf3tg6Rw9Q6rLCkpm2Gr1LtYSt/Km41ZW0Mt07sWdcI+U
         VjLmUyDJgTcXtzval/KSkE/q68d6gz5UYtyJ+MK2GTDFrYtP4K+yg2qhRx1z76fo4MqF
         whBye+FUuP38wP+IG6L8YGwlBbmyrpOTi8H/KOhOC7j7sWSXxojjQPvElG0AJ1c34gtz
         ONtA==
X-Gm-Message-State: ACrzQf2Z4Oyu80LlA8mtGr5u2ZyhEkfYSguRseOFPuQ6Hq7nxO1KHbvH
        ANnz8cLMvfEgN8QzFtmJan5JInurJwk8iPwv
X-Google-Smtp-Source: AMsMyM5qvCexR8P6Czc0gi95DaOQGd/qFVTsoanDO5UvShtkh4hopAR7+6iL1odgoLX6b+ECumPSNQ==
X-Received: by 2002:a17:90a:ad08:b0:212:d5f1:e0c6 with SMTP id r8-20020a17090aad0800b00212d5f1e0c6mr21996458pjq.228.1667059999324;
        Sat, 29 Oct 2022 09:13:19 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:d478:7aa5:ae24:3b52:b714])
        by smtp.gmail.com with ESMTPSA id a75-20020a621a4e000000b005624e9b3e10sm1361308pfa.210.2022.10.29.09.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 09:13:18 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] tools: usb: ffs-aio-example: Fix build error with aarch64-*-gnu-gcc toolchain(s)
Date:   Sat, 29 Oct 2022 21:43:12 +0530
Message-Id: <20221029161312.171165-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tools/usb/aio_simple.c file when cross-compiled with
aarch64-*-gnu-gcc toolchain(s) leads to the following errors:

  aio_simple.c:30:10: fatal error: endian.h: No such file or directory
  30 | #include <endian.h>
      |          ^~~~~~~~~~

  aio_simple.c:88:14: note: (near initialization for
                      'descriptors.fs_count')
  aio_simple.c:110:14: error: initializer element is not constant
  110 |  .hs_count = htole32(3),
      |              ^~~~~~~
  aio_simple.c:110:14: note: (near initialization for
                      'descriptors.hs_count')
  aio_simple.c:124:22: error: initializer element is not constant
  124 |    .wMaxPacketSize = htole16(512),
      |                      ^~~~~~~
  aio_simple.c:124:22: note: (near initialization for
                       'descriptors.hs_descs.bulk_sink.wMaxPacketSize')

Fix these compilation issues by:
 - Switching to _DEFAULT_SOURCE:
    _BSD_SOURCE is deprecated and gives a build warning. Let's use
    _DEFAULT_SOURCE instead.
 - Currently this file uses library htole16/32 function calls.
   Replace these with equivalent 'cpu_to_le16/32' calls.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../simple/device_app/aio_simple.c            | 44 +++++++++++++------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/tools/usb/ffs-aio-example/simple/device_app/aio_simple.c b/tools/usb/ffs-aio-example/simple/device_app/aio_simple.c
index 1f44a29818bf..96616eb4600b 100644
--- a/tools/usb/ffs-aio-example/simple/device_app/aio_simple.c
+++ b/tools/usb/ffs-aio-example/simple/device_app/aio_simple.c
@@ -25,7 +25,9 @@
  * For more information, please refer to <http://unlicense.org/>
  */
 
-#define _BSD_SOURCE /* for endian.h */
+/* $(CROSS_COMPILE)cc -g -o aio_simple aio_simple.c -laio */
+
+#define _DEFAULT_SOURCE /* for endian.h */
 
 #include <endian.h>
 #include <errno.h>
@@ -49,6 +51,22 @@
 
 #define BUF_LEN		8192
 
+/*
+ * cpu_to_le16/32 are used when initializing structures, a context where a
+ * function call is not allowed. To solve this, we code cpu_to_le16/32 in a way
+ * that allows them to be used when initializing structures.
+ */
+
+#if BYTE_ORDER == __LITTLE_ENDIAN
+#define cpu_to_le16(x)  (x)
+#define cpu_to_le32(x)  (x)
+#else
+#define cpu_to_le16(x)  ((((x) >> 8) & 0xffu) | (((x) & 0xffu) << 8))
+#define cpu_to_le32(x)  \
+	((((x) & 0xff000000u) >> 24) | (((x) & 0x00ff0000u) >>  8) | \
+	(((x) & 0x0000ff00u) <<  8) | (((x) & 0x000000ffu) << 24))
+#endif
+
 /******************** Descriptors and Strings *******************************/
 
 static const struct {
@@ -62,12 +80,12 @@ static const struct {
 	} __attribute__ ((__packed__)) fs_descs, hs_descs;
 } __attribute__ ((__packed__)) descriptors = {
 	.header = {
-		.magic = htole32(FUNCTIONFS_DESCRIPTORS_MAGIC_V2),
-		.flags = htole32(FUNCTIONFS_HAS_FS_DESC |
+		.magic = cpu_to_le32(FUNCTIONFS_DESCRIPTORS_MAGIC_V2),
+		.flags = cpu_to_le32(FUNCTIONFS_HAS_FS_DESC |
 				     FUNCTIONFS_HAS_HS_DESC),
-		.length = htole32(sizeof(descriptors)),
+		.length = cpu_to_le32(sizeof(descriptors)),
 	},
-	.fs_count = htole32(3),
+	.fs_count = cpu_to_le32(3),
 	.fs_descs = {
 		.intf = {
 			.bLength = sizeof(descriptors.fs_descs.intf),
@@ -89,7 +107,7 @@ static const struct {
 			.bmAttributes = USB_ENDPOINT_XFER_BULK,
 		},
 	},
-	.hs_count = htole32(3),
+	.hs_count = cpu_to_le32(3),
 	.hs_descs = {
 		.intf = {
 			.bLength = sizeof(descriptors.hs_descs.intf),
@@ -103,14 +121,14 @@ static const struct {
 			.bDescriptorType = USB_DT_ENDPOINT,
 			.bEndpointAddress = 1 | USB_DIR_IN,
 			.bmAttributes = USB_ENDPOINT_XFER_BULK,
-			.wMaxPacketSize = htole16(512),
+			.wMaxPacketSize = cpu_to_le16(512),
 		},
 		.bulk_source = {
 			.bLength = sizeof(descriptors.hs_descs.bulk_source),
 			.bDescriptorType = USB_DT_ENDPOINT,
 			.bEndpointAddress = 2 | USB_DIR_OUT,
 			.bmAttributes = USB_ENDPOINT_XFER_BULK,
-			.wMaxPacketSize = htole16(512),
+			.wMaxPacketSize = cpu_to_le16(512),
 		},
 	},
 };
@@ -125,13 +143,13 @@ static const struct {
 	} __attribute__ ((__packed__)) lang0;
 } __attribute__ ((__packed__)) strings = {
 	.header = {
-		.magic = htole32(FUNCTIONFS_STRINGS_MAGIC),
-		.length = htole32(sizeof(strings)),
-		.str_count = htole32(1),
-		.lang_count = htole32(1),
+		.magic = cpu_to_le32(FUNCTIONFS_STRINGS_MAGIC),
+		.length = cpu_to_le32(sizeof(strings)),
+		.str_count = cpu_to_le32(1),
+		.lang_count = cpu_to_le32(1),
 	},
 	.lang0 = {
-		htole16(0x0409), /* en-us */
+		cpu_to_le16(0x0409), /* en-us */
 		STR_INTERFACE,
 	},
 };
-- 
2.37.3

