Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E616EAD88
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjDUO5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjDUO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:57:02 -0400
Received: from outbound-smtp18.blacknight.com (outbound-smtp18.blacknight.com [46.22.139.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C764D324
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:57:01 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id BDD041C3F9C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:56:59 +0100 (IST)
Received: (qmail 4981 invoked from network); 21 Apr 2023 14:56:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 14:56:59 -0000
Date:   Fri, 21 Apr 2023 15:56:57 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 25/26] mm: page_alloc: disallow fallbacks when 2M
 defrag is enabled
Message-ID: <20230421145657.fnpjqkuyquy3z24t@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-26-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-26-hannes@cmpxchg.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:13:12PM -0400, Johannes Weiner wrote:
> Fallbacks are already unlikely due to watermarks being enforced
> against MIGRATE_FREE blocks. Eliminate them altogether. This allows
> compaction to look exclusively at movable blocks, reducing the number
> of pageblocks it needs to scan on an ongoing basis.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Conceptually this could be fun if a GFP_NOFS allocation cannot migrate
enough memory to free one pageblock and there are no pageblocks
available of the correct migratetype. Fallbacks might be unlikely but
never being able to fallback is a livelock risk, no?

-- 
Mel Gorman
SUSE Labs
