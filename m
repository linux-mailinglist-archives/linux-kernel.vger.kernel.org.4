Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438605FED4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJNLnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJNLnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:43:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373641C8437
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:43:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso7589481pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XtwckXY6GxG78kcpO8+3k1Gq+VT6rNZTsbhQDdeEaDs=;
        b=RyFNLKV4kCKAULz2zXwQH1I7Vbb+R8O/w1860da086cFUgLzEPfQAZHXTJ7s8Y7ADQ
         jfEuo6v3iUa08i0aj9Eu3Ql3MEyY07KlN3EK79rrRZd72kTZ3KZOTBI4oAuI8Q7aooBY
         WWxhsTC+tg5Psc09DFqaQCLWkEAN+ZwAEN1gOCLT9x+h6W1Ylg4/2DbCCU3DciOzyJTx
         46vVNqE+sV20n/trrqY+2XDvcIA3+Ht+Lz8RWq2s7bmZqNBlIEyS7m0iR4gQTbrlsaVq
         E1k1lzwK7hw/kytwHvz0v6V9gC8nMoX1qR1bfYcsnp7Kv/W9w+xRV6s1gr6YVPWqTbKQ
         ChUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtwckXY6GxG78kcpO8+3k1Gq+VT6rNZTsbhQDdeEaDs=;
        b=rM15PHp5HRvDvrm5GfRH+E828EXoNg6QgEuaJE8KXAwSm7lOmW+gSjiVYf0p7j2p/N
         r7Zjx3CHu1+KU9fpTOsaKnFeCiX6wvE1c/7w66Ssd4pi5vlvd44+Iu22F5L8CEzEtY6W
         yqWd8V9yWaiLqRysaUqSXReC7pUJraadLW2Sl6SRB8BRmk0AlPKOFwRh/dJ1foxg3JB/
         d4yj+2Ie3GnMey1E6xdWLp6ktkqYl2PPZ72ZJwG/23AfH26AG0OUB7l7/BPbwid98MZV
         3nACDuwQGUbHZK48vWOxdoSo5C1orQz58LluNv9NRSh0PFa8NBem7vpWe8TzlGTxk+CV
         EIsA==
X-Gm-Message-State: ACrzQf3pwdELJReIL4RipLPXIAGXNti/9KRhP/YEESYGnCpuQr9vkF4j
        bxC58Fo2ijoPgLjiQhAnhGo=
X-Google-Smtp-Source: AMsMyM7jsEKb+jhtAMZz14QrVwXhq59qrHDM300z2XniVkRWpRp+l8VZmMbO4pzcrNMY2TcEeeAHEg==
X-Received: by 2002:a17:902:d484:b0:17f:7437:565d with SMTP id c4-20020a170902d48400b0017f7437565dmr4892551plg.154.1665747828641;
        Fri, 14 Oct 2022 04:43:48 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b00178a8f4d4f2sm1542251plg.74.2022.10.14.04.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:43:47 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: remove dead code for debug caches on deactivate_slab()
Date:   Fri, 14 Oct 2022 20:43:22 +0900
Message-Id: <20221014114322.97512-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit c7323a5ad0786 ("mm/slub: restrict sysfs validation to debug
caches and make it safe"), SLUB does not take a slab from partial list for
debug caches. As deactivation isn't needed anymore, remove dead code.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 96dd392d7f99..e2215240954d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2411,7 +2411,7 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
 static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 			    void *freelist)
 {
-	enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE, M_FULL_NOLIST };
+	enum slab_modes { M_NONE, M_PARTIAL, M_FREE, M_FULL_NOLIST };
 	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
 	int free_delta = 0;
 	enum slab_modes mode = M_NONE;
@@ -2487,14 +2487,6 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 		 * acquire_slab() will see a slab that is frozen
 		 */
 		spin_lock_irqsave(&n->list_lock, flags);
-	} else if (kmem_cache_debug_flags(s, SLAB_STORE_USER)) {
-		mode = M_FULL;
-		/*
-		 * This also ensures that the scanning of full
-		 * slabs from diagnostic functions will not see
-		 * any frozen slabs.
-		 */
-		spin_lock_irqsave(&n->list_lock, flags);
 	} else {
 		mode = M_FULL_NOLIST;
 	}
@@ -2504,7 +2496,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
 				"unfreezing slab")) {
-		if (mode == M_PARTIAL || mode == M_FULL)
+		if (mode == M_PARTIAL)
 			spin_unlock_irqrestore(&n->list_lock, flags);
 		goto redo;
 	}
@@ -2518,10 +2510,6 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 		stat(s, DEACTIVATE_EMPTY);
 		discard_slab(s, slab);
 		stat(s, FREE_SLAB);
-	} else if (mode == M_FULL) {
-		add_full(s, n, slab);
-		spin_unlock_irqrestore(&n->list_lock, flags);
-		stat(s, DEACTIVATE_FULL);
 	} else if (mode == M_FULL_NOLIST) {
 		stat(s, DEACTIVATE_FULL);
 	}
-- 
2.32.0

