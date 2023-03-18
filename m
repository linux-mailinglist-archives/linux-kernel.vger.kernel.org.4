Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0336BF8EF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCRIVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCRIVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:21:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737784AFD4;
        Sat, 18 Mar 2023 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679127704; x=1710663704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E8B99Y3Mw49fVnz6FZh72xEoUG8Y58Gtj+qeak4kV4A=;
  b=lJANJHsvYDYq5IO6f33HNgmRXzxkiDpsf9UtfFtaS1gbJl5nP4U6azf6
   ywJ2UEUToz+xe2o6ojL6+Sy33mYJCWp3o5ZBpoXZXFUHLy13Mg+7RBuRy
   vX/Y60DWr9Gfw8LaYy5bfYusAVNsOW+z8cTZpxSx4i7c57yeGHr1KNhAy
   DUw/uC9/sGgk6gCMHuXMi+NyJ+X9lGo2isiZIRYF6pfBcubMw8bhmTatQ
   BhxRpEsWJvI8M0yZK7BGMUyaA85wEpQdUNUpiOhbYhuUaPrkAOpjAYpY4
   sJKhfXm6NuD35mi1/Ks0wGQBz923fF0B92kOeLKFxunj89BkvHpdkJuei
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="403288924"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="403288924"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 01:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="823912755"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="823912755"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2023 01:21:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdRoo-0009vO-07;
        Sat, 18 Mar 2023 08:21:38 +0000
Date:   Sat, 18 Mar 2023 16:21:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com
Cc:     oe-kbuild-all@lists.linux.dev, scclevenger@os.amperecomputing.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] coresight: etm4x: Drop pid argument from etm4_probe()
Message-ID: <202303181632.wBUDE5wa-lkp@intel.com>
References: <20230317030501.1811905-4-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317030501.1811905-4-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on soc/for-next rafael-pm/linux-next linus/master v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/coresight-etm4x-Allocate-and-device-assign-struct-etmv4_drvdata-earlier/20230317-110755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230317030501.1811905-4-anshuman.khandual%40arm.com
patch subject: [PATCH 3/7] coresight: etm4x: Drop pid argument from etm4_probe()
config: arm64-randconfig-r021-20230312 (https://download.01.org/0day-ci/archive/20230318/202303181632.wBUDE5wa-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/39e224e4248f0f7b2c59b97c12a12f8343ab900e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anshuman-Khandual/coresight-etm4x-Allocate-and-device-assign-struct-etmv4_drvdata-earlier/20230317-110755
        git checkout 39e224e4248f0f7b2c59b97c12a12f8343ab900e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hwtracing/coresight/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303181632.wBUDE5wa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwtracing/coresight/coresight-etm4x-core.c: In function 'etm4_init_arch_data':
>> drivers/hwtracing/coresight/coresight-etm4x-core.c:1169:43: warning: passing argument 2 of 'etm4_check_arch_features' makes integer from pointer without a cast [-Wint-conversion]
    1169 |         etm4_check_arch_features(drvdata, csa);
         |                                           ^~~
         |                                           |
         |                                           struct csdev_access *
   drivers/hwtracing/coresight/coresight-etm4x-core.c:389:51: note: expected 'unsigned int' but argument is of type 'struct csdev_access *'
     389 |                                      unsigned int id)
         |                                      ~~~~~~~~~~~~~^~


