Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317B262EAC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiKRBMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbiKRBMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:12:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B8E85EE5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668733841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M2c5rXQnd1kf7yTmDBDfaoawKYfDXFaD9281dnoZiZE=;
        b=D/ZZJvo5cGIr+uUmeTgrRoZ0Ej9vbFPHSteEslytmFJOZyUHrbzacAJkje03m0a5a47Nhp
        +XDxndNjO/PCTUR6Yfso5ZHufW3VXigcEQJQ6kTAXx/qtKGUQt5FgHRP/HYlP3gcZQ5GOF
        GYAbE0FIVOfVk1JN6J1sSYH1bwjDIQs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-272-h8diT6NpMPWQEGn-3yAAhg-1; Thu, 17 Nov 2022 20:10:39 -0500
X-MC-Unique: h8diT6NpMPWQEGn-3yAAhg-1
Received: by mail-qk1-f198.google.com with SMTP id bl21-20020a05620a1a9500b006fa35db066aso4374387qkb.19
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2c5rXQnd1kf7yTmDBDfaoawKYfDXFaD9281dnoZiZE=;
        b=7yWfspinfoy205QeuuZsJqbV0QoX2AvGHQ34mJCCKxats5VON9jdguWRJnZ/mn6Cer
         XkgSblxXWEnzGdMuMSHpqjHN+PXqkkIGJ8m9jwNiFrZGEnGj1EOYtcxJhDMaYPwWC7KV
         P3tz5ab90PVOnxxYvNNMfxylldQOWCcVLOd9wHGzblq7aI75tal0uhZkT3i3uZYtRjg+
         6P/5zfe6vyIHlX18cfkJ6LN8iJ5r86mp3sh4nJwCTq1Cz9zCpNJrWanSHSGSFdkclcZT
         i09tvoJ21Q/f7XxWOZVpeqQdxkgJkXXWBE64hlcZ2e6envgrGgYOXWvrqxm1ogZEZcGA
         Xb1Q==
X-Gm-Message-State: ANoB5pnTFGNi1S4lpA3qP4OwevEouMy5LSAMCm6mCozpwyiUzoUPf12s
        EL3Xozk0tsNyPACTOfVN9Q18F6kv23X/5emHkZBH4894CDtbq8S9SnVGq3x5Tt9lCbsOh1beykg
        /p9mLYzycMEfXKqn5xRuu7nJW
X-Received: by 2002:a05:620a:10a3:b0:6fa:156e:44c0 with SMTP id h3-20020a05620a10a300b006fa156e44c0mr4093364qkk.293.1668733839362;
        Thu, 17 Nov 2022 17:10:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5KpYFuSckUVSGa4lgr9LFNowF9nCCUTnXJySXZCtSwHy4gRXenmckPtcF9nzTIBjvTUthQDw==
X-Received: by 2002:a05:620a:10a3:b0:6fa:156e:44c0 with SMTP id h3-20020a05620a10a300b006fa156e44c0mr4093352qkk.293.1668733839139;
        Thu, 17 Nov 2022 17:10:39 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm1491342qko.126.2022.11.17.17.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:10:38 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC v2 07/12] mm/hugetlb: Use hugetlb walker lock in hugetlb_follow_page_mask()
Date:   Thu, 17 Nov 2022 20:10:20 -0500
Message-Id: <20221118011025.2178986-8-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221118011025.2178986-1-peterx@redhat.com>
References: <20221118011025.2178986-1-peterx@redhat.com>
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

Hugetlb walker lock makes sure the pte_t* won't go away from under us.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5ef883184885..fc49e3ca8acd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6222,9 +6222,10 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
+	hugetlb_walker_lock();
 	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (!pte)
-		return NULL;
+		goto out_unlock;
 
 	ptl = huge_pte_lock(h, mm, pte);
 	entry = huge_ptep_get(pte);
@@ -6247,6 +6248,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	}
 out:
 	spin_unlock(ptl);
+out_unlock:
+	hugetlb_walker_unlock();
 	return page;
 }
 
-- 
2.37.3

