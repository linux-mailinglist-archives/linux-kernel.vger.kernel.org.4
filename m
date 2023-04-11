Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E956B6DD161
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDKFFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjDKFFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:05:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B4626B6;
        Mon, 10 Apr 2023 22:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681189505; x=1712725505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mcESEGx++s2OAhRhlRIbrr37ZoLPPyWFTrdbJYKRMKI=;
  b=QNfVpmmA2sf1+GLXw6WZGQklIo1ovL7XkAGwNY0ezIAhUB2T3oSzvsyl
   qaNIkthMuTPdmXuz0/dAaRvay4whKFjDVQ5+8hxuOeBOlts3KdZTq1+6G
   Y+Zg6ko0zbpPDYqgYqnOZg0Nrn8DUiRjZ4SM6ZOLHBYtDuZvIhXQUccHo
   ki2gYTZTfuH1C3tcrb4o1fnL+/DbDdwmbAh6WodUYTn/LSwhp7lOJQIA9
   WionmsVIx+y4NGKOQ9bwJV8gErTCjV/v4bTOKiCC7FYhlyzzW5qwrDssE
   Fu3nPWIVdccyhT6ujGLMfXRPDJVJS5ljqv7SaDfTH1F8TQOXTHbRjNW79
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="323159662"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="323159662"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 22:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="681944081"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="681944081"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Apr 2023 22:04:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pm6BZ-000Vxu-2C;
        Tue, 11 Apr 2023 05:04:53 +0000
Date:   Tue, 11 Apr 2023 13:04:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: Re: [PATCH] coresight: Add support of setting trace id
Message-ID: <202304111249.6nPH3yAY-lkp@intel.com>
References: <20230410133930.30519-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410133930.30519-1-quic_jinlmao@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on atorgue-stm32/stm32-next]
[also build test WARNING on soc/for-next linus/master v6.3-rc6 next-20230406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mao-Jinlong/coresight-Add-support-of-setting-trace-id/20230410-214246
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
patch link:    https://lore.kernel.org/r/20230410133930.30519-1-quic_jinlmao%40quicinc.com
patch subject: [PATCH] coresight: Add support of setting trace id
config: arm-randconfig-r024-20230410 (https://download.01.org/0day-ci/archive/20230411/202304111249.6nPH3yAY-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/f92c27be62a6b3cef125e80682d265773e65cd13
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mao-Jinlong/coresight-Add-support-of-setting-trace-id/20230410-214246
        git checkout f92c27be62a6b3cef125e80682d265773e65cd13
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/hwtracing/coresight/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304111249.6nPH3yAY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-tpda.c:36:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (traceid < 0)
                       ^~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-tpda.c:43:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/hwtracing/coresight/coresight-tpda.c:36:3: note: remove the 'if' if its condition is always true
                   if (traceid < 0)
                   ^~~~~~~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-tpda.c:26:18: note: initialize the variable 'ret' to silence this warning
           int traceid, ret;
                           ^
                            = 0
   1 warning generated.


vim +36 drivers/hwtracing/coresight/coresight-tpda.c

    23	
    24	static int tpda_configure_trace_id(struct tpda_drvdata *drvdata)
    25	{
    26		int traceid, ret;
    27		/*
    28		 * TPDA must has a unique atid. This atid can uniquely
    29		 * identify the TPDM trace source connected to the TPDA.
    30		 * The TPDMs which are connected to same TPDA share the
    31		 * same trace-id. When TPDA does packetization, different
    32		 * port will have unique channel number for decoding.
    33		 */
    34		if (!drvdata->traceid) {
    35			traceid = coresight_trace_id_get_system_id();
  > 36			if (traceid < 0)
    37				return traceid;
    38	
    39			drvdata->traceid = traceid;
    40		} else
    41			ret = coresight_trace_id_set_system_id(drvdata->traceid);
    42	
    43		return ret;
    44	}
    45	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
