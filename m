Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD896B5803
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 04:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCKDPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 22:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCKDPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 22:15:00 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C180133D85
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 19:14:59 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678504497;
        bh=bcH+RH7mDEjMHFrUjTVALbIb4nQlqXgmdbui5y0vy1A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kZlB8FGBEQR31hU+wKRBi9KYXlBrcyD6oV6v1XjOWQ9rq66wgHNpRLUYSOmNhz7Br
         l6Yp+IzrR3+0bACs+iePMSyg0ht3HPlIsconcH/LC/yUOylCtvqQX8jFC0GqBmPhYm
         sNVQQlQVNd+oYDwJp7sNEmFVCU47JwnhOhAuop3s=
Date:   Sat, 11 Mar 2023 03:14:48 +0000
Subject: [PATCH 3/4] kobject: validate ktype release function during add
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230311-kobject-warning-v1-3-1ebba4f71fb5@weissschuh.net>
References: <20230311-kobject-warning-v1-0-1ebba4f71fb5@weissschuh.net>
In-Reply-To: <20230311-kobject-warning-v1-0-1ebba4f71fb5@weissschuh.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678504493; l=1594;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=bcH+RH7mDEjMHFrUjTVALbIb4nQlqXgmdbui5y0vy1A=;
 b=50p1tv7SGpwBneKoN/Ga7uCuCMRtktJIjevrXw7BKAo/GJRDKjp4L4KPNaEMK1kGTq5H/XvCN
 2HYvnPom76ECJekV40mWOmNExjS+TiGlSVG6Z6k1CBiIVMWP+H+Xi6G
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

Validating the ktype during cleanup is suboptimal.
Many kobjects are only destroyed during shutdown which makes it hard to
observe the messages.

Instead perform the validation when the object is added.

Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Link: https://lore.kernel.org/lkml/60b2b66c-22c9-1d38-ed1c-7b7d95e32720@alu.unizg.hr/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 lib/kobject.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index f79a434e1231..68ff8a48b784 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -215,6 +215,10 @@ static int kobject_add_internal(struct kobject *kobj)
 		return -EINVAL;
 	}
 
+	if (kobj->ktype && !kobj->ktype->release)
+		pr_debug("'%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
+			 kobject_name(kobj), kobj);
+
 	parent = kobject_get(kobj->parent);
 
 	/* join kset if set, use it as parent if we do not already have one */
@@ -663,10 +667,6 @@ static void kobject_cleanup(struct kobject *kobj)
 	pr_debug("'%s' (%p): %s, parent %p\n",
 		 kobject_name(kobj), kobj, __func__, kobj->parent);
 
-	if (t && !t->release)
-		pr_debug("'%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
-			 kobject_name(kobj), kobj);
-
 	/* remove from sysfs if the caller did not do it */
 	if (kobj->state_in_sysfs) {
 		pr_debug("'%s' (%p): auto cleanup kobject_del\n",

-- 
2.39.2

