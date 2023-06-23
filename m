Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5357673C2F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjFWVft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjFWVfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:35:39 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AE41BFC;
        Fri, 23 Jun 2023 14:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687556139; x=1719092139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tf23e+qP0vAVTrZV7UcKVY4M16KtyaaoS+HsqnTOfvs=;
  b=LPPCK4NO2lhFf1DkWSj2qYzVtxrHgslmtwsfQE9xQcw1DNn+c+uFbnCI
   ybbB2U/uWiUjdndI4ouKvEBbNc3/ddGo6qQxF4ivdu8T0lnXt7DanjA/R
   3r32vfKWduBiGDNCHdF9UoqqNKH0DaP3RbHVOu0kMxP+T0kKFqEdK7c4v
   s=;
X-IronPort-AV: E=Sophos;i="6.01,153,1684800000"; 
   d="scan'208";a="222572588"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 21:35:37 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 60BB78A5C5;
        Fri, 23 Jun 2023 21:35:36 +0000 (UTC)
Received: from EX19D002UWA001.ant.amazon.com (10.13.138.247) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 23 Jun 2023 21:35:35 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D002UWA001.ant.amazon.com (10.13.138.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 23 Jun 2023 21:35:35 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Fri, 23 Jun 2023 21:35:35
 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
        id C26E04091; Fri, 23 Jun 2023 21:35:34 +0000 (UTC)
From:   Rishabh Bhatnagar <risbhat@amazon.com>
To:     <gregkh@linuxfoundation.org>, <pc@cjr.nz>
CC:     <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Rishabh Bhatnagar" <risbhat@amazon.com>
Subject: [PATCH 5.4 5/5] cifs: Fix potential deadlock when updating vol in cifs_reconnect()
Date:   Fri, 23 Jun 2023 21:34:06 +0000
Message-ID: <20230623213406.5596-6-risbhat@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623213406.5596-1-risbhat@amazon.com>
References: <20230623213406.5596-1-risbhat@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paulo Alcantara (SUSE)" <pc@cjr.nz>

commit 06d57378bcc9b2c33640945174842115593795d1 upstream.

We can't acquire volume lock while refreshing the DFS cache because
cifs_reconnect() may call dfs_cache_update_vol() while we are walking
through the volume list.

To prevent that, make vol_info refcounted, create a temp list with all
volumes eligible for refreshing, and then use it without any locks
held.

Besides, replace vol_lock with a spinlock and protect cache_ttl from
concurrent accesses or changes.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
---
 fs/cifs/dfs_cache.c | 109 +++++++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 32 deletions(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 1efba8ee86bf..cf9267cf42e7 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -49,15 +49,20 @@ struct cache_entry {
 
 struct vol_info {
 	char *fullpath;
+	spinlock_t smb_vol_lock;
 	struct smb_vol smb_vol;
 	char *mntdata;
 	struct list_head list;
+	struct list_head rlist;
+	struct kref refcnt;
 };
 
 static struct kmem_cache *cache_slab __read_mostly;
 static struct workqueue_struct *dfscache_wq __read_mostly;
 
 static int cache_ttl;
+static DEFINE_SPINLOCK(cache_ttl_lock);
+
 static struct nls_table *cache_nlsc;
 
 /*
@@ -69,7 +74,7 @@ static struct hlist_head cache_htable[CACHE_HTABLE_SIZE];
 static DEFINE_MUTEX(list_lock);
 
 static LIST_HEAD(vol_list);
-static DEFINE_MUTEX(vol_lock);
+static DEFINE_SPINLOCK(vol_list_lock);
 
 static void refresh_cache_worker(struct work_struct *work);
 
@@ -300,7 +305,6 @@ int dfs_cache_init(void)
 	for (i = 0; i < CACHE_HTABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&cache_htable[i]);
 
-	cache_ttl = -1;
 	cache_nlsc = load_nls_default();
 
 	cifs_dbg(FYI, "%s: initialized DFS referral cache\n", __func__);
@@ -471,15 +475,15 @@ add_cache_entry(unsigned int hash, const char *path,
 
 	hlist_add_head_rcu(&ce->hlist, &cache_htable[hash]);
 
-	mutex_lock(&vol_lock);
-	if (cache_ttl < 0) {
+	spin_lock(&cache_ttl_lock);
+	if (!cache_ttl) {
 		cache_ttl = ce->ttl;
 		queue_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
 	} else {
 		cache_ttl = min_t(int, cache_ttl, ce->ttl);
 		mod_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
 	}
-	mutex_unlock(&vol_lock);
+	spin_unlock(&cache_ttl_lock);
 
 	return ce;
 }
@@ -523,21 +527,32 @@ static inline void destroy_slab_cache(void)
 	kmem_cache_destroy(cache_slab);
 }
 
-static inline void free_vol(struct vol_info *vi)
+static void __vol_release(struct vol_info *vi)
 {
-	list_del(&vi->list);
 	kfree(vi->fullpath);
 	kfree(vi->mntdata);
 	cifs_cleanup_volume_info_contents(&vi->smb_vol);
 	kfree(vi);
 }
 
+static void vol_release(struct kref *kref)
+{
+	struct vol_info *vi = container_of(kref, struct vol_info, refcnt);
+
+	spin_lock(&vol_list_lock);
+	list_del(&vi->list);
+	spin_unlock(&vol_list_lock);
+	__vol_release(vi);
+}
+
 static inline void free_vol_list(void)
 {
 	struct vol_info *vi, *nvi;
 
-	list_for_each_entry_safe(vi, nvi, &vol_list, list)
-		free_vol(vi);
+	list_for_each_entry_safe(vi, nvi, &vol_list, list) {
+		list_del_init(&vi->list);
+		__vol_release(vi);
+	}
 }
 
 /**
@@ -1156,10 +1171,13 @@ int dfs_cache_add_vol(char *mntdata, struct smb_vol *vol, const char *fullpath)
 		goto err_free_fullpath;
 
 	vi->mntdata = mntdata;
+	spin_lock_init(&vi->smb_vol_lock);
+	kref_init(&vi->refcnt);
 
-	mutex_lock(&vol_lock);
+	spin_lock(&vol_list_lock);
 	list_add_tail(&vi->list, &vol_list);
-	mutex_unlock(&vol_lock);
+	spin_unlock(&vol_list_lock);
+
 	return 0;
 
 err_free_fullpath:
@@ -1169,7 +1187,8 @@ int dfs_cache_add_vol(char *mntdata, struct smb_vol *vol, const char *fullpath)
 	return rc;
 }
 
-static inline struct vol_info *find_vol(const char *fullpath)
+/* Must be called with vol_list_lock held */
+static struct vol_info *find_vol(const char *fullpath)
 {
 	struct vol_info *vi;
 
@@ -1191,7 +1210,6 @@ static inline struct vol_info *find_vol(const char *fullpath)
  */
 int dfs_cache_update_vol(const char *fullpath, struct TCP_Server_Info *server)
 {
-	int rc;
 	struct vol_info *vi;
 
 	if (!fullpath || !server)
@@ -1199,22 +1217,24 @@ int dfs_cache_update_vol(const char *fullpath, struct TCP_Server_Info *server)
 
 	cifs_dbg(FYI, "%s: fullpath: %s\n", __func__, fullpath);
 
-	mutex_lock(&vol_lock);
-
+	spin_lock(&vol_list_lock);
 	vi = find_vol(fullpath);
 	if (IS_ERR(vi)) {
-		rc = PTR_ERR(vi);
-		goto out;
+		spin_unlock(&vol_list_lock);
+		return PTR_ERR(vi);
 	}
+	kref_get(&vi->refcnt);
+	spin_unlock(&vol_list_lock);
 
 	cifs_dbg(FYI, "%s: updating volume info\n", __func__);
+	spin_lock(&vi->smb_vol_lock);
 	memcpy(&vi->smb_vol.dstaddr, &server->dstaddr,
 	       sizeof(vi->smb_vol.dstaddr));
-	rc = 0;
+	spin_unlock(&vi->smb_vol_lock);
 
-out:
-	mutex_unlock(&vol_lock);
-	return rc;
+	kref_put(&vi->refcnt, vol_release);
+
+	return 0;
 }
 
 /**
@@ -1231,11 +1251,11 @@ void dfs_cache_del_vol(const char *fullpath)
 
 	cifs_dbg(FYI, "%s: fullpath: %s\n", __func__, fullpath);
 
-	mutex_lock(&vol_lock);
+	spin_lock(&vol_list_lock);
 	vi = find_vol(fullpath);
-	if (!IS_ERR(vi))
-		free_vol(vi);
-	mutex_unlock(&vol_lock);
+	spin_unlock(&vol_list_lock);
+
+	kref_put(&vi->refcnt, vol_release);
 }
 
 /* Get all tcons that are within a DFS namespace and can be refreshed */
@@ -1449,27 +1469,52 @@ static void refresh_tcon(struct vol_info *vi, struct cifs_tcon *tcon)
  */
 static void refresh_cache_worker(struct work_struct *work)
 {
-	struct vol_info *vi;
+	struct vol_info *vi, *nvi;
 	struct TCP_Server_Info *server;
-	LIST_HEAD(list);
+	LIST_HEAD(vols);
+	LIST_HEAD(tcons);
 	struct cifs_tcon *tcon, *ntcon;
 
-	mutex_lock(&vol_lock);
-
+	/*
+	 * Find SMB volumes that are eligible (server->tcpStatus == CifsGood)
+	 * for refreshing.
+	 */
+	spin_lock(&vol_list_lock);
 	list_for_each_entry(vi, &vol_list, list) {
 		server = get_tcp_server(&vi->smb_vol);
 		if (!server)
 			continue;
 
-		get_tcons(server, &list);
-		list_for_each_entry_safe(tcon, ntcon, &list, ulist) {
+		kref_get(&vi->refcnt);
+		list_add_tail(&vi->rlist, &vols);
+		put_tcp_server(server);
+	}
+	spin_unlock(&vol_list_lock);
+
+	/* Walk through all TCONs and refresh any expired cache entry */
+	list_for_each_entry_safe(vi, nvi, &vols, rlist) {
+		spin_lock(&vi->smb_vol_lock);
+		server = get_tcp_server(&vi->smb_vol);
+		spin_unlock(&vi->smb_vol_lock);
+
+		if (!server)
+			goto next_vol;
+
+		get_tcons(server, &tcons);
+		list_for_each_entry_safe(tcon, ntcon, &tcons, ulist) {
 			refresh_tcon(vi, tcon);
 			list_del_init(&tcon->ulist);
 			cifs_put_tcon(tcon);
 		}
 
 		put_tcp_server(server);
+
+next_vol:
+		list_del_init(&vi->rlist);
+		kref_put(&vi->refcnt, vol_release);
 	}
+
+	spin_lock(&cache_ttl_lock);
 	queue_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
-	mutex_unlock(&vol_lock);
+	spin_unlock(&cache_ttl_lock);
 }
-- 
2.40.1

