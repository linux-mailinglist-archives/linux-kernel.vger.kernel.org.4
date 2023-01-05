Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34AB65F3A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjAES1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjAES07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:26:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA34054D85
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 10:26:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AE0461BE7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEDBC433D2;
        Thu,  5 Jan 2023 18:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672943217;
        bh=2xBB462x3Sc6HYYpMTo6seMnpcER1C8TouUgi6aef5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VFcJxIx11LLNSXOAzjJz6akDEr3uhfU74pY/CnWKsOaMufTX1UHmqziwhBHoKWg79
         5uPqyx38WVZNI3o1b4tKgoFhCJ5aX2YQAc8CYjgWCC+Wg2e8Zru02n6LnRj9jtDh7r
         y97Lwj1OZG2Jza3zxE6/UNjO25tgujX0Rxmx+ptiIQenaOMqeL1yYKJYcA+oCeLGvG
         l0RsxrfPLkw/FIT+IILnuhhkbVYrfLXos0p0UlZPFuHnSdl6/UlwKWc2PU9n/5V/lT
         PnL9bURfedZTta50PLYlRNHAKOFOUGSH2lIHpE7Y7KwHkqz6AgHXu5yafwnn7eFUsi
         b4b9ut/MsWW2A==
Date:   Thu, 5 Jan 2023 11:26:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 4/8] migrate_pages: split unmap_and_move() to _unmap()
 and _move()
Message-ID: <Y7cWb2aP1+wAWR8N@dev-arch.thelio-3990X>
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-5-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227002859.27740-5-ying.huang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ying,

On Tue, Dec 27, 2022 at 08:28:55AM +0800, Huang Ying wrote:
> This is a preparation patch to batch the folio unmapping and moving.
> 
> In this patch, unmap_and_move() is split to migrate_folio_unmap() and
> migrate_folio_move().  So, we can batch _unmap() and _move() in
> different loops later.  To pass some information between unmap and
> move, the original unused dst->mapping and dst->private are used.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: haoxin <xhao@linux.alibaba.com>
> ---
>  include/linux/migrate.h |   1 +
>  mm/migrate.c            | 162 +++++++++++++++++++++++++++++-----------
>  2 files changed, 121 insertions(+), 42 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 3ef77f52a4f0..7376074f2e1e 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -18,6 +18,7 @@ struct migration_target_control;
>   * - zero on page migration success;
>   */
>  #define MIGRATEPAGE_SUCCESS		0
> +#define MIGRATEPAGE_UNMAP		1
>  
>  /**
>   * struct movable_operations - Driver page migration
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 97ea0737ab2b..e2383b430932 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1009,11 +1009,29 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>  	return rc;
>  }
>  
> -static int __unmap_and_move(struct folio *src, struct folio *dst,
> +static void __migrate_folio_record(struct folio *dst,
> +				   unsigned long page_was_mapped,
> +				   struct anon_vma *anon_vma)
> +{
> +	dst->mapping = (struct address_space *)anon_vma;
> +	dst->private = (void *)page_was_mapped;
> +}
> +
> +static void __migrate_folio_extract(struct folio *dst,
> +				   int *page_was_mappedp,
> +				   struct anon_vma **anon_vmap)
> +{
> +	*anon_vmap = (struct anon_vma *)dst->mapping;
> +	*page_was_mappedp = (unsigned long)dst->private;
> +	dst->mapping = NULL;
> +	dst->private = NULL;
> +}

This patch as commit 42871c600cad ("migrate_pages: split
unmap_and_move() to _unmap() and _move()") in next-20230105 causes the
following error with clang when CONFIG_RANDSTRUCT is enabled, which is
the case with allmodconfig:

  ../mm/migrate.c:1041:15: error: casting from randomized structure pointer type 'struct address_space *' to 'struct anon_vma *'
          *anon_vmap = (struct anon_vma *)dst->mapping;
                       ^
  1 error generated.

With GCC, there is only a note:

  ../mm/migrate.c: In function '__migrate_folio_extract':
  ../mm/migrate.c:1041:20: note: randstruct: casting between randomized structure pointer types (ssa): 'struct anon_vma' and 'struct address_space'

   1041 |         *anon_vmap = (struct anon_vma *)dst->mapping;
        |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kees has done fixes for warnings and errors like this in the past (I
just ran

  $ git log -p --grep='randomized structure pointer type'

to find them) but I did not see any that would seem appropriate here
hence just the report :)

Cheers,
Nathan
