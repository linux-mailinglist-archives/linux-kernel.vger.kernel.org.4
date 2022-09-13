Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11EB5B7BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiIMT6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiIMT6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:58:24 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A507392C;
        Tue, 13 Sep 2022 12:58:06 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id q8so10090370qvr.9;
        Tue, 13 Sep 2022 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dgAC9wdSWdNnQd7c6lUo6ch6gbgfZ8Ik+m13B5omrFE=;
        b=pgU7qB1cfn3bbb6aqaPKVsP0QULztBXM6ZTdmlLajCShk8VBE78cxzG8Cv0iNse9pr
         raJ8GgLPcDyEkXzvMHViIvbgw2EPxCCCxmBWVydWXsbvHPXhV9LnTIQcxrhx+uvf4Xru
         5WYEg1qQVSMXl/Ik2LXwDiiTB+uN5XnQ7jp32HYymQ2HZJZADmguB3tnteKHk9qIukRc
         jpn8LdBlaPcxTkVAmOKzkV+NLvIVifwROYLBZ5KLKak/eoCCJdA+KloOJgYdmZJeYMVG
         xPc5vPtISXEXXxdKiktdhoBVSWbwV6cguyuU1u/JwyBG7hVEPpa11URawNPjZH6cK9Db
         YImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dgAC9wdSWdNnQd7c6lUo6ch6gbgfZ8Ik+m13B5omrFE=;
        b=B6u2/MEiC4pV8psVGPVSD88rjHk/IaFxLFt9DSmwztJxmOBOQ29whM6/9WL5oPgNju
         Ytwri3PoF0ssUebbuJc8S0sZLZzFZRI/aZtyV9JK6V3VFUPFfg8YLHEvMd6du48OYrSk
         Ea+C66o6ypmPRi/fSi6gvKMo8moBkr9/qBgTXhD35luusRvDsjnWWGc29uVC4X8YKslK
         uC6wHIidWuQmowN79vPl4MAWCtJWG33aRyClCK8tVyisEKmqxBlcHfHcvL01Jo/rSxWc
         gL/N6P2yaDJ4VM8v9oDUdYg9IPVkzqZ0f04Gfic3TpRHdodT6gifAxAssYMzGsCPxqKN
         g9lg==
X-Gm-Message-State: ACgBeo3yXKV81tjYZmKY4cxWDuvTmGVW/jcVwiycnZPmHVv4Yp85sQza
        iYVtOy1JxBKkbFeGu5TfnAE=
X-Google-Smtp-Source: AA6agR5N0IDxlcIGSy6m2BrDrpoJ44hk3cGJOE0+/g5noyEETZjDxRdlg2yegkHVtpvIIdmASzximw==
X-Received: by 2002:a0c:a901:0:b0:4aa:a283:ef4a with SMTP id y1-20020a0ca901000000b004aaa283ef4amr28465376qva.53.1663099085481;
        Tue, 13 Sep 2022 12:58:05 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:04 -0700 (PDT)
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
Subject: [PATCH 03/21] mm/hugetlb: correct demote page offset logic
Date:   Tue, 13 Sep 2022 12:54:50 -0700
Message-Id: <20220913195508.3511038-4-opendmb@gmail.com>
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

With gigantic pages it may not be true that struct page structures
are contiguous across the entire gigantic page. The mem_map_offset
function is used here in place of direct pointer arithmetic to
correct for this.

Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/hugetlb.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 79949893ac12..a1d51a1f0404 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3420,6 +3420,7 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 {
 	int i, nid = page_to_nid(page);
 	struct hstate *target_hstate;
+	struct page *subpage;
 	int rc = 0;
 
 	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
@@ -3453,15 +3454,16 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	mutex_lock(&target_hstate->resize_lock);
 	for (i = 0; i < pages_per_huge_page(h);
 				i += pages_per_huge_page(target_hstate)) {
+		subpage = mem_map_offset(page, i);
 		if (hstate_is_gigantic(target_hstate))
-			prep_compound_gigantic_page_for_demote(page + i,
+			prep_compound_gigantic_page_for_demote(subpage,
 							target_hstate->order);
 		else
-			prep_compound_page(page + i, target_hstate->order);
-		set_page_private(page + i, 0);
-		set_page_refcounted(page + i);
-		prep_new_huge_page(target_hstate, page + i, nid);
-		put_page(page + i);
+			prep_compound_page(subpage, target_hstate->order);
+		set_page_private(subpage, 0);
+		set_page_refcounted(subpage);
+		prep_new_huge_page(target_hstate, subpage, nid);
+		put_page(subpage);
 	}
 	mutex_unlock(&target_hstate->resize_lock);
 
-- 
2.25.1

