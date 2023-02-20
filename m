Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C738469CF8E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjBTOjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjBTOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:39:08 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5528FBB81
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Q9zHG
        0kXKM7EYS1+RRwfxxlcds8xLakH1kfaDLZ5UTI=; b=TiCMVWrajKD84+4Lopo11
        MBbTKXVBvS9qg9QHqL4kJMOSDp+hy3XsWKL/xY5NTrVH98REuuJwQhwJsisQyDFu
        vvUwG9h7FW7ol7cec9KFCeiBk55eZp/vgfLbJVvO6OMgvpCivOJj1JYXny5tnkkq
        HmKZ/eO3d1Ck8eOEPBNGMM=
Received: from localhost (unknown [122.206.190.60])
        by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3SnTKhfNjP8MQAg--.33396S2;
        Mon, 20 Feb 2023 22:38:02 +0800 (CST)
From:   Shibo Li <zzutcyha@163.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Shibo Li <zzutcyha@163.com>
Subject: [PATCH] staging: rtl8712: Fix Sparse warnings in rtl871x_ioctl_linux.c
Date:   Mon, 20 Feb 2023 14:37:58 +0000
Message-Id: <20230220143758.4396-1-zzutcyha@163.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3SnTKhfNjP8MQAg--.33396S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWDZFy3Xr43JryDKF1Utrb_yoW8WrW7pr
        s8Wa4qyr4kWFnIg3ykJFn5ur15WF10grnYk3s7t34agF1rAr1agr4Iva4IqrsxGry3Z3WY
        yF1UJr4Yq34YkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRnZ2xUUUUU=
X-Originating-IP: [122.206.190.60]
X-CM-SenderInfo: x22x3ux1kdqiywtou0bp/1tbiZQ8cbF8ZW-54lgAAsX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warning in rtl871x_ioctl_linux.c

WARNING: Avoid multiple line dereference - prefer 'pnetwork->network.InfrastructureMode'
+                                       if (pnetwork->network.
+                                               InfrastructureMode

WARNING: Avoid multiple line dereference - prefer 'padapter->mlmepriv.cur_network.network'
+                                               padapter->mlmepriv.
+                                               cur_network.network.

WARNING: Avoid multiple line dereference - prefer 'cur_network.network.InfrastructureMode'
+                                               cur_network.network.
+                                               InfrastructureMode)

Signed-off-by: Shibo Li <zzutcyha@163.com>
---
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 36f6904d25ab..6673befeb2f0 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -1268,14 +1268,11 @@ static int r8711_wx_set_essid(struct net_device *dev,
 			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength))
 			    && (pnetwork->network.Ssid.SsidLength ==
 			     ndis_ssid.SsidLength)) {
-				if (check_fwstate(pmlmepriv,
-							WIFI_ADHOC_STATE)) {
-					if (pnetwork->network.
-						InfrastructureMode
+				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
+					if (pnetwork->network.configurationInfrastructureMode
 						!=
-						padapter->mlmepriv.
-						cur_network.network.
-						InfrastructureMode)
+						padapter->mlmepriv.assoc_by_rssi.
+						cur_network.network.InfrastructureMode)
 						continue;
 				}
 
-- 
2.39.2

