Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C24F744739
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 08:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGAGkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 02:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjGAGjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 02:39:46 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D66423A;
        Fri, 30 Jun 2023 23:39:34 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 88B55120014;
        Sat,  1 Jul 2023 09:28:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 88B55120014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688192929;
        bh=tAX9BS9Qmyzlmpr1k17sJ0Kzs+6bGB2QVrF/rbwEyDA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=DeNDBFfpH9IbbeqVzIvq/we2164xAwwjrKwlFH+Dmnq2ALgwrGUuw3tYz/xsDshbM
         f5lfBjuZk+iHsxiKiMxySwecX6WFoc93NmNLuPghjYUFBWBXDsBrGG1Oaj0BPjHE5b
         epwl2FwoIzFf4iS0NIMlK/6tsS/3CE5RbHTOiqwJUnDHIZZsdtVg4s/AwZ9/7atxed
         EcHa8n625gGiTEzV+Dva/q5pWjtANlW/vGqh2IqLEBRCpl6y/TDHtwl/g/QmppQkYp
         tc0kbqoy1taoo6I7RpiJQBt10bcjY54G31G009/VvCyeIsy9Znu4MwsCfbUFvlYfpa
         k+xm0Rt16aaYg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Sat,  1 Jul 2023 09:28:48 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 1 Jul 2023 09:28:23 +0300
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
CC:     <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <oxffffaa@gmail.com>,
        <avkrasnov@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: [RFC PATCH v5 10/17] vhost/vsock: support MSG_ZEROCOPY for transport
Date:   Sat, 1 Jul 2023 09:23:03 +0300
Message-ID: <20230701062310.3397129-11-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230701062310.3397129-1-AVKrasnov@sberdevices.ru>
References: <20230701062310.3397129-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178380 [Jun 30 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/01 00:58:00 #21597365
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'msgzerocopy_allow()' callback for vhost transport.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 Changelog:
 v4 -> v5:
  * Move 'msgzerocopy_allow' right after seqpacket callbacks.

 drivers/vhost/vsock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index cb00e0e059e4..3fd0ab0c0edc 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -398,6 +398,11 @@ static bool vhost_vsock_more_replies(struct vhost_vsock *vsock)
 	return val < vq->num;
 }
 
+static bool vhost_transport_msgzerocopy_allow(void)
+{
+	return true;
+}
+
 static bool vhost_transport_seqpacket_allow(u32 remote_cid);
 
 static struct virtio_transport vhost_transport = {
@@ -431,6 +436,8 @@ static struct virtio_transport vhost_transport = {
 		.seqpacket_allow          = vhost_transport_seqpacket_allow,
 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
 
+		.msgzerocopy_allow        = vhost_transport_msgzerocopy_allow,
+
 		.notify_poll_in           = virtio_transport_notify_poll_in,
 		.notify_poll_out          = virtio_transport_notify_poll_out,
 		.notify_recv_init         = virtio_transport_notify_recv_init,
-- 
2.25.1

