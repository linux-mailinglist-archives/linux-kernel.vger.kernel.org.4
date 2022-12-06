Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD854644E84
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiLFWYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLFWYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B230577
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670365414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KbcWN/Q2/pafQvgYCQFGwmhf/LUYY3gpOtuCCKoJbLI=;
        b=NdDfPqh4EVTCN3l2AY8PgAyn61JceAbxbMuwoQqAvPA/aAsRskP78oR1aepzHCGsjwmiDk
        blsLy/pOCxAHIxVUe2iXiuvOAL+qlQNzaPCKr1BWr2EjCRiLnWHAgJLdK4R2lm0sf41jDV
        G7u7GDfMh+/4IeplTs69v0h3VIPw6fQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-r1vEH37-OeiFQN_UhFKpZg-1; Tue, 06 Dec 2022 17:23:30 -0500
X-MC-Unique: r1vEH37-OeiFQN_UhFKpZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FDE3811E67;
        Tue,  6 Dec 2022 22:23:29 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.11.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA56E2027061;
        Tue,  6 Dec 2022 22:23:27 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     riel@surriel.com, mhocko@suse.com, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, hannes@cmpxchg.org,
        akpm@linux-foundation.org, aquini@redhat.com, longman@redhat.com
Subject: [RFC] vmscan: Scale file_is_tiny calculation based on priority
Date:   Tue,  6 Dec 2022 15:23:15 -0700
Message-Id: <20221206222315.37631-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that reclaiming anon memory is more prevelant (Johannes describes this
well in commit f53af4285d77 ("mm: vmscan: fix extreme overreclaim and swap
floods")), we've been seeing large bursts (sometimes in the order of
multiple GiBs) of anon memory being reclaimed despite swappiness being
very low (=1) and there being plenty of page cache remaining.

Johannes commit f53af4285d77 ("mm: vmscan: fix extreme overreclaim and
swap floods"), helped reduce these swap storms; however, it did not fully
curb this effect. Under further investigation I noticed these swap
storms correspond to the activation of file_is_tiny.

file_is_tiny is being computed on a per-node basis, if reclaim
drains the page cache on one node, and the scheduler is prefering
new allocations on a separate node, file_is_tiny will remain elevated
for a very long time, constantly draining anon from the node that is low
on page cache.

These burst of reclaim are also seen in the single node case, where once
file_is_tiny=1, anon reclaim is too aggressive with a low swap value.

Reduce these extreme bursts of anon reclaim by scaling the total_high_wmark
down by the reclaim priority. This will activate file_is_tiny way less
often, and for smaller bursts.

Fixes: ccc5dc67340c ("mm/vmscan: make active/inactive ratio as 1:1 for anon lru")
Fixes: 5df741963d52 ("mm: fix LRU balancing effect of new transparent huge pages")
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 026199c047e0..0d288bb5354e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2882,7 +2882,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
 		anon = node_page_state(pgdat, NR_INACTIVE_ANON);
 
 		sc->file_is_tiny =
-			file + free <= total_high_wmark &&
+			file + free <= (total_high_wmark >> sc->priority) &&
 			!(sc->may_deactivate & DEACTIVATE_ANON) &&
 			anon >> sc->priority;
 	}
-- 
2.38.1

