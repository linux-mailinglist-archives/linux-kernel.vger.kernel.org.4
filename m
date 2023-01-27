Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8995967EFF8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjA0Uvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjA0Uvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:51:44 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FEF7EFEE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674852690; bh=r9cSBMJn3mflOnLsA3kDjd8yrjkKnm2dAF4ZyKs29kM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=MHMtbPasMSOeq8cITgqud6o5CzxVy9BQenqnHND+tbn1l1lhHFXaytnKCwUaujVEi
         pWeVwN542Eg2KjKx1CmJpbBTLH1BMZR6In8uYl9WXpzNmHECRP2pdGNrrBJB954+Px
         h2fwo65Bglntb2HoG65hrBhTZW7Y+M48jf/rAngw=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 27 Jan 2023 21:51:30 +0100 (CET)
X-EA-Auth: 1zJc8Axf3sxItJw3RXYEjDVc497uFzsAFgO+gLFtm8VMZrSooyg8jW3dWmc5Q86OzEgdtkYdkiEUW3tRKFAqdHgMkJfmXOHT
Date:   Sat, 28 Jan 2023 02:21:26 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] drm/arm/malidp: use sysfs_emit in show function callback
Message-ID: <Y9Q5Tt8c9WBDxeyV@ubun2204.myguest.virtualbox.org>
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
of sprintf() family functions.
Issue identified using the device_attr_show.cocci Coccinelle script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 589c1c66a6dc..cf040e2e9efe 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -649,7 +649,7 @@ static ssize_t core_id_show(struct device *dev, struct device_attribute *attr,
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct malidp_drm *malidp = drm_to_malidp(drm);
 
-	return snprintf(buf, PAGE_SIZE, "%08x\n", malidp->core_id);
+	return sysfs_emit(buf, "%08x\n", malidp->core_id);
 }
 
 static DEVICE_ATTR_RO(core_id);
-- 
2.34.1



