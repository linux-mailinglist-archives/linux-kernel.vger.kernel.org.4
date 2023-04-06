Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323E66D9BDD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbjDFPKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjDFPKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:10:34 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0EF619F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:10:21 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E59215C0074;
        Thu,  6 Apr 2023 11:10:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 06 Apr 2023 11:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680793818; x=
        1680880218; bh=kle+3MjwA/FACHeFyfz4d/CYe30DnTpHJq8Ft3L5awo=; b=q
        qFxeVR8kQzRjSzroq+RMsVS1LiHsTBJBncFK3aBNqfVe7wnvkWragFvgfXxbgpZ7
        s2gG7CBKUs6z+2BrXqaOEpOFtZZ7WpbgV9+277RH1K448dAnhsipYaoO6C9mz9aL
        09QRzAZ5cOdle1Cy3QCUgSyGKt6H6KYc1myTtXIvgUyWGy+WwPr5pmMnPxHHhVrW
        sCKemEfPzMkeARhvLBopCe4OL5xVJVJD/cfrPqdrYSl2gT31qksMRc8QVwx4dy1m
        UJDjhhhxta+LtMjPr5k4xVTuhP2V/dUFKo9UT6c7wZFUwlZ7+1YLVuNds9Z/ZEre
        wInek6feFMwmcelwTgwow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680793818; x=1680880218; bh=kle+3MjwA/FAC
        HeFyfz4d/CYe30DnTpHJq8Ft3L5awo=; b=Vwa+ngHmVkHe7IrHgxRyO/cCv779M
        PYkVagl7CbDgF+i63Y5nCTWEd9719OPRVhrO2RifY6e2seMjompaMQxkasbGF7SZ
        gPxSWYRj2KeE/ojuthkmSOJXtaCPmXqisx5HvxXzGiLRThmjWK1UXFOdjRcmzgdJ
        vaobDDkKH7ob1XYwr3EgJuDlGWeFlLOCqVRpTFutyDP4+ojk2869zxX5n7mVV6qs
        WLI/QXuEDPc9sfhegs33zrIyfYI0GDzEoCAV+VDx97csE6OeZgiqJS8J/yTbaA5X
        rRCJIoCLOsj/HQryW2JtxNQsxE+dC7ggJQXwg/D7RQXDAM7e9M/bFPiqg==
X-ME-Sender: <xms:2uAuZE_NpgQwMkT6KsL78SVmwttdhuRgXTAn3-f1bOjnYTCm3hSsAQ>
    <xme:2uAuZMuAROYtTD-r9zbZlaGwpWcfA2Us7_4_JHWIkpoOsLM_jvhH9YCi56ioZBM6f
    dQZSwYg3Famht85XuE>
X-ME-Received: <xmr:2uAuZKCQZVOtsS_mtEXLOr0RBhAc2uJh81_581uyIU4B3rzlNpNeHF9f_1mMNv5ULiV-Aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    dttddttddvnecuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehk
    ihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnheplefghf
    efteelhfevffelveffgfetffefleefudduhfejudetgefgieehfeetheejnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:2uAuZEfAkRoOq42kKZrH_n1UBv1Da26QNk-Ri2OxZcL0oAGZCkUgiQ>
    <xmx:2uAuZJNshlKuEES4VVWPC4RXMIrxCd_U_caPdyVK2VddMJ2lqekknQ>
    <xmx:2uAuZOnoMvujFt5cEdgNPEYp3qHcYaWC0oPkTzS8yMogBt62Rs3wVg>
    <xmx:2uAuZKoijkY33tpLZO0Kr9K4QV8Oz7wimz_tSHjkJfHClDqHOsJslQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 11:10:18 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 13781109B00; Thu,  6 Apr 2023 18:10:15 +0300 (+03)
Date:   Thu, 6 Apr 2023 18:10:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Guenter Roeck <linux@roeck-us.net>, Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm-treewide-redefine-max_order-sanely-fix.txt
Message-ID: <20230406151015.yndcm24fyxitvqyc@box.shutemov.name>
References: <9460377a-38aa-4f39-ad57-fb73725f92db@roeck-us.net>
 <20230406072529.vupqyrzqnhyozeyh@box.shutemov.name>
 <83e6bc46-dfc0-0e95-e69c-5b996af1e50b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83e6bc46-dfc0-0e95-e69c-5b996af1e50b@roeck-us.net>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 06:57:41AM -0700, Guenter Roeck wrote:
> On 4/6/23 00:25, Kirill A. Shutemov wrote:
> > On Wed, Apr 05, 2023 at 10:20:26PM -0700, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > On Wed, Mar 15, 2023 at 06:38:00PM +0300, Kirill A. Shutemov wrote:
> > > > fix min() warning
> > > > 
> > > > Link: https://lkml.kernel.org/r/20230315153800.32wib3n5rickolvh@box
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >    Link: https://lore.kernel.org/oe-kbuild-all/202303152343.D93IbJmn-lkp@intel.com/
> > > > Signed-off-by: "Kirill A. Shutemov" <kirill@shutemov.name>
> > > > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > > Cc: Zi Yan <ziy@nvidia.com>
> > > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > 
> > > This patch results in various boot failures (hang) on arm targets
> > > in linux-next. Debug messages reveal the reason.
> > > 
> > > ########### MAX_ORDER=10 start=0 __ffs(start)=-1 min()=10 min_t=-1
> > >                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > 
> > > If start==0, __ffs(start) returns 0xfffffff or (as int) -1, which min_t()
> > > interprets as such, while min() apparently uses the returned unsigned long
> > > value. Obviously a negative order isn't received well by the rest of the
> > > code.
> > 
> > Actually, __ffs() is not defined for 0.
> > 
> > Maybe something like this?
> > 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 7911224b1ed3..63603b943bd0 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2043,7 +2043,11 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
> >   	int order;
> >   	while (start < end) {
> > -		order = min_t(int, MAX_ORDER, __ffs(start));
> > +		/* __ffs() behaviour is undefined for 0 */
> > +		if (start)
> > +			order = min_t(int, MAX_ORDER, __ffs(start));
> > +		else
> > +			order = MAX_ORDER;
> 
> Shouldn't that be
> 		else
> 			order = 0;
> ?

+Mike.

No. start == 0 is MAX_ORDER-aligned. We want to free the pages in the
largest chunks alignment allows.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
