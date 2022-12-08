Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518D6469D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 08:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiLHHpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 02:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLHHpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 02:45:40 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B23EF08;
        Wed,  7 Dec 2022 23:45:39 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NSR5d2CGCz8R039;
        Thu,  8 Dec 2022 15:45:25 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl1.zte.com.cn with SMTP id 2B87jFIJ078346;
        Thu, 8 Dec 2022 15:45:15 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 8 Dec 2022 15:45:17 +0800 (CST)
Date:   Thu, 8 Dec 2022 15:45:17 +0800 (CST)
X-Zmail-TransId: 2af96391960dffffffffc6c081d8
X-Mailer: Zmail v1.0
Message-ID: <202212081545178689771@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <hdegoede@redhat.com>
Cc:     <malattia@linux.it>, <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBwbGF0Zm9ybS94ODY6IHNvbnktbGFwdG9wOiBDb252ZXJ0IHRvIHVzZSBzeXNmc19lbWl0X2F0KCkgQVBJ?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B87jFIJ078346
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63919615.000 by FangMail milter!
X-FangMail-Envelope: 1670485525/4NSR5d2CGCz8R039/63919615.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63919615.000/4NSR5d2CGCz8R039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/platform/x86/sony-laptop.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index a19aac70252f..7156ae2ad196 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -820,10 +820,9 @@ static ssize_t sony_nc_handles_show(struct device *dev,
 	int i;

 	for (i = 0; i < ARRAY_SIZE(handles->cap); i++) {
-		len += scnprintf(buffer + len, PAGE_SIZE - len, "0x%.4x ",
-				handles->cap[i]);
+		len += sysfs_emit_at(buffer, len, "0x%.4x ", handles->cap[i]);
 	}
-	len += scnprintf(buffer + len, PAGE_SIZE - len, "\n");
+	len += sysfs_emit_at(buffer, len, "\n");

 	return len;
 }
@@ -2173,10 +2172,9 @@ static ssize_t sony_nc_thermal_profiles_show(struct device *dev,

 	for (cnt = 0; cnt < THM_PROFILE_MAX; cnt++) {
 		if (!cnt || (th_handle->profiles & cnt))
-			idx += scnprintf(buffer + idx, PAGE_SIZE - idx, "%s ",
-					snc_thermal_profiles[cnt]);
+			idx += sysfs_emit_at(buffer, idx, "%s ", snc_thermal_profiles[cnt]);
 	}
-	idx += scnprintf(buffer + idx, PAGE_SIZE - idx, "\n");
+	idx += sysfs_emit_at(buffer, idx, "\n");

 	return idx;
 }
-- 
2.25.1
