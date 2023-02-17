Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE36469A435
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 04:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBQDQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 22:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBQDQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 22:16:33 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EE1595AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 19:16:33 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676603791;
        bh=xtWe/z592GjmZvp4dfN6WhDniwxGWNDEk/AoL1eYtHs=;
        h=From:Date:Subject:To:Cc:From;
        b=MHiTYxTu3MP2S6driL0IZBIBiF3snIJLZsvrofUaGLWmj5720jsVnaje/BMnsTb02
         c0S1+fK/EUnM73Zf5khBBQWPTiwITaDUbPeDkTslgJgdx2hDtFa8pCBteI0ACpYddp
         MsE337EpOsH0vzu0Tp5GKdGpS2cchuDKZD9Gj7Rg=
Date:   Fri, 17 Feb 2023 03:16:25 +0000
Subject: [PATCH] irq: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230217-kobj_type-irq-v1-1-fedfacaf8cdb@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAInx7mMC/x2NUQrCMBAFr1L220CTiBWvIiJJfNptS9puVFpK7
 +7i58xjeBsVCKPQpdpI8OXCY1awh4pSG/ILhh/K5Grna2cb04+xu7/XSQeZDcK5QfLHeIIlbWI
 oMFFCTq1W+TMMKifBk5f/yfW27z9JD865dAAAAA==
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676603789; l=1219;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xtWe/z592GjmZvp4dfN6WhDniwxGWNDEk/AoL1eYtHs=;
 b=WZ5C3oh/EKt8NQXTUuEWEU/DJMwhHgaSQgdADdNR7aXr4/lDg0ZXVLUquyfe1toeo9Nz7Z0ad
 SNnoI5D4fJLCV3pP0c7jVtdGRgHVppGfFFeUzNq0a87IwEpO/3CnhHj
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

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/irq/irqdesc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index fd0996274401..240e145e969f 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -277,7 +277,7 @@ static struct attribute *irq_attrs[] = {
 };
 ATTRIBUTE_GROUPS(irq);
 
-static struct kobj_type irq_kobj_type = {
+static const struct kobj_type irq_kobj_type = {
 	.release	= irq_kobj_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = irq_groups,
@@ -335,7 +335,7 @@ postcore_initcall(irq_sysfs_init);
 
 #else /* !CONFIG_SYSFS */
 
-static struct kobj_type irq_kobj_type = {
+static const struct kobj_type irq_kobj_type = {
 	.release	= irq_kobj_release,
 };
 

---
base-commit: 3ac88fa4605ec98e545fb3ad0154f575fda2de5f
change-id: 20230217-kobj_type-irq-ea87ec34b6e1

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

