Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8BE743D85
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjF3Oao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjF3Oaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:30:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D404E3AA4;
        Fri, 30 Jun 2023 07:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688135437; x=1719671437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9I8VS6WX/BF/j754AYm46KpzU8aeLTf85BRuBqO8fhg=;
  b=aTqd5pXEry3xOwcRJ7AK5KOnPgX9h2JA1F97OqgcXnwPex759UDa6rx9
   U71lXZsUrTMER6w/wqS3ifwWzGwvwKsql3QN9wvxU6Xlyb+2ABgNpHi+6
   XVGwDx4SpylU1AMVgCYB0lbV6VJpimq0I8ZN5JJlBZjCKJG0RX8SpDxur
   rujDGpB8ASjgGFWaStwJNKnB8H7zOfCAc66CdqTZBF96jqb7iSf3appCL
   i2KGWoH2SM0TW2nZQ8Bhwht+SaEb8FdzQkubkm7NiAI4UEAe0oZMeoUYi
   ibOW8Gty1PQ0bEGwNAjaw6QrEXwltHXCIkHMfOO/glBoEUWJOfdSKbvWM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="352226619"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="352226619"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 07:30:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="717821775"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="717821775"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Jun 2023 07:30:29 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFF8m-000F2T-1o;
        Fri, 30 Jun 2023 14:30:28 +0000
Date:   Fri, 30 Jun 2023 22:29:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Quan <evan.quan@amd.com>, rafael@kernel.org, lenb@kernel.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Mario.Limonciello@amd.com, mdaenzer@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        hdegoede@redhat.com, jingyuwang_vip@163.com, Lijo.Lazar@amd.com,
        jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH V5 7/9] drm/amd/pm: add flood detection for wbrf events
Message-ID: <202306302258.ZdzWnrmF-lkp@intel.com>
References: <20230630103240.1557100-8-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630103240.1557100-8-evan.quan@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main v6.4]
[cannot apply to drm-misc/drm-misc-next linus/master next-20230630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Evan-Quan/drivers-core-Add-support-for-Wifi-band-RF-mitigations/20230630-183633
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20230630103240.1557100-8-evan.quan%40amd.com
patch subject: [PATCH V5 7/9] drm/amd/pm: add flood detection for wbrf events
config: x86_64-buildonly-randconfig-r003-20230630 (https://download.01.org/0day-ci/archive/20230630/202306302258.ZdzWnrmF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230630/202306302258.ZdzWnrmF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306302258.ZdzWnrmF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c: In function 'smu_wbrf_init':
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:1336:31: warning: unused variable 'adev' [-Wunused-variable]
    1336 |         struct amdgpu_device *adev = smu->adev;
         |                               ^~~~


vim +/adev +1336 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c

19fbe240b2627a Evan Quan 2023-06-30  1324  
19fbe240b2627a Evan Quan 2023-06-30  1325  /**
19fbe240b2627a Evan Quan 2023-06-30  1326   * smu_wbrf_init - init driver wbrf support
19fbe240b2627a Evan Quan 2023-06-30  1327   *
19fbe240b2627a Evan Quan 2023-06-30  1328   * @smu: smu_context pointer
19fbe240b2627a Evan Quan 2023-06-30  1329   *
19fbe240b2627a Evan Quan 2023-06-30  1330   * Verifies the AMD ACPI interfaces and registers with the wbrf
19fbe240b2627a Evan Quan 2023-06-30  1331   * notifier chain if wbrf feature is supported.
19fbe240b2627a Evan Quan 2023-06-30  1332   * Returns 0 on success, error on failure.
19fbe240b2627a Evan Quan 2023-06-30  1333   */
19fbe240b2627a Evan Quan 2023-06-30  1334  static int smu_wbrf_init(struct smu_context *smu)
19fbe240b2627a Evan Quan 2023-06-30  1335  {
19fbe240b2627a Evan Quan 2023-06-30 @1336  	struct amdgpu_device *adev = smu->adev;
19fbe240b2627a Evan Quan 2023-06-30  1337  	int ret;
19fbe240b2627a Evan Quan 2023-06-30  1338  
19fbe240b2627a Evan Quan 2023-06-30  1339  	if (!smu->wbrf_supported)
19fbe240b2627a Evan Quan 2023-06-30  1340  		return 0;
19fbe240b2627a Evan Quan 2023-06-30  1341  
0b8224d2686865 Evan Quan 2023-06-30  1342  	INIT_DELAYED_WORK(&smu->wbrf_delayed_work,
0b8224d2686865 Evan Quan 2023-06-30  1343  			  smu_wbrf_delayed_work_handler);
0b8224d2686865 Evan Quan 2023-06-30  1344  
19fbe240b2627a Evan Quan 2023-06-30  1345  	smu->wbrf_notifier.notifier_call = smu_wbrf_event_handler;
19fbe240b2627a Evan Quan 2023-06-30  1346  	ret = wbrf_register_notifier(&smu->wbrf_notifier);
19fbe240b2627a Evan Quan 2023-06-30  1347  	if (ret)
19fbe240b2627a Evan Quan 2023-06-30  1348  		return ret;
19fbe240b2627a Evan Quan 2023-06-30  1349  
19fbe240b2627a Evan Quan 2023-06-30  1350  	/*
19fbe240b2627a Evan Quan 2023-06-30  1351  	 * Some wifiband exclusion ranges may be already there
19fbe240b2627a Evan Quan 2023-06-30  1352  	 * before our driver loaded. To make sure our driver
19fbe240b2627a Evan Quan 2023-06-30  1353  	 * is awared of those exclusion ranges.
19fbe240b2627a Evan Quan 2023-06-30  1354  	 */
0b8224d2686865 Evan Quan 2023-06-30  1355  	schedule_delayed_work(&smu->wbrf_delayed_work,
0b8224d2686865 Evan Quan 2023-06-30  1356  			      msecs_to_jiffies(SMU_WBRF_EVENT_HANDLING_PACE));
19fbe240b2627a Evan Quan 2023-06-30  1357  
0b8224d2686865 Evan Quan 2023-06-30  1358  	return 0;
19fbe240b2627a Evan Quan 2023-06-30  1359  }
19fbe240b2627a Evan Quan 2023-06-30  1360  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
