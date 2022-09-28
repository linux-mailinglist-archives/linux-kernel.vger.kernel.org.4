Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EAD5EE5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiI1ThH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiI1ThF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:37:05 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1F548E89
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:37:04 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z191so10974262iof.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=w+64nBC9flQuRlvFf/LyNi8vAIoeFZlmjiGW7/Cl9GA=;
        b=W1oLTSde5Qwb++pbSaUe4lWBe586C2QHURCizljXgg5WUYP5/EWw76ThSDAmN8HdLN
         1bn2X8u17DOL6ZgiSEAOjjzoUl0ujoEeqIqAEMA3x4+hZclF9cxqSuvfrOm66gTJvflh
         A92GVUKk1qjCxsntZgVqbe2oBEeMo3tqY1nO/yRnkJRglartg9jnsTgHrlNRscXIikWy
         n2UW5230gSIvPlWMoDgw2rolIttjNi28MVW1qEFn6Ed0Q+1wPFYGc245TNoRKM4VXfHL
         rQZOyeQfp22g8RGWrVUD5FqoZ4l+WHWCEaG5YRAVet6EKIz5JM1019yWewHiNCSt3tYp
         9DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=w+64nBC9flQuRlvFf/LyNi8vAIoeFZlmjiGW7/Cl9GA=;
        b=HHPIGcZywfM10aUoYY2rek9RElwuofiU6bTw8gvSjlAoNOaHGx5DbNH61j/ettxCpc
         9msc7BT02hZlah4PAmeEIAPx85nkA4/R6qXIqPaxNEl6CVKtCcPyHumCxngOnr+RoPWZ
         Falixtw78YMHwlGR4F0kK0SwHiDUk1urA/HS54xNXOTqw0k6VW39DXxZnfKE9PPeAHk1
         15MW5lwJirGgcbQWROqqHsfr5GHwKDl41ZWDtBmLtEKUrieQtx62Iv4zmt9qrAx3Rx9L
         iQeBl0pQSRDwsyrqZ1InTIkhskOPHE4To0o6j+VmQ0yth7z7K9g+uenB0pbJqwYr7o5W
         uL/w==
X-Gm-Message-State: ACrzQf1EAeUuzPask8RQuE4bIAR/TX1O+etA5+xfg6+FkB8ldmII5zlv
        9nba0ySDhdCg/sC/FOQC7l+VOA==
X-Google-Smtp-Source: AMsMyM4pvj/63KDkjqfOHv+ZDuiHOFQWJwmRPDGjn/J9jBlb8WWfq0hCxV1lxPeDvR8N5J4PM3KGgA==
X-Received: by 2002:a02:c6d4:0:b0:35a:4ea3:4890 with SMTP id r20-20020a02c6d4000000b0035a4ea34890mr1234303jan.215.1664393823556;
        Wed, 28 Sep 2022 12:37:03 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:e132:6c29:fb2a:a1b])
        by smtp.gmail.com with ESMTPSA id z25-20020a6be019000000b006814fd71117sm2283016iog.12.2022.09.28.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 12:37:03 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:36:58 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH mm-unstable v15 08/14] mm: multi-gen LRU: support page
 table walks
Message-ID: <YzSiWq9UEER5LKup@google.com>
References: <20220918080010.2920238-1-yuzhao@google.com>
 <20220918080010.2920238-9-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918080010.2920238-9-yuzhao@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Can you please take another fixlet? Thanks.

Don't sync disk for each aging cycle.

wakeup_flusher_threads() was added under the assumption that if a
system runs out of clean cold pages, it might want to write back dirty
pages more aggressively so that they can become clean and be dropped.

However, doing so can breach the rate limit a system wants to impose
on writeback, resulting in early SSD wearout.

Reported-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5b565470286b..0317d4cf4884 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4413,8 +4413,6 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	if (wq_has_sleeper(&lruvec->mm_state.wait))
 		wake_up_all(&lruvec->mm_state.wait);
 
-	wakeup_flusher_threads(WB_REASON_VMSCAN);
-
 	return true;
 }
 
-- 
2.37.3.998.g577e59143f-goog
