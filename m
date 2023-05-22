Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A06270B5F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjEVHKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjEVHJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:09:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426C1139;
        Mon, 22 May 2023 00:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684739304; x=1716275304;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=oOd5rsKrPJKfeC3WvY5AJvq4TBzMN07anaIdGsxOMLY=;
  b=c0c4d+T/JsrNnBE8FO/+qsI/RmdKvfPqYIlKW7agitfcIN2Ex/8kVqy7
   1EQN0gGIqfFy5z/JX3KkxCCWwS1zr0uZ2WKQsK/M2CzyfjqRTo4zhRbX6
   IPpke42Hu8MTQd8+C197fIhbTi6+9xtHHl9ZgR4Fyc08TUSGONOIhFPUA
   2etKycpNBDonpDsntkpA9Untd6pUEVI++RCgDU71ftbF34sddowANtiF/
   ckRl+P9Le48+PxK4tgBe2tqQvA4NGrsF0rjDZe5rhVHnnJb1lYzWTjMJF
   f1VOyZ5G/znGkQOg2przp7mZnykmmAff0wvvYuGszZv6Woa/VLWm2VTZH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="337436779"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="337436779"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="768405265"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="768405265"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2023 00:08:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 00:08:13 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 00:08:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 00:08:12 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 00:08:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+YLc0HudeHSr7GihyZ22F1if7kM+/KrAQ+NfIJcd2eGT3DtvYECQzyDoIDPA72YVkxoTE9zuF2fnoV+2pv4TiqahdQz8kPPtvildvnlVy0YCZNTz442ij2LmhKeieZ4Tr+WXl4ivP7NxqDCoFjbadw2XBZxOFGe6HrxD2s3IgDm/GdWlurp3522gzLTBzm0hNk7KfHwqNX3l3HtrcMVctghRPl0+4B0yegZDFl/3vcdbcpBlI6D7gCtt9cwIu8L91mATIIA5rhBVpUeI0iLSUghaA3P7/pv8LMtceTxxT4lVzEGx8qmkCt/Bv4g+Qh1VLtpy6Pvxl2JrjRn3UQNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUOEHgKV+QCcN2BCZZtRx6IXObhTpdMpQfGPxEIJJCE=;
 b=Bhsj8SlHUpkS2R86OK5meERMuxD5ov997A7lnBH0MIgK0ozy485HWgdxBlM8uHVQzPrOoVAQHRBMA6X7vaF7YOBezeoAu4ADKMc8hoVGu7kWeDN/8YEioTJ5k3645dEHdd5eOKGETERLNF2grTQF+UOBGf7EBwzHadjLm1adceLj+vBEGxiWxB5r7oE0eJF1dBwJcURUFJod+mFMqwKmUF3rs9qup3AQR56tDTteaSjMC6WScw34LQ0Esta9saUDpLQmQvNzlJmvh0pSc+qmJUtzm7Al3gZNWZOUNmIhoPXr8POgZsJUVN5jjrHileOHmbFk4WFln7Gbv9No+T73GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW3PR11MB4636.namprd11.prod.outlook.com (2603:10b6:303:5a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 07:08:08 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 07:08:08 +0000
Date:   Mon, 22 May 2023 15:04:48 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Yajun Deng <yajun.deng@linux.dev>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-doc@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <mchehab@kernel.org>, <rric@kernel.org>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH] EDAC: Expose node link in sysfs if CONFIG_NUMA
Message-ID: <202305221451.b48d9b55-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="PS62Nk+e0TdyhMdz"
Content-Disposition: inline
In-Reply-To: <20230516080748.3155788-1-yajun.deng@linux.dev>
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW3PR11MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: a7890f89-3ad4-4954-d8d7-08db5a934b2a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wBqpaur8GHQBJF40oHAknBV1zd+DHmg3u9/Hh9sI+n7U/l0chqZUQTjfAWayDfhQ76tfwqyld+vDHpG2nI4kf3tmhA1wCxDfS/3LymBkBz1Tk8GygQG3LcQbMVPlYn9/BTCuIYC8TVOkaTmwK8ddScZXzELZQpz3zfDm66tmYwY01xKH7rXU9UKbPSTCimHyjdW/xU6jAcHAOvQtZvAbeMYyoa1PPS/7q1vCGXUfBo81IA6P2xtycFw1wn0AjxR+6c5hhU6EbU0wJJoQF1QMcrKyT3XnwiH7bAsSuHKzmupH+OQMlhh+rmDJ62li0yfQD9jSkBiUak5GnKqfJuW8VRP0J1du+Fa9dEaTbgVrcJeosn1BYegqQA9LS94sZ+d7yksvbRcXX4QDk5xXfgwJIJ7cknISXb4kdDrzxzAnlXXf5a9gWdTJrFbDI5hFu6gZ51+2ac1/prIpYXr37PNx87a5trOblIEuy/mn5ThRRzxghy9h/5IWWK4wlgc2swEEDdO7XlxaucouNvA2baYU19qeWjn+y5HG83/95Rxi1UJTayckyWPC/B4labWh6WiFojUQCvAOEajFBafeUVWZWeu8s2saMrNqx/FNqBpvP07nRmtAC8pnnCSy6d5b8YOv+BK1tG2UM4XIClr1f0KGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(8676002)(8936002)(5660300002)(235185007)(7416002)(186003)(26005)(1076003)(6512007)(6506007)(83380400001)(21490400003)(86362001)(2616005)(38100700002)(82960400001)(41300700001)(6666004)(6486002)(44144004)(966005)(66476007)(66556008)(66946007)(316002)(6916009)(36756003)(4326008)(478600001)(2906002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZVIcvp5gJAy/USWLinrKBgb/KO/ICDi2vqJjY+yQlLKdqy6DI9jO+J1OTQMD?=
 =?us-ascii?Q?Gw4RqWPKy1PY9tdzVWDjwnD9STlLX7RL4R1CMQe6oXyRroYWmffDTex5562X?=
 =?us-ascii?Q?5TUa22UdhBbPm/uukruNbX/GQU4Ug+nr+sZ0/WhGwunL+O7U7YC/srvvZo1s?=
 =?us-ascii?Q?EU2kDcmrFMTIt+1Oa7+Uk0QdI4UDVlrcauu+ldyIjJaokWE7TjG+pFMnpAqa?=
 =?us-ascii?Q?5L3al+AvOgvQA8K0vu3PT2BDNUa/KPqfY/UDWxjjLZclL5PxGROxbvAp01Zc?=
 =?us-ascii?Q?jx7Hk4aDn/rd3Oj95zauH+jW+D7Xvqz2iEno+XEoZMZUtOvEwZ45QUIKNmV6?=
 =?us-ascii?Q?rlsZFNnQxSsmWL7jMttICyJ0pUaSpJdmkEtMUAvKabWhRCkOk9FctCEpJK89?=
 =?us-ascii?Q?7MDzRFklOK4ifobebFDZUdRp+C41Kd8rN4O8prPKJMfdGXYuUn2rtuehWqsw?=
 =?us-ascii?Q?0KreSBjxtksKFvvJVwO8s27GQ50LJTiQpnkJrD3LIdfe5iTMIgZIIhCJumy2?=
 =?us-ascii?Q?88zCGI21pAIuXgvEhdOv7fCd6/IhjmndYBoZPSMkV8FDkvsPI7+YWKB7oskR?=
 =?us-ascii?Q?cHu76o7E+a4IsD3sAHlcge3Yv416SwWYwdxwVuhbSEF6f+1hYVoKnfsasK7W?=
 =?us-ascii?Q?DzO/aT1IN+VSjh4Y2+qx2JEpo9/8YvdwmQcYeknL42vxNubq29uL2aEBHbsp?=
 =?us-ascii?Q?CAppnOT2NTW8EBsyudcWyuz4pTJfLZWGupkz2vbAPJryUrknDHc/bwMSdj08?=
 =?us-ascii?Q?FONarUP72hdwAKqKCtHl/O87ZOR9TrMnjJCpXeHbKY1FqwE6WpisNXD1Zlqy?=
 =?us-ascii?Q?iSSwy8Bb4b91qMtd/oJfl1n5DrHojjY/yhtS9qXG3g80FxwKl3wjBuay501z?=
 =?us-ascii?Q?ZOOhoFYZykIqyInN14rLEjjHOVpziiVNjFHTFZuRL+6eXIHu/l8XCo+rlcGW?=
 =?us-ascii?Q?/5ygz4h5eDk1zV0UVXCZS1TgrtI2GO7mGVa0unNnvDLuliV47ee+lGiZBlOP?=
 =?us-ascii?Q?xqp6WOk7o/qOuZSfG+pCLg7L96FRB+PS0gLm6xhL4NKjISQKfXnPqxubVOpz?=
 =?us-ascii?Q?FcvzhqGEDPTiG3YoIhOXP4iSRFxBgXvCjP85EBuWiwyhCRDuRpzf/tcTt2m5?=
 =?us-ascii?Q?hGQrPhPG+uoDmeDP2QoZLiZw9c3eXtV1D/j633m+Vr61mQhs6C1vSpulnhpV?=
 =?us-ascii?Q?mnZwBGKVvd622j2yPYRjqLf/y0m5qQ9BaQtvKj/+B3ajlqxxZH1TipDVl84J?=
 =?us-ascii?Q?fY7YWKi53J7lpPUceoQqybB6ZcykuZNk/+t03p5zp13BVUK5B1YAu6hYdUdJ?=
 =?us-ascii?Q?is4VlqLqQHk4SfL/1FSR28v7zcoAGIdCj2UIjx/rALpYEdEL+TboFgA8MJl6?=
 =?us-ascii?Q?Ng7Zk6itQOFcieVeGZrO6IHB1vQX9UG2UzDJqxS7iroRCCyiemij2O2F9jZK?=
 =?us-ascii?Q?icb2CNDMJf+MaUk2P3FkrMjyL9JfDNN8VdLaLVU0k1SdiCTS/zByo5W1j5Qv?=
 =?us-ascii?Q?Ga2zmE/wnEBC+bCITZpKlcwWCpvEx00+uxoPSvHqZquAb8pV8s1lCK9rvX+U?=
 =?us-ascii?Q?kzXB8Ac/cAfIgZ1thnI/GEtTVVZR2Ts0n+v5hsl/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7890f89-3ad4-4954-d8d7-08db5a934b2a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 07:08:07.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4wWqKqkNxs/tWSHaAxAaFsHOJMh/AmUaRAY4CjUe4dEd0Q96aKz4Mv8YwwCU1hq4B3ItpXxfIpkI8ZjJomOqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4636
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--PS62Nk+e0TdyhMdz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hello,

kernel test robot noticed "BUG:KASAN:wild-memory-access_in_edac_create_sysfs_mci_device" on:

commit: 725ca92fab0b553466d32b1fecd4e8b4adb4ed03 ("[PATCH] EDAC: Expose node link in sysfs if CONFIG_NUMA")
url: https://github.com/intel-lab-lkp/linux/commits/Yajun-Deng/EDAC-Expose-node-link-in-sysfs-if-CONFIG_NUMA/20230516-160858
base: https://git.kernel.org/cgit/linux/kernel/git/ras/ras.git edac-for-next
patch subject: [PATCH] EDAC: Expose node link in sysfs if CONFIG_NUMA
patch link: https://lore.kernel.org/all/20230516080748.3155788-1-yajun.deng@linux.dev/

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: sgx

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt

compiler: gcc-11
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202305221451.b48d9b55-yujie.liu@intel.com


[ 61.987277][ T311] BUG: KASAN: wild-memory-access in edac_create_sysfs_mci_device (arch/x86/include/asm/bitops.h:228 arch/x86/include/asm/bitops.h:240 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/nodemask.h:423 drivers/edac/edac_mc_sysfs.c:934 drivers/edac/edac_mc_sysfs.c:1019) 
[   61.987284][  T311] Read of size 8 at addr 1fffffff854eddd8 by task systemd-udevd/311
0m] Reached targ[   61.987289][  T311] CPU: 9 PID: 311 Comm: systemd-udevd Not tainted 6.4.0-rc1-00003-g725ca92fab0b #1
[   61.987295][  T311] Call Trace:
[   61.987297][  T311]  <TASK>
[ 61.987299][ T311] dump_stack_lvl (lib/dump_stack.c:108) 
[ 61.987305][ T311] kasan_report (mm/kasan/report.c:574) 
[ 61.987311][ T311] ? edac_create_sysfs_mci_device (arch/x86/include/asm/bitops.h:228 arch/x86/include/asm/bitops.h:240 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/nodemask.h:423 drivers/edac/edac_mc_sysfs.c:934 drivers/edac/edac_mc_sysfs.c:1019) 
[ 61.987317][ T311] kasan_check_range (mm/kasan/generic.c:188) 
[ 61.987320][ T311] edac_create_sysfs_mci_device (arch/x86/include/asm/bitops.h:228 arch/x86/include/asm/bitops.h:240 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/nodemask.h:423 drivers/edac/edac_mc_sysfs.c:934 drivers/edac/edac_mc_sysfs.c:1019) 
[ 62.067405][ T311] edac_mc_add_mc_with_groups (drivers/edac/edac_mc.c:648) 
[ 62.073291][ T311] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 62.079279][ T311] ie31200_probe1 (drivers/edac/ie31200_edac.c:528) ie31200_edac
1;39mRegular bac[ 62.093328][ T311] ? ie31200_check (drivers/edac/ie31200_edac.c:405) ie31200_edac
kground program [ 62.100696][ T311] ? do_pci_enable_device (drivers/pci/pci.c:1931 drivers/pci/pci.c:1907) 
processing daemo[ 62.107379][ T311] ? rpm_callback (drivers/base/power/runtime.c:763) 
[ 62.113329][ T311] ? spin_bug (kernel/locking/spinlock_debug.c:113) 
[ 62.118112][ T311] ? pci_enable_device_flags (drivers/pci/pci.c:2007) 
[ 62.123916][ T311] ? ie31200_probe1 (drivers/edac/ie31200_edac.c:549) ie31200_edac
[ 62.126911][ T321] calling mei_init+0x0/0xc0 [mei] @ 321 
[ 62.130145][ T311] ie31200_init_one (drivers/edac/ie31200_edac.c:555) ie31200_edac
[ 62.130151][ T311] ? ie31200_probe1 (drivers/edac/ie31200_edac.c:549) ie31200_edac
[ 62.137671][ T321] initcall mei_init+0x0/0xc0 [mei] returned 0 after 2001 usecs 
[ 62.141510][ T311] local_pci_probe (drivers/pci/pci-driver.c:324) 
[ 62.141518][ T311] pci_call_probe (drivers/pci/pci-driver.c:392) 
[ 62.166212][ T311] ? spin_bug (kernel/locking/spinlock_debug.c:113) 
[ 62.166220][ T311] ? pci_pm_suspend_late (drivers/pci/pci-driver.c:352) 
Startin[ 62.166225][ T311] ? pci_match_device (drivers/pci/pci-driver.c:159) 
System Message [ 62.188729][ T311] ? kernfs_put (arch/x86/include/asm/atomic.h:123 (discriminator 1) include/linux/atomic/atomic-instrumented.h:576 (discriminator 1) fs/kernfs/dir.c:539 (discriminator 1)) 
[ 62.194359][ T311] pci_device_probe (drivers/pci/pci-driver.c:461) 
[ 62.199890][ T311] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658) 
[ 62.204551][ T311] ? ktime_get (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 include/linux/seqlock.h:104 kernel/time/timekeeping.c:846) 
[ 62.209137][ T311] __driver_probe_device (drivers/base/dd.c:736 drivers/base/dd.c:798) 
[ 62.214589][ T311] driver_probe_device (drivers/base/dd.c:830) 
[ 62.219781][ T311] __driver_attach (drivers/base/dd.c:1217) 
[ 62.224707][ T311] ? __device_attach_driver (drivers/base/dd.c:1157) 
[ 62.230405][ T311] bus_for_each_dev (drivers/base/bus.c:367) 
[ 62.235339][ T311] ? lockdep_init_map_type (kernel/locking/lockdep.c:4856) 
[ 62.235346][ T311] ? bus_remove_file (drivers/base/bus.c:356) 
[ 62.235351][ T311] ? bus_add_driver (drivers/base/bus.c:672) 
Startin[ 62.235357][ T311] bus_add_driver (drivers/base/bus.c:674) 
4 Metadata Check[ 62.235368][ T311] ie31200_init (drivers/edac/ie31200_edac.c:574) ie31200_edac
.
[   62.235378][  T311]  ? 0xffffffffa0538000
[ 62.235381][ T311] do_one_initcall (init/main.c:1246) 
[ 62.235385][ T311] ? trace_event_raw_event_initcall_level (init/main.c:1237) 
[ 62.235390][ T311] ? __kmem_cache_alloc_node (mm/slub.c:3453 mm/slub.c:3490) 
[ 62.235394][ T311] ? do_init_module (include/linux/slab.h:559 kernel/module/main.c:2517) 
[ 62.235398][ T311] ? kasan_unpoison (mm/kasan/shadow.c:160 mm/kasan/shadow.c:194) 
[ 62.235402][ T311] do_init_module (kernel/module/main.c:2529) 
[ 62.235406][ T311] load_module (kernel/module/main.c:2980) 
[ 62.235409][ T311] ? ima_read_file (security/integrity/ima/ima_main.c:788) 
[ 62.235415][ T311] ? post_relocation (kernel/module/main.c:2829) 
[ 62.235419][ T311] ? __x64_sys_fspick (fs/kernel_read_file.c:38) 
[ 62.235424][ T311] ? __do_sys_finit_module (kernel/module/main.c:3099) 
[ 62.235427][ T311] __do_sys_finit_module (kernel/module/main.c:3099) 
[ 62.235430][ T311] ? __ia32_sys_init_module (kernel/module/main.c:3061) 
[ 62.235433][ T311] ? seccomp_notify_ioctl (kernel/seccomp.c:1193) 
[ 62.235440][ T311] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 62.235445][ T311] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   62.235448][  T311] RIP: 0033:0x7f92a8c3f5a9
[ 62.235451][ T311] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 08 0d 00 f7 d8 64 89 01 48
All code
========
   0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
   6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   d:	00 00 00 
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 27 08 0d 00 	mov    0xd0827(%rip),%rcx        # 0xd0861
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 27 08 0d 00 	mov    0xd0827(%rip),%rcx        # 0xd0837
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[   62.235453][  T311] RSP: 002b:00007fff2a61dc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   62.235456][  T311] RAX: ffffffffffffffda RBX: 000055a843568f40 RCX: 00007f92a8c3f5a9
[   62.235458][  T311] RDX: 0000000000000000 RSI: 00007f92a8dd2efd RDI: 0000000000000006
[   62.235459][  T311] RBP: 00007f92a8dd2efd R08: 0000000000000000 R09: 000055a84353a4c0
[   62.235461][  T311] R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
[   62.235462][  T311] R13: 0000000000000000 R14: 000055a84357c480 R15: 000055a8417d0e50
[   62.235466][  T311]  </TASK>


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--PS62Nk+e0TdyhMdz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc1-00003-g725ca92fab0b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.4.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-12) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
# CONFIG_ADDRESS_MASKING is not set
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_X86_SGX_KVM is not set
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_IMA_KEXEC=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
CONFIG_ANON_VMA_NAME=y
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
CONFIG_DAMON_DBGFS=y
# CONFIG_DAMON_RECLAIM is not set
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_BPF_LINK=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
# CONFIG_NF_FLOW_TABLE_PROCFS is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_MQPRIO_LIB=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_FQ_PIE is not set
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
CONFIG_NET_ACT_GATE=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_DEBUG=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_ZRAM_MULTI_COMP is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
# CONFIG_GENEVE is not set
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_AMT=m
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_T1S_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_CBTX_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_CAN_DEV is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_FXL6408 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ELKHARTLAKE is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2606MVV is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
# CONFIG_EFI_SECRET is not set
CONFIG_TDX_GUEST_DRIVER=m
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_TASK=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
# CONFIG_HYPERV_VTL_MODE is not set
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_LENOVO_YMC is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
CONFIG_IOMMUFD=m
CONFIG_IOMMUFD_TEST=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
# CONFIG_IMA_KEXEC is not set
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
# CONFIG_IMA_DISABLE_HTABLE is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
# CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE is not set
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
# CONFIG_STACKLEAK_METRICS is not set
# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_INTERVAL_TREE_SPAN_ITER=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_DEBUG_ON=y
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
# CONFIG_PER_VMA_LOCK_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FPROBE=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
# CONFIG_SAMPLE_FTRACE_OPS is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_FPROBE is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
# CONFIG_SAMPLE_KMEMLEAK is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
# CONFIG_FAULT_INJECTION_CONFIGFS is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
CONFIG_LKDTM=y
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_DYNAMIC_DEBUG is not set
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--PS62Nk+e0TdyhMdz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export need_memory='3G'
	export job_origin='kernel-selftests-sgx.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='lkp-cfl-e1'
	export tbox_group='lkp-cfl-e1'
	export submit_id='6465a506dcf16b428c052667'
	export job_file='/lkp/jobs/scheduled/lkp-cfl-e1/kernel-selftests-sgx-debian-12-x86_64-20220629.cgz-725ca92fab0b553466d32b1fecd4e8b4adb4ed03-20230518-82572-nci7bd-0.yaml'
	export id='ed72909a230e54127373b9f4117297ad91286948'
	export queuer_version='/zday/lkp'
	export model='Coffee Lake'
	export nr_node=1
	export nr_cpu=16
	export memory='32G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part2'
	export swap_partitions='LABEL=SWAP'
	export rootfs_partition='/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part1'
	export brand='Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz'
	export commit='725ca92fab0b553466d32b1fecd4e8b4adb4ed03'
	export ucode='0xf4'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"IGB"=>"y"}
