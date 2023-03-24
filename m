Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E754E6C7D87
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjCXLzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCXLzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F83144A4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679658900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=o+NGktWMseNGfUqMMOZXVUXPZfRBI2cuMMXpzSQXhTs=;
        b=BvrFAyZdrzOqD6nbLzI2P/nGvS4jIi2bC2ZfikBGe9O8F98hMjCuoyBxttxyZ39XJ8XDT3
        aCdr1vKnkBfe/y7bWWOM9Ha/ngdnM4j/qEb0drNF80CROVAQrJlkBcygtu2wGbMiPn1uga
        f4YLy0fmKolPuL1F6Mw2zU9Fyv7drac=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-mizbSgbQOuermG_xzAeHEg-1; Fri, 24 Mar 2023 07:54:59 -0400
X-MC-Unique: mizbSgbQOuermG_xzAeHEg-1
Received: by mail-ed1-f71.google.com with SMTP id i22-20020a05640242d600b004f5962985f4so2877487edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679658898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+NGktWMseNGfUqMMOZXVUXPZfRBI2cuMMXpzSQXhTs=;
        b=0kiTvwDxHPl19oebCtC7jo9AQgs6RX15xrRgzKK9hlJlSUTaKouHQz3v+OdxjUb5Xk
         61RCGVi8f8Ttg8adnifBDvk9ezajwavcQAxgVzska2HUXTPJ/i+P35uAJ1yrXHJ6xlPB
         hER/xl0lR62JIZ+UO44Alozx4HTyhYk5t1/yjt4NDgRqCDDpZUQQujSV9x7SuRSTFwZ6
         /jeuyaMduE+hm79dk1osH6047uYvHMNG4jqFS2PJZ845hvNe/B3UN8NEv+298rnFcisO
         CYkqbPdNC+7i6qSHaiX3NEVGO2JefpTmRAkg7Fy+CIxiXjno8TGdniXPFZaw/qq/hyC2
         iDkQ==
X-Gm-Message-State: AAQBX9eCNyqdbA7Q+OkGoutW5cf7wmGzEldEjisrwCvgykfjln8vOWL8
        5yp8Hi80m1F2TVFDT4OR6McMjdIu7KRtU24iH3LVQu43IbuOzMjILqRpyGH4Q4aSTzx1kPPZjva
        2NFJU2+mFbztbDj5GjH2AIICo
X-Received: by 2002:aa7:da82:0:b0:502:100c:53a with SMTP id q2-20020aa7da82000000b00502100c053amr3077953eds.41.1679658898277;
        Fri, 24 Mar 2023 04:54:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350a2BftDLdHSiXK8s1hrtYYBfNg5thmCdq/Nta4rzlvwQHmMyC+RKWswAjDMk6HYVn/7+xcAeA==
X-Received: by 2002:aa7:da82:0:b0:502:100c:53a with SMTP id q2-20020aa7da82000000b00502100c053amr3077932eds.41.1679658897990;
        Fri, 24 Mar 2023 04:54:57 -0700 (PDT)
Received: from localhost.localdomain (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id v30-20020a50a45e000000b005021d17d896sm1153485edb.21.2023.03.24.04.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 04:54:57 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Bobby Eshleman <bobby.eshleman@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, avkrasnov@sberdevices.ru,
        Jakub Kicinski <kuba@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        syzbot+befff0a9536049e7902e@syzkaller.appspotmail.com
Subject: [PATCH net] vsock/loopback: use only sk_buff_head.lock to protect the packet queue
Date:   Fri, 24 Mar 2023 12:54:50 +0100
Message-Id: <20230324115450.11268-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pkt_list_lock was used before commit 71dc9ec9ac7d ("virtio/vsock:
replace virtio_vsock_pkt with sk_buff") to protect the packet queue.
After that commit we switched to sk_buff and we are using
sk_buff_head.lock in almost every place to protect the packet queue
except in vsock_loopback_work() when we call skb_queue_splice_init().

As reported by syzbot, this caused unlocked concurrent access to the
packet queue between vsock_loopback_work() and
vsock_loopback_cancel_pkt() since it is not holding pkt_list_lock.

With the introduction of sk_buff_head, pkt_list_lock is redundant and
can cause confusion, so let's remove it and use sk_buff_head.lock
everywhere to protect the packet queue access.

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Cc: bobby.eshleman@bytedance.com
Reported-and-tested-by: syzbot+befff0a9536049e7902e@syzkaller.appspotmail.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/vsock_loopback.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 671e03240fc5..89905c092645 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -15,7 +15,6 @@
 struct vsock_loopback {
 	struct workqueue_struct *workqueue;
 
-	spinlock_t pkt_list_lock; /* protects pkt_list */
 	struct sk_buff_head pkt_queue;
 	struct work_struct pkt_work;
 };
@@ -32,9 +31,7 @@ static int vsock_loopback_send_pkt(struct sk_buff *skb)
 	struct vsock_loopback *vsock = &the_vsock_loopback;
 	int len = skb->len;
 
-	spin_lock_bh(&vsock->pkt_list_lock);
 	skb_queue_tail(&vsock->pkt_queue, skb);
-	spin_unlock_bh(&vsock->pkt_list_lock);
 
 	queue_work(vsock->workqueue, &vsock->pkt_work);
 
@@ -113,9 +110,9 @@ static void vsock_loopback_work(struct work_struct *work)
 
 	skb_queue_head_init(&pkts);
 
-	spin_lock_bh(&vsock->pkt_list_lock);
+	spin_lock_bh(&vsock->pkt_queue.lock);
 	skb_queue_splice_init(&vsock->pkt_queue, &pkts);
-	spin_unlock_bh(&vsock->pkt_list_lock);
+	spin_unlock_bh(&vsock->pkt_queue.lock);
 
 	while ((skb = __skb_dequeue(&pkts))) {
 		virtio_transport_deliver_tap_pkt(skb);
@@ -132,7 +129,6 @@ static int __init vsock_loopback_init(void)
 	if (!vsock->workqueue)
 		return -ENOMEM;
 
-	spin_lock_init(&vsock->pkt_list_lock);
 	skb_queue_head_init(&vsock->pkt_queue);
 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);
 
@@ -156,9 +152,7 @@ static void __exit vsock_loopback_exit(void)
 
 	flush_work(&vsock->pkt_work);
 
-	spin_lock_bh(&vsock->pkt_list_lock);
 	virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
-	spin_unlock_bh(&vsock->pkt_list_lock);
 
 	destroy_workqueue(vsock->workqueue);
 }
-- 
2.39.2

