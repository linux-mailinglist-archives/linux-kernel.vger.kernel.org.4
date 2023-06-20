Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C73736F77
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjFTO6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjFTO61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:58:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9094C19A8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:58:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 165A82188D;
        Tue, 20 Jun 2023 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687273082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqpOqDJxJplxaFADnW3a40r4fQxrfN6aq0JgDGMsckI=;
        b=WsYTKvhvZFFpTFvj8EJ/4/anTVBa2ayWDpooa0WfzLc745laU0WIinTsKVENocgsoA8wYZ
        Py+fk/LPFM0WOliGx3qTTtHhvtU47oR5oA2ngp558q+DdVCHuiXHvowN8Y9HQOJ/PWBJAi
        JjZFAxcYMm5dp76ZogiesoH9PVpYSBE=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 64C852C141;
        Tue, 20 Jun 2023 14:58:01 +0000 (UTC)
Date:   Tue, 20 Jun 2023 16:57:55 +0200
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
Message-ID: <ZJG-c2Lsgrd0Y_yh@alley>
References: <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
 <ZIeMyQXU49OcoxY2@itl-email>
 <ec3d7ebe62654e949329785bb32c3822@AcuMS.aculab.com>
 <ZIiMrDxI5Ts0s8fK@itl-email>
 <23df90dd35874fd89c64906e6a6de164@AcuMS.aculab.com>
 <ZIoeVjC6offUywop@itl-email>
 <e354268a4efe48c9a8023a30c7292d12@AcuMS.aculab.com>
 <ZIr0z6u17xogE5+n@smile.fi.intel.com>
 <ZJGq0UTHPdEuIMal@alley>
 <ZJGvKuNq0yE/dkAJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJGvKuNq0yE/dkAJ@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-06-20 16:52:42, Andy Shevchenko wrote:
> On Tue, Jun 20, 2023 at 03:34:09PM +0200, Petr Mladek wrote:
> > On Thu 2023-06-15 14:23:59, Andy Shevchenko wrote:
> > > On Thu, Jun 15, 2023 at 08:06:46AM +0000, David Laight wrote:
> 
> ...
> 
> >   + %pj or another %p modifiers would be hard to understand either.
> > 
> >     Yes, we have %pe but I think that only few people really use it.
> >     And it is kind of self-explanatory because it is typically
> >     used together with ERR_PTR() and with variables called
> >     "err" or "ret".
> 
> j, besides the luck of no (yet) use in the kernel's printf(), is
> described for printf(3)
> 
>   j   A  following integer conversion corresponds to an intmax_t or uintmax_t
>       argument, or a following n conversion corresponds to a pointer to an
>       intmax_t argument.

I see, I have missed this coincidence. And we would really need to use %pj.
%jd requires intmax_t variable. Otherwise, the compiler produces:

kernel/lib/test.c:10:17: error: format ‘%jd’ expects argument of type ‘intmax_t *’, but argument 3 has type ‘int *’ [-Werror=format=]
  sscanf(str, "%jd hello.", &tmp);

Hmm, %pj might even make some sense for sscanf() which requires pointers anyway.
But still, we would lose the compiler check of the size of the passed
buffer.

This is actually my concern with many other %p modifiers. The compiler
is not able to check that we pass the right pointer. I know that this
might happen even with wrong buffer passed to %s or so. But number
types is another category.


> So, I think among all proposals, this one is the best (while all of them may
> sound not good).

I still prefer the custom handler when it is not too complex.

Or if there are many users, we could create sscanf_strict() or so.

Best Regards,
Petr
