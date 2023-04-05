Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683486D8002
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbjDEOuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbjDEOuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:50:16 -0400
Received: from outbound-smtp41.blacknight.com (outbound-smtp41.blacknight.com [46.22.139.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA793C22
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:50:14 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp41.blacknight.com (Postfix) with ESMTPS id 00D4321EF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 15:50:12 +0100 (IST)
Received: (qmail 1459 invoked from network); 5 Apr 2023 14:50:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Apr 2023 14:50:12 -0000
Date:   Wed, 5 Apr 2023 15:50:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Alexander Halbuer <halbuer@sra.uni-hannover.de>
Subject: Re: [PATCH] mm, page_alloc: use check_pages_enabled static key to
 check tail pages
Message-ID: <20230405145010.lrrc4gnxtaqjlnil@techsingularity.net>
References: <20230405142840.11068-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230405142840.11068-1-vbabka@suse.cz>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 04:28:40PM +0200, Vlastimil Babka wrote:
> Commit 700d2e9a36b9 ("mm, page_alloc: reduce page alloc/free sanity
> checks") has introduced a new static key check_pages_enabled to control
> when struct pages are sanity checked during allocation and freeing. Mel
> Gorman suggested that free_tail_pages_check() could use this static key
> as well, instead of relying on CONFIG_DEBUG_VM. That makes sense, so do
> that. Also rename the function to free_tail_page_prepare() because it
> works on a single tail page and has a struct page preparation component
> as well as the optional checking component.
> Also remove some unnecessary unlikely() within static_branch_unlikely()
> statements that Mel pointed out for commit 700d2e9a36b9.
> 
> Suggested-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
