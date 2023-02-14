Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519E469576A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjBNDZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBNDZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:25:57 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF2E15CA0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:25:56 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676345155;
        bh=p4L49mbChSxCQh+1gr3d/qeZBfH3UZf9pKaoK+b7mC0=;
        h=From:Date:Subject:To:Cc:From;
        b=mb/WwRgTL2QhEmlKMLH/u7+r0ezedOvfC4jlXmXwgmwcvhTdUBxkvwn8adUWVVK6T
         U+OtIjsfhQTKsQm2jACTdTQHMyDgsT8m7BG53uhs+gEzub71sepOtmaYk7QiqTz5ax
         EbSLc8MLxXuwzXe6Uy5LzuWJ+cpgDEyWJzgcXvQ0=
Date:   Tue, 14 Feb 2023 03:25:53 +0000
Subject: [PATCH] iommu: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230214-kobj_type-iommu-v1-1-e7392834b9d0@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAED/6mMC/x2NUQqDMBAFryL73UASldJepZSSmKduq4kktbSId
 +/i58xjeBsVZEaha7VRxocLpyhgThV1o4sDFAdhstrW2ppGvZJ/Pt6/RYY0z6u6AAFNHYw+tyS
 VdwXKZxe7Ubq4TpPIJaPn73Fzu+/7HxIrOax2AAAA
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676345153; l=991;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=p4L49mbChSxCQh+1gr3d/qeZBfH3UZf9pKaoK+b7mC0=;
 b=F2OI/YrWuEvRZ0lkOwWMT92t+p6WIJDy0d5wL95cCSpmLS0m3ZM+VI5h3SMG9TT7x5rOxfLhg
 TV3C6uBlrvQAtINdCaBQB5M/Ze90nUb4wHcrmAmSSpElFumXT545O8y
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
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5f6a85aea501..1dd4ec31301d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -714,7 +714,7 @@ static void iommu_group_release(struct kobject *kobj)
 	kfree(group);
 }
 
-static struct kobj_type iommu_group_ktype = {
+static const struct kobj_type iommu_group_ktype = {
 	.sysfs_ops = &iommu_group_sysfs_ops,
 	.release = iommu_group_release,
 };

---
base-commit: f6feea56f66d34259c4222fa02e8171c4f2673d1
change-id: 20230214-kobj_type-iommu-9eede43d1075

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

