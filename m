Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73C86C5E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCWFM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCWFMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:12:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92292B297;
        Wed, 22 Mar 2023 22:12:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ek18so81722944edb.6;
        Wed, 22 Mar 2023 22:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679548365;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whrG+gguDX8nlGRgJxXbZkIVF0D/vQIQyMAFq+Y5T48=;
        b=BpLs1mlubkF+Y3+eFz9RDbRTudzOajXsuy0qcoKqU6L82B8CEv6+C6tbF7VUw8VYTY
         Zn/r4dk0/D2dCl17NhSkSdcxXRONuIxG571RuOCqeOy5x8o9Dk+XWCKQ9S+zWSMVYHY3
         r1z7+SaZ+4RBeCxzbI0cpvIcDh60UoSEYdQewkFMZIVPc+qb0f3vnh/qz0/QXEDVEvQq
         PK0yhonnzsurHPgdKIFwF6se9XDS3QZjAELGA8+WM44ejk0NIDYXd/rbecyogL8kPy9k
         6vnsDQeKu5genjszP4FTHEkaN4tr7/saY12TD56468yRW/6EognoDDQQ2IOlXqVP7S/C
         X2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679548365;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whrG+gguDX8nlGRgJxXbZkIVF0D/vQIQyMAFq+Y5T48=;
        b=bpZ/bd78hY2GKqdD/wm8pKoKrvirpJA3LEXIOW2qrXx2NeFrC573gtEmFDvpLgiJkp
         scKBRxgZszyMhuDLiR1QJfeVbfPL77t0oTbIRNfjhNz7Vb8FKi6qT5qbZWUPDuC2ndLd
         il+D83EgrIyXFMD4EgkACYgEOyLeS8lXK9JHhVIQwt1gnNT3sm03zPCOu1OkwDX28WR2
         FWQUyiSRf9YwD9sBpZZdQC1e0M6u8s9knIwTvBvUZKOOxDJr/DsbNmU5BSek5uEFbkeI
         a7bRUYsQGOqdZTdAqWGwLc7gDTMUVBcnMGX3ixXihE079nNjlBKSzunwYKYSJTw4+Cau
         KYsQ==
X-Gm-Message-State: AO0yUKWgU1LuB4bWmQPkksIKuJvKLA8OsjF3Q1ZV45ZiJU3ym1xDOmVw
        dBWM5lRDgo6xpWFF+tbRlpc=
X-Google-Smtp-Source: AK7set8TGkvIr/ztWdhN99zc0Edsj6Aji2tAbnZ8CQjGqKiOpOy3zhFrG+v68BtyC+D7AEpOFH403w==
X-Received: by 2002:a17:906:ce32:b0:939:7260:7f7e with SMTP id sd18-20020a170906ce3200b0093972607f7emr9718319ejb.49.1679548364907;
        Wed, 22 Mar 2023 22:12:44 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:d509:cbf0:f579:76f0])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906118f00b0092421bf4927sm8250052eja.95.2023.03.22.22.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:12:43 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] selinux: clean up dead code after removing runtime disable
Date:   Thu, 23 Mar 2023 06:12:41 +0100
Message-Id: <20230323051241.24841-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f22f9aaf6c3d ("selinux: remove the runtime disable functionality")
removes the config SECURITY_SELINUX_DISABLE. This results in some dead code
in lsm_hooks.h and a reference in the ABI documentation leading nowhere as
the help text is simply gone.

Remove the dead code and dead reference.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Paul, please pick this minor cleanup patch on top of your commit above.

 .../ABI/removed/sysfs-selinux-disable         |  3 ---
 include/linux/lsm_hooks.h                     | 23 -------------------
 2 files changed, 26 deletions(-)

diff --git a/Documentation/ABI/removed/sysfs-selinux-disable b/Documentation/ABI/removed/sysfs-selinux-disable
index cb783c64cab3..1ae9587231e1 100644
--- a/Documentation/ABI/removed/sysfs-selinux-disable
+++ b/Documentation/ABI/removed/sysfs-selinux-disable
@@ -24,6 +24,3 @@ Description:
 	SELinux at runtime.  Fedora is in the process of removing the
 	selinuxfs "disable" node and once that is complete we will start the
 	slow process of removing this code from the kernel.
-
-	More information on /sys/fs/selinux/disable can be found under the
-	CONFIG_SECURITY_SELINUX_DISABLE Kconfig option.
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 2b04f94a31bd..ab2b2fafa4a4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -117,29 +117,6 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 		__used __section(".early_lsm_info.init")		\
 		__aligned(sizeof(unsigned long))
 
-#ifdef CONFIG_SECURITY_SELINUX_DISABLE
-/*
- * Assuring the safety of deleting a security module is up to
- * the security module involved. This may entail ordering the
- * module's hook list in a particular way, refusing to disable
- * the module once a policy is loaded or any number of other
- * actions better imagined than described.
- *
- * The name of the configuration option reflects the only module
- * that currently uses the mechanism. Any developer who thinks
- * disabling their module is a good idea needs to be at least as
- * careful as the SELinux team.
- */
-static inline void security_delete_hooks(struct security_hook_list *hooks,
-						int count)
-{
-	int i;
-
-	for (i = 0; i < count; i++)
-		hlist_del_rcu(&hooks[i].list);
-}
-#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
-
 extern int lsm_inode_alloc(struct inode *inode);
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
-- 
2.17.1

