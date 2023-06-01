Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D3F71A3AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjFAQEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbjFAQEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:04:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FCDE4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685635478; x=1717171478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TGGR2bLLl8X92/vFFfDqE2A/8GzFdht57yWXQPeix4w=;
  b=ffVjYekxSMcdosgV1N90JKhn7e0SFZIVMW9AES5sn0UPKTkw/p5IV8pU
   GP8Ta9dRKubYVpDZ2fTVjYMAIYVGnnmA1RTOA20hmQcTUrUfxe8jTz1F7
   3Jo6HDSyNOFaD3eP/f87MsHSHcqmQUsRHr5iGV+g1kGZ8I5hC2tdOLwxt
   lgo1IBZaPxY1MjYu2ZSppS8FgmBxtxa8ZDIXhooqr3h9x8i1RxkegByyt
   ebpr7WwyFpa/9OiY4U8c8QfpS9A7OmbQBz8RzM3OERAE9fUy2Zizk1zQK
   iLSeG8BM6vaeD8CsLvuoQP+KNPe5xEwbRyqx2Z4E7fhbLihLo29l/10mk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358897446"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="358897446"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="1037557517"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="1037557517"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jun 2023 09:03:30 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4klt-0002SI-1w;
        Thu, 01 Jun 2023 16:03:29 +0000
Date:   Fri, 2 Jun 2023 00:03:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lu Hongfei <luhongfei@vivo.com>,
        Artur Weber <aweber.kernel@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, opensource.kernel@vivo.com,
        luhongfei@vivo.com