SATA_AHCI'
	export need_kernel_version=
	export need_kconfig='{"BLOCK"=>"y"}
{"BTRFS_FS"=>"m"}
{"EFI"=>"y"}
EFIVAR_FS
{"FTRACE"=>"y"}
{"IP_ADVANCED_ROUTER"=>"y"}
{"IP_MULTIPLE_TABLES"=>"y"}
RC_CORE
{"RC_DECODERS"=>"y"}
{"RC_DEVICES"=>"y"}
{"RC_LOOPBACK"=>"m"}
{"RUNTIME_TESTING_MENU"=>"y"}
{"STAGING"=>"y"}
{"SYNC_FILE"=>"y"}
TEST_FIRMWARE
{"TEST_KMOD"=>"m"}
{"TEST_LKM"=>"m"}
TEST_USER_COPY
{"TUN"=>"m"}
{"XFS_FS"=>"m"}
{"GPIO_CDEV"=>"y"}
OVERLAY_FS
{"PERF_EVENTS"=>"y"}
{"SCHED_DEBUG"=>"y"}
{"SHMEM"=>"y"}
{"TMPFS_XATTR"=>"y"}
{"TMPFS"=>"y"}'
	export rootfs='debian-12-x86_64-20220629.cgz'
	export initrds='linux_headers
