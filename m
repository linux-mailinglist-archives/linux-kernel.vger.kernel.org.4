Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADD06AA9D3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCDN1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCDN1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:27:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AB91632F
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677936390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o+BfPKfMV9FPE8I8DD3zBXj28xwofcn4hyxEYIowXkA=;
        b=O7I/bpu5eOXMKPVD7BGVBOcxEBa5mxzJhHpWx1n+FrvwGix/JNS+gNr+L1XqjZHRUyyswl
        sXvuwGz0F58zFDsxmJbG6ZxuYnrv/mwoOfIqhqELxV46ssuPlqkQH0QzRdjBeHWG7H2JN9
        9KtdQkM9+8+vWUZZrVWP8rhDvoSGz+Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-wrY-VUF7M72MNEUgigALRA-1; Sat, 04 Mar 2023 08:26:29 -0500
X-MC-Unique: wrY-VUF7M72MNEUgigALRA-1
Received: by mail-qk1-f197.google.com with SMTP id s21-20020a05620a0bd500b0074234f33f24so3055051qki.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:26:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+BfPKfMV9FPE8I8DD3zBXj28xwofcn4hyxEYIowXkA=;
        b=kUSEu5ZoUuYtPq/GY47mQdhbWHJU6RyBHA70IrabgQbPc3cDJCB6MHhplXhQhtv2qO
         QZRy8ZpuAxNeDBJGm8geVPerh3VNmzOqzpo1Zfl3Yw5taujmohYk72bBeSNJHBnKiLPs
         7OIBveeRxBsmWQA+opNTqkp1OoZ31x7LS5VIbMUFaZ263n/8QdYFcG+0YpaKrhIpgH7e
         BnHrD+IjMNhM8NvXHFD7C8tEs8vzMpaEb51/bSGATVrbFSuVstYt9olon0UK+Dq2VkQJ
         tQM+5G+doCRee2nOM+0++JVc5z9sE3MOYT3e9D1ndj4Kjc6BtXdm9K6Sh6bgQKZqEvro
         Cphw==
X-Gm-Message-State: AO0yUKUL5xYQQcM3imfDgWcuLDjpM3tACDyriDJEQlHYWE/NXY28oTNF
        6cu84pe9c2i8L5PCTNI0RSNGB7O9RDa4A9Yn56hLKsSx5yEdI3FedNcwce7X5mBwnE++8OCOV8o
        rzqWFS2dsx9Ct6yKtz4dlfYzp
X-Received: by 2002:ac8:5c16:0:b0:3bf:d237:b12a with SMTP id i22-20020ac85c16000000b003bfd237b12amr5893380qti.56.1677936388623;
        Sat, 04 Mar 2023 05:26:28 -0800 (PST)
X-Google-Smtp-Source: AK7set/YbLpDQrN0mdiFLKbZlCfgTpafc0LpGjIXy2E6eFPSzph2ZgM4mRiQsUVLhhdqACgAq9bG7g==
X-Received: by 2002:ac8:5c16:0:b0:3bf:d237:b12a with SMTP id i22-20020ac85c16000000b003bfd237b12amr5893361qti.56.1677936388354;
        Sat, 04 Mar 2023 05:26:28 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d82-20020a376855000000b007419eb86df0sm3721036qkc.127.2023.03.04.05.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:26:27 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     rpeterso@redhat.com, agruenba@redhat.com
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] gfs2: remove extern from free_local_statfs_inodes and find_local_statfs_inode
Date:   Sat,  4 Mar 2023 08:26:25 -0500
Message-Id: <20230304132625.1936034-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
fs/gfs2/super.c:1477:13: warning: function 'free_local_statfs_inodes' with external linkage has definition
fs/gfs2/super.c:1492:21: warning: function 'find_local_statfs_inode' with external linkage has definition

extern is only needed in a declaration, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/gfs2/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index a83fa62106f0..189d7f7a4548 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1474,7 +1474,7 @@ static void gfs2_free_inode(struct inode *inode)
 	kmem_cache_free(gfs2_inode_cachep, GFS2_I(inode));
 }
 
-extern void free_local_statfs_inodes(struct gfs2_sbd *sdp)
+void free_local_statfs_inodes(struct gfs2_sbd *sdp)
 {
 	struct local_statfs_inode *lsi, *safe;
 
@@ -1489,8 +1489,8 @@ extern void free_local_statfs_inodes(struct gfs2_sbd *sdp)
 	}
 }
 
-extern struct inode *find_local_statfs_inode(struct gfs2_sbd *sdp,
-					     unsigned int index)
+struct inode *find_local_statfs_inode(struct gfs2_sbd *sdp,
+				      unsigned int index)
 {
 	struct local_statfs_inode *lsi;
 
-- 
2.27.0

