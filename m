Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8309E6F367A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjEATGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEATGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:06:20 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A4210F8
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:06:19 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-74e1745356dso121291685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682967978; x=1685559978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7SjFUEVHFEjNXjqk3Wy4WFYpwQq7tXRNuaA2WillKc=;
        b=qwmwpYuP3xJ5FM+y+ACsPfCdOO8roj6KCkX910r3xQCCDNB97gVQgj+ELmYPvVkL/7
         RrTK30prgoCHSUlLvbOIsVHh7eOGhigLXhKRJ3tO0PqkzKA2eZpM68o71hHQ+IItwzff
         e7DlmC+daNuiKB//KopiCzWx9tUvQVIAmX1REGR6EiU82MkSLkFeD/3r9/TDQ74tWZSv
         tEX6APB86Fb/Np4x0eIDA1qLprguHcdCEc3VUlJ/0ThofuXK8MrFeuGP7MFg3PziJJc1
         oGdVw+6lqPFJ11IiBnJv/rpayHkPDP1lHSFAMp42KlUYqkeozj3MSLUF8zY9ttCc13Go
         SS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682967978; x=1685559978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7SjFUEVHFEjNXjqk3Wy4WFYpwQq7tXRNuaA2WillKc=;
        b=aRxJ5L/jTfjYwMw+9J7cot0Tx2Jxhl3SOMz3yDLQLglZMr3M1W9W8MQdrlnVYmvVG3
         g5v6/OdujoNSK5Ky55guU6r40Ab+LG5ECflVq7voITToul4sufs6rL3+FfEc9xWpT4Mm
         KSm8Tb375cZaQ64i9bCtPbEDcMmMrPPoAWb/cE1eev6MHkZUU2A+FN3pxTHV/yKKLywH
         Y9z20+MAgnXWt6hUehIAGriaqfhyqCOtTu2Zm1hgVEe6ZHgNaVnV2sVXWNdd/lPHXqND
         TeAoSuKTpgoD6GtYGapi5s+gdjJbNWBmyePR3Q8JJPdDuoYMtOyqxM/Mo8QJDfCljrWr
         A1qw==
X-Gm-Message-State: AC+VfDwsSOeXZuTuawH0fy+SN0nAi+4xInfl+DaBEitEB9rjagfT7xAN
        BN2tJ2HKyqZFgv3nhaxdtFY=
X-Google-Smtp-Source: ACHHUZ7xIwiZkmlPBcLiddlfv4WObvEczwG21UftYy8+tFHEyD8EmHDM/h9Hd/lsgrr2BarWWtut7g==
X-Received: by 2002:a05:6214:5019:b0:619:ca55:970a with SMTP id jo25-20020a056214501900b00619ca55970amr1613558qvb.47.1682967978378;
        Mon, 01 May 2023 12:06:18 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com (207-172-141-204.s8906.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [207.172.141.204])
        by smtp.gmail.com with ESMTPSA id g7-20020a0ce4c7000000b005dd8b9345casm8918208qvm.98.2023.05.01.12.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:06:15 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Jason Andryuk <jandryuk@gmail.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/9p: Remove INET dependency
Date:   Mon,  1 May 2023 15:06:00 -0400
Message-Id: <20230501190602.86281-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.40.0
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

This allows configuring 9pfs over Xen with INET disabled.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 fs/9p/Kconfig          | 2 +-
 fs/9p/vfs_addr.c       | 1 -
 fs/9p/vfs_dentry.c     | 1 -
 fs/9p/vfs_dir.c        | 1 -
 fs/9p/vfs_file.c       | 1 -
 fs/9p/vfs_inode.c      | 1 -
 fs/9p/vfs_inode_dotl.c | 1 -
 fs/9p/vfs_super.c      | 1 -
 8 files changed, 1 insertion(+), 8 deletions(-)

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
-- 
2.40.0

