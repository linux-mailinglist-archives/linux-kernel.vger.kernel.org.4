Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F375F45E8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJDOun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJDOul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:50:41 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AA6061B1A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FiGiW
        uqNMxRYmMEJen9U4DdoTiKrvBlJbml9qjjwVXc=; b=leFOk6Ki2fQv6j7ISe0yI
        RzwUAPTjLxp6gYyKMfLcIWHVQiQGCN+3AhbtoyKJjr5acde9vRPTKNEpdJ91Ta+6
        Kz5maqXSM1cfcivBUqIKn780FA8hXGOwtqbEFKjVLC+A1X9Lp23Hyt5J6DvGSWBB
        /4q7GR4b44cI8YzFhUUVO4=
Received: from localhost.localdomain (unknown [112.22.168.89])
        by smtp12 (Coremail) with SMTP id EMCowACno3UQSDxjXwxPBw--.264S2;
        Tue, 04 Oct 2022 22:49:58 +0800 (CST)
From:   Yue Hu <zbestahu@163.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
Subject: [PATCH] erofs: fix the unmapped access in z_erofs_fill_inode_lazy()
Date:   Tue,  4 Oct 2022 22:49:51 +0800
Message-Id: <20221004144951.31075-1-zbestahu@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowACno3UQSDxjXwxPBw--.264S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyfGFyxZF4rtw4rtw4rGrg_yoW8tw47pF
        42krWSyryrJrn7ZrWI9F18Xry3Kay8Jw4DGw13G34rZ3Z0g3ZagFy8tF9xJF45GrWrZr4F
        qF1jva4rurWxG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3OzsUUUUU=
X-Originating-IP: [112.22.168.89]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/xtbBoRaQEWI0VBeiqAAAsp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

Note that we are still accessing 'h_idata_size' and 'h_fragmentoff'
after calling erofs_put_metabuf(), that is not correct. Fix it.

Fixes: ab92184ff8f1 ("add on-disk compressed tail-packing inline support")
Fixes: b15b2e307c3a ("support on-disk compressed fragments data")
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zmap.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 44c27ef39c43..1a15bbf18ba3 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -58,7 +58,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
 		    vi->xattr_isize, 8);
 	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
-				   EROFS_KMAP_ATOMIC);
+				   EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		err = PTR_ERR(kaddr);
 		goto out_unlock;
@@ -73,7 +73,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 		vi->z_fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
 		vi->z_tailextent_headlcn = 0;
-		goto unmap_done;
+		goto init_done;
 	}
 	vi->z_advise = le16_to_cpu(h->h_advise);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
@@ -105,10 +105,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		err = -EFSCORRUPTED;
 		goto unmap_done;
 	}
-unmap_done:
-	erofs_put_metabuf(&buf);
-	if (err)
-		goto out_unlock;
 
 	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
 		struct erofs_map_blocks map = {
@@ -127,7 +123,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 			err = -EFSCORRUPTED;
 		}
 		if (err < 0)
-			goto out_unlock;
+			goto unmap_done;
 	}
 
 	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
@@ -141,11 +137,14 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
 		if (err < 0)
-			goto out_unlock;
+			goto unmap_done;
 	}
+init_done:
 	/* paired with smp_mb() at the beginning of the function */
 	smp_mb();
 	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
+unmap_done:
+	erofs_put_metabuf(&buf);
 out_unlock:
 	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
 	return err;
-- 
2.25.1

