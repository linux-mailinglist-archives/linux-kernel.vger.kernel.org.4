Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BD069A439
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 04:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjBQDR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 22:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjBQDR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 22:17:56 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA77974B;
        Thu, 16 Feb 2023 19:17:53 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676603871;
        bh=ztr+IdxQRuyl8zlbtckleV8yYV26Hon5GkrvjeCXFEU=;
        h=From:Date:Subject:To:Cc:From;
        b=afOOM1iVH7yC0qYEmdHyCXYUxJOZ/wI+wgcqpyIqPgrzmzdDG+7z3/4Gk9xtcr3+F
         XAIEMo5LLctMy1WLrofmrzfjXWws9p22wof8whxfSrWbUnSE1QjzxeDmoCqEUk8XJB
         PDdXmHWGWu0z5dUFFDJ+Ds7LYvX+tswrchBg4SMI=
Date:   Fri, 17 Feb 2023 03:17:49 +0000
Subject: [PATCH] padata: Make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230217-kobj_type-padata-v1-1-e70b6cab4875@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANzx7mMC/x2N0QqDMAwAf0XybECzB4u/MoakbabZpJbWjQ3x3
 xf2eAfHHVClqFQYmwOKvLXqlgz6toGwcJoFNRoDdXTpqB/wufnHtH+zYObIOyM5JzFI4IEcWOa
 5CvrCKSwWpte6msxF7vr5f6638/wBMCwCNXcAAAA=
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676603869; l=1008;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ztr+IdxQRuyl8zlbtckleV8yYV26Hon5GkrvjeCXFEU=;
 b=XJNUk7Qrt62DXTVLIUYJKJzbykvAPZXCRfLiYSOkMlPlRs3CloLD4TRX2qiNyKKyN1fqwCYFX
 smwVNT1vvP9CX2qV7igv+fUPCmWOAwzOA74C5E8O1iU9MepET3AC2cY
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
 kernel/padata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index e007b8a4b738..106d08ee9ce2 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -967,7 +967,7 @@ static const struct sysfs_ops padata_sysfs_ops = {
 	.store = padata_sysfs_store,
 };
 
-static struct kobj_type padata_attr_type = {
+static const struct kobj_type padata_attr_type = {
 	.sysfs_ops = &padata_sysfs_ops,
 	.default_groups = padata_default_groups,
 	.release = padata_sysfs_release,

---
base-commit: 3ac88fa4605ec98e545fb3ad0154f575fda2de5f
change-id: 20230217-kobj_type-padata-288edceca728

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

