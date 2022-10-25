Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E635B60C7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiJYJUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiJYJTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:19:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64198160859
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666689221; x=1698225221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4W/ovsSPupI5rLSaIdoBpNhRPZ/toECDmp5MStaycPo=;
  b=MpisSNdDjfx74LolcdGq352JLH2fmTwkQylrJamh9Doqqc5kz5BhtaTk
   QkhNe6OYj3G4sz6+sTSuWoyDe4Ru21m9fNeE6haE50CVwB51BDk1tffZy
   0PLiIZWIqNdvxtpNBz68r2Ygm5LO0PSaosd1DuKpiMLA7COCZT8f4K8VW
   yebBv9S5d3jAspJuln6+kuv7eKI5aOICELrhIATXuHKrXAp14TxcKm23W
   t8S1921xs9hPBwL8AezyTpjZxYWy9Du7QcBrOuVfDLxEVlMqYNoY0X2wi
   TLUT1qVJdtHuBNw3JT2NlXEcicCJuH4sYmhoyvTIrhSvEzOh2dcaEd5Ki
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="334224402"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="334224402"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 02:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="876738255"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="876738255"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 25 Oct 2022 02:13:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1onG08-001uxm-1K;
        Tue, 25 Oct 2022 12:13:36 +0300
Date:   Tue, 25 Oct 2022 12:13:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, rostedt@goodmis.org,
        senozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, haakon.bugge@oracle.com,
        john.haxby@oracle.com
Subject: Re: [PATCH v3 1/1] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Message-ID: <Y1eowLuE8cgCnEfq@smile.fi.intel.com>
References: <20221019194159.2923873-1-jane.chu@oracle.com>
 <Y1BfK6LpDJDlUYKp@smile.fi.intel.com>
 <Y1Fgk1iDnhL7VtAl@char.us.oracle.com>
 <Y1FxS30zVENd/1Ap@smile.fi.intel.com>
 <Y1ehBZOuF3AXeesh@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ehBZOuF3AXeesh@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:40:37AM +0200, Petr Mladek wrote:
> On Thu 2022-10-20 19:03:23, Andy Shevchenko wrote:
> > On Thu, Oct 20, 2022 at 10:52:03AM -0400, Konrad Rzeszutek Wilk wrote:

...

> > OK, let's assume user recognizes this as a bug, what should they do in order
> > to provide a better description of the bug, so developer can easily debug
> > and fix it?
> 
> WARN() would provide similar information as panic() without actually
> crashing the kernel.

Unless one provides panic_on_warn (or how is it called?).

> > > Would we not want that experience for users ?
> > 
> > Yes, if it is a bug in the kernel we want to know it with all possible details.
> > Hiding bugs is a way to nowhere.
> 
> I agree but we should always distinguish between fatal problems where
> the system could hardly continue working and unexpected behavior that
> is not critical.
> 
> Many error code paths handle unexpected situations. Some problems are
> caused by users and some by bugs in the code. The kernel could always
> refuse doing some operation rather than crash. People will report
> it because it does not work. And there are non-destructive ways how
> to show useful debugging information.

Initially, if I understand correctly, the idea of that check was exactly to
guard against special pointers (NULL and error). Now this is getting wider
and I'm not sure hiding a crash is good thing to go.

Hypothetical situation: the "invalid" pointer is just one that gets LSB
shuffled a bit (some of the frameworks use lower bits to keep some information
there). That said, kernel is not going to crash elsewhere. How user will know
that unmasked pointer went to the printf()?

I honestly think that this or similar change will bring more harm than help.

-- 
With Best Regards,
Andy Shevchenko


