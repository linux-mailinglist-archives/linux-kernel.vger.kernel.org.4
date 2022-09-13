Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B0C5B7BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIMT7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiIMT6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:58:36 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64C874CE6;
        Tue, 13 Sep 2022 12:58:28 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id s9so7062214qkg.4;
        Tue, 13 Sep 2022 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kefl6D8eKpN1GxKRqpPd+2PbW8yMD7NaxrgEOy2EJKU=;
        b=byR/eekYsW9DhH0NqLev2fS+tpkFMN+hxgB8j3wmXvKTocIMCm6zZesYvYgQ87wjhP
         q+4AfKw8TXxcj2+vnpVcn5ECPh4qGk7Jtzj+zNbyb6YCFLIiwPOzRUIUuAqm/vme1CGD
         HXFFRmWffOsc2lXoXpa+V0KHw2MwGlrFjaT+dLfIFP4Da4Lspw/3GTIWmZkSLzazc/cQ
         hUYdezyBusY92UGvKeXjT7Rg0vsemlXyaK6ln+reN6yeiO3uNu7F3nGVR2B+OsucHch6
         d5MKRdQDkKjHro2ts06Z/prjBlf3W1AQZuN3IrXE7aLh74QN4KD+aUTWaAkLm41rgl56
         mOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kefl6D8eKpN1GxKRqpPd+2PbW8yMD7NaxrgEOy2EJKU=;
        b=pxILh4RiPrkaLKWtwcO0Stiql600sgOP4HLqmk9oo8eEU9flyY8wE9iF6hahCeU4kU
         BgQrrntlmdJOTU0LWOqmn1MZ1o6/AhMI80fAkQZCq1SOXmIOxOrnLCUeSN/7BKjWrNKw
         L0+CNoG6rdkEn2CaBtz3TDYC3GyJMgIu57FUXe4vDWuqCle0fY/BLuCDJ9OggJOklSAD
         U2f2SPFlS5jzDtwEbShQgfxFCfFbhM8r8r0BfBM3W2y9IbjDyW37iEAsmCu8lkdqNy2f
         RUzvFwhFR/HQEDDGdJoESoFb+EzX+1cfFnsYrJhBxnvrZsL+BLZ+qSupdiVMsSN0YPfT
         Ruzw==
X-Gm-Message-State: ACgBeo0+TIBXew2b9EwIELFX2rXqbBjea6U+B2Fcz+zZa1MrWuOlAEYA
        l5lhjXkWmfzpSCl7iUNeF8s=
X-Google-Smtp-Source: AA6agR4kCtYZpwUOe+kdoRL5XUeDY9Udr6YA+L+RrDdkM+ZkGSBIa8BGCY7yWmaW8ey8FgVIise+hw==
X-Received: by 2002:a37:916:0:b0:6ce:5f1c:d5d9 with SMTP id 22-20020a370916000000b006ce5f1cd5d9mr5678519qkj.737.1663099107720;
        Tue, 13 Sep 2022 12:58:27 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:27 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: [PATCH 09/21] mm/page_alloc: calculate node_spanned_pages from pfns
Date:   Tue, 13 Sep 2022 12:54:56 -0700
Message-Id: <20220913195508.3511038-10-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 6bf76bbc0308..b6074961fb59 100644
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

