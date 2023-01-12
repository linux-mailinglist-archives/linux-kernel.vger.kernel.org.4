Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AD3666E45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbjALJbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbjALJas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:30:48 -0500
Received: from outbound-smtp25.blacknight.com (outbound-smtp25.blacknight.com [81.17.249.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49345B1E8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:26:14 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 79609CAE1F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:26:12 +0000 (GMT)
Received: (qmail 26969 invoked from network); 12 Jan 2023 09:26:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Jan 2023 09:26:12 -0000
Date:   Thu, 12 Jan 2023 09:26:10 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] mm/page_alloc: Rename ALLOC_HIGH to ALLOC_MIN_RESERVE
Message-ID: <20230112092610.msowgtidt2a7zo4w@techsingularity.net>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-2-mgorman@techsingularity.net>
 <Y77TWhr9/dPcthiF@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y77TWhr9/dPcthiF@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:18:50PM +0100, Michal Hocko wrote:
> On Mon 09-01-23 15:16:25, Mel Gorman wrote:
> > __GFP_HIGH aliases to ALLOC_HIGH but the name does not really hint
> > what it means. As ALLOC_HIGH is internal to the allocator, rename
> > it to ALLOC_MIN_RESERVE to document that the min reserves can
> > be depleted.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Naming is hard but ALLOC_HIGH is definitely much more confusing as it
> can collide with high watermark. ALLOC_MIN_RESERVE says that some
> reserves are involved. ALl the reserves are below min watermark by
> defition but I cannot really come up with a better name. I do not think
> we want to encode the amount of reserves into the name.
> 

It's internal to the page allocator so I didn't sweat about it too much.
Access to the reserves currently means "allow pages to be allocated
below the min reserve". Even if that changes in the future, the name can
change with it.

> Acked-by: Michal Hocko <mhocko@suse.com>
> 

Thanks!

-- 
Mel Gorman
SUSE Labs
