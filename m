Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40AD6A3BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjB0Hkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjB0Hkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:40:45 -0500
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9E211153
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:40:41 -0800 (PST)
X-QQ-mid: bizesmtp89t1677483605t3p8ysbx
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 27 Feb 2023 15:39:57 +0800 (CST)
X-QQ-SSF: 0040000000200070C000B00A0000000
X-QQ-FEAT: 3GqwhZhMvTvfQjpR/B2tBV5yWXh5qI9xpTn1g/xB6K4m9QHxfp3TKCpkbOi8u
        SX5oUZA8JPczDI7eBe50wCktPsgIy1DvR6QkcJz8aadvplJS9cG3FdSW4H9Aszizw9J8jyx
        s2nfL1FENw50Bg44lyJOzCnosxyJ/cbCNojhlE4wCQSdjqrFTeyOJnZ9cag+w2jDY+8NN9K
        Do2eaGpNa70chPZuBddq2qdshf62XTDae70QLL6kbfih0XFnnBFBAubjZ2xKHXdtWNT2Mr7
        XHs2720dKbvcEZqugi94t0x+/Gnh/QRM1p1InHydsKA5KZBY4HrKRhRD8EuyMguxfNDPguV
        pgOrrGW0l8Q0ANch2M1QkXI4fLqARvZboCI0p6vfu8cROaBM9KH9NxY9zL11G0wXEtlKGZC
        awVGfvFsflY=
X-QQ-GoodBg: 2
From:   Yuanzhi Wang <wangyuanzhi@uniontech.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        mario.limonciello@amd.com, Bokun.Zhang@amd.com,
        tzimmermann@suse.de, hdegoede@redhat.com, jingyuwang_vip@163.com,
        rafael.j.wysocki@intel.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Yuanzhi Wang <wangyuanzhi@uniontech.com>
Subject: [PATCH] amdgpu: add a filter condition when set brightness
Date:   Mon, 27 Feb 2023 15:39:53 +0800
Message-Id: <20230227073953.326-1-wangyuanzhi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the laptop is plugged into AC or DC power supply,
the brightness obtained ACPI may be smaller than current
brightness.As a result the screen becomes dark，this is
not what people want.

Signed-off-by: Yuanzhi Wang <wangyuanzhi@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index d4196fcb85a0..93f1567028c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -406,6 +406,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 {
 	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 	int count;
+	int old_brightness;
 
 	DRM_DEBUG_DRIVER("event, device_class = %s, type = %#x\n",
 			event->device_class, event->type);
@@ -443,7 +444,13 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 				 * hardwired to post BACKLIGHT_UPDATE_SYSFS.
 				 * It probably should accept 'reason' parameter.
 				 */
-				backlight_device_set_brightness(atif->bd, req.backlight_level);
+				old_brightness = backlight_get_brightness(atif->bd);
+				if (old_brightness > req.backlight_level)
+					DRM_WARN("old brightness %d is greater than ACPI brightness
+						%d\n", old_brightness, req.backlight_level);
+				else
+					backlight_device_set_brightness(atif->bd,
+						req.backlight_level);
 			}
 		}
 
-- 
2.20.1

