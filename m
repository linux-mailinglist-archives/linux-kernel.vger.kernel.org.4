Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96D68A8E5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 08:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjBDHzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 02:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBDHzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 02:55:41 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA258B7D2;
        Fri,  3 Feb 2023 23:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675497340; x=1707033340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0EHShsNIiSr8mAoNRKbDMG1uUQdS2+B2WUEPBHFZwmA=;
  b=DDt/IX3+dWWRtqxKzhm/+AIqkvuDViqdrFIb6j+Jjm1lOACHosiW9MVL
   uAIrC6jhTCW2U0UA+ypYm9PDxrNjtMHHCxtbgwg5ovoEz9nKmYL3mzg+H
   jb4b/oNRTOMc32CxVjFMNIxzM/+J9CUbIIM0sp0K1RaKALxS6OnJ5Ui+R
   rAJJrvaYfOR3woU/03ABBMkug3TCCjoZRSP6ZcAhYd/mMnIvMgH2lwK0X
   Z2qErvs+Lr8LR/4xFCyoClpHRLnOMkSvbtv+XbBtAdWNAUojL13oOaU9W
   O9KCWA3EU0gB+rWIw2F2cXpT5teXqtcR4/+jXZXqK0sNUkDXHHLzamA8o
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="328942405"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="328942405"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 23:55:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="665970771"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="665970771"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Feb 2023 23:55:37 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pODOa-00019A-1X;
        Sat, 04 Feb 2023 07:55:36 +0000
Date:   Sat, 4 Feb 2023 15:54:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] thermal/acpi: Use the thermal framework ACPI API
Message-ID: <202302041525.ZDaLecDd-lkp@intel.com>
References: <20230203174429.3375691-12-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203174429.3375691-12-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v6.2-rc6 next-20230203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-acpi-Remove-the-intermediate-acpi_thermal_trip-structure/20230204-015126
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230203174429.3375691-12-daniel.lezcano%40linaro.org
patch subject: [PATCH v2 11/11] thermal/acpi: Use the thermal framework ACPI API
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20230204/202302041525.ZDaLecDd-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2c921da06a8ac8f9e047f1a683146e1c5561534a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/thermal-acpi-Remove-the-intermediate-acpi_thermal_trip-structure/20230204-015126
        git checkout 2c921da06a8ac8f9e047f1a683146e1c5561534a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/acpi/thermal.c:274:8: error: implicit declaration of function 'thermal_acpi_critical_trip_temp' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           ret = thermal_acpi_critical_trip_temp(tz->device->handle, &trip.temperature);
                 ^
>> drivers/acpi/thermal.c:307:8: error: implicit declaration of function 'thermal_acpi_hot_trip_temp' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           ret = thermal_acpi_hot_trip_temp(tz->device->handle, &trip.temperature);
                 ^
   drivers/acpi/thermal.c:307:8: note: did you mean 'thermal_zone_get_crit_temp'?
   include/linux/thermal.h:347:5: note: 'thermal_zone_get_crit_temp' declared here
   int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
       ^
>> drivers/acpi/thermal.c:339:8: error: implicit declaration of function 'thermal_acpi_passive_trip_temp' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           ret = thermal_acpi_passive_trip_temp(tz->device->handle, &trip.temperature);
                 ^
>> drivers/acpi/thermal.c:380:9: error: implicit declaration of function 'thermal_acpi_active_trip_temp' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   ret = thermal_acpi_active_trip_temp(tz->device->handle, i , &trip.temperature);
                         ^
   4 errors generated.


