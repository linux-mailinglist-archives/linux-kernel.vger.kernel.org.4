Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC6A5EE496
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiI1Sqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiI1Sq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:46:28 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BE585FA9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:46:26 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s18so1084022ilj.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=LpxoywpaQZbEd7HNklvkbE+pBYLLyfSwOdEaf41jsQ0=;
        b=kWM/3CIyRI6nfI+De5JUNdFwTItNaQXTWqbDTabs6UaUl/0MCPJIFdwWe1TWp0THQt
         pyuVI/kmr0tZXHf86RfvoAy2tWcuMABnOLuW9Hx3mry5zD2o7haITtjPCiSFjM2w7SMk
         OmTU9AKIiMlvgQ/AS4vDI7wJt4dCTGI/izxGoJAXjKUgLrbtrQK0iFKQSvp8hiIE460w
         7K+IGuJlBsXOCkKO3CfPBBEq2dq75P1+C0RpyxQxXTccXXClJS6elMDN9J4+1PcOC1qX
         ni21VCsI+ZJbnh3VosmGkjkU06nDSzTiDMUgBqSuNo1eH1cMXYU7F2qVJRhcxfl2gC7G
         Ec1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LpxoywpaQZbEd7HNklvkbE+pBYLLyfSwOdEaf41jsQ0=;
        b=VtKsiwRWtAtPzIRLpq1XnvYLi5L2EbNjquq9nnMLrw6LBHD7HT5wd4XPk3iAhmnST5
         yBXozcMzT/M1JeM9X+GuyNMFaI16KnpeWJ3KWsrtt/xRRwxQH3ehNexnsdVi6LvySJYi
         MErQ/eh3t06pj1a3luspbt0AqogE1wJKJq4ONtBfCXR7N18CP9fAzfu+VJZqoA3AKdek
         nKyySg4FpFlnqvI7i+HRb5IgdiuM9s0tsL5hUbt/GPKeXor9CMuk3WGuSgfKrWvOIH/3
         53ZAJ4YROZD37kvU29h0rhjBiBIiqhkHdWnHKlYznTFJ/BuXfc48eIctW7P9gi7loiBX
         cL1g==
X-Gm-Message-State: ACrzQf3Cb7gz/xQqorKRENQ2STlHBcuoFBbgLxU9JxGv4m+xVzVXnZpV
        BNgIagpdhRpTft2gjQBw0Qkt3w==
X-Google-Smtp-Source: AMsMyM6KnMs6h0Vv/mW+gYrgQ8avvnHmbBJG/o6ac7PBd3Tr7J6tylm8KXP4s2KRm+MwddNuokxv1A==
X-Received: by 2002:a05:6e02:16c7:b0:2f6:6eb4:8df3 with SMTP id 7-20020a056e0216c700b002f66eb48df3mr16415870ilx.31.1664390785536;
        Wed, 28 Sep 2022 11:46:25 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:e132:6c29:fb2a:a1b])
        by smtp.gmail.com with ESMTPSA id cq5-20020a056638478500b003428c21ed12sm2058124jab.167.2022.09.28.11.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 11:46:25 -0700 (PDT)
Date:   Wed, 28 Sep 2022 12:46:20 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH mm-unstable v15 09/14] mm: multi-gen LRU: optimize
 multiple memcgs
Message-ID: <YzSWfFI+MOeb1ils@google.com>
References: <20220918080010.2920238-1-yuzhao@google.com>
 <20220918080010.2920238-10-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918080010.2920238-10-yuzhao@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Can you please take this fixlet? Thanks.

Fix imprecise comments.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a8fd6300fa7e..5b565470286b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5078,7 +5078,7 @@ static bool should_abort_scan(struct lruvec *lruvec, unsigned long seq,
 	DEFINE_MAX_SEQ(lruvec);
 
 	if (!current_is_kswapd()) {
-		/* age each memcg once to ensure fairness */
+		/* age each memcg at most once to ensure fairness */
 		if (max_seq - seq > 1)
 			return true;
 
@@ -5103,10 +5103,9 @@ static bool should_abort_scan(struct lruvec *lruvec, unsigned long seq,
 
 	/*
 	 * A minimum amount of work was done under global memory pressure. For
-	 * kswapd, it may be overshooting. For direct reclaim, the target isn't
-	 * met, and yet the allocation may still succeed, since kswapd may have
-	 * caught up. In either case, it's better to stop now, and restart if
-	 * necessary.
+	 * kswapd, it may be overshooting. For direct reclaim, the allocation
+	 * may succeed if all suitable zones are somewhat safe. In either case,
+	 * it's better to stop now, and restart later if necessary.
 	 */
 	for (i = 0; i <= sc->reclaim_idx; i++) {
 		unsigned long wmark;
-- 
2.37.3.998.g577e59143f-goog

