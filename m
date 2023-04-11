Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCE06DE86C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 02:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDLANK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 20:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDLANI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 20:13:08 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6B0E4D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 17:13:05 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C1E655C1DED;
        Wed, 12 Apr 2023 00:13:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 34F535C1E80;
        Wed, 12 Apr 2023 00:13:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681258381; a=rsa-sha256;
        cv=none;
        b=wRW9YsHvTLeWvHcO0Eejf7xV4A6Y671oLikrIBXdrtEYPdlihIceEEpvkyNEpN5koCuzKH
        g26H4P1xyumW3YT96SzsGYWJHPlFXISAW25PpOjfJsEsM9DWoUQzipSB7INFfQwDCXX4Yj
        spPBFsYAW4nE/Gr3l4hIlb+InMr84z/iWUshWiZ8GgObXCY0UvwfuYeSp3TzUUCB8uxFW1
        Xc/WH05yGmtzniewQQz3PbBJtqwI7AGIHrf9DdzBDyXe8eKH/BCGESm1Mrn2V8B1xMJZCX
        1Z0dN7Dyo6Rv70XU3vWdP7o2Z0XH7WC3vhcaEPRjxmjHHZY1AEXQFeAX5i43BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681258381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=oEGhhJyU8k257jjtDFsLKg5eyDoIenlRxC9XjI+O/6M=;
        b=MfHrjgEhpM3dNp/fIOWZoSNmPk2bh8ElHa0qGEYfoDDsjE0TKV0lppNC8HrCgfOFQgLzTZ
        NM8GVN8vtbuRAGEneDMdONUsES8NVWnp15OAjfJTp9RPu/0q0UQvNIqBgxaLZu94RORpk7
        a81mn8OnrwO9H9R1W/aWRTtEHJAtU0jHIMWgzbtyzVxaO2jw78ZI5HcNdItXtHd0uqFPpG
        HuoceliQ4oBtYq4UY/YQ2nr8+4dgLIxHkDCNwVlAPqldMRmT7q3zTsdsY5lg6Q3Meo2xi7
        pKcYWYpDde6yipFquH97nDQtcKOGoIPaxFQcQs4p5gQ+48lMX4arMEsUK72s1w==
ARC-Authentication-Results: i=1;
        rspamd-786cb55f77-4xxjj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ski-Wiry: 300061116147a400_1681258381570_1219081380
X-MC-Loop-Signature: 1681258381570:839633618
X-MC-Ingress-Time: 1681258381570
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.43 (trex/6.7.2);
        Wed, 12 Apr 2023 00:13:01 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Px37w3TVZz55;
        Tue, 11 Apr 2023 17:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1681258380;
        bh=oEGhhJyU8k257jjtDFsLKg5eyDoIenlRxC9XjI+O/6M=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=l15cCpjmykIO06M8Hf4SdUNfBWQntRiRQiZk/MDx5vRmV6NfohpcDAzSXYGJnOAPX
         fY3a9BNLtBYE46m4+zReaeqYjLUlsYIYCU5dT695BAXBEVziGXz47j+77iyABMAvuw
         rPt4LDeNz+GXgq+EanVYY0m5Y3yr8OmvXvqLtCgSDvhMADdPeW6HH6GiRlAQcAQMa6
         lH+DU/4o8+SU3MF3Vu8Pjx/Gu379S9zRsZNDJANunv7UryUwpXoLa3I5nzNxTfNP83
         UY3w35kTdrpXkKROeCzyllxv+PWeuB4xIbSO8+PHwLw7fFjfrn7ufju1U6+7BiCsJL
         rIzsEomBYk6bw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     pabeni@redhat.com, dave@stgolabs.net, linux-kernel@vger.kernel.org
Subject: [PATCH] epoll: Rename global epmutex
Date:   Tue, 11 Apr 2023 16:41:59 -0700
Message-Id: <20230411234159.20421-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of 4f04cbaf128 (epoll: use refcount to reduce ep_mutex contention),
this lock is now specific to nesting cases - inserting an epoll fd onto
another epoll fd. Rename the lock to be less generic.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/eventpoll.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a8e1d09f039d..980483455cc0 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -43,7 +43,7 @@
  * LOCKING:
  * There are three level of locking required by epoll :
  *
