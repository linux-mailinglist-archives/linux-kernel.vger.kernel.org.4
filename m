Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802CC70F604
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjEXMP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjEXMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:15:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF13A18C;
        Wed, 24 May 2023 05:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684930523; x=1716466523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YWFNqek+VRG2S1Kpq+u/LIuoteJFwt9202gfFrPSfKQ=;
  b=JfnqMsM+npo4c+ck2bENMDYNj4A8L3OrRLeJcX2CwB3HCg0mcYCh6gYt
   FiD52Gh5aR+KQRK0AkHz3u35IUZJ3mMWT4JD4Pr3LVfSNtoEQvtNlD+fP
   1+3rtafkz0CQ94T5RTvIeaEBYnkwz0v/1LNunDNKHJihlqi6+Q0WnSl1R
   q+eZe9qDATD2QtnCo7jqBVBCWlyYdYYuWLLCXhDBJLr+Y4S0gwyTzuV/s
   Z7K8mEy9G02tjOLIZcQLrPbgPP/rj8SMENNjxdKmHW+t01DDAwMp8Z7ru
   +GyS0xpI5oNt+mgBS7qANZRwRe1/LwviheekcYRTOaHBqajtpKpWjSuCO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="338122845"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="338122845"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 05:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="816552403"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="816552403"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 05:15:19 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 914151202A9;
        Wed, 24 May 2023 15:15:16 +0300 (EEST)
Date:   Wed, 24 May 2023 12:15:16 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>,
        linux-hardening@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] i2c: Replace all non-returning strlcpy with strscpy
Message-ID: <ZG3/1JS7UBzWNZBD@kekkonen.localdomain>
References: <20230523021150.2406032-1-azeemshaikh38@gmail.com>
 <20230523090540.GC2174496@google.com>
 <ZGyDx4Jg9j2zmjD6@kekkonen.localdomain>
 <CADmuW3W+-7GeKX2LqvvTW408v6x1o_as5xuUFxrdHf9TyTTsnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmuW3W+-7GeKX2LqvvTW408v6x1o_as5xuUFxrdHf9TyTTsnQ@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Azeema,

On Tue, May 23, 2023 at 10:34:34AM -0400, Azeem Shaikh wrote:
> Thanks for the quick response Lee and Sakari.
> 
> On Tue, May 23, 2023 at 5:13 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Lee, Azeem,
> >
> > On Tue, May 23, 2023 at 10:05:40AM +0100, Lee Jones wrote:
> > > On Tue, 23 May 2023, Azeem Shaikh wrote:
> > >
> > > > strlcpy() reads the entire source buffer first.
> > > > This read may exceed the destination size limit.
> > > > This is both inefficient and can lead to linear read
> > > > overflows if a source string is not NUL-terminated [1].
> > > > In an effort to remove strlcpy() completely [2], replace
> > > > strlcpy() here with strscpy().
> > > > No return values were used, so direct replacement is safe.
> > > >
> > > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > > > [2] https://github.com/KSPP/linux/issues/89
> > > >
> > > > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > > > ---
> > > >  drivers/leds/flash/leds-as3645a.c |    4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > Please resubmit, taking the time to check the subject line please.
> >
> > I'd say also shorter description will suffice. Nowadays people understand
> > the motivation replacing strlcpy() by strscpy() without too much
> > elaboration. Lines may be up to 74 characters long, too, and period isn't
> > automatically followed by a newline.
> >
> 
> Let me know if this commit log looks good to you both and I'll send over a v2.
> 
> Subject: [PATCH] leds: as3645a: Replace all non-returning strlcpy with strscpy

All instances are replaced, so you can drop "all non-returning ".

> 
> Part of a tree-wide effort to remove deprecated strlcpy()[1] and replace
> it with strscpy()[2]. No return values were used, so direct replacement
> is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89

Looks good to me.

> 
> > I also prefer my @linux.intel.com address, as in MAINTAINERS for this
> > driver.
> 
> Fyi that the email address mentioned for this driver is not the
> @linux.intel.com -
> https://github.com/torvalds/linux/blob/44c026a73be8038f03dbdeef028b642880cf1511/MAINTAINERS#L3070.
> I'm happy to send the v2 patch to sakari.ailus@linux.intel.com if you
> prefer that instead.

Oops, my mistake then. :-) I thought I already had changed this. Oh well.

-- 
Regards,

Sakari Ailus
