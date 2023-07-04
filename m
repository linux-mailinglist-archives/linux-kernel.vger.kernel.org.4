Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F16B7469DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGDGpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjGDGpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:45:00 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D14E6E;
        Mon,  3 Jul 2023 23:44:45 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-765a4ff26cdso469115085a.0;
        Mon, 03 Jul 2023 23:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688453084; x=1691045084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9/IAi2WKAiTTNgYoMQrx/m0c+NwYKV1J+3q3HTRy94=;
        b=UlZ3SJ6uTEwDaSu593QviqOsxTt9koEad82ewy4xQIEps5slhQ2DxzAyTxEUbwChcJ
         5qzUJcvg2I+fULamZYZxjqJCwhz+GoWbNDYtF+pXoztFquZ16GB92yp4GIWcD4N3o/Js
         KHd6MtjAzfgmeNFA1e30pIaEY7yZmnlQDCQcnQ5cIS1t/jn5mZJuhsxOCjtPyrGt8bDs
         HqkpEPSLG90HEZ2mK+q3c1cQgXThhJo0izD+KgaavsUjwaIfkfIueDRkf/3wukn0I7FD
         bv3ApEvIm6saqYfd/qnQLwRJY7MoHlF4oqEerKTk8heZQJp1tfE4PEx0BDxeIEiHnggJ
         5B8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688453084; x=1691045084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9/IAi2WKAiTTNgYoMQrx/m0c+NwYKV1J+3q3HTRy94=;
        b=XqVEXVOhgOu2sJ7b2wXylSardAxKwPzI1S1zSnWj9KCV4FABLpwSQGBXqf7crpihDX
         /9zO9Xet1XzHyv6QHzi4/wxa40psFqpOZsJIo5v691tzqXGyIeRgZQFhZxacudcfSUh9
         ZIPVEVy6BfSwWzFFR0Q7qE2QxsVFVizCkmKWLlWqzMgiLnboDmL2Q3BYvFWko1kNU4BB
         gDxa8TOj0mpaObUQHb3TT2pIuOBw9aISM3KqtdOGCLQP73rPCIVHoSArbA+xsygWNF3+
         NwVv0tlg9+qr6V1e2mTTgZsB3FbgZIGJTn9ou2yhk/QR4utpbGxrfcGvLvPzxI3gDu6F
         gwtA==
X-Gm-Message-State: ABy/qLZ7iIQ5cF9ypMypsBEtN9giu84SHEur0q1Mfog+YL02iiX7IiS5
        f79wZXWm/bx/N0wjK3/1kXnxnBRg8jXKOg==
X-Google-Smtp-Source: APBJJlEyLu33y0phs4M05sJ2iCQnzHcIGogkqug6DOTs/IgO3iE+dHLShkVxqICxUfV/Czb20yzqhw==
X-Received: by 2002:a05:620a:4096:b0:765:3380:2005 with SMTP id f22-20020a05620a409600b0076533802005mr18161026qko.61.1688453084130;
        Mon, 03 Jul 2023 23:44:44 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u2-20020aa78382000000b00668652b020bsm14863429pfm.105.2023.07.03.23.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 23:44:43 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v13 6/7] media: uapi: Add controls for NPCM video driver
Date:   Tue,  4 Jul 2023 14:44:11 +0800
Message-Id: <20230704064412.2145181-7-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704064412.2145181-1-milkfafa@gmail.com>
References: <20230704064412.2145181-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create controls for Nuvoton NPCM video driver to support setting
capture mode of Video Capture/Differentiation (VCD) engine and getting
the count of HEXTILE rectangles that is compressed by Encoding
Compression Engine (ECE).

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 .../userspace-api/media/drivers/index.rst     |  1 +
 .../media/drivers/npcm-video.rst              | 67 +++++++++++++++++++
 include/uapi/linux/npcm-video.h               | 41 ++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 Documentation/userspace-api/media/drivers/npcm-video.rst
 create mode 100644 include/uapi/linux/npcm-video.h

diff --git a/Documentation/userspace-api/media/drivers/index.rst b/Documentation/userspace-api/media/drivers/index.rst
index 6708d649afd7..783f92f01a4c 100644
--- a/Documentation/userspace-api/media/drivers/index.rst
+++ b/Documentation/userspace-api/media/drivers/index.rst
@@ -37,6 +37,7 @@ For more details see the file COPYING in the source distribution of Linux.
 	dw100
 	imx-uapi
 	max2175
+	npcm-video
 	omap3isp-uapi
 	st-vgxy61
 	uvcvideo