Subject: Re: [PATCH] gpu: drm/panel: Optimize the workflow of s6d7aa0_lock
Message-ID: <202306012354.obLJxas6-lkp@intel.com>
References: <20230531110717.36896-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531110717.36896-1-luhongfei@vivo.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on next-20230601]
[cannot apply to linus/master v6.4-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lu-Hongfei/gpu-drm-panel-Optimize-the-workflow-of-s6d7aa0_lock/20230531-190848
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230531110717.36896-1-luhongfei%40vivo.com
patch subject: [PATCH] gpu: drm/panel: Optimize the workflow of s6d7aa0_lock
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230601/202306012354.obLJxas6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/e1ade7d20fb0efb9aa0b332d5ac5da2863f8e68e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lu-Hongfei/gpu-drm-panel-Optimize-the-workflow-of-s6d7aa0_lock/20230531-190848
        git checkout e1ade7d20fb0efb9aa0b332d5ac5da2863f8e68e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/panel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306012354.obLJxas6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:17:
   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c: In function 's6d7aa0_lock':
   include/drm/drm_mipi_dsi.h:326:9: error: expected expression before 'do'
     326 |         do {                                                               \
         |         ^~
   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:72:23: note: in expansion of macro 'mipi_dsi_dcs_write_seq'
      72 |                 ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0xa5, 0xa5);
         |                       ^~~~~~~~~~~~~~~~~~~~~~
   include/drm/drm_mipi_dsi.h:326:9: error: expected expression before 'do'
     326 |         do {                                                               \
         |         ^~
   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:75:23: note: in expansion of macro 'mipi_dsi_dcs_write_seq'
      75 |                 ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0xa5, 0xa5);
         |                       ^~~~~~~~~~~~~~~~~~~~~~
   include/drm/drm_mipi_dsi.h:326:9: error: expected expression before 'do'
     326 |         do {                                                               \
         |         ^~
   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:79:31: note: in expansion of macro 'mipi_dsi_dcs_write_seq'
      79 |                         ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0x5a, 0x5a);
         |                               ^~~~~~~~~~~~~~~~~~~~~~
   include/drm/drm_mipi_dsi.h:326:9: error: expected expression before 'do'
     326 |         do {                                                               \
         |         ^~
   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:84:23: note: in expansion of macro 'mipi_dsi_dcs_write_seq'
      84 |                 ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0x5a, 0x5a);
         |                       ^~~~~~~~~~~~~~~~~~~~~~
   include/drm/drm_mipi_dsi.h:326:9: error: expected expression before 'do'
     326 |         do {                                                               \
         |         ^~
   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:87:23: note: in expansion of macro 'mipi_dsi_dcs_write_seq'
      87 |                 ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0x5a, 0x5a);
         |                       ^~~~~~~~~~~~~~~~~~~~~~
   include/drm/drm_mipi_dsi.h:326:9: error: expected expression before 'do'
     326 |         do {                                                               \
         |         ^~
   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:91:31: note: in expansion of macro 'mipi_dsi_dcs_write_seq'
      91 |                         ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0xa5, 0xa5);
         |                               ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:68:33: warning: unused variable 'dsi' [-Wunused-variable]
      68 |         struct mipi_dsi_device *dsi = ctx->dsi;
         |                                 ^~~


vim +/dsi +68 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c

6810bb390282bb Artur Weber 2023-05-19  65  
6810bb390282bb Artur Weber 2023-05-19  66  static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
6810bb390282bb Artur Weber 2023-05-19  67  {
6810bb390282bb Artur Weber 2023-05-19 @68  	struct mipi_dsi_device *dsi = ctx->dsi;
6810bb390282bb Artur Weber 2023-05-19  69  	int ret = 0;
6810bb390282bb Artur Weber 2023-05-19  70  
6810bb390282bb Artur Weber 2023-05-19  71  	if (lock) {
e1ade7d20fb0ef Lu Hongfei  2023-05-31  72  		ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0xa5, 0xa5);
e1ade7d20fb0ef Lu Hongfei  2023-05-31  73  		if (ret < 0)
e1ade7d20fb0ef Lu Hongfei  2023-05-31  74  			return ret;
e1ade7d20fb0ef Lu Hongfei  2023-05-31  75  		ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0xa5, 0xa5);
e1ade7d20fb0ef Lu Hongfei  2023-05-31  76  		if (ret < 0)
e1ade7d20fb0ef Lu Hongfei  2023-05-31  77  			return ret;
e1ade7d20fb0ef Lu Hongfei  2023-05-31  78  		if (ctx->desc->use_passwd3) {
e1ade7d20fb0ef Lu Hongfei  2023-05-31  79  			ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0x5a, 0x5a);
e1ade7d20fb0ef Lu Hongfei  2023-05-31  80  			if (ret < 0)
e1ade7d20fb0ef Lu Hongfei  2023-05-31  81  				return ret;
e1ade7d20fb0ef Lu Hongfei  2023-05-31  82  		}
6810bb390282bb Artur Weber 2023-05-19  83  	} else {
e1ade7d20fb0ef Lu Hongfei  2023-05-31  84  		ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0x5a, 0x5a);
e1ade7d20fb0ef Lu Hongfei  2023-05-31  85  		if (ret < 0)
e1ade7d20fb0ef Lu Hongfei  2023-05-31  86  			return ret;
e1ade7d20fb0ef Lu Hongfei  2023-05-31  87  		ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0x5a, 0x5a);
e1ade7d20fb0ef Lu Hongfei  2023-05-31  88  		if (ret < 0)
e1ade7d20fb0ef Lu Hongfei  2023-05-31  89  			return ret;
e1ade7d20fb0ef Lu Hongfei  2023-05-31  90  		if (ctx->desc->use_passwd3) {
e1ade7d20fb0ef Lu Hongfei  2023-05-31  91  			ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0xa5, 0xa5);
e1ade7d20fb0ef Lu Hongfei  2023-05-31  92  			if (ret < 0)
e1ade7d20fb0ef Lu Hongfei  2023-05-31  93  				return ret;
e1ade7d20fb0ef Lu Hongfei  2023-05-31  94  		}
6810bb390282bb Artur Weber 2023-05-19  95  	}
6810bb390282bb Artur Weber 2023-05-19  96  
6810bb390282bb Artur Weber 2023-05-19  97  	return ret;
6810bb390282bb Artur Weber 2023-05-19  98  }
6810bb390282bb Artur Weber 2023-05-19  99  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
