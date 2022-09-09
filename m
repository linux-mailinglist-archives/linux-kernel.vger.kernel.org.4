Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F925B39A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiIINsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiIINrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:47:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5185F1440A3;
        Fri,  9 Sep 2022 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662731253; x=1694267253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aN1SHzTXZGGv2LvfYfQMrEiGcsIXsDTkiwAXlUs8w7A=;
  b=j1mZTs3Aqxhd9mVoXSzifk1IccnGstTeSV1+NmhG+Pyz4kEk+GO1SuG3
   mjbKZ7cD2JrBgJacJ/rp3IUI3WihyzF9ZHhBDiVQxBTaj0VG1F39NkoUV
   vSiMHF626ajFuGtSI493nCnbWIfR4zyGWxDAybeKZOUdo36FEtm054G/H
   20NmTiswDVDNpCPEGUim0wYUXXHyYKTOqbTe8KwjnSdwrfbjkLjAwbBBY
   FsvmKpnYnY5w3cKvFlbW3oLR0x0sdAjD+XoudwjCwIxi+RfxLyaG6VfKe
   6G1daSZo3bvgMesqkQDJqXBC45epVHVd/M8p1zYv274S4P5TTZR86USGM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="284493847"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="284493847"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 06:45:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="645537348"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 06:45:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWeJq-00Aa5q-0J;
        Fri, 09 Sep 2022 16:45:18 +0300
Date:   Fri, 9 Sep 2022 16:45:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gpiolib: cdev: export the consumer's PID
Message-ID: <YxtDbdN0xEOUsKHw@smile.fi.intel.com>
References: <20220909121329.42004-1-brgl@bgdev.pl>
 <20220909121329.42004-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909121329.42004-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:13:29PM +0200, Bartosz Golaszewski wrote:
> It's useful for user-space to be able to know the PIDs of processes
> holding GPIO lines in case they have the permissions and need to kill
> them.
> 
> Extend the gpio_v2_line_info structure with the consumer_pid field
> that's set to the PID of the user-space process or 0 if the user lives
> in the kernel.

...

> +int gpiod_request(struct gpio_desc *desc, const char *label)
> +{
> +	return gpiod_request_with_pid(desc, label, 0);

Why not -1? I would expect this is the usual way of telling
"don't use this PID".

> +}

...

> +		desc_set_pid(desc, 0);

Ditto.

...

> +	ret = gpiod_request_commit(desc, label, 0);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