diff --git a/Documentation/userspace-api/media/drivers/npcm-video.rst b/Documentation/userspace-api/media/drivers/npcm-video.rst
new file mode 100644
index 000000000000..d0d596d1fb82
--- /dev/null
+++ b/Documentation/userspace-api/media/drivers/npcm-video.rst
@@ -0,0 +1,67 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: <isonum.txt>
+
+NPCM video driver
+=================
+
+This driver is used to control the Video Capture/Differentiation (VCD) engine
+and Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs. The VCD can
+capture a frame from digital video input and compare two frames in memory, and
+the ECE can compress the frame data into HEXTILE format.
+
+Driver-specific Controls
+------------------------
+
+V4L2_CID_NPCM_CAPTURE_MODE
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The VCD engine supports two modes:
+
+- COMPLETE mode:
+
+  Capture the next complete frame into memory.
+
+- DIFF mode:
+
+  Compare the incoming frame with the frame stored in memory, and updates the
+  differentiated frame in memory.
+
+Application can use ``V4L2_CID_NPCM_CAPTURE_MODE`` control to set the VCD mode
+with different control values (enum v4l2_npcm_capture_mode):
+
+- ``V4L2_NPCM_CAPTURE_MODE_COMPLETE``: will set VCD to COMPLETE mode.
+- ``V4L2_NPCM_CAPTURE_MODE_DIFF``: will set VCD to DIFF mode.
+
+V4L2_CID_NPCM_RECT_COUNT
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+After frame data is captured, if using V4L2_PIX_FMT_HEXTILE format, the ECE will
+compress the data into HEXTILE format and store these HEXTILE rectangles data in
+V4L2 video buffer with the layout defined in Remote Framebuffer Protocol:
+::
+
+           (RFC 6143, https://www.rfc-editor.org/rfc/rfc6143.html#section-7.6.1)
+
+           +--------------+--------------+-------------------+
+           | No. of bytes | Type [Value] | Description       |
+           +--------------+--------------+-------------------+
+           | 2            | U16          | x-position        |
+           | 2            | U16          | y-position        |
+           | 2            | U16          | width             |
+           | 2            | U16          | height            |
+           | 4            | S32          | encoding-type (5) |
+           +--------------+--------------+-------------------+
+           |             HEXTILE rectangle data              |
+           +-------------------------------------------------+
+
+Application can get these video buffers through V4L2 interfaces and use
+``V4L2_CID_NPCM_RECT_COUNT`` control to get the count of compressed HEXTILE
+rectangles that can be put in the field number-of-rectangles of
+FramebufferUpdate header.
+
+References
+----------
+include/uapi/linux/npcm-video.h
+
+**Copyright** |copy| 2022 Nuvoton Technologies
diff --git a/include/uapi/linux/npcm-video.h b/include/uapi/linux/npcm-video.h
new file mode 100644
index 000000000000..1d39f6f38c96
--- /dev/null
+++ b/include/uapi/linux/npcm-video.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Controls header for NPCM video driver
+ *
+ * Copyright (C) 2022 Nuvoton Technologies
+ */
+
+#ifndef _UAPI_LINUX_NPCM_VIDEO_H
+#define _UAPI_LINUX_NPCM_VIDEO_H
+
+#include <linux/v4l2-controls.h>
+
+/*
+ * Check Documentation/userspace-api/media/drivers/npcm-video.rst for control
+ * details.
+ */
+
+/*
+ * This control is meant to set the mode of NPCM Video Capture/Differentiation
+ * (VCD) engine.
+ *
+ * The VCD engine supports two modes:
+ * COMPLETE - Capture the next complete frame into memory.
+ * DIFF	    - Compare the incoming frame with the frame stored in memory, and
+ *	      updates the differentiated frame in memory.
+ */
+#define V4L2_CID_NPCM_CAPTURE_MODE	(V4L2_CID_USER_NPCM_BASE + 0)
+
+enum v4l2_npcm_capture_mode {
+	V4L2_NPCM_CAPTURE_MODE_COMPLETE	= 0, /* COMPLETE mode */
+	V4L2_NPCM_CAPTURE_MODE_DIFF	= 1, /* DIFF mode */
+};
+
+/*
+ * This control is meant to get the count of compressed HEXTILE rectangles which
+ * is relevant to the number of differentiated frames if VCD is in DIFF mode.
+ * And the count will always be 1 if VCD is in COMPLETE mode.
+ */
+#define V4L2_CID_NPCM_RECT_COUNT	(V4L2_CID_USER_NPCM_BASE + 1)
+
+#endif /* _UAPI_LINUX_NPCM_VIDEO_H */
-- 
2.34.1

