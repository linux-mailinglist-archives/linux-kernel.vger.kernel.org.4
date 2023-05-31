Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A9E7173D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjEaCil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjEaCij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:38:39 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4A0C9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:38:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b02d0942caso23364485ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685500717; x=1688092717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tpH4t+aA6VmGuKwExaIddXhyI8sEcDcaGGPTHS+CPmI=;
        b=g5BFEFHPBgZ4qgHQ1gYDCA8l9KFVdQqB/fixZvBbGIxNlUbVNYI2tDO/GAU0pLDms6
         kLUAwWHzku0iuuHwSGQJLAqUALQDwfzADkSn72ivYxbkpbX0lrqCMKceR6AO2ZtRGerD
         V2WGNkUk/PD4flTllzlIP0O7+kdyqRkRlr1MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685500717; x=1688092717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpH4t+aA6VmGuKwExaIddXhyI8sEcDcaGGPTHS+CPmI=;
        b=DOM/HEVZk+c31FlGue2FqUSGjyebv5GGsPCx28vqCfqzlZ0GlAVPQ7k6i+1+RmUu6c
         8l89MoaiNHCqwhoY9PM2CZAzB1CXYayKNoPNoZQYe6SHpKK27EOJIZTphRiBsNUp827p
         5zUN8muqtWGTWDqTA6jjyqbT/VLuydryuSY1xKMTQ2novdxb2/kXqQZy0WYblQMe3iil
         0ypP3dJg/VOgSZs8X/YVhjOYpE9GEmMSyPC0XbR2RBX7u5SJESK/bYG9Lfff2GTuwwZP
         omGWFdFpPvDFRTqcPIai+1pRnCAPa9nEXzXrjilMvJbgbMxUHTl7+SMyemVM8FbtGeVC
         zu/w==
X-Gm-Message-State: AC+VfDwtevhZTR88cn+/Ccz5mBuZIOaNPxwoI0Q0ljh8tgSdSy1Ey2rt
        L8s4w6OiissLZbutQEwYAXgzbw==
X-Google-Smtp-Source: ACHHUZ58y6ZyWusYdmqf7jZnAxuypZK1eJ3gue4OHftvOWO4wTa+IcaIZbkiiKzykQ4E+SpDPpwhIw==
X-Received: by 2002:a17:902:db11:b0:1ae:7421:82b8 with SMTP id m17-20020a170902db1100b001ae742182b8mr4572863plx.28.1685500717586;
        Tue, 30 May 2023 19:38:37 -0700 (PDT)
Received: from localhost (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with UTF8SMTPSA id jk15-20020a170903330f00b001b024ee5f6esm48397plb.81.2023.05.30.19.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 19:38:37 -0700 (PDT)
From:   Ying Hsu <yinghsu@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Ying Hsu <yinghsu@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v4] Bluetooth: Fix l2cap_disconnect_req deadlock
Date:   Wed, 31 May 2023 02:38:16 +0000
Message-ID: <20230531023821.349759-1-yinghsu@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L2CAP assumes that the locks conn->chan_lock and chan->lock are
acquired in the order conn->chan_lock, chan->lock to avoid
potential deadlock.
For example, l2sock_shutdown acquires these locks in the order:
  mutex_lock(&conn->chan_lock)
  l2cap_chan_lock(chan)

However, l2cap_disconnect_req acquires chan->lock in
l2cap_get_chan_by_scid first and then acquires conn->chan_lock
before calling l2cap_chan_del. This means that these locks are
acquired in unexpected order, which leads to potential deadlock:
  l2cap_chan_lock(c)
  mutex_lock(&conn->chan_lock)

This patch releases chan->lock before acquiring the conn_chan_lock
to avoid the potential deadlock.

Fixes: ("a2a9339e1c9d Bluetooth: L2CAP: Fix use-after-free in l2cap_disconnect_{req,rsp}")
Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
This commit has been tested on a Chromebook device.

Changes in v4:
- Using l2cap_get_chan_by_scid to avoid repeated code.
- Releasing chan->lock before acquiring conn->chan_lock.

Changes in v3:
- Adding the fixes tag.

Changes in v2:
- Adding the prefix "Bluetooth:" to subject line.

 net/bluetooth/l2cap_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 376b523c7b26..d9c4d26b2518 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4663,7 +4663,9 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	chan->ops->set_shutdown(chan);
 
+	l2cap_chan_unlock(chan);
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNRESET);
 	mutex_unlock(&conn->chan_lock);
 
@@ -4702,7 +4704,9 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_unlock(chan);
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, 0);
 	mutex_unlock(&conn->chan_lock);
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

