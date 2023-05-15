Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FC9702B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241265AbjEOLZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbjEOLZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:25:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B1C19BE
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:25:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so22301327a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684149916; x=1686741916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qYw5o0HvEEWDxkyofYj3KGUxctwFLArsyHtXdfw7FXA=;
        b=jbbvynNqFDwn5QGIBqkxPLjOSvS9oQg0sxK8yIwEW1+QFpaNk5RVVAxyeKo8OlEX8y
         TWq0itO/EsZROeoya7JAVtTucCE9VuwFEDst6h2TgueFAsjiZ+nfPNq40EU4WTySbNhD
         NP4m1kFt4ktBIXCefxWIG/SDV8rBzF2S49Ah3k/0dRQVsY7xF88UiXf6z3qaQzQ9CbEu
         CsMgHcBG/rk9NtzxOY6zQcQ5caE8et0FgVHapn7BHz3Lif7Mh+P1mBfRjMM6eU19jfmi
         3nOCUihOFR05tuKO6bhuiZjWTfJqa140N/1xcCUsUU1WYhO1qQKSIyP9zdRY4uE1otZH
         0FLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684149916; x=1686741916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYw5o0HvEEWDxkyofYj3KGUxctwFLArsyHtXdfw7FXA=;
        b=IEYTag1xfwLx2qKVsdoFL4bFYfwp/46oDRJb41b3FEs9yy6CSYQWqT+sG1FtjAYN1d
         SDf10Xd/kj2G3S83kxFTk+uaTuC6mJeA8B5MinOcVr1X10Y/hi5H5xBgXDo04a0fo0cb
         BGMvp/kn+biTPABk3UR+MG/2CNtEMFF7PTmpJDvSPPA+ROWxw21P+cSilCJfdJNZ7MTX
         FhKu95xN16JxtjdQmPsujXA1PAfP/eikaKv3iy4DzQV4MjiRMqYZliofOOmg2dnf3XpD
         sDi8nDuDPlvyqT+i4bpRYdzDgJFs+7Q3RE8hPnrGG1i6UF2ghp/WYniamFPnP8ZSq/8N
         1BWw==
X-Gm-Message-State: AC+VfDxIF/DF1sAwi6xflBUGjJacvW+uT4HUtqw3hrAfWifuarAst2ZW
        KS32G4Zfy/iI2PDK1lwQ868=
X-Google-Smtp-Source: ACHHUZ4Qid7cgUwxhiv6jrJ7EnqBsE3iqwJImnN2vzCNgOHm4KFYH0qvM0L5MJTHJ6iYr10udidLow==
X-Received: by 2002:a17:906:db08:b0:94f:1c90:cb70 with SMTP id xj8-20020a170906db0800b0094f1c90cb70mr30936700ejb.66.1684149915837;
        Mon, 15 May 2023 04:25:15 -0700 (PDT)
Received: from localhost ([31.94.21.70])
        by smtp.gmail.com with ESMTPSA id h9-20020a170906584900b0094e597f0e4dsm9248259ejs.121.2023.05.15.04.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 04:25:15 -0700 (PDT)
Date:   Mon, 15 May 2023 12:25:14 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RESEND PATCH v1 1/5] mm: vmalloc must set pte via arch code
Message-ID: <54ecd324-91ac-4fbc-8c47-46f12b2f5256@lucifer.local>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
 <20230511132113.80196-2-ryan.roberts@arm.com>
 <db1b8b8f-c3ac-4dbb-8b15-125c0929856a@lucifer.local>
 <2d43731e-3a38-c96e-320e-6a0dc16f10e4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d43731e-3a38-c96e-320e-6a0dc16f10e4@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 09:29:16AM +0100, Ryan Roberts wrote:
> Hi Lorenzo,
>
> Thanks for the review - I appreciate it!
>
>
> On 13/05/2023 14:14, Lorenzo Stoakes wrote:
> > You've not cc'd the vmalloc reviewers, including the author of 3e9a9e256b1e
> > whose patch you purport to fix. Please remember to run get_maintainers.pl
> > on all files you patch and cc them at least on relevant patches.
> >
> > Have added Christoph + Uladzislau as cc.
>
> I did run get_maintainers.pl, but it gave me 82 names. I assumed I wouldn't be
> making any friends by CCing everyone, so tried to choose what I thought was a
> sensible base. I guess I didn't quite get it right. Sorry about that. Thanks for
> noticing and adding the right people.

