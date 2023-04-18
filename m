Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6EE6E68FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjDRQHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjDRQHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:07:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26CC13C1C;
        Tue, 18 Apr 2023 09:07:27 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:9493:29e1:3046:42cb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9A05466031FE;
        Tue, 18 Apr 2023 17:07:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681834045;
        bh=XMnjsK9TyGzaIqPnJPWEByUo3f+u5pJ1NqGe5xX/uh4=;
        h=From:To:Cc:Subject:Date:From;
        b=AQudzXPMulW+lyaZpK/OqrcgQJxH576MUnZgd5t0J/Z0Ma9IQnbdibv5ok9g7gEYd
         jdt3i2tjT9LOYG29O4MlkqIlIDKRS/rSARuxcXs8g8RklQPyAvXcW6bQzDQpY57HPH
         1E3D4VXb0BIkPVOYTbZfzEbCAQxvRhUjwVLpK5HoX5cRur/AX+5PqRAzvdVhL7ZDpS
         Vb2cKADCBlwFTMHddhc6AC4DPUWfF+hTp1C76fMT5RLWL5FYvNPUXD8ic6sz5GP88F
         kL++/5F+ZxlEYKWw7gDYWO/vHePX0ExnDIQ5AkQu1N4ptvjR/mzMqySnUSIJ/WlbWk
         8ygUoDqk7ll9w==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] media: uapi: HEVC: Add num_delta_pocs_of_ref_rps_idx field
Date:   Tue, 18 Apr 2023 18:07:17 +0200
Message-Id: <20230418160717.743517-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers firmwares parse by themselves slice header and need
num_delta_pocs_of_ref_rps_idx value to parse slice header
short_term_ref_pic_set().
Use one of the 4 reserved bytes to store this value without
changing the v4l2_ctrl_hevc_decode_params structure size and padding.

This value also exist in DXVA API.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../userspace-api/media/v4l/ext-ctrls-codec-stateless.rst  | 7 +++++++
 include/uapi/linux/v4l2-controls.h                         | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
index 3d8411acd5b8..92ce3e126929 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
@@ -2923,6 +2923,13 @@ This structure contains all loop filter related parameters. See sections
       - ``poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
       - PocLtCurr as described in section 8.3.2 "Decoding process for reference
         picture set": provides the index of the long term references in DPB array.
+    * - __u8
+      - ``num_delta_pocs_of_ref_rps_idx``
+      - When the short_term_ref_pic_set_sps_flag in the slice header is equal to 0,
+        it is the same than derived value NumDeltaPocs[RefRpsIdx]. It can be used to parse
+        the RPS data in slice headers instead of skipping it with @short_term_ref_pic_set_size.
+        When the value of short_term_ref_pic_set_sps_flag in the slice header is
+        equal to 1, num_delta_pocs_of_ref_rps_idx shall be set to 0.
     * - struct :c:type:`v4l2_hevc_dpb_entry`
       - ``dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
       - The decoded picture buffer, for meta-data about reference frames.
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 5e80daa4ffe0..7bf59a87a1bf 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -2385,6 +2385,9 @@ struct v4l2_ctrl_hevc_slice_params {
  * @poc_st_curr_after: provides the index of the short term after references
  *		       in DPB array
  * @poc_lt_curr: provides the index of the long term references in DPB array
+ * @num_delta_pocs_of_ref_rps_idx: same as the derived value NumDeltaPocs[RefRpsIdx],
+ *				   can be used to parse the RPS data in slice headers
+ *				   instead of skipping it with @short_term_ref_pic_set_size.
  * @reserved: padding field. Should be zeroed by applications.
  * @dpb: the decoded picture buffer, for meta-data about reference frames
  * @flags: see V4L2_HEVC_DECODE_PARAM_FLAG_{}
@@ -2400,7 +2403,8 @@ struct v4l2_ctrl_hevc_decode_params {
 	__u8	poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u8	reserved[4];
+	__u8	num_delta_pocs_of_ref_rps_idx;
+	__u8	reserved[3];
 	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u64	flags;
 };
-- 
2.34.1

