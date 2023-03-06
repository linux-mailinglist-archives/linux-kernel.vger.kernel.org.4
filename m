Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBEA6AD23F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCFXA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCFXAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:00:22 -0500
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D804A1CB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 15:00:13 -0800 (PST)
Received: by mail-ua1-x94a.google.com with SMTP id r18-20020ab06f52000000b00654ed50c29fso5452217uat.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 15:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678143612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hIx3kaJ7v5MfcJ3bC83E2C9/NBXIacneT6tynRm3EnA=;
        b=qvAewIddK0QuhCdcxur8X/IPKYUlFdGMwHQ7wfqwcDsA+ABbNXYVt7Xpud40PyavmQ
         IgS0CnzzxQ+sURvHsBxhn6GPimrIzKhfHCMChWPpYFWrjeNJ7XSWoE70RERcx6Z4TZ31
         Bj3E+88BJofX7eT4wjNwD6s4Tx7DTBBBF/5xs9U7P8rvtXXYIlfW3ttOVJ5Zx1beuTvM
         TqsqrigZMh7wFnRxKO0xdlf2NGmbwV2th7ywzvaTiOqCG5bnzZXoB7p+fVW1yLJQkwTL
         bGvPzcmjgTxl+W/H7JWrIJU/d/ADu31M5bVostl04gzRlaNtJrzUFBuglPdaHCUlbFJE
         UsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIx3kaJ7v5MfcJ3bC83E2C9/NBXIacneT6tynRm3EnA=;
        b=6xGtQ4FahIB9MP1F0jUCspFEK7guusjRFbIItNpfcCSss4IVbodKGlZ6Qs+nninpDE
         2xy5od+OSKutBWttPQG5yt3bJLBArAhU/2T70MV5G71ROmHHrZ84ACd7xuayp2J6i7yO
         7lel4uanF1AiChHxxsPA8X6T1TpPzImgoe0jdQyFIjYNpigXdSPORhIAWl2mlwa1gxoH
         l3/iQ2v3RQ0m2FFm9+92YKUjinOM0KTjn0P/TtQBFeo+TgAsIDVHos3Veqrd/eIIis1e
         LScrP7DU1DM7sFh/yMVbLG+nLR2iJhTLz0beJJFcXWfqyJRoJ2HvsA6PaBIQrPCyda/x
         coRg==
X-Gm-Message-State: AO0yUKVJXdw2ljIUlCk6IL2lZJeZm19KDp/tyjHgPZQbZgc5o0iG2uA+
        n9qi+bTgzFfGKEm3t/aujVFQYcR+13GwNeZN
X-Google-Smtp-Source: AK7set910gI7f4wEAiHLGM5tPuw0JcdSRnZOvRyh4XmPDvpbk+ahzqZvHdoFgr9rOMIgHs0nPGCKWy/u/Ys/1cG8
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a67:d583:0:b0:411:fff6:3cc4 with SMTP
 id m3-20020a67d583000000b00411fff63cc4mr8672319vsj.3.1678143612654; Mon, 06
 Mar 2023 15:00:12 -0800 (PST)
Date:   Mon,  6 Mar 2023 23:00:04 +0000
In-Reply-To: <20230306230004.1387007-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230306230004.1387007-1-jthoughton@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306230004.1387007-3-jthoughton@google.com>
Subject: [PATCH 2/2] mm: rmap: increase COMPOUND_MAPPED to support 512G
 HugeTLB pages
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
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

Some architectures may want to support 512G HugeTLB pages in the future.
Adjust COMPOUND_MAPPED to support this page size.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/internal.h b/mm/internal.h
index 400451a4dd49..994381fd5155 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -53,11 +53,11 @@ struct folio_batch;
 void page_writeback_init(void);
 
 /*
- * If a 16GB hugetlb folio were mapped by PTEs of all of its 4kB pages,
- * its nr_pages_mapped would be 0x400000: choose the COMPOUND_MAPPED bit
- * above that range, instead of 2*(PMD_SIZE/PAGE_SIZE).
+ * If a 512G hugetlb folio were mapped by PTEs of all of its 4kB pages,
+ * its nr_pages_mapped would be 2^27 (0x8000000): choose the COMPOUND_MAPPED bit
+ * above that range.
  */
-#define COMPOUND_MAPPED		0x800000
+#define COMPOUND_MAPPED		(1 << 28)
 #define FOLIO_PAGES_MAPPED	(COMPOUND_MAPPED - 1)
 
 /*
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

