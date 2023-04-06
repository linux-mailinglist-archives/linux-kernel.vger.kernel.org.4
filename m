Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4968B6DA203
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbjDFTxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjDFTxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:53:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26BF5253;
        Thu,  6 Apr 2023 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=p8aOV66JPpjAHa0iNDBc0x7MW11SfW/PEWlKFLcuUnA=; b=qhfV3QJ+Bi++LgFLjw1MU3Ape+
        9SqEg8M7YW5KJpC/tPepuEpFK/8afBBrrRj+t5RDaBVxfAGTCxP393ma7qguwVITELHM9N97V39AP
        G8gs72J0brcUfm7x5570AGhYvGj1Rmv+7+Vyuk7kuL9FRAjdVT5f1OV5wtJ+5/CgptUUZqhggXBwV
        xEnEXV7X8fd9EbXVE7hsjZIDuwuKuDnjlZZrkXup1JA/PZI0HWNP0ThgJSwoqxHltAqqD9jeih53Z
        dhllPfgRK7oVvJ3QNyUpCjubetq1PK3CKYGnaKDotcIAAnv3GVqARrptBaX4tEkmwRF08MNlSN9vh
        tcu/WMOg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pkVfu-008RKE-0Q;
        Thu, 06 Apr 2023 19:53:38 +0000
Date:   Thu, 6 Apr 2023 12:53:38 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jim.cromie@gmail.com
Cc:     Song Liu <song@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: kmemleaks on ac3b43283923 ("module: replace module_layout with
 module_memory")
Message-ID: <ZC8jQmbie6RWVyXo@bombadil.infradead.org>
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
 <ZCaE71aPvvQ/L05L@bombadil.infradead.org>
 <CAPhsuW6P5AYVKMk=G1bEUz5PGZKmTJwtgQBmE-P4iAo7dOr5yA@mail.gmail.com>
 <ZCs6jpo1nYe1Wm08@bombadil.infradead.org>
 <CAJfuBxzGJvrJo9nTXxZ3xZ7QmdSb6YxBw-bojZjQTpACBeK_sQ@mail.gmail.com>
 <ZCzWdLOg1i2p1Q67@bombadil.infradead.org>
 <CAJfuBxw7F5yN=F=i_0ZZ0b2EpWU4T=RXaf13qG9XVq6tG-EGJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfuBxw7F5yN=F=i_0ZZ0b2EpWU4T=RXaf13qG9XVq6tG-EGJQ@mail.gmail.com>
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

On Wed, Apr 05, 2023 at 09:14:12PM -0600, jim.cromie@gmail.com wrote:
> On Tue, Apr 4, 2023 at 8:01 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Tue, Apr 04, 2023 at 07:38:41PM -0600, jim.cromie@gmail.com wrote:
> > > On Mon, Apr 3, 2023 at 2:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:

<-- my old patch -->

> this disappearing act is still going on.
> my script issues no echo clear > kmemleak

So this email is ab it confusing. Because you comment here before the
new patch.

<-- my new switch statement kmemleak patch to fix the reported leak -->

> sorry for the delay, I was seeing heisen-responses, and several BUGs.
> a make clean seems to have settled things mostly.

And now here you comment after thew new suggested patch and say it
seemst to mostly fixed things.

> But in case theres any clues in there,

In where?

> Ive kept the paste-in of 2 BUGs
> 
> with
> f23cd1ffca4b (HEAD) kmemleaks on ac3b43283923 ("module: replace
> module_layout with module_memory")
> ac3b43283923 module: replace module_layout with module_memory

The only commit here that makes sense to me is

ac3b43283923 ("module: replace module_layout with module_memory"

Commit f23cd1ffca4b means absolutely nothing to me. I can only guess
you mean that you've applied my suggested changes with the new switch
statement?

> heres the 1st run.  cuz it leaked, I reran in another vm, which got
> different results.
> I left it overnight doing nothing (laptop slept, vm with it),
> and it BUG'd on a soft lockup
> (much later, but the leaktrace does have a timerfd in it)
> R11 looks poisoned.

<-- some unrelated leak I think -->

> using sh-script posted previously,

I don't recall what that sh-script was.

<-- snip some leaks -->

> Im not sure when I did the make clean, maybe here.
> it'd be a 'clean' explanation of the BUG struff.
> I havent seen any today

OK great.

<-- snip some long traces-->

I don't get these long traces if you didn't see any then.

  Luis
