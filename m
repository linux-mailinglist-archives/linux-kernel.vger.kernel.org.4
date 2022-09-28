Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5E05ED6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiI1H5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiI1H5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:57:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD3A63E5;
        Wed, 28 Sep 2022 00:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07E74B81F61;
        Wed, 28 Sep 2022 07:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E25C433D6;
        Wed, 28 Sep 2022 07:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664351864;
        bh=ruZ2DsK+gMbfErHsem/PLXeWS8YS24c8thncWAIJF0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kq3wd8OCFk4Zi3saIY7Rw52ujF8gD0yuF244x2GtPfaKk7H4ppKQq9bG2lF/dm41p
         Z39aqnoN86n28V6QEZP7v0dhyUVCe5kZrISQoSOKK/1eSEqcgppl2btoyH6dpmRqZc
         Cno6e2jk2lAaA/6zglYnl7q9hg/YRmp1iv8pB6JPvBxXDrjX0BiFWTSzrP6PLtTnl7
         RdfLpk6AqaXuYY/HLBo3MquICqha9k0o3tsZ5MqNCYnen1Jn5Zpqm+X/QOYx3PbMPS
         +5E9ZfAvQENXlQy8NneD4stO2UvDL+ngWSIMvvZ4dH02yF8yk7ZQXvO77pa7GBRkl2
         hx2dxvLbNxTjA==
Date:   Wed, 28 Sep 2022 10:57:29 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vernon Yang <vernon2gm@gmail.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, bobwxc@email.cn,
        hughd@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/mm: modify page_referenced to
 folio_referenced
Message-ID: <YzP+aZsR6Lov7zi6@kernel.org>
References: <20220926152032.74621-1-vernon2gm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926152032.74621-1-vernon2gm@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 11:20:32PM +0800, Vernon Yang wrote:
> Since commit b3ac04132c4b ("mm/rmap: Turn page_referenced() into
> folio_referenced()") the page_referenced function name was modified,
> so fix it up to use the correct one.
> 
> Signed-off-by: Vernon Yang <vernon2gm@gmail.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  Documentation/mm/unevictable-lru.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
> index b280367d6a44..4a0e158aa9ce 100644
> --- a/Documentation/mm/unevictable-lru.rst
> +++ b/Documentation/mm/unevictable-lru.rst
> @@ -197,7 +197,7 @@ unevictable list for the memory cgroup and node being scanned.
>  There may be situations where a page is mapped into a VM_LOCKED VMA, but the
>  page is not marked as PG_mlocked.  Such pages will make it all the way to
>  shrink_active_list() or shrink_page_list() where they will be detected when
> -vmscan walks the reverse map in page_referenced() or try_to_unmap().  The page
> +vmscan walks the reverse map in folio_referenced() or try_to_unmap().  The page
>  is culled to the unevictable list when it is released by the shrinker.
>  
>  To "cull" an unevictable page, vmscan simply puts the page back on the LRU list
> @@ -267,7 +267,7 @@ the LRU.  Such pages can be "noticed" by memory management in several places:
>   (4) in the fault path and when a VM_LOCKED stack segment is expanded; or
>  
>   (5) as mentioned above, in vmscan:shrink_page_list() when attempting to
> -     reclaim a page in a VM_LOCKED VMA by page_referenced() or try_to_unmap().
> +     reclaim a page in a VM_LOCKED VMA by folio_referenced() or try_to_unmap().
>  
>  mlocked pages become unlocked and rescued from the unevictable list when:
>  
> @@ -547,7 +547,7 @@ vmscan's shrink_inactive_list() and shrink_page_list() also divert obviously
>  unevictable pages found on the inactive lists to the appropriate memory cgroup
>  and node unevictable list.
>  
> -rmap's page_referenced_one(), called via vmscan's shrink_active_list() or
> +rmap's folio_referenced_one(), called via vmscan's shrink_active_list() or
>  shrink_page_list(), and rmap's try_to_unmap_one() called via shrink_page_list(),
>  check for (3) pages still mapped into VM_LOCKED VMAs, and call mlock_vma_page()
>  to correct them.  Such pages are culled to the unevictable list when released
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
