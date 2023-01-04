Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA69265DFFC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjADW36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbjADW3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:29:52 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0466B42600
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:29:46 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o21so7645222pjw.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=npFjL6Dds3DKnQo07iUTlbqXMaucW9/yvERNl8ZNQRo=;
        b=OWeh/xJasix7ucatObuWl3DONvbabYvNQFmjbkxy4TsWrHQ6sgQ4Q1RrAkB4fHWo+R
         QqcOI5wHYusIxypkiUE8QA01I5znwb5MuEjGOOxYlGRJXgJ+t/Y07y47zlCa+bDecmCa
         jRLDzay7BhzAr/uX7Bq2XoBrcJNGjwJAn35htNsjVF1VEApIDR1mSs2kCG3nZpWp7gOg
         Bv65mwAtANq3K4PBT7gLkZyUIoth4O9joCJSfs0ZH5tVn9bhQrv8h6OrMlNoPYCDJn8L
         sPOIgorTOJPWjB04nmHqo48GY30cOLowMhG9Ue3oL4PXSXkMHjI0kIOTZs49MzFZYsTj
         Zy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npFjL6Dds3DKnQo07iUTlbqXMaucW9/yvERNl8ZNQRo=;
        b=w9Q3K+OySUwoQe9/21Us6gutRc1TDLk/eR1NLG6psZlVBNcmgyIsAKrgey/kQrayyD
         4XdUdaQf2t/diZWU4I+2yZ50GEDh6Jmm70Rgl0L6Sci83C42FkXrmQOej7cH+FJqZ9oI
         1k3PWONAd6UhT4WyEIZcghu+6HZXipZFSSxTCTCNEOU+V56L6gX0IMeG6rkwDC82E5oe
         FR0tLG8Q8JHVR50FOnfaoYJ03H/pVMVVcDS/Ac5IuNiz4raCvtmN5KUANZConDz8PLb7
         zrhaGcRF0cfKyURuwQNDv1yVMIozygWW/Bg+115aBb/+HNB/RWAstL2QuVEgISpNuzVG
         gnKQ==
X-Gm-Message-State: AFqh2koPz8dXsXi63u+gbjEY8VlQK+dzzpCTIceIqi13r+dFw8v2+koS
        fLUZjCwjuAhqJzCbVvJl4WQE5GBS+kk=
X-Google-Smtp-Source: AMrXdXummmRPdLPDCZJnf16qcRjCFT8Ft0zu6vTjKxFqQng10LGXjfMissTbYkzRjIio/50ljKvhOg==
X-Received: by 2002:a17:902:848d:b0:191:1e89:35de with SMTP id c13-20020a170902848d00b001911e8935demr52352601plo.9.1672871386139;
        Wed, 04 Jan 2023 14:29:46 -0800 (PST)
Received: from localhost (fwdproxy-prn-012.fbsv.net. [2a03:2880:ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b00192944e3650sm15456333plb.268.2023.01.04.14.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:29:45 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH] workingset: fix confusion around eviction vs refault container
Date:   Wed,  4 Jan 2023 14:29:44 -0800
Message-Id: <20230104222944.2380117-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
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
