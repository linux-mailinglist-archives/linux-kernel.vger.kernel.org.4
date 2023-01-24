Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D3A678CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjAXAuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjAXAuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:50:35 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC01D1E281;
        Mon, 23 Jan 2023 16:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674521434; x=1706057434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dZ6BNJabTkYNTaTP/+BuHdFDJceZdO8i1XDRWoUnCP4=;
  b=Z7lZ3uzqdcLU7IU4h+yJGXK3BW4qfKEXYCk5XhFmZQYvvWiliT5PSdXs
   MDrQixHjhWDeqXLSOdV9veGFFt9vnrbw7hUykcQLhWPrdWBlIps3gVUkh
   w+vJgGL9grH5jpXNxPRyREKAa4nLvpytQp7X/Pcp0FR1UnDe7gOCoM4He
   JcPNPIQMb1x8IFSacFnd6Sz1L0R3NYzTNE9Pq7B988Ua5mDYYCBrbE5KM
   7J4vcX6hexBSL9W8d6JAR0d/q97zz2aVxCl4AGCmZXHZ2J0Z0zDjovSWH
   parLe2h1K02A1U85QlkqNSFiX8n7nlfSOZHXKL3LcZ8pYJeN8H+Rtb8Mx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="314102007"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="314102007"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="990686491"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="990686491"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jan 2023 16:50:29 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pK7W9-0005zY-07;
        Tue, 24 Jan 2023 00:50:29 +0000
Date:   Tue, 24 Jan 2023 08:49:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, quic_sbillaka@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        linux-kernel@vger.kernel.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v1 04/14] drm/msm/dp: correct configure Colorimetry
 Indicator Field at MISC0
Message-ID: <202301240836.ik3aytbc-lkp@intel.com>
References: <1674498274-6010-5-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674498274-6010-5-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuogee,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20230123]
[also build test WARNING on linus/master v6.2-rc5]
[cannot apply to drm-misc/drm-misc-next drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip v6.2-rc5 v6.2-rc4 v6.2-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuogee-Hsieh/drm-msm-dp-add-dpcd-read-of-both-dsc-and-fec-capability/20230124-022759
patch link:    https://lore.kernel.org/r/1674498274-6010-5-git-send-email-quic_khsieh%40quicinc.com
patch subject: [PATCH v1 04/14] drm/msm/dp: correct configure Colorimetry Indicator Field at MISC0
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230124/202301240836.ik3aytbc-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/834f569a141af42cb93424c24e7d146f3b88405b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kuogee-Hsieh/drm-msm-dp-add-dpcd-read-of-both-dsc-and-fec-capability/20230124-022759
        git checkout 834f569a141af42cb93424c24e7d146f3b88405b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/dp/dp_panel.c:571: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Mapper function which outputs colorimetry to be used for a


vim +571 drivers/gpu/drm/msm/dp/dp_panel.c

   569	
   570	/**
 > 571	 * Mapper function which outputs colorimetry to be used for a
   572	 * given colorspace value when misc field of MSA is used to
   573	 * change the colorimetry. Currently only RGB formats have been
   574	 * added. This API will be extended to YUV once its supported on DP.
   575	 */
   576	u8 dp_panel_get_misc_colorimetry_val(struct dp_panel *dp_panel)
   577	{
   578		u8 colorimetry;
   579		u32 colorspace;
   580		u32 cc;
   581		struct dp_panel_private *panel;
   582	
   583		panel = container_of(dp_panel, struct dp_panel_private, dp_panel);
   584	
   585		cc = dp_link_get_colorimetry_config(panel->link);
   586		/*
   587		 * If there is a non-zero value then compliance test-case
   588		 * is going on, otherwise we can honor the colorspace setting
   589		 */
   590		if (cc)
   591			return cc;
   592	
   593		colorspace = dp_panel->connector->state->colorspace;
   594		switch (colorspace) {
   595		case DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65:
   596		case DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER:
   597			colorimetry = 0x7;
   598			break;
   599		case DRM_MODE_COLORIMETRY_RGB_WIDE_FIXED:
   600			colorimetry = 0x3;
   601			break;
   602		case DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT:
   603			colorimetry = 0xb;
   604			break;
   605		case DRM_MODE_COLORIMETRY_OPRGB:
   606			colorimetry = 0xc;
   607			break;
   608		default:
   609			colorimetry = 0;
   610		}
   611	
   612		return colorimetry;
   613	}
   614	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
