Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBDE734907
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 00:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFRWBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 18:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjFRWB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 18:01:29 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3905C5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=knW5hfOdRlNb6ad4KcvWMFXEOrQEnk5DYqTPo5HmSZE=;
        b=nwrZNklbIibuv/B5ivfm6EIkAUlnO1nHZq/SerLKzN45UjsIjnkNqYVRDnKgzpo227Hq
        oHCw00h31gvAEBoLn+WoX33Z5LK+1BOoDBa/OmuSU9SjhoBuPQDX5uQzHJeWkLSCIcTQ6B
        aT7ZvIaH3hj7mnUyUiF6DCXCyDumgtdFcO32dhJMdsvK6NA6l6dIWadlAiKBvtGAn/MI53
        QlkbXGstcmLz4OdfcjxuBpN4CZwI01g1wLfkzNj9C9jzVlyjl4cQV/06Yu6x9WRXg7a9UF
        v/mHzUf9i2ZafNsom3UKIrevbGPEZyWL4no+oeNVpLsHMsnIRGpFuZyPNwo4uZug==
Received: by filterdrecv-84b96456cb-fbbmz with SMTP id filterdrecv-84b96456cb-fbbmz-1-648F7EB6-30
        2023-06-18 22:01:26.625714618 +0000 UTC m=+3363784.259579225
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-5 (SG)
        with ESMTP
        id oYfsfJYrSiSN_35tLvMcIg
        Sun, 18 Jun 2023 22:01:26.169 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 1/2] drm/fourcc: Add NV20 and NV30 YUV formats
Date:   Sun, 18 Jun 2023 22:01:27 +0000 (UTC)
Message-Id: <20230618220122.3911297-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230618220122.3911297-1-jonas@kwiboo.se>
References: <20230618220122.3911297-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h4iCR0c7B5q6rx1oD?=
 =?us-ascii?Q?W9+4R8Lw7Z7xtsoiXwBXqJPoFzEsTzCoor3Hb++?=
 =?us-ascii?Q?Z7TaqcwWsh9e86dziBnyfLh8E9iPkhS=2FUYIYEWi?=
 =?us-ascii?Q?EPKTGYd+l+=2F0caCf9XHQ+En1yXRCjBhzfPbDlRC?=
 =?us-ascii?Q?aiOD7HAlXJMyQhm81zUXjjK0bjyv+cxeCAGW3u?=
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM_FORMAT_NV20 and DRM_FORMAT_NV30 formats is the 2x1 and non-subsampled
variant of NV15, a 10-bit 2-plane YUV format that has no padding between
components. Instead, luminance and chrominance samples are grouped into 4s
so that each group is packed into an integer number of bytes:

YYYY = UVUV = 4 * 10 bits = 40 bits = 5 bytes

The '20' and '30' suffix refers to the optimum effective bits per pixel
which is achieved when the total number of luminance samples is a multiple
of 4.

V2: Added NV30 format

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 8 ++++++++
 include/uapi/drm/drm_fourcc.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 0f17dfa8702b..193cf8ed7912 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -299,6 +299,14 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		  .num_planes = 2, .char_per_block = { 5, 5, 0 },
 		  .block_w = { 4, 2, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
 		  .vsub = 2, .is_yuv = true },
+		{ .format = DRM_FORMAT_NV20,		.depth = 0,
+		  .num_planes = 2, .char_per_block = { 5, 5, 0 },
+		  .block_w = { 4, 2, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
+		  .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_NV30,		.depth = 0,
+		  .num_planes = 2, .char_per_block = { 5, 5, 0 },
+		  .block_w = { 4, 2, 0 }, .block_h = { 1, 1, 0 }, .hsub = 1,
+		  .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_Q410,		.depth = 0,
 		  .num_planes = 3, .char_per_block = { 2, 2, 2 },
 		  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 1,
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 8db7fd3f743e..3151f1fc7ebb 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -323,6 +323,8 @@ extern "C" {
  * index 1 = Cr:Cb plane, [39:0] Cr1:Cb1:Cr0:Cb0 little endian
  */
 #define DRM_FORMAT_NV15		fourcc_code('N', 'V', '1', '5') /* 2x2 subsampled Cr:Cb plane */
+#define DRM_FORMAT_NV20		fourcc_code('N', 'V', '2', '0') /* 2x1 subsampled Cr:Cb plane */
+#define DRM_FORMAT_NV30		fourcc_code('N', 'V', '3', '0') /* non-subsampled Cr:Cb plane */
 
 /*
  * 2 plane YCbCr MSB aligned
-- 
2.40.1

