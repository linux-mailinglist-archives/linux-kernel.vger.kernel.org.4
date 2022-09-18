Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513EC5BBCC1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIRJWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIRJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEF61EC41
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 551AE61370
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 09:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B754C433D6;
        Sun, 18 Sep 2022 09:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663492930;
        bh=d3t5vaJ7vpph6uaJ6/CLOVhFeXHAy4FKOvb8EhJO0vE=;
        h=From:To:Cc:Subject:Date:From;
        b=bZnt1YBTZePDwrE/lyj0niNlKTnwv6m78bMIrck6gMy+9JyZmLqExPfXEZtxbDGub
         p29TwO1g4NjpruzgtOi8TweChcRH1Wjjc/zqJj8FjEgP8dXOWTIDsc0Fqug9+1VNWP
         OwYdFmEP+8l6xuUgaZsqd0uPl6NCDMqMyQZsVjPWUV9UnV+euZc93bUAos8QkKMd0T
         ymz1NbLSq34Zz8jsgmVK4Ijk2+4BHOLYooQpgouLjjGnxa09A0xhHgR3radr6sfZF3
         oaJlotGcpAk2Cw0DNKbN5dAxQrR71UZcN3Pi4PoaatLSjBPe2Wd1fccWMABMuR18TN
         lcXeX6h2x/pUA==
From:   Chao Yu <chao@kernel.org>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Hugh Dickins <hugh@veritas.com>
Cc:     chao@kernel.org, Chao Yu <chao.yu@oppo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: clean up create_unique_id()
Date:   Sun, 18 Sep 2022 17:21:46 +0800
Message-Id: <20220918092146.4060783-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <chao.yu@oppo.com>

As Christophe JAILLET suggested:

In create_unique_id(),

"looks that ID_STR_LENGTH could even be reduced to 32 or 16.

The 2nd BUG_ON at the end of the function could certainly be just
removed as well or remplaced by a:
        if (p > name + ID_STR_LENGTH - 1) {
                kfree(name);
                return -E<something>;
        }
"

According to above suggestion, let's do below cleanups:
1. reduce ID_STR_LENGTH to 32, as the buffer size should be enough;
2. remove BUG_ON() and return error if check condition is true.

Link: https://lore.kernel.org/linux-mm/2025305d-16db-abdf-6cd3-1fb93371c2b4@wanadoo.fr/
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Fixes: 81819f0fc828 ("SLUB core")
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 mm/slub.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5ba6db62a5ab..a045c1ca8772 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5883,7 +5883,7 @@ static inline struct kset *cache_kset(struct kmem_cache *s)
 	return slab_kset;
 }
 
-#define ID_STR_LENGTH 64
+#define ID_STR_LENGTH 32
 
 /* Create a unique string id for a slab cache:
  *
@@ -5919,7 +5919,10 @@ static char *create_unique_id(struct kmem_cache *s)
 		*p++ = '-';
 	p += sprintf(p, "%07u", s->size);
 
-	BUG_ON(p > name + ID_STR_LENGTH - 1);
+	if (p > name + ID_STR_LENGTH - 1) {
+		kfree(name);
+		return ERR_PTR(-EINVAL);
+	}
 	return name;
 }
 
-- 
2.25.1

