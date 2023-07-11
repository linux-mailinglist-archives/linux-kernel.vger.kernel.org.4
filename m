Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45C374F717
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjGKRWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjGKRWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:22:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCD0E77;
        Tue, 11 Jul 2023 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689096127; x=1720632127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1iz+vAT80sPKY+3kIN8nS42GeY4BvNh//nVonB/RqM0=;
  b=jYe6aPwVNYLZP4Ove3FPMamnIx/ZXrkOBlG5NFIr6xwU8fQUnkizwGHa
   3IS6ZFEIoknuiMaEkqLRN24EvO3DBmNlD6WjVExiED19Dxro5tK3sxz+F
   7U+aVJDwEb8Ck7lQfU4A91Pm7U13S3EURPOUSHz4vmjM0ybTOMKt5yhBF
   bH81aGc9nukwH/nlXP1ucOpdxLdOTdhaSdaOpwWQ1mwCgixYotH5IkV/W
   9BisjjE7rU4tA0s/3G81tB485RYlMKuUfb9EvrrF0WLrfMN8Wiq8nEnqE
   1kAaOstp3QrDaSvN83afX9/UR2Icrs/83uCFGxyxPtlaORm4y2E33mvMp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362149156"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="362149156"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="1051870165"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="1051870165"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2023 10:19:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJH1j-001uQI-2u;
        Tue, 11 Jul 2023 20:19:51 +0300
Date:   Tue, 11 Jul 2023 20:19:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
Message-ID: <ZK2PN9eTmCkD+Jcr@smile.fi.intel.com>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
 <20230711063348.GB41919@unreal>
 <2a2d55f167a06782eb9dfa6988ec96c2eedb7fba.camel@redhat.com>
 <ZK002l0AojjdJptC@smile.fi.intel.com>
 <20230711122012.GR41919@unreal>
 <ZK1O7lBF1vH7/7UM@smile.fi.intel.com>
 <20230711133259.GS41919@unreal>
 <ZK1csjLgGM+ezG/J@smile.fi.intel.com>
 <20230711171058.GT41919@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711171058.GT41919@unreal>
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

On Tue, Jul 11, 2023 at 08:10:58PM +0300, Leon Romanovsky wrote:
> On Tue, Jul 11, 2023 at 04:44:18PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 11, 2023 at 04:32:59PM +0300, Leon Romanovsky wrote:
> > > On Tue, Jul 11, 2023 at 03:45:34PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Jul 11, 2023 at 03:20:12PM +0300, Leon Romanovsky wrote:
> > > > > On Tue, Jul 11, 2023 at 01:54:18PM +0300, Andy Shevchenko wrote:
> > > > > > On Tue, Jul 11, 2023 at 12:21:12PM +0200, Paolo Abeni wrote:
> > > > > > > On Tue, 2023-07-11 at 09:33 +0300, Leon Romanovsky wrote:
> > > > > > > > On Mon, Jul 10, 2023 at 01:06:24PM +0300, Andy Shevchenko wrote:

...

> > > > > > > > So what is the outcome of "int - bool + bool" in the line above?
> > > > > > 
> > > > > > The same as with int - int [0 .. 1] + int [0 .. 1].
> > > > > 
> > > > > No, it is not. bool is defined as _Bool C99 type, so strictly speaking
> > > > > you are mixing types int - _Bool + _Bool.
> > > > 
> > > > 1. The original code already does that. You still haven't reacted on that.
> > > 
> > > The original code was int - int + int.
> > 
> > No. You missed the callers part. They are using boolean.
> 
> I didn't miss and pointed you to the exact line which was implicitly
> changed with your patch.

Yes, and this line doesn't change the status quo. We have boolean in the
callers that implicitly went to the callee as int.

> > > > 2. Is what you are telling a problema?
> > > 
> > > No, I'm saying that you took perfectly correct code which had all types
> > > aligned and changed it to have mixed type arithmetic.
> > 
> > And after this change it's perfectly correct code with less letters and hidden
> > promotions (as a parameter to the function) and hence requires less cognitive
> > energy to parse.
> > 
> > So, the bottom line is the commit message you don't like, is it so?
> 
> Please reread my and Paolo replies.

I have read them. My point is that you should also look at the callers
to see the big picture.

-- 
With Best Regards,
Andy Shevchenko


