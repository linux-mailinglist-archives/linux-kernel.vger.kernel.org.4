Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9617712C75
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbjEZSck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbjEZScj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:32:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C1A116
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:32:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f818c48fbso191022366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685125956; x=1687717956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TfI6gce8/n7aYAsMcj2pW6r1+pTyQaEFnjJCPcxue4o=;
        b=ZpA/0XZrk9Ygxw8wd7SLozHGv0SEOQi7mqIYsJ8u4JVekZAvJ3qfubZcNKKyLV+F/z
         9o9Cv9oRC9eihw0UP+sJffHxHDSO3C+r3G1BHhIIxCO3CfpXXeqJAclQQanb3TwXnX+Y
         PRScUh7gnYb830SH0t8i5qFXIEb6mSob1CwDX3iU+Kd3Brs1EWpBcRJ/0Jnwn+bTPKCx
         KwJ+/Sb7/DQjd+HvWQH7a1u/sAexnWjXPF4FLUmVADarV+oZiITuoaghWsAP96fDVQOb
         Ry9PmXEZ7ZxnMSml9QoZ9NBxOlNU3NAbtukL/nNIoPsMGqBQqb04nH6E96izAP+trfSZ
         qXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685125956; x=1687717956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfI6gce8/n7aYAsMcj2pW6r1+pTyQaEFnjJCPcxue4o=;
        b=XwQDasZEApHQSKrX/YBVlkd3YX6a1XExFPTsfDA2cBYj9ut7EEJDUayctyuJF/Py21
         rgb8KWtTSlkPlf9f35Fj3CFGcILF15A6YwGrIBidZvs1T/rBWSjLxdivXRjswNp8q4XV
         A+74ZQNCx3mMn6tPS9WPPk5+CsTGz16Hgt4gehSsyDBIV4CC6VMUblymHsBFlAFzUiZ1
         KnJCPe4Y4etGtBlWBdNRaEWnnSxj4N0GXiGUWYyor/hgBWZH3HMWc7w/wt5TX4Sn+NfM
         hUJxkOQYvh86kW2J47wO/jW/K1RnSK+VNvOSijgIYwXsuGW3GSENOwCfFOUXn/mifpyD
         EfwQ==
X-Gm-Message-State: AC+VfDw/ZbjROk2u4I2u2r+NQxuaTAWvJOQavgmP+BeruPdzhNglYdXc
        35SYLM8m7km1uOPEdU9pV7w=
X-Google-Smtp-Source: ACHHUZ6odSUJK0yweALsc1BX4N5roFF2tMlehy1f269bEaZ1mlVlQnQZ3yxWV4MjIPXcheZGOSFtSA==
X-Received: by 2002:a17:907:9708:b0:970:925:6563 with SMTP id jg8-20020a170907970800b0097009256563mr3231068ejc.8.1685125956187;
        Fri, 26 May 2023 11:32:36 -0700 (PDT)
Received: from lelloman-5950.. (host-79-43-28-95.retail.telecomitalia.it. [79.43.28.95])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906560d00b009603d34cfecsm2397615ejq.164.2023.05.26.11.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:32:35 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, yosryahmed@google.com,
        hannes@cmpxchg.org, kernel-team@fb.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v3] mm: zswap: shrink until can accept
Date:   Fri, 26 May 2023 20:32:27 +0200
Message-Id: <20230526183227.793977-1-cerasuolodomenico@gmail.com>
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

V3:
- fix wrong loop break, should continue on !ret (thanks Johannes)

Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zswap.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 59da2a415fbb..bcb82e09eb64 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -37,6 +37,7 @@
 #include <linux/workqueue.h>
 
 #include "swap.h"
+#include "internal.h"
 
 /*********************************
 * statistics
@@ -587,9 +588,19 @@ static void shrink_worker(struct work_struct *w)
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
+			if (ret != -EAGAIN)
+				break;
+			if (++failures == MAX_RECLAIM_RETRIES)
+				break;
+		}
+		cond_resched();
+	} while (!zswap_can_accept());
 	zswap_pool_put(pool);
 }
 
@@ -1188,7 +1199,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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

