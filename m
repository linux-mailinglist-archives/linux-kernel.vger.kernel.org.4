Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0B9642F7C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiLERwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiLERvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:48 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445B71EC47
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:51:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so6620880pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 09:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npFjL6Dds3DKnQo07iUTlbqXMaucW9/yvERNl8ZNQRo=;
        b=mLWxUj1chMRiHdvugVEpnaxQ41A/ablxwsfxwk8xacytULj+ChB/06IFBL6WwSIScd
         4UnPBnLjtdJHcrXsK8FrHNSCKlQJosnldDtaMV7Y6yjl6vVGA8CnsUR4UNcov+bpxf7l
         1e2gADjhBINCiJVwtfuwZmxFtzvnoNpDHz6DRdaKJi+DPqLQ8hCNpZBPeDqAKBn8P+67
         AgBeur0PkHavY/K9nJOKtSb29BTgBnokiSezvSqrDesT1h0xSPvN4CjbmVS/EHS1/MJZ
         GilTo4H194oDwlt09T1aymIMfQ9aR7xVQAtH5wbx3oi6kb6dFhMa97eaikt7FES2sMrR
         DhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npFjL6Dds3DKnQo07iUTlbqXMaucW9/yvERNl8ZNQRo=;
        b=ci3CrBJNXKRJICpECDdFlc8Q+DHLc7j0wumOdqGj5VNNd/8XuzU7qScBw0BvMU/7Su
         XXX3LnS5w7PinK/IB4Xq/EpIMbzPs9l2sfrdrpoRRz7QFZ5bL5v18rFZwhLmUs+tKhKk
         8b8EB9XZ0rWeKNwNHRpC66KlYeLUo7hcaRbQE7eCPXysC9z3nmkA0JvPzGQQP0hRrs32
         mnahJMU4S7wx/AAPxVjpDDvyVGyJcV5V6yTm4agI93uwRb4x8edxd1jp0odFgveGXxQI
         5KqzlgjQQombQ9rI8BUoVwx8OZjAGpW/vFwRe4UcCHh172QaSCtYplqzCKUD5Pd5jshj
         +cdA==
X-Gm-Message-State: ANoB5pmKqNDhadAlLi5yd/GGcst/pg1n3VY/cruRiMbX8e0hSVJMU8Bu
        u0ZSrNic2ihZmh1KelhBBuE=
X-Google-Smtp-Source: AA0mqf7E5ztRL11sQZw9Ri0S+eLl0oSX/xxG2eP09s/4GVm7agnok9htqDogdvSs9ZdZLmqIvUrxvg==
X-Received: by 2002:a17:90a:eac2:b0:219:484:e955 with SMTP id ev2-20020a17090aeac200b002190484e955mr53314897pjb.214.1670262704724;
        Mon, 05 Dec 2022 09:51:44 -0800 (PST)
Received: from localhost (fwdproxy-prn-001.fbsv.net. [2a03:2880:ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a5a4100b00219396d795esm9476586pji.15.2022.12.05.09.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:51:44 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v2 1/4] workingset: fix confusion around eviction vs refault container
Date:   Mon,  5 Dec 2022 09:51:37 -0800
Message-Id: <20221205175140.1543229-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205175140.1543229-1-nphamcs@gmail.com>
References: <20221205175140.1543229-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

Refault decisions are made based on the lruvec where the page was
evicted, as that determined its LRU order while it was alive. Stats
and workingset aging must then occur on the lruvec of the new page, as
that's the node and cgroup that experience the refault and that's the
lruvec whose nonresident info ages out by a new resident page. Those
lruvecs could be different when a page is shared between cgroups, or
the refaulting page is allocated on a different node.

There are currently two mix-ups:

1. When swap is available, the resident anon set must be considered
   when comparing the refault distance. The comparison is made against
   the right anon set, but the check for swap is not. When pages get
   evicted from a cgroup with swap, and refault in one without, this
   can incorrectly consider a hot refault as cold - and vice
   versa. Fix that by using the eviction cgroup for the swap check.

2. The stats and workingset age are updated against the wrong lruvec
   altogether: the right cgroup but the wrong NUMA node. When a page
   refaults on a different NUMA node, this will have confusing stats
   and distort the workingset age on a different lruvec - again
   possibly resulting in hot/cold misclassifications down the line.

Fix the swap check and the refault pgdat to address both concerns.

This was found during code review. It hasn't caused notable issues in
production, suggesting that those refault-migrations are relatively
rare in practice.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Co-developed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/workingset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index ae7e984b23c6..79585d55c45d 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -457,6 +457,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 	 */
 	nr = folio_nr_pages(folio);
 	memcg = folio_memcg(folio);
+	pgdat = folio_pgdat(folio);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);

 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
@@ -474,7 +475,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 		workingset_size += lruvec_page_state(eviction_lruvec,
 						     NR_INACTIVE_FILE);
 	}
-	if (mem_cgroup_get_nr_swap_pages(memcg) > 0) {
+	if (mem_cgroup_get_nr_swap_pages(eviction_memcg) > 0) {
 		workingset_size += lruvec_page_state(eviction_lruvec,
 						     NR_ACTIVE_ANON);
 		if (file) {
--
2.30.2
