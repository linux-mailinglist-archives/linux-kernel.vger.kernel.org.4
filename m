Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7236D9049
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbjDFHNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjDFHNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:13:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D019E2D6A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:13:43 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PsXh76ks4z17R7c;
        Thu,  6 Apr 2023 15:10:15 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Apr
 2023 15:13:41 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 2/2] ubi: Correct the number of PEBs after a volume resize failure
Date:   Thu, 6 Apr 2023 15:13:31 +0800
Message-ID: <20230406071331.1247429-3-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230406071331.1247429-1-wangzhaolong1@huawei.com>
References: <20230406071331.1247429-1-wangzhaolong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error handing path `out_acc` of the ubi_resize_volume(),
when `pebs < 0`, it means that the volume table record fails to be
updated when the volume is shrinked. In this case, the number of
ubi->avail_pebs` and `ubi->rsvd_pebs` should also be restored,
otherwise the UBI will display an incorrect number of available PEBs.

Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 drivers/mtd/ubi/vmt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 97294def01eb..990571287e84 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -515,13 +515,12 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
 out_acc:
 	spin_lock(&ubi->volumes_lock);
 	vol->reserved_pebs = reserved_pebs - pebs;
-	if (pebs > 0) {
-		ubi->rsvd_pebs -= pebs;
-		ubi->avail_pebs += pebs;
+	ubi->rsvd_pebs -= pebs;
+	ubi->avail_pebs += pebs;
+	if (pebs > 0)
 		ubi_eba_copy_table(vol, old_eba_tbl, vol->reserved_pebs);
-	} else {
+	else
 		ubi_eba_copy_table(vol, old_eba_tbl, reserved_pebs);
-	}
 	vol->eba_tbl = old_eba_tbl;
 	spin_unlock(&ubi->volumes_lock);
 out_free:
-- 
2.31.1

