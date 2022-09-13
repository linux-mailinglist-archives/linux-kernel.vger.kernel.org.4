Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DC95B7BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiIMT7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIMT6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:58:38 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDF172FE8;
        Tue, 13 Sep 2022 12:58:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id a20so6960420qtw.10;
        Tue, 13 Sep 2022 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bjPZ9urefAsJcftBbAgQB1diXayOj809VCbylW0WU+4=;
        b=ElB8vGfwnTgMrOHPV8jOPMjX9e4dyOnpsA/daCy84nADITgBEDs0AWwUlYd7LmzJ4R
         Fd+wihlwr+eHGiOYJevIadmukrrhPQQQbV14He/EgVL8UId/ZjEQspu78E84lCBkqAk3
         9AGpDbnJvnF63g83iAedqf+9zINjZ62a64qbSfO2T1vB7Ckgl7brAPRPzZAIUuLk9YsF
         YnnaDAUhOF2TFJBs1+hdGFIi2/6/xETSCDXaO1b95XuqZwbhceSd0bqWp4uVAOWzs4lk
         zAxkAToGZXGzD1zml0W1YllS9/kHr+k5y9Z8yZENt9c1+33raLf8akoDdgYfGMOxfC4A
         ITFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bjPZ9urefAsJcftBbAgQB1diXayOj809VCbylW0WU+4=;
        b=2vKeVej398VF1KxT6CmF+E7esLxfw/Fj1hH+T2RFtOUPWXojcmoxLBGtE2zN/QU0OO
         dgSFdeQ3aUPKjIxnZgqFws4nUn3YQWEL2ldTWe7mEnVKoj5uVDtheVMFgEZeSPVg0Phy
         5I0yVqsxMLqFcy2oqH/ao5I1e1GzkCAyJJ7l5zUzXEmTF10QNpGKAp8hTLIndVVthv1p
         s0GurfFepRyfXNTwgX/5yaIGIxpIhQzw93fHlCcKAaqBVl7gd5WFyL4D/AkeK5e15ePd
         DShJVf0f8tACEOEofsP3lP7Vs/hoJXB9STRpbIQOGWkinUrEK5R02dn7ET4WfXnlpHGk
         f7AQ==
X-Gm-Message-State: ACgBeo3haF0AkNEgOStpbETGk8eX+5kQ86HA89ABPA0nWIIYviAjKVNh
        5/0OVF2wnbhas/Yo7UisHvs=
X-Google-Smtp-Source: AA6agR4w6aZMPi6cpzcCwIclFPfEwGVo8/KdfU9B4JBAlrDz19GDQ32yg1HkC6aVwcDa1gVOoM50cA==
X-Received: by 2002:a05:622a:174b:b0:343:1fc:14d8 with SMTP id l11-20020a05622a174b00b0034301fc14d8mr29317121qtk.579.1663099111308;
        Tue, 13 Sep 2022 12:58:31 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:30 -0700 (PDT)
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
Subject: [PATCH 10/21] mm/page_alloc.c: allow oversized movablecore
Date:   Tue, 13 Sep 2022 12:54:57 -0700
Message-Id: <20220913195508.3511038-11-opendmb@gmail.com>
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

Now that the error in computation of corepages has been corrected
by commit 9fd745d450e7 ("mm: fix overflow in
find_zone_movable_pfns_for_nodes()"), oversized specifications of
movablecore will result in a zero value for required_kernelcore if
it is not also specified.

It is unintuitive for such a request to lead to no ZONE_MOVABLE
memory when the kernel parameters are clearly requesting some.

The current behavior when requesting an oversized kernelcore is to
classify all of the pages in movable_zone as kernelcore. The new
behavior when requesting an oversized movablecore (when not also
specifying kernelcore) is to similarly classify all of the pages
in movable_zone as movablecore.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b6074961fb59..ad38a81203e5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8041,13 +8041,13 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 		corepages = totalpages - required_movablecore;
 
 		required_kernelcore = max(required_kernelcore, corepages);
+	} else if (!required_kernelcore) {
+		/* If kernelcore was not specified, there is no ZONE_MOVABLE */
+		goto out;
 	}
 
-	/*
-	 * If kernelcore was not specified or kernelcore size is larger
-	 * than totalpages, there is no ZONE_MOVABLE.
-	 */
-	if (!required_kernelcore || required_kernelcore >= totalpages)
+	/* If kernelcore size exceeds totalpages, there is no ZONE_MOVABLE */
+	if (required_kernelcore >= totalpages)
 		goto out;
 
 	/* usable_startpfn is the lowest possible pfn ZONE_MOVABLE can be at */
-- 
2.25.1

