Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61AF67FC00
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 01:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjA2ArN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 19:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjA2ArH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 19:47:07 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D451E9FC;
        Sat, 28 Jan 2023 16:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674953226; x=1706489226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l0j7K1/L9M+f1mEpBM1Ek5xikMFJoO8xM/NLZGKxV44=;
  b=AfhUt2FnK0shdOndFZggk49BSI/H5WajQgJt/N9O+1HoNN+IuwLWpQ1k
   xpkBFIe8kKAkYEr4+ROYq8gWWQ1WHxqON4q/6x5sP6DErBl7PR75a9WK+
   emVF/9YqyqQaySdmi/Nmtn750IUct/GvS28OmJSTz11OL+LYRLV4IB57Y
   5BgMfXmBxZfJg05ilfWUIb/nubXtqmBjSk6EMqowGZaZziWXe5VJqR+78
   HGWrVNsnIdyjD8iJAl9mKgqrJw0y9qJJPIfjQv1Cr9UzP7q3QQ9rUjSZS
   njIIO26sPZK/U/nU5Zt+U+pcOiWvpAp60jpdJr2KHFrDoeDhfOgsXzRWt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325043676"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325043676"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 16:47:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="727086438"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="727086438"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jan 2023 16:47:01 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLvqV-0001H4-3A;
        Sun, 29 Jan 2023 00:46:59 +0000
Date:   Sun, 29 Jan 2023 08:46:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cormier <jcormier@criticallink.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>,
        Jonathan Cormier <jcormier@criticallink.com>
Subject: Re: [PATCH 4/4] DRM: BRIDGE: TFP410: If connected, use I2C for
 polled HPD status.
Message-ID: <202301290803.ouS19eab-lkp@intel.com>
References: <20230125-tfp410_i2c-v1-4-66a4d4e390b7@criticallink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-tfp410_i2c-v1-4-66a4d4e390b7@criticallink.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 93f875a8526a291005e7f38478079526c843cbec]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cormier/dt-bindings-display-bridge-tfp410-Add-tfp410-i2c-example/20230128-183627
base:   93f875a8526a291005e7f38478079526c843cbec
patch link:    https://lore.kernel.org/r/20230125-tfp410_i2c-v1-4-66a4d4e390b7%40criticallink.com
patch subject: [PATCH 4/4] DRM: BRIDGE: TFP410: If connected, use I2C for polled HPD status.
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20230129/202301290803.ouS19eab-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c4659fa4c02b62087c095ca99978e5eac8b490de
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jonathan-Cormier/dt-bindings-display-bridge-tfp410-Add-tfp410-i2c-example/20230128-183627
        git checkout c4659fa4c02b62087c095ca99978e5eac8b490de
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/bridge/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/ti-tfp410.c:111:6: warning: unused variable 'val' [-Wunused-variable]
           u32 val;
               ^
   1 warning generated.


vim +/val +111 drivers/gpu/drm/bridge/ti-tfp410.c

   106	
   107	static enum drm_connector_status
   108	tfp410_connector_detect(struct drm_connector *connector, bool force)
   109	{
   110		struct tfp410 *dvi = drm_connector_to_tfp410(connector);
 > 111		u32 val;
   112		unsigned int ret;
   113	
   114		if (dvi->i2c) {
   115			ret = regmap_test_bits(dvi->regmap, TFP410_REG_CTL_2_MODE, TFP410_BIT_HTPLG);
   116			if (ret < 0)
   117				dev_err(dvi->dev, "%s failed to read HTPLG bit : %d\n", __func__, ret);
   118			else
   119				return ret ? connector_status_connected : connector_status_disconnected;
   120		}
   121	
   122		return drm_bridge_detect(dvi->next_bridge);
   123	}
   124	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
