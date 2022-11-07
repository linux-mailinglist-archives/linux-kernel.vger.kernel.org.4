Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A4B61FACB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiKGRGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiKGRGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:06:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8322F1A20F;
        Mon,  7 Nov 2022 09:05:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 70B181F383;
        Mon,  7 Nov 2022 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667840757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxt8DX9hjtQmJzjUJiAZ/pvWxZcY7FsbKiwy/1OaLtI=;
        b=1lzbk6FbmE1Ji+YX8AWT7ByzYWFkLM0klQ18smQktoXQgePMt4bnUreeY86am0yeokdgEB
        QtyUgF0y1bSbUbA4seztn2v1HaYPKT7kweuMv8/mtw7mvcTHFTpYuU3bI9UV1+pw3mhlYL
        zcc1aLbFLU9ErXpbWcHUaWMx8pOCWFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667840757;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxt8DX9hjtQmJzjUJiAZ/pvWxZcY7FsbKiwy/1OaLtI=;
        b=FCrIbgvyydHhHw/n93XtEZbWSlxOoQ4AzWmAzv1mIMBmWnFUVUVo3fQQbiVVUehzRBXspC
        3I84wT07/3zCFOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45BDD13ADB;
        Mon,  7 Nov 2022 17:05:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MNB2EPU6aWOYfwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 07 Nov 2022 17:05:57 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, paulmck@kernel.org,
        rcu@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 1/3] mm/slub: perform free consistency checks before call_rcu
Date:   Mon,  7 Nov 2022 18:05:52 +0100
Message-Id: <20221107170554.7869-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107170554.7869-1-vbabka@suse.cz>
References: <20221107170554.7869-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SLAB_TYPESAFE_BY_RCU caches we use call_rcu to perform empty slab
freeing. The rcu callback rcu_free_slab() calls __free_slab() that
currently includes checking the slab consistency for caches with
SLAB_CONSISTENCY_CHECKS flags. This check needs the slab->objects field
to be intact.

Because in the next patch we want to allow rcu_head in struct slab to
become larger in debug configurations and thus potentially overwrite
more fields through a union than slab_list, we want to limit the fields
used in rcu_free_slab().  Thus move the consistency checks to
free_slab() before call_rcu(). This can be done safely even for
SLAB_TYPESAFE_BY_RCU caches where accesses to the objects can still
occur after freeing them.

As a result, only the slab->slab_cache field has to be physically
separate from rcu_head for the freeing callback to work. We also save
some cycles in the rcu callback for caches with consistency checks
enabled.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 157527d7101b..99ba865afc4a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1999,14 +1999,6 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	int order = folio_order(folio);
 	int pages = 1 << order;
 
-	if (kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS)) {
-		void *p;
-
-		slab_pad_check(s, slab);
-		for_each_object(p, s, slab_address(slab), slab->objects)
-			check_object(s, slab, p, SLUB_RED_INACTIVE);
-	}
-
 	__slab_clear_pfmemalloc(slab);
 	__folio_clear_slab(folio);
 	folio->mapping = NULL;
@@ -2025,9 +2017,17 @@ static void rcu_free_slab(struct rcu_head *h)
 
 static void free_slab(struct kmem_cache *s, struct slab *slab)
 {
-	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU)) {
+	if (kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS)) {
+		void *p;
+
+		slab_pad_check(s, slab);
+		for_each_object(p, s, slab_address(slab), slab->objects)
+			check_object(s, slab, p, SLUB_RED_INACTIVE);
+	}
+
+	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU))
 		call_rcu(&slab->rcu_head, rcu_free_slab);
-	} else
+	else
 		__free_slab(s, slab);
 }
 
-- 
2.38.0

