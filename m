Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316C668B4EE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 05:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBFEfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 23:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBFEfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 23:35:25 -0500
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5054:ff:fe75:428f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2579F1B331;
        Sun,  5 Feb 2023 20:35:03 -0800 (PST)
Received: from misaki.sumomo.pri (unknown [192.168.0.134])
        by kozue.soulik.info (Postfix) with ESMTPA id 11A44101CD1;
        Mon,  6 Feb 2023 13:34:54 +0900 (JST)
From:   ayaka <ayaka@soulik.info>
To:     linux-media@vger.kernel.org
Cc:     randy.li@synaptics.com, Brian.Starkey@arm.com,
        boris.brezillon@collabora.com, frkoenig@chromium.org,
        hans.verkuil@cisco.com, hiroh@chromium.org, hverkuil@xs4all.nl,
        kernel@collabora.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        narmstrong@baylibre.com, nicolas@ndufresne.ca, sakari.ailus@iki.fi,
        stanimir.varbanov@linaro.org, tfiga@chromium.org,
        Helen Koike <helen.koike@collabora.com>
Subject: [PATCH v7 8/9] media: mediabus: Add helpers to convert a ext_pix format to/from a mbus_fmt
Date:   Mon,  6 Feb 2023 12:33:07 +0800
Message-Id: <20230206043308.28365-9-ayaka@soulik.info>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206043308.28365-1-ayaka@soulik.info>
References: <20230206043308.28365-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

Just a new version of v4l2_fill_mbus_format() and v4l2_fill_ext_pix_format()
to deal with the new v4l2_ext_pix_format struct.
This is needed to convert the VIMC driver to the EXT_FMT/EXT_BUF iocts.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
Changes in v6:
- Rename v4l2_fill_ext_pix_format() to v4l2_fill_ext_pix_format_from_mbus() (Tomasz)

Changes in v4:
- Add helper v4l2_fill_ext_pix_format()
- Rebased on top of media/master (post 5.8-rc1)

Changes in v3:
- Rebased on top of media/master (post 5.4-rc1)

Changes in v2:
- New patch
---
 include/media/v4l2-mediabus.h | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/media/v4l2-mediabus.h b/include/media/v4l2-mediabus.h
index 5bce6e423e94..3959d0abde03 100644
--- a/include/media/v4l2-mediabus.h
+++ b/include/media/v4l2-mediabus.h
@@ -252,4 +252,46 @@ v4l2_fill_mbus_format_mplane(struct v4l2_mbus_framefmt *mbus_fmt,
 	mbus_fmt->xfer_func = pix_mp_fmt->xfer_func;
 }
 
+/**
+ * v4l2_fill_ext_pix_format_from_mbus - Ancillary routine that fills a &struct
+ *     v4l2_ext_pix_format fields from a &struct v4l2_mbus_framefmt.
+ *
+ * @pix_fmt:   pointer to &struct v4l2_ext_pix_format to be filled
+ * @mbus_fmt:  pointer to &struct v4l2_mbus_framefmt to be used as model
+ */
+static inline void
+v4l2_fill_ext_pix_format_from_mbus(struct v4l2_ext_pix_format *pix_fmt,
+				   const struct v4l2_mbus_framefmt *mbus_fmt)
+{
+	pix_fmt->width = mbus_fmt->width;
+	pix_fmt->height = mbus_fmt->height;
+	pix_fmt->field = mbus_fmt->field;
+	pix_fmt->colorspace = mbus_fmt->colorspace;
+	pix_fmt->ycbcr_enc = mbus_fmt->ycbcr_enc;
+	pix_fmt->quantization = mbus_fmt->quantization;
+	pix_fmt->xfer_func = mbus_fmt->xfer_func;
+}
+
+/**
+ * v4l2_fill_mbus_format_ext - Ancillary routine that fills a &struct
+ *     v4l2_mbus_framefmt from a &struct v4l2_ext_pix_format.
+ *
+ * @mbus_fmt:  pointer to &struct v4l2_mbus_framefmt to be filled
+ * @pix_fmt:   pointer to &struct v4l2_ext_pix_format to be used as model
+ * @code:      data format code (from &enum v4l2_mbus_pixelcode)
+ */
+static inline void
+v4l2_fill_mbus_format_ext(struct v4l2_mbus_framefmt *mbus_fmt,
+			  const struct v4l2_ext_pix_format *pix_fmt, u32 code)
+{
+	mbus_fmt->width = pix_fmt->width;
+	mbus_fmt->height = pix_fmt->height;
+	mbus_fmt->field = pix_fmt->field;
+	mbus_fmt->colorspace = pix_fmt->colorspace;
+	mbus_fmt->ycbcr_enc = pix_fmt->ycbcr_enc;
+	mbus_fmt->quantization = pix_fmt->quantization;
+	mbus_fmt->xfer_func = pix_fmt->xfer_func;
+	mbus_fmt->code = code;
+}
+
 #endif
-- 
2.17.1