- * 1) epmutex (mutex)
+ * 1) epnested_mutex (mutex)
  * 2) ep->mtx (mutex)
  * 3) ep->lock (rwlock)
  *
@@ -57,8 +57,8 @@
  * we need a lock that will allow us to sleep. This lock is a
  * mutex (ep->mtx). It is acquired during the event transfer loop,
  * during epoll_ctl(EPOLL_CTL_DEL) and during eventpoll_release_file().
- * The epmutex is acquired when inserting an epoll fd onto another epoll
- * fd. We do this so that we walk the epoll tree and ensure that this
+ * The epnested_mutex is acquired when inserting an epoll fd onto another
+ * epoll fd. We do this so that we walk the epoll tree and ensure that this
  * insertion does not create a cycle of epoll file descriptors, which
  * could lead to deadlock. We need a global mutex to prevent two
  * simultaneous inserts (A into B and B into A) from racing and
@@ -74,9 +74,9 @@
  * of epoll file descriptors, we use the current recursion depth as
  * the lockdep subkey.
  * It is possible to drop the "ep->mtx" and to use the global
- * mutex "epmutex" (together with "ep->lock") to have it working,
+ * mutex "epnested_mutex" (together with "ep->lock") to have it working,
  * but having "ep->mtx" will make the interface more scalable.
- * Events that require holding "epmutex" are very rare, while for
+ * Events that require holding "epnested_mutex" are very rare, while for
  * normal operations the epoll private "ep->mtx" will guarantee
  * a better scalability.
  */
@@ -248,7 +248,7 @@ struct ep_pqueue {
 static long max_user_watches __read_mostly;
 
 /* Used for cycles detection */
-static DEFINE_MUTEX(epmutex);
+static DEFINE_MUTEX(epnested_mutex);
 
 static u64 loop_check_gen = 0;
 
@@ -263,7 +263,7 @@ static struct kmem_cache *pwq_cache __read_mostly;
 
 /*
  * List of files with newly added links, where we may need to limit the number
- * of emanating paths. Protected by the epmutex.
+ * of emanating paths. Protected by the epnested_mutex.
  */
 struct epitems_head {
 	struct hlist_head epitems;
@@ -1337,7 +1337,7 @@ static void ep_rbtree_insert(struct eventpoll *ep, struct epitem *epi)
  * is connected to n file sources. In this case each file source has 1 path
  * of length 1. Thus, the numbers below should be more than sufficient. These
  * path limits are enforced during an EPOLL_CTL_ADD operation, since a modify
- * and delete can't add additional paths. Protected by the epmutex.
+ * and delete can't add additional paths. Protected by the epnested_mutex.
  */
 static const int path_limits[PATH_ARR_SIZE] = { 1000, 500, 100, 50, 10 };
 static int path_count[PATH_ARR_SIZE];
@@ -2180,7 +2180,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	 * We do not need to take the global 'epumutex' on EPOLL_CTL_ADD when
 	 * the epoll file descriptor is attaching directly to a wakeup source,
 	 * unless the epoll file descriptor is nested. The purpose of taking the
-	 * 'epmutex' on add is to prevent complex toplogies such as loops and
+	 * 'epnested_mutex' on add is to prevent complex toplogies such as loops and
 	 * deep wakeup paths from forming in parallel through multiple
 	 * EPOLL_CTL_ADD operations.
 	 */
@@ -2191,7 +2191,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 		if (READ_ONCE(f.file->f_ep) || ep->gen == loop_check_gen ||
 		    is_file_epoll(tf.file)) {
 			mutex_unlock(&ep->mtx);
-			error = epoll_mutex_lock(&epmutex, 0, nonblock);
+			error = epoll_mutex_lock(&epnested_mutex, 0, nonblock);
 			if (error)
 				goto error_tgt_fput;
 			loop_check_gen++;
@@ -2252,7 +2252,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	if (full_check) {
 		clear_tfile_check_list();
 		loop_check_gen++;
-		mutex_unlock(&epmutex);
+		mutex_unlock(&epnested_mutex);
 	}
 
 	fdput(tf);
-- 
2.40.0

