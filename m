Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D7E6A5297
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 06:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjB1FPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 00:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1FPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 00:15:43 -0500
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A284C1E5EE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 21:15:36 -0800 (PST)
X-QQ-mid: bizesmtp65t1677561081t0n6rofl
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 28 Feb 2023 13:11:13 +0800 (CST)
X-QQ-SSF: 0040000000200080C000B00A0000000
X-QQ-FEAT: 7jw2iSiCazq7s/yFLHQYjjIiI+JaTbroy9lUTJtc5mR9gxqGwT8n1jK2q3jX+
        i+SeNDSJiEbv62nThphTbQKInjdDWitDUzvgWSa+6dCZmAThIvzbmEqt8KHdvSlMrecxi9a
        5Vw0V2FDAJCsNMzVKJjwNkKO5mwpqc4d9yBJWZixMptbZSRLSvs90QuCE7BuealyuS6T96W
        w0gxiB1zbN6kUte7Fdu2rz4PMcCZvDiDDjhIeOpdmmfCQqboJtLk6qmX65mKGvfSqaMGFXS
        J8l6Ube20624dbdD8uEGb5uksatgQkUI2CUX/MIN8bPLaQ3ZUyUSSAGZFHrAP8GT+dEStaU
        nliANT2u3AfLA2Pfd0n/QvZ4Rj8o40aJY0SXzwa0RN+kpwQjqUZeGSfIgZzcFuIXs70rgUu
        7Af9HJheuhtAu+mfNFJNHlN0KZM0E+j/
X-QQ-GoodBg: 2
From:   Yuanzhi Wang <wangyuanzhi@uniontech.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        mario.limonciello@amd.com, Bokun.Zhang@amd.com,
        tzimmermann@suse.de, hdegoede@redhat.com, jingyuwang_vip@163.com,
        rafael.j.wysocki@intel.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Yuanzhi Wang <wangyuanzhi@uniontech.com>
Subject: [PATCH v2] amdgpu: add a filter condition when set brightness
Date:   Tue, 28 Feb 2023 13:11:07 +0800
Message-Id: <20230228051107.32037-1-wangyuanzhi@uniontech.com>
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

There is a lenovo ThinkBook 14 G3 ACL notebook, when
the laptop is plugged into AC power supply, the
brightness obtained ACPI may be smaller than current
brightness.As a result the screen becomes dark，this is
not what people want. So we should add So we should
filter out very small brightness values obtained from ACPI

Signed-off-by: Yuanzhi Wang <wangyuanzhi@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index d4196fcb85a0..20e7a178765d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -406,6 +406,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 {
 	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 	int count;
+	int old_brightness;
 
 	DRM_DEBUG_DRIVER("event, device_class = %s, type = %#x\n",
 			event->device_class, event->type);
@@ -443,7 +444,14 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 				 * hardwired to post BACKLIGHT_UPDATE_SYSFS.
 				 * It probably should accept 'reason' parameter.
 				 */
-				backlight_device_set_brightness(atif->bd, req.backlight_level);
+				old_brightness = backlight_get_brightness(atif->bd);
+				if (old_brightness > req.backlight_level)
+					DRM_WARN(
+						"Old brightness %d is larger than ACPI brightness %d\n",
+						 old_brightness, req.backlight_level);
+				else
+					backlight_device_set_brightness(atif->bd,
+						 req.backlight_level);
 			}
 		}
 
-- 
2.20.1

