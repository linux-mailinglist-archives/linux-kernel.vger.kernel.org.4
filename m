Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B3A73ED84
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjFZVxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjFZVwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:52:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB0235AD;
        Mon, 26 Jun 2023 14:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12AF060EB2;
        Mon, 26 Jun 2023 21:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50225C433C8;
        Mon, 26 Jun 2023 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816242;
        bh=tMYO2YkFt7jmhducIbhA74XKtcMxH+f9qzOP8oqdIu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2G3JIQdcyMztmiFPZi9noYo1ucGmtaK06oDEjOwfGUpgnPkjqFUgunIMviYm0Vdn
         j4ef0yaI38rD1IR6B7iBSZU37MHzdzKHezwOk+isXa/1J8VXfBHAcMt/tVJjTWK3Ov
         R+VXs16jiBfDHGEiHI4pe3djGzAL7Lr/G3xUsQXlK2BQfgmu16x4lC1qFDYr9oAH6R
         FlWW4kMA4pIxtMOOOTENfp8xYJNIu4MG/d+8tr0dDdt2VGNQdEIVrne2Q/u8+ED59B
         YcTLpOAmTsdUMpMhNml4YG+xnhNTxUm8dJdHwfTrBuP8a8pnyPub5htM5HWEzYCH+r
         gWSf8YzZoCvCQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shyam Prasad N <sprasad@microsoft.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, pc@cjr.nz,
        lsahlber@redhat.com, pc@manguebit.com, ematsumiya@suse.de,
        zhangxiaoxu5@huawei.com, dhowells@redhat.com, brauner@kernel.org,
        vl@samba.org
Subject: [PATCH AUTOSEL 6.1 06/15] cifs: fix sockaddr comparison in iface_cmp
Date:   Mon, 26 Jun 2023 17:50:22 -0400
Message-Id: <20230626215031.179159-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215031.179159-1-sashal@kernel.org>
References: <20230626215031.179159-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.35
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 2991b77409891e14a10b96899755c004b0c07edb ]

iface_cmp used to simply do a memcmp of the two
provided struct sockaddrs. The comparison needs to do more
based on the address family. Similar logic was already
present in cifs_match_ipaddr. Doing something similar now.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsglob.h  | 37 ---------------------------------
 fs/cifs/cifsproto.h |  1 +
 fs/cifs/connect.c   | 50 +++++++++++++++++++++++++++++++++++++++++++++
 fs/cifs/smb2ops.c   | 37 +++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 37 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 6ec1a34738e27..3b5a0a2fd431c 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -970,43 +970,6 @@ release_iface(struct kref *ref)
 	kfree(iface);
 }
 
-/*
- * compare two interfaces a and b
- * return 0 if everything matches.
- * return 1 if a has higher link speed, or rdma capable, or rss capable
- * return -1 otherwise.
- */
-static inline int
-iface_cmp(struct cifs_server_iface *a, struct cifs_server_iface *b)
-{
-	int cmp_ret = 0;
-
-	WARN_ON(!a || !b);
-	if (a->speed == b->speed) {
-		if (a->rdma_capable == b->rdma_capable) {
-			if (a->rss_capable == b->rss_capable) {
-				cmp_ret = memcmp(&a->sockaddr, &b->sockaddr,
-						 sizeof(a->sockaddr));
-				if (!cmp_ret)
-					return 0;
-				else if (cmp_ret > 0)
-					return 1;
-				else
-					return -1;
-			} else if (a->rss_capable > b->rss_capable)
-				return 1;
-			else
-				return -1;
-		} else if (a->rdma_capable > b->rdma_capable)
-			return 1;
-		else
-			return -1;
-	} else if (a->speed > b->speed)
-		return 1;
-	else
-		return -1;
-}
-
 struct cifs_chan {
 	unsigned int in_reconnect : 1; /* if session setup in progress for this channel */
 	struct TCP_Server_Info *server;
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 98513f5af3f96..a914b88ca51a1 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -85,6 +85,7 @@ extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct mid_q_entry *mid);
 extern int smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx);
 extern int smb3_parse_opt(const char *options, const char *key, char **val);
+extern int cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs);
 extern bool cifs_match_ipaddr(struct sockaddr *srcaddr, struct sockaddr *rhs);
 extern int cifs_discard_remaining_data(struct TCP_Server_Info *server);
 extern int cifs_call_async(struct TCP_Server_Info *server,
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 935fe198a4baf..6e2744f0b545b 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1332,6 +1332,56 @@ cifs_demultiplex_thread(void *p)
 	module_put_and_kthread_exit(0);
 }
 
+int
+cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs)
+{
+	struct sockaddr_in *saddr4 = (struct sockaddr_in *)srcaddr;
+	struct sockaddr_in *vaddr4 = (struct sockaddr_in *)rhs;
+	struct sockaddr_in6 *saddr6 = (struct sockaddr_in6 *)srcaddr;
+	struct sockaddr_in6 *vaddr6 = (struct sockaddr_in6 *)rhs;
+
+	switch (srcaddr->sa_family) {
+	case AF_UNSPEC:
+		switch (rhs->sa_family) {
+		case AF_UNSPEC:
+			return 0;
+		case AF_INET:
+		case AF_INET6:
+			return 1;
+		default:
+			return -1;
+		}
+	case AF_INET: {
+		switch (rhs->sa_family) {
+		case AF_UNSPEC:
+			return -1;
+		case AF_INET:
+			return memcmp(saddr4, vaddr4,
+				      sizeof(struct sockaddr_in));
+		case AF_INET6:
+			return 1;
+		default:
+			return -1;
+		}
+	}
+	case AF_INET6: {
+		switch (rhs->sa_family) {
+		case AF_UNSPEC:
+		case AF_INET:
+			return -1;
+		case AF_INET6:
+			return memcmp(saddr6,
+				      vaddr6,
+				      sizeof(struct sockaddr_in6));
+		default:
+			return -1;
+		}
+	}
+	default:
+		return -1; /* don't expect to be here */
+	}
+}
+
 /*
  * Returns true if srcaddr isn't specified and rhs isn't specified, or
  * if srcaddr is specified and matches the IP address of the rhs argument
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index d512440d35b6f..759a7d7b3ddfe 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -510,6 +510,43 @@ smb3_negotiate_rsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	return rsize;
 }
 
+/*
+ * compare two interfaces a and b
+ * return 0 if everything matches.
+ * return 1 if a is rdma capable, or rss capable, or has higher link speed
+ * return -1 otherwise.
+ */
+static int
+iface_cmp(struct cifs_server_iface *a, struct cifs_server_iface *b)
+{
+	int cmp_ret = 0;
+
+	WARN_ON(!a || !b);
+	if (a->rdma_capable == b->rdma_capable) {
+		if (a->rss_capable == b->rss_capable) {
+			if (a->speed == b->speed) {
+				cmp_ret = cifs_ipaddr_cmp((struct sockaddr *) &a->sockaddr,
+							  (struct sockaddr *) &b->sockaddr);
+				if (!cmp_ret)
+					return 0;
+				else if (cmp_ret > 0)
+					return 1;
+				else
+					return -1;
+			} else if (a->speed > b->speed)
+				return 1;
+			else
+				return -1;
+		} else if (a->rss_capable > b->rss_capable)
+			return 1;
+		else
+			return -1;
+	} else if (a->rdma_capable > b->rdma_capable)
+		return 1;
+	else
+		return -1;
+}
+
 static int
 parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			size_t buf_len, struct cifs_ses *ses, bool in_mount)
-- 
2.39.2

