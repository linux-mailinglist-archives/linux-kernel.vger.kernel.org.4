Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDA372695D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjFGTDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFGTDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:03:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA21193
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEB1061779
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 19:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38B2C433D2;
        Wed,  7 Jun 2023 19:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686164593;
        bh=6rM3c0MzWmypFl9SNFBILYmJFrC7/yHDs2cmHU7fDRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ssml13aGyZyJ3ub78D/30u0UL0IB0MjCmCDTGHBI1B8L+zNeaRQzmtYap1KIiZzbx
         iwFHzqzJ92fkaq893W+6Uo0nFRdBZC7b8EpitBAsS/01f3s27OicNfWuDXwzFKTj1R
         gw6wXPo7gPLbJ2AOYwKqRyVsaoO4q6ZVJ3EHYaIc=
Date:   Wed, 7 Jun 2023 12:03:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Junxiao Chang <junxiao.chang@intel.com>,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        jmarchan@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Dongwon Kim <dongwon.kim@intel.com>,
        James Houghton <jthoughton@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] mm: fix hugetlb page unmap count balance issue
Message-Id: <20230607120312.6da5cea7677ec1a3da35b92c@linux-foundation.org>
In-Reply-To: <20230516223440.GA30624@monkey>
References: <20230512072036.1027784-1-junxiao.chang@intel.com>
        <CADrL8HV25JyeaT=peaR7NWhUiaBz8LzpyFosYZ3_0ACt+twU6w@mail.gmail.com>
        <20230512232947.GA3927@monkey>
        <20230515170259.GA3848@monkey>
        <20230516223440.GA30624@monkey>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 15:34:40 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> On 05/15/23 10:04, Mike Kravetz wrote:
> > On 05/12/23 16:29, Mike Kravetz wrote:
> > > On 05/12/23 14:26, James Houghton wrote:
> > > > On Fri, May 12, 2023 at 12:20 AM Junxiao Chang <junxiao.chang@intel.com> wrote:
> > > > 
> > > > This alone doesn't fix mapcounting for PTE-mapped HugeTLB pages. You
> > > > need something like [1]. I can resend it if that's what we should be
> > > > doing, but this mapcounting scheme doesn't work when the page structs
> > > > have been freed.
> > > > 
> > > > It seems like it was a mistake to include support for hugetlb memfds in udmabuf.
> > > 
> > > IIUC, it was added with commit 16c243e99d33 udmabuf: Add support for mapping
> > > hugepages (v4).  Looks like it was never sent to linux-mm?  That is unfortunate
> > > as hugetlb vmemmap freeing went in at about the same time.  And, as you have
> > > noted udmabuf will not work if hugetlb vmemmap freeing is enabled.
> > > 
> > > Sigh!
> > > 
> > > Trying to think of a way forward.
> > > -- 
> > > Mike Kravetz
> > > 
> > > > 
> > > > [1]: https://lore.kernel.org/linux-mm/20230306230004.1387007-2-jthoughton@google.com/
> > > > 
> > > > - James
> > 
> > Adding people and list on Cc: involved with commit 16c243e99d33.
> > 
> > There are several issues with trying to map tail pages of hugetllb pages
> > not taken into account with udmabuf.  James spent quite a bit of time trying
> > to understand and address all the issues with the HGM code.  While using
> > the scheme proposed by James, may be an approach to the mapcount issue there
> > are also other issues that need attention.  For example, I do not see how
> > the fault code checks the state of the hugetlb page (such as poison) as none
> > of that state is carried in tail pages.
> > 
> > The more I think about it, the more I think udmabuf should treat hugetlb
> > pages as hugetlb pages.  They should be mapped at the appropriate level
> > in the page table.  Of course, this would impose new restrictions on the
> > API (mmap and ioctl) that may break existing users.  I have no idea how
> > extensively udmabuf is being used with hugetlb mappings.
> 
> Verified that using udmabug on a hugetlb mapping with vmemmap optimization will
> BUG as:

BUGs aren't good.  Can we please find a way to push this along?

Have we heard anything from any udmabuf people?


