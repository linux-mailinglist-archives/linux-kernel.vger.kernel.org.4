Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ED365E8D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjAEKUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjAEKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:55 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62788551C9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:17 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g9-20020a25bdc9000000b0073727a20239so36033610ybk.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdV3IYpedDoNM7qUi7kHNJzHPxVnQ9DxeM3hKKmcY9U=;
        b=DiSQp6yj/Jffb5ePxq8rLXfWEn0QKWirG+DC/Z+7i72DYO+nh0hgIQIWulypFbtBD0
         CNXALjMtPUpaNYD+K9/Wtem86znsi9S0XhhVza6MwF9b0Ah41Zx62xgpk0EqpvxL45Ez
         twNhGjN8owfKEsoU0pxg3/ZHYJoT3u5nVxsT0weZJKuU5bHZEEigDexGz6ip4UrCMr3u
         3a/kheO+Wz2ofksSCLNRFL/BR4OqsTuwZPgS6RFEg5mlXviTOOl8DGf/P5TUOJfu8Kz5
         jKgiNh/96tLer8BEZqipSxoSlnT5zdxZozrvn3a/BmqSquCXcaUJoYHENLG2wGTwjIMH
         H8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdV3IYpedDoNM7qUi7kHNJzHPxVnQ9DxeM3hKKmcY9U=;
        b=ct9ChEO9CEnD0kY8vp2yGudpbEsESguOxQe1vrvdYdb6lwO9Fcy8NWiP5Q2x6K5Cun
         dWthLGbs667XLp/21CpQJW2JdTG6IMJkSLJfGJ1/QQpEVPgQxgJRE70OBcxjkq9dC37a
         fMZwdyVboex/2tT8+Vw8HtjP70sKIylqrniyXLgZGpuFDZBoQ91gp/51tqTF6rg5zVeD
         Amba1Q5bIsmNXsmWe44+tG1hsVP+JMU6ohhVLHmlsa+/i8v9sKyJZY7UJ3VDucn8Xc+Q
         fMsvuBwqhWoS2m+uYTNqiaOcsVxvEqONAQlRUqE4WeCzO90qGNkQjpFgN3N31Z8p+nRn
         BwDg==
X-Gm-Message-State: AFqh2kph3ep7HF0gPiXBp0WZ8xunrZbF72nhoqYjEMWYOBu3yTG4rRNY
        hX2j8seZFCKMlqeJIEmn2TaAItGAUBBPuB1G
X-Google-Smtp-Source: AMrXdXueaa4dFGcoO+ZQv8KF8N7hesWfET2q0B/yE9XBfhLadDTwF6Vz6PrsKAZSbr/jbmJmEVRWPYHXjsmbmqDZ
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:490c:0:b0:41f:702d:7883 with SMTP
 id w12-20020a81490c000000b0041f702d7883mr5495262ywa.22.1672913957258; Thu, 05
 Jan 2023 02:19:17 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:13 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-16-jthoughton@google.com>
Subject: [PATCH 15/46] hugetlb: make default arch_make_huge_pte understand
 small mappings
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a simple change: don't create a "huge" PTE if we are making a
regular, PAGE_SIZE PTE. All architectures that want to implement HGM
likely need to be changed in a similar way if they implement their own
version of arch_make_huge_pte.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2fcd8f313628..b7cf45535d64 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -912,7 +912,7 @@ static inline void arch_clear_hugepage_flags(struct page *page) { }
 static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
 				       vm_flags_t flags)
 {
-	return pte_mkhuge(entry);
+	return shift > PAGE_SHIFT ? pte_mkhuge(entry) : entry;
 }
 #endif
 
-- 
2.39.0.314.g84b9a713c41-goog

