Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056B6612D02
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJ3Vbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJ3VbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D263EA45F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667165388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6JldXIZ0VovVxqs2u1isjA5hu6yU0tGljewUccwkM0U=;
        b=ZWfAMV31AnIrzdaOb4rmWP1Uph4sW7jnjx2J+58PQTS7/7ZqFZXefJV0ASj2Ln64JwH+W1
        UVkTT9ozXnEqFZ9+i39uFuJ2bIIkodpQwxPrCnMgV+Mx4v1jisLwYsSh0WaNfFOgp3U/tC
        a1gaWA/8Nj7d0DFpcsgI9IMib91HWiY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-403-avLD5dvBNOyjZvKtLIGT4g-1; Sun, 30 Oct 2022 17:29:45 -0400
X-MC-Unique: avLD5dvBNOyjZvKtLIGT4g-1
Received: by mail-qt1-f200.google.com with SMTP id cj6-20020a05622a258600b003a519d02f59so2054879qtb.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JldXIZ0VovVxqs2u1isjA5hu6yU0tGljewUccwkM0U=;
        b=Xy1GfrLV7UFXKExE+0SEL+isZXHJT/z0gZgnimV7rZsp5X0p8AxF1qmIkXoW4vzuuE
         bkqYPi2xJtAr+jfuV85kRxWg8EhQGy/BculYMlE3zMi9bGfDV6sX+gPZ2sD7qhPuqnfi
         YAOAIzmrPvF2oDEjB9nw6j2k2gzTxzYoRB+zBUlXSic1yVv2nLCXSHG73unyIBR+Hoe1
         bBT/QTmi0it8ykulJ7KrdAVZjWy3cVM3Pk6ZV3Ll44799JBpCs3a2t7+I/vt+RbTJb6B
         f0xf2Y7jZ0k1VAniISk5zSRj3temz4R1adPLv+YusplnDjLesPacytoA16wo/MqiDEpj
         mzwQ==
X-Gm-Message-State: ACrzQf399OaEj9q7NPh7iL4LEpn5NnJIQXBZJwYCzpZlGkJGF+3tZx+Q
        UXUZx+r/hyi129Kei7O/Fym39nJpST8Io5qqu5JsFPvlwTlF8Nm0IPK0ouFX0MQbfhg5hRAoal4
        TBrxXWgAyVIcaCr8BKb9YD5z1Y9/W9AUp9MhMFXQNmcqymoCdH2bpwejCdSECQo2XjDLG/gmxbA
        ==
X-Received: by 2002:a05:6214:1c09:b0:4b7:f9f6:7d17 with SMTP id u9-20020a0562141c0900b004b7f9f67d17mr8720827qvc.22.1667165383360;
        Sun, 30 Oct 2022 14:29:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5VT0YcB2KUeD0RxKSYpx27URr0maKrp8Ghgz9I1abNoV5z97NF2ZhVFfbknBYsc6tbah94rA==
X-Received: by 2002:a05:6214:1c09:b0:4b7:f9f6:7d17 with SMTP id u9-20020a0562141c0900b004b7f9f67d17mr8720803qvc.22.1667165383128;
        Sun, 30 Oct 2022 14:29:43 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id a1-20020ac81081000000b003a4b88b886esm2654781qtj.96.2022.10.30.14.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:29:42 -0700 (PDT)
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
Subject: [PATCH RFC 07/10] mm/hugetlb: Make hugetlb_follow_page_mask() RCU-safe
Date:   Sun, 30 Oct 2022 17:29:26 -0400
Message-Id: <20221030212929.335473-8-peterx@redhat.com>
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
 mm/hugetlb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9869c12e6460..85214095fb85 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6229,10 +6229,12 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
+	/* For huge_pte_offset() */
+	rcu_read_lock();
 retry:
 	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (!pte)
-		return NULL;
+		goto out_rcu;
 
 	ptl = huge_pte_lock(h, mm, pte);
 	entry = huge_ptep_get(pte);
@@ -6266,6 +6268,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	}
 out:
 	spin_unlock(ptl);
+out_rcu:
+	rcu_read_unlock();
 	return page;
 }
 
-- 
2.37.3

