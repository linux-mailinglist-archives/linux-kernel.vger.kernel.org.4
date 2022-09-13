Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32215B7BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIMT6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiIMT6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:58:03 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE7472697;
        Tue, 13 Sep 2022 12:58:02 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id cb8so9637682qtb.0;
        Tue, 13 Sep 2022 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ae0x/cYtHCzUmIbnlOleUipnU3BBydliG8CbSfbHHfI=;
        b=lQy156yj9m33v2+lsCppN/1SSiL1+HSKUeGu4OKDvKzsWQP9uaxSZeRF6KYff4/ZX1
         T8ar9K8mrC7poQnpcOlicqZBPrnyrX4lQmy/efXceAo8c/r+O7+kebNQPiRqxM6b8RHk
         nqDdqIjYqMl2UkmBaLyC3jNoxqdBf+LTtzsYTc4L2U/V/TdvsthKIhCb1FgggCffFcVL
         4UCRPgfEkwehGvOaibbczRrkl3etaXkViPMT1ZepP3U6LDqZx2jP70X41REaFOYLplOf
         cOzr55DR2HMCT6kc/P98YRx0lPP2AD9Ny8hyMOuXORVZJrRjvmaKZrJZ1BXySGhbtpI9
         HDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ae0x/cYtHCzUmIbnlOleUipnU3BBydliG8CbSfbHHfI=;
        b=DhK79UjZYFX6oR2ZfYRzZaRib+JuOiQw8zC14/4oqBwzjoVvBskxTnNUCUo+YU570S
         B5CZYKkrdBf5SwmIMYGyhv/n0nQVNWtcdtummZTCM0UGL0qkAs/xpdg/H4boH+pE0V9V
         yNnJE8yAHHm5NHtpw73ESZKl9QW0K8FTlUT77nRa8MmIZjyn7k80pomSnX/iXKsxf/jt
         eMcbYT9SF2INEc+LzvA4qoehtyBZ95C/UEdreXGb1AJ+P7CpAgZ8SaYBy7XlXjzhAbD1
         b4/+ggHwwyaafLccNik9c5gSOMZXg42FzxbmAC0/kJXemAWbVjbqBVRP2pIP+UUYFtSk
         QSng==
X-Gm-Message-State: ACgBeo2JCDymnw+Bopy8tAou9papj5jEbvfJOtWdQd8u6UDfWCnRq0uE
        HXtocqxXjAP+AHFJ9lJ0vIw=
X-Google-Smtp-Source: AA6agR5RQ3Vz73r+e9pp4sPmIM/iMa/zHS6QVY1LvvDFqMY99XQUTUB/nmtdr1ce7F9gfpRjTDrD5Q==
X-Received: by 2002:ac8:5790:0:b0:35b:fd92:6fb8 with SMTP id v16-20020ac85790000000b0035bfd926fb8mr4051143qta.53.1663099081690;
        Tue, 13 Sep 2022 12:58:01 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:01 -0700 (PDT)
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
Subject: [PATCH 02/21] mm/hugetlb: correct max_huge_pages accounting on demote
Date:   Tue, 13 Sep 2022 12:54:49 -0700
Message-Id: <20220913195508.3511038-3-opendmb@gmail.com>
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

When demoting a hugepage to a smaller order, the number of pages
added to the target hstate will be the size of the large page
divided by the size of the smaller page.

Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/hugetlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e070b8593b37..79949893ac12 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3472,7 +3472,8 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	 * based on pool changes for the demoted page.
 	 */
 	h->max_huge_pages--;
-	target_hstate->max_huge_pages += pages_per_huge_page(h);
+	target_hstate->max_huge_pages += pages_per_huge_page(h) /
+					 pages_per_huge_page(target_hstate);
 
 	return rc;
 }
-- 
2.25.1

