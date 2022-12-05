Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84110642792
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiLELfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiLELfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:35:34 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385F319C39
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:35:33 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NQhLW55hCz5BNRf;
        Mon,  5 Dec 2022 19:35:31 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl2.zte.com.cn with SMTP id 2B5BZQN8074822;
        Mon, 5 Dec 2022 19:35:26 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 5 Dec 2022 19:35:28 +0800 (CST)
Date:   Mon, 5 Dec 2022 19:35:28 +0800 (CST)
X-Zmail-TransId: 2b04638dd780ffffffffbef9d1e3
X-Mailer: Zmail v1.0
Message-ID: <202212051935289159302@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <maarten.lankhorst@linux.intel.com>
Cc:     <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRybS9tb2RlczogdXNlIHN0cnNjcHkoKSB0byBpbnN0ZWFkIG9mIHN0cm5jcHkoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B5BZQN8074822
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 638DD783.000 by FangMail milter!
X-FangMail-Envelope: 1670240131/4NQhLW55hCz5BNRf/638DD783.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638DD783.000/4NQhLW55hCz5BNRf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/gpu/drm/drm_modes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 3c8034a8c27b..cb08b247d8c3 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -2081,8 +2081,7 @@ void drm_mode_convert_to_umode(struct drm_mode_modeinfo *out,
 		break;
 	}

-	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
-	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
+	strscpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
 }

 /**
@@ -2123,8 +2122,7 @@ int drm_mode_convert_umode(struct drm_device *dev,
 	 * useful for the kernel->userspace direction anyway.
 	 */
 	out->type = in->type & DRM_MODE_TYPE_ALL;
-	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
-	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
+	strscpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);

 	/* Clearing picture aspect ratio bits from out flags,
 	 * as the aspect-ratio information is not stored in
-- 
2.15.2
