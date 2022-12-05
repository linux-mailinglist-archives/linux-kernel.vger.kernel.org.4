Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDBE642AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiLEPBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiLEPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:01:03 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0A11D0FD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:01:01 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=0;PH=DS;RN=5;SR=0;TI=SMTPD_---0VWWWV0Z_1670252457;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VWWWV0Z_1670252457)
          by smtp.aliyun-inc.com;
          Mon, 05 Dec 2022 23:00:58 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        syzbot+2ae90e873e97f1faf6f2@syzkaller.appspotmail.com
Subject: [PATCH 2/2] erofs: validate the extent length for uncompressed pclusters
Date:   Mon,  5 Dec 2022 23:00:50 +0800
Message-Id: <20221205150050.47784-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
References: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
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

syzkaller reported a KASAN use-after-free:
https://syzkaller.appspot.com/bug?extid=2ae90e873e97f1faf6f2

The referenced fuzzed image actually has two issues:
 - m_pa == 0 as a non-inlined pcluster;
 - The logical length is longer than its physical length.

The first issue has already been addressed.  This patch addresses
the second issue by checking the extent length validity.

Reported-by: syzbot+2ae90e873e97f1faf6f2@syzkaller.appspotmail.com
Fixes: 02827e1796b3 ("staging: erofs: add erofs_map_blocks_iter")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 98eff1259de4..0150570c33aa 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -698,6 +698,11 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	}
 
 	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN) {
+		if (map->m_llen > map->m_plen) {
+			DBG_BUGON(1);
+			err = -EFSCORRUPTED;
+			goto unmap_out;
+		}
 		if (vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
 			map->m_algorithmformat =
 				Z_EROFS_COMPRESSION_INTERLACED;
-- 
2.24.4

