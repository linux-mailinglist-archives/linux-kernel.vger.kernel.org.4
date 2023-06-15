Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EBF7316B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343835AbjFOLdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244783AbjFOLc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF2ED
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686828728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=2jLPUY6QsgU36zacDi9VUOh4wRLZuAcl8Xg9zAds7pQ=;
        b=FShPQN/+1la0pmaLAxgwYfxFkyFVUJOZoB+ZcwyHfDwWk7tL6F7GO7hkbg/WDRd1o2JZRB
        4DFqePJ8FHhQALURlZxgqWKoTIiwYSn7wj1bldz26LxugDv2MQKow77arAzOFWQi66Vf5i
        dTjcvFFrME5s/6ZmGOYhKTG0NTjJLrw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-B0uJZzaOOPCYIxFhQXYuOA-1; Thu, 15 Jun 2023 07:32:07 -0400
X-MC-Unique: B0uJZzaOOPCYIxFhQXYuOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D21E8022EF;
        Thu, 15 Jun 2023 11:32:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 053F21415102;
        Thu, 15 Jun 2023 11:32:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
cc:     dhowells@redhat.com,
        syzbot+dd1339599f1840e4cc65@syzkaller.appspotmail.com,
        Tom Herbert <tom@herbertland.com>,
        Tom Herbert <tom@quantonium.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] kcm: Fix unnecessary psock unreservation.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20786.1686828722.1@warthog.procyon.org.uk>
Date:   Thu, 15 Jun 2023 12:32:02 +0100
Message-ID: <20787.1686828722@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kcm_write_msgs() calls unreserve_psock() to release its hold on the
underlying TCP socket if it has run out of things to transmit, but if we
have nothing in the write queue on entry (e.g. because someone did a
zero-length sendmsg), we don't actually go into the transmission loop and
as a consequence don't call reserve_psock().

Fix this by skipping the call to unreserve_psock() if we didn't reserve a
psock.

Fixes: c31a25e1db48 ("kcm: Send multiple frags in one sendmsg()")
Reported-by: syzbot+dd1339599f1840e4cc65@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/000000000000a61ffe05fe0c3d08@google.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: syzbot+dd1339599f1840e4cc65@syzkaller.appspotmail.com
cc: Tom Herbert <tom@herbertland.com>
cc: Tom Herbert <tom@quantonium.net>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---
 net/kcm/kcmsock.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index d75d775e9462..d0537c1c8cd7 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -661,6 +661,7 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 				kcm_abort_tx_psock(psock, ret ? -ret : EPIPE,
 						   true);
 				unreserve_psock(kcm);
+				psock = NULL;
 
 				txm->started_tx = false;
 				kcm_report_tx_retry(kcm);
@@ -696,7 +697,8 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 	if (!head) {
 		/* Done with all queued messages. */
 		WARN_ON(!skb_queue_empty(&sk->sk_write_queue));
-		unreserve_psock(kcm);
+		if (psock)
+			unreserve_psock(kcm);
 	}
 
 	/* Check if write space is available */

