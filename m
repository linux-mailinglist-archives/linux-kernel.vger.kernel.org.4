Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDD270EE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbjEXGwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbjEXGvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:51:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D87E7D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:50:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so1180120a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684911055; x=1687503055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1BgDaEuGbsPtj89gXejmiemKbgHi9EHq9Za8nOtL1I=;
        b=EgvyynvnYSsaA25G+7MLLPYzMpi3yN4o3G1RyAt/VSfgaKCM7SrDfnfm0KmHEHZGjP
         6ErdO7t5dAR1q46BChrApVBhwG5Vb92CZ1oZK86qhqRHEmf3sujlTrbqiO4wxpL3JTNr
         VA+AT64mDoeWhg0YbN618Rv/lqhd2VhzOVvyMh6ax3QDSWquV9xGEAWzVD+eArOvTyWZ
         hNVQuYLf8YhjHY3rnOvazlHr0gr2hzJiSu1lXhavatw2r/iO8QFulUoKK5SiN6IZ0gp/
         GnDhDXyLRFIrGtCB4426XmfP+W8hPr0LLQqxtvfYx6RSoyD44e/4l9EX4ibbCMLMA7j3
         7Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684911055; x=1687503055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1BgDaEuGbsPtj89gXejmiemKbgHi9EHq9Za8nOtL1I=;
        b=Gt+KxVwtu4Tc5gEZBg2sKYz0WfFPr/lvNq76l8Jct1aPigEDDOncNu8iZI7mFwgT+S
         Y/eSzGCXb0wrXHZTB0iC/cqKeNfD/tlqSBTGYEsH6+QirB0QdVMIO7rWbpus/UA+F2IY
         8JF4M3aVgHGe0A8B68JUqey4+GM/m0uAgA7cRG5m+DE+MJ2pT6FbJliponHCsUYrBCDK
         dCOFy0pBt35mu6wa3Y38XBAAlgoZHrfnOznecVTJyrFSvPY+YzR7176Gbmlh1YQyfB2O
         NeP6+9BpMh4u+nPawzbMWBm/93BEqZC7vfvL0eGUaC5iq52N5mMYNgd2Uoh/PCpWZy3H
         7mww==
X-Gm-Message-State: AC+VfDz4njn+VHus3gaFMfLde6jX4nH8EIXE5mozrgZnEZrZWWf3JYWc
        /fmoDUtODV7ss3ztSINZa7Y=
X-Google-Smtp-Source: ACHHUZ7eSE7CehhQUk2qxVR8zYd9xtqKtzU+hEDjQn7ZMSMx65xOzZ1NG0htRR3myXtzygOkFztzWg==
X-Received: by 2002:a17:907:7b8d:b0:92b:3c78:91fa with SMTP id ne13-20020a1709077b8d00b0092b3c7891famr18509329ejc.28.1684911054895;
        Tue, 23 May 2023 23:50:54 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-95-247-156-74.retail.telecomitalia.it. [95.247.156.74])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906739000b0096650f46004sm5444304ejl.56.2023.05.23.23.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:50:54 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, yosryahmed@google.com,
        hannes@cmpxchg.org, kernel-team@fb.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH] mm: zswap: shrink until can accept
Date:   Wed, 24 May 2023 08:50:51 +0200
Message-Id: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This update addresses an issue with the zswap reclaim mechanism, which
hinders the efficient offloading of cold pages to disk, thereby
compromising the preservation of the LRU order and consequently
diminishing, if not inverting, its performance benefits.

The functioning of the zswap shrink worker was found to be inadequate,
as shown by basic benchmark test. For the test, a kernel build was
utilized as a reference, with its memory confined to 1G via a cgroup and
a 5G swap file provided. The results are presented below, these are
averages of three runs without the use of zswap:

real 46m26s
user 35m4s
sys 7m37s

With zswap (zbud) enabled and max_pool_percent set to 1 (in a 32G
system), the results changed to:

real 56m4s
user 35m13s
sys 8m43s

written_back_pages: 18
reject_reclaim_fail: 0
pool_limit_hit:1478

Besides the evident regression, one thing to notice from this data is
the extremely low number of written_back_pages and pool_limit_hit.

The pool_limit_hit counter, which is increased in zswap_frontswap_store
when zswap is completely full, doesn't account for a particular
scenario: once zswap hits his limit, zswap_pool_reached_full is set to
true; with this flag on, zswap_frontswap_store rejects pages if zswap is
still above the acceptance threshold. Once we include the rejections due
to zswap_pool_reached_full && !zswap_can_accept(), the number goes from
1478 to a significant 21578266.

Zswap is stuck in an undesirable state where it rejects pages because
it's above the acceptance threshold, yet fails to attempt memory
reclaimation. This happens because the shrink work is only queued when
zswap_frontswap_store detects that it's full and the work itself only
reclaims one page per run.

This state results in hot pages getting written directly to disk,
while cold ones remain memory, waiting only to be invalidated. The LRU
order is completely broken and zswap ends up being just an overhead
without providing any benefits.

This commit applies 2 changes: a) the shrink worker is set to reclaim
pages until the acceptance threshold is met and b) the task is also
enqueued when zswap is not full but still above the threshold.

Testing this suggested update showed much better numbers:

real 36m37s
user 35m8s
sys 9m32s

written_back_pages: 10459423
reject_reclaim_fail: 12896
pool_limit_hit: 75653

Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zswap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 59da2a415fbb..2ee0775d8213 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -587,9 +587,13 @@ static void shrink_worker(struct work_struct *w)
 {
 	struct zswap_pool *pool = container_of(w, typeof(*pool),
 						shrink_work);
+	int ret;
 
-	if (zpool_shrink(pool->zpool, 1, NULL))
-		zswap_reject_reclaim_fail++;
+	do {
+		ret = zpool_shrink(pool->zpool, 1, NULL);
+		if (ret)
+			zswap_reject_reclaim_fail++;
+	} while (!zswap_can_accept() && ret != -EINVAL);
 	zswap_pool_put(pool);
 }
 
@@ -1188,7 +1192,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	if (zswap_pool_reached_full) {
 	       if (!zswap_can_accept()) {
 			ret = -ENOMEM;
-			goto reject;
+			goto shrink;
 		} else
 			zswap_pool_reached_full = false;
 	}
-- 
2.34.1

