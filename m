Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B236B56D1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjCKAkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCKAjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:39:52 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75F711F61B;
        Fri, 10 Mar 2023 16:39:51 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id s12so7688809qtq.11;
        Fri, 10 Mar 2023 16:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678495191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21XWFqZKFhrw7IqRe7YpT4TCzw//2tpfFn1az0nze7A=;
        b=H0fDFIKrE+i4ootQK/33BZNQZIOFe5T2gXr49E41EzK7+v+nPMZu5ce7GQgvufox1r
         xofMSL1BtQS45kz/SyzPCOerPL6qsYRi0a6twooP6fAdZu2ZRX08kGWmrLZ7Z0zZSTZP
         q+UEKBCQTwBEJR6r7gXIwUeRd0wTaMWuxQ3AU3IKjs4i6DE3h4QiwCXwnyrg4hJfR9Fa
         OqS3WXoZcjVB0XhOmr7mqX1611c4J16sjcN1h+t7gR00matvjm9r+0NLXtlYAE//yMF/
         M0fUUbTDdeXlerycqwdx/xfIlphKCqHxxm1rGe7SLvvTxgx6cxy15SvFrAbj2TA/Q5VH
         y60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21XWFqZKFhrw7IqRe7YpT4TCzw//2tpfFn1az0nze7A=;
        b=B7V3CrQcSemazJN7jDm84LMKUc3/gAAK/Oc2xIi33syeFgJCvrnhxx5Rgs9ZIlBCD1
         Xt/gzA94w6PBN8z9x6DbMg9RRNeg7qr42Ead6FoFd6s6lh9Exh67jHRIcfpkqBidrQL/
         xFxPjntuGYp/RJ+fmC8Iq4FZ27QNC+B/Shm9iDB5Gg8c+tuc29A6jMZyqXaydLqj52Eu
         2fZDq6EKynrLDiPJMsA6uJPmFy+hPRo66/KHz/I1w8gEj7Y3ic6ubPDff1wYBd8QcWsB
         XIJksaAIL8FoHQ4YsGclVXDFnGCxxTLOUAbEfLmjHtSIC8VoWSTVbZ6KKsNCr9jD82E8
         5FNQ==
X-Gm-Message-State: AO0yUKX8dT8woiYyit7f1wLQgIF0KX5BTQNcjjjedSTAap/ekZREF13z
        MKLxs5KiR6YBqWDnOTP+LvU=
X-Google-Smtp-Source: AK7set+uqKakBULmDoJ5Xr6lerX7tivt8yOC0pEZoZHG6hVLZ77mTu5fc8Qx1J0t8jZ7dQbCVw6tHQ==
X-Received: by 2002:ac8:5ad5:0:b0:3bf:a3fc:c70a with SMTP id d21-20020ac85ad5000000b003bfa3fcc70amr46750078qtd.28.1678495191044;
        Fri, 10 Mar 2023 16:39:51 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020ac84345000000b003bfaff2a6b9sm868874qtn.10.2023.03.10.16.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:39:50 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        "Georgi Djakov" <quic_c_gdjako@quicinc.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v4 2/9] mm/page_alloc: calculate node_spanned_pages from pfns
Date:   Fri, 10 Mar 2023 16:38:48 -0800
Message-Id: <20230311003855.645684-3-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311003855.645684-1-opendmb@gmail.com>
References: <20230311003855.645684-1-opendmb@gmail.com>
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

Since the start and end pfns of the node are passed as arguments
to calculate_node_totalpages() they might as well be used to
specify the node_spanned_pages value for the node rather than
accumulating the spans of member zones.

This prevents the need for additional adjustments if zones are
allowed to overlap.

The realtotalpages name is reverted to just totalpages to reduce
the burden of supporting multiple realities.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/page_alloc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ac1fc986af44..b1952f86ab6d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7586,7 +7586,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 						unsigned long node_start_pfn,
 						unsigned long node_end_pfn)
 {
-	unsigned long realtotalpages = 0, totalpages = 0;
+	unsigned long totalpages = 0;
 	enum zone_type i;
 
 	for (i = 0; i < MAX_NR_ZONES; i++) {
@@ -7617,13 +7617,12 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 		zone->present_early_pages = real_size;
 #endif
 
-		totalpages += size;
-		realtotalpages += real_size;
+		totalpages += real_size;
 	}
 
-	pgdat->node_spanned_pages = totalpages;
-	pgdat->node_present_pages = realtotalpages;
-	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
+	pgdat->node_spanned_pages = node_end_pfn - node_start_pfn;
+	pgdat->node_present_pages = totalpages;
+	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, totalpages);
 }
 
 #ifndef CONFIG_SPARSEMEM
-- 
2.34.1

