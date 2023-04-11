Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784546DE7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 01:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDKXTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 19:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDKXTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 19:19:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9345C30FD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 16:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681255176; x=1712791176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5lWfbaukBY0AMGMSMLq4CSRNcNltmmEQeJtpDY+cJQU=;
  b=SChxuwzg4YvF56UFXA9tpi+CN4290QMEY6VJ4ZqKQFVcioEWqr3vIHac
   iC7IkZ3EanEPgZSod8LCqBOZZWhhZhYwAR2H3J2l0pvYnRPBa0B4SSj7X
   Mft9EI3wFsVIYW7pjdYK/adNUO9H8h/r+DGgNuY7LTWLjN2zKO8xNllk6
   l2liv58X899IhM/rrEHH6er+7shuYTakvAJGmvAubsv+c98Y/uH8h7osZ
   ecwQjuHuvoB29XdIq0bdH+3NwLUsKQRaQ1I8kVqDWESVf2r1nH4U/RoxF
   EJ567R1lmN2ZNrRQbQg7huw7VMf8ugWw/kG6F4RsrbI1J6fMTRRUBC6g8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="343761861"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343761861"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 16:19:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="721362136"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="721362136"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Apr 2023 16:19:32 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmNGt-000Wo1-2Y;
        Tue, 11 Apr 2023 23:19:31 +0000
Date:   Wed, 12 Apr 2023 07:19:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Yacoub <markyacoub@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     oe-kbuild-all@lists.linux.dev, seanpaul@chromium.org,
        suraj.kandpal@intel.com, dianders@chromium.org,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/10] drm/hdcp: Expand HDCP helper library for
 enable/disable/check
Message-ID: <202304120709.oF7BKZuf-lkp@intel.com>
References: <20230411192134.508113-5-markyacoub@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411192134.508113-5-markyacoub@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-intel/for-linux-next-fixes]
[also build test WARNING on drm/drm-next linus/master v6.3-rc6 next-20230411]
[cannot apply to drm-tip/drm-tip drm-misc/drm-misc-next drm-intel/for-linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Yacoub/drm-hdcp-Add-drm_hdcp_atomic_check/20230412-032412
base:   git://anongit.freedesktop.org/drm-intel for-linux-next-fixes
patch link:    https://lore.kernel.org/r/20230411192134.508113-5-markyacoub%40google.com
patch subject: [PATCH v9 04/10] drm/hdcp: Expand HDCP helper library for enable/disable/check
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230412/202304120709.oF7BKZuf-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/972a98f65fb56b3be4370593c2b81f1283750db7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mark-Yacoub/drm-hdcp-Add-drm_hdcp_atomic_check/20230412-032412
        git checkout 972a98f65fb56b3be4370593c2b81f1283750db7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/gpu/drm/display/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304120709.oF7BKZuf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/display/drm_hdcp_helper.c:675:5: warning: no previous prototype for 'drm_hdcp_helper_hdcp1_capable_dp' [-Wmissing-prototypes]
     675 | int drm_hdcp_helper_hdcp1_capable_dp(struct drm_hdcp_helper_data *data,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/display/drm_hdcp_helper.c:1325:5: warning: no previous prototype for 'drm_hdcp_hdcp1_check_link_registers_dp' [-Wmissing-prototypes]
    1325 | int drm_hdcp_hdcp1_check_link_registers_dp(struct drm_device *dev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/drm_hdcp_helper_hdcp1_capable_dp +675 drivers/gpu/drm/display/drm_hdcp_helper.c

   674	
 > 675	int drm_hdcp_helper_hdcp1_capable_dp(struct drm_hdcp_helper_data *data,
   676					     bool *capable)
   677	{
   678		int ret;
   679		u8 bcaps;
   680	
   681		ret = data->display_type_funcs->remote_read(
   682			data, data->hdcp1_lut->bcaps, &bcaps, 1);
   683		*capable = !ret && (bcaps & DP_BCAPS_HDCP_CAPABLE);
   684	
   685		return 0;
   686	}
   687	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
