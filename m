Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5667725AFD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbjFGJqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjFGJqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:46:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40219EB;
        Wed,  7 Jun 2023 02:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 961E063526;
        Wed,  7 Jun 2023 09:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EF7C433D2;
        Wed,  7 Jun 2023 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686131178;
        bh=Hr4rBiNWgGFLHEUkJ6fJ0SmEH1IK0S4xufK3cOEzt8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4O3BnD+iBFljIz6bc+MRDzP6j9A4YW5JRg1OH8QiTSmUm9x+xd3ybL1fUr4AjAnm
         8yUolAP2YS/0ceZ4K3aBEhehVQL5Ak/0/sw6DIPWvsZSNhfggLWO4sig0wgYarXqMT
         JODzFKDXQj5LclUj3eYGm4/FuwGh66AUJrZaFGuA=
Date:   Wed, 7 Jun 2023 11:46:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Jiri Kosina <jikos@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
Message-ID: <2023060703-colony-shakily-3514@gregkh>
References: <20230531082428.21763-1-hadess@hadess.net>
 <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
 <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info>
 <nycvar.YFH.7.76.2306061527080.29760@cbobk.fhfr.pm>
 <42b6e582-f642-7521-135a-449140984211@leemhuis.info>
 <CAO-hwJL3RcfOxQvhqDFTwgfY=oAJqR5rsHmO5qDVwNUEh3K58Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-hwJL3RcfOxQvhqDFTwgfY=oAJqR5rsHmO5qDVwNUEh3K58Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:37:26PM +0200, Benjamin Tissoires wrote:
> On Tue, Jun 6, 2023 at 8:18 PM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
> >
> >
> >
> > On 06.06.23 15:27, Jiri Kosina wrote:
> > > On Mon, 5 Jun 2023, Linux regression tracking (Thorsten Leemhuis) wrote:
> > >
> > >>>>> If an attempt at contacting a receiver or a device fails because the
> > >>>>> receiver or device never responds, don't restart the communication, only
> > >>>>> restart it if the receiver or device answers that it's busy, as originally
> > >>>>> intended.
> > >>>>>
> > >>>>> This was the behaviour on communication timeout before commit 586e8fede795
> > >>>>> ("HID: logitech-hidpp: Retry commands when device is busy").
> > >>>>>
> > >>>>> This fixes some overly long waits in a critical path on boot, when
> > >>>>> checking whether the device is connected by getting its HID++ version.
> > >>>>>
> > >>>>> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > >>>>> Suggested-by: Mark Lord <mlord@pobox.com>
> > >>>>> Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
> > >>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217412
> > >>> [...]
> > >>>>
> > >>>> I have applied this even before getting confirmation from the reporters in
> > >>>> bugzilla, as it's the right thing to do anyway.
> > >>>
> > >>> Unfortunately it doesn't seem to cure the reported issue (while reverting
> > >>> 586e8fede79 does):
> > >>
> > >> BTW, remind me again: was fixing this by reverting 586e8fede79 for now a
> > >> option? I guess it's not, but if I'm wrong I wonder if that might at
> > >> this point be the best way forward.
> > >
> > > This should now all be fixed by
> > >
> > >     https://git.kernel.org/linus/7c28afd5512e371773dbb2bf95a31ed5625651d9
> >
> > Jiri, Benjamin, many many thx for working on this.
> >
> > Hmmm. No CC: <stable... tag.
> >
> > Should we ask Greg to pick this up for 6.3 now, or better wait a few
> > days? He currently already has 6199d23c91ce ("HID: logitech-hidpp:
> > Handle timeout differently from busy") in his queue for the next 6.3.y
> > release.
> 
> Well, the Fixes: tag supposedly is enough to let the stable folks to
> pick it up.

No, not at all, please see:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

(hint, we need a cc: stable@ in the signed-off-by area.)

We only pick up stuff with "Fixes:" semi-often, sometimes never,
depending on our workload.  Never rely on that.

It's been this way for 18+ years now, nothing new :)

> But you are right, let's Cc Greg for a quicker inclusion
> in the 6.3 tree.
> 
> Greg, would you mind adding the commit above (7c28afd5512e37) onto the
> 6.3 stable queue? Thanks!

Now queued up, thanks.

greg k-h
