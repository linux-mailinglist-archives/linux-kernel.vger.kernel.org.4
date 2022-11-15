Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE562A150
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiKOS3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiKOS3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:29:13 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F205F2FFD8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:29:04 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n17so6412319pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npFjL6Dds3DKnQo07iUTlbqXMaucW9/yvERNl8ZNQRo=;
        b=NPDHr0QlHVIUIhIrDfHxvLDIuBOtKZfo7tv9Z1S0sFSK9TGsnpiguY2DVaj8KQqkUg
         2SugxfLILvY2yZb9mSRU2q3++D6K9Vj+iOyidmF/ozO/p/7XOGWmFRfizSWm5iaLk5hj
         il4Q4TvN2HUyX2sk4tSfr2n2+tzXd77V5UybYcVVdBEnLxiMpx20HM6oe4QsCFyHtEs2
         LJ3vSboCcqML9M7WDu6BnBSGDB+A5Hgh9HctMZlRn/EuhBDkfp2Exqkb6OqkY16lFgjL
         mqYbnVzmCbSOyK+6Jgh/buBRjxAFZ5UldLk6C7sULrRpi2KwbgfgjYgFwkYbz8uiAGV1
         sx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npFjL6Dds3DKnQo07iUTlbqXMaucW9/yvERNl8ZNQRo=;
        b=S0sz/vWAjQCs/1P4XYe5XebJKXlS1wTddDknpvkdJTY80L4CblJNlZNf6XoKDRhuEN
         i1WcHhLkYl6QPXsvQRB2Y4duhd43JJUcZ97KxFJKHD/IMDdxsWdJeqcWaPqX9KGpJAJ2
         LGRSJYtwcukxasvo4UThOYumC83uz7UNOKDKpBp7FZHQ6eWskcLIxieuQtRr8f+VqBKY
         +PJcSOWPQ/SCFqwKOy2Rs4ol48lCC8B7Sbix2uLQ4ef4E1nY4Q3TK2pnkg/WbUCBaLZH
         c+hYfCYd3fcFe/jIgmxTt/uRPIGkqRpD1uzk+v35gHufuYbOx05uR1DeFUtnaeVaw7hr
         vC3A==
X-Gm-Message-State: ANoB5pmgPNfO81TdlooPUHx2zgGl9LQEFgMVxLqu/Z2zFcOY5Z0o/hvp
        Y4lIj8Rxwm0iqo9zsUG7d6Q=
X-Google-Smtp-Source: AA0mqf7wqzv071P0x/mRXjpwael9ewocrXAjhS7lO6DJTDtlWHz7zdSkAz307rNNRRW624ZDI3KXTA==
X-Received: by 2002:a63:560c:0:b0:476:9983:b4b5 with SMTP id k12-20020a63560c000000b004769983b4b5mr6888328pgb.516.1668536944373;
        Tue, 15 Nov 2022 10:29:04 -0800 (PST)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7972f000000b0056bbba4302dsm9034046pfg.119.2022.11.15.10.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:29:03 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org
Subject: [PATCH 1/4] workingset: fix confusion around eviction vs refault container
Date:   Tue, 15 Nov 2022 10:28:58 -0800
Message-Id: <20221115182901.2755368-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221115182901.2755368-1-nphamcs@gmail.com>
References: <20221115182901.2755368-1-nphamcs@gmail.com>
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

