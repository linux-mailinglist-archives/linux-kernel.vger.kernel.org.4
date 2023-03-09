Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C046B1AD0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 06:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCIFdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 00:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCIFdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 00:33:12 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC77564237
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 21:31:57 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VdS7uHS_1678339914;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdS7uHS_1678339914)
          by smtp.aliyun-inc.com;
          Thu, 09 Mar 2023 13:31:55 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: get rid of an useless DBG_BUGON
Date:   Thu,  9 Mar 2023 13:31:48 +0800
Message-Id: <20230309053148.9223-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230309053148.9223-1-hsiangkao@linux.alibaba.com>
References: <20230309053148.9223-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`err` could be -EINTR and it should not be the case.  Actually such
DBG_BUGON is useless.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 8bf6d30518b6..655da4d739cb 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -757,9 +757,6 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 	err = z_erofs_do_map_blocks(inode, map, flags);
 out:
 	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
-
-	/* aggressively BUG_ON iff CONFIG_EROFS_FS_DEBUG is on */
-	DBG_BUGON(err < 0 && err != -ENOMEM);
 	return err;
 }
 
-- 
2.24.4

