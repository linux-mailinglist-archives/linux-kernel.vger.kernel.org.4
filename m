Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82200632A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiKURMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiKURMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:12:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469ECEFF1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:12:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 767781F8B4;
        Mon, 21 Nov 2022 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669050731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+6JBhvUCUmmY2fewWAJiOqYwob3QGMrPLk+o7jKpOo=;
        b=rmucTGRhwveRnInQNpada4a4fkOqU6D6rRn9oP5ElxleOq8yEvmYnOEhYDr+K8soSSBUR0
        ApX/SEVkPEnvlVduLIpiCf7597UbxLGv4wiDmeFhQjxo4TF1RTKYCpMz8fxzzzN0xVFggC
        iEMgt8tuVapzUSxmvwogI3SUBUS2Sek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669050731;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+6JBhvUCUmmY2fewWAJiOqYwob3QGMrPLk+o7jKpOo=;
        b=ibeF/tUAVWs4fDUiEPICV/h0CIyDkXvu2Fwj3crXGYkf3alc6y3+9IzvFzC5Ov1PpvV44s
        hW9J4iGgwJb4cFDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AD5013B03;
        Mon, 21 Nov 2022 17:12:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OFWnEWuxe2MQeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 21 Nov 2022 17:12:11 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 05/12] mm, slub: lower the default slub_max_order with CONFIG_SLUB_TINY
Date:   Mon, 21 Nov 2022 18:11:55 +0100
Message-Id: <20221121171202.22080-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121171202.22080-1-vbabka@suse.cz>
References: <20221121171202.22080-1-vbabka@suse.cz>
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

With CONFIG_SLUB_TINY we want to minimize memory overhead. By lowering
the default slub_max_order we can make slab allocations use smaller
pages. However depending on object sizes, order-0 might not be the best
due to increased fragmentation. When testing on a 8MB RAM k210 system by
Damien Le Moal [1], slub_max_order=1 had the best results, so use that
as the default for CONFIG_SLUB_TINY.

[1] https://lore.kernel.org/all/6a1883c4-4c3f-545a-90e8-2cd805bcf4ae@opensource.wdc.com/

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 917b79278bad..bf726dd00f7d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3888,7 +3888,8 @@ EXPORT_SYMBOL(kmem_cache_alloc_bulk);
  * take the list_lock.
  */
 static unsigned int slub_min_order;
-static unsigned int slub_max_order = PAGE_ALLOC_COSTLY_ORDER;
+static unsigned int slub_max_order =
+	IS_ENABLED(CONFIG_SLUB_TINY) ? 1 : PAGE_ALLOC_COSTLY_ORDER;
 static unsigned int slub_min_objects;
 
 /*
-- 
2.38.1

