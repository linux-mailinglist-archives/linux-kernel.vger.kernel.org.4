Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F31F736D67
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjFTNeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjFTNeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:34:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E67BB7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:34:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 289F721842;
        Tue, 20 Jun 2023 13:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687268051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+g7f4R0DwF4FaxDOQ8yJtMXFiMiE/Afni5THZWxYk4=;
        b=OG4Wi1Co9aZVqCHKxsHujLoG3Ye+pvYO/WsjfwvJO6IgJKRGZM6qJvhlX8rxXoNQauTjHE
        xHodpMXYbKYUtizxY0U5RCobw34c/j/iyvoesp3qoU/+EJZ6aJNRX6bsrUhs9RVAcwMv5m
        rabDzSfrjuOm2HVFYBLsKE7koKDe+DI=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 984C12C141;
        Tue, 20 Jun 2023 13:34:09 +0000 (UTC)
Date:   Tue, 20 Jun 2023 15:34:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Laight <David.Laight@aculab.com>,
        'Demi Marie Obenour' <demi@invisiblethingslab.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 0/4] Make sscanf() stricter
Message-ID: <ZJGq0UTHPdEuIMal@alley>
References: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
 <ZId/IA41c2sJyvE0@itl-email>
 <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
 <ZIeMyQXU49OcoxY2@itl-email>
 <ec3d7ebe62654e949329785bb32c3822@AcuMS.aculab.com>
 <ZIiMrDxI5Ts0s8fK@itl-email>
 <23df90dd35874fd89c64906e6a6de164@AcuMS.aculab.com>
 <ZIoeVjC6offUywop@itl-email>
 <e354268a4efe48c9a8023a30c7292d12@AcuMS.aculab.com>
 <ZIr0z6u17xogE5+n@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIr0z6u17xogE5+n@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-06-15 14:23:59, Andy Shevchenko wrote:
> On Thu, Jun 15, 2023 at 08:06:46AM +0000, David Laight wrote:
> > From: Demi Marie Obenour
> > > Sent: 14 June 2023 21:09
> 
> ...
> 
> > > > What sort of formats and data are being used?
> > > 
> > > Base-10 or base-16 integers, with whitespace never being valid.
> > 
> > In which case sscanf() really isn't what you are looking for.
> > 
> > > > The "%s" format terminates on whitespace.
> > > > Even stroul() (and friends) will skip leading whitespace.
> > > 
> > > Yes, which is a reason that strto*l() are just broken IMO.
> >
> > They are not 'broken', that is what is useful most of the time.
> > The usual problem is that "020" is treated as octal.

I do not know how many users depend on this behavior. But I believe
that there are such users. And breaking compatibility with userspace
implementation would make more harm then good in this case.

> > > I’m trying to replace their uses in Xen with custom parsing code.
> > 
> > Then write a custom parser :-)

Honestly, I dislike any sscanf() modification which have been suggested
so far:

  + %!d is not acceptable because it produces compiler errors

  + %d! is not acceptable because "use 64!" is a realistic string.
    We could not be sure that "<number>!" will never be parsed
    in kernel.

  + %d%[!] produces compiler error either. It is hard to parse by eyes.
    Also the meaning of such a format would be far from obvious.

  + %pj or another %p modifiers would be hard to understand either.

    Yes, we have %pe but I think that only few people really use it.
    And it is kind of self-explanatory because it is typically
    used together with ERR_PTR() and with variables called
    "err" or "ret".


> Hmm... Usually we are against zillion implementations of the same with zillion
> bugs hidden (each buggy implementation with its own bugs).

I would really like to see the code depending on it. The cover letter
suggests that there already is a patch with such a custom parser.
I am sorry if it has already been mentioned. There were so many threads.

Sure, we do not want two full featured sscanf() implementations. But a
wrapper checking for leading whitespace and using kstrto<foo>
family does not sound too complex.

There should always be a good reason to introduce an incompatibility
between the kernel and the userspace implementation of a commonly
used API.

Best Regards,
Petr
