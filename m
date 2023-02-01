Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39EF6869A1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjBAPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjBAPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:09:41 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A2A66F80;
        Wed,  1 Feb 2023 07:08:21 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qw12so36369370ejc.2;
        Wed, 01 Feb 2023 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWGEYERPvz3Z7XS0c9NWA+7/cG741tA5LjUXI+xdY9A=;
        b=a5TGg72O4JVsbdjy8Fdwnjt1CZo2FFCFYgUY9zkr98rstihvKl+h2kTYnnQZj3XtIQ
         VrLdkj6Y8gRLKhKPrEtocVaVOw5Kqx9UYfjDWXRsHFay9d1QtX2Y1PDqy4dQKWewU3TC
         3UYtypps+hRIw0eo2P1np+vhLCLx7bfF2s8dlvC5L9lZRCzVkvRPlM6ZHeNJLS3glfeb
         afq1QNf+AfCNLiFhWe9Un0v4bsrFoG25K6Cbdnql4+Cbv+WM0zsZDjoBhbT7TY3FuVQq
         zf39dosn0iqhtolYkYxX7Mn7zR44cAUFhAxTGsdKOMhfaM3AINRsuKah8qgIMRjt1HXL
         j9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWGEYERPvz3Z7XS0c9NWA+7/cG741tA5LjUXI+xdY9A=;
        b=8C1hoTCx3NWojKfwaYeBcKwTWkTESWptWmMn4lZo/Q175/u0kR1hzftoA+l+qvIiWR
         1apW2wd0+GiyAHJKajqS3Omq0DexMnw9UUSSbxJhkLuyuU3S1J5NdMz1HfgUWmrg+ZWk
         lZTe5lNkWuRH8evb1BFs1I/VFP7jt5w7AJc413btTPdrjmRR6LT+Lf0RcbhMwDqpgYeJ
         maHlwF79Cx9IcR28TQDwYhZiHDzG0C3DkvHK2dpBR+o2QxNH+WmIHbyUMUZaI6Ju7z23
         5TMH6NppCfJ/6KACz4R60GvM4xejZ+O5e7EkkwkcYSmOVL1fV8fKzNuBuk2I7QhNJ2qf
         TRyQ==
X-Gm-Message-State: AO0yUKXaWUQPtzoeiCsfmNIwdlHAcw7LvV/wvnP9uJqgobjt/9emXiaK
        XKoux0CBYXzAZev/tqDWf1JpaRWSXcYyPw==
X-Google-Smtp-Source: AK7set/G9utt0kjirrLeO0f7RG4vKpbd0iCDXqlCLC97vHF2UZQtZK2/B3FCOQK+DPWEChiWZCsWLw==
X-Received: by 2002:a17:906:434b:b0:878:72f7:bd87 with SMTP id z11-20020a170906434b00b0087872f7bd87mr2475279ejm.6.1675264099752;
        Wed, 01 Feb 2023 07:08:19 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id qc26-20020a170906d8ba00b008787e94c5ccsm9585774ejb.184.2023.02.01.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:08:19 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 02/13] drbd: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
Date:   Wed,  1 Feb 2023 16:08:08 +0100
Message-Id: <20230201150815.409582-3-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201150815.409582-1-urezki@gmail.com>
References: <20230201150815.409582-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kvfree_rcu()'s single argument name is deprecated therefore
rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
underline that it is for sleepable contexts.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
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
2.30.2

