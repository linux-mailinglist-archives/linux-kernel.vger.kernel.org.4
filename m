Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA57F606A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJTVyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJTVyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:54:32 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470133FD55;
        Thu, 20 Oct 2022 14:54:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id f14so630316qvo.3;
        Thu, 20 Oct 2022 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShOyVALLWkkR4pnZbEXjhmF6LOSGNE0eOMv5EosjK40=;
        b=LmhsWLB5/8ER2JWGrAWt10ivNX62HhMvv1xr1WhLa8oIGbqE6gfaxeCqdv3/yMH1rg
         rupS1AoSzdDIE3sKhGSRgJ5JtZIE2Z00oJDsRRai1sGmU5SFhOf536G/b4t9VgZqOm8F
         +8bmWW2eKxJu2t/MLePJJ0YkKGitQ6cHO2DxfYvC2u+IkGry12ZDQ/MP4rOrSu4d0NBa
         MLgsBVxBgLZaAXLnaneL/ROAKOtw8peTXm6aE7CAIo2L/Hroz4ZJeq4htcoLmT07Awdi
         EIVo+KmLfCM/6yslbPviiQniqDYINEwRj+mLjivLeu4/7v5eVh8YdXUaSnwxQxIi1Kgy
         VU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShOyVALLWkkR4pnZbEXjhmF6LOSGNE0eOMv5EosjK40=;
        b=cf8mF6/vmPdHFRdKW3sMsOueoyEc75LTS8BejOiA8kFNKHYXtPTUatRfcwbCgHRQW9
         QiNDeLYroWRnrZ864iY9qOpVlkwTSMji1/EjSy6RAXX+REYzpDFaytzncIhO4brykbBV
         iT2iunS4WgonkU3hmL74pshuh8q1bqkPi6D/5Bwv22HJ9Jbwtw3a3Rxf/ZbDjBBkZgPX
         8mNm9QymVTC6KwKDfnFKtkJWCsuSTYpSX4LlmH9Q2z3A2VjNjcK4Rg7tI18q62CoUR9M
         RmKb87gtk0XbNWM2/hrnSoUJvvWdjMyPGO1Z0rJVu9fzAz/F7iHB77ecxhbf+QDBcgVY
         ++9Q==
X-Gm-Message-State: ACrzQf3cjF3TEIqwJ+CIIvidv4BSyiwmjcHMTmJl8qofuVvw+h2330z7
        cn0qsg0wY9omwtofmF3sIFY=
X-Google-Smtp-Source: AMsMyM4hvvi4L9JYqaXZOTFe/8FS+MJ1R0MvB72qG3wAneUbZ7hAzYBbeQWK/BxtpwbfBfx5iBtOJw==
X-Received: by 2002:a05:6214:20a8:b0:4b3:d99f:2588 with SMTP id 8-20020a05621420a800b004b3d99f2588mr13740927qvd.64.1666302867022;
        Thu, 20 Oct 2022 14:54:27 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006bb29d932e1sm8121067qkb.105.2022.10.20.14.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:54:26 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v3 2/9] mm/page_alloc: calculate node_spanned_pages from pfns
Date:   Thu, 20 Oct 2022 14:53:11 -0700
Message-Id: <20221020215318.4193269-3-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020215318.4193269-1-opendmb@gmail.com>
References: <20221020215318.4193269-1-opendmb@gmail.com>
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
index e20ade858e71..92908c51f1c3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7542,7 +7542,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 						unsigned long node_start_pfn,
 						unsigned long node_end_pfn)
 {
-	unsigned long realtotalpages = 0, totalpages = 0;
+	unsigned long totalpages = 0;
 	enum zone_type i;
 
 	for (i = 0; i < MAX_NR_ZONES; i++) {
@@ -7573,13 +7573,12 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
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
2.25.1

