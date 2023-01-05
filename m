Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD5765F402
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjAES5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjAES5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:57:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F56F5F48D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 10:57:19 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n12so27915662pjp.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 10:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iikTOOXwX2lw93hLanStaxDWxlQ0WBIAjgTuBx/ti1k=;
        b=nrimoDLQZmLj3dvp+AfMCD8cD184hlLMWxfat0lls3uhkpEt4vuyPux6Hqwn5YQVp5
         iYrOdq87WyrhSPwhooOGY3cznKqMdrIDZGRCF/0joJWfPGFff8r4b+8MLiMdTms4wqY5
         alEkBBg1uflRSQsfJj0/X5uJya4ArLe588W9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iikTOOXwX2lw93hLanStaxDWxlQ0WBIAjgTuBx/ti1k=;
        b=ghsu5Aq/6GB9eHI+2S8otbYS0MsxyjAJ8pnQmngo2Hi27akwdReeb1yHkkBABan2pK
         XiYXmK+0cdZYKsyaWt3Kcfkem52GvDazeCOgvj7on6NUk3o7dpPR3N53VjexllD1j3BB
         8SEhYkUA7wuvCTD6DBh2tyAWyA7301n7lHnHjbN6hyjqx4Ge0/Oc/EvGUGwAqFQg4F0c
         NG4sVvOmntRHk3vJQkkvgQUq2gOK/YTIF0Im9/GmAnynAPbdPtnNoK/974VG5CwkDUMB
         KBE19Siqf+oN7d9Dtp/Tw0nfiHmwAbJsFjyS+ufpjcZarkUt90inWv+pTPlNamBRYlu0
         x58Q==
X-Gm-Message-State: AFqh2kqxAFpIhTFfr4X9qjT1KnBWvejbmLuzpxj9j1AKDFqZbHaHimVR
        Rtzks9jag8B/f+16CMDTejK7IA==
X-Google-Smtp-Source: AMrXdXuxmHzRxqtDU34xBnBJtfQgvjYMGeSRQmTRNwl+jz+2WfMpjBPPPVH9eGCTbWEDSK1y9GYqbQ==
X-Received: by 2002:a17:903:41c6:b0:186:8238:bc9 with SMTP id u6-20020a17090341c600b0018682380bc9mr75210344ple.2.1672945038907;
        Thu, 05 Jan 2023 10:57:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709026a8800b00172f6726d8esm26384552plk.277.2023.01.05.10.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 10:57:18 -0800 (PST)
Date:   Thu, 5 Jan 2023 10:57:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 4/8] migrate_pages: split unmap_and_move() to _unmap()
 and _move()
Message-ID: <202301051056.9D8CB1C24@keescook>
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-5-ying.huang@intel.com>
 <Y7cWb2aP1+wAWR8N@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7cWb2aP1+wAWR8N@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 11:26:55AM -0700, Nathan Chancellor wrote:
> Hi Ying,
> 
> On Tue, Dec 27, 2022 at 08:28:55AM +0800, Huang Ying wrote:
> > This is a preparation patch to batch the folio unmapping and moving.
> > 
> > In this patch, unmap_and_move() is split to migrate_folio_unmap() and
> > migrate_folio_move().  So, we can batch _unmap() and _move() in
> > different loops later.  To pass some information between unmap and
> > move, the original unused dst->mapping and dst->private are used.
> > 
> > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Cc: Yang Shi <shy828301@gmail.com>
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Bharata B Rao <bharata@amd.com>
> > Cc: Alistair Popple <apopple@nvidia.com>
> > Cc: haoxin <xhao@linux.alibaba.com>
> > ---
> >  include/linux/migrate.h |   1 +
> >  mm/migrate.c            | 162 +++++++++++++++++++++++++++++-----------
> >  2 files changed, 121 insertions(+), 42 deletions(-)
> > 
> > diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > index 3ef77f52a4f0..7376074f2e1e 100644
> > --- a/include/linux/migrate.h
> > +++ b/include/linux/migrate.h
> > @@ -18,6 +18,7 @@ struct migration_target_control;
> >   * - zero on page migration success;
> >   */
> >  #define MIGRATEPAGE_SUCCESS		0
> > +#define MIGRATEPAGE_UNMAP		1
> >  
> >  /**
> >   * struct movable_operations - Driver page migration
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 97ea0737ab2b..e2383b430932 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1009,11 +1009,29 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
> >  	return rc;
> >  }
> >  
> > -static int __unmap_and_move(struct folio *src, struct folio *dst,
> > +static void __migrate_folio_record(struct folio *dst,
> > +				   unsigned long page_was_mapped,
> > +				   struct anon_vma *anon_vma)
> > +{
> > +	dst->mapping = (struct address_space *)anon_vma;
> > +	dst->private = (void *)page_was_mapped;
> > +}
> > +
> > +static void __migrate_folio_extract(struct folio *dst,
> > +				   int *page_was_mappedp,
> > +				   struct anon_vma **anon_vmap)
> > +{
> > +	*anon_vmap = (struct anon_vma *)dst->mapping;
> > +	*page_was_mappedp = (unsigned long)dst->private;
> > +	dst->mapping = NULL;
> > +	dst->private = NULL;
> > +}
> 
> This patch as commit 42871c600cad ("migrate_pages: split
> unmap_and_move() to _unmap() and _move()") in next-20230105 causes the
> following error with clang when CONFIG_RANDSTRUCT is enabled, which is
> the case with allmodconfig:
> 
>   ../mm/migrate.c:1041:15: error: casting from randomized structure pointer type 'struct address_space *' to 'struct anon_vma *'
>           *anon_vmap = (struct anon_vma *)dst->mapping;
>                        ^
>   1 error generated.
> 
> With GCC, there is only a note:
> 
>   ../mm/migrate.c: In function '__migrate_folio_extract':
>   ../mm/migrate.c:1041:20: note: randstruct: casting between randomized structure pointer types (ssa): 'struct anon_vma' and 'struct address_space'
> 
>    1041 |         *anon_vmap = (struct anon_vma *)dst->mapping;
>         |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Kees has done fixes for warnings and errors like this in the past (I
> just ran
> 
>   $ git log -p --grep='randomized structure pointer type'
> 
> to find them) but I did not see any that would seem appropriate here
> hence just the report :)

If this struct is literally just a scratch space and the original struct
layout doesn't matter, it may be possible to silence this cast by using
"(void *)" instead of the explicit struct type pointer.

-- 
Kees Cook
