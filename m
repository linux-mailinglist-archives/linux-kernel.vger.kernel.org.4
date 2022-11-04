Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF861A405
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiKDWXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKDWXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:23:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EAA5FDE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667600626; x=1699136626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jyyE3UFh52oFOY3mzA8Q7BVvcDMLwn6B9acrscYPruM=;
  b=f6KqY1C54s92AxCJr7DBeG2OjBgp9L/8kqMVxzcAYzaJy+VHKQ27mpm+
   DXqe1jJUvZItrlLA4WNbofNmaOPQbu3JpznFPt5k+eK2jCQr9ADoj+eHq
   hZljwRW3m61SFMNeMAoQi4fqXuARyARCqtvVW+lebS3oDldMDdhq9dMFX
   AhIMaGoi4Uij9lndDrVlsbmJRUzwVq+U+elsYK5XsNn79rWDPm5jdamcE
   zLG3Gra9eYhNpEgQzEPxUIJ+DngVdskcXTGYb1oCLvPOdhGkm93PaoU9e
   RFscW4TrL6wV1pbTFZUY/PjJVuinPH96FCECi3QAUA1Tlpi5aezQav3vM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="290476216"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="290476216"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="613223490"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="613223490"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by orsmga006.jf.intel.com with SMTP; 04 Nov 2022 15:23:41 -0700
Received: by stinkbox (sSMTP sendmail emulation); Sat, 05 Nov 2022 00:23:40 +0200
Date:   Sat, 5 Nov 2022 00:23:40 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        regressions@lists.linux.dev, naoya.horiguchi@nec.com
Subject: Re: [mm-unstable PATCH v7 2/8] mm/hugetlb: make pud_huge() and
 follow_huge_pud() aware of non-present pud entry
Message-ID: <Y2WQ7I4LXh8iUIRd@intel.com>
References: <Y2LYXItKQyaJTv8j@intel.com>
 <20221104155930.GA527246@ik1-406-35019.vs.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221104155930.GA527246@ik1-406-35019.vs.sakura.ne.jp>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 12:59:30AM +0900, Naoya Horiguchi wrote:
> On Wed, Nov 02, 2022 at 10:51:40PM +0200, Ville Syrjälä wrote:
> > On Thu, Jul 14, 2022 at 01:24:14PM +0900, Naoya Horiguchi wrote:
> > > +/*
> > > + * pud_huge() returns 1 if @pud is hugetlb related entry, that is normal
> > > + * hugetlb entry or non-present (migration or hwpoisoned) hugetlb entry.
> > > + * Otherwise, returns 0.
> > > + */
> > >  int pud_huge(pud_t pud)
> > >  {
> > > -	return !!(pud_val(pud) & _PAGE_PSE);
> > > +	return !pud_none(pud) &&
> > > +		(pud_val(pud) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
> > >  }
> > 
> > Hi,
> > 
> > This causes i915 to trip a BUG_ON() on x86-32 when I start X.
> 
> Hello,
> 
> Thank you for finding and reporting the issue.
> 
> x86-32 does not enable CONFIG_ARCH_HAS_GIGANTIC_PAGE, so pud_huge() is
> supposed to be false on x86-32.  Doing like below looks to me a fix
> (reverting to the original behavior for x86-32):
> diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
> index 6b3033845c6d..bf73f25aaa32 100644
> --- a/arch/x86/mm/hugetlbpage.c
> +++ b/arch/x86/mm/hugetlbpage.c
> @@ -37,8 +37,12 @@ int pmd_huge(pmd_t pmd)
>   */
>  int pud_huge(pud_t pud)
>  {
> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>         return !pud_none(pud) &&
>                 (pud_val(pud) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
> +#else
> +       return !!(pud_val(pud) & _PAGE_PSE);    // or "return 0;" ?
> +#endif
>  }
> 
>  #ifdef CONFIG_HUGETLB_PAGE
> 
> 
> Let me guess what the PUD entry was there when triggering the issue.
> Assuming that the original code (before 3a194f3f8ad0) was correct, the PSE
> bit in pud_val(pud) should be always cleared.  So, when pud_huge() returns
> true since 3a194f3f8ad0, the PRESENT bit should be clear and some other
> bits (rather than PRESENT and PSE) are set so that pud_none() is false.
> I'm not sure what such a non-present PUD entry does mean.

pud_val()==0 when it blows up, and pud_none() is false because
pgtable-nopmd.h says so with 2 level paging.

And given that I just tested with PAE / 3 level paging, 
and sure enough it no longer blows up.

So looks to me like maybe this new code just doesn't understand
how the levels get folded.

I might also be missing something obvious, but why is it even
necessary to treat PRESENT==0+PSE==0 as a huge entry?

-- 
Ville Syrjälä
Intel
