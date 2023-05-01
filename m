Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC4C6F2CC0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjEADEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjEADDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:03:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF51212C;
        Sun, 30 Apr 2023 20:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51365616DB;
        Mon,  1 May 2023 02:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F44C433A7;
        Mon,  1 May 2023 02:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682909988;
        bh=BtlnXcSRm/rre6eCabVHchSdoSEbnBIthAn8DRjtqNY=;
        h=From:To:Cc:Subject:Date:From;
        b=StCvtOd7RGUguulXonFQapNVUXlDND26VffdaaNET+HLkCo3vwY+07XHAqefMFMPQ
         Bl7vt1xZ7WNDFmYLcIqihWcNgmDPz7CS6TvKafT4Mj5YQU6Q+7uuW9u0+GEnKj6qIO
         WJfEKoOnMIZSxJD0y38+G3DSWbD1ECHtWlSULrV6ejmNBuAC1YSsxn2WaO+hs7lZ49
         192bPl+IE758wduoJU163sNZfD6oKGLfJayXl9fOW3x20zYLcLCTcC3IS0ueWDonKw
         64Ki0qDWnSneiCBVzpVpwl/Z6+Xop+iNdXepsZMlMQ4dGbO5IARIWlDA8RTlnTIo2M
         jWP8fopY6RD7w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Iaroslav Boliukin <iam@lach.pw>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sasha Levin <sashal@kernel.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.2 01/37] drm/displayid: add displayid_get_header() and check bounds better
Date:   Sun, 30 Apr 2023 22:59:09 -0400
Message-Id: <20230501025945.3253774-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 5bacecc3c56131c31f18b23d366f2184328fd9cf ]

Add a helper to get a pointer to struct displayid_header. To be
pedantic, add buffer overflow checks to not touch the base if that
itself would overflow.

Cc: Iaroslav Boliukin <iam@lach.pw>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/4a03b3a5132642d3cdb6d4c2641422955a917292.1676580180.git.jani.nikula@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_displayid.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_displayid.c b/drivers/gpu/drm/drm_displayid.c
index 38ea8203df45b..7d03159dc1461 100644
--- a/drivers/gpu/drm/drm_displayid.c
+++ b/drivers/gpu/drm/drm_displayid.c
@@ -7,13 +7,28 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_print.h>
 
+static const struct displayid_header *
+displayid_get_header(const u8 *displayid, int length, int index)
+{
+	const struct displayid_header *base;
+
+	if (sizeof(*base) > length - index)
+		return ERR_PTR(-EINVAL);
+
+	base = (const struct displayid_header *)&displayid[index];
+
+	return base;
+}
+
 static int validate_displayid(const u8 *displayid, int length, int idx)
 {
 	int i, dispid_length;
 	u8 csum = 0;
 	const struct displayid_header *base;
 
-	base = (const struct displayid_header *)&displayid[idx];
+	base = displayid_get_header(displayid, length, idx);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	DRM_DEBUG_KMS("base revision 0x%x, length %d, %d %d\n",
 		      base->rev, base->bytes, base->prod_id, base->ext_count);
-- 
2.39.2

