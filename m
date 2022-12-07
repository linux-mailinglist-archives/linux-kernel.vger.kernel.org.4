Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C09064537D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLGFkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLGFkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:40:19 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26E0058012
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 21:40:19 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id DA10120B6C40; Tue,  6 Dec 2022 21:40:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA10120B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1670391618;
        bh=6L4SN9sqeQg1kBVQ7Wv7J5PUz/9QBV2D4TUzw2VzCtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=frEcGb/ho4Fik9QbOkU4s6Ff87yjSFaJvaZWwT+7mcSYuuCMWl0Gsh6No4zfEQclu
         +zXfHizeVD1Fqr/7G1CBlqWhOQL2bi62BmCQaJ8zlVG37St+NouMjIXcubv2bYVokO
         ZYIBlXw31JTMP4ztKDL30L5IGuDIDIBacNepZUVo=
Date:   Tue, 6 Dec 2022 21:40:18 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     ssengar@microsoft.com, akpm@linux-foundation.org, jack@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jostarks@microsoft.com, Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/gup: fix gup_pud_range() for dax
Message-ID: <20221207054018.GB23765@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1666289686-22798-1-git-send-email-ssengar@linux.microsoft.com>
 <CAOUHufbkcdyg8RAEa08DvKE=+bsxjuReiP4iscTV99sZ1oBQ2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufbkcdyg8RAEa08DvKE=+bsxjuReiP4iscTV99sZ1oBQ2g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 04:18:37PM -0600, Yu Zhao wrote:
> On Thu, Oct 20, 2022 at 12:14 PM Saurabh Sengar
> <ssengar@linux.microsoft.com> wrote:
> >
> > From: John Starks <jostarks@microsoft.com>
> >
> > For dax pud, pud_huge() returns true on x86. So the function works as long
> > as hugetlb is configured. However, dax doesn't depend on hugetlb.
> > Commit 414fd080d125 ("mm/gup: fix gup_pmd_range() for dax") fixed
> > devmap-backed huge PMDs, but missed devmap-backed huge PUDs. Fix this as
> > well.
> >
> > Fixes: 414fd080d125 ("mm/gup: fix gup_pmd_range() for dax")
> > Signed-off-by: John Starks <jostarks@microsoft.com>
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  mm/gup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 05068d3d2557..9e07aa54a4cd 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2687,7 +2687,7 @@ static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned lo
> >                 next = pud_addr_end(addr, end);
> >                 if (unlikely(!pud_present(pud)))
> >                         return 0;
> > -               if (unlikely(pud_huge(pud))) {
> > +               if (unlikely(pud_huge(pud) || pud_devmap(pud))) {
> 
> Perhaps s/pud_huge/pud_leaf/ ?
Looks good to me but I am not sure the wider impact of this, I will let maintainers
comment on it. Meanwhile I will send a V2 with more description of panic observed.
> 
> >                         if (!gup_huge_pud(pud, pudp, addr, next, flags,
> >                                           pages, nr))
> >                                 return 0;
> > --
> > 2.25.1
> >
