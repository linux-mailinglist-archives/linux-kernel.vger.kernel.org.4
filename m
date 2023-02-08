Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8755468F89F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjBHULs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjBHULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:11:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E703E301BD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675887057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pkpGIxstJz2N9eQc0UMJE5ogLSVhp75UoejwnhOmCxs=;
        b=B1E+wFz9vzeZ8+peIwqPBQJONZujAQ+9pRyQeeMMWMzn7wqWVX4nDEKVQ+s+K9IwZUrF35
        PPFU8yem/p05ON5XVslJkBFloMGKLSoD5tYwB2hc+NZrIqRYKWQjSAIt+LsFJSsCLyB3oD
        rZ1Xg5aTB6smSkneDdOZXqK1An/sIic=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-kT6d-ytvNSaIgPYixMKvMA-1; Wed, 08 Feb 2023 15:10:54 -0500
X-MC-Unique: kT6d-ytvNSaIgPYixMKvMA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F180038123A1;
        Wed,  8 Feb 2023 20:10:53 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.10.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BAC1492C3F;
        Wed,  8 Feb 2023 20:10:47 +0000 (UTC)
From:   David Jeffery <djeffery@redhat.com>
To:     target-devel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Jeffery <djeffery@redhat.com>
Subject: [PATCH] scsi: target: iscsi: set memalloc_noio with loopback network connections
Date:   Wed,  8 Feb 2023 15:09:57 -0500
Message-Id: <20230208200957.14073-1-djeffery@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an admin connects an iscsi initiator to an iscsi target on the same
system, the iscsi connection is vulnerable to deadlocks during memory
allocations. Memory allocations in the target task accepting the I/O from
the initiator can wait on the initiator's I/O when the system is under
memory pressure, causing a deadlock situation between the iscsi target and
initiator.

When in this configuration, the deadlock scenario can be avoided by use of
GFP_NOIO allocations. Rather than force all configurations to use NOIO,
memalloc_noio_save/restore can be used to force GFP_NOIO allocations only
when in this loopback configuration.

Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/target/iscsi/iscsi_target.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index baf4da7bb3b4..a68e47e2cdf9 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -16,6 +16,7 @@
 #include <linux/vmalloc.h>
 #include <linux/idr.h>
 #include <linux/delay.h>
+#include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <asm/unaligned.h>
 #include <linux/inet.h>
@@ -4168,7 +4169,10 @@ int iscsi_target_rx_thread(void *arg)
 {
 	int rc;
 	struct iscsit_conn *conn = arg;
+	struct dst_entry *dst;
 	bool conn_freed = false;
+	bool loopback = false;
+	unsigned int flags;
 
 	/*
 	 * Allow ourselves to be interrupted by SIGINT so that a
@@ -4186,8 +4190,25 @@ int iscsi_target_rx_thread(void *arg)
 	if (!conn->conn_transport->iscsit_get_rx_pdu)
 		return 0;
 
+	/*
+	 * If the iscsi connection is over a loopback device from using
+	 * iscsi and iscsit on the same system, we need to set memalloc_noio to
+	 * prevent memory allocation deadlocks between target and initiator.
+	 */
+	rcu_read_lock();
+	dst = rcu_dereference(conn->sock->sk->sk_dst_cache);
+	if (dst && dst->dev && dst->dev->flags & IFF_LOOPBACK)
+		loopback = true;
+	rcu_read_unlock();
+
+	if (loopback)
+		flags = memalloc_noio_save();
+
 	conn->conn_transport->iscsit_get_rx_pdu(conn);
 
+	if (loopback)
+		memalloc_noio_restore(flags);
+
 	if (!signal_pending(current))
 		atomic_set(&conn->transport_failed, 1);
 	iscsit_take_action_for_connection_exit(conn, &conn_freed);
-- 
2.39.1

