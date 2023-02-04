Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD8468A86E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 06:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjBDFo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 00:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBDFoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 00:44:55 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2E44C3C;
        Fri,  3 Feb 2023 21:44:54 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675489492;
        bh=SiXM2SIdBSyvF41SkHm3D6NR8zccdHjK8Z5oPzVBzxE=;
        h=From:Date:Subject:To:Cc:From;
        b=NwkpIu4E3sV0+nl1zKUyqQfERzbylBVZExz4YXV0f0kJ/pC9wrq19fVysLPTrs6tA
         EUMqtDK04zJAh5RiKx2ThPyBWWuw1Bxc4KrOhik6EIQPQeINubFvS6YE62WdfiMP0e
         Zlns1GwhWPlNIwqyVXACS4hn77EYNNNaZEWG59NQ=
Date:   Sat, 04 Feb 2023 05:44:46 +0000
Subject: [PATCH] module: make module_ktype structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230204-kobj_type-module-v1-1-40df5b474e9d@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAM3w3WMC/x2NUQrCMBAFr1L224U0bUG8iogkzatdjUlJrCild
 3fxcwaG2aiiCCqdmo0K3lIlJ4X20NA4u3QDS1Ama2xnrOn5kf39+vou4GcOawQfQztMHug7N5B
 m3lWwLy6Ns4ZpjVHlUjDJ5/85X/b9ByPhBG13AAAA
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675489488; l=1512;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SiXM2SIdBSyvF41SkHm3D6NR8zccdHjK8Z5oPzVBzxE=;
 b=/VzpNIf+H0J6KcAabj+0srq7DptYyTEjRwXEss69cgHmpGADzfsDz5IBsbbRkr99EJkSb8npa
 XqEoigLbblSBmtUxpaqB45XYsXDwqYHM3sYDs9RU2ZUeNZ/pyxxefo9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/module.h | 2 +-
 kernel/params.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 8c5909c0076c..701869049be2 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -826,7 +826,7 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
 
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
-extern struct kobj_type module_ktype;
+extern const struct kobj_type module_ktype;
 #endif /* CONFIG_SYSFS */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
diff --git a/kernel/params.c b/kernel/params.c
index 14d66070757b..049d7078fb21 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -947,7 +947,7 @@ static void module_kobj_release(struct kobject *kobj)
 	complete(mk->kobj_completion);
 }
 
-struct kobj_type module_ktype = {
+const struct kobj_type module_ktype = {
 	.release   =	module_kobj_release,
 	.sysfs_ops =	&module_sysfs_ops,
 };

---
base-commit: 0136d86b78522bbd5755f8194c97a987f0586ba5
change-id: 20230204-kobj_type-module-8d15fbee43a5

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

