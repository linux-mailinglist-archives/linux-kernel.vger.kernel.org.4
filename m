Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724CD6D38D0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 17:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjDBPlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 11:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjDBPle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 11:41:34 -0400
X-Greylist: delayed 423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Apr 2023 08:41:27 PDT
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5054:ff:fe75:428f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DE26A68
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 08:41:26 -0700 (PDT)
Received: from ritsuko.sh.sumomo.pri (unknown [112.64.60.49])
        by kozue.soulik.info (Postfix) with ESMTPSA id A709B101DA9;
        Mon,  3 Apr 2023 00:34:27 +0900 (JST)
From:   Randy Li <ayaka@soulik.info>
To:     dri-devel@lists.freedesktop.org
Cc:     Randy Li <ayaka@soulik.info>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org, tfiga@chromium.org,
        nicolas@ndufresne.ca, laurent.pinchart@ideasonboard.com,
        ribalda@chromium.org, Hsia-Jun Li <randy.li@synaptics.com>
Subject: [PATCH v7 2/2] Documentation/gpu: Add Synaptics tiling formats documentation
Date:   Sun,  2 Apr 2023 23:33:58 +0800
Message-Id: <20230402153358.32948-3-ayaka@soulik.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230402153358.32948-1-ayaka@soulik.info>
References: <20230402153358.32948-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Randy Li <ayaka@soulik.info>
Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
---
 Documentation/gpu/drivers.rst   |  1 +
 Documentation/gpu/synaptics.rst | 81 +++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/gpu/synaptics.rst

diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
index 3a52f48215a3..7e820c93d994 100644
--- a/Documentation/gpu/drivers.rst
+++ b/Documentation/gpu/drivers.rst
@@ -18,6 +18,7 @@ GPU Driver Documentation
    xen-front
    afbc
    komeda-kms
+   synaptics
 
 .. only::  subproject and html
 
diff --git a/Documentation/gpu/synaptics.rst b/Documentation/gpu/synaptics.rst
new file mode 100644
index 000000000000..a3b24c297186
--- /dev/null
+++ b/Documentation/gpu/synaptics.rst
@@ -0,0 +1,81 @@
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
+
+================
+Synaptics Tiling
+================
+
+The tiling pixel formats in Synpatics Video Smart platform have
+many variants. Tiles could form the group of tiles, pixels within
+the group (nearest) width and height are stored into tile.
+Meanwhile, the tile in a group may not follow dimension layout,
+tile could form a small group of tiles, then that (sub)group
+of tiles would form a bigger group. We won't describe the dimension
+layout inside the group of tiles here. The layout of the group
+of tiles is fixed with the group width and height parameters
+in the same generation of the platform.
+
+Compression
+===========
+The proprietary lossless image compression protocol in Synaptics
+could minimizes the amount of data transferred (less memory bandwidth
+consumption) between devices. It would usually apply to the tiling
+pixel format.
+
+Each component would request an extra page aligned length buffer
+for storing the compression meta data. Also a 32 bytes parameters
+set would come with a compression meta data buffer.
+
+The component here corresponds to a signal type (i.e. Luma, chroma).
+They could be encoded into one or multiple metadata planes, but
+their compression parameters still would be individual.
+
+Pixel format modifiers
+======================
+Addition alignment requirement for stride and size of a memory plane
+could apply beyond what has been mentioned below. Remember always
+negotiating with all the devices in pipeline before allocation.
+
+.. flat-table:: Synpatics Image Format Modifiers
+
+  * - Identifier
+    - Fourcc
+    - Details
+
+  * - DRM_FORMAT_MOD_SYNA_V4H1
+    - DRM_FORMAT_NV12
+    - The plain uncompressed 8 bits tile format. It sounds similar to
+      Intel's Y-tile. but it won't take any pixel from the next X direction
+      in a tile group. The line stride and image height must be aligned to
+      a multiple of 16. The height of chrominance plane would plus 8.
+
+  * - DRM_FORMAT_MOD_SYNA_V4H3P8
+    - DRM_FORMAT_NV15
+    - The plain uncompressed 10 bits tile format. It stores pixel in 2D
+      3x4 tiles with a 8bits padding to each of tile. Then a tile is in a
+      128 bits cache line.
+
+  * - DRM_FORMAT_MOD_SYNA_V4H1_64L4_COMPRESSED
+    - DRM_FORMAT_NV12
+    - Group of tiles and compressed variant of ``DRM_FORMAT_MOD_SYNA_V4H1``.
+      A group of tiles would contain 64x4 pixels, where a tile has 1x4
+      pixel.
+
+  * - DRM_FORMAT_MOD_SYNA_V4H3P8_64L4_COMPRESSED
+    - DRM_FORMAT_NV15
+    - Group of tiles and compressed variant of ``DRM_FORMAT_MOD_SYNA_V4H3P8``.
+      A group of tiles would contains 48x4 pixels, where a tile has 3x4 pixels
+      and a 8 bits padding in the end of a tile. A group of tiles would
+      be 256 bytes.
+
+  * - ``DRM_FORMAT_MOD_SYNA_V4H1_128L128_COMPRESSED``
+    - DRM_FORMAT_NV12
+    - Group of tiles and compressed variant of ``DRM_FORMAT_MOD_SYNA_V4H1``.
+      A group of tiles would contain 128x32 pixels, where a tile has 1x4
+      pixel.
+
+  * - ``DRM_FORMAT_MOD_SYNA_V4H3P8_128L128_COMPRESSED``
+    - DRM_FORMAT_NV15
+    - Group of tiles and compressed variant of ``DRM_FORMAT_MOD_SYNA_V4H3P8``.
+      A group of tiles would contains 96x128 pixels, where a tile has 3x4 pixels
+      and a 8 bits padding in the end of a tile. A group of tiles would
+      be 16 KiB.
-- 
2.39.2