vim +/thermal_acpi_critical_trip_temp +274 drivers/acpi/thermal.c

   257	
   258	static struct thermal_trip *acpi_thermal_trips_alloc_critical(struct acpi_thermal *tz,
   259								      struct thermal_trip *trips,
   260								      int *num_trips)
   261	{
   262		struct thermal_trip trip = {
   263			.type = THERMAL_TRIP_CRITICAL,
   264		};
   265	
   266		int ret;
   267	
   268		/*
   269		 * Module parameters disable the critical trip point
   270		 */
   271		if (crt < 0)
   272			goto out;
   273	
 > 274		ret = thermal_acpi_critical_trip_temp(tz->device->handle, &trip.temperature);
   275		if (ret)
   276			goto out;
   277		
   278		if (trip.temperature <= 0) {
   279			pr_info(FW_BUG "Invalid critical threshold (%d)\n", trip.temperature);
   280			goto out;
   281		}
   282	
   283		trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
   284		if (!trips)
   285			goto out;
   286	
   287		trips[*num_trips] = trip; /* structure copy */
   288	
   289		if (crt > 0)
   290			acpi_thermal_trips_override(&trips[*num_trips], crt * MILLI);
   291		
   292		(*num_trips)++;
   293	out:
   294		return trips;
   295	}
   296	
   297	static struct thermal_trip *acpi_thermal_trips_alloc_hot(struct acpi_thermal *tz,
   298								 struct thermal_trip *trips,
   299								 int *num_trips)
   300	{
   301		struct thermal_trip trip = {
   302			.type = THERMAL_TRIP_HOT,
   303		};
   304	
   305		int ret;
   306	
 > 307		ret = thermal_acpi_hot_trip_temp(tz->device->handle, &trip.temperature);
   308		if (ret)
   309			goto out;
   310	
   311		trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
   312		if (!trips)
   313			goto out;
   314	
   315		trips[*num_trips] = trip; /* structure copy */
   316		
   317		(*num_trips)++;
   318	out:
   319		return trips;
   320	}
   321	
   322	static struct thermal_trip *acpi_thermal_trips_alloc_passive(struct acpi_thermal *tz,
   323								     struct thermal_trip *trips,
   324								     int *num_trips)
   325	{
   326		acpi_status status;
   327		struct acpi_handle_list devices;
   328		struct thermal_trip trip = {
   329			.type = THERMAL_TRIP_PASSIVE
   330		};
   331		int ret;
   332	
   333		/*
   334		 * Module parameters disable all passive trip points
   335		 */
   336		if (psv < 0)
   337			goto out;
   338		
 > 339		ret = thermal_acpi_passive_trip_temp(tz->device->handle, &trip.temperature);
   340		if (ret)
   341			goto out;
   342		
   343		status = acpi_evaluate_reference(tz->device->handle, "_PSL", NULL, &devices);
   344		if (ACPI_FAILURE(status)) {
   345			acpi_handle_debug(tz->device->handle, "No passive device associated\n");
   346			goto out;
   347		}
   348	
   349		trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
   350		if (!trips)
   351			goto out;
   352	
   353		trips[*num_trips] = trip; /* structure copy */	
   354		
   355		(*num_trips)++;
   356	out:
   357		return trips;
   358	}
   359	
   360	static struct thermal_trip *acpi_thermal_trips_alloc_active(struct acpi_thermal *tz,
   361								    struct thermal_trip *trips,
   362								    int *num_trips)
   363	{
   364		acpi_status status;
   365		struct acpi_handle_list devices;
   366		int i, ret;
   367	
   368		/*
   369		 * Module parameters disable all active trip points
   370		 */
   371		if (act < 0)
   372			return trips;
   373	
   374		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
   375			struct thermal_trip trip = {
   376				.type = THERMAL_TRIP_ACTIVE,
   377			};
   378			char name[5];
   379	
 > 380			ret = thermal_acpi_active_trip_temp(tz->device->handle, i , &trip.temperature);
   381			if (ret)
   382				break;
   383	
   384			sprintf(name, "_AL%d", i);
   385	
   386			status = acpi_evaluate_reference(tz->device->handle, name, NULL, &devices);
   387			if (ACPI_FAILURE(status)) {
   388				acpi_handle_info(tz->device->handle, "No _AL%d defined for _AC%d\n", i, i);
   389				break;
   390			}
   391			
   392			trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
   393			if (!trips)
   394				break;
   395	
   396			trips[*num_trips] = trip; /* structure copy */	
   397	
   398			(*num_trips)++;
   399		}
   400	
   401		/*
   402		 * We found at least one trip point and we have an override option
   403		 */
   404		if (i && act) {
   405			/*
   406			 * Regarding the ACPI specification AC0 is the highest active
   407			 * temperature trip point. We will override this one.
   408			 */
   409			acpi_thermal_trips_override(&trips[*num_trips], act * MILLI);		
   410		}
   411	
   412		return trips;
   413	}
   414	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