linux_selftests'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export enqueue_time='2023-05-18 12:09:42 +0800'
	export _id='6465a506dcf16b428c052667'
	export _rt='/result/kernel-selftests/sgx/lkp-cfl-e1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='6d50a24ff3577f57fe5a0643eed35a546c1ae0ee'
	export base_commit='f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6'
	export branch='linux-devel/devel-hourly-20230517-020720'
	export result_root='/result/kernel-selftests/sgx/lkp-cfl-e1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/0'
	export scheduler_version='/lkp/lkp/.src-20230517-200353'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-12-x86_64-20220629.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/sgx/lkp-cfl-e1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/0
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/vmlinuz-6.4.0-rc1-00003-g725ca92fab0b
branch=linux-devel/devel-hourly-20230517-020720
job=/lkp/jobs/scheduled/lkp-cfl-e1/kernel-selftests-sgx-debian-12-x86_64-20220629.cgz-725ca92fab0b553466d32b1fecd4e8b4adb4ed03-20230518-82572-nci7bd-0.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=725ca92fab0b553466d32b1fecd4e8b4adb4ed03
initcall_debug
nmi_watchdog=0
max_uptime=1200
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230329.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-60acb023-1_20230329.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20230326.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.4.0-rc2'
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/vmlinuz-6.4.0-rc1-00003-g725ca92fab0b'
	export dequeue_time='2023-05-18 12:35:08 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-cfl-e1/kernel-selftests-sgx-debian-12-x86_64-20220629.cgz-725ca92fab0b553466d32b1fecd4e8b4adb4ed03-20230518-82572-nci7bd-0.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper kmemleak
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='sgx' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='sgx' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper kmemleak

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--PS62Nk+e0TdyhMdz
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
t4oDrqQUNy0uLrHEZ/sCAAAAAARZWg==

