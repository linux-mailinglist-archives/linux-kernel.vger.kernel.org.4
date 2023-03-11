Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63C6B5804
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 04:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCKDPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 22:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKDPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 22:15:02 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A33A132A94
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 19:15:00 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678504498;
        bh=pCEog6vxwSuKmvKLhc80450ur1XxkLoLlCfazqFt1F0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hBhcLJv3vkpuVK0jz9kWGargi8oM/bWAOYD6b4P03pAkENPLv8TeRN2rJbLaUmet5
         IveFF1TAXhGbIly7PajneFQT5Jdc+hGo47BFvsWy2bx6AlZfQQR4AMzWdbwgFXJHcf
         pnJS6C4tsZgfrqkZMEdRpXeacTh+b6IIf7boqCzg=
Date:   Sat, 11 Mar 2023 03:14:47 +0000
Subject: [PATCH 2/4] kobject: align stacktrace levels to logging message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230311-kobject-warning-v1-2-1ebba4f71fb5@weissschuh.net>
References: <20230311-kobject-warning-v1-0-1ebba4f71fb5@weissschuh.net>
In-Reply-To: <20230311-kobject-warning-v1-0-1ebba4f71fb5@weissschuh.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678504493; l=1551;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=pCEog6vxwSuKmvKLhc80450ur1XxkLoLlCfazqFt1F0=;
 b=4MfIfOAfHwH+ONwUjubatS0nY+UNzyAioLh2YI5evEhAVmI2SI6nfiNqost8qs2AkmLHZ+MnA
 Qy30P6yFsQJB/MX3UbN6LRaFSgyzDqODqAOxjyJmumiLFKIOgiyhq3G
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without an explicit level the stacktraces are printed at a default
level.
If this level does not match the one from the logging level it may
happen that the stacktrace is shown without the message or vice versa.

Both these cases are confusing, so make sure the user always sees both,
the message and the stacktrace.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 lib/kobject.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 09c81ffb8b33..f79a434e1231 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -340,7 +340,7 @@ void kobject_init(struct kobject *kobj, const struct kobj_type *ktype)
 		/* do not error out as sometimes we can recover */
 		pr_err("kobject (%p): tried to init an initialized object, something is seriously wrong.\n",
 		       kobj);
-		dump_stack();
+		dump_stack_lvl(KERN_ERR);
 	}
 
 	kobject_init_internal(kobj);
@@ -349,7 +349,7 @@ void kobject_init(struct kobject *kobj, const struct kobj_type *ktype)
 
 error:
 	pr_err("kobject (%p): %s\n", kobj, err_str);
-	dump_stack();
+	dump_stack_lvl(KERN_ERR);
 }
 EXPORT_SYMBOL(kobject_init);
 
@@ -413,7 +413,7 @@ int kobject_add(struct kobject *kobj, struct kobject *parent,
 	if (!kobj->state_initialized) {
 		pr_err("kobject '%s' (%p): tried to add an uninitialized object, something is seriously wrong.\n",
 		       kobject_name(kobj), kobj);
-		dump_stack();
+		dump_stack_lvl(KERN_ERR);
 		return -EINVAL;
 	}
 	va_start(args, fmt);

-- 
2.39.2

