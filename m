Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58956455BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiLGIq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiLGIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:44:52 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1AE326FF;
        Wed,  7 Dec 2022 00:44:28 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRrSB5GZ7z8RV6M;
        Wed,  7 Dec 2022 16:44:26 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl1.zte.com.cn with SMTP id 2B78iEVJ043223;
        Wed, 7 Dec 2022 16:44:14 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 16:44:17 +0800 (CST)
Date:   Wed, 7 Dec 2022 16:44:17 +0800 (CST)
X-Zmail-TransId: 2af96390526103d06ca3
X-Mailer: Zmail v1.0
Message-ID: <202212071644171074630@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <dmitry.torokhov@gmail.com>
Cc:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jeff@labundy.com>
Subject: =?UTF-8?B?W1BBVENIXSBJbnB1dDogQ29udmVydCB0byB1c2Ugc3lzZnNfZW1pdF9hdCgpIEFQSQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B78iEVJ043223
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 6390526A.001 by FangMail milter!
X-FangMail-Envelope: 1670402666/4NRrSB5GZ7z8RV6M/6390526A.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6390526A.001/4NRrSB5GZ7z8RV6M
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
 drivers/input/vivaldi-fmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/vivaldi-fmap.c b/drivers/input/vivaldi-fmap.c
index 6dae83d96806..ac5edc4d2ab0 100644
--- a/drivers/input/vivaldi-fmap.c
+++ b/drivers/input/vivaldi-fmap.c
@@ -27,10 +27,9 @@ ssize_t vivaldi_function_row_physmap_show(const struct vivaldi_data *data,
 		return 0;

 	for (i = 0; i < data->num_function_row_keys; i++)
-		size += scnprintf(buf + size, PAGE_SIZE - size,
-				  "%s%02X", size ? " " : "", physmap[i]);
+		size += sysfs_emit_at(buf, size, "%s%02X", size ? " " : "", physmap[i]);
 	if (size)
-		size += scnprintf(buf + size, PAGE_SIZE - size, "\n");
+		size += sysfs_emit_at(buf, size, "\n");

 	return size;
 }
-- 
2.25.1
