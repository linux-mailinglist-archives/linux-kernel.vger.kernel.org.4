Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306756F5991
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjECOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjECOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:11:50 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF5C59F0;
        Wed,  3 May 2023 07:11:49 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75131c2997bso227471585a.1;
        Wed, 03 May 2023 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683123108; x=1685715108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gUG4sgiQ1KTeWUq0RWqJ+AL9Ulz9Emys2lp8p49mD5s=;
        b=rsVvo1MaAxxvWQVE8a5FCgk271oCPa7AFeqUNjH6/7+2ugf+EiZEGJzNE8ao6Doj6t
         FCOMbihFCQehwpN97HcEac4vldNeeF+zfGj56xFKoi1kMVDssrFv8AHNdHxVqOrRUCcZ
         12PbplJFsUI01rHOPI3D8pODprPejrogUCjfF1HO0Yvbfh4rokDqkJqelu06D1HEFali
         qocdi8YOQYAHDdb/ytqCW/u1w4cyQEx4DYZlo4/6MitiNEOyqbM5rYcSUoJfEAv/vuS8
         ClfwGMI3fRfTRxZMdUfgMx6IyjcD+X4h5/kPMy5wmnFK71OQ9pyzv+t5/a9BfYXTVej+
         dZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683123108; x=1685715108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUG4sgiQ1KTeWUq0RWqJ+AL9Ulz9Emys2lp8p49mD5s=;
        b=kT6dEQrWd9Fwo9LLnIc0Nu+70f5PNa3mY9fdhZEz61NXhNcYNQbdgmTwXAmoU2oQGj
         8z3yfAjCXhpV0yVBU4LcmeH5dVY0mFoB7hRnvX7UTHVNA4WupzhJUKYKwc5i5U4CGld+
         T2MnDaWUdXPvT1t85k5S7CQ7qwAW7J0v3ukGvqvBnDTBHmXGMVprSZIWbAfd5XYKzuXT
         fHzrsXiDz7cj4Yb2SoJWg5+aiJHiyY1M2N9Yd5tUx9RrP5tVVcYETcKEdvFslCpKiEGy
         lheO40uTEDtoRFCiG0UAhlWlkx6O084s0EzJw5zObW53W14kg4uJMtcSJAc7n5SHk7xf
         U1yw==
X-Gm-Message-State: AC+VfDxw0wq30oB595GQz0MUx7PfYEx8C6zMaGP8tvMKrdmFS2D/GNcz
        pJqCPr7hec3z19lV1c6iMOM=
X-Google-Smtp-Source: ACHHUZ61fVaZwt1vUlMIS5/1x/krBw24HmhirjusDb86fZD1DnQ0fQ02fTjFpaw4dwNSF9rp2B/dDg==
X-Received: by 2002:a05:622a:190c:b0:3ef:3824:b8b0 with SMTP id w12-20020a05622a190c00b003ef3824b8b0mr461735qtc.5.1683123108129;
        Wed, 03 May 2023 07:11:48 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com (207-172-141-204.s8906.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [207.172.141.204])
        by smtp.gmail.com with ESMTPSA id r2-20020a05622a034200b003ef42f84532sm11459281qtw.49.2023.05.03.07.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 07:11:47 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Jason Andryuk <jandryuk@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2] 9p: Remove INET dependency
Date:   Wed,  3 May 2023 10:11:20 -0400
Message-Id: <20230503141123.23290-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

9pfs can run over assorted transports, so it doesn't have an INET
dependency.  Drop it and remove the includes of linux/inet.h.

NET_9P_FD/trans_fd.o builds without INET or UNIX and is unusable over
plain file descriptors.  However, tcp and unix functionality is still
built and would generate runtime failures if used.  Add imply INET and
UNIX to NET_9P_FD, so functionality is enabled by default but can still
be explicitly disabled.

This allows configuring 9pfs over Xen with INET and UNIX disabled.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
v2
Add imply INET and UNIX
---
 fs/9p/Kconfig          | 2 +-
 fs/9p/vfs_addr.c       | 1 -
 fs/9p/vfs_dentry.c     | 1 -
 fs/9p/vfs_dir.c        | 1 -
 fs/9p/vfs_file.c       | 1 -
 fs/9p/vfs_inode.c      | 1 -
 fs/9p/vfs_inode_dotl.c | 1 -
 fs/9p/vfs_super.c      | 1 -
 net/9p/Kconfig         | 2 ++
 9 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/9p/Kconfig b/fs/9p/Kconfig
index d7bc93447c85..0c63df574ee7 100644
--- a/fs/9p/Kconfig
+++ b/fs/9p/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config 9P_FS
 	tristate "Plan 9 Resource Sharing Support (9P2000)"
-	depends on INET && NET_9P
+	depends on NET_9P
 	select NETFS_SUPPORT
 	help
 	  If you say Y here, you will get experimental support for
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 6f46d7e4c750..425956eb9fde 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -12,7 +12,6 @@
 #include <linux/file.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/inet.h>
 #include <linux/pagemap.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 65fa2df5e49b..f16f73581634 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -13,7 +13,6 @@
 #include <linux/pagemap.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/inet.h>
 #include <linux/namei.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 3d74b04fe0de..52bf87934650 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -13,7 +13,6 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/sched.h>
-#include <linux/inet.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/fscache.h>
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 44c15eb2b908..367a851eaa82 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -14,7 +14,6 @@
 #include <linux/file.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/inet.h>
 #include <linux/list.h>
 #include <linux/pagemap.h>
 #include <linux/utsname.h>
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 1d523bec0a94..502ac74e4959 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -15,7 +15,6 @@
 #include <linux/pagemap.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/inet.h>
 #include <linux/namei.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 331ed60d8fcb..a7da49906d99 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -13,7 +13,6 @@
 #include <linux/pagemap.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/inet.h>
 #include <linux/namei.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 266c4693e20c..10449994a972 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -12,7 +12,6 @@
 #include <linux/file.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/inet.h>
 #include <linux/pagemap.h>
 #include <linux/mount.h>
 #include <linux/sched.h>
diff --git a/net/9p/Kconfig b/net/9p/Kconfig
index deabbd376cb1..00ebce9e5a65 100644
--- a/net/9p/Kconfig
+++ b/net/9p/Kconfig
@@ -17,6 +17,8 @@ if NET_9P
 
 config NET_9P_FD
 	default NET_9P
+	imply INET
+	imply UNIX
 	tristate "9P FD Transport"
 	help
 	  This builds support for transports over TCP, Unix sockets and
-- 
2.40.1

