Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1280B6B1E6B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCIIl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCIIlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:41:32 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8E059E4A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678351231; x=1709887231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G5dU4hHATFfv7G2/A3JDJPT5blZGxoer2PPC5vaPk28=;
  b=F7sDRGqzRU1G6ypv4Q+T0j47VyH++JH5wkKwhzj+Vz0Jg0LMfmQRTLUs
   u786UA3OcXZml9aDBm+AlkOXeasnoqs3UODBklsrRKadUCaz5SUwXhoIn
   6YgBL3204LDfo4hTj4jZWSGcqgH/vtfT1GpVUdEjO4hquxHIlcEpWMjON
   IqSP3SAqfJFFZL/gv3GRMe8iOBGVoVLcIKPyZKdisFCpKOVfTPeyn1gaa
   OEnNRw6TOHnxvgxMZzKO+2fQ0ISAvhDPeBXsHprrKQIV1UaGHkdkuG/km
   lRVRrGhfEjCtXc8wxRgZf8owG2ffxNq+sRDSF79+WOvRcRCWUpspMl6zp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="422661720"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="422661720"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746235109"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746235109"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Mar 2023 00:40:17 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paBou-0002oS-1W;
        Thu, 09 Mar 2023 08:40:16 +0000
Date:   Thu, 9 Mar 2023 16:39:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] coresight: Fix CTI module refcount leak by making it
 a helper device
Message-ID: <202303091610.lmXasuRR-lkp@intel.com>
References: <20230308173904.3449231-9-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308173904.3449231-9-james.clark@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc1 next-20230309]
[cannot apply to atorgue-stm32/stm32-next soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Clark/coresight-Use-enum-type-for-cs_mode-wherever-possible/20230309-014226
patch link:    https://lore.kernel.org/r/20230308173904.3449231-9-james.clark%40arm.com
patch subject: [PATCH 8/8] coresight: Fix CTI module refcount leak by making it a helper device
config: arm-randconfig-r005-20230309 (https://download.01.org/0day-ci/archive/20230309/202303091610.lmXasuRR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f9e928551717a3c3c97e8264ed48a11a27d1667d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review James-Clark/coresight-Use-enum-type-for-cs_mode-wherever-possible/20230309-014226
        git checkout f9e928551717a3c3c97e8264ed48a11a27d1667d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/hwtracing/coresight/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303091610.lmXasuRR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-cti-core.c:586:26: warning: no previous prototype for 'cti__get_cti_device' [-Wmissing-prototypes]
     586 | struct coresight_device *cti__get_cti_device(struct coresight_device *csdev)
         |                          ^~~~~~~~~~~~~~~~~~~


vim +/cti__get_cti_device +586 drivers/hwtracing/coresight/coresight-cti-core.c

   585	
 > 586	struct coresight_device *cti__get_cti_device(struct coresight_device *csdev)
   587	{
   588		int i;
   589		struct coresight_device *tmp;
   590	
   591		for (i = 0; i < csdev->pdata->nr_outconns; i++) {
   592			tmp = csdev->pdata->out_conns[i].child_dev;
   593	
   594			if (tmp && tmp->type == CORESIGHT_DEV_TYPE_HELPER &&
   595			    tmp->subtype.helper_subtype ==
   596				    CORESIGHT_DEV_SUBTYPE_HELPER_ECT_CTI)
   597				return tmp;
   598		}
   599		return NULL;
   600	}
   601	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
