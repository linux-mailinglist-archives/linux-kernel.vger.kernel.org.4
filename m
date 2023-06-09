Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6C72965D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbjFIKKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbjFIKKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:10:17 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950DA8692
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:59:16 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D57063F15D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303190;
        bh=2hwztFxZhmRTBhQzcOpavHgJ6h9g0DydFvSzqcbHOs4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=gnIAQkU5IQwVZT/mb4HqZ/A0yOpNhVz5GmtWYTjNRRoq+7mZNRaAkR7XplOF7bvM8
         LObbxLfaLRX2iVz7q+46V63+KFzXOymSMcoTl2g5wceo8kDkxeI7qhpWKnOklalskU
         zhmMjuz4U3UZDVO2eOtVLAz425t265ejn/z6gHUVm7MVrozyaT03eznZw6oYSRswNv
         6DKNMbg4IzaumociTwxq84FaxmFuAST9GyT9X4JOc8GPC9hBG/0Dc41jQR68vZUTFT
         TXAPRq552NELtnqaRgM4yzGeRVhL3TOlCD9JBnHUt4IXxeenLMuYwj04FAd5YmeLZl
         ODSNyX9BB8kgg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9745c72d99cso207741166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 02:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303190; x=1688895190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hwztFxZhmRTBhQzcOpavHgJ6h9g0DydFvSzqcbHOs4=;
        b=WyDp2UYFdyfyXlbfn/tI8aYQJRaf/YdUIrs1566t91ezyDTPyiGYiYscwk9Y/OFtVr
         3baf6oxJf20s8b00MT0CsQLWnsNBdYfM5h6RZE2/j0ke+LIvYkaGzCUcYwKC3vx/hf6S
         qMzuvqFU4UrOqOEuj0JHon+GMuF+U3tyj9KpSpmsHbAH+FmFAioX3Ujpg2zWdLKJr6H+
         4NnFORYDSp6GDpq1WhxRmJ5F8Qeuiu0zPBuDUF2BVJt3Fs8xdj6ms4FRoVRU99qWgOYK
         DrMkpho8lCYKB6K5grT8iqqatSV4enkY6NUhjHJoPTJf2+LJbsgtSWbGxLDybYvUZWWy
         TEPQ==
X-Gm-Message-State: AC+VfDwyuAI5OzTZfTux3v5hToghTSyGa3AYaRFfF9EkXl6DrDrLhBDT
        trXc5OEeL92ekY71Wk8NbYleN9gcupr5RbdG9kaUULZHhqaZALgESLYZNqsuBDKiaZa5PiJL0M1
        /zaupZtu0VuT+nWlJlspsScGlFcfgSrCFa/XG2BfE7A==
X-Received: by 2002:a17:907:3d93:b0:94f:2a13:4e01 with SMTP id he19-20020a1709073d9300b0094f2a134e01mr1371729ejc.74.1686303190606;
        Fri, 09 Jun 2023 02:33:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MsL6zC8MBPYxx1/IN/olzX93IyA3TrvCsZrn7wnZMo+W05KzTTK8rzx2rV8d5frIVKKWmuA==
X-Received: by 2002:a17:907:3d93:b0:94f:2a13:4e01 with SMTP id he19-20020a1709073d9300b0094f2a134e01mr1371717ejc.74.1686303190365;
        Fri, 09 Jun 2023 02:33:10 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:33:10 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/15] ceph: pass idmap to ceph_netfs_issue_op_inline
Date:   Fri,  9 Jun 2023 11:31:25 +0200
Message-Id: <20230609093125.252186-15-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just pass down the mount's idmapping to ceph_netfs_issue_op_inline.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: brauner@kernel.org
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/addr.c  | 12 ++++++++++++
 fs/ceph/super.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 0a32475ed034..2759a0cf2381 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -291,6 +291,8 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
+	struct ceph_netfs_request_data *priv = rreq->netfs_priv;
+	struct mnt_idmap *idmap = priv->mnt_idmap;
 	struct ceph_mds_reply_info_parsed *rinfo;
 	struct ceph_mds_reply_info_in *iinfo;
 	struct ceph_mds_request *req;
@@ -318,6 +320,8 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	req->r_args.getattr.mask = cpu_to_le32(CEPH_STAT_CAP_INLINE_DATA);
 	req->r_num_caps = 2;
 
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
+
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	if (err < 0)
 		goto out;
@@ -443,13 +447,18 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->mnt_idmap = &nop_mnt_idmap;
+
 	if (file) {
 		struct ceph_rw_context *rw_ctx;
 		struct ceph_file_info *fi = file->private_data;
+		struct mnt_idmap *idmap = file_mnt_idmap(file);
 
 		priv->file_ra_pages = file->f_ra.ra_pages;
 		priv->file_ra_disabled = file->f_mode & FMODE_RANDOM;
 
+		priv->mnt_idmap = mnt_idmap_get(idmap);
+
 		rw_ctx = ceph_find_rw_context(fi);
 		if (rw_ctx) {
 			rreq->netfs_priv = priv;
@@ -496,6 +505,9 @@ static void ceph_netfs_free_request(struct netfs_io_request *rreq)
 
 	if (priv->caps)
 		ceph_put_cap_refs(ceph_inode(rreq->inode), priv->caps);
+
+	mnt_idmap_put(priv->mnt_idmap);
+
 	kfree(priv);
 	rreq->netfs_priv = NULL;
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d89e7b99ac5f..0badf58fb5fc 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -481,6 +481,8 @@ struct ceph_netfs_request_data {
 
 	/* Set it if fadvise disables file readahead entirely */
 	bool file_ra_disabled;
+
+	struct mnt_idmap *mnt_idmap;
 };
 
 static inline struct ceph_inode_info *
-- 
2.34.1

