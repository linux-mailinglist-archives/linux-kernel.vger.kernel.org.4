Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8C6DE7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 01:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjDKXBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 19:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKXBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 19:01:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1500DDA;
        Tue, 11 Apr 2023 16:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=uA2hCTgdMV/heqzAqJQlXsa/2lF8jk1ShKW1BBduEvY=; b=2D+cwJvW1+x3eLKfERE1bHV1LO
        0eBxeeMsrwpGmo4KgsDzPRvt/Tt/LX1E37lv71F1ftbMxFZ3+Kr6kytOJArFe7Gct2noVjklKJ1lW
        nlaj27OlEPyXUBfMISmBlCDjcLIiUYwT6Io4mgmNvTAZHV3xUoAOwngzRaTm5ogr6g1ZxDiaqOnvy
        2ZTvT0lNiUDLuBpSeSNlh3EIywIEpbQ+o+N3oGG9njWAR8JivVb8cO5UZ107xoYV5khOG9YGc5IjI
        qsPvpRgMeQ9DIudoXubV9T9xZQ9cP7w6ASS1lk8TYskPgx6d/B187ayuTxfrNvNqCaTYK4QZijYbx
        LIpvKcjg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pmMyx-001IjV-1M;
        Tue, 11 Apr 2023 23:00:59 +0000
Date:   Tue, 11 Apr 2023 16:00:59 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Song Liu <song@kernel.org>, jim.cromie@gmail.com,
        linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: kmemleaks on ac3b43283923 ("module: replace module_layout with
 module_memory")
Message-ID: <ZDXmq1B2W0h2rrYW@bombadil.infradead.org>
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
 <ZCaE71aPvvQ/L05L@bombadil.infradead.org>
 <CAPhsuW6P5AYVKMk=G1bEUz5PGZKmTJwtgQBmE-P4iAo7dOr5yA@mail.gmail.com>
 <ZCs6jpo1nYe1Wm08@bombadil.infradead.org>
 <ZDV4YGjRpuqcI7F3@arm.com>
 <ZDWT6UoWshTUBU+u@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZDWT6UoWshTUBU+u@bombadil.infradead.org>
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

On Tue, Apr 11, 2023 at 10:07:53AM -0700, Luis Chamberlain wrote:
> On Tue, Apr 11, 2023 at 04:10:24PM +0100, Catalin Marinas wrote:
> > On Mon, Apr 03, 2023 at 01:43:58PM -0700, Luis Chamberlain wrote:
> > > On Fri, Mar 31, 2023 at 05:27:04PM -0700, Song Liu wrote:
> > > > On Fri, Mar 31, 2023 at 12:00 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > > On Thu, Mar 30, 2023 at 04:45:43PM -0600, jim.cromie@gmail.com wrote:
> > > > > > kmemleak is reporting 19 leaks during boot
> > > > > >
> > > > > > because the hexdumps appeared to have module-names,
> > > > > > and Ive been hacking nearby, and see the same names
> > > > > > every time I boot my test-vm, I needed a clearer picture
> > > > > > Jason corroborated and bisected.
> > > > > >
> > > > > > the 19 leaks split into 2 groups,
> > > > > > 9 with names of builtin modules in the hexdump,
> > > > > > all with the same backtrace
> > > > > > 9 without module-names (with a shared backtrace)
> > > > > > +1 wo name-ish and a separate backtrace
> > > > >
> > > > > Song, please take a look.
> > > > 
> > > > I will look into this next week.
> > > 
> > > I'm thinking this may be it, at least this gets us to what we used to do
> > > as per original Catalinas' 4f2294b6dc88d ("kmemleak: Add modules
> > > support") and right before Song's patch.
> > > 
> > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > index 6b6da80f363f..3b9c71fa6096 100644
> > > --- a/kernel/module/main.c
> > > +++ b/kernel/module/main.c
> > > @@ -2240,7 +2240,10 @@ static int move_module(struct module *mod, struct load_info *info)
> > >  		 * which is inside the block. Just mark it as not being a
> > >  		 * leak.
> > >  		 */
> > > -		kmemleak_ignore(ptr);
> > > +		if (type == MOD_INIT_TEXT)
> > > +			kmemleak_ignore(ptr);
> > > +		else
> > > +			kmemleak_not_leak(ptr);
> > >  		if (!ptr) {
> > >  			t = type;
> > >  			goto out_enomem;
> > > 
> > > We used to use the grey area for the TEXT but the original commit
> > > doesn't explain too well why we grey out init but not the others. Ie
> > > why kmemleak_ignore() on init and kmemleak_not_leak() on the others.
> > 
> > It's safe to use the 'grey' colour in all cases. For text sections that
> > don't need scanning, there's a slight chance of increasing the false
> > negatives, 
> 
> It turns out that there are *tons* of false positives today, unless
> these are real leaks.

I should clarify: *if* we leave things as-is, we seem to get tons of
false positives.

  Luis
