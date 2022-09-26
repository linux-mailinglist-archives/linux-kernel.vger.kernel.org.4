Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B895EAB39
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbiIZPhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbiIZPfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0624BBF76
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CE9F60DE1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDADC43470;
        Mon, 26 Sep 2022 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664202090;
        bh=h7h74y8er6BoIqIK+NiPbrmtuB0Riz6+hSGGmV7Df14=;
        h=From:To:Cc:Subject:Date:From;
        b=lD8hNLrbF6sEGxqr/uldD4SMD1/tmZ91P2U76f5F94M3ttIK7XzG20QvpXfvGj6Jb
         byAuOwCw9q9DFaUA2ihHJmEs2/Apa+L8oF+kJ6dTBWqTFu+bGFp1k5qkrZ+sofiVDk
         spp+BQghx/FQTVuBbTO72vfrblLBPZNzUi0pU4cOEX9zCo/9IzhXBeA1Wp8ae3vOr5
         RuzUuKqP8PekEgUcpthxxGBqASHtm5bgrdzR8/XerWfAL3+ikq7PKZIuTYSOJvLrhv
         GyyYv32PeOdsK+KDlCpsn3jgiU5LeuptI2idvQXUTMo3tHASXeHG89xzQOTYqEdEVx
         /zPc6DTKNUuXg==
From:   Chao Yu <chao@kernel.org>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hugh@veritas.com>
Cc:     chao@kernel.org, Chao Yu <chao.yu@oppo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/slub: clean up create_unique_id()
Date:   Mon, 26 Sep 2022 22:20:41 +0800
Message-Id: <20220926142042.2725-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2. use WARN_ON instead of BUG_ON() and return error if check condition
is true;
3. use snprintf instead of sprintf to avoid overflow.

Link: https://lore.kernel.org/linux-mm/2025305d-16db-abdf-6cd3-1fb93371c2b4@wanadoo.fr/
Fixes: 81819f0fc828 ("SLUB core")
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
v3:
- clean up codes
- fix size parameter of snprintf()
 mm/slub.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4b98dff9be8e..4d3ee0924533 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5890,7 +5890,7 @@ static inline struct kset *cache_kset(struct kmem_cache *s)
 	return slab_kset;
 }
 
-#define ID_STR_LENGTH 64
+#define ID_STR_LENGTH 32
 
 /* Create a unique string id for a slab cache:
  *
@@ -5924,9 +5924,12 @@ static char *create_unique_id(struct kmem_cache *s)
 		*p++ = 'A';
 	if (p != name + 1)
 		*p++ = '-';
-	p += sprintf(p, "%07u", s->size);
+	p += snprintf(p, ID_STR_LENGTH - (p - name), "%07u", s->size);
 
-	BUG_ON(p > name + ID_STR_LENGTH - 1);
+	if (WARN_ON(p > name + ID_STR_LENGTH - 1)) {
+		kfree(name);
+		return ERR_PTR(-EINVAL);
+	}
 	return name;
 }
 
-- 
2.36.1

