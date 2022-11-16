Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6462B4BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiKPIOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbiKPINq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:13:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896C3C2F;
        Wed, 16 Nov 2022 00:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668586300; x=1700122300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wuRDsrMORCD054oFgsKRIJ7FO0a6ZUpcEuJQ+QkEcRQ=;
  b=WXQKISAsVtXPnkUzTGqjkYwhC6yXVM+p92rnSJX2579G/4R34gehui52
   BZUTuTrzRibDXOzGxNS3d8rbwoOriLHKXFTC3C0lKabUiql+0kMk5Dgtg
   23uY0zQxAFgvEkxZkU6jFgRcrDAsX5ig8/pnzDA88kvvevM+rNahD0Hsg
   WOOUtZSD8//Xmj6pKtbkC2oy3dmWl2sdqrTiS514MjEX2oiyWY9Zcah52
   vVdeMiJkmT0sgvNKwlzwf7Zp5qfi5EeMBiYjWcjkFbgtlh4/DaMIWhfdL
   qbaraLKaJ15G0B6Xpe8eP5SFk3I0jJ/st9bORAJf6kAcI+nD/0ubOWcqW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="300010433"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="300010433"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 00:11:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="617078944"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="617078944"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 16 Nov 2022 00:11:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovDW8-00D2KK-34;
        Wed, 16 Nov 2022 10:11:32 +0200
Date:   Wed, 16 Nov 2022 10:11:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/4] pwm: Reduce time the pwm_lock mutex is held in
 pwmchip_add()
Message-ID: <Y3SbNM8H3QxY0XF2@smile.fi.intel.com>
References: <20221115211515.3750209-1-u.kleine-koenig@pengutronix.de>
 <20221115211515.3750209-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221115211515.3750209-3-u.kleine-koenig@pengutronix.de>
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

On Tue, Nov 15, 2022 at 10:15:13PM +0100, Uwe Kleine-König wrote:
> This simplifies error handling as the need for goto error handling goes
> away and at the end of the function the code can be simplified as this
> code isn't used in the error case any more.

...

> +	mutex_unlock(&pwm_lock);
>  
>  	if (IS_ENABLED(CONFIG_OF))
>  		of_pwmchip_add(chip);

Why calling this without a lock is not a problem? Commit message doesn't share
a bit about this change.

> -out:
> -	mutex_unlock(&pwm_lock);

-- 
With Best Regards,
Andy Shevchenko


