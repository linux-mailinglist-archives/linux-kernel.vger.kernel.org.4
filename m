Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B24E6C1D84
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjCTRQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjCTRPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:15:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2A3126C1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:11:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso7976137wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679332184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rGCOrM4FMzTeub5/ravYucAeRNAx4GgviWtRpjAsQwg=;
        b=E9AQrjlOsm+l+iOQUD4pwk+AqM5R1bYmm58QOXDqblfoHm3MXvqAnhkeZN1+9EJwx7
         Aao5iFJHH0B+mn/jwjGJmeso7WXJ5F2aZyjaUtvEkl5jVMNpvuSMGyPsyTziEhgtTFAa
         BuolEZoDnl7tyKvrhf0Rf85bDtLcuczss0wphoiDB+N0FVSaPh+AE29x/qfvOBpXr2mc
         WnbcTA7ZTvbvYc0lQ1M3AhAbtHk8EfDzhEe2fiWZFxJ1inn4a8kVx2BStf/uhiHHRC+w
         CNp6Sn25eOTd3ZUqxtUCAfXDfIWMutOmjzzMtKSkHmICuvZPEczGURMj78dS+DfQCBHo
         eSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGCOrM4FMzTeub5/ravYucAeRNAx4GgviWtRpjAsQwg=;
        b=knXcH64B6T4olj8I8gInrcT08JSNzWTzahOUOffCgGpNQqxPpYdZkypDwmAksu2yPM
         fnjVifQNVhbC1gIGTkiJRhHNP8Pil2a+15rqE8BIs3aYjPFry/omLfwtJWV80JacMYJG
         brSTVq7msf9/YrsXFybBOUIe43r3rY/N/KQBLPM1pwZHTsSfFtvyaIJYDLj2h/ntHMli
         4sxOPLCSOk9KaErxkMDtQaTnkFQCLTeCBDSrUz7GVKULw4GCJ3umTgGRYz5RoU8pe4Zc
         L30f7ORLFbARiIaqJpVW6X4xUQKWmRjUV19g/8O9ghqpcJdoW+iViXbyQnpHjhwlkmws
         +N8A==
X-Gm-Message-State: AO0yUKV9LjqWAyYvNVkzJZ+Z+9W6LiL1uK61FFFIAl5grOcpBGm+xnZw
        Wk0mIHhEEIqojmW2QDfu+D8=
X-Google-Smtp-Source: AK7set8Zn5kiOPJpzlqDnRjE14OR99eyKESo6ny4jIJtj32Vsx+m/y8wwatZPjlZILI0qLL/qeeWlw==
X-Received: by 2002:a7b:c7cf:0:b0:3ee:12cd:dfa7 with SMTP id z15-20020a7bc7cf000000b003ee12cddfa7mr221076wmk.13.1679332183603;
        Mon, 20 Mar 2023 10:09:43 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id ay38-20020a05600c1e2600b003df7b40f99fsm16986271wmb.11.2023.03.20.10.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:09:42 -0700 (PDT)
Date:   Mon, 20 Mar 2023 17:09:41 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 0/4] further cleanup of vma_merge()
Message-ID: <a52f4521-8d02-496e-ac40-e8da5b1ec268@lucifer.local>
References: <cover.1679137163.git.lstoakes@gmail.com>
 <20230320164707.zpjhcwplkrp4tvgf@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320164707.zpjhcwplkrp4tvgf@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 12:47:07PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lstoakes@gmail.com> [230318 07:15]:
> > Following on from Vlastimil Babka's patch series "cleanup vma_merge() and
> > improve mergeability tests" which was in turn based on Liam's prior
> > cleanups, this patch series introduces changes discussed in review of
> > Vlastimil's series and goes further in attempting to make the logic as
> > clear as possible.
> >
> > Nearly all of this should have absolutely no functional impact, however it
> > does add a singular VM_WARN_ON() case.
>
> Thanks for looking at this function and adding more clarity.  I'm happy
> to have comments within the code, especially tricky areas.  But I find
> that adding almost 50 lines to this function makes it rather hard to
> follow.
>
> Can we remove the more obvious comments and possibly reduce the nesting
> of others so there are less lines?
>
> For example in patch 2:
>         /*
>          * If there is a previous VMA specified, find the next, otherwise find
>          * the first.
>          */
>         vma = find_vma(mm, prev ? prev->vm_end : 0);
>
> Is rather verbose for something that can be seen in the code itself.
>
> I think we are risking over-documenting what is going on here which is
> making the code harder to read; the function is pushing 200 lines now.
>
> >
> > Lorenzo Stoakes (4):
> >   mm/mmap/vma_merge: further improve prev/next VMA naming
> >   mm/mmap/vma_merge: set next to NULL if not applicable
> >   mm/mmap/vma_merge: extend invariants, avoid invalid res, vma
> >   mm/mmap/vma_merge: be explicit about the non-mergeable case
> >
> >  mm/mmap.c | 165 +++++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 107 insertions(+), 58 deletions(-)
> >
> > --
> > 2.39.2
>

Sure, I did try not to overdo things (once you start simplifying you can go
too far), but it seems like I _did_ go too far on the commenting (perhaps
pushing too far the other way).

I will simplify, remove things implied by the code and strip down + respin.
