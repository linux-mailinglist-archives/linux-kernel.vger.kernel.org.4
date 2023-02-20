Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B406069D431
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjBTTip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjBTTie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:38:34 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB31E9EF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:25 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2397E3F588
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676921902;
        bh=rNKn8l0DXhBBWayY+UE9TrV0KD39Snp/RxB5yHis2Hs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=A0fPwJUhCL1FZbUUdAv9mHMilT4wqAPQIxR8WgkCzVr4eyPnfX/n8thRJJYE5SKqD
         8wvIM3Wf211x7G98Vy59S0+H1HBl0+TV2QsaycuEZJuxOTNUkhb3kkAAXtk3yTPUjj
         p8UvT9u5birLTRn/RaO6IExAhEUimSJx5eSIbVOnVBtursEbs24G8i2U34al5aruas
         wIew9uH4E1f0eaJr3l+p4AEWdvJ4Xn9J3iB0ICf/OUek0gDxAfES9muayZku9qCow1
         Q14+VqUHkqVlAcVglll1N4D0CM3H1k3M027NGNB9YKyqOB4sgcw+iI7fyRIbiYWoru
         Pfwf1Xl7zs6LA==
Received: by mail-ed1-f70.google.com with SMTP id eh16-20020a0564020f9000b004acc4f8aa3fso2807907edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNKn8l0DXhBBWayY+UE9TrV0KD39Snp/RxB5yHis2Hs=;
        b=7xzfWYIxROdStJh7bu3r+gHVg+/Jea4kWd4SYqgCpKwFpmyTqObDD3ivPu66iA/y71
         BWPJfVaD6pLtniYDFQ/2JBqL3TB33T7GRtIPPTKyueG5Jl4DlFXOUEStNEFdttFBzqSh
         3AvX5nNj0118OHuMqG1MbJvfDiZPx+FaYH+874RdSGT4kKYyUDOtFnGcUK+9Kv9nc/yE
         vHeS4m0uLUXajq0PonGWlMEpCteHrHvcr5h39G9nNBVIOZaHtStmDYkl0zUfSXsl/EAw
         xQRsSrzSaDB+Fr1SK8D9DMp1FWVV7FpEkpfBUD0AFelXVBEImfFGyqbWwsHFvMQZQJ+c
         EyWw==
X-Gm-Message-State: AO0yUKXvgkwNaqzFFUX/sgiHU47ZXRD/QtMDPzntJpOJ4klMX+K8xd4Y
        1sXTo6KfnoCPhBc9XGA71ZWHFVKzTY5/GNSZKB4AOHwzUSwLRsGFwDf4M/TzySv70hpuBV9oLT0
        VVS+OIrpwiX3zoBPNc91MR8LtNQ4R9w9x5/cVuIvyvA==
X-Received: by 2002:a17:907:d87:b0:8bf:2458:a82a with SMTP id go7-20020a1709070d8700b008bf2458a82amr10939216ejc.75.1676921896350;
        Mon, 20 Feb 2023 11:38:16 -0800 (PST)
X-Google-Smtp-Source: AK7set8hs5/aMnQF9o5ErDn38JnV32O18k1wgH8DVVkd729EJttLELb83cIFAps5N4mV3Dcuf4NpEw==
X-Received: by 2002:a17:907:d87:b0:8bf:2458:a82a with SMTP id go7-20020a1709070d8700b008bf2458a82amr10939203ejc.75.1676921896217;
        Mon, 20 Feb 2023 11:38:16 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:bb20:aed2:bb7f:f0cf])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1526693ejx.195.2023.02.20.11.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:38:15 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH 3/9] fuse: add fuse connection generation
Date:   Mon, 20 Feb 2023 20:37:48 +0100
Message-Id: <20230220193754.470330-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will use connection generation to detect stale inodes
from the "old" fuse daemon and invalidate/revalidate them.

There is no functional changes.

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/file.c   |  1 +
 fs/fuse/fuse_i.h | 29 +++++++++++++++++++++++++++++
 fs/fuse/inode.c  |  2 ++
 3 files changed, 32 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3eb28aad5674..6d89d4dd4c55 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -78,6 +78,7 @@ struct fuse_file *fuse_file_alloc(struct fuse_mount *fm)
 	init_waitqueue_head(&ff->poll_wait);
 
 	ff->kh = atomic64_inc_return(&fm->fc->khctr);
+	ff->conn_gen = READ_ONCE(fm->fc->conn_gen);
 
 	return ff;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d5fc2d89ff1c..ccd7c145de94 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -161,6 +161,9 @@ struct fuse_inode {
 	 */
 	struct fuse_inode_dax *dax;
 #endif
+
+	/** Fuse connection (fuse_conn) generation when inode was allocated */
+	u32 conn_gen;
 };
 
 /** FUSE inode state bits */
@@ -232,6 +235,9 @@ struct fuse_file {
 
 	/** Has flock been performed on this file? */
 	bool flock:1;
+
+	/** Fuse connection (fuse_conn) generation when file was allocated */
+	u32 conn_gen;
 };
 
 /** One input argument of a request */
@@ -847,6 +853,18 @@ struct fuse_conn {
 
 	/* New writepages go into this bucket */
 	struct fuse_sync_bucket __rcu *curr_bucket;
+
+	/**
+	 * Connection generation.
+	 * Used to determine if inodes/files were created with an "old"
+	 * fuse connection and have to be invalidated. So, all requests
+	 * related to these inodes should fail with -EIO.
+	 *
+	 * CHECKME: do we really need conn_gen for struct fuse_file?
+	 * Right now it's only needed for fuse_file_put(), where we have
+	 * no access to the inode in some cases.
+	 */
+	u32 conn_gen;
 };
 
 /*
@@ -910,6 +928,17 @@ static inline u64 fuse_get_attr_version(const struct fuse_conn *fc)
 	return atomic64_read(&fc->attr_version);
 }
 
+static inline bool fuse_stale_ff(const struct fuse_file *ff)
+{
+	return unlikely(READ_ONCE(ff->fm->fc->conn_gen) != ff->conn_gen);
+}
+
+static inline bool fuse_stale_inode_conn(const struct inode *inode)
+{
+	return unlikely(READ_ONCE(get_fuse_conn(inode)->conn_gen) !=
+			get_fuse_inode(inode)->conn_gen);
+}
+
 static inline bool fuse_stale_inode(const struct inode *inode, int generation,
 				    struct fuse_attr *attr)
 {
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 097b7049057e..c604434611d9 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -77,6 +77,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->attr_version = 0;
 	fi->orig_ino = 0;
 	fi->state = 0;
+	fi->conn_gen = READ_ONCE(get_fuse_conn_super(sb)->conn_gen);
 	mutex_init(&fi->mutex);
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
@@ -841,6 +842,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
+	fc->conn_gen = 1;
 
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
-- 
2.34.1

