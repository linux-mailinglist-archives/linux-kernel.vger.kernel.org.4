Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D35698B87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBPFFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPFFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:05:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFBD34F67;
        Wed, 15 Feb 2023 21:05:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FFCB61E79;
        Thu, 16 Feb 2023 05:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10E5C433D2;
        Thu, 16 Feb 2023 05:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676523908;
        bh=cA+ujwzRa7cMS2uAmK6WLQ5YJGarTpd9LGJ9b1k4sqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSbTauz2edsWuVn6M9bO5wr6sR2tdWZxjG40ValN74N0ILGSP+JH1saObtXe9LBBV
         gbcdLxD/cNmNjU80lbKMZtRviKK91bRDDpglYK3rO0pwl9+zYTBnHBT/BqW2/ykpQY
         5klSdWevags0PoGt512UW7N0EP72waP/yeOpgL5hjvt9KmY2fKFsN+ATIuFvvKj+y7
         WloMtRt8dh9dFZnxeLu+lHjYtqQg1EUVvQgp44CbjWQAtfGcXtdQVYDcxn+BpepOvi
         3C7BwfbGRth2YlnVDNHc/QmLNJBvrDKXcNTm84L9Oyr6yJHWIqT4Pz+lz48aCpfCTC
         PBT8EKK6EJSzQ==
Date:   Thu, 16 Feb 2023 07:04:53 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Retire IA64/Itanium support
Message-ID: <Y+25dZiA+xnZRgVX@kernel.org>
References: <20230215100008.2565237-1-ardb@kernel.org>
 <534469b750e1847e1645f9ae5ed19dcc80b82be6.camel@physik.fu-berlin.de>
 <CAHk-=wjEmZ19T4XpVb0_Hacm53xJG_w5ygcuorwC0xBoT-myUA@mail.gmail.com>
 <SJ1PR11MB6083F7F30FE9ED8F39FA1F85FCA39@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAHk-=wj9RkLN+GpYcFmsd8tze6zYL7MMkNpvdKbETQnqYm+Hwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9RkLN+GpYcFmsd8tze6zYL7MMkNpvdKbETQnqYm+Hwg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, Feb 15, 2023 at 12:08:28PM -0800, Linus Torvalds wrote:
> On Wed, Feb 15, 2023 at 11:43 AM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > Maybe you don't see others pain?  I added Al Viro ... perhaps
> > he'll replay some of his thoughts from trying to make signals
> > and other stuff work correctly on ia64.
> 
> Well, as long as it's ia64-specific, I'll just go "hey, it was Al's
> choice to look at that code".
> 
> IOW, I'm more worried about "ia64 makes it a pain to make _generic_ changes".
> 
> IOW, doing something like this:
> 
>     git log -p --no-merges --since=1.year arch/ia64/
> 
> to see what kind of pain ia64 parts of patches have caused, about a
> third of them are that "look, somebody cared about ia64 explicitly".
 
I remember that when I was doing cleanups of mm initialization, ia64
required special care several times.

> That said, it's entirely possible I've missed some particular painpoint.

The largest painpoint IMO is absence of any ability to test ia64 except
sending patches to Adrian in a hope he has time to give them a whirl.
 
>                   Linus

-- 
Sincerely yours,
Mike.
