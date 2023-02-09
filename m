Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FFE68FFD2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBIFTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBIFSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:18:50 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92452D15C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 21:18:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbEaujl_1675919920;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbEaujl_1675919920)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 13:18:41 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        zhujia.zj@bytedance.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] erofs: relinquish volume with mutex held
Date:   Thu,  9 Feb 2023 13:18:37 +0800
Message-Id: <20230209051838.33297-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230209051838.33297-1-jefflexu@linux.alibaba.com>
References: <20230209051838.33297-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relinquish fscache volume with mutex held.  Otherwise if a new domain is
registered when the old domain with the same name gets removed from the
list but not relinquished yet, fscache may complain the collision.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 2f5930e177cc..a6f030966147 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -328,8 +328,8 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
 			kern_unmount(erofs_pseudo_mnt);
 			erofs_pseudo_mnt = NULL;
 		}
-		mutex_unlock(&erofs_domain_list_lock);
 		fscache_relinquish_volume(domain->volume, NULL, false);
+		mutex_unlock(&erofs_domain_list_lock);
 		kfree(domain->domain_id);
 		kfree(domain);
 		return;
-- 
2.19.1.6.gb485710b

