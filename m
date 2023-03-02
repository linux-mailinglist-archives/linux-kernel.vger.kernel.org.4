Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7D66A8BAF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCBWYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCBWYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:24:19 -0500
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5CB15143
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:24:18 -0800 (PST)
Received: by mail-ua1-x949.google.com with SMTP id g27-20020ab05fdb000000b0068ffe2ec956so240294uaj.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677795857;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/JMMuDjw3H8CXzuyUx8aTGbQPmUlzXe13PcSv0YCfA=;
        b=QwtuoBvQNsXjDF/5E0s2kkJBbQ7N49ADAjWzU3BQXBopWQfnrTRLV6Z27JDOp6F5HB
         KQDTPH0Az27+IuYaiI1PnvtwbnfX1xp2V/WIXY9jtVrW81TkyehvTbjngvholMVC6bYw
         aXNIbkpRqujqfrWNdj3CeyzPnH3lcE6M202ox8JoOqbXk5FnwxEzPf3mWnw06gwYe+0t
         TOB3hVaZRJnAAfhdTBOQB08H6bDIkashLN7H4FaXTKBss6G6pFjmVE7V0iKJZdXWr5bS
         8taEkfzuDL2mp8mFxDS2vdSt1ZJItRkZOTrHSWy4SlA8jwTE7IwUcgdpzQwmwOoH3675
         90XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677795857;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/JMMuDjw3H8CXzuyUx8aTGbQPmUlzXe13PcSv0YCfA=;
        b=N+y04xlX+A0Pd84670TVcD4P4R37W7G2MgZR+wrvjXWEU4wj97wnAijzy1NSfGSEBo
         kmx3+QAbQ5p/Y6Zcw6s/DDcPgqDuLYk9+9FYPLRxlqFyrFr2qKd7eCiORkg1FVn1T519
         GiXZC3Q5cCorNewY4pUbAwVET3ukT87byO++uxnlDq7sLWs4qN8NVynTXpwjp05/BzNn
         Zc7DTnIinDRjY5G7cYDtoI3V15q/ZkmHB/b3ZdFF0U+NRv5jlKQy1XMBLQMqTixukAwj
         HjXeTZWiey3ATleq8vy1v4vTxH7QWeQeaM6h96XzY7OPoiqZ2yhokKnqltcTWfCPkrb7
         8rmQ==
X-Gm-Message-State: AO0yUKXWXPqAOGywWhK9IXE+t7xjuiTWYxSvqq0gfhUnMK2a4V0jKeC+
        hIX95Eo7ttBb2xxYjrwYFv09R97edenSz1dQ
X-Google-Smtp-Source: AK7set+jM4FnUzOsiQZgYL+m6qqmD5EyS8XVoY3pBRGESuYSP0JXzthHQrD3igTCVn2odnvH4hP/WUYncqTEZm/o
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:ab0:4ad5:0:b0:68b:90f4:1d8c with SMTP
 id t21-20020ab04ad5000000b0068b90f41d8cmr6973689uae.1.1677795857710; Thu, 02
 Mar 2023 14:24:17 -0800 (PST)
Date:   Thu,  2 Mar 2023 22:24:04 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230302222404.175303-1-jthoughton@google.com>
Subject: [PATCH] mm: teach mincore_hugetlb about pte markers
From:   James Houghton <jthoughton@google.com>
To:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anish Moorthy <amoorthy@google.com>, linux-mm@kvack.org,
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

By checking huge_pte_none(), we incorrectly classify PTE markers as
"present". Instead, check huge_pte_none_mostly(), classifying PTE
markers the same as if the PTE were completely blank.

PTE markers, unlike other kinds of swap entries, don't reference any
physical page and don't indicate that a physical page was mapped
previously. As such, treat them as non-present for the sake of
mincore().

Fixes: 5c041f5d1f23 ("mm: teach core mm about pte markers")
Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/mincore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mincore.c b/mm/mincore.c
index cd69b9db0081..d359650b0f75 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -33,7 +33,7 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 	 * Hugepages under user process are always in RAM and never
 	 * swapped out, but theoretically it needs to be checked.
 	 */
-	present = pte && !huge_pte_none(huge_ptep_get(pte));
+	present = pte && !huge_pte_none_mostly(huge_ptep_get(pte));
 	for (; addr != end; vec++, addr += PAGE_SIZE)
 		*vec = present;
 	walk->private = vec;
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

