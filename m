Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996A76CB5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjC1FOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjC1FOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:14:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C93010DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 22:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c+upOLAl1tNic16x8Kml180+4+m4/ZhbaMD9TGfmxxs=; b=fKGRKKkajfjv/3r8kcgNgFQfnP
        ikAfkwv4pEVGu1o8CVFNaLzRiEME/UkqQWM+50kX8UwmxxNrySdrHVZiFVyVVCp6LHsCCMW4l7Aaq
        VISqY0jRfjcgpSbf4jTNXj0ZZAOaddN9RU8H40G+o/+e0hm2ZRSBdP5Q8piYFC6GEB1tOyl9leUqd
        AnLBLn2a3zmQokWbjKZokz7VD9V234oSaNtlzWAVDhdY6MVnLBK7puPV6n9WYqnjdGpb9nb+YSnc0
        Rgmj1nu28F+MvOTyEcvGYg+N2heuu+xsfCm7o1kIB7WLirtaN+TGL4jxlkQsY0P4vg+qAfChjzgXG
        IvqkkaWQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ph1fH-00DA9M-2y;
        Tue, 28 Mar 2023 05:14:35 +0000
Date:   Mon, 27 Mar 2023 22:14:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jeff Layton <jlayton@kernel.org>, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: 9p caching with cache=loose and cache=fscache
Message-ID: <ZCJ3uzqDk6RPd28j@bombadil.infradead.org>
References: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org>
 <CAFkjPTmVbyuA0jEAjYhsOsg-SE99yXgehmjqUZb4_uWS_L-ZTQ@mail.gmail.com>
 <ZBSc1jjYJn6noeMl@bombadil.infradead.org>
 <CAFkjPTmc-OgMEj9kF3y04sRGeOVO_ogEv1fGG=-CfKP-0ZKC_g@mail.gmail.com>
 <ZCHU6k56nF5849xj@bombadil.infradead.org>
 <ZCJRlqc/epbRhm93@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCJRlqc/epbRhm93@codewreck.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:31:50AM +0900, Dominique Martinet wrote:
> Luis Chamberlain wrote on Mon, Mar 27, 2023 at 10:39:54AM -0700:
> > > I have fixed what
> > > I hope to be my last bug with the new patch series so it should be
> > > going into linux-next today.
> > 
> > Nice, thanks, since kdevops relies on a host kernel though and we strive
> > to have stability for that, I personally like to recommend distro
> > kernels and so they're a few kernel releases out of date. So debian-testing
> > is on 6.1 as of today for example.
> > [...]
> > -    opts: "ro,trans=virtio,version=9p2000.L,posixacl,cache=loose"
> > +    opts: "ro,trans=virtio,version=9p2000.L,posixacl,cache=none"
> 
> Yes, if you want something mostly coherent with the host, cache=none (or
> cache=mmap if you need mmap, iirc linux build does for linking? if you
> want to do that on guest...) is what you'll want to use on current
> kernels.

OK cool, we use 9p to build on the host and so all the guest has to do
is just 'make modules_install install'.

> > BTW the qemu wiki seems to suggest cache=loose and its why I used it on
> > kdevops as a default. What about the following so to avoid folks running
> > into similar issues? I can go and update the wiki too.
> 
> I've added Christian in Cc for this point, he's more active on the qemu
> side
> (thread started here:
> https://lkml.kernel.org/r/ZA0FEyOtRBvpIXbi@bombadil.infradead.org
> )
> 
> I have no opinion on the current wording, the default is there for a
> reason and it's a safe default (none), and cache=loose is clearly
> described with "no attempts are made at consistency, intended for
> exclusive, read-only mounts" which I think ought to be clear enough
> (exclusive means not shared with the host), but if you think it's not
> clear enough it probably isn't.

It certainly was not.

  LUis
