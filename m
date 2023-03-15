Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5896BBBDC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjCOST3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjCOST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:27 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A735BCBB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:26 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id r5so17220464qtp.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgzilRrDZzjZzGZPzVxtA7dkKR8Cud+QjJJNSSQFpD0=;
        b=aeF1GaiTWV2z10A11VbsrsakE7qKYNyoR2nVgFLI3d6N8gJEjje/zzswtN2TGFln6U
         SlbpWOL++D9xe66W2i+I7sjdmACU7jeLTJNedgxGtjL2iQs0D2V2ErxDWeH77FfhlQ7S
         B9eXRQAjYlyuksBs4ic13nFMImugk9I19BUXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgzilRrDZzjZzGZPzVxtA7dkKR8Cud+QjJJNSSQFpD0=;
        b=ZXQgQpLgin8+6oEOsBmWvDkvlXGDJzVMbHO+fsllFjaChqPdkkDWNSUHUB6JfXkGZl
         tWMaA1ng3J2bopjvWOljENYlCDei4aAT7juhzwXkAMiCRit4hcOLEtzrwhB40yONFOQT
         +0aJ8mETlZlN+fSG6lfEgyquljdzRFzOSnFceP9Fv4TO91hOAig1yC9veZIzaSC9J2UP
         NYBM/bL2Hgit8rZdH+GiFhUX2aX0vBRFhjP+2nU94FMw698AG1PcmSwjkS9T5/IyqPUA
         K2ooL0MjRBEyVaHAPL7Rw0U/KMMVQikVveIiDTZtAs/iXJhdkvdwdLiQreM/eetkZLRq
         V0mQ==
X-Gm-Message-State: AO0yUKVQF+zpDvW5TE5pyF5Nb1UXAfvAK3ejkuwb7vGGJFjmR2iDprRk
        A3bUSe0WQ13PvI6OdpsJLRtCww==
X-Google-Smtp-Source: AK7set8VcYEA2FNHiNt71e1UCyy1BH+LnV/QaaYc7e1fsnQTQLTwiKalxIxHMNkF25qJEH4XWQKcdQ==
X-Received: by 2002:ac8:5cce:0:b0:3bf:c266:fa6f with SMTP id s14-20020ac85cce000000b003bfc266fa6fmr1378818qta.46.1678904365367;
        Wed, 15 Mar 2023 11:19:25 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:24 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/14] drbd: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
Date:   Wed, 15 Mar 2023 18:18:48 +0000
Message-Id: <20230315181902.4177819-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
switch to the new kvfree_rcu_mightsleep() variant. The goal is to
avoid accidental use of the single-argument forms, which can introduce
functionality bugs in atomic contexts and latency bugs in non-atomic
contexts.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/block/drbd/drbd_nl.c       | 6 +++---
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 drivers/block/drbd/drbd_state.c    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 60757ac31701..f49f2a5282e1 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1615,7 +1615,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 			drbd_send_sync_param(peer_device);
 	}
 
-	kvfree_rcu(old_disk_conf);
+	kvfree_rcu_mightsleep(old_disk_conf);
 	kfree(old_plan);
 	mod_timer(&device->request_timer, jiffies + HZ);
 	goto success;
@@ -2446,7 +2446,7 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_unlock(&connection->resource->conf_update);
 	mutex_unlock(&connection->data.mutex);
-	kvfree_rcu(old_net_conf);
+	kvfree_rcu_mightsleep(old_net_conf);
 
 	if (connection->cstate >= C_WF_REPORT_PARAMS) {
 		struct drbd_peer_device *peer_device;
@@ -2860,7 +2860,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 		new_disk_conf->disk_size = (sector_t)rs.resize_size;
 		rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
 		mutex_unlock(&device->resource->conf_update);
-		kvfree_rcu(old_disk_conf);
+		kvfree_rcu_mightsleep(old_disk_conf);
 		new_disk_conf = NULL;
 	}
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 757f4692b5bd..e197b2a465d2 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3759,7 +3759,7 @@ static int receive_protocol(struct drbd_connection *connection, struct packet_in
 		drbd_info(connection, "peer data-integrity-alg: %s\n",
 			  integrity_alg[0] ? integrity_alg : "(none)");
 
-	kvfree_rcu(old_net_conf);
+	kvfree_rcu_mightsleep(old_net_conf);
 	return 0;
 
 disconnect_rcu_unlock:
@@ -4127,7 +4127,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 
 			rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
 			mutex_unlock(&connection->resource->conf_update);
-			kvfree_rcu(old_disk_conf);
+			kvfree_rcu_mightsleep(old_disk_conf);
 
 			drbd_info(device, "Peer sets u_size to %lu sectors (old: %lu)\n",
 				 (unsigned long)p_usize, (unsigned long)my_usize);
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 75d13ea0024f..2aeea295fa28 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -2071,7 +2071,7 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 		conn_free_crypto(connection);
 		mutex_unlock(&connection->resource->conf_update);
 
-		kvfree_rcu(old_conf);
+		kvfree_rcu_mightsleep(old_conf);
 	}
 
 	if (ns_max.susp_fen) {
-- 
2.40.0.rc1.284.g88254d51c5-goog

