Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE45612D03
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJ3Vbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ3Vb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B183A460
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667165391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WBN8D9wCQW9wV7A+8u6L08Ik6RBdolsM1Jhl7A7rc8s=;
        b=ZhXgywEZckyh/r+RrUqDGLSPPPKpNRQzaTne4j2fbKtwcs6CTh9BRCFjKReRG+97gk/YN6
        On14FKxHkryyMUxhP8tMJ1BXG8pF7Pw72O1f/11hDHwPwbKXX06vu2c2v1RdxizTlSHXJ5
        AEu2lZcn9sMIS0Js8PRoFm5wEUwnw5o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-329-11DEyvRzPSy2VC0YzWNAuQ-1; Sun, 30 Oct 2022 17:29:42 -0400
X-MC-Unique: 11DEyvRzPSy2VC0YzWNAuQ-1
Received: by mail-qt1-f197.google.com with SMTP id i4-20020ac813c4000000b003a5044a818cso4846994qtj.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBN8D9wCQW9wV7A+8u6L08Ik6RBdolsM1Jhl7A7rc8s=;
        b=cuUwJid9F63Y3MikCKhQEDEQIYvrgwoEpsPz965MHb8cwz13K2DsE+yUPRhz7eAXz1
         nBkwnX1Q3/E0VJpya58Njr4QlwBlbphGUnOUU6bdMRNA74jiKoSg6sUkFOUi32Y8U1nP
         Huq7rBKL4DAmrsg+/3apcQcMED/daYjMGLZVQ/Gb603cGRursZsNEYpgokTcB7skzu4Q
         2kQc9L7Wao0S0sVHRyQKQ9m0luW7USWWCDQZ+coGx8MrNyKHxix2blUnc24Uo6fOGGF+
         xywS2xvKH/yoPEU9JvTZNve86Wyh7unKuGkosRokI8SZvAd2S70nlpRxVWdfykaT+1qH
         ZIWg==
X-Gm-Message-State: ACrzQf0Qx+KKu+jdSjEPhf5TCbyKY9z7sCQexYfQpDKUFiDeoqVr1cJr
        9B3Y89hK4CwjoEX6SMRfrtv7wqixLKIOHC1PwjilzYEIIuBnJgLMbyb+x4PcBuMX8fh6/bBHej3
        y2r+ukztPKmrcFVO5oz1XeTY3az2gm8YimCVl4htRRSvJ1A5loGCl+osgkK7LefF7gHFKPk0B9Q
        ==
X-Received: by 2002:a05:620a:404d:b0:6da:4b51:2a8f with SMTP id i13-20020a05620a404d00b006da4b512a8fmr6987364qko.421.1667165381984;
        Sun, 30 Oct 2022 14:29:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM42RXOVz0QArfSJMlSE1Zpcejb5AA8L6KVh4LIIheRuXu9MXkBezCcPcA+vujWAM+SNNHsPqw==
X-Received: by 2002:a05:620a:404d:b0:6da:4b51:2a8f with SMTP id i13-20020a05620a404d00b006da4b512a8fmr6987344qko.421.1667165381708;
        Sun, 30 Oct 2022 14:29:41 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id a1-20020ac81081000000b003a4b88b886esm2654781qtj.96.2022.10.30.14.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:29:41 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH RFC 06/10] mm/hugetlb: Make page_vma_mapped_walk() RCU-safe
Date:   Sun, 30 Oct 2022 17:29:25 -0400
Message-Id: <20221030212929.335473-7-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221030212929.335473-1-peterx@redhat.com>
References: <20221030212929.335473-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU makes sure the pte_t* won't go away from under us.  Please refer to the
comment above huge_pte_offset() for more information.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/rmap.h | 3 +++
 mm/page_vma_mapped.c | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index bd3504d11b15..d2c5e69a56f2 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -408,6 +408,9 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 		pte_unmap(pvmw->pte);
 	if (pvmw->ptl)
 		spin_unlock(pvmw->ptl);
+	/* Hugetlb uses RCU lock for safe access of huge_pte_offset() */
+	if (is_vm_hugetlb_page(pvmw->vma))
+		rcu_read_unlock();
 }
 
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 93e13fc17d3c..513210a59d7b 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -169,10 +169,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		if (pvmw->pte)
 			return not_found(pvmw);
 
+		/* For huge_pte_offset() */
+		rcu_read_lock();
+
 		/* when pud is not present, pte will be NULL */
 		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
-		if (!pvmw->pte)
+		if (!pvmw->pte) {
+			rcu_read_unlock();
 			return false;
+		}
 
 		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
 		if (!check_pte(pvmw))
-- 
2.37.3

