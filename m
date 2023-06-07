Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356CA726984
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjFGTJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFGTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:09:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909231721
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DC1564300
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 19:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4955EC433EF;
        Wed,  7 Jun 2023 19:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686164980;
        bh=6dtKuXV2nXZXQRpqAxbQFyVi9qyFYTAFk5MrNR013Ts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PnV1yt+iqLBH3jR5kuNY9n1RF0i8vSUcbzOkVpRudAVvqEVYDFHJWJv1sK0KcI8Fk
         0Lei0xwn1WHAKmiGGcIZVSOj26BaWu8mtT3YvnG1b+sNZ/6t/78JM3wPhqZ5OM/0it
         IQQ9hYseyVP2EFdHepJrgHG/pmqDmOT4tBxewju0=
Date:   Wed, 7 Jun 2023 12:09:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zswap: do not shrink when memory.zswap.max is 0
Message-Id: <20230607120939.c1256fac4bb4e081811c02da@linux-foundation.org>
In-Reply-To: <CAJD7tkZUc=h+h4f1a+nas8KruFBaGMuaq67jZLk+LkdbwZVqKQ@mail.gmail.com>
References: <20230530162153.836565-1-nphamcs@gmail.com>
        <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
        <CAKEwX=OK5qK9DTYLKZUefE0eq8KooygT-nbkgUZaYjK72SKzFQ@mail.gmail.com>
        <CAJD7tkZUc=h+h4f1a+nas8KruFBaGMuaq67jZLk+LkdbwZVqKQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unclear (to me) whether we should proceed with this.  Thoughts, please?

Here's what I presently have in mm-hotfixes-unstable:


From: Nhat Pham <nphamcs@gmail.com>
Subject: zswap: do not shrink if cgroup may not zswap
Date: Tue, 30 May 2023 15:24:40 -0700

Before storing a page, zswap first checks if the number of stored pages
exceeds the limit specified by memory.zswap.max, for each cgroup in the
hierarchy.  If this limit is reached or exceeded, then zswap shrinking is
triggered and short-circuits the store attempt.

However, since the zswap's LRU is not memcg-aware, this can create the
following pathological behavior: the cgroup whose zswap limit is 0 will
evict pages from other cgroups continually, without lowering its own zswap
usage.  This means the shrinking will continue until the need for swap
ceases or the pool becomes empty.

As a result of this, we observe a disproportionate amount of zswap
writeback and a perpetually small zswap pool in our experiments, even
though the pool limit is never hit.

More generally, a cgroup might unnecessarily evict pages from other
cgroups before we drive the memcg back below its limit.

This patch fixes the issue by rejecting zswap store attempt without
shrinking the pool when obj_cgroup_may_zswap() returns false.

[akpm@linux-foundation.org: fix return of unintialized value]
[akpm@linux-foundation.org: s/ENOSPC/ENOMEM/]
Link: https://lkml.kernel.org/r/20230530222440.2777700-1-nphamcs@gmail.com
Link: https://lkml.kernel.org/r/20230530232435.3097106-1-nphamcs@gmail.com
Fixes: f4840ccfca25 ("zswap: memcg accounting")
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/zswap.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/mm/zswap.c~zswap-do-not-shrink-if-cgroup-may-not-zswap
+++ a/mm/zswap.c
@@ -1174,9 +1174,16 @@ static int zswap_frontswap_store(unsigne
 		goto reject;
 	}
 
+	/*
+	 * XXX: zswap reclaim does not work with cgroups yet. Without a
+	 * cgroup-aware entry LRU, we will push out entries system-wide based on
+	 * local cgroup limits.
+	 */
 	objcg = get_obj_cgroup_from_page(page);
-	if (objcg && !obj_cgroup_may_zswap(objcg))
-		goto shrink;
+	if (objcg && !obj_cgroup_may_zswap(objcg)) {
+		ret = -ENOMEM;
+		goto reject;
+	}
 
 	/* reclaim space if needed */
 	if (zswap_is_full()) {
_

