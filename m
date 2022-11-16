Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F1762B519
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiKPIZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiKPIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:24:44 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DE71E3E6;
        Wed, 16 Nov 2022 00:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668586980; x=1700122980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1RxOS6QZuyMCp79s8wDdIfrJKzJQ7kfsHXLMLaJ7574=;
  b=Os4do6wS66LeUW2Gw82fH2fWC+sTxwrN7v7vVbh2RFQzF0/W8KlPsXFF
   kHYsDKklQFMKq5L2rU76lZ/DHlwO+D/dIY8VlmcPbLhnvyIoag6dICz1H
   CccxsSQUiKIlrvuSkUwYrVsiLzdEB09hALb4oeUozyesormcd2a56Gn+9
   +vPSThaEJgwqP7xbQZav9XL8Jo7M/t1TPXQt+ZkW54svAieNC4xwrxgmz
   sIaFYNCNYwm7dtIEVeNRL4tgCGrR0Y1v76YuREcV3ANg8BVITh4CjltEO
   r5kG7KDQmpKrAIyeX8lOQjlYeb62kNMy2LUYq4OFFF87y4T31Z5DMVzCD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="300012519"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="300012519"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 00:22:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="617082470"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="617082470"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 16 Nov 2022 00:22:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovDhA-00D2Yy-1q;
        Wed, 16 Nov 2022 10:22:56 +0200
Date:   Wed, 16 Nov 2022 10:22:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: core: Refactor pwmchip_add() to avoid extra
 checks
Message-ID: <Y3Sd4BYkkjLUv5ka@smile.fi.intel.com>
References: <20221114170006.61751-1-andriy.shevchenko@linux.intel.com>
 <20221115202412.77d52oafpplzu5bw@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221115202412.77d52oafpplzu5bw@pengutronix.de>
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

On Tue, Nov 15, 2022 at 09:24:12PM +0100, Uwe Kleine-König wrote:
> On Mon, Nov 14, 2022 at 07:00:04PM +0200, Andy Shevchenko wrote:
> > When we already know that everything is fine there is no need
> > to use ret variable. Refactor code accordingly.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> The patch is correct (i.e. doesn't change the semantic of the function).
> 
> But I think there is some more potential to clean up than it used here.
> I will send out a series that I like better than this patch.

Fine, can you attach the second patch of this series to yours v2, please?

-- 
With Best Regards,
Andy Shevchenko


