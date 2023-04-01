Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D12F6D2DFF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 05:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjDADtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 23:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjDADtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 23:49:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB347F75C;
        Fri, 31 Mar 2023 20:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680320942; x=1711856942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iKRGjxyuVPlp7bjfbPORRfcTp1PxnLq+Mx9fXMULy44=;
  b=PJzX4mCSl9L2jiuSGvZ+N0EMt67ebEwMK3TV54KB5fQcqM3N7qifeSoi
   +0qJpiNYj4Sk3m196E4yTN19GEcuRsTgvdudW+j6nwSGUaUSIc5N8kYMJ
   6l7JXhUq13yeuP5jRxVNqcL3pKiiUChtijLJNWyrHAIPOwQ4MolIblPS8
   1pmlWirOXhNMTXOQafV8XcSz5YeInJgDJ4Zpkt7CbZKheXPc2aJjFjA5L
   tO96lc92sCXzVIgJ2/WI/FIoY9Sszy9ilgEtZHYZpbQJY1y/JfNmUfVFx
   cczYRv2ccbAqHWmd8YeI1M3h+zv/UBtEYX0nhgnxi1761OL1942TXkyDz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="321268508"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="321268508"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 20:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="662612093"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="662612093"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Mar 2023 20:45:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piSAv-000MQR-2Z;
        Sat, 01 Apr 2023 03:45:09 +0000
Date:   Sat, 1 Apr 2023 11:44:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Yacoub <markyacoub@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     oe-kbuild-all@lists.linux.dev,
        Mark Yacoub <markyacoub@chromium.org>,
        intel-gfx@lists.freedesktop.org, dianders@chromium.org,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>, seanpaul@chromium.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH v8 10/10] drm/msm: Implement HDCP 1.x using
 the new drm HDCP helpers
Message-ID: <202304011152.dsr8g6yX-lkp@intel.com>
References: <20230331221213.1691997-11-markyacoub@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331221213.1691997-11-markyacoub@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

I love your patch! Yet something to improve:

[auto build test ERROR on drm-intel/for-linux-next-fixes]
[also build test ERROR on linus/master v6.3-rc4]
[cannot apply to drm-misc/drm-misc-next drm-intel/for-linux-next drm/drm-next next-20230331]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Yacoub/drm-hdcp-Add-drm_hdcp_atomic_check/20230401-061425
base:   git://anongit.freedesktop.org/drm-intel for-linux-next-fixes
patch link:    https://lore.kernel.org/r/20230331221213.1691997-11-markyacoub%40google.com
patch subject: [Intel-gfx] [PATCH v8 10/10] drm/msm: Implement HDCP 1.x using the new drm HDCP helpers
config: arc-randconfig-r043-20230329 (https://download.01.org/0day-ci/archive/20230401/202304011152.dsr8g6yX-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/697c762c590d862f4f6ed4a8cac97ac2de815f73
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mark-Yacoub/drm-hdcp-Add-drm_hdcp_atomic_check/20230401-061425
        git checkout 697c762c590d862f4f6ed4a8cac97ac2de815f73
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304011152.dsr8g6yX-lkp@intel.com/

All errors (new ones prefixed by >>):

   arc-elf-ld: drivers/gpu/drm/msm/msm_atomic.o: in function `msm_atomic_commit_tail':
>> drivers/gpu/drm/msm/msm_atomic.c:193: undefined reference to `dp_drm_is_bridge_msm_dp'
>> arc-elf-ld: drivers/gpu/drm/msm/msm_atomic.c:193: undefined reference to `dp_drm_is_bridge_msm_dp'
>> arc-elf-ld: drivers/gpu/drm/msm/msm_atomic.c:194: undefined reference to `dp_drm_atomic_commit'
>> arc-elf-ld: drivers/gpu/drm/msm/msm_atomic.c:194: undefined reference to `dp_drm_atomic_commit'
   arc-elf-ld: drivers/gpu/drm/msm/dp/dp_debug.o: in function `dp_hdcp_key_write':
>> drivers/gpu/drm/msm/dp/dp_debug.c:219: undefined reference to `dp_hdcp_ingest_key'
>> arc-elf-ld: drivers/gpu/drm/msm/dp/dp_debug.c:219: undefined reference to `dp_hdcp_ingest_key'


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
