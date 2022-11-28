Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF7363A651
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiK1Kpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiK1Kpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:45:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D3DDF1F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669632343; x=1701168343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ot71st/2utMfdONzhlAwUYwqxVknRLimMxul6O7ei5U=;
  b=J1LdcDHIVpp7MPsAm9wlsRI3CN1jzXgoHDc7d9mcHc3URJY+Y14bwqM9
   igpXQ6ay8vu+ubtN0yKR+QdVeFwmBbAO1zGaK7mSdid4FsaspaVrdt2qP
   0+CJu7gmJrWyyyol6FNgVhhI3HuBKhJtxUV18N2mDB8070hrwjaZUgAyk
   hTsCmPHLbQsfiMZ/StGQ4ZtBasWb7W5w0eoVg+VaOOoTZEjbDmOccEWZQ
   2FbR5dkhoDrYss5KG7zWpkYVCxKGpA0ozFirg+bLvQpwqG6iF32SEJNmm
   b13wHpVNYNZ/g4DNk3JfGPLoNIAT0Yrs4HGGOBPsfBv1S4WA9UYBJ0OE9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="379058285"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="379058285"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 02:45:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="888372010"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="888372010"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 28 Nov 2022 02:45:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozbdr-0015ES-1N;
        Mon, 28 Nov 2022 12:45:39 +0200
Date:   Mon, 28 Nov 2022 12:45:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     ojeda@kernel.org, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] auxdisplay: hd44780: Fix potential memory leak in
 hd44780_remove()
Message-ID: <Y4SRUwKFGJfwNZ2U@smile.fi.intel.com>
References: <20221128084421.8626-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128084421.8626-1-niejianglei2021@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 04:44:21PM +0800, Jianglei Nie wrote:
> hd44780_probe() allocates a memory chunk for hd with kzalloc() and
> makes "lcd->drvdata->hd44780" point to it. When we call hd44780_remove(),
> we should release all relevant memory and resource. But "lcd->drvdata
> ->hd44780" is not released, which will lead to a memory leak.
> 
> We should release the "lcd->drvdata->hd44780" in hd44780_remove() to fix
> the memory leak bug.

Better now! See my comments below. After addressing them,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 41c8d0adf3c4 ("auxdisplay: hd44780: Fix memory leak on ->remove()")

Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")

What you found has nothing to do with the issue. Issue has been introduced
later on.

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/auxdisplay/hd44780.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
> index 8b2a0eb3f32a..f4800a946bd8 100644
> --- a/drivers/auxdisplay/hd44780.c
> +++ b/drivers/auxdisplay/hd44780.c
> @@ -322,8 +322,10 @@ static int hd44780_probe(struct platform_device *pdev)
>  static int hd44780_remove(struct platform_device *pdev)
>  {
>  	struct charlcd *lcd = platform_get_drvdata(pdev);

> +	struct hd44780_common *hdc = (struct hd44780_common *)lcd->drvdata;

drvdata member is type of void *, no need to do an explicit casting as
per C standard.

>  	charlcd_unregister(lcd);
> +	kfree(hdc->hd44780);
>  	kfree(lcd->drvdata);
>  
>  	kfree(lcd);
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


