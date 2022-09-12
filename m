Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB495B53BA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiILF76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILF7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:59:54 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66013E04
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:59:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VPOQ3u0_1662962379;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0VPOQ3u0_1662962379)
          by smtp.aliyun-inc.com;
          Mon, 12 Sep 2022 13:59:45 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     luoben@linux.alibaba.com
Subject: [PATCH] mm/slub: return 0 when object pointer is NULL
Date:   Mon, 12 Sep 2022 13:59:39 +0800
Message-Id: <1662962379-16174-1-git-send-email-luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL is definitly not a valid address

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9..50fad18 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -674,7 +674,7 @@ static inline int check_valid_pointer(struct kmem_cache *s,
 	void *base;
 
 	if (!object)
-		return 1;
+		return 0;
 
 	base = slab_address(slab);
 	object = kasan_reset_tag(object);
-- 
1.8.3.1

