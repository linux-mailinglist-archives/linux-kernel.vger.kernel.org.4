Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99405647746
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiLHU2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiLHU2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:28:12 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676771A393
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:28:11 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v3so2094665pgh.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npFjL6Dds3DKnQo07iUTlbqXMaucW9/yvERNl8ZNQRo=;
        b=PtrML52y4++BjkDz048pa6CUOhJB/mkeWNTiPY7aI2UbgF7O0oTXxRSB+Rgt+XOkh2
         IhRH1bB7exc+5heFlRaaYr1yjjAwmfAuerp1aWipjPeaCOdr512Ka1FELYXazYxmhQEi
         SI7xS7B+WXTt+l2S403kfG2hbvrX5IAdut2oWDHfpaLlRGt4YV6g6R2N/Y+M0OIVauM4
         yspqne9tauDtNmi+n/6QI2qbmUkn/MYPIpdZcxb09OW88KyKsov7q5fHtFuGQCLf0/61
         TA66+MiESyfsohxgdTOk04PCX9QDVLvzcic6TUKUmrBvMvg3B2oikbP6Edti5vGkX47C
         FKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npFjL6Dds3DKnQo07iUTlbqXMaucW9/yvERNl8ZNQRo=;
        b=DEEF5/dipw5Hh246PyqBnqvgovp5j+uvvo5nHgi0upHSbxxvz/TJiCNqCkcRMC6qPp
         7aTOQS9p+t34OiObzTnIPwKuQRb6evZ6/25XXUNrYMmkIyXWN4sbIhfNQ66NHRUCzBKZ
         bvDtaLsthsSba4Be/N6W1xvsV6GORzDhjmth9NFHsqjm2/n2qW3/beRnwz54KFbmRU2l
         Zp+KSH4XhNFENz3fJH+WsrLjLzE1GgtejYeyWn0guYD0aBiRB/K4NtiFY8jQW36/xXre
         dwiIqKud114803EITbEBtT0XpYdP2KpXKObymaoOzH18v+mQtdyJMU6i9uLaBB8ySViq
         gPfA==
X-Gm-Message-State: ANoB5pnL7kDGzNnHoRgn4gZxfMuKJbmQSUNh7uHzUkZR1jUYgKx3p/Td
        51pbXG8DgQpOrNYg7tFymkM=
X-Google-Smtp-Source: AA0mqf4PzirRAa+DHb5HDZfpPwkKugYCrcQU4IMR06a44BnH7VGJOBKJqvkTVtEYWESsKuUDvBw8gQ==
X-Received: by 2002:a62:3142:0:b0:56d:8d19:f331 with SMTP id x63-20020a623142000000b0056d8d19f331mr99706326pfx.7.1670531290779;
        Thu, 08 Dec 2022 12:28:10 -0800 (PST)
Received: from localhost (fwdproxy-prn-008.fbsv.net. [2a03:2880:ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id b29-20020aa7951d000000b0057555d35f79sm15702101pfp.101.2022.12.08.12.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:28:10 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v3 1/4] workingset: fix confusion around eviction vs refault container
Date:   Thu,  8 Dec 2022 12:28:05 -0800
Message-Id: <20221208202808.908690-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221208202808.908690-1-nphamcs@gmail.com>
References: <20221208202808.908690-1-nphamcs@gmail.com>
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
