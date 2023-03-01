Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDA16A7460
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCATgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCATf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:35:58 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D622134332
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 11:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677699348; bh=wMm9SK0T1X6wjNTxe4InzSuoAuJv/ovXH3Yd9x3INdU=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=M+bk0agZs/ip9NlWKZDeUxfjq8j6MC+6xVMMX5fU/IoWhEkbNWW1yC9t5wgOcujW3
         9UpzH2khiWtofRavCKeOROPNzJ7F1MwDHi1MQC8lAMQrLQvxFJRM/n+qZ371YI/pA4
         ryeabzdxFT5WjBOu4Wulvt4pgZaD1gbmA35PMcD0=
Received: by b221-2.in.mailobj.net [192.168.90.22] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Wed,  1 Mar 2023 20:35:48 +0100 (CET)
X-EA-Auth: PldJwNJFnC6SMwwwKTtAv1uOQAxuwnwELDsuScmNAdkFQxNVkfwbnt8OHmVTfN7luEAx/wUZHVjyHoFVwndeyg==
Date:   Thu, 2 Mar 2023 01:05:41 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH RESEND] drm/nouveau/hwmon: Use sysfs_emit in show function
 callsbacks
Message-ID: <Y/+pDaHOgG1x8Py2@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/filesystems/sysfs.rst, the show() callback
function of kobject attributes should strictly use sysfs_emit() instead
of sprintf() family functions. So, make this change.
Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note:
   Resending the patch for review and feedback. No functional changes.


 drivers/gpu/drm/nouveau/nouveau_hwmon.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
index a7db7c31064b..e844be49e11e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
@@ -41,7 +41,7 @@ static ssize_t
 nouveau_hwmon_show_temp1_auto_point1_pwm(struct device *d,
 					 struct device_attribute *a, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", 100);
+	return sysfs_emit(buf, "%d\n", 100);
 }
 static SENSOR_DEVICE_ATTR(temp1_auto_point1_pwm, 0444,
 			  nouveau_hwmon_show_temp1_auto_point1_pwm, NULL, 0);
@@ -54,8 +54,8 @@ nouveau_hwmon_temp1_auto_point1_temp(struct device *d,
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nvkm_therm *therm = nvxx_therm(&drm->client.device);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-	      therm->attr_get(therm, NVKM_THERM_ATTR_THRS_FAN_BOOST) * 1000);
+	return sysfs_emit(buf, "%d\n",
+			  therm->attr_get(therm, NVKM_THERM_ATTR_THRS_FAN_BOOST) * 1000);
 }
 static ssize_t
 nouveau_hwmon_set_temp1_auto_point1_temp(struct device *d,
@@ -87,8 +87,8 @@ nouveau_hwmon_temp1_auto_point1_temp_hyst(struct device *d,
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nvkm_therm *therm = nvxx_therm(&drm->client.device);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-	 therm->attr_get(therm, NVKM_THERM_ATTR_THRS_FAN_BOOST_HYST) * 1000);
+	return sysfs_emit(buf, "%d\n",
+			  therm->attr_get(therm, NVKM_THERM_ATTR_THRS_FAN_BOOST_HYST) * 1000);
 }
 static ssize_t
 nouveau_hwmon_set_temp1_auto_point1_temp_hyst(struct device *d,
-- 
2.34.1



