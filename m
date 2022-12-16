Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445DD64F1AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiLPTWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiLPTVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:21:53 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72D5B5B7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:21:52 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso7131163pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npFjL6Dds3DKnQo07iUTlbqXMaucW9/yvERNl8ZNQRo=;
        b=puCmKh+rn1JVyyUrtJjttd3FuNpbSs+RvZ8ZxzxDamK/Cuevoa4qtVifp0nUVsS9lh
         0su5AgtBOtGAeJcTOGyuWko0BwZQ7Hw6oQcDbbq9Y5NKHzQG9VITawrQHm9EI3qQUtXM
         AjUeShMh5cwQvSmrSrgxNusU8MJ0Ps5grqGE16Jv+htNHDWoIqXfzOF/h7F71mmC2Q1E
         NNvHAUFdO6YKiZApC81EFhAdwOFuqt2/XO3bAgLN5JBLh/DKhH01Xf0pI87uxLqwhDrf
         y630abcVgNDikwUEr0+Rj+UvB/s9o4pMrTtTDexj2Un1ME0s2kgTDdYZM42tUCJ8TC7f
         LBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npFjL6Dds3DKnQo07iUTlbqXMaucW9/yvERNl8ZNQRo=;
        b=Obkk7flr0mKrke+AxCgYnNI6yokflMAyrWMoZGJphLAESFODJdDoHgR1q6+NvOCgWI
         uy/zs4KDX5bkgeS1qAZV+/jNMRarpYi3wKh5nJMoF+jlrQLBCnVJ51Y4j9/lWTloFAfg
         k7hZePCPxLamKo23nCibO/SHgnqBPa3uDqJALKlAYBPLp0FiJS9cGkzTz5zgY4QGP4ft
         3RViG2UFn17ZBPFSFWv6uPv6wszX8NJtTCdSbB3NAaXg/KeCUR7Te7nNG/2S4aicTtjg
         5y5Y++t10JCx6EG3eAQ9CPmyHWZMcZdQgjBbkCsoxFDeJAJjhky0zn0vqzAULnPGoeuE
         S7RQ==
X-Gm-Message-State: ANoB5pk90vPRigK8anGB+mTmzDK+MHhjsDrpS6htrZgG+srl2A/stmDF
        Q4mp+XO1x6ykcwZRDBnix0s=
X-Google-Smtp-Source: AA0mqf5iiz7kn+rL8ZNVOrzT6DCoAp/rEnkSuQcxifioDG25jx57bGRL2eOaG2gjKzao6LEbgDEnXw==
X-Received: by 2002:a05:6a20:12cc:b0:9d:efbf:8151 with SMTP id v12-20020a056a2012cc00b0009defbf8151mr48168779pzg.26.1671218512074;
        Fri, 16 Dec 2022 11:21:52 -0800 (PST)
Received: from localhost (fwdproxy-prn-011.fbsv.net. [2a03:2880:ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id q20-20020a631f54000000b00476c2180dbcsm1814843pgm.29.2022.12.16.11.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 11:21:51 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v4 1/4] workingset: fix confusion around eviction vs refault container
Date:   Fri, 16 Dec 2022 11:21:46 -0800
Message-Id: <20221216192149.3902877-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221216192149.3902877-1-nphamcs@gmail.com>
References: <20221216192149.3902877-1-nphamcs@gmail.com>
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
