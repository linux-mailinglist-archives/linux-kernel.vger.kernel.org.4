Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B85669CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjAMPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAMPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:45:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F579585
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673624127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9kcFm4bZIrWxqb92kaZI81madTzRGEizfXuC8UiNAg=;
        b=TvduCiF3iNV562DnVH4+1FT1+GzwSFGcPvbuCshdIi1sKbgWxYxgX+5pNIbLgh52Z4jdrT
        7VTQkB0H1trpSYzozgK5ABkZzyPrkc0AgDLse5k/yEHx3HIie1yP4wfJVw5v3xwiyYmJq+
        xIS2LBeVhO9EiyMoviESdskKRe32YS4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-8GSV_tszMvSXmXjg5pv4QQ-1; Fri, 13 Jan 2023 10:35:23 -0500
X-MC-Unique: 8GSV_tszMvSXmXjg5pv4QQ-1
Received: by mail-lj1-f197.google.com with SMTP id r20-20020a2e8e34000000b002838fc9f1feso4718101ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9kcFm4bZIrWxqb92kaZI81madTzRGEizfXuC8UiNAg=;
        b=mj72GvNUEWJQod73CKHzhHJcP3KXMs9G3kfQvWjsfde4EYRFsjyyUUCK8c6TADkbrX
         pbbNXQsIu4Fz7A8gCkEHJIcfbpHeM/AxdvXkqy2NlQYDcdEJ+HUXmLZ2dlEjOY/4OkWt
         oxCOU0SiJLxCg0PkwWLKxDX11o/MdGmN4KLV78/RQBY9Jmxe6dhhH7gEwWu9GjF/wphQ
         n8XCmwGADYGrdAVlmI9GFGAeE3JbbiiWpnOk4wa3mjJ8G/u0xm5BFYbMlGyWvOgJrRtB
         rbb7qWbsa6whiogTBE1VlXxtO1HeYu8eqr905MOKUhr8oSJ+Og02hfkDcaC8LS0UHNqD
         cXnA==
X-Gm-Message-State: AFqh2kpvy/PRslPoZJxSNYHS7QUQs9/yvY+/VR93pAjumKa0SbH5ORAa
        kpfmHxp+dmq71dtgrJT2HATtntx1+mvX+ZUABQEJn+H4+ClNqLVSDmw6VTVZv61EaBeWW0Lg4df
        bV9WvrBvkMk/C9eIfa5ISld2X
X-Received: by 2002:a05:651c:2382:b0:27f:c869:79df with SMTP id bk2-20020a05651c238200b0027fc86979dfmr37437ljb.48.1673624122089;
        Fri, 13 Jan 2023 07:35:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvmjmybujP0N8n04T1ckkET6oZsbCUI2QaQPefp9fcGTi4MrxysQ5l3DSbnQ3hKb7R9yNAANA==
X-Received: by 2002:a05:651c:2382:b0:27f:c869:79df with SMTP id bk2-20020a05651c238200b0027fc86979dfmr37427ljb.48.1673624121911;
        Fri, 13 Jan 2023 07:35:21 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id p20-20020a2e9a94000000b00289bb528b8dsm725473lji.49.2023.01.13.07.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:35:21 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v2 6/6] composefs: Add kconfig and build support
Date:   Fri, 13 Jan 2023 16:33:59 +0100
Message-Id: <3cacd5065575e30f2120be6aa8587bc736aee774.1673623253.git.alexl@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673623253.git.alexl@redhat.com>
References: <cover.1673623253.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds Makefile and Kconfig for composefs, and
updates Makefile and Kconfig files in the fs directory

Signed-off-by: Alexander Larsson <alexl@redhat.com>
---
 fs/Kconfig            |  1 +
 fs/Makefile           |  1 +
 fs/composefs/Kconfig  | 18 ++++++++++++++++++
 fs/composefs/Makefile |  5 +++++
 4 files changed, 25 insertions(+)
 create mode 100644 fs/composefs/Kconfig
 create mode 100644 fs/composefs/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index 2685a4d0d353..de8493fc2b1e 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -127,6 +127,7 @@ source "fs/quota/Kconfig"
 source "fs/autofs/Kconfig"
 source "fs/fuse/Kconfig"
 source "fs/overlayfs/Kconfig"
+source "fs/composefs/Kconfig"
 
 menu "Caches"
 
diff --git a/fs/Makefile b/fs/Makefile
index 4dea17840761..d16974e02468 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -137,3 +137,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_COMPOSEFS_FS)	+= composefs/
diff --git a/fs/composefs/Kconfig b/fs/composefs/Kconfig
new file mode 100644
index 000000000000..88c5b55380e6
--- /dev/null
+++ b/fs/composefs/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config COMPOSEFS_FS
+	tristate "Composefs filesystem support"
+	select EXPORTFS
+	help
+	  Composefs is a filesystem that allows combining file content from
+	  existing regular files with a metadata directory structure from
+	  a separate binary file. This is useful to share file content between
+	  many different directory trees, such as in a local container image store.
+
+	  Composefs also allows using fs-verity to validate the content of the
+	  content-files as well as the metadata file which allows dm-verity
+	  like validation with the flexibility of regular files.
+
+	  For more information see Documentation/filesystems/composefs.rst
+
+	  If unsure, say N.
diff --git a/fs/composefs/Makefile b/fs/composefs/Makefile
new file mode 100644
index 000000000000..eac8445e7d25
--- /dev/null
+++ b/fs/composefs/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_COMPOSEFS_FS) += composefs.o
+
+composefs-objs += cfs-reader.o cfs.o
-- 
2.39.0