vim +/etm4_check_arch_features +1169 drivers/hwtracing/coresight/coresight-etm4x-core.c

  1138	
  1139	static void etm4_init_arch_data(void *info)
  1140	{
  1141		u32 etmidr0;
  1142		u32 etmidr2;
  1143		u32 etmidr3;
  1144		u32 etmidr4;
  1145		u32 etmidr5;
  1146		struct etm4_init_arg *init_arg = info;
  1147		struct etmv4_drvdata *drvdata;
  1148		struct csdev_access *csa;
  1149		int i;
  1150	
  1151		drvdata = dev_get_drvdata(init_arg->dev);
  1152		csa = init_arg->csa;
  1153	
  1154		/*
  1155		 * If we are unable to detect the access mechanism,
  1156		 * or unable to detect the trace unit type, fail
  1157		 * early.
  1158		 */
  1159		if (!etm4_init_csdev_access(drvdata, csa))
  1160			return;
  1161	
  1162		/* Detect the support for OS Lock before we actually use it */
  1163		etm_detect_os_lock(drvdata, csa);
  1164	
  1165		/* Make sure all registers are accessible */
  1166		etm4_os_unlock_csa(drvdata, csa);
  1167		etm4_cs_unlock(drvdata, csa);
  1168	
> 1169		etm4_check_arch_features(drvdata, csa);
  1170	
  1171		/* find all capabilities of the tracing unit */
  1172		etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
  1173	
  1174		/* INSTP0, bits[2:1] P0 tracing support field */
  1175		drvdata->instrp0 = !!(FIELD_GET(TRCIDR0_INSTP0_MASK, etmidr0) == 0b11);
  1176		/* TRCBB, bit[5] Branch broadcast tracing support bit */
  1177		drvdata->trcbb = !!(etmidr0 & TRCIDR0_TRCBB);
  1178		/* TRCCOND, bit[6] Conditional instruction tracing support bit */
  1179		drvdata->trccond = !!(etmidr0 & TRCIDR0_TRCCOND);
  1180		/* TRCCCI, bit[7] Cycle counting instruction bit */
  1181		drvdata->trccci = !!(etmidr0 & TRCIDR0_TRCCCI);
  1182		/* RETSTACK, bit[9] Return stack bit */
  1183		drvdata->retstack = !!(etmidr0 & TRCIDR0_RETSTACK);
  1184		/* NUMEVENT, bits[11:10] Number of events field */
  1185		drvdata->nr_event = FIELD_GET(TRCIDR0_NUMEVENT_MASK, etmidr0);
  1186		/* QSUPP, bits[16:15] Q element support field */
  1187		drvdata->q_support = FIELD_GET(TRCIDR0_QSUPP_MASK, etmidr0);
  1188		/* TSSIZE, bits[28:24] Global timestamp size field */
  1189		drvdata->ts_size = FIELD_GET(TRCIDR0_TSSIZE_MASK, etmidr0);
  1190	
  1191		/* maximum size of resources */
  1192		etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
  1193		/* CIDSIZE, bits[9:5] Indicates the Context ID size */
  1194		drvdata->ctxid_size = FIELD_GET(TRCIDR2_CIDSIZE_MASK, etmidr2);
  1195		/* VMIDSIZE, bits[14:10] Indicates the VMID size */
  1196		drvdata->vmid_size = FIELD_GET(TRCIDR2_VMIDSIZE_MASK, etmidr2);
  1197		/* CCSIZE, bits[28:25] size of the cycle counter in bits minus 12 */
  1198		drvdata->ccsize = FIELD_GET(TRCIDR2_CCSIZE_MASK, etmidr2);
  1199	
  1200		etmidr3 = etm4x_relaxed_read32(csa, TRCIDR3);
  1201		/* CCITMIN, bits[11:0] minimum threshold value that can be programmed */
  1202		drvdata->ccitmin = FIELD_GET(TRCIDR3_CCITMIN_MASK, etmidr3);
  1203		/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
  1204		drvdata->s_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_S_MASK, etmidr3);
  1205		drvdata->config.s_ex_level = drvdata->s_ex_level;
  1206		/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
  1207		drvdata->ns_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_NS_MASK, etmidr3);
  1208		/*
  1209		 * TRCERR, bit[24] whether a trace unit can trace a
  1210		 * system error exception.
  1211		 */
  1212		drvdata->trc_error = !!(etmidr3 & TRCIDR3_TRCERR);
  1213		/* SYNCPR, bit[25] implementation has a fixed synchronization period? */
  1214		drvdata->syncpr = !!(etmidr3 & TRCIDR3_SYNCPR);
  1215		/* STALLCTL, bit[26] is stall control implemented? */
  1216		drvdata->stallctl = !!(etmidr3 & TRCIDR3_STALLCTL);
  1217		/* SYSSTALL, bit[27] implementation can support stall control? */
  1218		drvdata->sysstall = !!(etmidr3 & TRCIDR3_SYSSTALL);
  1219		/*
  1220		 * NUMPROC - the number of PEs available for tracing, 5bits
  1221		 *         = TRCIDR3.bits[13:12]bits[30:28]
  1222		 *  bits[4:3] = TRCIDR3.bits[13:12] (since etm-v4.2, otherwise RES0)
  1223		 *  bits[3:0] = TRCIDR3.bits[30:28]
  1224		 */
  1225		drvdata->nr_pe =  (FIELD_GET(TRCIDR3_NUMPROC_HI_MASK, etmidr3) << 3) |
  1226				   FIELD_GET(TRCIDR3_NUMPROC_LO_MASK, etmidr3);
  1227		/* NOOVERFLOW, bit[31] is trace overflow prevention supported */
  1228		drvdata->nooverflow = !!(etmidr3 & TRCIDR3_NOOVERFLOW);
  1229	
  1230		/* number of resources trace unit supports */
  1231		etmidr4 = etm4x_relaxed_read32(csa, TRCIDR4);
  1232		/* NUMACPAIRS, bits[0:3] number of addr comparator pairs for tracing */
  1233		drvdata->nr_addr_cmp = FIELD_GET(TRCIDR4_NUMACPAIRS_MASK, etmidr4);
  1234		/* NUMPC, bits[15:12] number of PE comparator inputs for tracing */
  1235		drvdata->nr_pe_cmp = FIELD_GET(TRCIDR4_NUMPC_MASK, etmidr4);
  1236		/*
  1237		 * NUMRSPAIR, bits[19:16]
  1238		 * The number of resource pairs conveyed by the HW starts at 0, i.e a
  1239		 * value of 0x0 indicate 1 resource pair, 0x1 indicate two and so on.
  1240		 * As such add 1 to the value of NUMRSPAIR for a better representation.
  1241		 *
  1242		 * For ETM v4.3 and later, 0x0 means 0, and no pairs are available -
  1243		 * the default TRUE and FALSE resource selectors are omitted.
  1244		 * Otherwise for values 0x1 and above the number is N + 1 as per v4.2.
  1245		 */
  1246		drvdata->nr_resource = FIELD_GET(TRCIDR4_NUMRSPAIR_MASK, etmidr4);
  1247		if ((drvdata->arch < ETM_ARCH_V4_3) || (drvdata->nr_resource > 0))
  1248			drvdata->nr_resource += 1;
  1249		/*
  1250		 * NUMSSCC, bits[23:20] the number of single-shot
  1251		 * comparator control for tracing. Read any status regs as these
  1252		 * also contain RO capability data.
  1253		 */
  1254		drvdata->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
  1255		for (i = 0; i < drvdata->nr_ss_cmp; i++) {
  1256			drvdata->config.ss_status[i] =
  1257				etm4x_relaxed_read32(csa, TRCSSCSRn(i));
  1258		}
  1259		/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
  1260		drvdata->numcidc = FIELD_GET(TRCIDR4_NUMCIDC_MASK, etmidr4);
  1261		/* NUMVMIDC, bits[31:28] number of VMID comparators for tracing */
  1262		drvdata->numvmidc = FIELD_GET(TRCIDR4_NUMVMIDC_MASK, etmidr4);
  1263	
  1264		etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
  1265		/* NUMEXTIN, bits[8:0] number of external inputs implemented */
  1266		drvdata->nr_ext_inp = FIELD_GET(TRCIDR5_NUMEXTIN_MASK, etmidr5);
  1267		/* TRACEIDSIZE, bits[21:16] indicates the trace ID width */
  1268		drvdata->trcid_size = FIELD_GET(TRCIDR5_TRACEIDSIZE_MASK, etmidr5);
  1269		/* ATBTRIG, bit[22] implementation can support ATB triggers? */
  1270		drvdata->atbtrig = !!(etmidr5 & TRCIDR5_ATBTRIG);
  1271		/*
  1272		 * LPOVERRIDE, bit[23] implementation supports
  1273		 * low-power state override
  1274		 */
  1275		drvdata->lpoverride = (etmidr5 & TRCIDR5_LPOVERRIDE) && (!drvdata->skip_power_up);
  1276		/* NUMSEQSTATE, bits[27:25] number of sequencer states implemented */
  1277		drvdata->nrseqstate = FIELD_GET(TRCIDR5_NUMSEQSTATE_MASK, etmidr5);
  1278		/* NUMCNTR, bits[30:28] number of counters available for tracing */
  1279		drvdata->nr_cntr = FIELD_GET(TRCIDR5_NUMCNTR_MASK, etmidr5);
  1280		etm4_cs_lock(drvdata, csa);
  1281		cpu_detect_trace_filtering(drvdata);
  1282	}
  1283	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
