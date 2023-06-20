Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1535736FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjFTPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjFTPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:07:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB98CDC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687273646; x=1718809646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dKDmJjt7XJnSsECb/w05H37T93Rv7V4QnXaN44SoXng=;
  b=lhqzoryXz0lRnnDb3RoKeX7kc84FNAKV3QWauRN8aFEVsr/Rl23NqkoQ
   r2zJn2EmYnZ4aKzGHabk3GrKy3EnYbwqhr7e7akAPTHcobIJlYUqbV0ZJ
   2+jsYixRmtoNr64eZF34boONiYMgtzlYbXc69ZV+fHJChepT10jv/McOr
   f8IteT8RZCAIgLqThWVSxP0raa/GttcI1qw1HkRSg5B5dne6SHiWtGqUI
   tKkSWeCU8aDVLbLvMJnq/x9X7pZxVxXkq2NAVkBoWDQCBu504dsQtnD5f
   qRh5Ph79KTZxgKSiVMinyZAqVfUd28VPHGyze+V5MgkyfhuNSZV+8KiIn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389158038"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="389158038"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 08:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="714071011"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="714071011"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 20 Jun 2023 08:05:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qBcux-005Hbs-04;
        Tue, 20 Jun 2023 18:05:15 +0300
Date:   Tue, 20 Jun 2023 18:05:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
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
Message-ID: <ZJHAKnO4+KT0km2H@smile.fi.intel.com>
References: <ZIeMyQXU49OcoxY2@itl-email>
 <ec3d7ebe62654e949329785bb32c3822@AcuMS.aculab.com>
 <ZIiMrDxI5Ts0s8fK@itl-email>
 <23df90dd35874fd89c64906e6a6de164@AcuMS.aculab.com>
 <ZIoeVjC6offUywop@itl-email>
 <e354268a4efe48c9a8023a30c7292d12@AcuMS.aculab.com>
 <ZIr0z6u17xogE5+n@smile.fi.intel.com>
 <ZJGq0UTHPdEuIMal@alley>
 <ZJGvKuNq0yE/dkAJ@smile.fi.intel.com>
 <ZJG-c2Lsgrd0Y_yh@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJG-c2Lsgrd0Y_yh@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 04:57:55PM +0200, Petr Mladek wrote:
> On Tue 2023-06-20 16:52:42, Andy Shevchenko wrote:
> > On Tue, Jun 20, 2023 at 03:34:09PM +0200, Petr Mladek wrote:
> > > On Thu 2023-06-15 14:23:59, Andy Shevchenko wrote:
> > > > On Thu, Jun 15, 2023 at 08:06:46AM +0000, David Laight wrote:

...

> > >   + %pj or another %p modifiers would be hard to understand either.
> > > 
> > >     Yes, we have %pe but I think that only few people really use it.
> > >     And it is kind of self-explanatory because it is typically
> > >     used together with ERR_PTR() and with variables called
> > >     "err" or "ret".
> > 
> > j, besides the luck of no (yet) use in the kernel's printf(), is
> > described for printf(3)
> > 
> >   j   A  following integer conversion corresponds to an intmax_t or uintmax_t
> >       argument, or a following n conversion corresponds to a pointer to an
> >       intmax_t argument.
> 
> I see, I have missed this coincidence. And we would really need to use %pj.
> %jd requires intmax_t variable. Otherwise, the compiler produces:
> 
> kernel/lib/test.c:10:17: error: format ‘%jd’ expects argument of type ‘intmax_t *’, but argument 3 has type ‘int *’ [-Werror=format=]
>   sscanf(str, "%jd hello.", &tmp);
> 
> Hmm, %pj might even make some sense for sscanf() which requires pointers anyway.
> But still, we would lose the compiler check of the size of the passed
> buffer.
> 
> This is actually my concern with many other %p modifiers. The compiler
> is not able to check that we pass the right pointer. I know that this
> might happen even with wrong buffer passed to %s or so. But number
> types is another category.

Yeah, it was a discussion IIRC for the compiler plugin to support %p
extensions, but I have no idea where it's now.

> > So, I think among all proposals, this one is the best (while all of them may
> > sound not good).
> 
> I still prefer the custom handler when it is not too complex.
> 
> Or if there are many users, we could create sscanf_strict() or so.

-- 
With Best Regards,
Andy Shevchenko


