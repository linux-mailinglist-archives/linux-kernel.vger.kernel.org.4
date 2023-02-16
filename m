Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D75D6989B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBPBLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBPBLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:11:18 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDE82941F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:11:17 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676509875;
        bh=m6ujeRpdfOK/ExLf0oC3JKdeaOfOHj5ANo4y+Xyc7GY=;
        h=From:Date:Subject:To:Cc:From;
        b=gSkPlaVUEK8XCxDKTPzpUqjl9Sj0DEdap9GrK1j86v07YTpvTLLdwcKxIujqhkWB+
         XgYRtg03IY4LSvnmAhX3Qaz4hjJpbsjxnynrgHkvSOBxHfJDU27yrdWGRUUJ5JRsRz
         Lnvj6RvH7X9KBpZJ6xcf5rigeR7QEen4I31aShSU=
Date:   Thu, 16 Feb 2023 01:10:59 +0000
Subject: [PATCH] xen: sysfs: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230216-kobj_type-xen-v1-1-742423de7d71@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKKC7WMC/x2NXQrCQAwGr1LybCBdf0CvIiK7208bLWnZVamU3
 t3g4wwMs1BFUVQ6NQsVfLTqaA7tpqHcR7uDtXOmIGEroT3wc0yP6+s7gWcYd0cJe5GcdgB5k2I
 FpxIt917ZexhcTgU3nf+T82VdfzDVeXV0AAAA
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676509873; l=995;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=m6ujeRpdfOK/ExLf0oC3JKdeaOfOHj5ANo4y+Xyc7GY=;
 b=BSGS1rU5dMp0UG5XucdetX/M4JSycNQ6bQiZOMnjBqP9UUfa2dOu+1rbACy/WpsfD/SxzWpCb
 DiLmvhDGWHKDZlz1T5Tt4NbRLtZoQNjF1h3XY5tKryMcADg00hd0MNh
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
 drivers/xen/sys-hypervisor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index fcb0792f090e..ef62acb354a7 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -594,7 +594,7 @@ static const struct sysfs_ops hyp_sysfs_ops = {
 	.store = hyp_sysfs_store,
 };
 
-static struct kobj_type hyp_sysfs_kobj_type = {
+static const struct kobj_type hyp_sysfs_kobj_type = {
 	.sysfs_ops = &hyp_sysfs_ops,
 };
 

---
base-commit: 033c40a89f55525139fd5b6342281b09b97d05bf
change-id: 20230216-kobj_type-xen-d902500cb4ee

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

