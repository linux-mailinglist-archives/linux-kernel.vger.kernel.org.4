Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513886A647A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCAAyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCAAyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:54:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0633757B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:54:14 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v11so8804029plz.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112; t=1677632054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZtlzZe/d0Q6OhRvlvfAoNbZgUxzzVMGIFQwl5nnqEQ=;
        b=GsZa91gxGV5DheeCaS+3CJZB0hyP0XJp42gYcgHEBlqBeffIUFRwKZtsF0dBFslIGz
         Sz05pSpEb5ec2/fRF15GJADm+MG3GUiywUvYRLgMJbS1JKdNEiJGoS/ZJA5uh5ZNRHFR
         1hCb4UmmRWuYbEUA7a/ACtWlqgblcD8i+mQ8qpjksoshdt4pBgkrZqifPJ8thWelGdVl
         pwP0/pAVMTOLnGVqLr0fkL81VyRgvc+YRJY0vpM1hdne9ushPypUbP+ODr96W58ZLOSk
         V51VgGEgJHBawzFh7bzagaWhcx2OeVzN/yCiwIqLO+s/NKWDTEpxdE6lSuSA1jxTNHlD
         VGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677632054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZtlzZe/d0Q6OhRvlvfAoNbZgUxzzVMGIFQwl5nnqEQ=;
        b=sW9+P1vam4neZKphqpECc76yKc0UIlVqjan7QXsQlAF5pcYdqcpEgm0f/8Egsk0GGO
         YuHFs4GQWWzdXuZvF+BqcDs0I3/v/6PHSQXM8lgSc+ytGSR5hOPPy3tcytNyhppmFEbJ
         1aIxtASjHbnUDRNDQJeyqU3BcaUhz7kK8MQ+oAIrbdNn4DF326UP3pp+aFjQFsut/4Vb
         OcRrpbnRuCcv1/qFlh9Y6inYKyShIfT0TTxnI+R2dhdROJe7+Y3acOJ7u+0ooLdcnWYP
         PQNo717Q8KrxomzsUO4J3ANXdjhliaTMFc4EhjNJA01EhrU4pV7ItloRfnTetBXnrcm1
         dA2A==
X-Gm-Message-State: AO0yUKWWfkRzJkaExdX0OOidpxS5DDzt425H5cHw+icDxEvHYvOHWRBl
        vLX0vQbsh6gwo6XxbaFTVgMLlg==
X-Google-Smtp-Source: AK7set8aZyn0JSAK6Uwu8+OgXRA/Act6Q0P5NIsUEaRYULPEJ7JmLBTK2/344+azofqGhqp4mTZYMQ==
X-Received: by 2002:a05:6a20:3d11:b0:cd:3f69:e15 with SMTP id y17-20020a056a203d1100b000cd3f690e15mr5787643pzi.11.1677632054021;
        Tue, 28 Feb 2023 16:54:14 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id c5-20020a6566c5000000b00503000f0492sm18606pgw.14.2023.02.28.16.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:54:13 -0800 (PST)
From:   Glenn Washburn <development@efficientek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Glenn Washburn <development@efficientek.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] scripts/gdb: Create linux/vfs.py for VFS related GDB helpers
Date:   Tue, 28 Feb 2023 18:53:34 -0600
Message-Id: <7bba4c065a8c2c47f1fc5b03a7278005b04db251.1677631565.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1677631565.git.development@efficientek.com>
References: <cover.1677631565.git.development@efficientek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow for more VFS specific GDB helpers to be collected in
one place. Move utils.dentry_name into the vfs modules. Also a local
variable in proc.py was changed from vfs to mnt to prevent a naming
collision with the new vfs module.

Signed-off-by: Glenn Washburn <development@efficientek.com>
---
 scripts/gdb/linux/proc.py  | 15 ++++++++-------
 scripts/gdb/linux/utils.py |  8 --------
 scripts/gdb/linux/vfs.py   | 22 ++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py |  1 +
 4 files changed, 31 insertions(+), 15 deletions(-)
 create mode 100644 scripts/gdb/linux/vfs.py

diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
index 09cd871925a5..f2c9ba62534b 100644
--- a/scripts/gdb/linux/proc.py
+++ b/scripts/gdb/linux/proc.py
@@ -16,6 +16,7 @@ from linux import constants
 from linux import utils
 from linux import tasks
 from linux import lists
+from linux import vfs
 from struct import *
 
 
@@ -170,16 +171,16 @@ values of that process namespace"""
         gdb.write("{:^18} {:^15} {:>9} {} {} options\n".format(
                   "mount", "super_block", "devname", "pathname", "fstype"))
 
-        for vfs in lists.list_for_each_entry(namespace['list'],
+        for mnt in lists.list_for_each_entry(namespace['list'],
                                              mount_ptr_type, "mnt_list"):
-            devname = vfs['mnt_devname'].string()
+            devname = mnt['mnt_devname'].string()
             devname = devname if devname else "none"
 
             pathname = ""
-            parent = vfs
+            parent = mnt
             while True:
                 mntpoint = parent['mnt_mountpoint']
-                pathname = utils.dentry_name(mntpoint) + pathname
+                pathname = vfs.dentry_name(mntpoint) + pathname
                 if (parent == parent['mnt_parent']):
                     break
                 parent = parent['mnt_parent']
@@ -187,14 +188,14 @@ values of that process namespace"""
             if (pathname == ""):
                 pathname = "/"
 
-            superblock = vfs['mnt']['mnt_sb']
+            superblock = mnt['mnt']['mnt_sb']
             fstype = superblock['s_type']['name'].string()
             s_flags = int(superblock['s_flags'])
-            m_flags = int(vfs['mnt']['mnt_flags'])
+            m_flags = int(mnt['mnt']['mnt_flags'])
             rd = "ro" if (s_flags & constants.LX_SB_RDONLY) else "rw"
 
             gdb.write("{} {} {} {} {} {}{}{} 0 0\n".format(
-                      vfs.format_string(), superblock.format_string(), devname,
+                      mnt.format_string(), superblock.format_string(), devname,
                       pathname, fstype, rd, info_opts(FS_INFO, s_flags),
                       info_opts(MNT_INFO, m_flags)))
 
diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
index 1553f68716cc..46233e845be3 100644
--- a/scripts/gdb/linux/utils.py
+++ b/scripts/gdb/linux/utils.py
@@ -193,11 +193,3 @@ def gdb_eval_or_none(expresssion):
         return gdb.parse_and_eval(expresssion)
     except gdb.error:
         return None
-
-
-def dentry_name(d):
-    parent = d['d_parent']
-    if parent == d or parent == 0:
-        return ""
-    p = dentry_name(d['d_parent']) + "/"
-    return p + d['d_iname'].string()
diff --git a/scripts/gdb/linux/vfs.py b/scripts/gdb/linux/vfs.py
new file mode 100644
index 000000000000..62d4f9ad7d79
--- /dev/null
+++ b/scripts/gdb/linux/vfs.py
@@ -0,0 +1,22 @@
+#
+# gdb helper commands and functions for Linux kernel debugging
+#
+#  VFS tools
+#
+# Copyright (c) 2023 Glenn Washburn
+# Copyright (c) 2016 Linaro Ltd
+#
+# Authors:
+#  Glenn Washburn <development@efficientek.com>
+#  Kieran Bingham <kieran.bingham@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL version 2.
+#
+
+
+def dentry_name(d):
+    parent = d['d_parent']
+    if parent == d or parent == 0:
+        return ""
+    p = dentry_name(d['d_parent']) + "/"
+    return p + d['d_iname'].string()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 3e8d3669f0ce..b5af64dcf4ed 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -37,3 +37,4 @@ else:
     import linux.clk
     import linux.genpd
     import linux.device
+    import linux.vfs
-- 
2.30.2

