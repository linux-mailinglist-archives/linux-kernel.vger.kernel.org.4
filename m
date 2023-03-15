Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49DC6BB3B3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjCOMyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjCOMyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:54:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7407199D55;
        Wed, 15 Mar 2023 05:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678884889; x=1710420889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PmN515W/2mq3hBjB/cyy5WpgL1t4bB08Urxg0WllqhU=;
  b=YqE6FwL8sSMLAP+OZlMSD+QFduC/M+wCUW0iodnT9Sd5ZVGJk7C4vgvh
   4Dn5mOUYJSOVp1eRhBY5GWhtmy8ylyoXNlLxa8hrk8YtrGLEPbAlUEg4d
   rcA0cS2I47E9SFXQEYVXcb7kT3MPw0xewU7kShIVPnYVuOiDcOUfn8ENc
   xYgnYLVY2M8gT01HNgR7YXYx1uKPjmJsby9SI1qceva2S4I8znoIpT/X5
   GdfzKTX/4ygq+MqE287F/JhH5AK0+/sjV6MrcctLbiaCimclzBszYOD/u
   dWE7MHzZRG2titoO2Dx5DEQgdk8tOi44UQKkHvR5R9VJ35nmH99hWtd9Q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="335179434"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="335179434"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 05:54:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="629447017"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="629447017"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2023 05:54:46 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcQeT-0007g8-2Z;
        Wed, 15 Mar 2023 12:54:45 +0000
Date:   Wed, 15 Mar 2023 20:54:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        rui.zhang@intel.com, amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/11] thermal/core: Alloc-copy-free the thermal zone
 parameters structure