Right you mean across the whole of the patch set? Different people have
different approaches as to how to cc patch sets as a whole, but it's not
optional to include maintainers and reviewers on patches, so you should at least
cc- them on individual patches.

It's ok, it's really easy to mess this up, I have managed every variant of doing
this the wrong way myself... :)

>
> >
> > You'll definitely want an ack from Christoph on this!
> >
> > On Thu, May 11, 2023 at 02:21:09PM +0100, Ryan Roberts wrote:
> >> It is bad practice to directly set pte entries within a pte table.
> >> Instead all modifications must go through arch-provided helpers such as
> >> set_pte_at() to give the arch code visibility and allow it to validate
> >> (and potentially modify) the operation.
> >
> > This does make sense, and I see for example in xtensa that an arch-specific
> > instruction is issued under certain circumstances so I do suspect we should
> > do this.
>
> arm64 provides another example, where barriers are required to ensure the page
> table walker sees the new pte and no fault is raised. See
> arch/arm64/include/asm/pgtable.h:set_pte() (which is called by its
> implementation of set_pte_at()).

Ack, yeah I do think your patch is correct.

>
> >
> > As for validation, the function never indicates an error, so only in the
> > sense that a WARN_ON() could _in theory_ trigger is it being
> > validated. This might be quite a nitty point :) as set_pte_at() has no
> > means of indicating an error. But maybe to be pedantic 'check' rather than
> > 'validate'?
>
> I'm sorry, I'm not sure what you are asking here? set_pte_at() forms part of the
> contract with he arch code and is defined never to return an error. Some
> implementations might have code enabled in debug configs to detect incorrect
> usage and emit warnings (see arm64's implementation).

I'm saying that 'validate' implies to me that you assess whether the value is
correct and behave differently accordingly. It's something of a pedantic point,
but perhaps 'check' is better here.

>
> >
> >>
> >> Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
> >
> > Not sure if this is really 'fixing' anything, I mean ostensibly, but not
> > sure if the tag is relevant here, that is more so for a bug being
> > introduced, and unless an issue has arisen not sure if it's
> > appropriate. But this might be a nit, again!
>
> Well I'm happy to remove it if that's the concensus. But I do believe there is a
> real bug here. At least on arm64, the barriers are needed to prevent a race with
> the page table walker. That said, the only place in the tree I can see
> vmap_pfn() used, is in the i915 driver, which I guess has never been used on an
> arm64 platform.

Yeah, again this might be a little too nitty! And I totally understand where
you're coming from, I do agree this is appears to be an issue and your solution
is right, it just feels less like an obvious 'bug' and more of an oversight. But
I am being pedantic, and am not overly worried if you retain it :)

>
> >
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  mm/vmalloc.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >> index 9683573f1225..d8d2fe797c55 100644
> >> --- a/mm/vmalloc.c
> >> +++ b/mm/vmalloc.c
> >> @@ -2899,10 +2899,13 @@ struct vmap_pfn_data {
> >>  static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
> >>  {
> >>  	struct vmap_pfn_data *data = private;
> >> +	pte_t ptent;
> >>
> >>  	if (WARN_ON_ONCE(pfn_valid(data->pfns[data->idx])))
> >>  		return -EINVAL;
> >> -	*pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
> >> +
> >> +	ptent = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
> >> +	set_pte_at(&init_mm, addr, pte, ptent);>
> > While we're refactoring, it'd be nice to stash data->pfns[data->idx] into a
> > local pfn variable.
>
> OK, I'll do this for v2.

Thanks!

>
> Thanks,
> Ryan
>
>
> >
> >>  	return 0;
> >>  }
> >>
> >> --
> >> 2.25.1
> >>
>

Sorry to get into the weeds here a bit, overall I think this patch is fine, I
would like Christoph to take a look given it's his code however.
