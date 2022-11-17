Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0945B62D3B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiKQHAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiKQHAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:00:48 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E566EB5C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:00:47 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCW5p2x9Zz8R040;
        Thu, 17 Nov 2022 15:00:46 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AH70cgR059705;
        Thu, 17 Nov 2022 15:00:38 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 17 Nov 2022 15:00:40 +0800 (CST)
Date:   Thu, 17 Nov 2022 15:00:40 +0800 (CST)
X-Zmail-TransId: 2af96375dc18ffffffffb19f3ea9
X-Mailer: Zmail v1.0
Message-ID: <202211171500403515273@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <maarten.lankhorst@linux.intel.com>
Cc:     <thierry.reding@gmail.com>, <sam@ravnborg.org>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRybS9wYW5lbDogVXNlIGRldmljZV9tYXRjaF9vZl9ub2RlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AH70cgR059705
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 6375DC1E.000 by FangMail milter!
X-FangMail-Envelope: 1668668446/4NCW5p2x9Zz8R040/6375DC1E.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6375DC1E.000/4NCW5p2x9Zz8R040
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with device_match_of_node().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/drm_panel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index f634371c717a..ba66ac1ad88a 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -250,7 +250,7 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
 	mutex_lock(&panel_lock);

 	list_for_each_entry(panel, &panel_list, list) {
-		if (panel->dev->of_node == np) {
+		if (device_match_of_node(panel->dev, np)) {
 			mutex_unlock(&panel_lock);
 			return panel;
 		}
-- 
2.25.1