--PS62Nk+e0TdyhMdz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kernel-selftests"

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03
2023-05-18 04:38:13 ln -sf /usr/bin/clang
2023-05-18 04:38:14 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
2023-05-18 04:38:14 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
2023-05-18 04:38:14 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2023-05-18 04:38:14 make -j16 -C sgx
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx'
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/../../../tools/include -fPIC -z noexecstack -c main.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx/main.o
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/../../../tools/include -fPIC -z noexecstack -c load.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx/load.o
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/../../../tools/include -fPIC -z noexecstack -c sigstruct.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx/sigstruct.o
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/../../../tools/include -fPIC -z noexecstack -c call.S -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx/call.o
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/../../../tools/include -fPIC -z noexecstack -c sign_key.S -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx/sign_key.o
gcc -Wall -Werror -static -nostdlib -nostartfiles -fPIC -fno-stack-protector -mrdrnd -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/../../../tools/include -T test_encl.lds test_encl.c test_encl_bootstrap.S -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx/test_encl.elf -Wl,--build-id=none
/usr/bin/ld: warning: /tmp/lkp/cc9qYTLW.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/../../../tools/include -fPIC -z noexecstack -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx/test_sgx /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx/main.o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx/load.o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx/sigstruct.o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx/call.o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx/sign_key.o -lcrypto
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx'
2023-05-18 04:38:16 make quicktest=1 run_tests -C sgx
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx'
TAP version 13
1..1
# selftests: sgx: test_sgx
# TAP version 13
# 1..16
# # Starting 16 tests from 1 test cases.
# #  RUN           enclave.unclobbered_vdso ...
# #            OK  enclave.unclobbered_vdso
# ok 1 enclave.unclobbered_vdso
# #  RUN           enclave.unclobbered_vdso_oversubscribed ...
# #            OK  enclave.unclobbered_vdso_oversubscribed
# ok 2 enclave.unclobbered_vdso_oversubscribed
# #  RUN           enclave.unclobbered_vdso_oversubscribed_remove ...
# # main.c:402:unclobbered_vdso_oversubscribed_remove:Creating an enclave with 198705152 bytes heap may take a while ...
# #      SKIP      System does not support SGX2
# #            OK  enclave.unclobbered_vdso_oversubscribed_remove
# ok 3 # SKIP System does not support SGX2
# #  RUN           enclave.clobbered_vdso ...
# #            OK  enclave.clobbered_vdso
# ok 4 enclave.clobbered_vdso
# #  RUN           enclave.clobbered_vdso_and_user_function ...
# #            OK  enclave.clobbered_vdso_and_user_function
# ok 5 enclave.clobbered_vdso_and_user_function
# #  RUN           enclave.tcs_entry ...
# #            OK  enclave.tcs_entry
# ok 6 enclave.tcs_entry
# #  RUN           enclave.pte_permissions ...
# #            OK  enclave.pte_permissions
# ok 7 enclave.pte_permissions
# #  RUN           enclave.tcs_permissions ...
# #      SKIP      System does not support SGX2
# #            OK  enclave.tcs_permissions
# ok 8 # SKIP System does not support SGX2
# #  RUN           enclave.epcm_permissions ...
# #      SKIP      System does not support SGX2
# #            OK  enclave.epcm_permissions
# ok 9 # SKIP System does not support SGX2
# #  RUN           enclave.augment ...
# #      SKIP      SGX2 not supported
# #            OK  enclave.augment
# ok 10 # SKIP SGX2 not supported
# #  RUN           enclave.augment_via_eaccept ...
# #      SKIP      SGX2 not supported
# #            OK  enclave.augment_via_eaccept
# ok 11 # SKIP SGX2 not supported
# #  RUN           enclave.tcs_create ...
# #      SKIP      System does not support SGX2
# #            OK  enclave.tcs_create
# ok 12 # SKIP System does not support SGX2
# #  RUN           enclave.remove_added_page_no_eaccept ...
# #      SKIP      System does not support SGX2
# #            OK  enclave.remove_added_page_no_eaccept
# ok 13 # SKIP System does not support SGX2
# #  RUN           enclave.remove_added_page_invalid_access ...
# #      SKIP      System does not support SGX2
# #            OK  enclave.remove_added_page_invalid_access
# ok 14 # SKIP System does not support SGX2
# #  RUN           enclave.remove_added_page_invalid_access_after_eaccept ...
# #      SKIP      System does not support SGX2
# #            OK  enclave.remove_added_page_invalid_access_after_eaccept
# ok 15 # SKIP System does not support SGX2
# #  RUN           enclave.remove_untouched_page ...
# #      SKIP      System does not support SGX2
# #            OK  enclave.remove_untouched_page
# ok 16 # SKIP System does not support SGX2
# # PASSED: 16 / 16 tests passed.
# # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:10 error:0
ok 1 selftests: sgx: test_sgx
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-725ca92fab0b553466d32b1fecd4e8b4adb4ed03/tools/testing/selftests/sgx'

