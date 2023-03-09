Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0AB6B1DC5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCIIWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCIIWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:22:00 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84187B32BB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349960; x=1709885960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LxitaPLDKDiwktycQFO+JpurANiChLYy613O1BTD8w8=;
  b=g3bTzNzjk2uCz7jlhfZV1E2HfiyVoZ3l4NdyMbCtr9W5RCmcyca8ul0m
   ezL6PHJD9kC/sTLzuL5+PDViit+RsWdolavBWM8X6O72d76YNlfwUPomd
   44JAM+WLt8R50ZxwkdjXfMx7z7mIRTDtFve9x5WIpknW4w7JhbTG1jVkF
   aUWVIICPPywmCtUop05pOcjKAz7m23K7/vJdeDORjGEXpcsMXjyqbKrgy
   mq0YKraDiHBTnHddLUWDYlREGHDsQ9xT+9KVLQ368SG4ORVbz1oGIElGo
   qxmXJjrn6Gl1q0mr5ffzk1JQGJbOuvMB3X83u0Jx1dOMXkf5MlvpRhJmo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="324707099"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="324707099"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:19:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="627267779"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="627267779"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2023 00:19:16 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paBUZ-0002ms-1T;
        Thu, 09 Mar 2023 08:19:15 +0000
Date:   Thu, 9 Mar 2023 16:18:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] coresight: Refactor out buffer allocation function
 for ETR
