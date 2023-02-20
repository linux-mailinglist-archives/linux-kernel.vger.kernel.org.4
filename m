Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8169D6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjBTXXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBTXXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:23:39 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678A6A52
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 15:23:37 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676935415;
        bh=JOsefuzEssw8NpzH0pMwXy0Xm7yZ/VEe5keeQF4Xa9c=;
        h=From:Date:Subject:To:Cc:From;
        b=kaZKQoAqtVhRXU9q986twd4dAaRy4Fmn5amijgSkdfZUlw/ZCs3OQDALVBSx0gcoP
         2ZBXbsCgHc0NeGfxfsSzxtMYi2bTGo6UuWc3NsMd98y7I3SJR+C7gu8itlq4GxvJQh
         OYImhPxLrkemWJH07VS1x8PDqotcBiFkLezWx/28=
Date:   Mon, 20 Feb 2023 23:23:31 +0000
Subject: [PATCH] mm: cma: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230220-kobj_type-mm-cma-v1-1-45996cff1a81@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAPIA9GMC/x2N0QqDMAwAf0XyvEDNUHC/MsZIazbjbJV2Gxviv
 xt8vIPjViiSVQpcqhWyfLXonAzqUwVh4PQU1N4YyNHZETl8zX68v/+LYIwYImPbSM2OmrbrPVj
 muQj6zCkMFqbPNJlcsjz0d3yut23bAbPZOTN3AAAA
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676935412; l=953;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JOsefuzEssw8NpzH0pMwXy0Xm7yZ/VEe5keeQF4Xa9c=;
 b=COSTO2v7/hO9rUQuDn6+JOFIyoUBHYRroOSbPIeh0L0VxeAOlz6bRAThMhUyKsQvTLsNs4c7a
 P/J9fVgHuNuA3FBGfWq7UN8YnaWjWI5VnIAEVXQzUZTJQDQuX6+LHhm
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
 mm/cma_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
index eb2f39caff59..56347d15b7e8 100644
--- a/mm/cma_sysfs.c
+++ b/mm/cma_sysfs.c
@@ -64,7 +64,7 @@ static struct attribute *cma_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cma);
 
-static struct kobj_type cma_ktype = {
+static const struct kobj_type cma_ktype = {
 	.release = cma_kobj_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = cma_groups,

---
base-commit: 5b0ed5964928b0aaf0d644c17c886c7f5ea4bb3f
change-id: 20230220-kobj_type-mm-cma-65e1a02569db

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

