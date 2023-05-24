Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CB770FA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjEXPhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbjEXPge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:36:34 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B710E7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:35:13 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4E7C63F452
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684942460;
        bh=j/vZphe6iawzwC+GAFA6qRSN3lvkZ4mAE+bgyLQQZEQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=imXshkHuCw3/YUan0IJiKbujCfMF+5vkS7QhmvJJg1R3yQIkewLDUKGjaXPTUiami
         cDqpNs3ctWg5EVmqcMZskEWrJPpR9hArStgk5SsqJlSdzJnlELz+7N/mbcmMrj+q7D
         Zb9GtZLgmf22NXdBYgNzY6opF2ywxkMKZ8mfJTJ9t69Nz5Y75Yr4sfvfsMc5Ey8hop
         sbdaL19jbL19dCbpXERe/52AjcIwwlJ+JKvUi+jz74g04oAJk0Irt0wkQsP0riXUkU
         HEauFkKME9pG+sRn2AirER6O9IPaDWO2c11lU2D++tSo545jqyEsEsUfEgYekyjdfa
         WGcodyCVO+n+w==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50dfa390825so1411617a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942459; x=1687534459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/vZphe6iawzwC+GAFA6qRSN3lvkZ4mAE+bgyLQQZEQ=;
        b=deGwzFks+KglQxPQtSFs5+chXRYV4TOVHpqDZOpOKpTJ+5YUwnEh+deuUFkHrURh+X
         Yr8uiMWfxMEJoOZ5fciGp2izoXxHugtkOIXCiH83868hsFWJMNRiB05a0j8elOyeqRit
         lRA9olwFmHvKgAh3b1ZeWwz96NlipsLPO6G2lfFmTGpmL1Vsopj3mpcN3n3uzQiobPjf
         zaqv4bggvHvufz2809cVM+2NECwOgFcN1iYSIjvNhK+PcMAk1BkpGhdZ/IhPOApK5rS/
         rVAe/dJvvGwBzJIQzjSG4oAI1p504sPdJ6cFD0VncpLWBnazHsCfjMhG5gv285iwLsyf
         +KIw==
X-Gm-Message-State: AC+VfDyGfchNM2P3diQBNvqPV54bNX4gBKnLTrqaxUygMWQn4qrmqLJa
        Xp9749otU04JBXCud4c3UfvizowGYvwbT3/6AsFbvX6RgnKWBh9RzgTpzk2Fc/A+FUqyfKOGBel
        MGM3QbiAxV1CSmbPfzXOFPktoOk4egPO2+GC2Z5cfQg==
X-Received: by 2002:a17:907:c26:b0:94e:e859:7b07 with SMTP id ga38-20020a1709070c2600b0094ee8597b07mr22066650ejc.32.1684942459656;
        Wed, 24 May 2023 08:34:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70ze+kK5xwEjLwX+w5pYZq2/22Y+g7DXsfrlfW78Xsf0MHGqqXeUaXUY3B25KagsieuVK90w==
X-Received: by 2002:a17:907:c26:b0:94e:e859:7b07 with SMTP id ga38-20020a1709070c2600b0094ee8597b07mr22066628ejc.32.1684942459495;
        Wed, 24 May 2023 08:34:19 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090664da00b0096f7105b3a6sm5986979ejn.189.2023.05.24.08.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:34:19 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] ceph/file: allow idmapped atomic_open inode op
Date:   Wed, 24 May 2023 17:33:14 +0200
Message-Id: <20230524153316.476973-13-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_atomic_open() to handle idmapped mounts. This is just a
matter of passing down the mount's idmapping.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v2:
	- rebased, see also 5fadbd9929 ("ceph: rely on vfs for setgid stripping")
---
 fs/ceph/file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f4d8bf7dec88..f00bfda4b1d2 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -654,7 +654,9 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 	in.truncate_seq = cpu_to_le32(1);
 	in.truncate_size = cpu_to_le64(-1ULL);
 	in.xattr_version = cpu_to_le64(1);
-	in.uid = cpu_to_le32(from_kuid(&init_user_ns, current_fsuid()));
+	in.uid = cpu_to_le32(from_kuid(&init_user_ns,
+				       mapped_fsuid(req->r_mnt_idmap,
+						    &init_user_ns)));
 	if (dir->i_mode & S_ISGID) {
 		in.gid = cpu_to_le32(from_kgid(&init_user_ns, dir->i_gid));
 
@@ -662,7 +664,9 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else {
-		in.gid = cpu_to_le32(from_kgid(&init_user_ns, current_fsgid()));
+		in.gid = cpu_to_le32(from_kgid(&init_user_ns,
+				     mapped_fsgid(req->r_mnt_idmap,
+						  &init_user_ns)));
 	}
 	in.mode = cpu_to_le32((u32)mode);
 
@@ -731,6 +735,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		     struct file *file, unsigned flags, umode_t mode)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct dentry *dn;
@@ -786,6 +791,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		mask |= CEPH_CAP_XATTR_SHARED;
 	req->r_args.open.mask = cpu_to_le32(mask);
 	req->r_parent = dir;
+	req->r_mnt_idmap = idmap;
 	ihold(dir);
 
 	if (flags & O_CREAT) {
-- 
2.34.1