--PS62Nk+e0TdyhMdz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests-sgx.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
need_memory: 3G
kernel-selftests:
  group: sgx
job_origin: kernel-selftests-sgx.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-cfl-e1
tbox_group: lkp-cfl-e1
submit_id: 6465a506dcf16b428c052667
job_file: "/lkp/jobs/scheduled/lkp-cfl-e1/kernel-selftests-sgx-debian-12-x86_64-20220629.cgz-725ca92fab0b553466d32b1fecd4e8b4adb4ed03-20230518-82572-nci7bd-0.yaml"
id: ed72909a230e54127373b9f4117297ad91286948
queuer_version: "/zday/lkp"

#! /db/releases/20230517104217/lkp-src/hosts/lkp-cfl-e1
model: Coffee Lake
nr_node: 1
nr_cpu: 16
memory: 32G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part2"
swap_partitions: LABEL=SWAP
rootfs_partition: "/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part1"
brand: Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz

#! /db/releases/20230517104217/lkp-src/include/category/functional
kmsg:
heartbeat:
meminfo:
kmemleak:

#! /db/releases/20230517104217/lkp-src/include/queue/cyclic
commit: 725ca92fab0b553466d32b1fecd4e8b4adb4ed03

#! /db/releases/20230517104217/lkp-src/include/testbox/lkp-cfl-e1
ucode: '0xf4'
need_kconfig_hw:
- PTP_1588_CLOCK: y
- IGB: y
- SATA_AHCI

