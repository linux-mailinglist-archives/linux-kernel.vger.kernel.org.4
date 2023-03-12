Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554D56B677D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCLPXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCLPXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1393401A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678634539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nzLK8pzk4KIa2DzMQw0GW05ecwCB1ocN9TsqvVekrfU=;
        b=g1LecFFErJ17axWU4OzdsfY+4WaFYyr1dYsaa0zT3Nt9RH3psRTSqD64Hj7u/kixLWju6W
        p/gyoSjfS2lj6Nz2iXJ+EVpK8zeYDMChzMkNWBlnKYKOA8QedArF3TWU9KixysJHr1h7ig
        yfHLKbJX0Vara/2+9zJJXLUOhc8kooM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9--aJYZL-SPMKTXtgN0Tpo0w-1; Sun, 12 Mar 2023 11:22:18 -0400
X-MC-Unique: -aJYZL-SPMKTXtgN0Tpo0w-1
Received: by mail-pf1-f197.google.com with SMTP id fb7-20020a056a002d8700b0061c7b700c6dso5532748pfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678634536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzLK8pzk4KIa2DzMQw0GW05ecwCB1ocN9TsqvVekrfU=;
        b=MpIu/pTy8avcuhXVtRS3Y97eu+LMdUX2vsPsU7z2HGtX4TaSiiDgrYSG0oeq/NzOjc
         I7hoUVeTsGd+MXNqYTzS4wwIfHcbc4k7RKH4tBGC8ibR9EfF3o3ukUWPbCngVIdq42u2
         PpAxGgiHlVP5G546nU3zVxr3da+zigDbypl+0ElP1KZhcze2+G7SQXY50lWi9tbTU8rn
         j/R9yVbWYOde+jDbdriI6mFkBaDakqiGCKElxi5S0VXszE+wGk0D1JIECXp1yKDRxKTl
         9z1wm1PzYH9YhS6qf+PFAYVNjZw2naMno8YMeVL2qDgkUYM/awvi7g8C4w+2QRxzNGln
         uYww==
X-Gm-Message-State: AO0yUKV/ENPsPinWoeiyrfHxWDO6VeOwrlUhKvV1l/vF2pH1zPdDlB8B
        inS3OxYJewPO67D7roIy+ZNlxn50nKW2zqB71F1ClS20M9wifyDQxc+X08+mzgD5CCqqlIfgr4g
        cEwaDfYJWFhlb8NZq9ZFf1YZ0HXoKy84UEwI=
X-Received: by 2002:a17:90a:ba01:b0:23b:45be:a15a with SMTP id s1-20020a17090aba0100b0023b45bea15amr3611087pjr.25.1678634536261;
        Sun, 12 Mar 2023 08:22:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set94eat7B+zgRt/layidU5XBpCUezpZ9uMngg/wlfqxvLnrt4eoZ30jiyybAhgSwaezS0GnJ2g==
X-Received: by 2002:a17:90a:ba01:b0:23b:45be:a15a with SMTP id s1-20020a17090aba0100b0023b45bea15amr3611067pjr.25.1678634535830;
        Sun, 12 Mar 2023 08:22:15 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id lb5-20020a17090b4a4500b00233864f21a7sm2871960pjb.51.2023.03.12.08.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 08:22:15 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     j.vosburgh@gmail.com, andy@greyhouse.net
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        syzbot+9dfc3f3348729cc82277@syzkaller.appspotmail.com
Subject: [PATCH net] bonding: Fix warning in default_device_exit_batch()
Date:   Mon, 13 Mar 2023 00:21:58 +0900
Message-Id: <20230312152158.995043-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported warning in default_device_exit_batch() like below [1]:

WARNING: CPU: 1 PID: 56 at net/core/dev.c:10867 unregister_netdevice_many_notify+0x14cf/0x19f0 net/core/dev.c:10867
...
Call Trace:
 <TASK>
 unregister_netdevice_many net/core/dev.c:10897 [inline]
 default_device_exit_batch+0x451/0x5b0 net/core/dev.c:11350
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:174
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:613
 process_one_work+0x9bf/0x1820 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

For bond devices which also has a master device, IFF_SLAVE flag is
cleared at err_undo_flags label in bond_enslave() if it is not
ARPHRD_ETHER type.  In this case, __bond_release_one() is not called
when bond_netdev_event() received NETDEV_UNREGISTER event.  This
causes the above warning.

This patch fixes this issue by setting IFF_SLAVE flag at
err_undo_flags label in bond_enslave() if the bond device has a master
device.

Fixes: 7d5cd2ce5292 ("bonding: correctly handle bonding type change on enslave failure")
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Link: https://syzkaller.appspot.com/bug?id=391c7b1f6522182899efba27d891f1743e8eb3ef [1]
Reported-by: syzbot+9dfc3f3348729cc82277@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/net/bonding/bond_main.c | 2 ++
 include/net/bonding.h           | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 00646aa315c3..1a8b59e1468d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2291,6 +2291,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			dev_close(bond_dev);
 			ether_setup(bond_dev);
 			bond_dev->flags |= IFF_MASTER;
+			if (bond_has_master(bond))
+				bond_dev->flags |= IFF_SLAVE;
 			bond_dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 		}
 	}
diff --git a/include/net/bonding.h b/include/net/bonding.h
index ea36ab7f9e72..ed0b49501fad 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -57,6 +57,11 @@
 
 #define bond_has_slaves(bond) !list_empty(bond_slave_list(bond))
 
+/* master list primitives */
+#define bond_master_list(bond) (&(bond)->dev->adj_list.upper)
+
+#define bond_has_master(bond) !list_empty(bond_master_list(bond))
+
 /* IMPORTANT: bond_first/last_slave can return NULL in case of an empty list */
 #define bond_first_slave(bond) \
 	(bond_has_slaves(bond) ? \
-- 
2.39.0

