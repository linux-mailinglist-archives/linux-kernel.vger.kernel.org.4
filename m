Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84449731618
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbjFOLGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245537AbjFOLF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:05:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6AC2947;
        Thu, 15 Jun 2023 04:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686827151; x=1718363151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MkE8nhgMY40cukHBG1NhaYRrEgXerTwfhDdfHL1WSXU=;
  b=eQIgfAMRZpaDm+2qppwCe4aYXr2qCusv69XhRp/2lfTvBeB8o7b0J31/
   WnDjnvU9hNRXE5k9bj3ipTmUmxUxBNpOoaj0+4+WkH20Udfm3LUdm2KHe
   8ALg8AThh5oba1Qhh6Oc1kK75v1/FBCrMW1EajRJa7dUJ8c2s5BkURK3l
   HyQXLgdySn2jPark6/Tbi/SuLruULzxWyXmoTaufAaN7Ruw4miwcGpca+
   Hayd4OmY9WCz+4n1ufZif9Tc81GEkizjg12e50461JdrzqHA0E1u1zaP/
   6I61Dri+xyRBPC+TkuyMvnlsxaTXXVLs82HP/1Kk1UPvti7oioVMCYlWo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="339226602"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="339226602"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 04:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="802297929"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="802297929"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 04:05:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9knI-003vMt-2A;
        Thu, 15 Jun 2023 14:05:36 +0300
Date:   Thu, 15 Jun 2023 14:05:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] pinctrl: check memory returned by devm_kasprintf()
Message-ID: <ZIrwgJHl9VwGsRtc@smile.fi.intel.com>
References: <20230615105333.585304-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615105333.585304-1-claudiu.beznea@microchip.com>
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

On Thu, Jun 15, 2023 at 01:53:30PM +0300, Claudiu Beznea wrote:
> Hi,
> 
> While browsing some code I noticed that there are places where pointer
> returned by devm_kasprintf() or kasprintf() is not checked. Thus I've
> tooked the chance and fixed this (by updating kmerr.cocci script,
> changes published at [1]).

Thank you for fixing this!
Individual patches are commented by me.

> [1] https://lore.kernel.org/all/20230530074044.1603426-1-claudiu.beznea@microchip.com/
> 
> Claudiu Beznea (3):
>   pinctrl: mcp23s08: check return value of {devm_}kasprintf()
>   pinctrl: microchip-sgpio: check return value of devm_kasprintf()
>   pinctrl: at91-pio4: check return value of devm_kasprintf()
> 
>  drivers/pinctrl/pinctrl-at91-pio4.c       | 2 ++
>  drivers/pinctrl/pinctrl-mcp23s08_spi.c    | 3 +++
>  drivers/pinctrl/pinctrl-microchip-sgpio.c | 3 +++
>  3 files changed, 8 insertions(+)
> 
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