#! /db/releases/20230517104217/lkp-src/include/kernel-selftests
need_kernel_version:
need_kconfig:
- BLOCK: y
- BTRFS_FS: m
- EFI: y
- EFIVAR_FS
- FTRACE: y
- IP_ADVANCED_ROUTER: y
- IP_MULTIPLE_TABLES: y
- RC_CORE
- RC_DECODERS: y
- RC_DEVICES: y
- RC_LOOPBACK: m
- RUNTIME_TESTING_MENU: y
- STAGING: y
- SYNC_FILE: y
- TEST_FIRMWARE
- TEST_KMOD: m
- TEST_LKM: m
- TEST_USER_COPY
- TUN: m
- XFS_FS: m
- GPIO_CDEV: y
- OVERLAY_FS
- PERF_EVENTS: y
- SCHED_DEBUG: y
- SHMEM: y
- TMPFS_XATTR: y
- TMPFS: y
rootfs: debian-12-x86_64-20220629.cgz
initrds:
- linux_headers
- linux_selftests
kconfig: x86_64-rhel-8.3-kselftests
enqueue_time: 2023-05-18 12:09:42.703598200 +08:00
_id: 6465a506dcf16b428c052667
_rt: "/result/kernel-selftests/sgx/lkp-cfl-e1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 6d50a24ff3577f57fe5a0643eed35a546c1ae0ee
base_commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
branch: linux-devel/devel-hourly-20230517-020720
result_root: "/result/kernel-selftests/sgx/lkp-cfl-e1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/0"
scheduler_version: "/lkp/lkp/.src-20230517-200353"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-12-x86_64-20220629.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/sgx/lkp-cfl-e1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/vmlinuz-6.4.0-rc1-00003-g725ca92fab0b
- branch=linux-devel/devel-hourly-20230517-020720
- job=/lkp/jobs/scheduled/lkp-cfl-e1/kernel-selftests-sgx-debian-12-x86_64-20220629.cgz-725ca92fab0b553466d32b1fecd4e8b4adb4ed03-20230518-82572-nci7bd-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- commit=725ca92fab0b553466d32b1fecd4e8b4adb4ed03
- initcall_debug
- nmi_watchdog=0
- max_uptime=1200
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw

#! runtime status
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230329.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-60acb023-1_20230329.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20230326.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /db/releases/20230517104217/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 4.20.0

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/725ca92fab0b553466d32b1fecd4e8b4adb4ed03/vmlinuz-6.4.0-rc1-00003-g725ca92fab0b"
dequeue_time: 2023-05-18 12:35:08.149476340 +08:00

#! /cephfs/db/releases/20230517200055/lkp-src/include/site/inn
job_state: finished
loadavg: 1.81 1.05 0.42 1/268 2103
start_time: '1684384693'
end_time: '1684384699'
version: "/lkp/lkp/.src-20230517-200427:3e72a3fe5f66:4c41e25b2b6c"

--PS62Nk+e0TdyhMdz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

ln -sf /usr/bin/clang
ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -j16 -C sgx
make quicktest=1 run_tests -C sgx

--PS62Nk+e0TdyhMdz--
