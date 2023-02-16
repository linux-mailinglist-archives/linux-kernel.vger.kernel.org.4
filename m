Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C01D699ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjBPRFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:05:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8019A4BEA7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676567098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EAJARXHQNAhyOCCyC2BnQ09ROyHtptUeMjLNwbeK/jY=;
        b=Mzm/1fNPLM2/7K8u6GprUct9sm2Cb0jVfFtvk2bHScdWlA7+o9voj/DXVFB83+9Qv6/0A3
        IVjuQ4pvfqdihm267QVFGl5fblz0J7m1PDzJSvSZoKsdEIOIRht8WCR1R+cfiyONfavPvR
        Ze14Pb6iUjbxSenIkN+I4ZVz+qzZlkc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-Bx4Wo_wUP66nZ1AW_s2XTQ-1; Thu, 16 Feb 2023 12:04:57 -0500
X-MC-Unique: Bx4Wo_wUP66nZ1AW_s2XTQ-1
Received: by mail-wr1-f72.google.com with SMTP id i1-20020adfa501000000b002c54aaa28dcso341899wrb.16
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAJARXHQNAhyOCCyC2BnQ09ROyHtptUeMjLNwbeK/jY=;
        b=Rw8BpOqVdUquOJQMS80vcAeTQdURFNalFPkyAXOHWP7w7ohZBVMwHXwjRHhAyXYEDR
         teCml2BJ2ynVdvQaQ03DkuD4VEQ92MAh3WQs+nC9OT0p0cZGf+oGPfX22cDoZ2djIesC
         2ghwI3Pd/g191Fqo3VxAbvassuaczcq92ffNoo9SZADvU0hJakYWXIyooVTxyXgext4A
         DEWs6dRH2o5XwBX1COZ3fSNYcg8L6H8vYlxzoVBY8bU71olYTqd+5YRuFfsUB3OJdUCw
         I5Na5v1blTP2CaTo181B/vYHzvcBS6A2h9/Hh9FKYpNRdMMF+tUBAQOv4IhB3OAPUnIJ
         bbqw==
X-Gm-Message-State: AO0yUKUdSJEc2qqVBxlnzVcwBDy1RyPW1V4/zsh+Hwnw65A5Ryii4KHB
        uxsDPVwiwhxQCOZHarpgWvcET6Th2cazaruzABlJzTjkF81xsQMxx+da494MvyXXKBFFDhyLtRl
        BpnFZnZMq56Atw7Ey0DCA898B
X-Received: by 2002:a05:600c:1d0f:b0:3df:9858:c03f with SMTP id l15-20020a05600c1d0f00b003df9858c03fmr2424328wms.20.1676567095533;
        Thu, 16 Feb 2023 09:04:55 -0800 (PST)
X-Google-Smtp-Source: AK7set9iS3qwiL5Y9tVloR5loMJzSSh/RVxr2XYgvc64ngnOoIKwusZ8GTOPyQ1l0/LCC+Rtrdk7Uw==
X-Received: by 2002:a05:600c:1d0f:b0:3df:9858:c03f with SMTP id l15-20020a05600c1d0f00b003df9858c03fmr2424281wms.20.1676567095128;
        Thu, 16 Feb 2023 09:04:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id l14-20020adffe8e000000b002c561805a4csm1966327wrr.45.2023.02.16.09.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 09:04:54 -0800 (PST)
Message-ID: <3a3ee697-591d-dc3c-7c53-5965da219062@redhat.com>
Date:   Thu, 16 Feb 2023 18:04:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/migrate: Fix wrongly apply write bit after mkdirty on
 sparc64
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        regressions@leemhuis.info, Nick Bowler <nbowler@draconx.ca>
References: <20230216153059.256739-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230216153059.256739-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.23 16:30, Peter Xu wrote:
> Nick Bowler reported another sparc64 breakage after the young/dirty
> persistent work for page migration (per "Link:" below).  That's after a
> similar report [2].
> 
> It turns out page migration was overlooked, and it wasn't failing before
> because page migration was not enabled in the initial report test environment.
> 
> David proposed another way [2] to fix this from sparc64 side, but that
> patch didn't land somehow.  Neither did I check whether there's any other
> arch that has similar issues.
> 
> Let's fix it for now as simple as moving the write bit handling to be after
> dirty, like what we did before.
> 
> Note: this is based on mm-unstable, because the breakage was since 6.1 and
> we're at a very late stage of 6.2 (-rc8), so I assume for this specific
> case we should target this at 6.3.
> 
> [1] https://lore.kernel.org/all/20221021160603.GA23307@u164.east.ru/
> [2] https://lore.kernel.org/all/20221212130213.136267-1-david@redhat.com/
> 
> Cc: regressions@leemhuis.info
> Fixes: 2e3468778dbe ("mm: remember young/dirty bit for page migrations")
> Link: https://lore.kernel.org/all/CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com/
> Reported-by: Nick Bowler <nbowler@draconx.ca>
> Tested-by: Nick Bowler <nbowler@draconx.ca>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/huge_memory.c | 6 ++++--
>   mm/migrate.c     | 2 ++
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1343a7d88299..4fc43859e59a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3274,8 +3274,6 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>   	pmde = mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot));
>   	if (pmd_swp_soft_dirty(*pvmw->pmd))
>   		pmde = pmd_mksoft_dirty(pmde);
> -	if (is_writable_migration_entry(entry))
> -		pmde = maybe_pmd_mkwrite(pmde, vma);
>   	if (pmd_swp_uffd_wp(*pvmw->pmd))
>   		pmde = pmd_mkuffd_wp(pmde);
>   	if (!is_migration_entry_young(entry))
> @@ -3283,6 +3281,10 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>   	/* NOTE: this may contain setting soft-dirty on some archs */
>   	if (PageDirty(new) && is_migration_entry_dirty(entry))
>   		pmde = pmd_mkdirty(pmde);
> +	if (is_writable_migration_entry(entry))
> +		pmde = maybe_pmd_mkwrite(pmde, vma);
> +	else
> +		pmde = pmd_wrprotect(pmde);
>   
>   	if (PageAnon(new)) {
>   		rmap_t rmap_flags = RMAP_COMPOUND;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ef68a1aff35c..40c63e77e91f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -225,6 +225,8 @@ static bool remove_migration_pte(struct folio *folio,
>   			pte = maybe_mkwrite(pte, vma);
>   		else if (pte_swp_uffd_wp(*pvmw.pte))
>   			pte = pte_mkuffd_wp(pte);
> +		else
> +			pte = pte_wrprotect(pte);
>   
>   		if (folio_test_anon(folio) && !is_readable_migration_entry(entry))
>   			rmap_flags |= RMAP_EXCLUSIVE;


I'd really rather focus on fixing the root cause instead, anyhow if my 
patch won't make it:

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

