Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56F95EE96B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiI1WeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiI1Wdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:33:54 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0EAF9620;
        Wed, 28 Sep 2022 15:33:52 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w2so8855253qtv.9;
        Wed, 28 Sep 2022 15:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cdp6gKq67l8BHxfvYyqMmk5Gv7X6BRjPu/o7++6IXk0=;
        b=URRpeJBFdppH8e/fE8Zn7u382jDrgAPrKGhvy+7Q9UV2n6l9mlnKvfUaPasfPDJqgk
         CD+pbglEc1OI5Fj/Ci2WqTozLVEtwoShQNGOrjiQFjdUvELjoZQctEpQ0qJlyiY1tPms
         mCJNKHtApeVTyeFWznRhP/VEmF+PEBVfL0Wj6h7o2eqTX4N+Rwbn+bTA29OKo7/TjhZr
         oFtvm1ZfUUbyXsguDLLXRWV61hzGuJRFQ3SHrca2K/fo6GpbBESMus7lg6s82a/2Xses
         6HTILxedb1ZkW+eSgwHqH81i1xdlpXFU+5urGqxgxYDlYtqfNTdk8gQDSt36m8RjOxql
         PFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cdp6gKq67l8BHxfvYyqMmk5Gv7X6BRjPu/o7++6IXk0=;
        b=oZcPVxuDEp4CWnHiUI4KPXN2QJ04Mg02WBfFG+RSBRxnLBrxU3Bv5AWk67ecW7VazB
         CJ0b5IXsoD38CuJrp9Oa11cL+mvO89htFDzWulixSRP1hZLLYmI+APdGNBQwDRZg7RqI
         Bc5CmuKVJZzMSW+TKhwPa6ODwXWrOxNnQqpLh6+4BDoFXcO5n9J46hh2fyY1PGebjgAR
         OFzKMCaS6Pwlc6w770w3/16EnwxUI7lqu89rMYuYyM8GN5gO3AuKmdlQn6pAPQs38SU+
         kqS8/EEIFR3DPdVGCVhx6uE4J36q+K0oi+3Ofj3TT7yp+io4FwRtjSYsFhUIe80lf79t
         fISA==
X-Gm-Message-State: ACrzQf2ZmZNwoQIxaCDc9I0sPXTFMs8weC4WOtQ0mzQsFllFZ13ENTPE
        YSGdOWTDIeqyHcp6+MBRzIE=
X-Google-Smtp-Source: AMsMyM5HlDloR0Q6E7bhHNQx3py83nBExasTaOUqKPuAI2ERKE88ypL9nf6ynZrpI0Y72+pqvQzwZg==
X-Received: by 2002:a05:622a:190b:b0:35b:b5a2:eceb with SMTP id w11-20020a05622a190b00b0035bb5a2ecebmr25196qtc.529.1664404432585;
        Wed, 28 Sep 2022 15:33:52 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j188-20020a37b9c5000000b006bb83c2be40sm3963481qkf.59.2022.09.28.15.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:33:52 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v2 3/9] mm/page_alloc: calculate node_spanned_pages from pfns
Date:   Wed, 28 Sep 2022 15:32:55 -0700
Message-Id: <20220928223301.375229-4-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928223301.375229-1-opendmb@gmail.com>
References: <20220928223301.375229-1-opendmb@gmail.com>
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

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/page_alloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d47406e..3412d644c230 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7452,7 +7452,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 						unsigned long node_start_pfn,
 						unsigned long node_end_pfn)
 {
-	unsigned long realtotalpages = 0, totalpages = 0;
+	unsigned long realtotalpages = 0;
 	enum zone_type i;
 
 	for (i = 0; i < MAX_NR_ZONES; i++) {
@@ -7483,11 +7483,10 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 		zone->present_early_pages = real_size;
 #endif
 
-		totalpages += size;
 		realtotalpages += real_size;
 	}
 
-	pgdat->node_spanned_pages = totalpages;
+	pgdat->node_spanned_pages = node_end_pfn - node_start_pfn;
 	pgdat->node_present_pages = realtotalpages;
 	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
 }
-- 
2.25.1