Message-ID: <202303091603.UuxHblt7-lkp@intel.com>
References: <20230308173904.3449231-7-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308173904.3449231-7-james.clark@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230308173904.3449231-7-james.clark%40arm.com
patch subject: [PATCH 6/8] coresight: Refactor out buffer allocation function for ETR
config: arm-randconfig-r046-20230308 (https://download.01.org/0day-ci/archive/20230309/202303091603.UuxHblt7-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3651e0e04e2a01c3cbcb4a4e9289092f2377dc13
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review James-Clark/coresight-Use-enum-type-for-cs_mode-wherever-possible/20230309-014226
        git checkout 3651e0e04e2a01c3cbcb4a4e9289092f2377dc13
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/hwtracing/coresight/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303091603.UuxHblt7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwtracing/coresight/coresight-tmc-etr.c: In function 'tmc_etr_get_sysfs_buffer':
>> drivers/hwtracing/coresight/coresight-tmc-etr.c:1174:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    1174 |         int ret = 0;
         |             ^~~


vim +/ret +1174 drivers/hwtracing/coresight/coresight-tmc-etr.c

6c6ed1e244c053 Mathieu Poirier  2016-05-03  1171  
3651e0e04e2a01 James Clark      2023-03-08  1172  static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
6c6ed1e244c053 Mathieu Poirier  2016-05-03  1173  {
de5461970b3e9e Mathieu Poirier  2016-05-03 @1174  	int ret = 0;
6c6ed1e244c053 Mathieu Poirier  2016-05-03  1175  	unsigned long flags;
6c6ed1e244c053 Mathieu Poirier  2016-05-03  1176  	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
96a7f644006ecc Suzuki K Poulose 2018-09-20  1177  	struct etr_buf *sysfs_buf = NULL, *new_buf = NULL, *free_buf = NULL;
6c6ed1e244c053 Mathieu Poirier  2016-05-03  1178  
de5461970b3e9e Mathieu Poirier  2016-05-03  1179  	/*
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1180  	 * If we are enabling the ETR from disabled state, we need to make
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1181  	 * sure we have a buffer with the right size. The etr_buf is not reset
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1182  	 * immediately after we stop the tracing in SYSFS mode as we wait for
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1183  	 * the user to collect the data. We may be able to reuse the existing
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1184  	 * buffer, provided the size matches. Any allocation has to be done
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1185  	 * with the lock released.
de5461970b3e9e Mathieu Poirier  2016-05-03  1186  	 */
6c6ed1e244c053 Mathieu Poirier  2016-05-03  1187  	spin_lock_irqsave(&drvdata->spinlock, flags);
96a7f644006ecc Suzuki K Poulose 2018-09-20  1188  	sysfs_buf = READ_ONCE(drvdata->sysfs_buf);
96a7f644006ecc Suzuki K Poulose 2018-09-20  1189  	if (!sysfs_buf || (sysfs_buf->size != drvdata->size)) {
6c6ed1e244c053 Mathieu Poirier  2016-05-03  1190  		spin_unlock_irqrestore(&drvdata->spinlock, flags);
de5461970b3e9e Mathieu Poirier  2016-05-03  1191  
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1192  		/* Allocate memory with the locks released */
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1193  		free_buf = new_buf = tmc_etr_setup_sysfs_buf(drvdata);
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1194  		if (IS_ERR(new_buf))
3651e0e04e2a01 James Clark      2023-03-08  1195  			return new_buf;
de5461970b3e9e Mathieu Poirier  2016-05-03  1196  
de5461970b3e9e Mathieu Poirier  2016-05-03  1197  		/* Let's try again */
de5461970b3e9e Mathieu Poirier  2016-05-03  1198  		spin_lock_irqsave(&drvdata->spinlock, flags);
de5461970b3e9e Mathieu Poirier  2016-05-03  1199  	}
de5461970b3e9e Mathieu Poirier  2016-05-03  1200  
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1201  	if (drvdata->reading || drvdata->mode == CS_MODE_PERF) {
de5461970b3e9e Mathieu Poirier  2016-05-03  1202  		ret = -EBUSY;
de5461970b3e9e Mathieu Poirier  2016-05-03  1203  		goto out;
6c6ed1e244c053 Mathieu Poirier  2016-05-03  1204  	}
6c6ed1e244c053 Mathieu Poirier  2016-05-03  1205  
f2facc3366d77e Mathieu Poirier  2016-05-03  1206  	/*
f2facc3366d77e Mathieu Poirier  2016-05-03  1207  	 * In sysFS mode we can have multiple writers per sink.  Since this
f2facc3366d77e Mathieu Poirier  2016-05-03  1208  	 * sink is already enabled no memory is needed and the HW need not be
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1209  	 * touched, even if the buffer size has changed.
f2facc3366d77e Mathieu Poirier  2016-05-03  1210  	 */
f973d88b757037 Mathieu Poirier  2019-04-25  1211  	if (drvdata->mode == CS_MODE_SYSFS) {
f973d88b757037 Mathieu Poirier  2019-04-25  1212  		atomic_inc(csdev->refcnt);
f2facc3366d77e Mathieu Poirier  2016-05-03  1213  		goto out;
f973d88b757037 Mathieu Poirier  2019-04-25  1214  	}
f2facc3366d77e Mathieu Poirier  2016-05-03  1215  
de5461970b3e9e Mathieu Poirier  2016-05-03  1216  	/*
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1217  	 * If we don't have a buffer or it doesn't match the requested size,
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1218  	 * use the buffer allocated above. Otherwise reuse the existing buffer.
de5461970b3e9e Mathieu Poirier  2016-05-03  1219  	 */
96a7f644006ecc Suzuki K Poulose 2018-09-20  1220  	sysfs_buf = READ_ONCE(drvdata->sysfs_buf);
96a7f644006ecc Suzuki K Poulose 2018-09-20  1221  	if (!sysfs_buf || (new_buf && sysfs_buf->size != new_buf->size)) {
96a7f644006ecc Suzuki K Poulose 2018-09-20  1222  		free_buf = sysfs_buf;
96a7f644006ecc Suzuki K Poulose 2018-09-20  1223  		drvdata->sysfs_buf = new_buf;
de5461970b3e9e Mathieu Poirier  2016-05-03  1224  	}
de5461970b3e9e Mathieu Poirier  2016-05-03  1225  
de5461970b3e9e Mathieu Poirier  2016-05-03  1226  out:
6c6ed1e244c053 Mathieu Poirier  2016-05-03  1227  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
6c6ed1e244c053 Mathieu Poirier  2016-05-03  1228  
de5461970b3e9e Mathieu Poirier  2016-05-03  1229  	/* Free memory outside the spinlock if need be */
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1230  	if (free_buf)
75f4e3619fe202 Suzuki K Poulose 2018-07-11  1231  		tmc_etr_free_sysfs_buf(free_buf);
3651e0e04e2a01 James Clark      2023-03-08  1232  	return drvdata->sysfs_buf;
3651e0e04e2a01 James Clark      2023-03-08  1233  }
3651e0e04e2a01 James Clark      2023-03-08  1234  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
