Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901DF74D22C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjGJJuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjGJJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:49:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22723AA5;
        Mon, 10 Jul 2023 02:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688982279; x=1720518279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2khzmhKhnoS24cYl9j3/7m5Qz5fUfM6HHTw49kzdp3M=;
  b=kR6BAjWjP5bdm/GB8zjep0dapC/bnLAgokeDpCuI1V9UZjoTsuruSEKs
   QUkyJQTrOrcG84JvzcEgPIWoZgjnFoyV0OGl4haCduoYhEeQGHw8LngSq
   hdZ2OBCRt+1OhoqnEg7KnSUY25FkGaj62wTrIil/ZP+hK64bzlYg6rcu0
   GN0BU+qw6fG22LGFEBswU8sUjlu+OJf7PMiiK2Hqaq8wg9fs6TuHKzk43
   IjB2tIi2TxpeaGiX9iudD2rJFJUNNe6ssVlVGAU5AOEItEVhCUBt47/j/
   zUa/xi6ErDXBhYAMHjrmgw/MsqjlEU7yFIJEXT5Zy5GCDCWeAoCoD+QR2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="363165733"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="363165733"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="894718881"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="894718881"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 10 Jul 2023 02:44:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qInRc-001W6x-0r;
        Mon, 10 Jul 2023 12:44:36 +0300
Date:   Mon, 10 Jul 2023 12:44:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH v1 1/1] usb: musb: Use read_poll_timeout()
Message-ID: <ZKvTA5fQxPqIdX1n@smile.fi.intel.com>
References: <20230703121936.71623-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbySh+XFUDnFWUQHULYag0hukJ_ogfSREPLvs1iV=YmwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbySh+XFUDnFWUQHULYag0hukJ_ogfSREPLvs1iV=YmwQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 11:08:41AM +0200, Linus Walleij wrote:
> On Mon, Jul 3, 2023 at 2:19 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Use read_poll_timeout() instead of open coding it.
> > In the same time, fix the typo in the error message.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> (...)
> > +       ret = read_poll_timeout(gpiod_get_value, reg, !reg, 1000, 100000, true,
> > +                               glue->intpin);
> 
> Wow that's really cool. I had no idea that you could use read_poll_timeout()
> together with gpiod_get_value() like this!

Yep, after 5f5323a14cad ("iopoll: introduce read_poll_timeout macro").
I just realized that we need to bump the sleep_us parameter as beneath
it divides it by 4, so I would put 5000 there in v2.

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


