Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52515B7BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIMT6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIMT62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:58:28 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D24F78200;
        Tue, 13 Sep 2022 12:58:18 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d15so9307283qka.9;
        Tue, 13 Sep 2022 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5478I3WyUfDJcI1zhJnzCnFwBV1ia1XR+sLHu3XJI6Q=;
        b=ngWpsEYVUBqyRCK+w+5Ame50HZp1DYM8gstxDexc5gHtIO2fEu4wX/+7Noqq7EWBX5
         SX4JOXX5B1E8Qf1s/pvzk9Bz2iJJBgv4Hk3Ull+tKjmtldfM+s3z+vbM1B3di5w6gxjz
         dcVCWO2NZ50adOCK8bPYxw3tCqWOsDx7M7cTAjTnYf/V4tSaPDhi8fqtVljCEiP5o1JE
         EBkXOKZZNuxNzz6s5U3pOqHYezTLOaL4mQLClkKUJN8hT0raCVH32ZKrxQcROVGentqi
         38kFA0gMphAG/6qqKzQ2VCttdNXcqVd0gmzjLhB0hmlMfPBCKPcE2Rytw17lBrFXHH3/
         rqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5478I3WyUfDJcI1zhJnzCnFwBV1ia1XR+sLHu3XJI6Q=;
        b=ZdpfxQH5JMWc9atFLaVl342kjTClvqmVLm6tWN8jUEJSadOqlZRCjWzEKZ2gqlrXun
         svhU85L1/UsjszGpxALGj7CavklIt/24+En7eaWEUs5VinJYbxMFgGZWmXOq6Jd91K+i
         39r4he9C3wSa5mPX6jZ8AgJ3o0JM/frfMgOrLVGR4kGF/dcqJQbJ2Umv27AH9vmJKWw2
         oZqHXTGes5RTFpEMNcNS7ldLFJtXfcLAqtvf3xpQ6kJwgzoqBkV3ty3ETMi9fCnks8px
         aRtf5KgXyQkUx7Kn0VoolTHaRA7sxep65RQK6UyXYap8F5uYDdqMPx75F7cMo7/ei1qj
         MALA==
X-Gm-Message-State: ACgBeo3gHm0/c7qvp8ADIW3PPtIMJxy+4sB8U8lcgx5ldy86SKdunGTy
        MYSxew3nscFHdY2tZ+F0N58=
X-Google-Smtp-Source: AA6agR5yg7LQIQNFFYJ0sDmMy6v2CLDWuXatdLv4m+yPVXKNj8MYR/nHEcTFAbCbbhbRcvfawH5dww==
X-Received: by 2002:a05:620a:4496:b0:6bb:8db4:6b49 with SMTP id x22-20020a05620a449600b006bb8db46b49mr24594751qkp.703.1663099096778;
        Tue, 13 Sep 2022 12:58:16 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:16 -0700 (PDT)
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
Subject: [PATCH 06/21] mm/hugetlb: add hugepage isolation support
Date:   Tue, 13 Sep 2022 12:54:53 -0700
Message-Id: <20220913195508.3511038-7-opendmb@gmail.com>
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

When a range of pageblocks is isolated there is at most one
hugepage that has only tail pages overlapping that range (i.e.
a hugepage that overlaps the beginning of the range).

However, that hugepage is the first migration target for an
alloc_contig_range() attempt so it already receives special
attention.

Checking whether the pageblock containing the head of a hugepage
is isolated is an inexpensive way to avoid hugepage allocations
from isolated pageblocks which makes alloc_contig_range() more
efficient.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/hugetlb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index da80889e1436..2f354423f50f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -33,6 +33,7 @@
 #include <linux/migrate.h>
 #include <linux/nospec.h>
 #include <linux/delayacct.h>
+#include <linux/page-isolation.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -1135,6 +1136,10 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 		if (PageHWPoison(page))
 			continue;
 
+		/* Check head pageblock isolation */
+		if (is_migrate_isolate_page(page))
+			continue;
+
 		list_move(&page->lru, &h->hugepage_activelist);
 		set_page_refcounted(page);
 		ClearHPageFreed(page);
-- 
2.25.1

