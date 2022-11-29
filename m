Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBA063C893
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiK2Ti6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbiK2Th3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:37:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952C15917E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669750544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tlgp91ck5zE/ROfq0OY9j8l1q/C3T3fwuEiiEDoRd8M=;
        b=PLmp9qAAVoXZ/DLCrhHauwbfIJ8eucPnqbLK/nRBJIKfSy2xRYyOfG9cpnvH4yNsOCxf60
        ONlKONJCwUJht1zh2iZ82SSNfzcMDGnyIEYpeBPBqEMkp7MCCQCSIvZDQqthMmEHJpg43b
        9OyN7osSfnd1FAHdBbWORvnupPB2HUQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-6Mz9jCuLNK6tvdNUgjXp2w-1; Tue, 29 Nov 2022 14:35:43 -0500
X-MC-Unique: 6Mz9jCuLNK6tvdNUgjXp2w-1
Received: by mail-qk1-f197.google.com with SMTP id u5-20020a05620a0c4500b006fb30780443so32368012qki.22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlgp91ck5zE/ROfq0OY9j8l1q/C3T3fwuEiiEDoRd8M=;
        b=lWfkIv9xg8ZejBv4f/6TxbEFtPTmtTJQhuFtb0mA6ngyiFi9eOLCwYX7bKa849ZW5r
         vw0KTQFp9XXfCAJhd8JZ4ECUv+Cs3PFq050gxKhdS4PWKB9cy+i0FMf+XIkyVUNTwvPX
         yTA8MlD/RWK1tBUw+vOJ41Y0VCXuu7Vs5Rn+eDmvxlBF3s3VOgtK4GDI3wbnWfLXME/M
         kakemfAKk3N/R3sUuQDPM7G/HCwCgNtIzg2j70OAvzhRYP03smopomcvKTm335plKh1K
         lqYTT5LLwtzZd38ceCAv5SVshAUjD9F5duU/dySEIbdLU5e5n17Q4b90t2D7HUdcnF02
         +13w==
X-Gm-Message-State: ANoB5pll1dXkrF4iD7lPIt4RtIeXwNBlYmGoJwfBKj1GNgSi6QkrP1Hq
        6RnwMuBfiF5xrJ+xY8OXjlx7q+OF292wZ2rJqlxlFVhK22ZarBKgfIZ7/9qo8giEJeozByz/Wgg
        NPyTwmRvaGoNFsJUFm4QhNXXZ
X-Received: by 2002:a05:6214:3607:b0:4c6:fb3e:4993 with SMTP id nv7-20020a056214360700b004c6fb3e4993mr12852435qvb.110.1669750542529;
        Tue, 29 Nov 2022 11:35:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4xmfsUZVgeiYSekMVU4CvYl69LMLxbBsqa8kFerZrz4PcOvOhvTZpsuJGzn4pvxETRAceDKA==
X-Received: by 2002:a05:6214:3607:b0:4c6:fb3e:4993 with SMTP id nv7-20020a056214360700b004c6fb3e4993mr12852419qvb.110.1669750542285;
        Tue, 29 Nov 2022 11:35:42 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa16fe93bbsm11313013qkp.15.2022.11.29.11.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:35:41 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to pmd unshare
Date:   Tue, 29 Nov 2022 14:35:24 -0500
Message-Id: <20221129193526.3588187-9-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129193526.3588187-1-peterx@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
to make sure the pgtable page will not be freed concurrently.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/pagewalk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 7f1c9b274906..d98564a7be57 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -302,6 +302,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 
+	hugetlb_vma_lock_read(vma);
 	do {
 		next = hugetlb_entry_end(h, addr, end);
 		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
@@ -314,6 +315,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 		if (err)
 			break;
 	} while (addr = next, addr != end);
+	hugetlb_vma_unlock_read(vma);
 
 	return err;
 }
-- 
2.37.3

