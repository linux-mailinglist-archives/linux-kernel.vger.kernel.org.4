Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11DD6E8B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjDTHlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDTHlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:41:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16AC40F5;
        Thu, 20 Apr 2023 00:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681976501; x=1713512501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NhVnAVol5gXAIwXYVWqD7i2sY1WMUpuOf8O646Hurhg=;
  b=CW+XdxILvv0r7qAtFfza/EwVfA5t7J2oeKmNvLRvcBD1PZRTiVUNWFWe
   fG8Fo7Do+SD6JeYfs8Aj5DSlDplfR12qrtGYMCHTPJgzHdJkmWUtXuu52
   HQ60DifYPf2DNMDlAniDo0AlvWIxXQNOFl+g/19gp7EhaxeeNBZ24I7BP
   JQNT5/JondN8hhHvzKmBDViJRgYgOWYH6aRvFnOP1GP5tDHv9AyuDWlL1
   2deB0S3OEPqRkyx2GQZVzaraxQ6xt9Zo4iOWH+OVYNnrAKGpwGYHqfNM1
   5R1/7dHxa09xlN6Qks4N8DoZD8SvgndaFPqjzcFxkRFMZB2iYwnYahGG/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="431940277"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="431940277"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 00:41:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="815916515"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="815916515"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2023 00:41:36 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppOv4-000fak-2x;
        Thu, 20 Apr 2023 07:41:30 +0000
Date:   Thu, 20 Apr 2023 15:41:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Yacoub <markyacoub@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     oe-kbuild-all@lists.linux.dev, suraj.kandpal@intel.com,
        Mark Yacoub <markyacoub@chromium.org>,
        intel-gfx@lists.freedesktop.org, dianders@chromium.org,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>, seanpaul@chromium.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 10/10] drm/msm: Implement HDCP 1.x using the new drm
 HDCP helpers
Message-ID: <202304201512.clLNZI0u-lkp@intel.com>
References: <20230419154321.1993419-11-markyacoub@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419154321.1993419-11-markyacoub@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-intel/for-linux-next-fixes]
[also build test ERROR on linus/master v6.3-rc7]
[cannot apply to drm-misc/drm-misc-next drm-intel/for-linux-next drm/drm-next next-20230419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Yacoub/drm-hdcp-Add-drm_hdcp_atomic_check/20230419-234833
base:   git://anongit.freedesktop.org/drm-intel for-linux-next-fixes
patch link:    https://lore.kernel.org/r/20230419154321.1993419-11-markyacoub%40google.com
patch subject: [PATCH v10 10/10] drm/msm: Implement HDCP 1.x using the new drm HDCP helpers
config: arm64-randconfig-r022-20230416 (https://download.01.org/0day-ci/archive/20230420/202304201512.clLNZI0u-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6fb5b032262769c786a7a8c9ed522d936dcf14c2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mark-Yacoub/drm-hdcp-Add-drm_hdcp_atomic_check/20230419-234833
        git checkout 6fb5b032262769c786a7a8c9ed522d936dcf14c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304201512.clLNZI0u-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/gpu/drm/msm/msm_atomic.o: in function `msm_atomic_commit_connectors':
>> drivers/gpu/drm/msm/msm_atomic.c:193: undefined reference to `dp_drm_is_bridge_msm_dp'
   drivers/gpu/drm/msm/msm_atomic.c:193:(.text+0x1368): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `dp_drm_is_bridge_msm_dp'
>> aarch64-linux-ld: drivers/gpu/drm/msm/msm_atomic.c:194: undefined reference to `dp_drm_atomic_commit'
   drivers/gpu/drm/msm/msm_atomic.c:194:(.text+0x137c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `dp_drm_atomic_commit'
   aarch64-linux-ld: drivers/gpu/drm/msm/dp/dp_debug.o: in function `dp_hdcp_key_write':
>> drivers/gpu/drm/msm/dp/dp_debug.c:219: undefined reference to `dp_hdcp_ingest_key'
   drivers/gpu/drm/msm/dp/dp_debug.c:219:(.text+0x98): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `dp_hdcp_ingest_key'


vim +193 drivers/gpu/drm/msm/msm_atomic.c

   184	
   185	static void msm_atomic_commit_connectors(struct drm_atomic_state *state)
   186	{
   187		struct drm_device *dev = state->dev;
   188		struct msm_drm_private *priv = dev->dev_private;
   189		int i;
   190	
   191		for (i = 0; i < priv->num_bridges; ++i) {
   192			struct drm_bridge *bridge = priv->bridges[i];
 > 193			if (dp_drm_is_bridge_msm_dp(bridge)) {
 > 194				dp_drm_atomic_commit(bridge, state);
   195			}
   196		}
   197	}
   198	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
