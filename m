Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69B6D2C0D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 02:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjDAAUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 20:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjDAAUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 20:20:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA6E1D844
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 17:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680308436; x=1711844436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i+fMdauhfahN1aZCfVPkPAeQqjT40gdgL5LTsfvPY/s=;
  b=j7vDzXu9dUlGRPksitBAaeQQjHDaHEqfCFc9joBAAXP8V+HDt+Tv0zua
   3iirGvysKNybvixWRSoxHyjoby7COXtVEn5vhIVznZ6YZU9SooLXxNj8w
   91zPureQbU+MvTGdPwZUmYyE6n27HZMdEo8EBWZrYDCmYFJoruq7AvWKO
   RqGf988+QcJBmbPtx9SSeaUxkjUtWvUE+f7G2NAn4pWsciNxWs4ZD6Ehm
   7WlX4d1z/bBgdU2Pxs/fDUW/qFpgawFJqaqtu5CY9pSGyVr1zTDVycTFi
   K8SRFcyGhqCfk/dNOT40PEO3M3h2yOKg66/0WlR95v4E/oqU/0pi4t5Dh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="344128907"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="344128907"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 17:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="662581327"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="662581327"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Mar 2023 17:20:03 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piOyQ-000MIf-2t;
        Sat, 01 Apr 2023 00:20:02 +0000
Date:   Sat, 1 Apr 2023 08:19:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Yacoub <markyacoub@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     oe-kbuild-all@lists.linux.dev, seanpaul@chromium.org,
        suraj.kandpal@intel.com, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/10] drm/hdcp: Expand HDCP helper library for
 enable/disable/check
Message-ID: <202304010815.5iVFI5nv-lkp@intel.com>
References: <20230331221213.1691997-5-markyacoub@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331221213.1691997-5-markyacoub@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

I love your patch! Perhaps something to improve:

[auto build test WARNING on drm-intel/for-linux-next-fixes]
[also build test WARNING on drm/drm-next linus/master v6.3-rc4 next-20230331]
[cannot apply to drm-misc/drm-misc-next drm-intel/for-linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Yacoub/drm-hdcp-Add-drm_hdcp_atomic_check/20230401-061425
base:   git://anongit.freedesktop.org/drm-intel for-linux-next-fixes
patch link:    https://lore.kernel.org/r/20230331221213.1691997-5-markyacoub%40google.com
patch subject: [PATCH v8 04/10] drm/hdcp: Expand HDCP helper library for enable/disable/check
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20230401/202304010815.5iVFI5nv-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/82a092e7e090cdeb3ff18498e6ad671906268631
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mark-Yacoub/drm-hdcp-Add-drm_hdcp_atomic_check/20230401-061425
        git checkout 82a092e7e090cdeb3ff18498e6ad671906268631
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/display/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304010815.5iVFI5nv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/display/drm_hdcp_helper.c:719: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Check if the sink is capable of HDCP 1.x. DisplayPort has a dedicated bit
   drivers/gpu/drm/display/drm_hdcp_helper.c:742: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Check if the sink is capable of HDCP 1.x. HDMI spec states that transmitters
   drivers/gpu/drm/display/drm_hdcp_helper.c:1633: warning: Function parameter or member 'aux' not described in 'drm_hdcp_helper_initialize_dp'


vim +719 drivers/gpu/drm/display/drm_hdcp_helper.c

   717	
   718	/**
 > 719	 * Check if the sink is capable of HDCP 1.x. DisplayPort has a dedicated bit
   720	 * for this in DPCD.
   721	 *
   722	 * @data: pointer to the HDCP helper data.
   723	 * @capable: pointer to a bool which will contain true if the sink is capable.
   724	 *
   725	 * Returns:
   726	 * -errno if the transacation between source and sink fails.
   727	 */
   728	int drm_hdcp_helper_hdcp1_capable_dp(struct drm_hdcp_helper_data *data,
   729					     bool *capable)
   730	{
   731		int ret;
   732		u8 bcaps;
   733	
   734		ret = data->funcs->remote_read(data, data->hdcp1_lut->bcaps, &bcaps, 1);
   735		*capable = !ret && (bcaps & DP_BCAPS_HDCP_CAPABLE);
   736	
   737		return 0;
   738	}
   739	EXPORT_SYMBOL(drm_hdcp_helper_hdcp1_capable_dp);
   740	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
