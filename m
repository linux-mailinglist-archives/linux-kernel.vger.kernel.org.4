Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B59D74472D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 08:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjGAGkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 02:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjGAGjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 02:39:40 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB833448B;
        Fri, 30 Jun 2023 23:39:34 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 493E9120019;
        Sat,  1 Jul 2023 09:28:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 493E9120019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688192934;
        bh=tL2E1Y90S5bBkA16ZM0oXYsz18KCFk1Zn9JPdTBbPT8=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=AONkneIVY6z7uG6hGz0R3adxk6xqQ8wWG+QmW6Xj4HFpm/W6DayErS2I7yKgSN7uW
         oPP2OxpUAJrN2L+egYLzMko63eJKcGMb9VWh1V75J183W2u8pUtWoerjGwztUPZ2aY
         rKj8co3FcC1qPLfVN57NuOL6J7GCtbhFsziy1t3xNKG4BBp9kMKg/Vu5BCsfA6L3pZ
         jkpVFcGiFugKUUtTnn6YxAtuTW9uk7jgVzRyCmqnUn7WPoNcyk0xKURpq8lT3ced5/
         +iWKXh3X0OI2iHu+IAM3A64XxKF59JQMK8905a6QoJsyMs7ObdKVJb6TfHUSptk4jD
         LokT5swgZvE5g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Sat,  1 Jul 2023 09:28:53 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 1 Jul 2023 09:28:26 +0300
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
Subject: [RFC PATCH v5 14/17] docs: net: description of MSG_ZEROCOPY for AF_VSOCK
Date:   Sat, 1 Jul 2023 09:23:07 +0300
Message-ID: <20230701062310.3397129-15-AVKrasnov@sberdevices.ru>
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

This adds description of MSG_ZEROCOPY flag support for AF_VSOCK type of
socket.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 Documentation/networking/msg_zerocopy.rst | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/msg_zerocopy.rst b/Documentation/networking/msg_zerocopy.rst
index b3ea96af9b49..34bc7ff411ce 100644
--- a/Documentation/networking/msg_zerocopy.rst
+++ b/Documentation/networking/msg_zerocopy.rst
@@ -7,7 +7,8 @@ Intro
 =====
 
 The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
-The feature is currently implemented for TCP and UDP sockets.
+The feature is currently implemented for TCP, UDP and VSOCK (with
+virtio transport) sockets.
 
 
 Opportunity and Caveats
@@ -174,7 +175,7 @@ read_notification() call in the previous snippet. A notification
 is encoded in the standard error format, sock_extended_err.
 
 The level and type fields in the control data are protocol family
-specific, IP_RECVERR or IPV6_RECVERR.
+specific, IP_RECVERR or IPV6_RECVERR (for TCP or UDP socket).
 
 Error origin is the new type SO_EE_ORIGIN_ZEROCOPY. ee_errno is zero,
 as explained before, to avoid blocking read and write system calls on
@@ -201,6 +202,7 @@ undefined, bar for ee_code, as discussed below.
 
 	printf("completed: %u..%u\n", serr->ee_info, serr->ee_data);
 
+For VSOCK socket, cmsg_level will be SOL_VSOCK and cmsg_type will be 0.
 
 Deferred copies
 ~~~~~~~~~~~~~~~
@@ -235,12 +237,15 @@ Implementation
 Loopback
 --------
 
+For TCP and UDP:
 Data sent to local sockets can be queued indefinitely if the receive
 process does not read its socket. Unbound notification latency is not
 acceptable. For this reason all packets generated with MSG_ZEROCOPY
 that are looped to a local socket will incur a deferred copy. This
 includes looping onto packet sockets (e.g., tcpdump) and tun devices.
 
+For VSOCK:
+Data path sent to local sockets is the same as for non-local sockets.
 
 Testing
 =======
@@ -254,3 +259,6 @@ instance when run with msg_zerocopy.sh between a veth pair across
 namespaces, the test will not show any improvement. For testing, the
 loopback restriction can be temporarily relaxed by making
 skb_orphan_frags_rx identical to skb_orphan_frags.
+
+For VSOCK type of socket example can be found in  tools/testing/vsock/
+vsock_test_zerocopy.c.
-- 
2.25.1

