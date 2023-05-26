Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79409712BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbjEZRkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbjEZRkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:40:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADBC9C
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:40:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f7377c86aso170304966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685122801; x=1687714801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o16G9dPIrqAga4lo4DLIjG9Wv4N2BLNRqrSSEriNgT0=;
        b=qpu9Bv+u7sPo5eBwj+7k6ZtiCbuuZCpIEi9hh0plPkI6u5aNcCQTzZzsn0fS3h/C7Z
         NhT6vIH+D/GFR7jQKVruYL7dW6qexXdHpy5hjtaWtn5yQa3hxefZ/OAoYsi9MeSlDxo6
         WMmk4Qn+26E8hXHeS0v+XapEpqLxnkXIupRY0Z/SPpZE5RUTxHUjMivfnwQu9mMtk4le
         LzBEblatDND/t3yh3h7APgqOQZvFMHQq/q4RGW/F2P2FEewb6b4expNsd91LlEZh8OFc
         kv900xSJiPdqrbHxQ5sIXsTbewL3netuAfbyKTys8STiDziFfVKrNXNvrIRxZ4+orlDU
         K6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685122801; x=1687714801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o16G9dPIrqAga4lo4DLIjG9Wv4N2BLNRqrSSEriNgT0=;
        b=Si6Fsn3GSg+qU2pDD1HL8Bite8/KweCtdOc3eQYbApV4lFlXl3mWgmCZivyye4ken8
         8w6UDcaHEuZIRwAKfKkyVG06q4fMA/RakHDGg6codv4Y9vV+lOz0B+flb+NgHSLzJUTq
         V2UfQjMXcPV48rZ+3bGnm429mfzDPt4MCd5qdWmNylujdkgkvv81DmrP6Ij1CMPHQH5E
         V0sKPW+0vN1/ycaq6BM5peVGPLaEYFVvxFsnKNcEY+pfAs6TsxVZOa38QPbu/YWhEsCU
         4jHDMV4Kq0Lfk3Sbl999SJRS8WXayzb79PWZRqmnSG9CxHVe4BdBKJ/PrHLd+0vtKXnm
         NfvA==
X-Gm-Message-State: AC+VfDzkLjuj03xxlsLbSJqJSvPBlCzjCbQ8pEHCuQp9flyLLiKKviHB
        atM849yPG2Do8Vr7WSbstxM=
X-Google-Smtp-Source: ACHHUZ7HiivSeQORwj2h+UiuD32hVlBu7zcVhSUj2RPNw/rPXS+3z0TyozmYmEVObz5aoV1AuyOf2w==
X-Received: by 2002:a17:907:98e:b0:957:943e:7416 with SMTP id bf14-20020a170907098e00b00957943e7416mr2375842ejc.15.1685122800824;
        Fri, 26 May 2023 10:40:00 -0700 (PDT)
Received: from lelloman-5950.. (host-79-43-28-95.retail.telecomitalia.it. [79.43.28.95])
        by smtp.gmail.com with ESMTPSA id lf20-20020a170906ae5400b0096f84292cf5sm2381205ejb.132.2023.05.26.10.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:40:00 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, yosryahmed@google.com,
        hannes@cmpxchg.org, kernel-team@fb.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v2] mm: zswap: shrink until can accept
Date:   Fri, 26 May 2023 19:39:55 +0200
Message-Id: <20230526173955.781115-1-cerasuolodomenico@gmail.com>
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

V2:
- loop against == -EAGAIN rather than != -EINVAL and also break the loop
on MAX_RECLAIM_RETRIES (thanks Yosry)
- cond_resched() to ensure that the loop doesn't burn the cpu (thanks
Vitaly)

Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zswap.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 59da2a415fbb..f953dceaab34 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -37,6 +37,7 @@
 #include <linux/workqueue.h>
 
 #include "swap.h"
+#include "internal.h"
 
 /*********************************
 * statistics
@@ -587,9 +588,17 @@ static void shrink_worker(struct work_struct *w)
 {
 	struct zswap_pool *pool = container_of(w, typeof(*pool),
 						shrink_work);
+	int ret, failures = 0;
 
-	if (zpool_shrink(pool->zpool, 1, NULL))
-		zswap_reject_reclaim_fail++;
+	do {
+		ret = zpool_shrink(pool->zpool, 1, NULL);
+		if (ret) {
+			zswap_reject_reclaim_fail++;
+			failures++;
+		}
+		cond_resched();
+	} while (!zswap_can_accept() && ret == -EAGAIN &&
+		 failures < MAX_RECLAIM_RETRIES);
 	zswap_pool_put(pool);
 }
 
@@ -1188,7 +1197,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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

