Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75E969B6C0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjBRAbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjBRA36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:58 -0500
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D764F692BA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:19 -0800 (PST)
Received: by mail-ua1-x949.google.com with SMTP id f9-20020ab049c9000000b00419afefbe3eso547545uad.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676680159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iq/7jaT5OFDRS9NrMnKt72E+h6CEDJFDrueWaD5zQ0Y=;
        b=LJj15ou5aMEGPdFnqegHuN/91OeXfp4rRCRW3cHsebkq5WCcCf2NnXo+eHh1uMaO0x
         HGob/Qz7INsRX4HMjLzhzpa+KbL6w+JBpKkbb6I/Ysl4ceV4fqt+kMp8qMdpjJbgCgDd
         Tcz7EoAzke3MYE3bcoJtrb8uvPbhZOxumTn85X2FXJuWHnvKqPNwDU25UykrRCmdga/F
         knEIFRpT0+EamIE3eGJxptV9TuGnb5/oXNb+6p7X3bGPy9+qYpYd06XgumHdicpJSnfx
         vsXDE/Y+0UGaB7YP7fdTkJQcKpB/Er0uopshKy4OGw0b9a8rj98PAJY4bfzYQJ4aBoYZ
         rlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676680159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iq/7jaT5OFDRS9NrMnKt72E+h6CEDJFDrueWaD5zQ0Y=;
        b=h52h9LsO2+kALS3Uzc3ZFJ/Q3YCMhrMgvqr3U24xXrk+RYkys4/CGnLKgP3g9DbT+s
         dWJPnkz976UMx+uM9z+1O7fCy3pT1LbHMxu7EwlHkClJDAPPW9DDy/UzCY1vyvzscpvn
         lG9r8n/6e7QFzPAnbspy2qlXEItj6BB0kwYo1qLq7fv+flPIa7m2c2keWjiMnqaR6nrb
         gJDbk7ZVd0QEJFmiN0ZkLxL/8laBFs4rRbFtVY8o5Iael+V7ZZdfUyWpCrPHbKEgTZ+8
         InMMeB2urEAD8Llqpe87wzlDJzggexTvwcPUk+Cwpjqp1ciYSYAyaD9+HOsiHoeie4O4
         BFbg==
X-Gm-Message-State: AO0yUKVaeD27MiKgHlL7DA3SyU5UbqAWtkmf+feLYNu+5cORjikB/erA
        3nSpRHu8rfoemmpzZ0HHU7kQIT2Q3rE0vgQ1
X-Google-Smtp-Source: AK7set8EhVlNCK9IccPiC1WcAxl/BD8tBcWSdj7osxR3aU5m9A2R/pd4W9j1Bya2QmGiWMHJAKk9Wk9ZzEwHF/MA
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a67:f1c6:0:b0:3ec:ab8:a571 with SMTP id
 v6-20020a67f1c6000000b003ec0ab8a571mr271401vsm.55.1676680139239; Fri, 17 Feb
 2023 16:28:59 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:49 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-17-jthoughton@google.com>
Subject: [PATCH v2 16/46] hugetlb: make default arch_make_huge_pte understand
 small mappings
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 726d581158b1..b767b6889dea 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -899,7 +899,7 @@ static inline void arch_clear_hugepage_flags(struct page *page) { }
 static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
 				       vm_flags_t flags)
 {
-	return pte_mkhuge(entry);
+	return shift > PAGE_SHIFT ? pte_mkhuge(entry) : entry;
 }
 #endif
 
-- 
2.39.2.637.g21b0678d19-goog

