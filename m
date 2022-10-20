Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC2A606A88
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJTVye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJTVy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:54:28 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567FD2250C;
        Thu, 20 Oct 2022 14:54:25 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id s17so849477qkj.12;
        Thu, 20 Oct 2022 14:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwP9OSSuHG+apHyoqkPAJ44LToseDE0HSDpJZDk5eXs=;
        b=jNUUsRnWlXrm8JAnuE1Xqa7UyLQ1Ntt7WFErGDBLV2vutQLJ0PQilqL0HL16ioBgaH
         tfq5WvKTPdO/dJLDa7W8VLb0/wS9gfOFZuMY8jvjjuPVKNIMwy9MVx/MirO3GfRRjL9n
         LupI3gDdDDnJkGpBaXNyK+SWatGDer0WWzVHCbIfQnp6CFkOKk6e3uHHKYH1dhv9aKUc
         UA3llhu3zx7UqBkZYqKQEWHaDgpLD1LksEfySU/2dYYUbXhzmBK7FSG2uF/2KLWhBZ9W
         k2/WpZe9yLC3nkSo4WQVXGo12b2hpsTKZzBu5axXXMLlcPqhKB9lAMVFlgQgm+2vH3RB
         pXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwP9OSSuHG+apHyoqkPAJ44LToseDE0HSDpJZDk5eXs=;
        b=H+1roMVjlDs+n+cgAol0jw/LbEczpDWjTc51iPHD31Ir8kWBhjlBDqCjnBu4qPEq3g
         gaYAY418VZriByUhm3Q1OUv9r2sfZBzmXgz1RCxRa17SSl0s/5AHAv38yZNn0GU9OpoS
         MLwJEnthgoVE0qnqt/5YbJdHYbqJ5C/+b/BAk9MBZQB2RHD1/trcUdClK+TVuM4kQNiM
         BLJBR4Je5ABTugNIDmQ24PTnjee+1df29+Yx8yNGzuuxiTEozkrMKxvTQugY+gt9/+zK
         ZED+QimJFellCFJS67FRBmDfJKVEhydEHdFQxXH50VDA3Z87izJFShGkRnos/xmxG3Bm
         ByZw==
X-Gm-Message-State: ACrzQf12gGtAq7znMlKvRB0Ne+4smtpJqi/+gj6+lRf4D31K7hZz7YQY
        n1jlehGebQfy3anLZwaZfr4=
X-Google-Smtp-Source: AMsMyM6u0RdH/aVAaBL4k+8UrNNclWICnDFcnMRVg2Itkr/PEI6FjGGL8fVEwkAtL7Q/FgTRKalRDQ==
X-Received: by 2002:a05:620a:150b:b0:6ee:8d04:f70 with SMTP id i11-20020a05620a150b00b006ee8d040f70mr11428999qkk.101.1666302864030;
        Thu, 20 Oct 2022 14:54:24 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006bb29d932e1sm8121067qkb.105.2022.10.20.14.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:54:23 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v3 1/9] lib/show_mem.c: display MovableOnly
Date:   Thu, 20 Oct 2022 14:53:10 -0700
Message-Id: <20221020215318.4193269-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020215318.4193269-1-opendmb@gmail.com>
References: <20221020215318.4193269-1-opendmb@gmail.com>
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

The comment for commit c78e93630d15 ("mm: do not walk all of
system memory during show_mem") indicates it "also corrects the
reporting of HighMem as HighMem/MovableOnly as ZONE_MOVABLE has
similar problems to HighMem with respect to lowmem/highmem
exhaustion."

Presuming the similar problems are with regard to the general
exclusion of kernel allocations from either zone, I believe it
makes sense to include all ZONE_MOVABLE memory even on systems
without HighMem.

To the extent that this was the intent of the original commit I
have included a "Fixes" tag, but it seems unnecessary to submit
to linux-stable.

Fixes: c78e93630d15 ("mm: do not walk all of system memory during show_mem")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 lib/show_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/show_mem.c b/lib/show_mem.c
index 0d7585cde2a6..6a632b0c35c5 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -27,7 +27,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 			total += zone->present_pages;
 			reserved += zone->present_pages - zone_managed_pages(zone);
 
-			if (is_highmem_idx(zoneid))
+			if (zoneid == ZONE_MOVABLE || is_highmem_idx(zoneid))
 				highmem += zone->present_pages;
 		}
 	}
-- 
2.25.1

