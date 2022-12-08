Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA9A646816
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 05:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLHEIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 23:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLHEIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 23:08:42 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 397CF81DBB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 20:08:42 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 9B11E20B83E2; Wed,  7 Dec 2022 20:08:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B11E20B83E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1670472521;
        bh=vcwrQocosi4LmOsysrsc5qbkkt0d5VHvi+wuU+bw0i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnO5hSg6ee/12BCZc/RGMGbteux3ixpgoBgR3nuDXYJxRFMgehB2+4z+MryrGMO6e
         qKHiMoUVuncqfQrVlGPBSD2BQI0sF6X83npeH69tyaXDR+MaKthdVF7SaanO4GD2QB
         b66xaS8Q+lAfo5z7pfWxLN6IynbWHsXkzdBmCLw4=
Date:   Wed, 7 Dec 2022 20:08:41 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ssengar@microsoft.com, yuzhao@google.com, jack@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jostarks@microsoft.com
Subject: Re: [PATCH v2] mm/gup: fix gup_pud_range() for dax
Message-ID: <20221208040841.GA19421@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1670392853-28252-1-git-send-email-ssengar@linux.microsoft.com>
 <20221207133130.f4894372d295f99fd4954255@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207133130.f4894372d295f99fd4954255@linux-foundation.org>
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

On Wed, Dec 07, 2022 at 01:31:30PM -0800, Andrew Morton wrote:
> On Tue,  6 Dec 2022 22:00:53 -0800 Saurabh Sengar <ssengar@linux.microsoft.com> wrote:
> 
> > From: John Starks <jostarks@microsoft.com>
> > 
> > For dax pud, pud_huge() returns true on x86. So the function works as long
> > as hugetlb is configured. However, dax doesn't depend on hugetlb.
> > Commit 414fd080d125 ("mm/gup: fix gup_pmd_range() for dax") fixed
> > devmap-backed huge PMDs, but missed devmap-backed huge PUDs. Fix this as
> > well.
> > 
> > This fixes the below kernel panic:
> > 
> > ...
> >
> > Fixes: 414fd080d125 ("mm/gup: fix gup_pmd_range() for dax")
> 
> Feb 2019.
> 
> > Signed-off-by: John Starks <jostarks@microsoft.com>
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  mm/gup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index c2c2c6d..e776540 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2765,7 +2765,7 @@ static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned lo
> >  		next = pud_addr_end(addr, end);
> >  		if (unlikely(!pud_present(pud)))
> >  			return 0;
> > -		if (unlikely(pud_huge(pud))) {
> > +		if (unlikely(pud_huge(pud) || pud_devmap(pud))) {
> >  			if (!gup_huge_pud(pud, pudp, addr, next, flags,
> >  					  pages, nr))
> >  				return 0;
> 
> I assume this should be backported into -stable kernels?
That would be helpful, thanks.

