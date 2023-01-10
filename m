Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4019E664716
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjAJRMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjAJRMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:12:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B0326C7;
        Tue, 10 Jan 2023 09:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KzyBivF3n+NLA7hD9FZvYWloVx6WyXwO0Pajf7egvG0=; b=tz4J2g+jd26/N0rmKmzqyLWQOY
        L3XdVvcTZgbNDGnojGB69jY+TugwDxwEitrhHklYmJpab4GWYpqoE2GP83iaA+DkpO+M3Irn1srP3
        snw37rzzuKQrvzAKhZVsw2yidFo5ximHSEsTfr3gbTVmYxE5khRmPBFKZLS1z5qNK3u19KLbWsia4
        PvCSisMD2UZCZH+1o3Wa/vKcO1F3tQeCFTe7hzmvgm304t2OKntJWP89H+WOUIWxi9QvFo+qwTpcL
        Eo1UCp0YBz/nBhQnYgpmDmKJzDc9lmD2V0d+aPjPoygZmgulh3YiroyLVzo9JKbFMapsSoptVSjoN
        cOdmmluA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFIAU-007vT0-1x; Tue, 10 Jan 2023 17:12:10 +0000
Date:   Tue, 10 Jan 2023 09:12:10 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] kallsyms: Fix sleeping function called from invalid
 context when CONFIG_KALLSYMS_SELFTEST=y
Message-ID: <Y72casXMXhedox8r@bombadil.infradead.org>
References: <20221228014511.328-1-thunder.leizhen@huawei.com>
 <Y7wZSxw+Ys5MNf8g@alley>
 <Y7ythXxlzsJkFQcd@bombadil.infradead.org>
 <Y702gW+5P5EepCkG@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y702gW+5P5EepCkG@alley>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 10:57:21AM +0100, Petr Mladek wrote:
> On Mon 2023-01-09 16:12:53, Luis Chamberlain wrote:
> > On Mon, Jan 09, 2023 at 02:40:27PM +0100, Petr Mladek wrote:
> > > Why are try hardly comparable?
> > > 
> > > 1. The speed depends on the number of loaded modules
> > >    and number of symbols. It highly depends on the configuration
> > >    that was used to build the kernel.
> > > 
> > > 2. The test runs only once. As a result it is hard to judge
> > >    how big is the noise.
> > > 
> > > 3. The noise might depend on the size and state of CPU caches.
> > > 
> > > 
> > > I personally vote for removing this selftest!
> > 
> > Even so, just as with testing a filesystem with different types of
> > configurations, at least testing a few configs helps and it's what
> > we do. Then, if anyone ever wanted to try to increase performance
> > on symbol lookup today they have no easy way to measure things. How
> > would they go about comparing things performance without this selftest?
> 
> How many people cares about kallsyms performance, please?
> Is it worth spending time one implementing and maintaining such a
> selftest?

If someone is willing to *try* put the effort to do it as they are optimizing
it, then by all means it is welcomed effort.

> Yes, Zhen wanted to make it faster. But how likely will anyone else
> try to make it even better? Do we need to spend time on this
> in the meantime?

I can't say.

> > This selftests helps generically with that *and* helps peg on to it any sanity
> > checks you may wish to add to those APIs which we just don't want to do
> > upstream.
> 
> From my POV, it would be much more important to check if the API
> works as expected. I mean that it gives the right results.

Sure, but that's just one aspect of it. And before the selftests we
didn't have that either.

> I am not sure that performance is that important to spend more time
> on this one.
> 
> Also I am not sure if selftests are the right location for performance
> tests. My understanding is that it is a framework for functional
> testing. It is showing if the tests passed or not. But performance
> tests do not give "pass or not" results.

Sefltests have no rules, you do what you want, for your own use. It
is up to you for your own subsystem.

But I do agree that if we want a performance data, it should be reliable
and so if that cannot be done today then best just remove it until it
can be done.

  Luis
