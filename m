Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7FC5B7BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIMUA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIMUAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:00:03 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6B6796AA;
        Tue, 13 Sep 2022 12:59:12 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id l5so10085275qvs.13;
        Tue, 13 Sep 2022 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=koBwJdR4HF2Mh9OkMa3nN+ZpGb/cJotv47IHPg3aLjM=;
        b=H9fVlQTVY6EaU+njTimAq+ibJtvJjx2vWGkJikgtxKpK4lpRvh7Gs0dhq+SfYU7Y1l
         ol227J1p7+D7fHpafEcMsArwK6zpQesHNLeCyw8pBBnlfTeZXRH0gTB01wVhDLo6ZqZ0
         2mt9ehwJJq5f5bEntKn/0aquyhMi35hMoNg4MgcTAFw56eJYhoioxREYotQhcXVzv4ef
         26N8v6sdGt7Ksl3t6WmZRbYcEffyv4LTbLh0c7Zn4Y23wzA2w1INQgl13/vOL+Z8k7Uy
         rhOg4rC2RHnt2n62JjXnioNT4+kK415lG500sJWQkISGfWvSLQb972JndYtjJi8pBB0H
         qioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=koBwJdR4HF2Mh9OkMa3nN+ZpGb/cJotv47IHPg3aLjM=;
        b=HN7lhz6SD+hT8b1DBWvUrJNtZdiu4wDF7bHx9lrwgcYGTgSOc9npRxclx1uIhOeAm/
         piFgg7I0qM+7uuFTbwTcWzP9U+X37VOMOF18k7Z1D1yQGZJGyaNNn4onTUV5J8Th551p
         4gdxT/E+aBKOjYJheyA4m31wPDDwaZRD2xEJnTY5xETTAmV94uC4j32OtCkbyae3S8X9
         3ZAVw2kfdi96qY6vAUR0REO3fQCFLxRduOFcSh39HdTtdjl54THciYIjQnSWhml+qgH2
         qEnrb7SSxvrQeqjiwyp+ZKEWS+kj+Rfqsjno6sE1Zc1Vr10CMWw9AhTKBF6sjsJ/c8tq
         tAUw==
X-Gm-Message-State: ACgBeo0ybWQ69iXreBTql3F2ddDt1pdWNkqPzneq7FOVfr/I3cHY5oCE
        Boyb2a0M2EpQxprcLY5ENB8=
X-Google-Smtp-Source: AA6agR4KLeMksXEqgCvXkwrSYo6YaUFxsEGC4nazCYouj2Y6nxYnhGX19vjDfEjEBR3X6wdqMlktzg==
X-Received: by 2002:a05:6214:1c0a:b0:49d:87ff:e77c with SMTP id u10-20020a0562141c0a00b0049d87ffe77cmr28164232qvc.54.1663099151805;
        Tue, 13 Sep 2022 12:59:11 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:59:11 -0700 (PDT)
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
Subject: [PATCH 21/21] mm/hugetlb: introduce hugetlb_dmb
Date:   Tue, 13 Sep 2022 12:55:08 -0700
Message-Id: <20220913195508.3511038-22-opendmb@gmail.com>
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

If specified on the kernel command line the hugetlb_dmb parameter
modifies the behavior of the hugetlb_cma parameter to use the
Contiguous Memory Allocator within Designated Movable Blocks for
gigantic page allocation.

This allows the kernel page allocator to use the memory more
agressively than traditional CMA memory pools at the cost of
potentially increased allocation latency.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 mm/hugetlb.c                                    | 16 +++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8141fac7c7cb..b29d1fa253d6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1732,6 +1732,9 @@
 			hugepages using the CMA allocator. If enabled, the
 			boot-time allocation of gigantic hugepages is skipped.
 
+	hugetlb_dmb	[HW,CMA] Causes hugetlb_cma to use Designated Movable
+			Blocks for any CMA areas it reserves.
+
 	hugetlb_free_vmemmap=
 			[KNL] Reguires CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 			enabled.
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2f354423f50f..d3fb8b1f443f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -54,6 +54,7 @@ struct hstate hstates[HUGE_MAX_HSTATE];
 #ifdef CONFIG_CMA
 static struct cma *hugetlb_cma[MAX_NUMNODES];
 static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
+static bool hugetlb_dmb __initdata;
 static bool hugetlb_cma_page(struct page *page, unsigned int order)
 {
 	return cma_pages_valid(hugetlb_cma[page_to_nid(page)], page,
@@ -7321,6 +7322,14 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
 
 early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
 
+static int __init cmdline_parse_hugetlb_dmb(char *p)
+{
+	hugetlb_dmb = true;
+	return 0;
+}
+
+early_param("hugetlb_dmb", cmdline_parse_hugetlb_dmb);
+
 void __init hugetlb_cma_reserve(int order)
 {
 	unsigned long size, reserved, per_node;
@@ -7396,10 +7405,11 @@ void __init hugetlb_cma_reserve(int order)
 		 * may be returned to CMA allocator in the case of
 		 * huge page demotion.
 		 */
-		res = cma_declare_contiguous_nid(0, size, 0,
+		res = __cma_declare_contiguous_nid(0, size, 0,
 						PAGE_SIZE << HUGETLB_PAGE_ORDER,
-						 0, false, name,
-						 &hugetlb_cma[nid], nid);
+						0, false, name,
+						&hugetlb_cma[nid], nid,
+						hugetlb_dmb);
 		if (res) {
 			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
 				res, nid);
-- 
2.25.1

