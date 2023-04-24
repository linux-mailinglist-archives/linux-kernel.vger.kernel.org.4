Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2BB6EAAFF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjDUMy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjDUMy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:54:57 -0400
Received: from outbound-smtp15.blacknight.com (outbound-smtp15.blacknight.com [46.22.139.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8794D1B1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:54:56 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 26F031C3F46
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:54:55 +0100 (IST)
Received: (qmail 6123 invoked from network); 21 Apr 2023 12:54:55 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 12:54:54 -0000
Date:   Fri, 21 Apr 2023 13:54:53 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 06/26] mm: page_alloc: consolidate free page
 accounting
Message-ID: <20230421125453.np6b5hirktkj6ji5@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-7-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-7-hannes@cmpxchg.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:53PM -0400, Johannes Weiner wrote:
> Free page accounting currently happens a bit too high up the call
> stack, where it has to deal with guard pages, compaction capturing,
> block stealing and even page isolation. This is subtle and fragile,
> and makes it difficult to hack on the code.
> 
> Push the accounting down to where pages enter and leave the physical
> freelists, where all these higher-level exceptions are of no concern.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

I didn't look too closely at this one as I'm scanning through to see how
the overall series works and this is mostly a mechanical patch.
However, it definitely breaks build

> @@ -843,7 +843,7 @@ static int __init debug_guardpage_minorder_setup(char *buf)
>  early_param("debug_guardpage_minorder", debug_guardpage_minorder_setup);
>  
>  static inline bool set_page_guard(struct zone *zone, struct page *page,
> -				unsigned int order, int migratetype)
> +				  unsigned int order
>  {
>  	if (!debug_guardpage_enabled())
>  		return false;

Here

-- 
Mel Gorman
SUSE Labs
