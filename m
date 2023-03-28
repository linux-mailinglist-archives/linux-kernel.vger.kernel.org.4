Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508FC6CBB42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjC1Jjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjC1Jjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:39:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3750155A4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:39:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8C561F8BA;
        Tue, 28 Mar 2023 09:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679996368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UgfE83B87JnzYkBplYgpUKueaTqClGbainLz0Z27234=;
        b=gfW4yDUUcpChSDwKbNwRwXDijsOrfTAYRLllKADw1zl14hMfdZIMuXN3TbT4u6uaSFrDqT
        Q2vFJQRYFbG8AjjFNyNEcn651PsaOqFI97MLfmMww8FlBy070mZdJ/W+m/I5+RASiIcqQa
        vOUS4k4u/p/h3gEUPsirmtaOOyp2Jec=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4D771390B;
        Tue, 28 Mar 2023 09:39:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7X7MKtC1ImS8TgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 28 Mar 2023 09:39:28 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, Dan Carpenter <error27@gmail.com>
Subject: [PATCH] xen/pvcalls: don't call bind_evtchn_to_irqhandler() under lock
Date:   Tue, 28 Mar 2023 11:39:24 +0200
Message-Id: <20230328093924.12260-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bind_evtchn_to_irqhandler() shouldn't be called under spinlock, as it
can sleep.

This requires to move the calls of create_active() out of the locked
regions. This is no problem, as the worst which could happen would be
a spurious call of the interrupt handler, causing a spurious wake_up().

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/lkml/Y+JUIl64UDmdkboh@kadam/
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/pvcalls-front.c | 46 ++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index d5d589bda243..6e5d712e3115 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -227,22 +227,31 @@ static irqreturn_t pvcalls_front_event_handler(int irq, void *dev_id)
 
 static void free_active_ring(struct sock_mapping *map);
 
-static void pvcalls_front_free_map(struct pvcalls_bedata *bedata,
-				   struct sock_mapping *map)
+static void pvcalls_front_destroy_active(struct pvcalls_bedata *bedata,
+					 struct sock_mapping *map)
 {
 	int i;
 
 	unbind_from_irqhandler(map->active.irq, map);
 
-	spin_lock(&bedata->socket_lock);
-	if (!list_empty(&map->list))
-		list_del_init(&map->list);
-	spin_unlock(&bedata->socket_lock);
+	if (bedata) {
+		spin_lock(&bedata->socket_lock);
+		if (!list_empty(&map->list))
+			list_del_init(&map->list);
+		spin_unlock(&bedata->socket_lock);
+	}
 
 	for (i = 0; i < (1 << PVCALLS_RING_ORDER); i++)
 		gnttab_end_foreign_access(map->active.ring->ref[i], NULL);
 	gnttab_end_foreign_access(map->active.ref, NULL);
+
 	free_active_ring(map);
+}
+
+static void pvcalls_front_free_map(struct pvcalls_bedata *bedata,
+				   struct sock_mapping *map)
+{
+	pvcalls_front_destroy_active(bedata, map);
 
 	kfree(map);
 }
@@ -433,19 +442,18 @@ int pvcalls_front_connect(struct socket *sock, struct sockaddr *addr,
 		pvcalls_exit_sock(sock);
 		return ret;
 	}
-
-	spin_lock(&bedata->socket_lock);
-	ret = get_request(bedata, &req_id);
+	ret = create_active(map, &evtchn);
 	if (ret < 0) {
-		spin_unlock(&bedata->socket_lock);
 		free_active_ring(map);
 		pvcalls_exit_sock(sock);
 		return ret;
 	}
-	ret = create_active(map, &evtchn);
+
+	spin_lock(&bedata->socket_lock);
+	ret = get_request(bedata, &req_id);
 	if (ret < 0) {
 		spin_unlock(&bedata->socket_lock);
-		free_active_ring(map);
+		pvcalls_front_destroy_active(NULL, map);
 		pvcalls_exit_sock(sock);
 		return ret;
 	}
@@ -821,28 +829,28 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
 		pvcalls_exit_sock(sock);
 		return ret;
 	}
-	spin_lock(&bedata->socket_lock);
-	ret = get_request(bedata, &req_id);
+	ret = create_active(map2, &evtchn);
 	if (ret < 0) {
+		free_active_ring(map2);
+		kfree(map2);
 		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
 			  (void *)&map->passive.flags);
 		spin_unlock(&bedata->socket_lock);
-		free_active_ring(map2);
-		kfree(map2);
 		pvcalls_exit_sock(sock);
 		return ret;
 	}
 
-	ret = create_active(map2, &evtchn);
+	spin_lock(&bedata->socket_lock);
+	ret = get_request(bedata, &req_id);
 	if (ret < 0) {
-		free_active_ring(map2);
-		kfree(map2);
 		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
 			  (void *)&map->passive.flags);
 		spin_unlock(&bedata->socket_lock);
+		pvcalls_front_free_map(bedata, map2);
 		pvcalls_exit_sock(sock);
 		return ret;
 	}
+
 	list_add_tail(&map2->list, &bedata->socket_mappings);
 
 	req = RING_GET_REQUEST(&bedata->ring, req_id);
-- 
2.35.3

