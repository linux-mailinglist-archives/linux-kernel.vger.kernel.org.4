Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE31697D95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBONiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjBONiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:38:12 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909422F7AD;
        Wed, 15 Feb 2023 05:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676468291; x=1708004291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+4r0+D+q5ysn8M+YYqPSqFr45GaxeGtQyxkSeRJTi1U=;
  b=NRrmvenv4cwJpf95BqDV4tCGNgFaYW884q3Kh2rwFkEmnGjm3XfUHNDJ
   0I6kLfxt2ZojI7pLftuXIVlzsQTbBaQ4BdIpPbqFWta7ke3dIpJHsk0Zw
   zXlGtSbdcV4bI45AmJ4r22WG0Nf7V6VnR0ASG3of3r91VBR8atX7WmKpZ
   kfiH8ZQM0bvhhEvgFQgEaQWqE2lPskNoNmohnVTU1wBhC8LPLRwO7Qds7
   TkOHS3XDmEX9bg+iGFuSrnPIxogtkmsxQ0yw8IqSj/PG75Sq5D3sHvyqL
   akS2wYbifkgJzgF6jOs+Ko9NRHFLBGDQDfnTDRwJwNdRXbInhF+KXy6h5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="332733937"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="332733937"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:38:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793501673"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="793501673"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2023 05:38:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSHz4-007H3i-2x;
        Wed, 15 Feb 2023 15:38:06 +0200
Date:   Wed, 15 Feb 2023 15:38:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Claudiu.Beznea@microchip.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
        linus.walleij@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH v2 5/5] pinctrl: at91: Utilise temporary variable for
 struct device
Message-ID: <Y+zgPjDruv4cIqDd@smile.fi.intel.com>
References: <20230213154532.32992-1-andriy.shevchenko@linux.intel.com>
 <20230213154532.32992-6-andriy.shevchenko@linux.intel.com>
 <b78661b9-d9a4-5c2c-7df6-8fc79da73538@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b78661b9-d9a4-5c2c-7df6-8fc79da73538@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:11:58AM +0000, Claudiu.Beznea@microchip.com wrote:
> On 13.02.2023 17:45, Andy Shevchenko wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > We have a temporary variable to keep pointer to struct device.
> > Utilise it inside the ->probe() implementation.
> 
> Apart from this the patch also removes some { } and does some alignments.
> For clarity some of these might go better in a different patch.

I was under impression that checkpatch will complain about it, but it appears
that it does not. I will issue a new version with this updated.

Thanks for your reviews and testing!

-- 
With Best Regards,
Andy Shevchenko


