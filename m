Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20FD6623E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjAILNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbjAILNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:13:13 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D9C140C4;
        Mon,  9 Jan 2023 03:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673262792; x=1704798792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hdEsJAUiSPZYf7Xm2lSioHZsJcGS6XDIqya7eqaZHNQ=;
  b=MxyQVS+fmsh6fE4C1iMnsuBYrTDVWRGT+6Ihbwq5YMNzgFn7r+I3kj/C
   WJCDh2fDkr+uUtQcQmsXzgKD7gv3/S6+qgHYo9wDyelHAw6gLO3AlsWOX
   5Irl7qhuR0k6DBNP2e9N3M4Gb1fLaPP3KCluKWdyEyu2FEUBnxNn7bgq5
   aSRYcL40OWbC2nW7nKQbcjqjmvsb2veFnHJ2dHJ7soPjiDlzfYmcQ0wca
   FmEJXAMB2mBaszxEP5whf12NxgDfhC8VKEsDcCnLuvY/uEuWHMlZP1+Vp
   Fe2vWmt1ZeApkKBSD6o+i6ZVOCudwRf5Ke8NyN/tsrJG14bN/KsdroTJM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="321551712"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="321551712"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 03:13:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649982329"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649982329"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2023 03:13:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pEq5N-006MLx-13;
        Mon, 09 Jan 2023 13:13:01 +0200
Date:   Mon, 9 Jan 2023 13:13:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     sam@ravnborg.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH 09/15] staging: fbtft: fb_ssd1351.c: Introduce
 backlight_is_blank()
Message-ID: <Y7v2vJtsWuhhiB2b@smile.fi.intel.com>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-9-1bd9bafb351f@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107-sam-video-backlight-drop-fb_blank-v1-9-1bd9bafb351f@ravnborg.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 07:26:23PM +0100, Sam Ravnborg via B4 Submission Endpoint wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> Avoiding direct access to backlight_properties.props.
> 
> Access to the deprecated props.fb_blank replaced by backlight_is_blank().
> Access to props.power is dropped - it was only used for debug.

> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Stephen Kitt <steve@sk2.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: linux-fbdev@vger.kernel.org

Not sure why you have this (at least) explicitly mentioned as get_maintainer.pl
can generate it and git send-email can utilize the script output...

...

> -	write_reg(par, 0xB5, on ? 0x03 : 0x02);
> +	write_reg(par, 0xB5, !blank ? 0x03 : 0x02);

Why not positive conditional?

	write_reg(par, 0xB5, blank ? 0x02 : 0x03);

-- 
With Best Regards,
Andy Shevchenko


