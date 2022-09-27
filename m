Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7415ECAE3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiI0Rdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiI0Rdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:33:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB11E1C770A;
        Tue, 27 Sep 2022 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664300010; x=1695836010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qL2/gbkz5vC23h0UVMkPYeZziYcWA8mFsACtDw2q3ik=;
  b=j8KSciNijSDMhaFXCM5vfwJNF2H8+C9cfZtUNIsEeckfHDrtmBfhYIYA
   bj4N0MQT4u7kt1KDGVKKMaaXDtSdy3wqoQkLKTTpKe5VvrXv7cT+JYsyR
   xmi+r4cXMwCLTGb6sMWeq+yZnaboX+w9qZchQxGmBuhf5HoIaoPKkDdaV
   TLg8QbMkM3R15z0YWEzBS0qHWZ3p+9c8nz8X374mCdRInNI5ftw7dUArz
   c0sKETfKxPgL191kJnXaJlsvycmP3+HIrDvNucQPUUUURvUZ3a6sqxjOl
   ML/Je0QQTzHxReAyUM5hNVMA4toZqkAqXtioWTXBn4w1zkfbE3JZ/dDmW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="298977385"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="298977385"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 10:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="710645459"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="710645459"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Sep 2022 10:33:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odEST-008Yte-3C;
        Tue, 27 Sep 2022 20:33:25 +0300
Date:   Tue, 27 Sep 2022 20:33:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        kbuild-all@lists.01.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/5] device property: Constify fwnode connection match
 APIs
Message-ID: <YzMz5ZDkxE3TwGgl@smile.fi.intel.com>
References: <20220927142822.4095-2-andriy.shevchenko@linux.intel.com>
 <202209280013.P9rEfc5m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209280013.P9rEfc5m-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 12:35:10AM +0800, kernel test robot wrote:
> Hi Andy,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on driver-core/driver-core-testing]
> [cannot apply to usb/usb-testing westeri-thunderbolt/next linus/master v6.0-rc7 next-20220923]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/device-property-Keep-dev_fwnode-and-dev_fwnode_const-separate/20220927-223109
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 1da40c2667388dd70306bfd3d4dcb49fd20b50a9
> config: sh-allmodconfig
> compiler: sh4-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/34401a778cc4e8ddd9610bf7f76d8b7e4fff142e
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Andy-Shevchenko/device-property-Keep-dev_fwnode-and-dev_fwnode_const-separate/20220927-223109
>         git checkout 34401a778cc4e8ddd9610bf7f76d8b7e4fff142e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/usb/typec/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):

Thanks, fixed locally for v2.

-- 
With Best Regards,
Andy Shevchenko