Message-ID: <202303152025.rVv9btko-lkp@intel.com>
References: <20230307133735.90772-11-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307133735.90772-11-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.3-rc2 next-20230315]
[cannot apply to rafael-pm/thermal]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-drivers-intel_pch_thermal-Use-thermal-driver-device-to-write-a-trace/20230307-223759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230307133735.90772-11-daniel.lezcano%40linaro.org
patch subject: [PATCH v1 10/11] thermal/core: Alloc-copy-free the thermal zone parameters structure
config: i386-randconfig-a011-20230313 (https://download.01.org/0day-ci/archive/20230315/202303152025.rVv9btko-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a9813bacf3531491cb02c13aafe358e6b5423aa0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/thermal-drivers-intel_pch_thermal-Use-thermal-driver-device-to-write-a-trace/20230307-223759
        git checkout a9813bacf3531491cb02c13aafe358e6b5423aa0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/thermal/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303152025.rVv9btko-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_core.c:1267:7: warning: variable 'result' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (!tz->tzp)
                       ^~~~~~~~
   drivers/thermal/thermal_core.c:1388:17: note: uninitialized use occurs here
           return ERR_PTR(result);
                          ^~~~~~
   drivers/thermal/thermal_core.c:1267:3: note: remove the 'if' if its condition is always false
                   if (!tz->tzp)
                   ^~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1217:12: note: initialize the variable 'result' to silence this warning
           int result;
                     ^
                      = 0
   1 warning generated.


vim +1267 drivers/thermal/thermal_core.c

  1183	
  1184	/**
  1185	 * thermal_zone_device_register_with_trips() - register a new thermal zone device
  1186	 * @type:	the thermal zone device type
  1187	 * @trips:	a pointer to an array of thermal trips
  1188	 * @num_trips:	the number of trip points the thermal zone support
  1189	 * @mask:	a bit string indicating the writeablility of trip points
  1190	 * @devdata:	private device data
  1191	 * @ops:	standard thermal zone device callbacks
  1192	 * @tzp:	thermal zone platform parameters
  1193	 * @passive_delay: number of milliseconds to wait between polls when
  1194	 *		   performing passive cooling
  1195	 * @polling_delay: number of milliseconds to wait between polls when checking
  1196	 *		   whether trip points have been crossed (0 for interrupt
  1197	 *		   driven systems)
  1198	 *
  1199	 * This interface function adds a new thermal zone device (sensor) to
  1200	 * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
  1201	 * thermal cooling devices registered at the same time.
  1202	 * thermal_zone_device_unregister() must be called when the device is no
  1203	 * longer needed. The passive cooling depends on the .get_trend() return value.
  1204	 *
  1205	 * Return: a pointer to the created struct thermal_zone_device or an
  1206	 * in case of error, an ERR_PTR. Caller must check return value with
  1207	 * IS_ERR*() helpers.
  1208	 */
  1209	struct thermal_zone_device *
  1210	thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
  1211						void *devdata, struct thermal_zone_device_ops *ops,
  1212						struct thermal_zone_params *tzp, int passive_delay,
  1213						int polling_delay)
  1214	{
  1215		struct thermal_zone_device *tz;
  1216		int id;
  1217		int result;
  1218		int count;
  1219		struct thermal_governor *governor;
  1220	
  1221		if (!type || strlen(type) == 0) {
  1222			pr_err("No thermal zone type defined\n");
  1223			return ERR_PTR(-EINVAL);
  1224		}
  1225	
  1226		if (strlen(type) >= THERMAL_NAME_LENGTH) {
  1227			pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
  1228			       type, THERMAL_NAME_LENGTH);
  1229			return ERR_PTR(-EINVAL);
  1230		}
  1231	
  1232		/*
  1233		 * Max trip count can't exceed 31 as the "mask >> num_trips" condition.
  1234		 * For example, shifting by 32 will result in compiler warning:
  1235		 * warning: right shift count >= width of type [-Wshift-count- overflow]
  1236		 *
  1237		 * Also "mask >> num_trips" will always be true with 32 bit shift.
  1238		 * E.g. mask = 0x80000000 for trip id 31 to be RW. Then
  1239		 * mask >> 32 = 0x80000000
  1240		 * This will result in failure for the below condition.
  1241		 *
  1242		 * Check will be true when the bit 31 of the mask is set.
  1243		 * 32 bit shift will cause overflow of 4 byte integer.
  1244		 */
  1245		if (num_trips > (BITS_PER_TYPE(int) - 1) || num_trips < 0 || mask >> num_trips) {
  1246			pr_err("Incorrect number of thermal trips\n");
  1247			return ERR_PTR(-EINVAL);
  1248		}
  1249	
  1250		if (!ops) {
  1251			pr_err("Thermal zone device ops not defined\n");
  1252			return ERR_PTR(-EINVAL);
  1253		}
  1254	
  1255		if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
  1256			return ERR_PTR(-EINVAL);
  1257	
  1258		if (!thermal_class)
  1259			return ERR_PTR(-ENODEV);
  1260	
  1261		tz = kzalloc(sizeof(*tz), GFP_KERNEL);
  1262		if (!tz)
  1263			return ERR_PTR(-ENOMEM);
  1264	
  1265		if (tzp) {
  1266			tz->tzp = kmemdup(tzp, sizeof(*tzp), GFP_KERNEL);
> 1267			if (!tz->tzp)
  1268				goto free_tz;
  1269		}
  1270		
  1271		INIT_LIST_HEAD(&tz->thermal_instances);
  1272		ida_init(&tz->ida);
  1273		mutex_init(&tz->lock);
  1274		id = ida_alloc(&thermal_tz_ida, GFP_KERNEL);
  1275		if (id < 0) {
  1276			result = id;
  1277			goto free_tzp;
  1278		}
  1279	
  1280		tz->id = id;
  1281		strscpy(tz->type, type, sizeof(tz->type));
  1282	
  1283		if (!ops->critical)
  1284			ops->critical = thermal_zone_device_critical;
  1285	
  1286		tz->ops = ops;
  1287		tz->device.class = thermal_class;
  1288		tz->devdata = devdata;
  1289		tz->trips = trips;
  1290		tz->num_trips = num_trips;
  1291	
  1292		thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
  1293		thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
  1294	
  1295		/* sys I/F */
  1296		/* Add nodes that are always present via .groups */
  1297		result = thermal_zone_create_device_groups(tz, mask);
  1298		if (result)
  1299			goto remove_id;
  1300	
  1301		/* A new thermal zone needs to be updated anyway. */
  1302		atomic_set(&tz->need_update, 1);
  1303	
  1304		result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
  1305		if (result) {
  1306			thermal_zone_destroy_device_groups(tz);
  1307			goto remove_id;
  1308		}
  1309		result = device_register(&tz->device);
  1310		if (result)
  1311			goto release_device;
  1312	
  1313		for (count = 0; count < num_trips; count++) {
  1314			struct thermal_trip trip;
  1315	
  1316			result = thermal_zone_get_trip(tz, count, &trip);
  1317			if (result)
  1318				set_bit(count, &tz->trips_disabled);
  1319		}
  1320	
  1321		/* Update 'this' zone's governor information */
  1322		mutex_lock(&thermal_governor_lock);
  1323	
  1324		if (tz->tzp)
  1325			governor = __find_governor(tz->tzp->governor_name);
  1326		else
  1327			governor = def_governor;
  1328	
  1329		result = thermal_set_governor(tz, governor);
  1330		if (result) {
  1331			mutex_unlock(&thermal_governor_lock);
  1332			goto unregister;
  1333		}
  1334	
  1335		mutex_unlock(&thermal_governor_lock);
  1336	
  1337		if (!tz->tzp || !tz->tzp->no_hwmon) {
  1338			result = thermal_add_hwmon_sysfs(tz);
  1339			if (result)
  1340				goto unregister;
  1341		}
  1342	
  1343		mutex_lock(&thermal_list_lock);
  1344		list_add_tail(&tz->node, &thermal_tz_list);
  1345		mutex_unlock(&thermal_list_lock);
  1346	
  1347		if (tzp && tzp->linked_dev) {
  1348			result = sysfs_create_link(&tzp->linked_dev->kobj,
  1349						   &tz->device.kobj, "thermal_zone");
  1350			if (result)
  1351				goto out_list_del;
  1352	
  1353			result = sysfs_create_link(&tz->device.kobj,
  1354						   &tzp->linked_dev->kobj, "device");
  1355			if (result)
  1356				goto out_del_link;
  1357		}
  1358	
  1359		/* Bind cooling devices for this zone */
  1360		bind_tz(tz);
  1361	
  1362		INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
  1363	
  1364		thermal_zone_device_init(tz);
  1365		/* Update the new thermal zone and mark it as already updated. */
  1366		if (atomic_cmpxchg(&tz->need_update, 1, 0))
  1367			thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
  1368	
  1369		thermal_notify_tz_create(tz->id, tz->type);
  1370	
  1371		return tz;
  1372	
  1373	out_del_link:
  1374		sysfs_remove_link(&tz->device.kobj, "thermal_zone");
  1375	out_list_del:
  1376		list_del(&tz->node);
  1377	unregister:
  1378		device_del(&tz->device);
  1379	release_device:
  1380		put_device(&tz->device);
  1381		tz = NULL;
  1382	remove_id:
  1383		ida_free(&thermal_tz_ida, id);
  1384	free_tzp:
  1385		kfree(tz->tzp);
  1386	free_tz:
  1387		kfree(tz);
  1388		return ERR_PTR(result);
  1389	}
  1390	EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
  1391	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
