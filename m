Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2030B5EBDDC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiI0I5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiI0I5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:57:20 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92A4D7A527;
        Tue, 27 Sep 2022 01:57:18 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 1FBCE1E80D33;
        Tue, 27 Sep 2022 16:53:04 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zSR2IxmD8Duw; Tue, 27 Sep 2022 16:53:01 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 7F7131E80CF9;
        Tue, 27 Sep 2022 16:53:00 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     jlayton@kernel.org, xiubli@redhat.com, idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhoujie@nfschina.com
Subject: [PATCH] fs/ceph:Modify the return value to void
Date:   Tue, 27 Sep 2022 16:57:02 +0800
Message-Id: <20220927085702.10026-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the return value of the integer to void.

Signed-off-by: Zhou jie <zhoujie@nfschina.com>
---
 fs/ceph/debugfs.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index bec3c4549c07..e4852a1c4a0a 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -22,14 +22,14 @@
 #include "mds_client.h"
 #include "metric.h"
 
-static int mdsmap_show(struct seq_file *s, void *p)
+static void mdsmap_show(struct seq_file *s, void *p)
 {
 	int i;
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_mdsmap *mdsmap;
 
 	if (!fsc->mdsc || !fsc->mdsc->mdsmap)
-		return 0;
+		return;
 	mdsmap = fsc->mdsc->mdsmap;
 	seq_printf(s, "epoch %d\n", mdsmap->m_epoch);
 	seq_printf(s, "root %d\n", mdsmap->m_root);
@@ -43,13 +43,12 @@ static int mdsmap_show(struct seq_file *s, void *p)
 			       ceph_pr_addr(addr),
 			       ceph_mds_state_name(state));
 	}
-	return 0;
 }
 
 /*
  * mdsc debugfs
  */
-static int mdsc_show(struct seq_file *s, void *p)
+static void mdsc_show(struct seq_file *s, void *p)
 {
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -124,7 +123,6 @@ static int mdsc_show(struct seq_file *s, void *p)
 	}
 	mutex_unlock(&mdsc->mutex);
 
-	return 0;
 }
 
 #define CEPH_LAT_METRIC_SHOW(name, total, avg, min, max, sq) {		\
@@ -146,7 +144,7 @@ static int mdsc_show(struct seq_file *s, void *p)
 		   name, total, avg, _min, max, sum);			\
 }
 
-static int metrics_file_show(struct seq_file *s, void *p)
+static void metrics_file_show(struct seq_file *s, void *p)
 {
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_client_metric *m = &fsc->mdsc->metric;
@@ -161,7 +159,6 @@ static int metrics_file_show(struct seq_file *s, void *p)
 		   atomic64_read(&m->total_caps));
 	seq_printf(s, "%-35s%lld\n", "opened inodes",
 		   percpu_counter_sum(&m->opened_inodes));
-	return 0;
 }
 
 static const char * const metric_str[] = {
@@ -170,7 +167,7 @@ static const char * const metric_str[] = {
 	"metadata",
 	"copyfrom"
 };
-static int metrics_latency_show(struct seq_file *s, void *p)
+static void metrics_latency_show(struct seq_file *s, void *p)
 {
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_client_metric *cm = &fsc->mdsc->metric;
@@ -193,10 +190,9 @@ static int metrics_latency_show(struct seq_file *s, void *p)
 		CEPH_LAT_METRIC_SHOW(metric_str[i], total, avg, min, max, sq);
 	}
 
-	return 0;
 }
 
-static int metrics_size_show(struct seq_file *s, void *p)
+static void metrics_size_show(struct seq_file *s, void *p)
 {
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_client_metric *cm = &fsc->mdsc->metric;
@@ -223,10 +219,9 @@ static int metrics_size_show(struct seq_file *s, void *p)
 		CEPH_SZ_METRIC_SHOW(metric_str[i], total, avg, min, max, sum);
 	}
 
-	return 0;
 }
 
-static int metrics_caps_show(struct seq_file *s, void *p)
+static void metrics_caps_show(struct seq_file *s, void *p)
 {
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_client_metric *m = &fsc->mdsc->metric;
@@ -245,10 +240,9 @@ static int metrics_caps_show(struct seq_file *s, void *p)
 		   percpu_counter_sum(&m->i_caps_mis),
 		   percpu_counter_sum(&m->i_caps_hit));
 
-	return 0;
 }
 
-static int caps_show_cb(struct inode *inode, struct ceph_cap *cap, void *p)
+static void caps_show_cb(struct inode *inode, struct ceph_cap *cap, void *p)
 {
 	struct seq_file *s = p;
 
@@ -256,10 +250,9 @@ static int caps_show_cb(struct inode *inode, struct ceph_cap *cap, void *p)
 		   cap->session->s_mds,
 		   ceph_cap_string(cap->issued),
 		   ceph_cap_string(cap->implemented));
-	return 0;
 }
 
-static int caps_show(struct seq_file *s, void *p)
+static void caps_show(struct seq_file *s, void *p)
 {
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -304,10 +297,9 @@ static int caps_show(struct seq_file *s, void *p)
 	}
 	spin_unlock(&mdsc->caps_list_lock);
 
-	return 0;
 }
 
-static int mds_sessions_show(struct seq_file *s, void *ptr)
+static void mds_sessions_show(struct seq_file *s, void *ptr)
 {
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -340,10 +332,9 @@ static int mds_sessions_show(struct seq_file *s, void *ptr)
 	}
 	mutex_unlock(&mdsc->mutex);
 
-	return 0;
 }
 
-static int status_show(struct seq_file *s, void *p)
+static void status_show(struct seq_file *s, void *p)
 {
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_entity_inst *inst = &fsc->client->msgr.inst;
@@ -353,7 +344,6 @@ static int status_show(struct seq_file *s, void *p)
 		   ceph_pr_addr(client_addr), le32_to_cpu(client_addr->nonce));
 	seq_printf(s, "blocklisted: %s\n", fsc->blocklisted ? "true" : "false");
 
-	return 0;
 }
 
 DEFINE_SHOW_ATTRIBUTE(mdsmap);
@@ -370,20 +360,18 @@ DEFINE_SHOW_ATTRIBUTE(metrics_caps);
 /*
  * debugfs
  */
-static int congestion_kb_set(void *data, u64 val)
+static void congestion_kb_set(void *data, u64 val)
 {
 	struct ceph_fs_client *fsc = (struct ceph_fs_client *)data;
 
 	fsc->mount_options->congestion_kb = (int)val;
-	return 0;
 }
 
-static int congestion_kb_get(void *data, u64 *val)
+static void congestion_kb_get(void *data, u64 *val)
 {
 	struct ceph_fs_client *fsc = (struct ceph_fs_client *)data;
 
 	*val = (u64)fsc->mount_options->congestion_kb;
-	return 0;
 }
 
 DEFINE_SIMPLE_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
-- 
2.18.2

