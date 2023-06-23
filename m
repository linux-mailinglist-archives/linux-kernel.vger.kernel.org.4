Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3426173C2F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjFWVf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjFWVfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:35:41 -0400
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFC11FCE;
        Fri, 23 Jun 2023 14:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687556141; x=1719092141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qUk0Z0PFob4emRrFeAmspujbbtCA0yUs40XCJFSLUio=;
  b=cbhVBnKW5gEABXelB+nHsja7x2+Lz+hNEWVitqXEJYcHWSVSd8PCb3ty
   IMIDtzrch703ILEaDrpdDOt/zx8yIBvX+HLQIVUNw3c3n9+VqmyWEjhdw
   4LqIDR8GKq6fIsC6AacPcPzy/KqX/knqeDMJWYbNQplBgHKZKGMQBuxH2
   I=;
X-IronPort-AV: E=Sophos;i="6.01,153,1684800000"; 
   d="scan'208";a="568404616"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 21:35:39 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 9B3F3CD009;
        Fri, 23 Jun 2023 21:35:36 +0000 (UTC)
Received: from EX19D002UWC002.ant.amazon.com (10.13.138.166) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 23 Jun 2023 21:35:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D002UWC002.ant.amazon.com (10.13.138.166) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 23 Jun 2023 21:35:34 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Fri, 23 Jun 2023 21:35:34
 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
        id B7F7E311E; Fri, 23 Jun 2023 21:35:34 +0000 (UTC)
From:   Rishabh Bhatnagar <risbhat@amazon.com>
To:     <gregkh@linuxfoundation.org>, <pc@cjr.nz>
CC:     <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>, Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>,
        Rishabh Bhatnagar <risbhat@amazon.com>
Subject: [PATCH 5.4 2/5] cifs: Get rid of kstrdup_const()'d paths
Date:   Fri, 23 Jun 2023 21:34:03 +0000
Message-ID: <20230623213406.5596-3-risbhat@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623213406.5596-1-risbhat@amazon.com>
References: <20230623213406.5596-1-risbhat@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paulo Alcantara (SUSE)" <pc@cjr.nz>

commit 199c6bdfb04b71d88a7765e08285885fbca60df4 upstream.

The DFS cache API is mostly used with heap allocated strings.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
---
 fs/cifs/dfs_cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 4a241979c7c7..3ca65051b55c 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -131,7 +131,7 @@ static inline void flush_cache_ent(struct cache_entry *ce)
 		return;
 
 	hlist_del_init_rcu(&ce->hlist);
-	kfree_const(ce->path);
+	kfree(ce->path);
 	free_tgts(ce);
 	cache_count--;
 	call_rcu(&ce->rcu, free_cache_entry);
@@ -420,7 +420,7 @@ static struct cache_entry *alloc_cache_entry(const char *path,
 	if (!ce)
 		return ERR_PTR(-ENOMEM);
 
-	ce->path = kstrdup_const(path, GFP_KERNEL);
+	ce->path = kstrndup(path, strlen(path), GFP_KERNEL);
 	if (!ce->path) {
 		kmem_cache_free(cache_slab, ce);
 		return ERR_PTR(-ENOMEM);
@@ -430,7 +430,7 @@ static struct cache_entry *alloc_cache_entry(const char *path,
 
 	rc = copy_ref_data(refs, numrefs, ce, NULL);
 	if (rc) {
-		kfree_const(ce->path);
+		kfree(ce->path);
 		kmem_cache_free(cache_slab, ce);
 		ce = ERR_PTR(rc);
 	}
-- 
2.40.1

