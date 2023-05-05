Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C328E6F803C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjEEJlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjEEJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:41:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA46150E6;
        Fri,  5 May 2023 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683279676; x=1714815676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D7UA2lx+EkPLMAJoV5cMenjK7P7GwwqdLMhdFNpcpUw=;
  b=AtQnPgrEWRcRAzpEoTkDxVmh2sAaZffQ3RfB4yCuzYwID/q5MEM/vL20
   aneKNgg2WVYBLl2nvWclG6u3pO/N3JEkdjxb/c0qV2F+CkSNoBGfwboZh
   DOsHmb3RoViiuO5ty9dnpRicRYsOYYKBObnWngpF/KZoKDkhrI1dHUM9I
   bLaDj+93ClLC3Ne3NWIyL+JfCGHBfAJwY6asPw+nv8a0RCkjenhN3jq17
   fChNTxB9CKNF9G9FJTs10QP7ldNo/BCdoE6DDECLn2JhyVmXTDWv9DKXX
   0Fl5Q1HQCF7v1e62Mx0LGKZzRlTG7K4dMb9PJMoOUmjTREosREWk2grN9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="328794858"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="328794858"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 02:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="943777751"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="943777751"
Received: from lkp-server01.sh.intel.com (HELO fe5d646e317d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 May 2023 02:41:11 -0700
Received: from kbuild by fe5d646e317d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1purw6-0000TB-1W;
        Fri, 05 May 2023 09:41:10 +0000
Date:   Fri, 5 May 2023 17:40:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-fbdev@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-spi@vger.kernel.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] Input: ads7846 - Convert to use software nodes
Message-ID: <202305051726.wOn3I3W1-lkp@intel.com>
References: <20230430-nokia770-regression-v2-1-984ed3ca5444@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430-nokia770-regression-v2-1-984ed3ca5444@linaro.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

kernel test robot noticed the following build errors:

[auto build test ERROR on 348551ddaf311c76b01cdcbaf61b6fef06a49144]

url:    https://github.com/intel-lab-lkp/linux/commits/Linus-Walleij/Input-ads7846-Convert-to-use-software-nodes/20230505-162601
base:   348551ddaf311c76b01cdcbaf61b6fef06a49144
patch link:    https://lore.kernel.org/r/20230430-nokia770-regression-v2-1-984ed3ca5444%40linaro.org
patch subject: [PATCH v2 1/3] Input: ads7846 - Convert to use software nodes
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20230505/202305051726.wOn3I3W1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/9708c9277cc820e52916ddf795926d3254bb5eed
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Linus-Walleij/Input-ads7846-Convert-to-use-software-nodes/20230505-162601
        git checkout 9708c9277cc820e52916ddf795926d3254bb5eed
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/input/touchscreen/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305051726.wOn3I3W1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/input/touchscreen/ads7846.c:1406:35: error: 'ads7846_dt_ids' undeclared here (not in a function); did you mean 'ads7846_cmds'?
    1406 |                 .of_match_table = ads7846_dt_ids,
         |                                   ^~~~~~~~~~~~~~
         |                                   ads7846_cmds


vim +1406 drivers/input/touchscreen/ads7846.c

  1401	
  1402	static struct spi_driver ads7846_driver = {
  1403		.driver = {
  1404			.name	= "ads7846",
  1405			.pm	= pm_sleep_ptr(&ads7846_pm),
> 1406			.of_match_table = ads7846_dt_ids,
  1407		},
  1408		.probe		= ads7846_probe,
  1409		.remove		= ads7846_remove,
  1410	};
  1411	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
