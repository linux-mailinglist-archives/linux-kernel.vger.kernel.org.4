Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589815B7BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiIMT7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiIMT6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:58:32 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3B174B81;
        Tue, 13 Sep 2022 12:58:25 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id o13so10086435qvw.12;
        Tue, 13 Sep 2022 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6/+RylwAUS1L6kGkdbzNevLkV7SCUovxqo9fjOaS6JU=;
        b=IIvzQBml/wGri/ZBWsuig4iC5yLnXMtk1VHesQ1eh/9HzasiMgV8YxfdpWHpGIoYep
         M/INFOPjeTVC3OEHHCjy2E1Hs8kTN4G53N8xRA/QBMd1ulJjTypxrYcp9Vasl1Q/eOJB
         qHAj6LLFWCEJm7FVRIifJLn+g0xAhtpqiGJt/0Lazj8LpFDzEnyQtx4bqcugERvtsdZG
         jeSnKtUCKGP4SXlnb3HB7CkPQRbT8a6KgjjUz3Q32zw4SQOfC5UckDKNJQGxML3W3hgv
         kauff9Q/Ua47CAvmWSZZgrFSzvsXxKLS/PIpqLn25rigG7/KetjxEqCiT7a4LgLAH6NO
         U6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6/+RylwAUS1L6kGkdbzNevLkV7SCUovxqo9fjOaS6JU=;
        b=qgVFZ8T7kukAfgpncvsvudRZ+DSjxdQyvYvQfMSlqLSIr/2/KakJQAmUJ8NlVxcvWR
         +77JmhrQ1attjTjhQ3C5VvwdQZEEdPQJTULyidCKIHt5nw5dSdSDq59/m0yLivBefH5w
         2qlgHgBuKxfa8SCzWSb/YbTG4bk+HfCGTMvvdtYAN5U80VH188Lo9HqMi9BQVAuAzb4G
         ZVYMf4svKyDsaz9n/+Fthqi9sizW5jQyFW2NA1VDXh3Ur8S8kNa9o2OEcH+c5OIJrGHz
         OjTpY220DOnkOwQIdBAJbg+S/X7xf9dhbgL4zt+fSY6OtZzzv9o627JwM+/kDEh148E3
         PsAA==
X-Gm-Message-State: ACgBeo0SytFwwStcyHTs6CBGDEqpUIA1rjh6K5K7T6QqcKXa4GzsHjEs
        xohwT4YTTPzuY41nJ6q2gCg=
X-Google-Smtp-Source: AA6agR7HhxHAKHSAet4vBy7WKGiBHiOPyi3Gu3lpC/Y1Ix8I/hDUvAWKeNeCYEL5N+Wcelu80g5S7w==
X-Received: by 2002:a0c:d987:0:b0:4a5:192c:faff with SMTP id y7-20020a0cd987000000b004a5192cfaffmr29341373qvj.106.1663099104077;
        Tue, 13 Sep 2022 12:58:24 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:23 -0700 (PDT)
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
Subject: [PATCH 08/21] mm/vmstat: show start_pfn when zone spans pages
Date:   Tue, 13 Sep 2022 12:54:55 -0700
Message-Id: <20220913195508.3511038-9-opendmb@gmail.com>
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

A zone that overlaps with another zone may span a range of pages
that are not present. In this case, displaying the start_pfn of
the zone allows the zone page range to be identified.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/vmstat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 90af9a8572f5..e2f19f2b7615 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1717,6 +1717,11 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 
 	/* If unpopulated, no other information is useful */
 	if (!populated_zone(zone)) {
+		/* Show start_pfn for empty overlapped zones */
+		if (zone->spanned_pages)
+			seq_printf(m,
+				   "\n  start_pfn:           %lu",
+				   zone->zone_start_pfn);
 		seq_putc(m, '\n');
 		return;
 	}
-- 
2.25.1

