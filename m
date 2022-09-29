Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEDD5EF4FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiI2MKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiI2MKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:10:47 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6AC2CC8B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:10:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d42so1978690lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NsrrWIjf2uyMMXyxY7icXqYe+9FJkb9IHxNntDwreP4=;
        b=XWdx3nnbholxUaQlNpAYPNQWHmifAfs11gtmtx33+5wKkyrm5AFhGQPzcVhYtrfLkk
         EtoWaTJPd+B6YtUixt/Q78iUkiDl5oJHYnFSh11hOBjVgjOv4sD3ufr/KzHpetgSMD51
         MZpuEgMTMS9T+WuemoX3uw39+wcbsZjt+Ed1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NsrrWIjf2uyMMXyxY7icXqYe+9FJkb9IHxNntDwreP4=;
        b=UR9AcIE1UdaWA+pkJjp5hjVXmM0pS1UQsYEho9SO/iKZStmq0FjQHzgpDBzJytIbuV
         lBXMx24X7Sqlhfh3H1BsDxFxL/b6pDDtOsZLQOr829K2SbKqwZOmas4QAfoCY/HC82dN
         CzmjhZXjjNcemaiiSrFLQD7H/XcNiF6Oe8/R077ErnpOJwpDA2WppPNFm7g59Hv41f6m
         Xu/dBy8e8vDpExe/j96DI4NeR+Bozw+L/MsSpzceQnez4A4xfjj+x2r3e4n0UBsyJAPy
         CNhESC+Q6dKlhFspcOsDxE97PqJmF8VQN89Co7hEpMzIJirMER4ak5kRZ+GDLOR9lIcS
         b70Q==
X-Gm-Message-State: ACrzQf1U/tBNpfqMbuC1sgN+xymYpwy9dpy2PH91H/r5Dwe8nev5RddU
        Fpu5ZEOC5DhSEIYOOkDJt3hTXw==
X-Google-Smtp-Source: AMsMyM5utwA6mqx1GWSzGWmcGTdL8ObnQwkFKgX/HF/+wvlKA00E1HQEYJw3V/fRLHpwjk9qxiEq9A==
X-Received: by 2002:ac2:4f03:0:b0:495:ec98:bcac with SMTP id k3-20020ac24f03000000b00495ec98bcacmr1220332lfr.339.1664453443617;
        Thu, 29 Sep 2022 05:10:43 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b00497a61453a9sm767713lfr.243.2022.09.29.05.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 05:10:42 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] module: remove redundant module_sysfs_initialized variable
Date:   Thu, 29 Sep 2022 14:10:39 +0200
Message-Id: <20220929121039.702873-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable module_sysfs_initialized is used for checking whether
module_kset has been initialized. Checking module_kset itself works
just fine for that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/module.h | 1 -
 kernel/module/sysfs.c  | 2 +-
 kernel/params.c        | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 518296ea7f73..727176de2890 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -827,7 +827,6 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
 extern struct kobj_type module_ktype;
-extern int module_sysfs_initialized;
 #endif /* CONFIG_SYSFS */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index ce68f821dcd1..c921bf044050 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -340,7 +340,7 @@ static int mod_sysfs_init(struct module *mod)
 	int err;
 	struct kobject *kobj;
 
-	if (!module_sysfs_initialized) {
+	if (!module_kset) {
 		pr_err("%s: module sysfs not initialized\n", mod->name);
 		err = -EINVAL;
 		goto out;
diff --git a/kernel/params.c b/kernel/params.c
index 5b92310425c5..8d4e9a3f0df2 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -940,7 +940,6 @@ static const struct kset_uevent_ops module_uevent_ops = {
 };
 
 struct kset *module_kset;
-int module_sysfs_initialized;
 
 static void module_kobj_release(struct kobject *kobj)
 {
@@ -964,7 +963,6 @@ static int __init param_sysfs_init(void)
 			__FILE__, __LINE__);
 		return -ENOMEM;
 	}
-	module_sysfs_initialized = 1;
 
 	version_sysfs_builtin();
 	param_sysfs_builtin();
-- 
2.37.2

