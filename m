Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0436B56D4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCKAkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCKAkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:40:01 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A11136D33;
        Fri, 10 Mar 2023 16:39:59 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id ne1so4751582qvb.9;
        Fri, 10 Mar 2023 16:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678495198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS/BwpEuHX62q7q4jA6kz2JjH38ryXLVzKB9Q24XSVc=;
        b=VF08OkgdvcCe08OFIcKq9AjNHxoLhzwun0cGIC1Dw+CHTXLxKUFwhYo6TUZdd/cWK3
         9WanLdPXxSvDlWj9fqkxau3KxElLZQ+s/76QZ3bxEmG1O+nywfnvT/hiRGlxMPH/ohYJ
         FAs5zCI3FPjJgsi5FN6DhqLP9JB7Lpvd8rZj/E499x6+NukAtPbth8cSZITIIevW4iJI
         mpXPc4PbQsDfArMwZv6d+gaXpvtIkJexpGmEU7Bh54jzSPLoRC8gA+96ufZ6AQFCWzAo
         aZF9vOT02zcYSfbZLxIu9rZCY/Z3v8Xnipykl3H10Lw3vvS3h3NOz85H7iNEhWMQD/d4
         eWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS/BwpEuHX62q7q4jA6kz2JjH38ryXLVzKB9Q24XSVc=;
        b=Y9NA/rPZgrARI7cdRC7L5LBKkZ7PWGECLQ7VGfiNg4tkD2VmYUEal0ba3zXldR2xQF
         +MMq8OYliJmixWt3p8XMKLXhQ/CqD4nZ5tspRmq7snmSUKXSdR34ACiGVOmlcW3XDtws
         XVQ+Gn6rvjdEKLoehyqvO2ddiIVP90NFzR+yZqYPjAmdrgfFs1vsi38HhwssQHJ2BUmZ
         /8S0mNsJe6jORkRfFvsi6UCNt4lrgiU5Lh6lGnh84tRPceRQaZo4tsQTqL6IvantLepc
         jB/ixGwi6Ybc0FFgWsp5Qkk8Y5rnPvr5uQYuIFcCZ2bsXYCZcr5mnb7RAHc1iemhwePq
         9A4Q==
X-Gm-Message-State: AO0yUKWPjzqIEIkZhdO649A5R7jISKwVfhpQ8JEfuA/OzzDezUvUr84f
        /kKaOA+RA5l4YnlaTkGRUPw=
X-Google-Smtp-Source: AK7set/7lbmUehkOoWsoZelfJbwaie1c7mWXavPmCpQDq6lJJf0+Kbe53vrmeRB0vmNfXKniiuy2zg==
X-Received: by 2002:ad4:5aee:0:b0:57e:56f5:5410 with SMTP id c14-20020ad45aee000000b0057e56f55410mr1647846qvh.39.1678495198141;
        Fri, 10 Mar 2023 16:39:58 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020ac84345000000b003bfaff2a6b9sm868874qtn.10.2023.03.10.16.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:39:57 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        "Georgi Djakov" <quic_c_gdjako@quicinc.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v4 4/9] mm/page_alloc.c: allow oversized movablecore
Date:   Fri, 10 Mar 2023 16:38:50 -0800
Message-Id: <20230311003855.645684-5-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311003855.645684-1-opendmb@gmail.com>
References: <20230311003855.645684-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 827b4bfef625..e574c6a79e2f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8166,13 +8166,13 @@ static void __init find_zone_movable_pfns_for_nodes(void)
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
2.34.1

