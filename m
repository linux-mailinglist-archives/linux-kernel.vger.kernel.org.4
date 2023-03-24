Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EDF6C7B36
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjCXJXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjCXJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:23:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E77E3AB;
        Fri, 24 Mar 2023 02:23:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eh3so5139865edb.11;
        Fri, 24 Mar 2023 02:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679649799;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBqIhqgnT5Tx44NknDnNp6UNXSDtAsauUjSMoRmswK8=;
        b=W59iSxYIe8739Z+MVxjPiOJyMysvhM6mCxLCZEZPgS5tLy2mHQ4ENMuEXdYmvme4HM
         t0zcEp8R+7jIeqdj+MIQogX/H+ca9+O3Hmh5PHZz++0BgnE4Sy3L9hWCoA1Mt3kmWWPx
         nfcBfIwz+QIIx2jqSoTxWd9hxQtoCYN1J8CIL/gmDRPk6iy+BU4AJXsTodnBkVsQYjPF
         DvAUePueMiHtiyP6yGqpornczGHMVsfmnZPhYEXrTRfCL33+GbMfx+kOywLBek5CEOl1
         yrZj7pvnU8WAAcPLysNxb/+qA58n7Cwoed1ICpTCwOoYOKnm6jwPJscdK3YbDnxFQ8ib
         laLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679649799;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBqIhqgnT5Tx44NknDnNp6UNXSDtAsauUjSMoRmswK8=;
        b=QxZ58+pnwdvXVjVrNuYNyF/1683FROAXLGWZNd2JpgadA/esAFyNHcomIo8WhLsYJF
         bGbVwzYBXao4+jKP71Xr1LHGec0mZJ2nMD0zbZFz0R9y5JFbFk4M4y8zV18sAmmIl0a/
         I8YuvGo4wjE08hPRdZLlk3yPPCbwr87MrdgIsLBT8pLUvW43U3voG+DwuwgqVMybiBHj
         vQjcp9RgJBq45lRkAAmOLb3jPUjKQI+b0pN3AHaI4ZwGZKAfmuw8o1BH2wfr5YvLCmjR
         tmz148AkEd8PZTbrzWYVt4j5v4KVOgxdLjHC59v4v8wvvoBVRPsC/ZGUDlg2XgsPXUa3
         rcrw==
X-Gm-Message-State: AAQBX9cJA/kmv2yf5vW/KicoWZBbtJ/JkBNc3qJNi5M3AFG4ghIv500u
        ArSR2LMD0FZ+o1yOqCer3yvbiUUL7/dEcw==
X-Google-Smtp-Source: AKy350bBiN60fBswq8Aaxq4PFkLiuZpubGTDMBCSbbUCkQIG8ZYVMOR/wnXl3nfX7edIwMVmTxIxzA==
X-Received: by 2002:a17:906:ad98:b0:930:6d59:d1f8 with SMTP id la24-20020a170906ad9800b009306d59d1f8mr1874861ejb.10.1679649798777;
        Fri, 24 Mar 2023 02:23:18 -0700 (PDT)
Received: from felia.fritz.box (ipbcc1d920.dynamic.kabel-deutschland.de. [188.193.217.32])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906114d00b008e0bb004976sm9948654eja.134.2023.03.24.02.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 02:23:18 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] selinux: clean up dead code after removing runtime disable
Date:   Fri, 24 Mar 2023 10:21:14 +0100
Message-Id: <20230324092114.13907-1-lukas.bulwahn@gmail.com>
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
in lsm_hooks.h.

Remove this dead code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 include/linux/lsm_hooks.h | 23 -----------------------
 1 file changed, 23 deletions(-)

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

