Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED7272AB97
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjFJM7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFJM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:59:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEB1AB;
        Sat, 10 Jun 2023 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686401983; x=1717937983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ITLJwuiMSNZijdY4Cz6EusiXck7vPTOmLnkmQWskaI8=;
  b=OShB4cayu10aFZla9A0oE9/QG63uiZ6GWDEPrfLgPV93QNywgAj6cBEo
   KKBVu7Aatq0Wi+2JooeueON54gqju3Q/VgkeioLtd96581UVlsAqOKbsv
   ORk05fn6N3BN9I/owLjhHmRPxjPwnZKUTEuQQ8iQZ+lG5P2LYXzH5ClN3
   vILYp7Wjs0NyDNQG+Xzl1bPxPymmdQcehpF1dsmKd14Bim1Jgf4Tlyr5S
   +absCNldqZJRq13EbA7aKP3MAYC9WMK7aDs2W9tfeetY4DjG2sazUUvU4
   nfRbMenTM06cskmFSXONjS8MtyfstYj/tQBzFNjvSoSJK3VH1EioU7e0B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="338122799"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="338122799"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 05:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="957451084"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="957451084"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2023 05:59:38 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7yBt-000A6A-2O;
        Sat, 10 Jun 2023 12:59:37 +0000
Date:   Sat, 10 Jun 2023 20:59:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     oe-kbuild-all@lists.linux.dev,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/4] vsscanf(): Return -ERANGE on integer overflow
Message-ID: <202306102055.ZSJK8Xsj-lkp@intel.com>
References: <20230610025759.1813-2-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610025759.1813-2-demi@invisiblethingslab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Demi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on lee-leds/for-leds-next linus/master v6.4-rc5 next-20230609]
[cannot apply to xen-tip/linux-next lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Demi-Marie-Obenour/vsscanf-Return-ERANGE-on-integer-overflow/20230610-110026
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20230610025759.1813-2-demi%40invisiblethingslab.com
patch subject: [PATCH 2/4] vsscanf(): Return -ERANGE on integer overflow
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230610/202306102055.ZSJK8Xsj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        git remote add lee-mfd https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
        git fetch lee-mfd for-mfd-next
        git checkout lee-mfd/for-mfd-next
        b4 shazam https://lore.kernel.org/r/20230610025759.1813-2-demi@invisiblethingslab.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/staging/media/atomisp/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306102055.ZSJK8Xsj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/staging/media/atomisp//pci/ia_css_acc_types.h:25,
                    from drivers/staging/media/atomisp//pci/ia_css_pipe_public.h:29,
                    from drivers/staging/media/atomisp//pci/ia_css_stream_public.h:25,
                    from drivers/staging/media/atomisp//pci/runtime/binary/interface/ia_css_binary.h:23,
                    from drivers/staging/media/atomisp//pci/runtime/debug/interface/ia_css_debug.h:25,
                    from drivers/staging/media/atomisp/pci/isp/kernels/macc/macc_1.0/ia_css_macc.host.c:18:
>> drivers/staging/media/atomisp//pci/hive_isp_css_include/platform_support.h:30: warning: "UCHAR_MAX" redefined
      30 | #define UCHAR_MAX  (255)
         | 
   In file included from include/linux/limits.h:7,
                    from drivers/staging/media/atomisp//pci/hive_isp_css_include/type_support.h:37,
                    from drivers/staging/media/atomisp//pci/ia_css_types.h:27,
                    from drivers/staging/media/atomisp/pci/isp/kernels/macc/macc_1.0/ia_css_macc.host.c:16:
   include/vdso/limits.h:5: note: this is the location of the previous definition
       5 | #define UCHAR_MAX       ((unsigned char)~0U)
         | 


vim +/UCHAR_MAX +30 drivers/staging/media/atomisp//pci/hive_isp_css_include/platform_support.h

ad85094b293e40 drivers/staging/media/atomisp/pci/atomisp2/css2400/hive_isp_css_include/platform_support.h Mauro Carvalho Chehab 2020-04-19  27  
ad85094b293e40 drivers/staging/media/atomisp/pci/atomisp2/css2400/hive_isp_css_include/platform_support.h Mauro Carvalho Chehab 2020-04-19  28  #define UINT16_MAX USHRT_MAX
ad85094b293e40 drivers/staging/media/atomisp/pci/atomisp2/css2400/hive_isp_css_include/platform_support.h Mauro Carvalho Chehab 2020-04-19  29  #define UINT32_MAX UINT_MAX
ad85094b293e40 drivers/staging/media/atomisp/pci/atomisp2/css2400/hive_isp_css_include/platform_support.h Mauro Carvalho Chehab 2020-04-19 @30  #define UCHAR_MAX  (255)
ad85094b293e40 drivers/staging/media/atomisp/pci/atomisp2/css2400/hive_isp_css_include/platform_support.h Mauro Carvalho Chehab 2020-04-19  31  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
