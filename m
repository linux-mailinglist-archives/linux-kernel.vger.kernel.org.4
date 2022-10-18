Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7DD602712
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiJRIg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJRIgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:36:54 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F8952DDB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:36:53 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 29I8ZX7A019933-29I8ZX7D019933
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Oct 2022 16:35:54 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Dave Kleikamp <shaggy@kernel.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Zixuan Fu <r33s3n6@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: jfs: use the correct value to do sanity check
Date:   Tue, 18 Oct 2022 16:33:43 +0800
Message-Id: <20221018083346.855584-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous commit 920f4b7e923b ("fs: jfs: fix shift-out-of-bounds
in dbAllocAG") incorrectly uses MAXMAPSIZE - L2MAXAG as upper bound to
limit bmp->db_agl2size. The right value should be L2MAXL2SIZE - L2MAXAG,
i.e., 13 + 10*3 - 7 = 36, according to Dave Kleikamp.

Fix this by modifying the upper bound to the correct value.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 920f4b7e923b ("fs: jfs: fix shift-out-of-bounds in dbAllocAG")
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 fs/jfs/jfs_dmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 962c855631cb..e1cbfbb60303 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -193,7 +193,7 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
 	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
 	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
-	if (bmp->db_agl2size > MAXMAPSIZE - L2MAXAG) {
+	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
-- 
2.35.1

