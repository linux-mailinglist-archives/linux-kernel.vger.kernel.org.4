Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783B5736DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjFTNxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjFTNxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:53:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A802A173F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687269170; x=1718805170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6r5uVPhDDMiZFH8frBv87Azxgl4/50I7UgigmpU/mYo=;
  b=hBRy01iZu1n9LiXFKO3PyTIaHYFCF6rNed6yoLgM40fEy1p0yE9EeV2A
   CHSgNn7l2ZvuVI1GH+niT+UpP2weP3KiIsVEZWwYJDmHxKeq9UjuuEYld
   Bz7FMa4GHvD52MAV4ySFsWIgaDeezndGi96h1L0yIxqrWlEpS6etF70eg
   m976sfD0jGLn+sv7zvLaXgFmQSP9KcnRDrX7/UK4yodR+E5jvHxH3rfeS
   LZ5d/hWcJ05Xsa7v+imyAdXinIKo9i+1dodS9GCvb24lia+08Kl1MhNdI
   pKUBYoCZTytMwZiPBp1aLre1pxtqLqWSq+YuT+GKzqmvi+agUVaxqAePb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="358735515"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="358735515"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="1044270846"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="1044270846"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jun 2023 06:52:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qBbml-005Gr5-0j;
        Tue, 20 Jun 2023 16:52:43 +0300
Date:   Tue, 20 Jun 2023 16:52:42 +0300
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
Message-ID: <ZJGvKuNq0yE/dkAJ@smile.fi.intel.com>
References: <ZId/IA41c2sJyvE0@itl-email>
 <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
 <ZIeMyQXU49OcoxY2@itl-email>
 <ec3d7ebe62654e949329785bb32c3822@AcuMS.aculab.com>
 <ZIiMrDxI5Ts0s8fK@itl-email>
 <23df90dd35874fd89c64906e6a6de164@AcuMS.aculab.com>
 <ZIoeVjC6offUywop@itl-email>
 <e354268a4efe48c9a8023a30c7292d12@AcuMS.aculab.com>
 <ZIr0z6u17xogE5+n@smile.fi.intel.com>
 <ZJGq0UTHPdEuIMal@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJGq0UTHPdEuIMal@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 03:34:09PM +0200, Petr Mladek wrote:
> On Thu 2023-06-15 14:23:59, Andy Shevchenko wrote:
> > On Thu, Jun 15, 2023 at 08:06:46AM +0000, David Laight wrote:

...

>   + %pj or another %p modifiers would be hard to understand either.
> 
>     Yes, we have %pe but I think that only few people really use it.
>     And it is kind of self-explanatory because it is typically
>     used together with ERR_PTR() and with variables called
>     "err" or "ret".

j, besides the luck of no (yet) use in the kernel's printf(), is
described for printf(3)

  j   A  following integer conversion corresponds to an intmax_t or uintmax_t
      argument, or a following n conversion corresponds to a pointer to an
      intmax_t argument.

So, I this among all proposals, this one is the best (while all of them may
sound not good).

-- 
With Best Regards,
Andy Shevchenko


