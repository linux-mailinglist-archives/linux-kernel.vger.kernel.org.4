Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BFA634F67
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbiKWFOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiKWFOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:14:10 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57501ECCD0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 21:14:09 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id j6so11499726qvn.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 21:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OkCJt0xSlohFefz/J5gZgN/a/7oPMseVk+gnc8nDg0=;
        b=plVfVdX58j84lIGa4iqPQSbyhDhbjWozttExLyvRA1W9+qlKQ5NjDx3LZf+B4Bn5U9
         PjW05AlxEjEb87VgnpnmSsYmZp1c/LXs89/R9/AtRgzgE+5v3/uyrnA6IqjTzALnkfCG
         4362TdsP5r/0/hCELVqbOJZlkEXcl+qZHdIb1cxRrC9UTw2Nmv+JoVU+WFlnyzLDlnSL
         Z9+jsb9+Q+SvfBfjePWxmJuDlX/V7EAFU4sTqghLowYRwd1ZFPYOk3wIg9uHQUY9FjwY
         oTA9TAKSxI4TAgjy47KIohzKKjLVEgDp3nWps6Vna0ZKhxrL+v8OMsjBaV4R+UyTnRhM
         rzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OkCJt0xSlohFefz/J5gZgN/a/7oPMseVk+gnc8nDg0=;
        b=jbOw46bwI1VzofoSBqAOf9Kt1YarY2E5+Av+QWL17G4q3Y88RCVSjs3qoolQShEK58
         E/rWJw5gdPiOTxtaQ1CPM7xsm0dolfw8KSMcvUslKIJ8ZksFyBo48WnosY/fobY1hO4A
         AajQCjPsQAR17UeK+b1VWWfK9HUV4erHaWjqGIJRcyP2BCM43CSGA73l9QomvjV/S7nT
         Xumv35yiZFdJfuCMxkFGo6lzpMIUY58TpnbdeyGFn9AuvmGL/sbZiWrXkPxY3b6mkLDL
         9tw9WXCbVTHAdhRy6P1JY77eJTO7wOlQ0WVoz8q+9Va7+ckeg9A0JphoASyJj2GQsL2i
         qoOg==
X-Gm-Message-State: ANoB5pmIfOl6sbm9F87KGy0qycgJYV6Nw0k2CDL0ubSmj+sgsMAxaZyd
        f1JvzrxLRmuJFhhj9jH8YAtsTg==
X-Google-Smtp-Source: AA0mqf6VTL2hceDYuR2jQQIcVLTrbAT50vgOYN/hDopSb3SpZKzpp7T58o2B44uHsRmRDr7I33n4Zw==
X-Received: by 2002:ad4:528a:0:b0:4c6:9033:e56b with SMTP id v10-20020ad4528a000000b004c69033e56bmr6555464qvr.12.1669180448354;
        Tue, 22 Nov 2022 21:14:08 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id oo19-20020a05620a531300b006fa00941e9dsm10953687qkn.136.2022.11.22.21.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 21:14:07 -0800 (PST)
Date:   Tue, 22 Nov 2022 21:14:04 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Gavin Shan <gshan@redhat.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com, david@redhat.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com, riel@surriel.com,
        willy@infradead.org, apopple@nvidia.com
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
In-Reply-To: <20221123005752.161003-1-gshan@redhat.com>
Message-ID: <e8a64b11-98f9-b571-dce9-a60df98e3e5@google.com>
References: <20221123005752.161003-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 23 Nov 2022, Gavin Shan wrote:

> The issue is reported when removing memory through virtio_mem device.
> The transparent huge page, experienced copy-on-write fault, is wrongly
> regarded as pinned. The transparent huge page is escaped from being
> isolated in isolate_migratepages_block(). The transparent huge page
> can't be migrated and the corresponding memory block can't be put
> into offline state.
> 
> Fix it by replacing page_mapcount() with total_mapcount(). With this,
> the transparent huge page can be isolated and migrated, and the memory
> block can be put into offline state.
> 
> Fixes: 3917c80280c9 ("thp: change CoW semantics for anon-THP")
> Cc: stable@vger.kernel.org   # v5.8+
> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Interesting, good catch, looked right to me: except for the Fixes line
and mention of v5.8.  That CoW change may have added a case which easily
demonstrates the problem, but it would have been the wrong test on a THP
for long before then - but only in v5.7 were compound pages allowed
through at all to reach that test, so I think it should be

Fixes: 1da2f328fa64 ("mm,thp,compaction,cma: allow THP migration for CMA allocations")
Cc: stable@vger.kernel.org   # v5.7+

Oh, no, stop: this is not so easy, even in the latest tree.

Because at the time of that "admittedly racy check", we have no hold
at all on the page in question: and if it's PageLRU or PageCompound
at one instant, it may be different the next instant.  Which leaves it
vulnerable to whatever BUG_ON()s there may be in the total_mapcount()
path - needs research.  *Perhaps* there are no more BUG_ON()s in the
total_mapcount() path than in the existing page_mapcount() path.

I suspect that for this to be safe (before your patch and more so after),
it will be necessary to shift the "admittedly racy check" down after the
get_page_unless_zero() (and check the sequence of operations when a
compound page is initialized).

The races I'm talking about are much much rarer than the condition you
are trying to avoid, so it's frustrating; but such races are real,
and increasing stable's exposure to them is not so good.

Sorry, I'm going to run away now: just raising these concerns
without working on the solution.

Hugh

> ---
>  mm/compaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c51f7f545afe..c408b5e04c1d 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -990,7 +990,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		 * admittedly racy check.
>  		 */
>  		mapping = page_mapping(page);
> -		if (!mapping && page_count(page) > page_mapcount(page))
> +		if (!mapping && page_count(page) > total_mapcount(page))
>  			goto isolate_fail;
>  
>  		/*
> -- 
> 2.23.0
