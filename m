Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2074C65538E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 19:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiLWSRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 13:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiLWSRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 13:17:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0855B1EEDE;
        Fri, 23 Dec 2022 10:17:07 -0800 (PST)
Received: from whitebuilder.lan (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3045D6602CDF;
        Fri, 23 Dec 2022 18:17:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671819425;
        bh=WtkH3zd/DfeHPZ0Re8eGGq82FSkjo7m3N6d2l6hBATE=;
        h=From:To:Cc:Subject:Date:From;
        b=dII6bpvdM6HM6sNU54FfXTO4/cp04kUdbmAG9Ts3HYVnzAJJVe1yPWSg4KhclwCP/
         AN+tcSg2VzuAXtxQwt+S7is5T+FMi161WvIRGgU2HtwDBMrfpZPCUZQ4ATlfcKM97J
         BA7Y8+ojbBSsHHwInjNQVy2i2XjRLoLMMPHYUqQJ9RRP+iTwSmS+bt0gThlPS5XC8B
         0bKPRZrKtgs8ocu9L5rLg01IZiTyvx38+pTn4BIigb32TkcIlEXUHjWIKUIz00CmRQ
         cPJWTeBkhH3mJj4+wD8hzFZXfKPdM8KMSMadYjXUQhtz5XkuoUK5Zs/U++DCDl6dKr
         M3D0sKG4/3nKA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Robert Mader <robert.mader@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hantro: Fix JPEG encoder ENUM_FRMSIZE on RK3399
Date:   Fri, 23 Dec 2022 13:16:47 -0500
Message-Id: <20221223181647.720918-1-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 79c987de8b354, enumerating framesize on format set with "MODE_NONE"
(any raw formats) is reporting an invalid frmsize.

  Size: Stepwise 0x0 - 0x0 with step 0/0

Before this change, the driver would return EINVAL, which is also invalid but
worked in GStreamer. The original intent was not to implement it, hence the
-ENOTTY return in this change. While drivers should implement ENUM_FRMSIZE for
all formats and queues, this change is limited in scope to fix the regression.

This fixes taking picture in Gnome Cheese software, or any software using
GSteamer to encode JPEG with hardware acceleration.

Fixes: 79c987de8b354 ("media: hantro: Use post processor scaling capacities")
Reported-by: Robert Mader <robert.mader@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 2c7a805289e7b..30e650edaea8a 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -161,8 +161,11 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 	}
 
 	/* For non-coded formats check if postprocessing scaling is possible */
-	if (fmt->codec_mode == HANTRO_MODE_NONE && hantro_needs_postproc(ctx, fmt)) {
-		return hanto_postproc_enum_framesizes(ctx, fsize);
+	if (fmt->codec_mode == HANTRO_MODE_NONE) {
+		if (hantro_needs_postproc(ctx, fmt))
+			return hanto_postproc_enum_framesizes(ctx, fsize);
+		else
+			return -ENOTTY;
 	} else if (fsize->index != 0) {
 		vpu_debug(0, "invalid frame size index (expected 0, got %d)\n",
 			  fsize->index);
-- 
2.38.1

