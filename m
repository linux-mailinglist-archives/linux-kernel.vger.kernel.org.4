Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC90656210
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 12:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiLZLGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 06:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiLZLGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 06:06:00 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABD6B57
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 03:05:59 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NgZhj61nyz8R03d;
        Mon, 26 Dec 2022 19:05:57 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
        by mse-fl1.zte.com.cn with SMTP id 2BQB5ip4062779;
        Mon, 26 Dec 2022 19:05:44 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 26 Dec 2022 19:05:47 +0800 (CST)
Date:   Mon, 26 Dec 2022 19:05:47 +0800 (CST)
X-Zmail-TransId: 2b0363a9800bffffffffb9415792
X-Mailer: Zmail v1.0
Message-ID: <202212261905476729002@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <larry.finger@lwfinger.net>
Cc:     <phil@philpotter.co.uk>, <paskripkin@gmail.com>,
        <martin@kaiser.cx>, <abdun.nihaal@gmail.com>,
        <straube.linux@gmail.com>, <sandsch@northvilleschools.net>,
        <error27@gmail.com>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHN0YWdpbmc6IHI4MTg4ZXU6IHVzZSBzdHJzY3B5KCkgdG8gaW5zdGVhZCBvZiBzdHJuY3B5KCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2BQB5ip4062779
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63A98015.001 by FangMail milter!
X-FangMail-Envelope: 1672052757/4NgZhj61nyz8R03d/63A98015.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63A98015.001/4NgZhj61nyz8R03d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL-terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 8e9b7b0664bc..e0a819970546 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3061,8 +3061,7 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 		char *reg_ifname;
 		reg_ifname = padapter->registrypriv.if2name;

-		strncpy(rereg_priv->old_ifname, reg_ifname, IFNAMSIZ);
-		rereg_priv->old_ifname[IFNAMSIZ - 1] = 0;
+		strscpy(rereg_priv->old_ifname, reg_ifname, IFNAMSIZ);
 	}

 	if (wrqu->data.length > IFNAMSIZ)
@@ -3084,8 +3083,7 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 		rtw_ips_mode_req(&padapter->pwrctrlpriv, rereg_priv->old_ips_mode);
 	}

-	strncpy(rereg_priv->old_ifname, new_ifname, IFNAMSIZ);
-	rereg_priv->old_ifname[IFNAMSIZ - 1] = 0;
+	strscpy(rereg_priv->old_ifname, new_ifname, IFNAMSIZ);

 	if (!memcmp(new_ifname, "disable%d", 9)) {
 		/*  free network queue for Android's timming issue */
-- 
2.15.2
