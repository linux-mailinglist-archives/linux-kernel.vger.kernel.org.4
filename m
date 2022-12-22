Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17926653B37
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiLVEUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiLVETy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:19:54 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E2C22BDD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:53 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4528903f275so9657567b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wqbMgd0zowymzGskr7701SDcBxSEYhpmKyp2L4CmwQc=;
        b=FaAk0+IovKrA30gqzGnUXCgvxnAEqM9RNUrx6/qbk2dXbMev+aX6+TBCBI++qJqoJh
         DHNBFkCo27K0mtm3kCypi0Ii7FLQEyOoUcXG+t83h3xzdMvkNUCkZTP8OrqRsYYWm0el
         eWwdtsGBlfK8BfaDX27IjQxVLcqXb9rSOW0ntCxNjAM2Cim1CHaEVKSL6BfOAxE/zGHv
         zshIYCJIZ+wR/JAB7hswAHRV8jE3CLxEuhhNl1iaGkZYIJeIjSv9yuHWpAemQnptTj9G
         AsAn5TBRtcqHkkCAS4JOx0xwOehAeuT/Kj0REFHOiEd6bNs1NdquJnCAzj9joH3GCGp1
         aNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqbMgd0zowymzGskr7701SDcBxSEYhpmKyp2L4CmwQc=;
        b=DJmZpvGwa47fRGOzxcJH+2hrKMiv0YdQEb71x6ZA7TSFsF+0xjuzQBUvnooT5f2glg
         HM2yB4RxSZlqNmpHr5i96rt6Qf0Yb7CUqjIm3rMXPoPKR5i+PqAQNvl5aP0u0thHwnYv
         5Gx3DevBaLYOsBv2Qo4GbmKl4zsakG2ZNZzyBiKu/vsMZ0YHFOdteIC6nqrW5qpIy6Qg
         JogTScz5mwFddghFY61R8nS8/ddEqmqi5446jsKcuMi112p+zP3bgMRop6XLuRfJHl5n
         leBT0yvrOmOjdez7ANHw1jLBpTKWJNuehOCNTjo8IwCO2/lnft4q4fwapWy8GLeDdvlA
         iZtg==
X-Gm-Message-State: AFqh2kpA3abPB+h8sl0o3cc3KOKrzSF32JkUOPpVvu/pSYLvJ5t6LZIn
        EIsLKJqpWEWs2LgAfqo7ciU/4Ahoc9Y=
X-Google-Smtp-Source: AMrXdXtoQV2nYQsCRHGYe9z8m7Uo+pjFU+YdC4C/Y+Mib9s2WlE6ZwrTFMZkcNSCiAcHyEFs+f2bQg5UyD0=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a463:5f7b:440e:5c77])
 (user=yuzhao job=sendgmr) by 2002:a25:3c85:0:b0:6dc:b9ec:7c87 with SMTP id
 j127-20020a253c85000000b006dcb9ec7c87mr460947yba.322.1671682792499; Wed, 21
 Dec 2022 20:19:52 -0800 (PST)
Date:   Wed, 21 Dec 2022 21:19:06 -0700
In-Reply-To: <20221222041905.2431096-1-yuzhao@google.com>
Message-Id: <20221222041905.2431096-9-yuzhao@google.com>
Mime-Version: 1.0
References: <20221222041905.2431096-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v3 8/8] mm: multi-gen LRU: simplify
 arch_has_hw_pte_young() check
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com,
        Yu Zhao <yuzhao@google.com>
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

Scanning page tables when hardware does not set the accessed bit has
no real use cases.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a9b318e1bdc2..71d13c969b52 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4428,7 +4428,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	 * handful of PTEs. Spreading the work out over a period of time usually
 	 * is less efficient, but it avoids bursty page faults.
 	 */
-	if (!force_scan && !(arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK))) {
+	if (!arch_has_hw_pte_young() || !get_cap(LRU_GEN_MM_WALK)) {
 		success = iterate_mm_list_nowalk(lruvec, max_seq);
 		goto done;
 	}
-- 
2.39.0.314.g84b9a713c41-goog

