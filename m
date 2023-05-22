Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DDA70B79F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjEVI3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjEVI3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:29:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821E7BE;
        Mon, 22 May 2023 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684744140; x=1716280140;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Fm8khGruqSFipchTDB3EA4dnQD1UrfBXLe/dNSxe3Os=;
  b=Zj3ae0noUbI3+BfoqafgNKSHpFdQSV5R3yT58u00WR8dcRAU/SorLt77
   Ey4HywIdmubgaBtTDNjQ6fwx3SLveSlo6DWR1VWYHbMyoYgjFdDlPK2GH
   lMKA1HrMqc4I4XsOZObmQcXWnp+e0cyb28FbKmosvroakl4m2lkc+eO5o
   oIjPizm+jrggHoxIT7nh/U6NTr8nFrcy79t6en6CB1zySkpk50OjWr6nB
   cXR/tX0FJoMLScn0UEtXPZiPDtJ5gyLa6XOknPd+mTIwf+k8n+D6iT/q5
   fEx+N8lKY2HU5ny4aNlqVBy9YpcbNHTWEDGVV6C01tRjByUxCAyhryVGy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="439215642"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="yaml'?scan'208";a="439215642"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 01:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="827630645"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="yaml'?scan'208";a="827630645"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 22 May 2023 01:28:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 01:28:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 01:28:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 01:28:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 01:28:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ik+6edv+lXDkizdh/1zXotGOssVd85cUmAzSGnNdoXRhVVIUun+OFWy05o685XRL5k5MpuDMkz3Jft7u9gHjOSEEheAB7A3JRNaiMzJjyiyFSvBaa5+w3rr8CcW7H8BJWn+9HJbMzn1fKPJemsuY9BqQCKUx78jIG0VqrMfl6bn0y8/9AQnhG1ppvcH00L/WXImvmRHqjAE2UHNgM4/aFvVmTAO77/Wa0bjwGVMmEgjo5lD/AjQs9iG/C3VvSefBHRO5dX1m2u5BxJvBVvLQWgB3oHnKA9cimrV2YApgSPb8IfOYKjrvVpuSd0E6L3/Uux+LjQGDaKKH4qKK25i2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRXWadzzK7srC+0zI9Kho846UlHRStFWEg1/672Rap8=;
 b=QmP+9V4OzLEMhFeTXd9LAWhEhWfvH873a0GhDCyz8q2u5xKUi6mcNoh3ooW7bJAmscJdap6wE2o3awgL4ZD/XjpobTSTk6B6dAN8xIC1cKW3y5Qb2QQyqNPZYPyaqvgrW+S4siVzNLowDFxoJSNG3n3rI5V+V1b1f0PRaeWEsXYNBYSN8MeIQT3UsuMJfoSWB7edQeigXJUfobzKPLzGkU9bkIV4mgn+5O3/5wQqMb+g3huxjptFkVDc8vcoSG756JJPv81BuiFxOdkis6FQstSqcWqDTnUEjnhC3GjcY43Y0zJlzEnBco8TPwlfYUMI166PSi2PA9XhYycAkBLY5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH3PR11MB7275.namprd11.prod.outlook.com (2603:10b6:610:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.25; Mon, 22 May
 2023 08:28:44 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf%6]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 08:28:43 +0000
Date:   Mon, 22 May 2023 16:28:31 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Wyes Karny <wyes.karny@amd.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-pm@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <ray.huang@amd.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v4 3/3] cpufreq: Return failure if fast_switch is not set
 and fast_switch_possible is set
Message-ID: <202305221612.200d8fb1-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="0KnvGdYZjz/yEpkn"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517162817.8538-4-wyes.karny@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH3PR11MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8a81f4-ff00-49ad-6f24-08db5a9e8d2e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K82tSm1gVlhlrt69dHCDQcVOwqviu0i7vSjz5uy0MI4EVMDkBl0SDb46SFVDlUNaTGIMLGPVmN8NmHXUopJGrm9TnPsIz5i6cU0IlKqaRpJbB1bCBOJBMEkx/pbZZet3sz0ooyFNQXTe00YxO7PGuM1OsfWOJhzgN+l8WpZFUVHc3+OmEtqGDBJZuFZikGRbTHoo+K+I+ox+a2TDhbAmuADjrzDJ8G8zQ8JIkj1g4FKJ8if73SrTS9M8HRDS8tzC+iSjtQt6gw3I5KJfT5FyEQRpWBrZMmNACYanQF/BujWfb8PWkqEr/NHeCiftT9mdSl7tiBObXhpcktlp1nC1KjrScMrt51ghrheslp6wHmUFtghKFr7bom/Dj4GPmZdznM0OQeoGP4sLucsc0I7CH5jbTOySTj7WrbUSHQnDxeZPicFfMkV0355QzLvDbkneMN7GEjCDeqN8+BL59ZrdRaaAhF+x3xU1q2DWrfSCIWdJ8trcI3FidieVciRW4FZJ1y8JZW8GIi416Zpbv7eFLZ36gKF13iIstr8sOpP2EvB+57E4lDWrm403+aGx7zbpion2E1sgoyGGXoLDdxw2sHUVphPyuXpArbS+tFWfoRWu6UqgRCNngkCc2IyJn37DtemhavrdFCK/8qv2tuUX0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(8936002)(8676002)(38100700002)(5660300002)(235185007)(82960400001)(6512007)(6506007)(26005)(21490400003)(1076003)(186003)(2906002)(30864003)(36756003)(83380400001)(2616005)(107886003)(966005)(86362001)(316002)(19627235002)(6486002)(6666004)(4326008)(6916009)(66476007)(66556008)(66946007)(478600001)(41300700001)(44144004)(2700100001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kwiBqFGL6h0DNMALXlI/gv6+VhmaM338Lp+Wbp9vhi64ysyXOImDQutvk9?=
 =?iso-8859-1?Q?9NvB73ID9F4nx7iAryfhcUzp3GsRAvhBmw4rwVosk6eP3kyi/0F9PjY3ly?=
 =?iso-8859-1?Q?SLs0L4uV2qOBw4Pc41Q6aJUY0vwX+H/LGicgwf+mrDAnE2i3UBgBXs65EO?=
 =?iso-8859-1?Q?sLOTH7vR2hzhxHQV4Sh3wfWcuyXjmgkXCcn6XbZcgkJnlF/PaQW7Fe38Qg?=
 =?iso-8859-1?Q?IidYntEVe6u9Hrgzv2lije9cXnRKRhEGyy01O+YCpD7wWzXrvjbUt/AkPQ?=
 =?iso-8859-1?Q?Q2E5RUUglnPnd8od6kyn2h+NBbQe4qt/4Wsyp0ZbV+TAH2nDtLarKwFDgj?=
 =?iso-8859-1?Q?CV2L4eZATjUHwCcHTCrqCyZo+r5zBdgBKDz82cCgM5gyiFxzs+zQOhE+6F?=
 =?iso-8859-1?Q?X9WJ0U9kVG72I9KSJqXM1c/jFFTc2BkfZYdgcJ9jr76Lwi23iR/VUuYnwX?=
 =?iso-8859-1?Q?YcfXqFMIdJkY5KqLicNTGdKNWVLG0ZFuWFWzVTckrnQAQidDf+53G6nkyJ?=
 =?iso-8859-1?Q?2QCo+7IZQqOQ1ENXzTwbTm5s899TKgs0doJJRY5yExP4vVxZKH3QVsL5a5?=
 =?iso-8859-1?Q?lvUlRTAytgiIzh6/DAVXlfv+jYLyMEGAMd4Tq+WgvUA2ynMRUTZAywpNCw?=
 =?iso-8859-1?Q?2q6ercwv/ZL1unQtXn6MelNL1jnhhVZO+GXG61WQq/nupzuMIeVNgCKdH3?=
 =?iso-8859-1?Q?W7TUn+VLTxWlHWEh9zK9YqxW5LfZcYNrNM4G/jUyHBPRZVhP72HBp9Cf9/?=
 =?iso-8859-1?Q?9wdGqYFJ/c/tSiXEW4NxC0ChFmAcLZ1Q1HIVJNylKaUEqYwedAwxA95o7o?=
 =?iso-8859-1?Q?gPWao6B6w42KIH9DDBxAAmZtogpkYWf+fq8YVWx0+vfhLS7PQj6iOGKJm2?=
 =?iso-8859-1?Q?WJMRoZoTGg+Kw6AIP8a6r3iv9R4+wGtpbYaAWbDFnmzIOhFZP5ejgq7YRJ?=
 =?iso-8859-1?Q?ibu71G0WerHLPEefigiELwDmkR29IWVUT+RdXCLbh8k657OR06jBGNdxX0?=
 =?iso-8859-1?Q?EWLN1JcqOlXXMrn6BLju1mdfjBEL/wD4HKV0IVbtvpZwZ8Ye5VrU0Spfo1?=
 =?iso-8859-1?Q?RGnzHVqmXiL88bLI2Zid+rR4dvMZ+uaLIuWTJAk6S+4NKrCOEm3WniivlI?=
 =?iso-8859-1?Q?pUymHYZWQas0oEDRR+CiTHiU6lvhz1zndJvAoz3xLXfK3Ye0lHcqbu04uE?=
 =?iso-8859-1?Q?WNx8jIwVs/9qHfRD3g+uUDIMVdegiaB88es21sUxjKdytAmCAr02XszZ3P?=
 =?iso-8859-1?Q?x9cWSpbZZrbyvvFjrFk2kv1lbqLfTxLDe8HYPkChbq/fdEuq4A2yYK4oT6?=
 =?iso-8859-1?Q?yp1rxrUd7KUMdK37cZWlqz8DmslFh8e9N4zPFFmC3hOTBcm40w9NXj/1+F?=
 =?iso-8859-1?Q?4CHRHsryiHUUZVJ+femt3/pMPWQpAtaKVc1Rs+kBnGo+Ll5S3HoYeEEaoB?=
 =?iso-8859-1?Q?gN0fkcxL9in/BapPX4GCmG/tzqo7Cntd9a0QoHb3E3o63xtQEgWdDBWg5q?=
 =?iso-8859-1?Q?fYKcT7vzrI1ioNK1Dykn18+grKayEElYjt8J+Ppefr2drY4icvk8OUGBb0?=
 =?iso-8859-1?Q?g4h4f9/7LLgdKmLD7/h5qVg+RmaQx4tfvIUQUaHSNsQuslO7zATdpFERDw?=
 =?iso-8859-1?Q?AvcDSXZb9IwAOHde6NcXZviP5NEPNzoi8A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8a81f4-ff00-49ad-6f24-08db5a9e8d2e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 08:28:43.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ph1UYrbEHlMpnp84Lk/dybHKGAGfkkt82u4NGRz9N6nWh8+z5bYKj7/3Lyv/Szwn6ZCVmcL/PIWpbLVELnB0eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7275
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0KnvGdYZjz/yEpkn
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Hello,

kernel test robot noticed a 302.3% regression of phoronix-test-suite.glibc-bench.sin.nanoseconds on:


commit: 278dfbd17c5d0767834471d7fea71d3127c3ecfb ("[PATCH v4 3/3] cpufreq: Return failure if fast_switch is not set and fast_switch_possible is set")
url: https://github.com/intel-lab-lkp/linux/commits/Wyes-Karny/amd_pstate-Add-fast_switch-callback/20230518-010448
base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
patch link: https://lore.kernel.org/all/20230517162817.8538-4-wyes.karny@amd.com/
patch subject: [PATCH v4 3/3] cpufreq: Return failure if fast_switch is not set and fast_switch_possible is set

testcase: phoronix-test-suite
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
parameters:

	test: glibc-bench-1.6.1
	option_a: sin
	cpufreq_governor: performance

test-description: The Phoronix Test Suite is the most comprehensive testing and benchmarking platform available that provides an extensible framework for which new tests can be easily added.
test-url: http://www.phoronix-test-suite.com/

In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.n-queens.0.seconds 313.6% regression                                                           |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory                                           |
| test parameters  | cpufreq_governor=performance                                                                                                            |
|                  | test=n-queens-1.2.1                                                                                                                     |
+------------------+-----------------------------------------------------------------------------------------------------------------------------------------+
| testcase: change | filebench: filebench.sum_operations/s -72.1% regression                                                                                 |
| test machine     | 96 threads 2 sockets (Ice Lake) with 256G memory                                                                                        |
| test parameters  | cpufreq_governor=performance                                                                                                            |
|                  | disk=1HDD                                                                                                                               |
|                  | fs=xfs                                                                                                                                  |
|                  | test=cvar_example.f                                                                                                                     |
+------------------+-----------------------------------------------------------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.glibc-bench.ffs.nanoseconds 301.2% regression                                                  |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory                                           |
| test parameters  | cpufreq_governor=performance                                                                                                            |
|                  | option_a=ffs                                                                                                                            |
|                  | test=glibc-bench-1.6.1                                                                                                                  |
+------------------+-----------------------------------------------------------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.glibc-bench.pthread_once.nanoseconds 300.8% regression                                                                                   |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory                                           |
| test parameters  | cpufreq_governor=performance                                                                                                            |
|                  | option_a=pthread_once                                                                                                                   |
|                  | test=glibc-bench-1.6.1                                                                                                                  |
+------------------+-----------------------------------------------------------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.cyclictest.clock_nanosleepTIME_ABSTIME,Interval500ms,100000Loops.ms_average 5550.0% regression |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory                                           |
| test parameters  | cpufreq_governor=performance                                                                                                            |
|                  | option_a=3                                                                                                                              |
|                  | test=cyclictest-1.0.0                                                                                                                   |
+------------------+-----------------------------------------------------------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.astcenc.Medium.seconds 106.6% regression                                                       |
| test machine     | 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory                                               |
| test parameters  | cpufreq_governor=performance                                                                                                            |
|                  | option_a=Medium                                                                                                                         |
|                  | test=astcenc-1.1.0                                                                                                                      |
+------------------+-----------------------------------------------------------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.pyperformance.pickle_pure_python.milliseconds -99.4% regression                                |
| test machine     | 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory                                               |
| test parameters  | cpufreq_governor=performance                                                                                                            |
|                  | option_a=pickle_pure_python                                                                                                             |
|                  | test=pyperformance-1.0.2                                                                                                                |
+------------------+-----------------------------------------------------------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.x11perf.500pxCopyFromWindowToWindow.operations___second -7.3% regression                       |
| test machine     | 12 threads 1 sockets Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz (Coffee Lake) with 32G memory                                              |
| test parameters  | cpufreq_governor=performance                                                                                                            |
|                  | need_x=true                                                                                                                             |
|                  | option_a=500px Copy From Window To Window                                                                                               |
|                  | test=x11perf-1.1.1                                                                                                                      |
+------------------+-----------------------------------------------------------------------------------------------------------------------------------------+


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202305221612.200d8fb1-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.

=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/sin/debian-x86_64-phoronix/lkp-csl-2sp7/glibc-bench-1.6.1/phoronix-test-suite

commit: 
  a525b95417 ("cpufreq/amd-pstate: Remove fast_switch_possible flag from active driver")
  278dfbd17c ("cpufreq: Return failure if fast_switch is not set and fast_switch_possible is set")

a525b954173e74cd 278dfbd17c5d0767834471d7fea 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6          100%           6:6     kmsg.cpufreq:fast_switch_possible_is_enabled_but_fast_switch_callback_is_not_set
         %stddev     %change         %stddev
             \          |                \  
     72.00          +302.3%     289.69        phoronix-test-suite.glibc-bench.sin.nanoseconds
     86.29           +14.5%      98.84        phoronix-test-suite.time.elapsed_time
     86.29           +14.5%      98.84        phoronix-test-suite.time.elapsed_time.max
    307.00 ± 15%    +397.0%       1525 ±  3%  phoronix-test-suite.time.involuntary_context_switches
     74.33            +5.6%      78.50        phoronix-test-suite.time.percent_of_cpu_this_job_got
     61.97           +12.2%      69.52        phoronix-test-suite.time.user_time
      8020 ±  3%     +32.1%      10593        meminfo.Active(anon)
 8.199e+09            +9.8%  9.003e+09        cpuidle..time
   8533649           +12.1%    9564836        cpuidle..usage
     80285 ±  5%     -39.2%      48852 ± 28%  numa-meminfo.node0.AnonHugePages
     14184 ± 93%    +360.9%      65375 ± 24%  numa-meminfo.node1.AnonHugePages
    144.48 ±  5%     +13.8%     164.46        uptime.boot
     12935 ±  5%     +11.6%      14439        uptime.idle
      1.00          +100.0%       2.00        vmstat.procs.r
      2346          +108.3%       4888        vmstat.system.cs
     95898            -2.3%      93730        vmstat.system.in
      0.04 ±  8%      -0.0        0.03 ±  4%  mpstat.cpu.all.iowait%
      1.64            +2.0        3.59        mpstat.cpu.all.irq%
      0.09 ±  3%      +0.1        0.21 ±  2%  mpstat.cpu.all.soft%
      0.09            +0.2        0.28        mpstat.cpu.all.sys%
      0.90            +0.8        1.68        mpstat.cpu.all.usr%
      2004 ±  3%     +32.1%       2648        proc-vmstat.nr_active_anon
    110098            -4.0%     105659        proc-vmstat.nr_anon_pages
    286491            -1.6%     281968        proc-vmstat.nr_inactive_anon
     52653            -1.1%      52049        proc-vmstat.nr_slab_unreclaimable
      2004 ±  3%     +32.1%       2648        proc-vmstat.nr_zone_active_anon
    286491            -1.6%     281968        proc-vmstat.nr_zone_inactive_anon
    513152            +8.7%     557738        proc-vmstat.numa_hit
    494207            +9.0%     538756        proc-vmstat.numa_local
    592220            +9.6%     649301        proc-vmstat.pgalloc_normal
    681984 ±  2%     +10.6%     754452        proc-vmstat.pgfault
    492147 ±  2%     +10.6%     544510        proc-vmstat.pgfree
     89356 ±  2%     +16.7%     104272        proc-vmstat.pgreuse
    835328           +13.6%     948992        proc-vmstat.unevictable_pgs_scanned
      4.17            +4.7        8.90        turbostat.Busy%
      1607           -56.4%     700.00        turbostat.Bzy_MHz
     59849 ± 12%    +264.1%     217899 ±  7%  turbostat.C1E
      0.23 ±  4%      +0.1        0.30 ±  2%  turbostat.C1E%
   8348392           +10.9%    9254503        turbostat.C6
     71.41           -21.0%      56.44        turbostat.CPU%c1
     24.42 ±  2%     +41.9%      34.65        turbostat.CPU%c6
     51.50 ±  3%     -25.9%      38.17        turbostat.CoreTmp
   8545229           +11.7%    9542613        turbostat.IRQ
     35868 ±  6%     -96.2%       1375 ± 38%  turbostat.POLL
     18.83 ±  5%     -57.2%       8.06 ±  3%  turbostat.Pkg%pc2
      2.57 ±  7%     -74.2%       0.66 ±  4%  turbostat.Pkg%pc6
     51.67 ±  2%     -25.5%      38.50        turbostat.PkgTmp
    121.11           -42.2%      70.00        turbostat.PkgWatt
     53.52 ± 18%     -16.0       37.52 ± 22%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     53.52 ± 18%     -16.0       37.52 ± 22%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.74 ±103%      -8.3        2.42 ±155%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
     10.74 ±103%      -8.3        2.42 ±155%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      8.15 ±116%      -6.9        1.26 ±145%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.__generic_file_write_iter
     10.74 ±103%      -6.6        4.09 ±178%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
     10.74 ±103%      -6.6        4.09 ±178%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      4.26 ±105%      -4.3        0.00        perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      4.26 ± 84%      -3.8        0.50 ±223%  perf-profile.calltrace.cycles-pp.__do_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      5.19 ± 85%      -3.0        2.17 ±169%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      5.19 ± 85%      -3.0        2.17 ±169%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     53.52 ± 18%     -16.0       37.52 ± 22%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     53.52 ± 18%     -16.0       37.52 ± 22%  perf-profile.children.cycles-pp.do_syscall_64
     10.74 ±103%      -6.6        4.09 ±178%  perf-profile.children.cycles-pp.unmap_vmas
     10.74 ±103%      -6.6        4.09 ±178%  perf-profile.children.cycles-pp.unmap_page_range
     10.74 ±103%      -6.6        4.09 ±178%  perf-profile.children.cycles-pp.zap_pmd_range
     10.74 ±103%      -6.6        4.09 ±178%  perf-profile.children.cycles-pp.zap_pte_range
      4.26 ±105%      -4.3        0.00        perf-profile.children.cycles-pp.page_remove_rmap
      4.26 ± 84%      -3.8        0.50 ±223%  perf-profile.children.cycles-pp.__do_fault
      5.18 ± 85%      -3.0        2.17 ±169%  perf-profile.children.cycles-pp.do_fault
      5.18 ± 85%      -3.0        2.17 ±169%  perf-profile.children.cycles-pp.do_read_fault
      2862 ± 20%   +5653.9%     164728 ±213%  sched_debug.cfs_rq:/.load.avg
     47107 ± 16%  +32534.6%   15373401 ±219%  sched_debug.cfs_rq:/.load.max
      9468 ± 12%  +16445.2%    1566546 ±218%  sched_debug.cfs_rq:/.load.stddev
     58.57 ± 33%     -58.9%      24.09 ± 46%  sched_debug.cfs_rq:/.load_avg.avg
    203.27 ± 18%     -53.0%      95.47 ± 50%  sched_debug.cfs_rq:/.load_avg.stddev
     37231 ± 14%     +51.4%      56368 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
     39.58 ± 51%     -77.9%       8.76 ±126%  sched_debug.cfs_rq:/.removed.load_avg.avg
    187.92 ± 25%     -66.1%      63.64 ±106%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     18.16 ± 57%     -77.1%       4.16 ±123%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     18.16 ± 57%     -77.1%       4.16 ±123%  sched_debug.cfs_rq:/.removed.util_avg.avg
    214.61 ± 14%     -37.7%     133.71 ±  6%  sched_debug.cfs_rq:/.runnable_avg.avg
    248.38 ±  6%     -17.4%     205.07 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
    214.53 ± 14%     -37.7%     133.59 ±  6%  sched_debug.cfs_rq:/.util_avg.avg
    248.36 ±  6%     -17.4%     205.03 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
    715.50 ±  6%     -41.8%     416.50 ± 25%  sched_debug.cfs_rq:/.util_est_enqueued.max
     99.21 ±  6%     -31.7%      67.78 ± 24%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
   2382316 ± 46%     -49.6%    1201480 ± 12%  sched_debug.cpu.avg_idle.max
     36009           +21.1%      43615 ±  2%  sched_debug.cpu.clock_task.min
    117475 ± 75%     -88.0%      14136 ± 82%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 20%    +130.0%       0.00 ± 63%  sched_debug.cpu.next_balance.stddev
     52309           +15.6%      60475        sched_debug.sched_clk
     25.76 ±  4%     +48.2%      38.19        perf-stat.i.MPKI
 7.905e+08           -45.2%   4.33e+08        perf-stat.i.branch-instructions
      3.18 ±  2%      +2.8        5.96        perf-stat.i.branch-miss-rate%
  15210221           +64.8%   25060061        perf-stat.i.branch-misses
   2046023           +68.1%    3438514        perf-stat.i.cache-misses
  49258879           +69.3%   83372455        perf-stat.i.cache-references
      1997          +130.4%       4601        perf-stat.i.context-switches
      2.07 ±  2%     +12.5%       2.32        perf-stat.i.cpi
 5.568e+09            -6.3%  5.218e+09        perf-stat.i.cpu-cycles
      3074           -48.9%       1571        perf-stat.i.cycles-between-cache-misses
      0.31 ±  5%      +0.2        0.52        perf-stat.i.dTLB-load-miss-rate%
   1469231           +70.0%    2497301        perf-stat.i.dTLB-load-misses
 1.117e+09           -52.2%  5.343e+08        perf-stat.i.dTLB-loads
      0.06 ±  5%      +0.0        0.11        perf-stat.i.dTLB-store-miss-rate%
    140944 ±  3%     +63.8%     230910        perf-stat.i.dTLB-store-misses
 4.405e+08           -46.6%  2.354e+08        perf-stat.i.dTLB-stores
     61.61           +12.2       73.84        perf-stat.i.iTLB-load-miss-rate%
    799474            -3.9%     768539        perf-stat.i.iTLB-load-misses
    499584 ±  2%     -45.3%     273344 ±  3%  perf-stat.i.iTLB-loads
 5.589e+09           -55.2%  2.504e+09        perf-stat.i.instructions
      7134           -54.0%       3281        perf-stat.i.instructions-per-iTLB-miss
      1.00           -52.6%       0.47        perf-stat.i.ipc
      2.07 ±  4%     -58.4%       0.86 ±  6%  perf-stat.i.major-faults
      0.06            -6.3%       0.05        perf-stat.i.metric.GHz
    618.20           +40.6%     869.20        perf-stat.i.metric.K/sec
     24.35           -48.5%      12.53        perf-stat.i.metric.M/sec
     83.55            -3.9       79.68        perf-stat.i.node-load-miss-rate%
     92330 ±  2%     +36.8%     126293 ±  3%  perf-stat.i.node-load-misses
     38082 ±  2%     +17.1%      44601 ±  3%  perf-stat.i.node-loads
     42624 ± 14%     +41.2%      60176 ±  9%  perf-stat.i.node-store-misses
      8.82          +277.4%      33.29        perf-stat.overall.MPKI
      1.92            +3.9        5.79        perf-stat.overall.branch-miss-rate%
      1.00          +109.0%       2.08        perf-stat.overall.cpi
      2722 ±  2%     -44.3%       1517        perf-stat.overall.cycles-between-cache-misses
      0.13            +0.3        0.47        perf-stat.overall.dTLB-load-miss-rate%
      0.03 ±  3%      +0.1        0.10        perf-stat.overall.dTLB-store-miss-rate%
     61.55           +12.2       73.77        perf-stat.overall.iTLB-load-miss-rate%
      6987           -53.4%       3258        perf-stat.overall.instructions-per-iTLB-miss
      1.00           -52.2%       0.48        perf-stat.overall.ipc
     70.79            +3.1       73.87        perf-stat.overall.node-load-miss-rate%
     44.13 ± 10%      +7.7       51.80 ±  8%  perf-stat.overall.node-store-miss-rate%
  7.81e+08           -45.1%  4.286e+08        perf-stat.ps.branch-instructions
  15031718           +65.0%   24799436        perf-stat.ps.branch-misses
   2022310           +68.3%    3402668        perf-stat.ps.cache-misses
  48693838           +69.4%   82502207        perf-stat.ps.cache-references
      1974          +130.7%       4554        perf-stat.ps.context-switches
 5.503e+09            -6.2%  5.164e+09        perf-stat.ps.cpu-cycles
   1452373           +70.1%    2471118        perf-stat.ps.dTLB-load-misses
 1.103e+09           -52.1%  5.288e+08        perf-stat.ps.dTLB-loads
    139332 ±  3%     +64.0%     228525        perf-stat.ps.dTLB-store-misses
 4.353e+08           -46.5%   2.33e+08        perf-stat.ps.dTLB-stores
    790174            -3.7%     760575        perf-stat.ps.iTLB-load-misses
    493698 ±  2%     -45.2%     270481 ±  3%  perf-stat.ps.iTLB-loads
 5.521e+09           -55.1%  2.479e+09        perf-stat.ps.instructions
      2.04 ±  4%     -58.2%       0.85 ±  6%  perf-stat.ps.major-faults
     91256 ±  2%     +37.0%     125023 ±  3%  perf-stat.ps.node-load-misses
     37653 ±  2%     +17.3%      44171 ±  3%  perf-stat.ps.node-loads
     42127 ± 14%     +41.4%      59560 ±  9%  perf-stat.ps.node-store-misses
 4.781e+11           -49.8%  2.401e+11        perf-stat.total.instructions


***************************************************************************************************
lkp-csl-2sp7: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/debian-x86_64-phoronix/lkp-csl-2sp7/n-queens-1.2.1/phoronix-test-suite

commit: 
  a525b95417 ("cpufreq/amd-pstate: Remove fast_switch_possible flag from active driver")
  278dfbd17c ("cpufreq: Return failure if fast_switch is not set and fast_switch_possible is set")

a525b954173e74cd 278dfbd17c5d0767834471d7fea 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6          100%           6:6     kmsg.cpufreq:fast_switch_possible_is_enabled_but_fast_switch_callback_is_not_set
         %stddev     %change         %stddev
             \          |                \  
      4.14          +313.6%      17.10        phoronix-test-suite.n-queens.0.seconds
     35.10 ±  2%    +128.7%      80.28        phoronix-test-suite.time.elapsed_time
     35.10 ±  2%    +128.7%      80.28        phoronix-test-suite.time.elapsed_time.max
     28850            -3.0%      27994 ±  2%  phoronix-test-suite.time.maximum_resident_set_size
  2.27e+09 ±  4%     +22.0%  2.769e+09        cpuidle..time
   2439080 ±  3%     +16.5%    2841419        cpuidle..usage
      7803 ±  2%     +30.3%      10166        meminfo.Active(anon)
   2128118           +13.6%    2416662        meminfo.Committed_AS
      3883 ±  8%     -16.6%       3240 ±  9%  numa-meminfo.node0.PageTables
      9073 ±  5%     +15.6%      10489 ±  2%  numa-meminfo.node1.KernelStack
      1929 ± 14%     +49.6%       2885 ±  9%  numa-meminfo.node1.PageTables
    971.33 ±  8%     -16.6%     810.00 ±  9%  numa-vmstat.node0.nr_page_table_pages
      9074 ±  5%     +15.7%      10494 ±  3%  numa-vmstat.node1.nr_kernel_stack
    482.00 ± 14%     +49.8%     721.83 ±  9%  numa-vmstat.node1.nr_page_table_pages
     63.98           -28.9       35.05        mpstat.cpu.all.idle%
      0.09 ±  5%      -0.1        0.04        mpstat.cpu.all.iowait%
      1.64            +1.2        2.84        mpstat.cpu.all.irq%
      0.09 ±  4%      +0.0        0.11        mpstat.cpu.all.soft%
      0.13 ±  2%      +0.2        0.29        mpstat.cpu.all.sys%
     34.08 ±  2%     +27.6       61.67        mpstat.cpu.all.usr%
     65.33           -44.9%      36.00        vmstat.cpu.id
     31.67 ±  2%     +86.8%      59.17        vmstat.cpu.us
      2345 ±  3%     -54.4%       1069 ±  3%  vmstat.io.bi
     31.00           +94.1%      60.17        vmstat.procs.r
      2937           +67.8%       4927        vmstat.system.cs
     96735            -2.6%      94264        vmstat.system.in
    980.50 ±  2%     -53.7%     454.00        turbostat.Avg_MHz
     37.06 ±  2%     +28.7       65.74        turbostat.Busy%
      2671           -73.8%     700.00        turbostat.Bzy_MHz
     64543 ± 21%     -70.0%      19387 ±  7%  turbostat.C1
      0.05 ± 22%      -0.0        0.01        turbostat.C1%
     36674 ± 10%    +197.1%     108951 ± 11%  turbostat.C1E
      0.30 ±  6%      -0.1        0.17 ±  9%  turbostat.C1E%
   2305719 ±  4%     +16.6%    2687774        turbostat.C6
     63.05           -28.7       34.39        turbostat.C6%
     43.38           -53.5%      20.16        turbostat.CPU%c1
     19.56           -27.9%      14.11        turbostat.CPU%c6
     51.00 ±  3%     -24.2%      38.67        turbostat.CoreTmp
   3714942 ±  2%    +113.2%    7921708        turbostat.IRQ
     13286 ±  2%     -96.2%     509.50 ± 24%  turbostat.POLL
     10.25           -67.9%       3.30 ± 11%  turbostat.Pkg%pc2
      5.70 ±  5%     -97.2%       0.16 ±  5%  turbostat.Pkg%pc6
     50.83 ±  4%     -23.0%      39.17        turbostat.PkgTmp
    165.02           -49.5%      83.38        turbostat.PkgWatt
    139.21            +3.3%     143.74        turbostat.RAMWatt
      1950 ±  2%     +30.2%       2539        proc-vmstat.nr_active_anon
     26828            +3.9%      27867        proc-vmstat.nr_active_file
    107483            -4.1%     103038        proc-vmstat.nr_anon_pages
    283850            -1.6%     279280        proc-vmstat.nr_inactive_anon
     20564 ±  2%      +3.8%      21344        proc-vmstat.nr_kernel_stack
      1452            +5.1%       1526        proc-vmstat.nr_page_table_pages
     25654            +1.0%      25919        proc-vmstat.nr_slab_reclaimable
      1950 ±  2%     +30.2%       2539        proc-vmstat.nr_zone_active_anon
     26828            +3.9%      27867        proc-vmstat.nr_zone_active_file
    283850            -1.6%     279280        proc-vmstat.nr_zone_inactive_anon
    390716           +25.2%     489291        proc-vmstat.numa_hit
    371740           +26.5%     470277        proc-vmstat.numa_local
      6451 ± 56%     -90.3%     628.33 ± 59%  proc-vmstat.numa_pages_migrated
     21981 ± 24%     -75.9%       5294 ± 67%  proc-vmstat.numa_pte_updates
    461444           +24.3%     573395        proc-vmstat.pgalloc_normal
    484259           +33.7%     647486        proc-vmstat.pgfault
    361816           +29.2%     467634        proc-vmstat.pgfree
      6451 ± 56%     -90.3%     628.33 ± 59%  proc-vmstat.pgmigrate_success
     58553           +50.8%      88315 ±  2%  proc-vmstat.pgreuse
    335104          +102.6%     678912        proc-vmstat.unevictable_pgs_scanned
      2379 ± 34%    +159.9%       6184 ± 32%  sched_debug.cfs_rq:/.load.avg
      8773 ± 34%    +156.3%      22488 ± 53%  sched_debug.cfs_rq:/.load.stddev
     59.18 ± 31%     -59.2%      24.17 ± 32%  sched_debug.cfs_rq:/.load_avg.avg
      1020 ±  3%     -19.2%     824.58 ± 25%  sched_debug.cfs_rq:/.load_avg.max
    201.36 ± 21%     -49.2%     102.31 ± 30%  sched_debug.cfs_rq:/.load_avg.stddev
      4306 ± 17%   +1283.4%      59568 ±128%  sched_debug.cfs_rq:/.min_vruntime.stddev
     39.17 ± 50%     -80.4%       7.68 ± 95%  sched_debug.cfs_rq:/.removed.load_avg.avg
    185.53 ± 28%     -65.2%      64.59 ± 83%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     17.61 ± 45%     -78.3%       3.82 ± 96%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     86.06 ± 23%     -62.7%      32.11 ± 84%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     17.61 ± 45%     -78.3%       3.82 ± 96%  sched_debug.cfs_rq:/.removed.util_avg.avg
     86.06 ± 23%     -62.7%      32.11 ± 84%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    225.01 ± 11%     -44.8%     124.22 ± 24%  sched_debug.cfs_rq:/.runnable_avg.avg
    253.39 ±  5%     -21.5%     198.91 ± 13%  sched_debug.cfs_rq:/.runnable_avg.stddev
      4306 ± 17%   +1283.1%      59563 ±128%  sched_debug.cfs_rq:/.spread0.stddev
    224.86 ± 11%     -44.8%     124.11 ± 24%  sched_debug.cfs_rq:/.util_avg.avg
    253.32 ±  5%     -21.5%     198.83 ± 13%  sched_debug.cfs_rq:/.util_avg.stddev
    783.83 ± 14%     -42.9%     447.67 ± 49%  sched_debug.cfs_rq:/.util_est_enqueued.max
     96.58 ± 11%     -32.0%      65.67 ± 33%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      3.45 ± 29%    +151.3%       8.67 ±  5%  sched_debug.cpu.clock.stddev
     36256           +46.5%      53120 ± 26%  sched_debug.cpu.clock_task.min
    140.27 ± 23%     +57.5%     220.89 ±  8%  sched_debug.cpu.curr->pid.avg
    525.18 ± 13%     +27.1%     667.27 ±  3%  sched_debug.cpu.curr->pid.stddev
      0.00 ±  9%     +85.4%       0.00 ± 17%  sched_debug.cpu.next_balance.stddev
      0.06 ± 21%     +59.5%       0.10 ± 13%  sched_debug.cpu.nr_running.avg
     52700           +32.7%      69957 ± 20%  sched_debug.sched_clk
     14.93 ± 37%     -14.9        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.93 ± 37%     -14.9        0.00        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.40 ± 56%      -7.4        0.00        perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.40 ± 56%      -7.4        0.00        perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      7.40 ± 56%      -7.4        0.00        perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      7.40 ± 56%      -7.4        0.00        perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      5.05 ±105%      -5.0        0.00        perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      5.05 ±105%      -5.0        0.00        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
      5.05 ±105%      -5.0        0.00        perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      5.05 ±105%      -5.0        0.00        perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      5.05 ±105%      -5.0        0.00        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.00            +6.2        6.21 ± 52%  perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
      0.00            +6.2        6.21 ± 52%  perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
      0.00            +6.9        6.90 ± 46%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.00            +6.9        6.90 ± 46%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
     14.93 ± 37%     -14.9        0.00        perf-profile.children.cycles-pp.__x64_sys_execve
     14.93 ± 37%     -14.9        0.00        perf-profile.children.cycles-pp.do_execveat_common
      7.40 ± 56%      -7.4        0.00        perf-profile.children.cycles-pp.bprm_execve
      7.40 ± 56%      -7.4        0.00        perf-profile.children.cycles-pp.exec_binprm
      7.40 ± 56%      -7.4        0.00        perf-profile.children.cycles-pp.search_binary_handler
      7.40 ± 56%      -7.4        0.00        perf-profile.children.cycles-pp.load_elf_binary
      5.05 ±105%      -5.0        0.00        perf-profile.children.cycles-pp.begin_new_exec
      5.05 ±105%      -5.0        0.00        perf-profile.children.cycles-pp.exec_mmap
      5.88 ± 82%      -4.8        1.11 ±223%  perf-profile.children.cycles-pp.free_pgtables
      0.00            +6.2        6.21 ± 52%  perf-profile.children.cycles-pp.perf_release
      0.00            +6.2        6.21 ± 52%  perf-profile.children.cycles-pp.perf_event_release_kernel
      0.83 ±223%      +6.9        7.74 ± 41%  perf-profile.children.cycles-pp.task_work_run
      0.83 ±223%      +6.9        7.74 ± 41%  perf-profile.children.cycles-pp.__fput
      6.71 ± 75%      -6.0        0.70 ±223%  perf-profile.self.cycles-pp.zap_pte_range
     43.58 ±  5%     -71.0%      12.62 ±  5%  perf-stat.i.MPKI
 8.111e+09 ±  2%     -54.1%  3.721e+09        perf-stat.i.branch-instructions
     14.40            +1.9       16.33        perf-stat.i.branch-miss-rate%
 1.658e+09 ±  2%     -55.4%  7.401e+08        perf-stat.i.branch-misses
      7.61            +2.2        9.79 ±  4%  perf-stat.i.cache-miss-rate%
   2374185           -18.4%    1936172 ±  2%  perf-stat.i.cache-misses
  45065640           -25.1%   33764433        perf-stat.i.cache-references
      2358           +97.5%       4657        perf-stat.i.context-switches
      3.44 ±  3%     -58.6%       1.42 ±  2%  perf-stat.i.cpi
 9.928e+10           -54.8%  4.488e+10        perf-stat.i.cpu-cycles
    125.68 ±  2%     +12.2%     141.01        perf-stat.i.cpu-migrations
    157340 ±  3%     -56.5%      68500 ±  5%  perf-stat.i.cycles-between-cache-misses
      0.47 ±  5%      -0.3        0.17 ±  4%  perf-stat.i.dTLB-load-miss-rate%
   1300850           -25.3%     972044        perf-stat.i.dTLB-load-misses
 1.072e+10 ±  2%     -54.6%  4.867e+09        perf-stat.i.dTLB-loads
      0.08 ±  5%      -0.0        0.04 ±  2%  perf-stat.i.dTLB-store-miss-rate%
    200676            +9.5%     219785        perf-stat.i.dTLB-store-misses
 1.048e+10 ±  2%     -55.3%  4.684e+09        perf-stat.i.dTLB-stores
     77.21            -6.7       70.51        perf-stat.i.iTLB-load-miss-rate%
    835438 ±  7%     -34.9%     544154 ±  3%  perf-stat.i.iTLB-load-misses
    281802           -22.1%     219530        perf-stat.i.iTLB-loads
 1.023e+11 ±  2%     -55.3%  4.576e+10        perf-stat.i.instructions
      0.70 ±  2%     +21.8%       0.85        perf-stat.i.ipc
      5.05 ±  3%     -78.3%       1.10 ±  5%  perf-stat.i.major-faults
      1.03           -54.9%       0.47        perf-stat.i.metric.GHz
    667.47 ±  3%     -46.4%     357.69        perf-stat.i.metric.K/sec
    305.23 ±  2%     -54.7%     138.14        perf-stat.i.metric.M/sec
      6910           -28.6%       4935        perf-stat.i.minor-faults
    143333 ±  4%     -11.2%     127226 ±  3%  perf-stat.i.node-load-misses
     70783 ±  6%     -34.1%      46661 ±  4%  perf-stat.i.node-loads
     59.90 ±  4%      +7.5       67.39        perf-stat.i.node-store-miss-rate%
     78522 ± 14%     -46.0%      42369 ±  3%  perf-stat.i.node-stores
      6915           -28.6%       4936        perf-stat.i.page-faults
      0.44 ±  3%     +60.7%       0.71        perf-stat.overall.MPKI
     20.44            -0.5       19.92        perf-stat.overall.branch-miss-rate%
      5.27 ±  2%      +0.5        5.76 ±  2%  perf-stat.overall.cache-miss-rate%
      0.97            +1.0%       0.98        perf-stat.overall.cpi
     41833 ±  2%     -42.6%      24012 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±  3%      +0.0        0.02        perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  2%      +0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
     74.71            -3.5       71.17        perf-stat.overall.iTLB-load-miss-rate%
    123027 ±  5%     -29.9%      86229 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      1.03            -1.0%       1.02        perf-stat.overall.ipc
     66.94 ±  2%      +6.4       73.36        perf-stat.overall.node-load-miss-rate%
     51.71 ±  8%     +11.2       62.86        perf-stat.overall.node-store-miss-rate%
 7.879e+09           -52.8%  3.722e+09        perf-stat.ps.branch-instructions
  1.61e+09           -54.0%  7.415e+08        perf-stat.ps.branch-misses
   2305884           -18.8%    1872089 ±  2%  perf-stat.ps.cache-misses
  43800806           -25.8%   32479193        perf-stat.ps.cache-references
      2291          +100.8%       4600        perf-stat.ps.context-switches
     93316            +1.6%      94785        perf-stat.ps.cpu-clock
 9.645e+10           -53.4%  4.491e+10        perf-stat.ps.cpu-cycles
    122.10           +14.4%     139.72        perf-stat.ps.cpu-migrations
   1264505           -26.1%     934112        perf-stat.ps.dTLB-load-misses
 1.041e+10           -53.2%  4.871e+09        perf-stat.ps.dTLB-loads
    194993           +11.1%     216552        perf-stat.ps.dTLB-store-misses
 1.018e+10           -53.9%  4.692e+09        perf-stat.ps.dTLB-stores
    811464 ±  7%     -34.4%     532304 ±  3%  perf-stat.ps.iTLB-load-misses
    273639           -21.3%     215398        perf-stat.ps.iTLB-loads
  9.94e+10           -53.9%  4.583e+10        perf-stat.ps.instructions
      4.88 ±  3%     -78.6%       1.05 ±  4%  perf-stat.ps.major-faults
      6706           -28.0%       4827        perf-stat.ps.minor-faults
    139125 ±  4%     -10.6%     124398 ±  3%  perf-stat.ps.node-load-misses
     68666 ±  6%     -34.2%      45167 ±  4%  perf-stat.ps.node-loads
     76159 ± 14%     -46.0%      41093 ±  3%  perf-stat.ps.node-stores
      6711           -28.1%       4828        perf-stat.ps.page-faults
     93316            +1.6%      94785        perf-stat.ps.task-clock
 3.538e+12            +1.6%  3.593e+12        perf-stat.total.instructions



***************************************************************************************************
lkp-icl-2sp1: 96 threads 2 sockets (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/performance/1HDD/xfs/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp1/cvar_example.f/filebench

commit: 
  a525b95417 ("cpufreq/amd-pstate: Remove fast_switch_possible flag from active driver")
  278dfbd17c ("cpufreq: Return failure if fast_switch is not set and fast_switch_possible is set")

a525b954173e74cd 278dfbd17c5d0767834471d7fea 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6          100%           6:6     kmsg.cpufreq:fast_switch_possible_is_enabled_but_fast_switch_callback_is_not_set
         %stddev     %change         %stddev
             \          |                \  
      2831           -72.1%     788.78        filebench.sum_bytes_mb/s
  87006971           -72.1%   24234692        filebench.sum_operations
   1450022           -72.1%     403880        filebench.sum_operations/s
    483340           -72.1%     134626        filebench.sum_reads/s
      0.00          +100.0%       0.00        filebench.sum_time_ms/op
    283.33 ± 97%   +2342.1%       6919 ± 13%  filebench.time.involuntary_context_switches
     14383            +2.1%      14680        filebench.time.minor_page_faults
     93.00            -1.1%      92.00        filebench.time.percent_of_cpu_this_job_got
     72.15 ± 13%    +120.2%     158.88 ± 40%  boot-time.boot
      6397 ± 13%    +119.9%      14065 ± 39%  boot-time.idle
     96.77            -1.7%      95.12        iostat.cpu.idle
      2.79           +49.2%       4.17        iostat.cpu.system
     31818 ± 69%    +201.5%      95941 ±  8%  numa-meminfo.node1.AnonHugePages
    196985 ± 43%     +62.8%     320714 ± 20%  numa-meminfo.node1.Inactive
    141.31 ±  6%     +61.8%     228.60 ± 28%  uptime.boot
     12823 ±  6%     +59.4%      20437 ± 27%  uptime.idle
      2294 ±  2%    +142.4%       5562        vmstat.system.cs
     94416            -1.8%      92687        vmstat.system.in
      1697           +88.1%       3193        meminfo.Active
      1688           +88.7%       3185        meminfo.Active(anon)
     74749 ± 10%     +45.0%     108373 ±  4%  meminfo.AnonHugePages
   8341845 ± 11%     +28.7%   10738346 ± 19%  meminfo.DirectMap2M
      2.05            +1.2        3.27        mpstat.cpu.all.irq%
      0.12 ±  3%      +0.0        0.17 ±  6%  mpstat.cpu.all.soft%
      0.63            +0.1        0.76        mpstat.cpu.all.sys%
      0.42            +0.3        0.70        mpstat.cpu.all.usr%
      2.52 ± 51%      +2.9        5.39 ± 26%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.86 ± 76%      +3.5        5.39 ± 26%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.62 ± 74%      +3.8        5.39 ± 26%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.62 ± 74%      +3.8        5.39 ± 26%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.14 ±223%      +6.1        6.24 ± 46%  perf-profile.calltrace.cycles-pp.show_interrupts.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read
      0.38 ±164%      +6.8        7.16 ± 60%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.24 ±144%      +6.9        7.16 ± 60%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
      2.52 ± 51%      +2.9        5.39 ± 26%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.86 ± 76%      +3.5        5.39 ± 26%  perf-profile.children.cycles-pp.tick_sched_timer
      1.62 ± 74%      +3.8        5.39 ± 26%  perf-profile.children.cycles-pp.tick_sched_handle
      1.62 ± 74%      +3.8        5.39 ± 26%  perf-profile.children.cycles-pp.update_process_times
      0.14 ±223%      +5.7        5.83 ± 54%  perf-profile.children.cycles-pp.show_interrupts
      0.38 ±164%      +6.8        7.16 ± 60%  perf-profile.children.cycles-pp.proc_reg_read_iter
    421.67           +88.9%     796.33        proc-vmstat.nr_active_anon
     18437            +2.3%      18864        proc-vmstat.nr_kernel_stack
     11616            +3.4%      12017        proc-vmstat.nr_shmem
     55935            -2.0%      54811        proc-vmstat.nr_slab_unreclaimable
    421.67           +88.9%     796.33        proc-vmstat.nr_zone_active_anon
      2418           +12.1%       2710 ±  9%  proc-vmstat.numa_hint_faults_local
   1116500 ±  4%     -54.4%     509544 ±  2%  proc-vmstat.numa_hit
   1029620 ±  4%     -59.0%     422532 ±  2%  proc-vmstat.numa_local
   1837630 ±  5%     -66.1%     623575 ±  3%  proc-vmstat.pgalloc_normal
    308419            +4.3%     321665        proc-vmstat.pgfault
   1648136 ±  6%     -74.1%     427598 ±  5%  proc-vmstat.pgfree
     13210           +10.0%      14531        proc-vmstat.pgreuse
    510506           +11.8%     570880        proc-vmstat.unevictable_pgs_scanned
     85.17           -26.8%      62.33        turbostat.Avg_MHz
      4.09            +2.2        6.29        turbostat.Busy%
      2077           -51.9%       1000        turbostat.Bzy_MHz
      7434 ±  5%    +986.2%      80757 ±  2%  turbostat.C1
     29350 ±  3%    +127.1%      66640 ±  2%  turbostat.C1E
      3.51 ±  7%     +51.0%       5.30 ±  5%  turbostat.CPU%c1
     53.50           -15.3%      45.33 ±  5%  turbostat.CoreTmp
     16996 ±  5%     -96.8%     545.33 ± 30%  turbostat.POLL
     36.83           -16.8%      30.63 ±  3%  turbostat.Pkg%pc2
      1.58 ±  8%     -25.8%       1.17 ±  2%  turbostat.Pkg%pc6
     54.17           -13.5%      46.83 ±  4%  turbostat.PkgTmp
    209.90           -41.0%     123.86        turbostat.PkgWatt
    162.53           -10.2%     145.96        turbostat.RAMWatt
    100.43 ± 20%     -71.1%      28.98 ± 21%  sched_debug.cfs_rq:/.load_avg.avg
    272.22 ± 10%     -55.7%     120.65 ± 19%  sched_debug.cfs_rq:/.load_avg.stddev
     21531 ± 21%     -40.9%      12715 ± 19%  sched_debug.cfs_rq:/.min_vruntime.avg
     61.41 ± 33%     -83.9%       9.91 ± 54%  sched_debug.cfs_rq:/.removed.load_avg.avg
    237.67 ± 15%     -63.1%      87.63 ± 46%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     24.37 ± 40%     -83.6%       3.99 ± 73%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    528.83           -41.3%     310.17 ± 56%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     98.29 ± 21%     -65.0%      34.42 ± 61%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     24.37 ± 40%     -83.6%       3.99 ± 73%  sched_debug.cfs_rq:/.removed.util_avg.avg
    528.83           -41.3%     310.17 ± 56%  sched_debug.cfs_rq:/.removed.util_avg.max
     98.29 ± 21%     -65.0%      34.42 ± 61%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    311.92 ±  4%     -29.3%     220.52 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
      1445 ± 11%     -29.1%       1024        sched_debug.cfs_rq:/.runnable_avg.max
    337.24 ±  7%     -26.1%     249.36 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
    311.31 ±  4%     -29.2%     220.40 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      1444 ± 11%     -29.1%       1024        sched_debug.cfs_rq:/.util_avg.max
    336.63 ±  7%     -25.9%     249.28 ±  3%  sched_debug.cfs_rq:/.util_avg.stddev
    502.50 ±  4%     +57.5%     791.33        sched_debug.cfs_rq:/.util_est_enqueued.max
      2321 ± 18%    +196.4%       6880 ±  6%  sched_debug.cpu.avg_idle.min
     78576 ± 12%    +111.1%     165880 ± 38%  sched_debug.cpu.clock.avg
     78581 ± 12%    +111.1%     165890 ± 38%  sched_debug.cpu.clock.max
     78570 ± 12%    +111.1%     165870 ± 38%  sched_debug.cpu.clock.min
      2.89 ± 26%     +96.7%       5.68 ±  5%  sched_debug.cpu.clock.stddev
     77698 ± 11%    +109.1%     162504 ± 38%  sched_debug.cpu.clock_task.avg
     78440 ± 12%    +110.4%     165076 ± 38%  sched_debug.cpu.clock_task.max
     48018           +54.5%      74192 ± 10%  sched_debug.cpu.clock_task.min
     78574 ± 12%    +111.1%     165870 ± 38%  sched_debug.cpu_clk
     77364 ± 12%    +112.8%     164658 ± 39%  sched_debug.ktime
     64011           +42.5%      91223 ±  9%  sched_debug.sched_clk
     12.22 ±  2%    +157.3%      31.43        perf-stat.i.MPKI
 1.623e+09           -60.9%   6.35e+08        perf-stat.i.branch-instructions
      1.03 ±  4%      +1.4        2.47 ±  2%  perf-stat.i.branch-miss-rate%
      0.58 ±  2%      +0.1        0.68 ±  5%  perf-stat.i.cache-miss-rate%
    562035 ±  2%     +11.1%     624178 ±  4%  perf-stat.i.cache-misses
  94757587 ±  2%      -5.8%   89223187        perf-stat.i.cache-references
      1864 ±  2%    +184.1%       5298        perf-stat.i.context-switches
      0.87           +79.6%       1.57        perf-stat.i.cpi
 6.768e+09           -33.0%  4.536e+09        perf-stat.i.cpu-cycles
    105.39            -2.3%     102.97        perf-stat.i.cpu-migrations
     17826 ±  4%     -45.7%       9673 ±  6%  perf-stat.i.cycles-between-cache-misses
      0.13            +0.2        0.35        perf-stat.i.dTLB-load-miss-rate%
   2476399            +3.2%    2556155        perf-stat.i.dTLB-load-misses
 1.953e+09           -60.6%  7.691e+08        perf-stat.i.dTLB-loads
      0.02 ±  2%      +0.0        0.06 ±  5%  perf-stat.i.dTLB-store-miss-rate%
  1.16e+09           -63.3%  4.259e+08        perf-stat.i.dTLB-stores
  7.77e+09           -60.4%   3.08e+09        perf-stat.i.instructions
      1.15           -42.5%       0.66        perf-stat.i.ipc
      0.09 ± 68%     -93.8%       0.01 ±141%  perf-stat.i.major-faults
      0.07           -32.9%       0.05        perf-stat.i.metric.GHz
     49.68           -61.6%      19.08        perf-stat.i.metric.M/sec
    107291 ±  7%     +31.6%     141162 ±  5%  perf-stat.i.node-load-misses
     12.20 ±  2%    +137.6%      28.98        perf-stat.overall.MPKI
      1.02 ±  4%      +1.4        2.47 ±  2%  perf-stat.overall.branch-miss-rate%
      0.59 ±  2%      +0.1        0.70 ±  4%  perf-stat.overall.cache-miss-rate%
      0.87           +69.1%       1.47        perf-stat.overall.cpi
     12075 ±  2%     -39.7%       7285 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.13            +0.2        0.33 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.02 ±  2%      +0.0        0.06 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
      1.15           -40.9%       0.68        perf-stat.overall.ipc
 1.597e+09           -60.9%  6.242e+08        perf-stat.ps.branch-instructions
    551866 ±  2%     +11.2%     613416 ±  4%  perf-stat.ps.cache-misses
  93226966 ±  2%      -5.9%   87736015        perf-stat.ps.cache-references
      1834 ±  2%    +184.1%       5212        perf-stat.ps.context-switches
 6.659e+09           -33.0%   4.46e+09        perf-stat.ps.cpu-cycles
    103.65            -2.4%     101.20        perf-stat.ps.cpu-migrations
   2436431            +3.2%    2513516        perf-stat.ps.dTLB-load-misses
 1.922e+09           -60.7%   7.56e+08        perf-stat.ps.dTLB-loads
 1.141e+09           -63.3%  4.188e+08        perf-stat.ps.dTLB-stores
 7.644e+09           -60.4%  3.028e+09        perf-stat.ps.instructions
      0.09 ± 68%     -93.8%       0.01 ±141%  perf-stat.ps.major-faults
    105526 ±  7%     +31.5%     138766 ±  5%  perf-stat.ps.node-load-misses
 4.798e+11           -61.5%   1.85e+11        perf-stat.total.instructions



***************************************************************************************************
lkp-csl-2sp7: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/ffs/debian-x86_64-phoronix/lkp-csl-2sp7/glibc-bench-1.6.1/phoronix-test-suite

commit: 
  a525b95417 ("cpufreq/amd-pstate: Remove fast_switch_possible flag from active driver")
  278dfbd17c ("cpufreq: Return failure if fast_switch is not set and fast_switch_possible is set")

a525b954173e74cd 278dfbd17c5d0767834471d7fea 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6          100%           6:6     kmsg.cpufreq:fast_switch_possible_is_enabled_but_fast_switch_callback_is_not_set
         %stddev     %change         %stddev
             \          |                \  
      2.57          +301.2%      10.31        phoronix-test-suite.glibc-bench.ffs.nanoseconds
     55.10           +23.5%      68.06        phoronix-test-suite.time.elapsed_time
     55.10           +23.5%      68.06        phoronix-test-suite.time.elapsed_time.max
    300.00 ± 14%    +398.7%       1496 ±  2%  phoronix-test-suite.time.involuntary_context_switches
     62.33           +12.0%      69.83        phoronix-test-suite.time.percent_of_cpu_this_job_got
      5.40          +110.3%      11.36        phoronix-test-suite.time.system_time
     29.22           +24.6%      36.42        phoronix-test-suite.time.user_time
 5.284e+09           +17.9%  6.228e+09        cpuidle..time
   5539887           +18.5%    6564240        cpuidle..usage
      7874           +26.6%       9970        meminfo.Active(anon)
    525422 ±  7%     -16.3%     439748 ± 11%  meminfo.DirectMap4k
    114.59 ±  4%     +19.2%     136.55 ±  7%  uptime.boot
     10125 ±  4%     +16.8%      11822 ±  6%  uptime.idle
      1414 ±  5%     -16.7%       1177 ±  6%  vmstat.io.bi
      1.00          +100.0%       2.00        vmstat.procs.r
      2577           +93.3%       4983        vmstat.system.cs
     95670            -3.3%      92477        vmstat.system.in
      0.06 ± 13%      -0.0        0.05 ± 18%  mpstat.cpu.all.iowait%
      1.73            +1.8        3.56        mpstat.cpu.all.irq%
      0.10 ±  5%      +0.1        0.21        mpstat.cpu.all.soft%
      0.18            +0.2        0.40        mpstat.cpu.all.sys%
      0.79            +1.1        1.87        mpstat.cpu.all.usr%
    155.96 ± 32%     -28.9%     110.84 ± 34%  sched_debug.cfs_rq:/.load_avg.stddev
     32174 ± 20%     -24.5%      24289 ±  9%  sched_debug.cfs_rq:/.min_vruntime.avg
     45718 ± 11%     +25.8%      57491 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
    244.32 ± 11%     -18.3%     199.54 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
     18560 ± 27%     +88.6%      34998 ±  7%  sched_debug.cfs_rq:/.spread0.max
    244.33 ± 11%     -18.3%     199.53 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
      3.37 ± 26%    +161.7%       8.82 ±  4%  sched_debug.cpu.clock.stddev
     35302           +20.5%      42534        sched_debug.cpu.clock_task.min
    149.18 ± 36%     +74.1%     259.73 ± 31%  sched_debug.cpu.curr->pid.avg
    530.50 ± 18%     +29.1%     684.71 ± 13%  sched_debug.cpu.curr->pid.stddev
     51821           +14.8%      59506        sched_debug.sched_clk
      1968           +26.6%       2492        proc-vmstat.nr_active_anon
    108779            -6.0%     102231        proc-vmstat.nr_anon_pages
    285189            -2.4%     278339        proc-vmstat.nr_inactive_anon
     52438            -1.6%      51613        proc-vmstat.nr_slab_unreclaimable
      1968           +26.6%       2492        proc-vmstat.nr_zone_active_anon
    285189            -2.4%     278339        proc-vmstat.nr_zone_inactive_anon
    445853            +9.3%     487223        proc-vmstat.numa_hit
    426867            +9.7%     468279        proc-vmstat.numa_local
    513203            +9.1%     560135        proc-vmstat.pgalloc_normal
    570191           +12.7%     642729        proc-vmstat.pgfault
    419473            +9.4%     458954        proc-vmstat.pgfree
     69487           +20.8%      83936        proc-vmstat.pgreuse
    595200           +21.5%     722944        proc-vmstat.unevictable_pgs_scanned
      4.38            +4.7        9.07        turbostat.Busy%
      1570           -55.4%     700.00        turbostat.Bzy_MHz
     75921 ± 10%     -37.6%      47362 ±  2%  turbostat.C1
      0.04 ± 21%      -0.0        0.02        turbostat.C1%
     56181 ± 20%    +172.3%     153009 ±  9%  turbostat.C1E
   5377888           +18.0%    6343412        turbostat.C6
     70.60           -20.2%      56.35        turbostat.CPU%c1
     25.02 ±  2%     +38.2%      34.58        turbostat.CPU%c6
     47.67           -21.3%      37.50        turbostat.CoreTmp
   5554932           +18.2%    6565797        turbostat.IRQ
     25793           -96.1%       1008 ± 14%  turbostat.POLL
     17.91 ±  4%     -70.0%       5.38 ±  4%  turbostat.Pkg%pc2
      3.66 ±  4%     -94.8%       0.19 ±  3%  turbostat.Pkg%pc6
     47.83 ±  2%     -20.6%      38.00        turbostat.PkgTmp
    116.41           -40.0%      69.85        turbostat.PkgWatt
    141.47            +1.4%     143.42        turbostat.RAMWatt
     18.20 ± 15%     -11.1        7.12 ± 56%  perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.20 ± 15%     -11.1        7.12 ± 56%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
     18.20 ± 15%     -11.1        7.12 ± 56%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
     18.20 ± 15%     -10.3        7.91 ± 60%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.20 ± 15%     -10.3        7.91 ± 60%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.24 ±107%      -4.4        0.79 ±223%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.24 ±107%      -4.4        0.79 ±223%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      3.86 ±100%      -3.9        0.00        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.24 ±107%      -3.8        1.39 ±143%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.24 ±107%      -3.8        1.39 ±143%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.53 ± 72%      -2.8        2.75 ±159%  perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write
      4.14 ±102%      -2.2        1.96 ±223%  perf-profile.calltrace.cycles-pp.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter
      4.14 ±102%      -1.4        2.75 ±159%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
     18.20 ± 15%     -11.1        7.12 ± 56%  perf-profile.children.cycles-pp.generic_file_write_iter
     18.20 ± 15%     -11.1        7.12 ± 56%  perf-profile.children.cycles-pp.__generic_file_write_iter
     18.20 ± 15%     -11.1        7.12 ± 56%  perf-profile.children.cycles-pp.generic_perform_write
     18.20 ± 15%     -10.3        7.91 ± 60%  perf-profile.children.cycles-pp.ksys_write
     18.20 ± 15%     -10.3        7.91 ± 60%  perf-profile.children.cycles-pp.vfs_write
      5.24 ±107%      -4.4        0.79 ±223%  perf-profile.children.cycles-pp.do_filp_open
      5.24 ±107%      -4.4        0.79 ±223%  perf-profile.children.cycles-pp.path_openat
      4.34 ±101%      -4.3        0.00        perf-profile.children.cycles-pp.do_vmi_align_munmap
      3.86 ±100%      -3.9        0.00        perf-profile.children.cycles-pp.__do_sys_brk
      5.24 ±107%      -3.8        1.39 ±143%  perf-profile.children.cycles-pp.__x64_sys_openat
      5.24 ±107%      -3.8        1.39 ±143%  perf-profile.children.cycles-pp.do_sys_openat2
      4.14 ±102%      -3.3        0.79 ±223%  perf-profile.children.cycles-pp.__alloc_pages
      5.53 ± 72%      -2.8        2.75 ±159%  perf-profile.children.cycles-pp.shmem_write_begin
      4.14 ±102%      -2.2        1.96 ±223%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_folio
      4.14 ±102%      -1.4        2.75 ±159%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      4.76 ±111%      -4.0        0.79 ±223%  perf-profile.self.cycles-pp.fault_in_readable
      3.77 ±100%      -3.2        0.60 ±223%  perf-profile.self.cycles-pp.zap_pte_range
     35.29            +6.2%      37.47        perf-stat.i.MPKI
 1.103e+09           -49.5%  5.566e+08        perf-stat.i.branch-instructions
      3.99            +1.8        5.80        perf-stat.i.branch-miss-rate%
  19937132           +51.2%   30154000        perf-stat.i.branch-misses
      4.48            -0.2        4.25        perf-stat.i.cache-miss-rate%
   2311967 ±  2%     +57.9%    3651013        perf-stat.i.cache-misses
  52356349           +63.0%   85336312        perf-stat.i.cache-references
      2132 ±  3%    +120.5%       4703        perf-stat.i.context-switches
      2.80           -17.2%       2.31        perf-stat.i.cpi
 5.652e+09            -5.3%  5.353e+09        perf-stat.i.cpu-cycles
      2808           -45.3%       1536        perf-stat.i.cycles-between-cache-misses
      0.39 ±  2%      +0.1        0.48        perf-stat.i.dTLB-load-miss-rate%
   1543223 ±  3%     +63.8%    2527374        perf-stat.i.dTLB-load-misses
 1.017e+09           -44.3%  5.669e+08        perf-stat.i.dTLB-loads
      0.07 ±  3%      +0.0        0.09        perf-stat.i.dTLB-store-miss-rate%
    152204 ±  4%     +54.3%     234914        perf-stat.i.dTLB-store-misses
 5.998e+08           -51.9%  2.885e+08        perf-stat.i.dTLB-stores
     72.30            +4.0       76.32        perf-stat.i.iTLB-load-miss-rate%
   1341052 ±  2%     -32.8%     901087        perf-stat.i.iTLB-load-misses
    487115 ±  2%     -42.8%     278743 ±  2%  perf-stat.i.iTLB-loads
 4.089e+09           -39.9%  2.455e+09        perf-stat.i.instructions
      3035           -10.0%       2730        perf-stat.i.instructions-per-iTLB-miss
      0.71           -36.1%       0.45        perf-stat.i.ipc
      3.27 ±  4%     -62.7%       1.22        perf-stat.i.major-faults
      0.06            -5.3%       0.06        perf-stat.i.metric.GHz
    690.67 ±  2%     +27.4%     879.69        perf-stat.i.metric.K/sec
     28.18           -47.8%      14.72        perf-stat.i.metric.M/sec
      6125            -6.1%       5749        perf-stat.i.minor-faults
     82.46            -6.4       76.09        perf-stat.i.node-load-miss-rate%
    116280 ±  5%     +25.1%     145514 ±  4%  perf-stat.i.node-load-misses
      6128            -6.2%       5751        perf-stat.i.page-faults
     12.82          +171.2%      34.76        perf-stat.overall.MPKI
      1.81            +3.6        5.42        perf-stat.overall.branch-miss-rate%
      4.41            -0.1        4.28        perf-stat.overall.cache-miss-rate%
      1.38           +57.6%       2.18        perf-stat.overall.cpi
      2445 ±  2%     -40.0%       1466        perf-stat.overall.cycles-between-cache-misses
      0.15 ±  3%      +0.3        0.44        perf-stat.overall.dTLB-load-miss-rate%
      0.03 ±  4%      +0.1        0.08        perf-stat.overall.dTLB-store-miss-rate%
     73.35            +3.0       76.38        perf-stat.overall.iTLB-load-miss-rate%
      3049 ±  2%     -10.6%       2725        perf-stat.overall.instructions-per-iTLB-miss
      0.72           -36.6%       0.46        perf-stat.overall.ipc
 1.082e+09           -49.4%   5.48e+08        perf-stat.ps.branch-instructions
  19556338           +51.8%   29688966        perf-stat.ps.branch-misses
   2269777 ±  2%     +58.4%    3594809        perf-stat.ps.cache-misses
  51414505           +63.4%   84023854        perf-stat.ps.cache-references
      2094 ±  3%    +121.1%       4630        perf-stat.ps.context-switches
 5.549e+09            -5.0%  5.271e+09        perf-stat.ps.cpu-cycles
   1515443 ±  3%     +64.2%    2488466        perf-stat.ps.dTLB-load-misses
 9.979e+08           -44.1%  5.582e+08        perf-stat.ps.dTLB-loads
    149490 ±  4%     +54.7%     231314        perf-stat.ps.dTLB-store-misses
 5.886e+08           -51.7%  2.841e+08        perf-stat.ps.dTLB-stores
   1316324 ±  2%     -32.6%     887291        perf-stat.ps.iTLB-load-misses
    478150 ±  2%     -42.6%     274431 ±  2%  perf-stat.ps.iTLB-loads
 4.012e+09           -39.7%  2.418e+09        perf-stat.ps.instructions
      3.20 ±  4%     -62.6%       1.20        perf-stat.ps.major-faults
      6015            -5.9%       5661        perf-stat.ps.minor-faults
    114133 ±  5%     +25.6%     143299 ±  4%  perf-stat.ps.node-load-misses
      6018            -5.9%       5662        perf-stat.ps.page-faults
 2.216e+11           -28.0%  1.596e+11        perf-stat.total.instructions



***************************************************************************************************
lkp-csl-2sp7: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/pthread_once/debian-x86_64-phoronix/lkp-csl-2sp7/glibc-bench-1.6.1/phoronix-test-suite

commit: 
  a525b95417 ("cpufreq/amd-pstate: Remove fast_switch_possible flag from active driver")
  278dfbd17c ("cpufreq: Return failure if fast_switch is not set and fast_switch_possible is set")

a525b954173e74cd 278dfbd17c5d0767834471d7fea 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6          100%           6:6     kmsg.cpufreq:fast_switch_possible_is_enabled_but_fast_switch_callback_is_not_set
         %stddev     %change         %stddev
             \          |                \  
      2.59          +300.8%      10.40        phoronix-test-suite.glibc-bench.pthread_once.nanoseconds
     55.71           +22.1%      68.01        phoronix-test-suite.time.elapsed_time
     55.71           +22.1%      68.01        phoronix-test-suite.time.elapsed_time.max
    317.17 ± 10%    +366.7%       1480 ±  2%  phoronix-test-suite.time.involuntary_context_switches
     61.67           +13.0%      69.67        phoronix-test-suite.time.percent_of_cpu_this_job_got
      5.29          +112.4%      11.24        phoronix-test-suite.time.system_time
     29.32           +24.3%      36.46        phoronix-test-suite.time.user_time
      8014 ±  3%     +24.5%       9980        meminfo.Active(anon)
     14023 ± 28%     -33.3%       9356 ± 44%  numa-vmstat.node1.nr_slab_reclaimable
 5.345e+09           +16.4%  6.223e+09        cpuidle..time
   5596240           +17.4%    6571074        cpuidle..usage
     56094 ± 28%     -33.3%      37426 ± 44%  numa-meminfo.node1.KReclaimable
     56094 ± 28%     -33.3%      37426 ± 44%  numa-meminfo.node1.SReclaimable
    125.08 ± 12%     +91.5%     239.55 ± 50%  uptime.boot
     11056 ± 11%     +86.0%      20560 ± 49%  uptime.idle
     66.42 ± 22%    +152.7%     167.84 ± 72%  boot-time.boot
     46.41 ± 31%    +206.2%     142.14 ± 85%  boot-time.dhcp
      5588 ± 23%    +152.3%      14100 ± 72%  boot-time.idle
      2.58 ± 45%    +307.1%      10.52 ± 98%  boot-time.smp_boot
      1511           -20.4%       1202 ±  5%  vmstat.io.bi
      1.00          +100.0%       2.00        vmstat.procs.r
      2580 ±  2%     +94.1%       5008        vmstat.system.cs
     95728            -3.3%      92603        vmstat.system.in
      0.06 ±  3%      -0.0        0.04 ±  3%  mpstat.cpu.all.iowait%
      1.70            +1.8        3.55        mpstat.cpu.all.irq%
      0.10 ±  4%      +0.1        0.21        mpstat.cpu.all.soft%
      0.18            +0.2        0.40        mpstat.cpu.all.sys%
      0.79            +1.1        1.89        mpstat.cpu.all.usr%
      2003 ±  3%     +24.6%       2495        proc-vmstat.nr_active_anon
    108638            -5.6%     102534        proc-vmstat.nr_anon_pages
    285043            -2.2%     278915        proc-vmstat.nr_inactive_anon
     52421            -1.5%      51635        proc-vmstat.nr_slab_unreclaimable
      2003 ±  3%     +24.6%       2495        proc-vmstat.nr_zone_active_anon
    285043            -2.2%     278915        proc-vmstat.nr_zone_inactive_anon
    459003            +6.8%     490091        proc-vmstat.numa_hit
    440043            +7.3%     472049        proc-vmstat.numa_local
    529679            +6.8%     565786        proc-vmstat.pgalloc_normal
    592060 ±  2%      +9.0%     645487        proc-vmstat.pgfault
    431573            +7.1%     462298        proc-vmstat.pgfree
     72771 ±  3%     +16.0%      84416        proc-vmstat.pgreuse
    609792 ±  2%     +18.5%     722688        proc-vmstat.unevictable_pgs_scanned
      4.31            +4.8        9.10        turbostat.Busy%
      1576           -55.6%     700.00        turbostat.Bzy_MHz
     61354 ± 14%     -22.8%      47384 ±  2%  turbostat.C1
     49691 ± 12%    +226.7%     162332 ±  3%  turbostat.C1E
      0.28 ±  2%      +0.0        0.32        turbostat.C1E%
   5437863           +16.4%    6329781        turbostat.C6
     70.92           -20.8%      56.16        turbostat.CPU%c1
     24.77           +40.3%      34.74        turbostat.CPU%c6
     47.00           -19.5%      37.83        turbostat.CoreTmp
   5596785           +17.2%    6561866        turbostat.IRQ
     25649           -96.9%     792.83 ±  7%  turbostat.POLL
     17.44 ±  4%     -64.5%       6.19 ± 27%  turbostat.Pkg%pc2
      3.73 ±  5%     -94.8%       0.20 ±  2%  turbostat.Pkg%pc6
     47.00           -18.1%      38.50        turbostat.PkgTmp
    116.45           -40.0%      69.92        turbostat.PkgWatt
    141.45            +1.4%     143.45        turbostat.RAMWatt
      0.07 ± 32%     +74.4%       0.13 ±  7%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.26 ± 13%     +29.7%       0.34 ±  3%  sched_debug.cfs_rq:/.h_nr_running.stddev
     34989 ± 16%     -29.9%      24543 ± 12%  sched_debug.cfs_rq:/.min_vruntime.avg
      0.07 ± 34%     +76.2%       0.13 ± 10%  sched_debug.cfs_rq:/.nr_running.avg
      0.26 ± 14%     +30.5%       0.33 ±  4%  sched_debug.cfs_rq:/.nr_running.stddev
     38.84 ± 25%     -83.8%       6.29 ±160%  sched_debug.cfs_rq:/.removed.load_avg.avg
    193.00 ± 13%     -78.0%      42.53 ±145%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     16.82 ± 21%     -84.4%       2.62 ±190%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    514.17           -78.2%     112.33 ±157%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     85.74 ± 10%     -81.2%      16.12 ±173%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     16.82 ± 21%     -84.4%       2.62 ±190%  sched_debug.cfs_rq:/.removed.util_avg.avg
    514.00           -78.2%     112.17 ±157%  sched_debug.cfs_rq:/.removed.util_avg.max
     85.73 ± 10%     -81.2%      16.11 ±173%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    205.16 ±  6%     -32.6%     138.25 ±  7%  sched_debug.cfs_rq:/.runnable_avg.avg
    250.68 ±  5%     -15.7%     211.41 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
     12358 ± 66%     -78.7%       2634 ±154%  sched_debug.cfs_rq:/.spread0.avg
    205.08 ±  6%     -32.7%     138.10 ±  7%  sched_debug.cfs_rq:/.util_avg.avg
    250.67 ±  5%     -15.7%     211.37 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
    760.17 ±  5%     -38.4%     468.33 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.max
    899715 ±  3%     +17.3%    1055048 ± 12%  sched_debug.cpu.avg_idle.avg
     68244 ± 21%    +149.7%     170398 ± 71%  sched_debug.cpu.clock.avg
     68250 ± 21%    +149.7%     170415 ± 71%  sched_debug.cpu.clock.max
     68235 ± 21%    +149.7%     170385 ± 71%  sched_debug.cpu.clock.min
      3.51 ± 13%    +140.4%       8.43 ±  9%  sched_debug.cpu.clock.stddev
     67132 ± 21%    +144.5%     164149 ± 70%  sched_debug.cpu.clock_task.avg
     67835 ± 21%    +147.7%     168044 ± 71%  sched_debug.cpu.clock_task.max
     35817           +19.1%      42655 ±  2%  sched_debug.cpu.clock_task.min
      3228 ± 46%    +287.0%      12494 ± 95%  sched_debug.cpu.clock_task.stddev
    133.56 ± 44%    +108.6%     278.63 ± 10%  sched_debug.cpu.curr->pid.avg
    502.90 ± 20%     +42.3%     715.86 ±  4%  sched_debug.cpu.curr->pid.stddev
      0.00 ± 13%    +135.2%       0.00 ± 29%  sched_debug.cpu.next_balance.stddev
      0.06 ± 41%    +111.1%       0.13 ± 11%  sched_debug.cpu.nr_running.avg
      0.24 ± 18%     +42.8%       0.34 ±  4%  sched_debug.cpu.nr_running.stddev
     68240 ± 21%    +149.7%     170386 ± 71%  sched_debug.cpu_clk
     67525 ± 21%    +151.3%     169670 ± 71%  sched_debug.ktime
     52331           +14.7%      60008        sched_debug.sched_clk
 1.263e+09           -52.8%  5.957e+08        perf-stat.i.branch-instructions
      3.93 ±  2%      +1.6        5.57        perf-stat.i.branch-miss-rate%
  19844846           +52.5%   30265786        perf-stat.i.branch-misses
      4.49            -0.2        4.27        perf-stat.i.cache-miss-rate%
   2283572           +59.1%    3633877        perf-stat.i.cache-misses
  52070252           +62.4%   84585057        perf-stat.i.cache-references
      2159 ±  2%    +117.9%       4705        perf-stat.i.context-switches
      2.70 ±  2%     -16.7%       2.25        perf-stat.i.cpi
 5.606e+09            -4.1%  5.374e+09        perf-stat.i.cpu-cycles
    101.91            -2.3%      99.54        perf-stat.i.cpu-migrations
      2804           -44.9%       1545        perf-stat.i.cycles-between-cache-misses
      0.37 ±  5%      +0.1        0.43        perf-stat.i.dTLB-load-miss-rate%
   1542705           +65.2%    2549066 ±  2%  perf-stat.i.dTLB-load-misses
 1.535e+09           -55.7%  6.799e+08        perf-stat.i.dTLB-loads
      0.07 ±  5%      +0.0        0.10 ±  3%  perf-stat.i.dTLB-store-miss-rate%
    152237 ±  3%     +59.7%     243190 ±  3%  perf-stat.i.dTLB-store-misses
 4.136e+08           -39.1%  2.517e+08        perf-stat.i.dTLB-stores
     71.73            +4.6       76.38        perf-stat.i.iTLB-load-miss-rate%
   1314924 ±  6%     -32.7%     884328        perf-stat.i.iTLB-load-misses
    493184           -44.6%     273276 ±  2%  perf-stat.i.iTLB-loads
 4.402e+09           -42.3%  2.542e+09        perf-stat.i.instructions
      3289 ±  4%     -12.6%       2873        perf-stat.i.instructions-per-iTLB-miss
      0.77           -39.2%       0.47        perf-stat.i.ipc
      3.16 ±  2%     -61.4%       1.22        perf-stat.i.major-faults
      0.06            -4.2%       0.06        perf-stat.i.metric.GHz
    697.29 ±  2%     +26.2%     880.12        perf-stat.i.metric.K/sec
     33.29           -52.2%      15.91        perf-stat.i.metric.M/sec
      6215 ±  3%      -7.1%       5771        perf-stat.i.minor-faults
     82.62            -6.8       75.78        perf-stat.i.node-load-miss-rate%
    117468 ±  6%     +24.2%     145903 ±  2%  perf-stat.i.node-load-misses
     49000 ±  6%     +22.0%      59761 ±  6%  perf-stat.i.node-loads
      6218 ±  3%      -7.2%       5772        perf-stat.i.page-faults
     11.84 ±  2%    +181.1%      33.29        perf-stat.overall.MPKI
      1.57            +3.5        5.08        perf-stat.overall.branch-miss-rate%
      1.27           +65.9%       2.11        perf-stat.overall.cpi
      2455           -39.8%       1479        perf-stat.overall.cycles-between-cache-misses
      0.10 ±  3%      +0.3        0.37        perf-stat.overall.dTLB-load-miss-rate%
      0.04 ±  4%      +0.1        0.10 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
     72.66            +3.7       76.40        perf-stat.overall.iTLB-load-miss-rate%
      3360 ±  6%     -14.5%       2874        perf-stat.overall.instructions-per-iTLB-miss
      0.78           -39.7%       0.47        perf-stat.overall.ipc
  1.24e+09           -52.7%  5.865e+08        perf-stat.ps.branch-instructions
  19487700           +52.9%   29789495        perf-stat.ps.branch-misses
   2242413           +59.5%    3577319        perf-stat.ps.cache-misses
  51143893           +62.8%   83278509        perf-stat.ps.cache-references
      2120 ±  2%    +118.4%       4632        perf-stat.ps.context-switches
 5.505e+09            -3.9%  5.291e+09        perf-stat.ps.cpu-cycles
    100.07            -2.1%      98.01        perf-stat.ps.cpu-migrations
   1515252           +65.6%    2509672 ±  2%  perf-stat.ps.dTLB-load-misses
 1.506e+09           -55.6%  6.693e+08        perf-stat.ps.dTLB-loads
    149535 ±  3%     +60.1%     239445 ±  3%  perf-stat.ps.dTLB-store-misses
  4.06e+08           -39.0%  2.478e+08        perf-stat.ps.dTLB-stores
   1290945 ±  6%     -32.5%     870773        perf-stat.ps.iTLB-load-misses
    484246           -44.4%     269019 ±  2%  perf-stat.ps.iTLB-loads
  4.32e+09           -42.1%  2.502e+09        perf-stat.ps.instructions
      3.10 ±  2%     -61.2%       1.20        perf-stat.ps.major-faults
      6104 ±  3%      -6.9%       5681        perf-stat.ps.minor-faults
    115360 ±  6%     +24.5%     143643 ±  2%  perf-stat.ps.node-load-misses
     48119 ±  7%     +22.3%      58833 ±  6%  perf-stat.ps.node-loads
      6107 ±  3%      -6.9%       5683        perf-stat.ps.page-faults
 2.422e+11           -32.0%  1.646e+11        perf-stat.total.instructions
     12.90 ± 35%      -9.8        3.08 ± 72%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     11.79 ± 43%      -9.6        2.16 ±100%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
     11.79 ± 43%      -9.6        2.16 ±100%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      8.19 ± 58%      -6.6        1.59 ±144%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      6.66 ±133%      -6.0        0.70 ±223%  perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.62 ±121%      -4.9        0.70 ±223%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.62 ±121%      -4.9        0.70 ±223%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.38 ±109%      -4.7        0.67 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.38 ±109%      -4.7        0.67 ±223%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.38 ±109%      -4.7        0.67 ±223%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.58 ±108%      -4.6        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable
      5.84 ± 88%      -4.3        1.59 ±144%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4.24 ±115%      -4.2        0.00        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.24 ±115%      -4.2        0.00        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.24 ±115%      -4.2        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.11 ±108%      -4.1        0.00        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      4.11 ±108%      -4.1        0.00        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      4.11 ±108%      -4.1        0.00        perf-profile.calltrace.cycles-pp.__do_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      4.58 ±108%      -3.8        0.79 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write
      4.58 ±108%      -3.8        0.79 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable
      3.13 ±100%      -3.1        0.00        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3.13 ±100%      -3.1        0.00        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      3.13 ±100%      -3.1        0.00        perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      3.21 ±100%      -2.5        0.67 ±223%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      3.21 ±100%      -2.5        0.67 ±223%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      3.82 ±101%      -2.4        1.46 ±142%  perf-profile.calltrace.cycles-pp.rep_movs_alternative.copyin.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter
      3.82 ±101%      -2.4        1.46 ±142%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00            +8.4        8.42 ± 42%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +8.4        8.42 ± 42%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
      0.00           +10.3       10.30 ± 57%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +10.3       10.30 ± 57%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.85 ± 40%     -12.7        2.16 ±100%  perf-profile.children.cycles-pp.unmap_vmas
     13.94 ± 25%     -10.9        3.08 ± 72%  perf-profile.children.cycles-pp.__mmput
     13.94 ± 25%     -10.9        3.08 ± 72%  perf-profile.children.cycles-pp.exit_mmap
     12.83 ± 34%     -10.7        2.16 ±100%  perf-profile.children.cycles-pp.unmap_page_range
     12.90 ± 35%      -9.8        3.08 ± 72%  perf-profile.children.cycles-pp.exit_mm
     10.42 ± 29%      -8.8        1.59 ±144%  perf-profile.children.cycles-pp.handle_mm_fault
     11.71 ± 47%      -8.4        3.31 ± 72%  perf-profile.children.cycles-pp.exc_page_fault
     11.71 ± 47%      -8.4        3.31 ± 72%  perf-profile.children.cycles-pp.do_user_addr_fault
      8.19 ± 58%      -6.6        1.59 ±144%  perf-profile.children.cycles-pp.__handle_mm_fault
      6.66 ±133%      -6.0        0.70 ±223%  perf-profile.children.cycles-pp.__do_sys_brk
      6.66 ±133%      -6.0        0.70 ±223%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      6.66 ±133%      -6.0        0.70 ±223%  perf-profile.children.cycles-pp.unmap_region
      5.38 ±109%      -4.7        0.67 ±223%  perf-profile.children.cycles-pp.__x64_sys_execve
      5.38 ±109%      -4.7        0.67 ±223%  perf-profile.children.cycles-pp.do_execveat_common
      5.38 ±109%      -4.7        0.67 ±223%  perf-profile.children.cycles-pp.bprm_execve
      4.24 ±115%      -4.2        0.00        perf-profile.children.cycles-pp.__x64_sys_exit_group
      4.11 ±108%      -4.1        0.00        perf-profile.children.cycles-pp.do_fault
      4.11 ±108%      -4.1        0.00        perf-profile.children.cycles-pp.do_read_fault
      4.11 ±108%      -4.1        0.00        perf-profile.children.cycles-pp.__do_fault
      3.13 ±100%      -3.1        0.00        perf-profile.children.cycles-pp.page_remove_rmap
      4.89 ± 73%      -2.7        2.18 ±149%  perf-profile.children.cycles-pp.__alloc_pages
      3.21 ±100%      -2.5        0.67 ±223%  perf-profile.children.cycles-pp.exec_binprm
      3.21 ±100%      -2.5        0.67 ±223%  perf-profile.children.cycles-pp.search_binary_handler
      3.82 ±101%      -2.4        1.46 ±142%  perf-profile.children.cycles-pp.rep_movs_alternative
      3.82 ±101%      -2.4        1.46 ±142%  perf-profile.children.cycles-pp.copyin
      0.00            +8.4        8.42 ± 42%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.00            +8.4        8.42 ± 42%  perf-profile.children.cycles-pp.seq_read_iter
      0.00           +10.3       10.30 ± 57%  perf-profile.children.cycles-pp.ksys_read
      0.00           +10.3       10.30 ± 57%  perf-profile.children.cycles-pp.vfs_read
      3.54 ±104%      -2.8        0.70 ±223%  perf-profile.self.cycles-pp.zap_pte_range
      3.82 ±101%      -2.4        1.46 ±142%  perf-profile.self.cycles-pp.rep_movs_alternative



***************************************************************************************************
lkp-csl-2sp7: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/3/debian-x86_64-phoronix/lkp-csl-2sp7/cyclictest-1.0.0/phoronix-test-suite

commit: 
  a525b95417 ("cpufreq/amd-pstate: Remove fast_switch_possible flag from active driver")
  278dfbd17c ("cpufreq: Return failure if fast_switch is not set and fast_switch_possible is set")

a525b954173e74cd 278dfbd17c5d0767834471d7fea 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6          100%           6:6     kmsg.cpufreq:fast_switch_possible_is_enabled_but_fast_switch_callback_is_not_set
         %stddev     %change         %stddev
             \          |                \  
      1.00         +5550.0%      56.50 ± 90%  phoronix-test-suite.cyclictest.clock_nanosleepTIME_ABSTIME,Interval500ms,100000Loops.ms_average
     67.47           +12.4%      75.83        phoronix-test-suite.time.elapsed_time
     67.47           +12.4%      75.83        phoronix-test-suite.time.elapsed_time.max
    228.83 ± 13%    +555.6%       1500 ±  3%  phoronix-test-suite.time.involuntary_context_switches
      5.00          +270.0%      18.50 ±  2%  phoronix-test-suite.time.percent_of_cpu_this_job_got
 2.229e+08           -28.7%  1.588e+08        cpuidle..usage
      8121 ±  3%     +24.7%      10129        meminfo.Active(anon)
      1244           -14.1%       1069 ±  3%  vmstat.io.bi
      0.00       +1.3e+102%       1.33 ± 35%  vmstat.procs.r
      5430           +39.5%       7576        vmstat.system.cs
     97212            -3.0%      94332        vmstat.system.in
      0.05 ±  2%      -0.0        0.04 ±  5%  mpstat.cpu.all.iowait%
      0.90 ±  2%      +1.6        2.47        mpstat.cpu.all.irq%
      0.05 ±  3%      +0.1        0.16 ±  2%  mpstat.cpu.all.soft%
      0.10            +0.2        0.34 ±  2%  mpstat.cpu.all.sys%
      0.23            +1.1        1.36        mpstat.cpu.all.usr%
      2030 ±  3%     +24.7%       2531        proc-vmstat.nr_active_anon
    108456            -4.6%     103460        proc-vmstat.nr_anon_pages
    284847            -1.8%     279599        proc-vmstat.nr_inactive_anon
     52453            -1.2%      51832        proc-vmstat.nr_slab_unreclaimable
      2030 ±  3%     +24.7%       2531        proc-vmstat.nr_zone_active_anon
    284847            -1.8%     279599        proc-vmstat.nr_zone_inactive_anon
    474897            +6.5%     505695        proc-vmstat.numa_hit
    457187            +6.5%     486800        proc-vmstat.numa_local
    551902 ±  2%      +4.8%     578226        proc-vmstat.pgalloc_normal
    615780            +9.0%     671086        proc-vmstat.pgfault
    456513 ±  2%      +4.3%     476256        proc-vmstat.pgfree
     77912           +13.6%      88541 ±  2%  proc-vmstat.pgreuse
    667136           +12.5%     750208        proc-vmstat.unevictable_pgs_scanned
      2033           -77.0%     467.83        turbostat.Avg_MHz
      2778           -74.8%     700.00        turbostat.Bzy_MHz
     65709 ± 14%     -61.7%      25182 ±  8%  turbostat.C1
      0.02 ± 20%      -0.0        0.01        turbostat.C1%
     31391 ± 20%    +190.6%      91233 ±  7%  turbostat.C1E
   1797823 ±  4%     +31.5%    2364347        turbostat.C6
     26.41 ±  3%      +5.9       32.32        turbostat.C6%
      7.08 ±  6%     +87.7%      13.30        turbostat.CPU%c6
     58.00 ±  2%     -31.3%      39.83        turbostat.CoreTmp
  2.21e+08           -29.3%  1.563e+08        turbostat.POLL
     71.21           -10.2       60.97        turbostat.POLL%
      3.92 ±  4%     -45.7%       2.12 ±  7%  turbostat.Pkg%pc2
      1.58 ± 10%     -88.7%       0.18 ±  6%  turbostat.Pkg%pc6
     57.83 ±  3%     -30.5%      40.17        turbostat.PkgTmp
    223.68           -63.4%      81.80        turbostat.PkgWatt
      3459 ± 34%     +45.1%       5020 ± 11%  sched_debug.cfs_rq:/.load.avg
     10426 ± 20%     +36.6%      14243 ±  5%  sched_debug.cfs_rq:/.load.stddev
     62.38 ± 31%     -59.0%      25.56 ± 30%  sched_debug.cfs_rq:/.load_avg.avg
    212.19 ± 22%     -50.5%     104.97 ± 34%  sched_debug.cfs_rq:/.load_avg.stddev
     42608 ± 18%     +36.6%      58197 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
      4070 ± 12%     +28.5%       5231 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
     45.18 ± 45%     -77.5%      10.16 ± 58%  sched_debug.cfs_rq:/.removed.load_avg.avg
    200.73 ± 25%     -55.6%      89.17 ± 48%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     19.50 ± 44%     -74.2%       5.03 ± 58%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     88.18 ± 24%     -50.0%      44.09 ± 48%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     19.50 ± 44%     -74.2%       5.02 ± 58%  sched_debug.cfs_rq:/.removed.util_avg.avg
     88.18 ± 24%     -50.0%      44.07 ± 48%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    199.68 ±  9%     -32.3%     135.14 ± 10%  sched_debug.cfs_rq:/.runnable_avg.avg
    246.87 ±  5%     -16.2%     206.81 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
      4075 ± 13%     +28.6%       5239 ±  3%  sched_debug.cfs_rq:/.spread0.stddev
    199.62 ±  9%     -32.4%     135.03 ± 10%  sched_debug.cfs_rq:/.util_avg.avg
    246.86 ±  5%     -16.2%     206.77 ±  7%  sched_debug.cfs_rq:/.util_avg.stddev
    812.67 ± 12%     -45.7%     441.00 ± 17%  sched_debug.cfs_rq:/.util_est_enqueued.max
    101.76 ± 19%     -31.7%      69.51 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      4205 ± 45%    +167.9%      11264 ± 12%  sched_debug.cpu.avg_idle.min
      3.54 ± 29%    +152.9%       8.96 ± 17%  sched_debug.cpu.clock.stddev
     35726           +19.2%      42576 ±  2%  sched_debug.cpu.clock_task.min
     52210           +14.9%      60013        sched_debug.sched_clk
      5.54 ± 76%      -5.5        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.54 ± 76%      -5.5        0.00        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.54 ± 76%      -5.5        0.00        perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.54 ± 76%      -5.5        0.00        perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      5.54 ± 76%      -5.5        0.00        perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      4.43 ±105%      -4.4        0.00        perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      4.80 ± 73%      -3.2        1.55 ±141%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +5.6        5.63 ± 28%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
      0.00            +5.6        5.63 ± 28%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.00            +5.6        5.63 ± 28%  perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
      0.00            +5.6        5.63 ± 28%  perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
      4.80 ± 73%      +5.7       10.50 ± 15%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.80 ± 73%      +5.7       10.50 ± 15%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.80 ± 73%      +5.7       10.50 ± 15%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      4.80 ± 73%      +5.7       10.50 ± 15%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      4.80 ± 73%      +5.7       10.50 ± 15%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
      4.80 ± 73%      +5.7       10.50 ± 15%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      6.08 ± 47%      +7.5       13.60 ± 27%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     33.77 ± 15%     +11.1       44.92 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     32.84 ± 17%     +12.1       44.92 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     32.84 ± 17%     +13.0       45.84 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     33.77 ± 15%     +13.9       47.65 ±  3%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     32.84 ± 17%     +14.8       47.65 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     32.84 ± 17%     +14.8       47.65 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     32.84 ± 17%     +14.8       47.65 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.98 ±108%      -6.0        0.00        perf-profile.children.cycles-pp.inode_permission
      5.54 ± 76%      -5.5        0.00        perf-profile.children.cycles-pp.__x64_sys_execve
      5.54 ± 76%      -5.5        0.00        perf-profile.children.cycles-pp.do_execveat_common
      5.54 ± 76%      -5.5        0.00        perf-profile.children.cycles-pp.bprm_execve
      5.54 ± 76%      -5.5        0.00        perf-profile.children.cycles-pp.exec_binprm
      5.54 ± 76%      -5.5        0.00        perf-profile.children.cycles-pp.search_binary_handler
      4.86 ±115%      -4.9        0.00        perf-profile.children.cycles-pp.override_creds
      4.43 ±105%      -4.4        0.00        perf-profile.children.cycles-pp.load_elf_binary
      4.80 ± 73%      -3.2        1.55 ±141%  perf-profile.children.cycles-pp.page_remove_rmap
      0.00            +5.6        5.63 ± 28%  perf-profile.children.cycles-pp.perf_release
      0.00            +5.6        5.63 ± 28%  perf-profile.children.cycles-pp.perf_event_release_kernel
      4.80 ± 73%      +5.7       10.50 ± 15%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      4.80 ± 73%      +5.7       10.50 ± 15%  perf-profile.children.cycles-pp.get_signal
      4.80 ± 73%      +6.6       11.42 ± 24%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      4.80 ± 73%      +6.6       11.42 ± 24%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      6.08 ± 47%      +7.5       13.60 ± 27%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     33.77 ± 15%     +11.2       44.92 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter
     33.77 ± 15%     +11.2       44.92 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter_state
     33.77 ± 15%     +12.1       45.84 ±  5%  perf-profile.children.cycles-pp.cpuidle_idle_call
     33.77 ± 15%     +13.9       47.65 ±  3%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     33.77 ± 15%     +13.9       47.65 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
     33.77 ± 15%     +13.9       47.65 ±  3%  perf-profile.children.cycles-pp.do_idle
     32.84 ± 17%     +14.8       47.65 ±  3%  perf-profile.children.cycles-pp.start_secondary
      7.64 ±120%      -6.9        0.76 ±223%  perf-profile.self.cycles-pp.fault_in_readable
      4.86 ±115%      -4.9        0.00        perf-profile.self.cycles-pp.override_creds
      4.94 ±130%      -3.4        1.52 ±223%  perf-profile.self.cycles-pp.show_interrupts
 9.155e+09           -71.5%   2.61e+09        perf-stat.i.branch-instructions
      1.97 ±  7%      +0.5        2.48        perf-stat.i.branch-miss-rate%
  37281940           -28.1%   26816122        perf-stat.i.branch-misses
      9.37 ±  2%      -1.2        8.20 ±  3%  perf-stat.i.cache-miss-rate%
   1168532 ±  3%     +56.3%    1826809        perf-stat.i.cache-misses
  18204626 ±  6%     +74.1%   31696003        perf-stat.i.cache-references
      5294           +41.2%       7477        perf-stat.i.context-switches
      6.21           -29.6%       4.37        perf-stat.i.cpi
 2.021e+11           -76.6%  4.725e+10        perf-stat.i.cpu-cycles
    576582 ±  3%     -84.5%      89226 ±  3%  perf-stat.i.cycles-between-cache-misses
    462899 ±  6%     +85.2%     857410 ±  2%  perf-stat.i.dTLB-load-misses
 5.539e+09           -64.5%  1.966e+09        perf-stat.i.dTLB-loads
     58476 ±  5%     +58.1%      92464 ±  3%  perf-stat.i.dTLB-store-misses
 8.442e+08           -29.3%  5.971e+08        perf-stat.i.dTLB-stores
     88.97            -6.7       82.29        perf-stat.i.iTLB-load-miss-rate%
    151482 ±  2%     +37.7%     208592 ±  2%  perf-stat.i.iTLB-loads
 2.974e+10           -68.2%  9.452e+09        perf-stat.i.instructions
     30509 ±  2%     -67.6%       9882 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.23           +17.4%       0.28        perf-stat.i.ipc
      2.72 ±  5%     -55.9%       1.20 ±  4%  perf-stat.i.major-faults
      2.11           -76.6%       0.49        perf-stat.i.metric.GHz
    243.40 ± 10%     +37.5%     334.64        perf-stat.i.metric.K/sec
    161.80           -66.7%      53.88        perf-stat.i.metric.M/sec
     83.31            -3.2       80.11        perf-stat.i.node-load-miss-rate%
    106552 ±  5%     +32.3%     140953 ±  7%  perf-stat.i.node-load-misses
     43996 ± 11%     +16.0%      51045 ±  2%  perf-stat.i.node-loads
     59564 ±  5%     +16.5%      69365 ±  8%  perf-stat.i.node-store-misses
      0.62 ±  7%    +447.4%       3.37 ±  2%  perf-stat.overall.MPKI
      0.41            +0.6        1.03        perf-stat.overall.branch-miss-rate%
      6.43 ±  4%      -0.7        5.76 ±  2%  perf-stat.overall.cache-miss-rate%
      6.80           -26.5%       5.00        perf-stat.overall.cpi
    172717 ±  4%     -85.1%      25771        perf-stat.overall.cycles-between-cache-misses
      0.01 ±  7%      +0.0        0.04        perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  6%      +0.0        0.02 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
     86.59            -4.6       82.02        perf-stat.overall.iTLB-load-miss-rate%
     30298           -67.3%       9918        perf-stat.overall.instructions-per-iTLB-miss
      0.15           +36.0%       0.20        perf-stat.overall.ipc
     56.74 ±  5%      +6.0       62.77 ±  4%  perf-stat.overall.node-store-miss-rate%
 9.009e+09           -71.5%  2.571e+09        perf-stat.ps.branch-instructions
  36711771           -27.9%   26457021        perf-stat.ps.branch-misses
   1153423 ±  3%     +56.6%    1806281        perf-stat.ps.cache-misses
  17988261 ±  6%     +74.3%   31357377        perf-stat.ps.cache-references
      5212           +41.4%       7371        perf-stat.ps.context-switches
 1.989e+11           -76.6%  4.653e+10        perf-stat.ps.cpu-cycles
    457693 ±  6%     +85.4%     848579 ±  2%  perf-stat.ps.dTLB-load-misses
 5.451e+09           -64.5%  1.937e+09        perf-stat.ps.dTLB-loads
     57782 ±  5%     +58.3%      91486 ±  3%  perf-stat.ps.dTLB-store-misses
  8.31e+08           -29.2%  5.884e+08        perf-stat.ps.dTLB-stores
    149554 ±  2%     +37.7%     205884 ±  2%  perf-stat.ps.iTLB-loads
 2.926e+10           -68.2%   9.31e+09        perf-stat.ps.instructions
      2.68 ±  5%     -55.8%       1.19 ±  4%  perf-stat.ps.major-faults
    105070 ±  5%     +32.5%     139219 ±  7%  perf-stat.ps.node-load-misses
     43441 ± 11%     +16.2%      50497 ±  2%  perf-stat.ps.node-loads
     58710 ±  5%     +16.6%      68472 ±  8%  perf-stat.ps.node-store-misses
 1.984e+12           -65.3%  6.875e+11        perf-stat.total.instructions



***************************************************************************************************
lkp-cfl-e1: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/Medium/debian-x86_64-phoronix/lkp-cfl-e1/astcenc-1.1.0/phoronix-test-suite

commit: 
  a525b95417 ("cpufreq/amd-pstate: Remove fast_switch_possible flag from active driver")
  278dfbd17c ("cpufreq: Return failure if fast_switch is not set and fast_switch_possible is set")

a525b954173e74cd 278dfbd17c5d0767834471d7fea 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6          100%           6:6     kmsg.cpufreq:fast_switch_possible_is_enabled_but_fast_switch_callback_is_not_set
         %stddev     %change         %stddev
             \          |                \  
      6.51          +106.6%      13.45        phoronix-test-suite.astcenc.Medium.seconds
     41.10          +223.2%     132.82        phoronix-test-suite.time.elapsed_time
     41.10          +223.2%     132.82        phoronix-test-suite.time.elapsed_time.max
      1674         +1056.2%      19360 ±  6%  phoronix-test-suite.time.involuntary_context_switches
    236.67           +56.9%     371.33        phoronix-test-suite.time.percent_of_cpu_this_job_got
     96.53          +406.6%     489.06        phoronix-test-suite.time.user_time
 5.719e+08          +161.8%  1.497e+09        cpuidle..time
    609347          +172.7%    1661621        cpuidle..usage
      6795           +16.3%       7902        meminfo.Active(anon)
    197921 ±  7%     +73.9%     344256 ±  2%  meminfo.AnonHugePages
    469519           +19.9%     562889        meminfo.AnonPages
     82.86           -12.8       70.05        mpstat.cpu.all.idle%
      0.72 ± 76%      -0.6        0.14 ±  4%  mpstat.cpu.all.iowait%
      0.63            +2.3        2.94        mpstat.cpu.all.irq%
      0.04 ± 11%      +0.1        0.16 ±  3%  mpstat.cpu.all.soft%
      0.43 ±  2%      +0.3        0.70        mpstat.cpu.all.sys%
     15.32           +10.7       26.00        mpstat.cpu.all.usr%
     82.83           -15.5%      70.00        vmstat.cpu.id
     14.00           +78.6%      25.00        vmstat.cpu.us
      2578 ± 12%     -70.2%     769.17 ±  2%  vmstat.io.bi
      2.00          +100.0%       4.00        vmstat.procs.r
      1565           +26.7%       1984        vmstat.system.cs
     15803            +4.2%      16461        vmstat.system.in
      1698           +16.3%       1976        proc-vmstat.nr_active_anon
     28204            +6.8%      30122        proc-vmstat.nr_active_file
    117478           +19.9%     140853        proc-vmstat.nr_anon_pages
     96.33 ±  7%     +74.2%     167.83 ±  2%  proc-vmstat.nr_anon_transparent_hugepages
    296875            +8.1%     320871        proc-vmstat.nr_inactive_anon
      6598            +2.5%       6764        proc-vmstat.nr_kernel_stack
     18110            +1.2%      18332        proc-vmstat.nr_mapped
      1365            +7.0%       1460        proc-vmstat.nr_page_table_pages
     15776            -1.9%      15472        proc-vmstat.nr_slab_unreclaimable
      1698           +16.3%       1976        proc-vmstat.nr_zone_active_anon
     28204            +6.8%      30122        proc-vmstat.nr_zone_active_file
    296875            +8.1%     320871        proc-vmstat.nr_zone_inactive_anon
    290802 ±  2%     +40.6%     408922        proc-vmstat.numa_hit
    290802 ±  2%     +40.7%     409089        proc-vmstat.numa_local
     18530            +4.7%      19409        proc-vmstat.pgactivate
    828771           +17.9%     976790        proc-vmstat.pgalloc_normal
    338161 ±  3%     +56.3%     528417        proc-vmstat.pgfault
    770641           +19.0%     917408        proc-vmstat.pgfree
     31372 ±  3%    +108.5%      65408        proc-vmstat.pgreuse
    465920          +150.6%    1167488        proc-vmstat.unevictable_pgs_scanned
     60.29           +56.9%      94.59        turbostat.Any%C0
    679.67           -63.6%     247.50        turbostat.Avg_MHz
     16.46           +14.5       30.92        turbostat.Busy%
      4144           -80.7%     800.00        turbostat.Bzy_MHz
      1700 ± 20%   +1986.3%      35467 ±  4%  turbostat.C1
      0.01            +0.0        0.02 ± 20%  turbostat.C1%
      0.06 ± 11%      -0.0        0.04 ± 23%  turbostat.C10%
      5370 ± 23%    +492.7%      31828 ±  2%  turbostat.C1E
      0.24 ± 52%      -0.1        0.13 ±  3%  turbostat.C1E%
      0.55 ± 72%      -0.4        0.13 ±  2%  turbostat.C3%
    327658          +127.0%     743779        turbostat.C6
     45.83           -13.8       32.04        turbostat.C6%
    253362          +229.7%     835400        turbostat.C8
     15.34           -15.9%      12.89        turbostat.CPU%c1
      0.83 ± 66%     -77.9%       0.18 ±  4%  turbostat.CPU%c3
     26.89           -37.2%      16.88        turbostat.CPU%c7
     28.37           -90.5%       2.69        turbostat.CorWatt
     55.00 ±  2%     -44.8%      30.33        turbostat.CoreTmp
    697284          +220.7%    2236189        turbostat.IRQ
     11573 ±  3%     -88.6%       1320 ± 14%  turbostat.POLL
      6.93           -92.2%       0.54 ± 13%  turbostat.Pkg%pc2
     21.26 ±  2%     -78.8%       4.51        turbostat.Pkg%pc3
     54.50 ±  2%     -42.8%      31.17        turbostat.PkgTmp
     28.82           -89.0%       3.17        turbostat.PkgWatt
    166.20           +92.8%     320.39        turbostat.Totl%C0
     33915 ± 16%    +104.7%      69438 ± 21%  sched_debug.cfs_rq:/.load.avg
    127082 ±  5%    +189.1%     367447 ± 47%  sched_debug.cfs_rq:/.load.max
     43893 ±  8%    +167.8%     117549 ± 33%  sched_debug.cfs_rq:/.load.stddev
    210.50 ± 31%     -53.3%      98.31 ± 17%  sched_debug.cfs_rq:/.load_avg.avg
      1208 ± 20%     -52.4%     575.11 ± 40%  sched_debug.cfs_rq:/.load_avg.max
     19.17 ± 50%     -77.8%       4.25 ± 67%  sched_debug.cfs_rq:/.load_avg.min
    321.23 ± 29%     -48.4%     165.60 ± 34%  sched_debug.cfs_rq:/.load_avg.stddev
      9895 ± 32%   +1532.2%     161504 ± 38%  sched_debug.cfs_rq:/.min_vruntime.avg
     16191 ± 22%   +1115.3%     196783 ± 35%  sched_debug.cfs_rq:/.min_vruntime.max
      5611 ± 19%   +2491.5%     145426 ± 40%  sched_debug.cfs_rq:/.min_vruntime.min
      2882 ± 24%    +363.4%      13357 ± 29%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.49           -14.9%       0.42 ±  8%  sched_debug.cfs_rq:/.nr_running.stddev
    735.49 ±  9%     -53.0%     345.89 ± 11%  sched_debug.cfs_rq:/.runnable_avg.avg
    214.50 ± 66%     -71.7%      60.78 ± 31%  sched_debug.cfs_rq:/.runnable_avg.min
      3969 ± 83%    +985.0%      43070 ± 53%  sched_debug.cfs_rq:/.spread0.max
      2884 ± 24%    +363.2%      13358 ± 29%  sched_debug.cfs_rq:/.spread0.stddev
    705.35 ±  9%     -52.8%     333.26 ± 11%  sched_debug.cfs_rq:/.util_avg.avg
     70.43 ± 11%     -27.1%      51.31 ± 29%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    790.50           -57.0%     340.19 ± 44%  sched_debug.cfs_rq:/.util_est_enqueued.max
    195.01           -50.4%      96.73 ± 35%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    550906 ± 19%     +47.6%     813196 ±  9%  sched_debug.cpu.avg_idle.avg
     35231          +137.2%      83557 ± 17%  sched_debug.cpu.clock_task.min
    485.08 ± 14%     +27.4%     617.87 ±  9%  sched_debug.cpu.curr->pid.avg
      1171           +97.3%       2311 ± 12%  sched_debug.cpu.curr->pid.max
    526.49 ±  2%     +54.7%     814.24 ± 12%  sched_debug.cpu.curr->pid.stddev
      4635 ±  2%    +128.9%      10611 ± 17%  sched_debug.cpu.nr_switches.avg
     10915 ± 18%     +90.5%      20797 ± 13%  sched_debug.cpu.nr_switches.max
      1339 ± 19%    +195.5%       3959 ± 27%  sched_debug.cpu.nr_switches.min
      2524 ± 10%     +89.8%       4792 ± 22%  sched_debug.cpu.nr_switches.stddev
     44326          +112.3%      94104 ± 16%  sched_debug.sched_clk
     87.63 ±  5%     -56.1%      38.49        perf-stat.i.MPKI
 1.616e+09           -64.6%  5.725e+08        perf-stat.i.branch-instructions
      5.71 ±  3%      -1.1        4.59        perf-stat.i.branch-miss-rate%
  64667069           -61.2%   25072928        perf-stat.i.branch-misses
      7.54            -1.1        6.47        perf-stat.i.cache-miss-rate%
   6852594           -46.7%    3654271        perf-stat.i.cache-misses
 4.577e+08           -63.0%  1.691e+08        perf-stat.i.cache-references
      1350           +40.7%       1899        perf-stat.i.context-switches
      2.07 ±  4%     -53.8%       0.96        perf-stat.i.cpi
 1.103e+10           -65.4%   3.82e+09        perf-stat.i.cpu-cycles
     29.77 ±  2%     +10.2%      32.81        perf-stat.i.cpu-migrations
      2461 ±  3%     -31.9%       1675        perf-stat.i.cycles-between-cache-misses
      0.39 ±  8%      -0.2        0.15 ±  8%  perf-stat.i.dTLB-load-miss-rate%
    804093 ± 10%     -37.4%     503607 ±  8%  perf-stat.i.dTLB-load-misses
 3.753e+09           -67.1%  1.236e+09        perf-stat.i.dTLB-loads
      0.07 ±  4%      -0.0        0.05 ± 13%  perf-stat.i.dTLB-store-miss-rate%
     74383 ±  2%     -25.9%      55137 ±  9%  perf-stat.i.dTLB-store-misses
 1.026e+09           -65.9%  3.495e+08        perf-stat.i.dTLB-stores
     73.52            -3.8       69.74        perf-stat.i.iTLB-load-miss-rate%
    190642 ±  3%     -15.4%     161312        perf-stat.i.iTLB-load-misses
  1.33e+10           -66.3%  4.476e+09        perf-stat.i.instructions
    107118 ± 17%     -67.2%      35109 ±  5%  perf-stat.i.instructions-per-iTLB-miss
      1.01           +18.4%       1.19        perf-stat.i.ipc
      4.27 ±  2%     -70.3%       1.27        perf-stat.i.major-faults
      0.14 ±  8%    -100.0%       0.00        perf-stat.i.metric.G/sec
      0.69           -65.3%       0.24        perf-stat.i.metric.GHz
    151.41 ± 21%     -73.9%      39.59 ±  2%  perf-stat.i.metric.K/sec
    284.19 ±  4%     -48.8%     145.40        perf-stat.i.metric.M/sec
      6118 ±  4%     -42.6%       3513        perf-stat.i.minor-faults
      1.09 ± 21%     -58.2%       0.46 ± 33%  perf-stat.i.node-load-misses
    243872 ±  2%     -60.2%      97050        perf-stat.i.node-loads
      1.36 ± 20%     -70.9%       0.39 ± 38%  perf-stat.i.node-store-misses
   1154861 ±  5%     -64.6%     409216 ±  3%  perf-stat.i.node-stores
      6123 ±  4%     -42.6%       3514        perf-stat.i.page-faults
     34.42            +9.6%      37.74        perf-stat.overall.MPKI
      4.00            +0.4        4.37        perf-stat.overall.branch-miss-rate%
      1.50            +0.7        2.17        perf-stat.overall.cache-miss-rate%
      0.83            +2.9%       0.85        perf-stat.overall.cpi
      1608           -35.1%       1043        perf-stat.overall.cycles-between-cache-misses
      0.02 ± 10%      +0.0        0.04 ±  9%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  2%      +0.0        0.02 ±  9%  perf-stat.overall.dTLB-store-miss-rate%
     74.02            -4.4       69.67        perf-stat.overall.iTLB-load-miss-rate%
     69782 ±  3%     -60.3%      27693        perf-stat.overall.instructions-per-iTLB-miss
      1.21            -2.8%       1.17        perf-stat.overall.ipc
 1.577e+09           -64.1%  5.665e+08        perf-stat.ps.branch-instructions
  63097630           -60.7%   24776524        perf-stat.ps.branch-misses
   6689008           -45.9%    3620492        perf-stat.ps.cache-misses
 4.465e+08           -62.6%  1.671e+08        perf-stat.ps.cache-references
      1318           +42.7%       1881        perf-stat.ps.context-switches
     15621            +1.7%      15880        perf-stat.ps.cpu-clock
 1.076e+10           -64.9%  3.778e+09        perf-stat.ps.cpu-cycles
     29.06 ±  2%     +11.9%      32.52        perf-stat.ps.cpu-migrations
    784798 ± 10%     -36.4%     499506 ±  8%  perf-stat.ps.dTLB-load-misses
 3.661e+09           -66.6%  1.223e+09        perf-stat.ps.dTLB-loads
     72623 ±  2%     -24.7%      54670 ±  9%  perf-stat.ps.dTLB-store-misses
 1.001e+09           -65.4%  3.463e+08        perf-stat.ps.dTLB-stores
    186142 ±  3%     -14.1%     159974        perf-stat.ps.iTLB-load-misses
 1.297e+10           -65.9%  4.429e+09        perf-stat.ps.instructions
      4.17 ±  2%     -70.0%       1.25        perf-stat.ps.major-faults
      5975 ±  4%     -41.8%       3478        perf-stat.ps.minor-faults
      1.07 ± 21%     -57.7%       0.45 ± 33%  perf-stat.ps.node-load-misses
    238147 ±  2%     -59.6%      96125        perf-stat.ps.node-loads
      1.32 ± 20%     -70.6%       0.39 ± 38%  perf-stat.ps.node-store-misses
   1127035 ±  5%     -64.0%     405385 ±  4%  perf-stat.ps.node-stores
      5979 ±  4%     -41.8%       3479        perf-stat.ps.page-faults
     15621            +1.7%      15880        perf-stat.ps.task-clock
  5.48e+11            +8.0%  5.918e+11        perf-stat.total.instructions
     65.13 ± 17%     -58.5        6.60 ± 24%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     65.13 ± 17%     -58.4        6.70 ± 25%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     16.88 ± 61%     -16.7        0.23 ±141%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     16.60 ± 46%     -16.2        0.45 ± 72%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.65 ± 75%     -13.6        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.65 ± 75%     -13.6        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.62 ± 77%     -11.4        0.24 ±142%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.62 ± 77%     -11.4        0.24 ±142%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.62 ± 77%     -11.4        0.24 ±142%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.33 ± 78%     -11.3        0.00        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
     11.33 ± 78%     -11.3        0.00        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
     10.87 ± 53%     -10.9        0.00        perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
     10.87 ± 53%     -10.9        0.00        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
     10.87 ± 53%     -10.9        0.00        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     10.87 ± 53%     -10.9        0.00        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     10.30 ± 61%     -10.3        0.00        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     10.30 ± 61%     -10.3        0.00        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.get_signal
      9.48 ±128%      -9.5        0.00        perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      9.48 ±128%      -9.5        0.00        perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.48 ±128%      -9.5        0.00        perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
      8.10 ± 78%      -8.1        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      8.10 ± 78%      -8.1        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      6.58 ±103%      -6.4        0.23 ±141%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      6.58 ±103%      -6.4        0.23 ±141%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      6.01 ±110%      -6.0        0.00        perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      5.32 ±105%      -5.3        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exec_mmap.begin_new_exec
      5.32 ±105%      -5.1        0.20 ±142%  perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      5.32 ±105%      -5.1        0.20 ±142%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
      0.00            +0.8        0.83 ± 34%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +1.0        0.97 ± 30%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.0        0.99 ± 20%  perf-profile.calltrace.cycles-pp.update_rq_clock_task.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.00            +1.1        1.10 ± 26%  perf-profile.calltrace.cycles-pp.account_user_time.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00            +1.2        1.17 ± 34%  perf-profile.calltrace.cycles-pp.update_curr.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
      0.00            +1.3        1.26 ± 35%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.3        1.28 ± 36%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.3        1.34 ± 35%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.4        1.41 ± 32%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +1.4        1.45 ± 38%  perf-profile.calltrace.cycles-pp.sync_regs.asm_sysvec_apic_timer_interrupt
      0.00            +1.5        1.52 ± 48%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +1.5        1.52 ± 48%  perf-profile.calltrace.cycles-pp.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      0.00            +1.6        1.60 ± 43%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +1.6        1.63 ± 25%  perf-profile.calltrace.cycles-pp.update_load_avg.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
      0.00            +1.7        1.65 ± 41%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00            +1.9        1.86 ± 26%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work
      0.00            +1.9        1.86 ± 26%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work
      0.00            +1.9        1.86 ± 26%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work
      0.00            +1.9        1.86 ± 26%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work
      0.00            +2.2        2.21 ± 16%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_irq_work
      0.00            +2.2        2.21 ± 16%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode
      0.00            +2.2        2.21 ± 16%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.00            +2.2        2.21 ± 16%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.exit_to_user_mode_loop
      0.00            +2.2        2.21 ± 16%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_sysvec_irq_work
      0.00            +2.2        2.21 ± 16%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_irq_work
      0.00            +2.2        2.21 ± 16%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_irq_work
      0.00            +2.6        2.60 ± 17%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +3.0        2.96 ± 19%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
      0.00            +3.6        3.62 ± 19%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      0.00            +4.2        4.19 ± 20%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit._printk
      0.00            +4.8        4.76 ± 20%  perf-profile.calltrace.cycles-pp.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work
      0.00            +4.8        4.76 ± 20%  perf-profile.calltrace.cycles-pp.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work
      0.00            +4.8        4.76 ± 20%  perf-profile.calltrace.cycles-pp._printk.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work
      0.00            +4.8        4.76 ± 20%  perf-profile.calltrace.cycles-pp.vprintk_emit._printk.irq_work_single.irq_work_run_list.irq_work_run
      0.00            +4.8        4.76 ± 20%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit._printk.irq_work_single.irq_work_run_list
      0.00            +4.8        4.76 ± 20%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit._printk.irq_work_single
      0.00            +6.4        6.43 ±  9%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +6.7        6.70 ±  7%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +9.6        9.56 ± 11%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      4.86 ±143%     +10.7       15.57 ± 23%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00           +10.9       10.91 ± 13%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      4.86 ±143%     +17.1       21.96 ± 21%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00           +20.0       20.04 ± 25%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00           +20.6       20.64 ± 25%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     19.32 ± 61%     +22.1       41.42 ± 23%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.58 ±223%     +22.2       22.76 ± 26%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.58 ±223%     +25.6       26.14 ± 27%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
     16.94 ± 66%     +31.3       48.20 ± 17%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     17.52 ± 65%     +33.4       50.92 ± 17%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     19.32 ± 61%     +33.5       52.83 ± 18%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     17.52 ± 65%     +34.0       51.54 ± 16%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     17.52 ± 65%     +34.0       51.55 ± 16%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     17.52 ± 65%     +34.0       51.55 ± 16%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     19.90 ± 60%     +37.5       57.38 ± 16%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     65.13 ± 17%     -58.5        6.60 ± 24%  perf-profile.children.cycles-pp.do_syscall_64
     65.13 ± 17%     -58.4        6.70 ± 25%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     22.50 ± 42%     -22.0        0.50 ± 33%  perf-profile.children.cycles-pp.do_group_exit
     22.50 ± 42%     -22.0        0.50 ± 33%  perf-profile.children.cycles-pp.do_exit
     16.60 ± 46%     -16.1        0.50 ± 49%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     10.87 ± 53%     -10.9        0.00        perf-profile.children.cycles-pp.arch_do_signal_or_restart
     10.87 ± 53%     -10.9        0.00        perf-profile.children.cycles-pp.get_signal
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.perf_event_mmap
      0.00            +0.1        0.10 ± 38%  perf-profile.children.cycles-pp.do_anonymous_page
      0.00            +0.1        0.10 ± 41%  perf-profile.children.cycles-pp.run_timer_softirq
      0.00            +0.1        0.12 ± 61%  perf-profile.children.cycles-pp.__run_timers
      0.00            +0.1        0.12 ± 39%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.00            +0.1        0.13 ± 46%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      0.00            +0.1        0.13 ± 69%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.00            +0.1        0.14 ± 28%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.00            +0.1        0.14 ± 49%  perf-profile.children.cycles-pp.schedule_timeout
      0.00            +0.1        0.14 ± 46%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.00            +0.1        0.14 ± 68%  perf-profile.children.cycles-pp.select_task_rq
      0.00            +0.1        0.14 ± 61%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.2        0.15 ± 39%  perf-profile.children.cycles-pp.profile_tick
      0.00            +0.2        0.16 ± 94%  perf-profile.children.cycles-pp.enqueue_entity
      0.00            +0.2        0.16 ± 15%  perf-profile.children.cycles-pp.io_serial_out
      0.00            +0.2        0.16 ± 45%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.00            +0.2        0.16 ± 73%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.2        0.16 ± 73%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.00            +0.2        0.16 ± 73%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.00            +0.2        0.16 ± 43%  perf-profile.children.cycles-pp.futex_wait
      0.00            +0.2        0.17 ± 50%  perf-profile.children.cycles-pp.hrtimer_forward
      0.00            +0.2        0.17 ± 52%  perf-profile.children.cycles-pp.drm_gem_vunmap_unlocked
      0.00            +0.2        0.17 ± 52%  perf-profile.children.cycles-pp.drm_gem_vunmap
      0.00            +0.2        0.18 ± 38%  perf-profile.children.cycles-pp.hrtimer_wakeup
      0.00            +0.2        0.18 ± 50%  perf-profile.children.cycles-pp.__x64_sys_futex
      0.00            +0.2        0.18 ± 50%  perf-profile.children.cycles-pp.do_futex
      0.00            +0.2        0.20 ± 47%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.2        0.20 ± 18%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.00            +0.2        0.21 ± 53%  perf-profile.children.cycles-pp.drm_client_buffer_vmap
      0.00            +0.2        0.21 ± 41%  perf-profile.children.cycles-pp.number
      0.00            +0.2        0.22 ± 49%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.2        0.22 ± 41%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.2        0.22 ± 68%  perf-profile.children.cycles-pp.error_entry
      0.00            +0.2        0.22 ± 50%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.00            +0.2        0.23 ± 36%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.00            +0.2        0.24 ± 41%  perf-profile.children.cycles-pp.native_apic_mem_write
      0.00            +0.2        0.24 ± 47%  perf-profile.children.cycles-pp.nohz_balancer_kick
      0.00            +0.2        0.25 ± 40%  perf-profile.children.cycles-pp.irqentry_enter
      0.00            +0.3        0.25 ± 46%  perf-profile.children.cycles-pp.__wake_up_common
      0.00            +0.3        0.26 ± 49%  perf-profile.children.cycles-pp.hrtimer_active
      0.00            +0.3        0.26 ± 28%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.3        0.26 ± 38%  perf-profile.children.cycles-pp.task_tick_mm_cid
      0.00            +0.3        0.27 ± 37%  perf-profile.children.cycles-pp.acct_account_cputime
      0.00            +0.3        0.27 ± 64%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.3        0.28 ± 48%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.3        0.28 ± 55%  perf-profile.children.cycles-pp.activate_task
      0.00            +0.3        0.28 ± 39%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.00            +0.3        0.28 ± 64%  perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.3        0.28 ± 51%  perf-profile.children.cycles-pp.timekeeping_advance
      0.00            +0.3        0.28 ± 51%  perf-profile.children.cycles-pp.update_wall_time
      0.00            +0.3        0.29 ± 53%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.00            +0.3        0.29 ± 97%  perf-profile.children.cycles-pp.drm_atomic_helper_prepare_planes
      0.00            +0.3        0.29 ± 97%  perf-profile.children.cycles-pp.drm_gem_fb_vmap
      0.00            +0.3        0.30 ± 52%  perf-profile.children.cycles-pp.__do_huge_pmd_anonymous_page
      0.00            +0.3        0.30 ± 52%  perf-profile.children.cycles-pp.clear_huge_page
      0.00            +0.3        0.30 ± 48%  perf-profile.children.cycles-pp.account_process_tick
      0.00            +0.3        0.30 ± 50%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.3        0.31 ± 29%  perf-profile.children.cycles-pp.__calc_delta
      0.00            +0.3        0.31 ± 49%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +0.3        0.32 ± 66%  perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.3        0.33 ± 62%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.3        0.33 ± 72%  perf-profile.children.cycles-pp.sprintf
      0.00            +0.3        0.34 ± 50%  perf-profile.children.cycles-pp.clear_page_erms
      0.00            +0.4        0.37 ± 28%  perf-profile.children.cycles-pp.pipe_write
      0.00            +0.4        0.37 ± 34%  perf-profile.children.cycles-pp.irq_work_tick
      0.00            +0.4        0.37 ± 52%  perf-profile.children.cycles-pp.check_cpu_stall
      0.00            +0.4        0.38 ± 50%  perf-profile.children.cycles-pp.rb_erase
      0.00            +0.4        0.38 ± 62%  perf-profile.children.cycles-pp.show_time_in_state
      0.00            +0.4        0.38 ± 62%  perf-profile.children.cycles-pp.show
      0.00            +0.4        0.38 ± 23%  perf-profile.children.cycles-pp.__cgroup_account_cputime_field
      0.00            +0.4        0.39 ± 60%  perf-profile.children.cycles-pp.vsnprintf
      0.00            +0.4        0.40 ± 42%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.4        0.41 ± 59%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.00            +0.4        0.41 ± 42%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.4        0.42 ± 27%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.00            +0.4        0.42 ± 62%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.00            +0.4        0.42 ± 75%  perf-profile.children.cycles-pp.drm_gem_get_pages
      0.00            +0.4        0.42 ± 75%  perf-profile.children.cycles-pp.shmem_read_mapping_page_gfp
      0.00            +0.4        0.43 ± 25%  perf-profile.children.cycles-pp.dup_mmap
      0.00            +0.5        0.45 ± 23%  perf-profile.children.cycles-pp.dup_mm
      0.00            +0.5        0.46 ± 40%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.5        0.47 ± 27%  perf-profile.children.cycles-pp.try_to_wake_up
      0.00            +0.5        0.47 ± 57%  perf-profile.children.cycles-pp.traverse
      0.00            +0.5        0.48 ± 11%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.5        0.49 ± 63%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.00            +0.5        0.49 ± 80%  perf-profile.children.cycles-pp.delay_tsc
      0.00            +0.5        0.50 ± 62%  perf-profile.children.cycles-pp.drm_gem_vmap_unlocked
      0.00            +0.5        0.50 ± 62%  perf-profile.children.cycles-pp.drm_gem_vmap
      0.00            +0.5        0.52 ± 31%  perf-profile.children.cycles-pp.lf
      0.00            +0.5        0.52 ± 31%  perf-profile.children.cycles-pp.con_scroll
      0.00            +0.5        0.52 ± 31%  perf-profile.children.cycles-pp.fbcon_scroll
      0.00            +0.5        0.52 ± 31%  perf-profile.children.cycles-pp.fbcon_redraw
      0.00            +0.5        0.52 ± 40%  perf-profile.children.cycles-pp.fbcon_putcs
      0.00            +0.5        0.54 ± 50%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.6        0.57 ± 30%  perf-profile.children.cycles-pp.vt_console_print
      0.00            +0.6        0.58 ± 38%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.6        0.60 ± 45%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.6        0.62 ± 28%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.6        0.63 ± 31%  perf-profile.children.cycles-pp.copy_process
      0.00            +0.6        0.64 ± 29%  perf-profile.children.cycles-pp.__do_sys_clone
      0.00            +0.6        0.64 ± 29%  perf-profile.children.cycles-pp.kernel_clone
      0.00            +0.7        0.66 ± 47%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.00            +0.7        0.67 ± 47%  perf-profile.children.cycles-pp.seq_read_iter
      0.00            +0.7        0.73 ± 32%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.7        0.73 ± 37%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.7        0.75 ± 32%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.8        0.76 ± 67%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
      0.00            +0.8        0.76 ± 67%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.00            +0.8        0.76 ± 67%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      0.00            +0.8        0.76 ± 67%  perf-profile.children.cycles-pp.drm_fb_memcpy
      0.00            +0.8        0.76 ± 67%  perf-profile.children.cycles-pp.memcpy_toio
      0.00            +0.8        0.77 ± 27%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.8        0.82 ± 36%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +0.9        0.85 ± 61%  perf-profile.children.cycles-pp.commit_tail
      0.00            +0.9        0.88 ± 23%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.9        0.88 ± 53%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.9        0.94 ± 39%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +1.0        0.96 ± 35%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +1.0        0.96 ± 22%  perf-profile.children.cycles-pp.read_tsc
      0.00            +1.0        0.98 ± 30%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +1.0        1.00 ± 36%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +1.0        1.00 ± 27%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +1.0        1.02 ± 15%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +1.0        1.03 ± 31%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +1.1        1.06 ± 29%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +1.1        1.10 ± 26%  perf-profile.children.cycles-pp.account_user_time
      0.00            +1.1        1.14 ± 64%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.00            +1.2        1.15 ± 62%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.00            +1.2        1.16 ± 28%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +1.2        1.16 ± 23%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +1.3        1.33 ± 17%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +1.4        1.36 ± 45%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +1.5        1.52 ± 48%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.00            +1.5        1.52 ± 48%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
      0.00            +1.6        1.57 ± 22%  perf-profile.children.cycles-pp.perf_rotate_context
      0.00            +1.6        1.58 ± 25%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +1.6        1.60 ± 43%  perf-profile.children.cycles-pp.process_one_work
      0.00            +1.7        1.65 ± 41%  perf-profile.children.cycles-pp.worker_thread
      0.00            +1.7        1.66 ± 39%  perf-profile.children.cycles-pp.sync_regs
      0.00            +1.9        1.88 ± 23%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +2.7        2.74 ± 20%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.00            +3.6        3.56 ± 16%  perf-profile.children.cycles-pp.io_serial_in
      0.00            +3.9        3.90 ± 32%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.00            +4.0        4.04 ± 20%  perf-profile.children.cycles-pp.wait_for_lsr
      0.00            +4.2        4.19 ± 20%  perf-profile.children.cycles-pp.serial8250_console_write
      0.00            +4.8        4.76 ± 20%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.00            +4.8        4.76 ± 20%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.00            +4.8        4.76 ± 20%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.00            +4.8        4.76 ± 20%  perf-profile.children.cycles-pp.irq_work_run
      0.00            +4.8        4.76 ± 20%  perf-profile.children.cycles-pp.irq_work_single
      0.00            +4.8        4.76 ± 20%  perf-profile.children.cycles-pp._printk
      0.00            +4.8        4.76 ± 20%  perf-profile.children.cycles-pp.vprintk_emit
      0.00            +4.8        4.78 ± 20%  perf-profile.children.cycles-pp.console_unlock
      0.00            +4.8        4.78 ± 20%  perf-profile.children.cycles-pp.console_flush_all
      0.00            +4.9        4.89 ± 20%  perf-profile.children.cycles-pp.irq_work_run_list
      4.86 ±143%     +10.9       15.80 ± 23%  perf-profile.children.cycles-pp.tick_sched_timer
      4.86 ±143%     +17.5       22.32 ± 21%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      4.86 ±143%     +21.9       26.72 ± 20%  perf-profile.children.cycles-pp.hrtimer_interrupt
     19.32 ± 61%     +22.1       41.41 ± 23%  perf-profile.children.cycles-pp.intel_idle
      4.86 ±143%     +22.7       27.60 ± 19%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      5.44 ±123%     +27.2       32.68 ± 17%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      5.44 ±123%     +31.4       36.88 ± 18%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     17.52 ± 65%     +34.0       51.55 ± 16%  perf-profile.children.cycles-pp.start_secondary
     19.32 ± 61%     +34.4       53.68 ± 18%  perf-profile.children.cycles-pp.cpuidle_enter_state
     19.32 ± 61%     +34.5       53.82 ± 18%  perf-profile.children.cycles-pp.cpuidle_enter
     19.90 ± 60%     +36.8       56.72 ± 17%  perf-profile.children.cycles-pp.cpuidle_idle_call
     19.90 ± 60%     +37.5       57.37 ± 16%  perf-profile.children.cycles-pp.do_idle
     19.90 ± 60%     +37.5       57.38 ± 16%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     19.90 ± 60%     +37.5       57.38 ± 16%  perf-profile.children.cycles-pp.cpu_startup_entry
      6.01 ±110%      -6.0        0.02 ±223%  perf-profile.self.cycles-pp.page_remove_rmap
      0.00            +0.1        0.11 ± 69%  perf-profile.self.cycles-pp.timekeeping_advance
      0.00            +0.1        0.11 ± 40%  perf-profile.self.cycles-pp.irq_work_needs_cpu
      0.00            +0.1        0.13 ± 40%  perf-profile.self.cycles-pp.irq_work_run_list
      0.00            +0.1        0.14 ± 68%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.14 ± 46%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.00            +0.1        0.14 ± 20%  perf-profile.self.cycles-pp.tick_irq_enter
      0.00            +0.1        0.14 ± 71%  perf-profile.self.cycles-pp.nohz_balancer_kick
      0.00            +0.1        0.15 ± 56%  perf-profile.self.cycles-pp.number
      0.00            +0.2        0.15 ± 39%  perf-profile.self.cycles-pp.profile_tick
      0.00            +0.2        0.16 ± 15%  perf-profile.self.cycles-pp.io_serial_out
      0.00            +0.2        0.17 ± 50%  perf-profile.self.cycles-pp.hrtimer_forward
      0.00            +0.2        0.20 ± 51%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.2        0.20 ± 18%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.00            +0.2        0.21 ± 38%  perf-profile.self.cycles-pp.timerqueue_del
      0.00            +0.2        0.22 ± 41%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.2        0.22 ± 68%  perf-profile.self.cycles-pp.error_entry
      0.00            +0.2        0.23 ± 45%  perf-profile.self.cycles-pp.reweight_entity
      0.00            +0.2        0.23 ± 36%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.00            +0.2        0.24 ± 41%  perf-profile.self.cycles-pp.native_apic_mem_write
      0.00            +0.2        0.25 ± 47%  perf-profile.self.cycles-pp.hrtimer_active
      0.00            +0.2        0.25 ± 62%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.3        0.25 ± 38%  perf-profile.self.cycles-pp.task_tick_mm_cid
      0.00            +0.3        0.27 ± 37%  perf-profile.self.cycles-pp.acct_account_cputime
      0.00            +0.3        0.27 ± 69%  perf-profile.self.cycles-pp.trigger_load_balance
      0.00            +0.3        0.28 ± 28%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.3        0.29 ± 53%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.00            +0.3        0.30 ± 48%  perf-profile.self.cycles-pp.account_process_tick
      0.00            +0.3        0.31 ± 29%  perf-profile.self.cycles-pp.__calc_delta
      0.00            +0.3        0.31 ± 37%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.3        0.32 ± 62%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.00            +0.3        0.32 ± 39%  perf-profile.self.cycles-pp.irq_work_tick
      0.00            +0.3        0.34 ± 50%  perf-profile.self.cycles-pp.clear_page_erms
      0.00            +0.4        0.36 ± 52%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.4        0.37 ± 52%  perf-profile.self.cycles-pp.check_cpu_stall
      0.00            +0.4        0.38 ± 50%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.4        0.39 ± 54%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.4        0.41 ± 59%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.4        0.42 ± 13%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.4        0.44 ± 70%  perf-profile.self.cycles-pp.task_tick_fair
      0.00            +0.4        0.44 ± 33%  perf-profile.self.cycles-pp.memcpy_toio
      0.00            +0.5        0.46 ± 40%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.5        0.46 ± 26%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.5        0.49 ± 63%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.00            +0.5        0.49 ± 80%  perf-profile.self.cycles-pp.delay_tsc
      0.00            +0.5        0.52 ± 56%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.5        0.55 ± 41%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.6        0.57 ± 40%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.6        0.60 ± 24%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.6        0.60 ± 45%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.6        0.63 ± 26%  perf-profile.self.cycles-pp.timerqueue_add
      0.00            +0.6        0.63 ± 26%  perf-profile.self.cycles-pp.account_user_time
      0.00            +0.6        0.65 ± 21%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +0.7        0.67 ± 17%  perf-profile.self.cycles-pp.perf_rotate_context
      0.00            +0.7        0.73 ± 33%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.7        0.73 ± 30%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.8        0.75 ± 35%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.8        0.81 ± 35%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.8        0.84 ± 40%  perf-profile.self.cycles-pp.scheduler_tick
      0.00            +0.9        0.89 ± 28%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.9        0.94 ± 25%  perf-profile.self.cycles-pp.read_tsc
      0.00            +1.0        1.02 ± 15%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +1.1        1.06 ± 29%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.00            +1.2        1.16 ± 23%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +1.2        1.25 ± 25%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +1.3        1.27 ± 23%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +1.3        1.33 ± 17%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +1.7        1.66 ± 39%  perf-profile.self.cycles-pp.sync_regs
      0.00            +3.6        3.56 ± 16%  perf-profile.self.cycles-pp.io_serial_in
     19.32 ± 61%     +22.1       41.41 ± 23%  perf-profile.self.cycles-pp.intel_idle



***************************************************************************************************
lkp-cfl-e1: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/pickle_pure_python/debian-x86_64-phoronix/lkp-cfl-e1/pyperformance-1.0.2/phoronix-test-suite

commit: 
  a525b95417 ("cpufreq/amd-pstate: Remove fast_switch_possible flag from active driver")
  278dfbd17c ("cpufreq: Return failure if fast_switch is not set and fast_switch_possible is set")

a525b954173e74cd 278dfbd17c5d0767834471d7fea 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6          100%           6:6     kmsg.cpufreq:fast_switch_possible_is_enabled_but_fast_switch_callback_is_not_set
         %stddev     %change         %stddev
             \          |                \  
    391.00           -99.4%       2.22        phoronix-test-suite.pyperformance.pickle_pure_python.milliseconds
     91.97           +70.0%     156.34        phoronix-test-suite.time.elapsed_time
     91.97           +70.0%     156.34        phoronix-test-suite.time.elapsed_time.max
     75.83           +10.8%      84.00        phoronix-test-suite.time.percent_of_cpu_this_job_got
     68.51           +78.7%     122.45        phoronix-test-suite.time.user_time
     44.67 ±  3%      +9.1%      48.74        boot-time.boot
    578.11 ±  2%      +6.0%     612.59        boot-time.idle
 1.408e+09           +57.1%  2.211e+09        cpuidle..time
   1492421           +64.8%    2460130        cpuidle..usage
      6896           +18.6%       8177        meminfo.Active(anon)
    121274 ±  9%     +14.4%     138735 ±  2%  meminfo.AnonHugePages
    139.63           +49.3%     208.46        uptime.boot
      1999           +43.0%       2859        uptime.idle
     93.00            -5.7%      87.67        vmstat.cpu.id
      1112 ±  4%     -40.6%     660.50 ±  2%  vmstat.io.bi
      1468           +38.0%       2026        vmstat.system.cs
      0.30 ±  5%      -0.1        0.17 ±  2%  mpstat.cpu.all.iowait%
      0.59            +2.5        3.06        mpstat.cpu.all.irq%
      0.04 ±  7%      +0.2        0.20        mpstat.cpu.all.soft%
      0.29            +0.5        0.83        mpstat.cpu.all.sys%
      5.09            +2.5        7.59        mpstat.cpu.all.usr%
      1723           +18.6%       2044        proc-vmstat.nr_active_anon
     92126            -1.7%      90534        proc-vmstat.nr_anon_pages
      6684            +1.6%       6789        proc-vmstat.nr_kernel_stack
     15983            -2.6%      15569        proc-vmstat.nr_slab_unreclaimable
      1723           +18.6%       2044        proc-vmstat.nr_zone_active_anon
    691105           +15.3%     796970        proc-vmstat.numa_hit
    691096           +15.3%     796942        proc-vmstat.numa_local
     16545            +4.3%      17256        proc-vmstat.pgactivate
    748098           +17.2%     876972        proc-vmstat.pgalloc_normal
   1113450           +14.9%    1279681        proc-vmstat.pgfault
    696774           +18.2%     823764        proc-vmstat.pgfree
    347697            +8.8%     378312        proc-vmstat.pgreuse
    869760           +57.1%    1366784        proc-vmstat.unevictable_pgs_scanned
     78.73           +21.3%      95.53        turbostat.Any%C0
    279.33           -62.2%     105.50        turbostat.Avg_MHz
      6.12            +7.1       13.20        turbostat.Busy%
      4569           -82.5%     800.00        turbostat.Bzy_MHz
      2894 ±  6%   +1657.0%      50860        turbostat.C1
      0.01            +0.0        0.03        turbostat.C1%
     11256 ±  3%    +332.0%      48630        turbostat.C1E
     14141 ±  2%     +61.5%      22838 ±  3%  turbostat.C3
      0.22 ±  3%      -0.1        0.15        turbostat.C3%
    499577          +124.0%    1118904        turbostat.C6
     31.51            +9.4       40.94        turbostat.C6%
    937249           +30.0%    1218418        turbostat.C8
     61.61           -15.6       46.02        turbostat.C8%
      0.28 ± 12%     -28.7%       0.20 ±  2%  turbostat.CPU%c3
     31.36           +58.4%      49.69        turbostat.CPU%c6
     46.27           -54.4%      21.11        turbostat.CPU%c7
     24.55           -92.1%       1.95        turbostat.CorWatt
     52.50 ±  7%     -42.9%      30.00        turbostat.CoreTmp
   1519070           +68.8%    2564565        turbostat.IRQ
     26254           -93.4%       1721 ± 24%  turbostat.POLL
      3.21 ±  4%     -86.1%       0.44 ±  4%  turbostat.Pkg%pc2
     10.04 ±  2%     -62.6%       3.76 ±  2%  turbostat.Pkg%pc3
     51.83 ±  9%     -40.8%      30.67        turbostat.PkgTmp
     25.03           -90.3%       2.43        turbostat.PkgWatt
     97.03           +99.1%     193.14        turbostat.Totl%C0
      0.52 ± 23%     -18.7%       0.42 ±  8%  sched_debug.cfs_rq:/.h_nr_running.stddev
      9607 ± 15%    +152.8%      24290 ±  8%  sched_debug.cfs_rq:/.min_vruntime.avg
     16594 ± 20%    +249.3%      57957 ± 15%  sched_debug.cfs_rq:/.min_vruntime.max
      6011 ± 18%     +79.8%      10806 ±  6%  sched_debug.cfs_rq:/.min_vruntime.min
      2916 ± 29%    +387.4%      14213 ± 19%  sched_debug.cfs_rq:/.min_vruntime.stddev
    666.91 ± 29%     -47.1%     352.68 ± 21%  sched_debug.cfs_rq:/.runnable_avg.avg
    229.00 ± 93%     -78.1%      50.08 ± 41%  sched_debug.cfs_rq:/.runnable_avg.min
      3691 ± 73%    +741.5%      31063 ± 41%  sched_debug.cfs_rq:/.spread0.max
     -6899          +133.6%     -16116        sched_debug.cfs_rq:/.spread0.min
      2917 ± 29%    +387.4%      14220 ± 19%  sched_debug.cfs_rq:/.spread0.stddev
    637.35 ± 27%     -46.9%     338.25 ± 21%  sched_debug.cfs_rq:/.util_avg.avg
    212.83 ± 90%     -79.1%      44.39 ± 50%  sched_debug.cfs_rq:/.util_avg.min
    730.42 ± 16%     -73.8%     191.67 ± 23%  sched_debug.cfs_rq:/.util_est_enqueued.max
    186.21 ± 19%     -66.5%      62.29 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    264982 ± 37%     +89.7%     502726 ± 12%  sched_debug.cpu.avg_idle.min
     51644 ± 24%     +76.5%      91142 ± 16%  sched_debug.cpu.clock.avg
     51645 ± 24%     +76.5%      91144 ± 16%  sched_debug.cpu.clock.max
     51643 ± 24%     +76.5%      91140 ± 16%  sched_debug.cpu.clock.min
     50245 ± 24%     +76.1%      88500 ± 15%  sched_debug.cpu.clock_task.avg
     51446 ± 23%     +74.5%      89762 ± 15%  sched_debug.cpu.clock_task.max
     40424 ± 26%     +95.8%      79135 ± 17%  sched_debug.cpu.clock_task.min
      1323 ± 25%     +73.1%       2290 ± 12%  sched_debug.cpu.curr->pid.max
    515.04 ± 26%     +53.7%     791.50 ± 13%  sched_debug.cpu.curr->pid.stddev
      4983 ± 22%    +104.8%      10204 ± 16%  sched_debug.cpu.nr_switches.avg
     11553 ± 42%    +110.0%      24267 ± 14%  sched_debug.cpu.nr_switches.max
      1502 ± 29%    +147.1%       3713 ± 17%  sched_debug.cpu.nr_switches.min
      2809 ± 35%     +93.1%       5425 ± 15%  sched_debug.cpu.nr_switches.stddev
     51643 ± 24%     +76.5%      91140 ± 16%  sched_debug.cpu_clk
     50769 ± 24%     +77.8%      90265 ± 16%  sched_debug.ktime
     49225 ± 22%     +81.8%      89499 ± 15%  sched_debug.sched_clk
     44.71 ±  4%     -14.6%      38.20        perf-stat.i.MPKI
 1.929e+09           -76.9%  4.446e+08        perf-stat.i.branch-instructions
      2.33            +0.4        2.78        perf-stat.i.branch-miss-rate%
  17917862           -33.9%   11845681        perf-stat.i.branch-misses
      3.39 ±  3%      +1.6        5.04        perf-stat.i.cache-miss-rate%
   3279255 ±  3%      -6.9%    3053819        perf-stat.i.cache-misses
 1.045e+08           -41.7%   60884324        perf-stat.i.cache-references
      1373           +43.8%       1974        perf-stat.i.context-switches
      1.15 ±  2%     -27.1%       0.84        perf-stat.i.cpi
  4.39e+09           -65.5%  1.515e+09        perf-stat.i.cpu-cycles
     24.91            -5.4%      23.57 ±  2%  perf-stat.i.cpu-migrations
      1930 ±  5%     -66.8%     640.60        perf-stat.i.cycles-between-cache-misses
      0.19 ±  4%      -0.1        0.13 ±  2%  perf-stat.i.dTLB-load-miss-rate%
    567898           -11.4%     503424        perf-stat.i.dTLB-load-misses
 2.756e+09           -79.0%  5.784e+08        perf-stat.i.dTLB-loads
      0.04 ±  5%      -0.0        0.03        perf-stat.i.dTLB-store-miss-rate%
     81667           -21.4%      64183        perf-stat.i.dTLB-store-misses
 1.267e+09           -79.2%  2.639e+08        perf-stat.i.dTLB-stores
     44.98            +1.2       46.14        perf-stat.i.iTLB-load-miss-rate%
    548983 ±  2%     -52.0%     263472        perf-stat.i.iTLB-load-misses
    900745           -62.6%     336446        perf-stat.i.iTLB-loads
 8.909e+09           -76.8%   2.07e+09        perf-stat.i.instructions
     15290           -48.3%       7907        perf-stat.i.instructions-per-iTLB-miss
      1.81           -25.5%       1.35        perf-stat.i.ipc
      2.37           -46.6%       1.26 ±  2%  perf-stat.i.major-faults
      0.27           -65.5%       0.09        perf-stat.i.metric.GHz
    117.79 ±  5%     -59.4%      47.79        perf-stat.i.metric.K/sec
    378.49           -77.7%      84.21        perf-stat.i.metric.M/sec
     11121           -30.1%       7775        perf-stat.i.minor-faults
      7.42 ± 10%     -36.3%       4.73 ±  4%  perf-stat.i.node-load-misses
    177094 ±  3%     -34.2%     116568        perf-stat.i.node-loads
      8.67 ± 19%     -40.8%       5.13 ± 12%  perf-stat.i.node-store-misses
    364565 ±  4%     -32.5%     246258        perf-stat.i.node-stores
     11123           -30.1%       7776        perf-stat.i.page-faults
     11.73          +151.2%      29.48        perf-stat.overall.MPKI
      0.93            +1.7        2.66        perf-stat.overall.branch-miss-rate%
      3.14 ±  2%      +1.9        5.01        perf-stat.overall.cache-miss-rate%
      0.49           +48.6%       0.73        perf-stat.overall.cpi
      1339 ±  3%     -63.0%     496.35        perf-stat.overall.cycles-between-cache-misses
      0.02            +0.1        0.09        perf-stat.overall.dTLB-load-miss-rate%
      0.01            +0.0        0.02        perf-stat.overall.dTLB-store-miss-rate%
     37.87            +6.0       43.87        perf-stat.overall.iTLB-load-miss-rate%
     16234 ±  2%     -51.7%       7839        perf-stat.overall.instructions-per-iTLB-miss
      2.03           -32.7%       1.37        perf-stat.overall.ipc
 1.907e+09           -76.9%  4.412e+08        perf-stat.ps.branch-instructions
  17720496           -33.7%   11756414        perf-stat.ps.branch-misses
   3243482 ±  3%      -6.5%    3031172        perf-stat.ps.cache-misses
 1.034e+08           -41.4%   60556271        perf-stat.ps.cache-references
      1358           +44.3%       1959        perf-stat.ps.context-switches
 4.341e+09           -65.3%  1.504e+09        perf-stat.ps.cpu-cycles
     24.65            -4.8%      23.46 ±  2%  perf-stat.ps.cpu-migrations
    561792           -11.0%     500237        perf-stat.ps.dTLB-load-misses
 2.726e+09           -78.9%   5.74e+08        perf-stat.ps.dTLB-loads
     80786           -21.0%      63822        perf-stat.ps.dTLB-store-misses
 1.253e+09           -79.1%   2.62e+08        perf-stat.ps.dTLB-stores
    542990 ±  2%     -51.7%     262035        perf-stat.ps.iTLB-load-misses
    890835           -62.4%     335305        perf-stat.ps.iTLB-loads
 8.811e+09           -76.7%  2.054e+09        perf-stat.ps.instructions
      2.34           -46.6%       1.25 ±  2%  perf-stat.ps.major-faults
     11000           -29.7%       7730        perf-stat.ps.minor-faults
      7.34 ± 10%     -36.0%       4.70 ±  5%  perf-stat.ps.node-load-misses
    175176 ±  3%     -33.9%     115833        perf-stat.ps.node-loads
      8.57 ± 19%     -40.4%       5.11 ± 13%  perf-stat.ps.node-store-misses
    360620 ±  4%     -31.9%     245454        perf-stat.ps.node-stores
     11002           -29.7%       7731        perf-stat.ps.page-faults
 8.234e+11           -60.7%  3.233e+11        perf-stat.total.instructions
     51.62 ± 14%     -47.4        4.20 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     51.62 ± 14%     -47.4        4.22 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     12.88 ± 77%     -12.9        0.00        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     11.55 ± 64%     -11.6        0.00        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.09 ± 63%     -10.5        1.56 ±  8%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
     10.37 ± 94%     -10.4        0.00        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
     10.36 ± 92%     -10.4        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.36 ± 92%     -10.4        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.04 ± 66%     -10.0        0.00        perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
     10.04 ± 66%     -10.0        0.00        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      8.93 ± 82%      -8.9        0.00        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      9.15 ± 58%      -8.7        0.47 ± 71%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.53 ± 91%      -8.5        0.00        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      8.53 ± 91%      -8.5        0.00        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.get_signal
      9.15 ± 58%      -8.4        0.73 ± 18%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.15 ± 58%      -8.4        0.73 ± 18%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.70 ± 84%      -7.7        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.70 ± 84%      -7.7        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.18 ± 84%      -7.2        0.00        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.18 ± 84%      -7.2        0.00        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.18 ± 84%      -7.2        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.01 ± 90%      -7.0        0.00        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      7.01 ± 90%      -7.0        0.00        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      5.99 ± 92%      -6.0        0.00        perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.99 ± 92%      -6.0        0.00        perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      5.99 ± 92%      -6.0        0.00        perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
      5.90 ± 68%      -5.9        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      5.90 ± 68%      -5.9        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      0.00            +0.7        0.70 ±  6%  perf-profile.calltrace.cycles-pp.timerqueue_del.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.7        0.71 ± 20%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00            +0.7        0.71 ± 19%  perf-profile.calltrace.cycles-pp.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.8        0.77 ± 16%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.8        0.79 ± 24%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.00            +0.8        0.80 ± 16%  perf-profile.calltrace.cycles-pp.update_blocked_averages.run_rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.8        0.80 ± 23%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.8        0.85 ± 16%  perf-profile.calltrace.cycles-pp.run_rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.0        0.97 ± 16%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.2        1.20 ± 25%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +1.4        1.41 ± 36%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit._printk
      0.00            +1.4        1.42 ± 26%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.5        1.46 ± 20%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.5        1.50 ± 18%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.7        1.71 ± 23%  perf-profile.calltrace.cycles-pp.vprintk_emit._printk.irq_work_single.irq_work_run_list.irq_work_run
      0.00            +1.7        1.71 ± 23%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit._printk.irq_work_single.irq_work_run_list
      0.00            +1.7        1.71 ± 23%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit._printk.irq_work_single
      0.00            +1.7        1.71 ± 23%  perf-profile.calltrace.cycles-pp.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work
      0.00            +1.7        1.71 ± 23%  perf-profile.calltrace.cycles-pp.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work
      0.00            +1.7        1.71 ± 23%  perf-profile.calltrace.cycles-pp._printk.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work
      0.00            +2.3        2.32 ± 10%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +2.4        2.37 ± 19%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00            +2.8        2.85 ± 10%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +3.5        3.52 ± 20%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +4.3        4.27 ±  9%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +4.8        4.76 ±  8%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +5.4        5.42 ±  6%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +5.6        5.62 ± 82%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.00            +5.8        5.83 ± 79%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      0.00            +5.9        5.90 ± 79%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
      0.00            +5.9        5.90 ± 79%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
      0.00            +5.9        5.90 ± 79%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +5.9        5.90 ± 79%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +5.9        5.90 ± 79%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +5.9        5.90 ± 79%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +5.9        5.90 ± 79%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.00            +9.2        9.21 ±  2%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00           +11.2       11.19 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00           +11.7       11.74 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00           +18.1       18.08        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00           +20.5       20.55 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     21.44 ± 35%     +40.0       61.39 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     25.50 ± 46%     +53.7       79.24 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     25.50 ± 46%     +57.7       83.24        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     25.50 ± 46%     +58.2       83.74 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     25.58 ± 45%     +59.2       84.78 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     25.58 ± 45%     +59.2       84.82 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     25.58 ± 45%     +59.2       84.82 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     25.66 ± 45%     +65.0       90.72        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     51.62 ± 14%     -47.4        4.21 ± 10%  perf-profile.children.cycles-pp.do_syscall_64
     51.62 ± 14%     -47.4        4.22 ± 10%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     17.21 ± 61%     -16.9        0.28 ± 20%  perf-profile.children.cycles-pp.do_group_exit
     17.21 ± 61%     -16.9        0.28 ± 20%  perf-profile.children.cycles-pp.do_exit
     17.42 ± 68%     -16.9        0.51 ± 10%  perf-profile.children.cycles-pp.__mmput
     17.34 ± 69%     -16.8        0.51 ± 10%  perf-profile.children.cycles-pp.exit_mmap
     13.04 ± 75%     -12.8        0.22 ± 30%  perf-profile.children.cycles-pp.exit_mm
     11.55 ± 64%     -11.2        0.39 ± 30%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     12.90 ± 53%     -11.1        1.78 ± 12%  perf-profile.children.cycles-pp.asm_exc_page_fault
     10.04 ± 66%     -10.0        0.00        perf-profile.children.cycles-pp.get_signal
     10.04 ± 66%     -10.0        0.01 ±223%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      9.15 ± 58%      -8.5        0.62 ± 21%  perf-profile.children.cycles-pp.bprm_execve
      9.15 ± 58%      -8.4        0.73 ± 18%  perf-profile.children.cycles-pp.__x64_sys_execve
      9.15 ± 58%      -8.4        0.73 ± 18%  perf-profile.children.cycles-pp.do_execveat_common
      5.99 ± 92%      -6.0        0.00        perf-profile.children.cycles-pp.generic_perform_write
      5.99 ± 92%      -6.0        0.01 ±223%  perf-profile.children.cycles-pp.__generic_file_write_iter
      5.99 ± 92%      -6.0        0.01 ±223%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.00            +0.1        0.10 ± 38%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.1        0.10 ± 19%  perf-profile.children.cycles-pp.sprintf
      0.00            +0.1        0.11 ± 23%  perf-profile.children.cycles-pp.show
      0.00            +0.1        0.11 ± 23%  perf-profile.children.cycles-pp.show_time_in_state
      0.00            +0.1        0.12 ± 24%  perf-profile.children.cycles-pp.traverse
      0.00            +0.1        0.12 ± 28%  perf-profile.children.cycles-pp.hrtimer_wakeup
      0.00            +0.1        0.13 ± 17%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.13 ± 19%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.00            +0.1        0.13 ± 28%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.1        0.14 ± 36%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.00            +0.1        0.14 ± 48%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.00            +0.1        0.14 ± 33%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.14 ± 34%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.00            +0.1        0.14 ± 45%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.00            +0.1        0.15 ± 45%  perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.2        0.16 ± 43%  perf-profile.children.cycles-pp.enqueue_entity
      0.00            +0.2        0.16 ± 38%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.2        0.17 ± 53%  perf-profile.children.cycles-pp.ct_irq_enter
      0.00            +0.2        0.17 ± 39%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.00            +0.2        0.18 ± 48%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.2        0.18 ± 43%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.2        0.19 ± 33%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.00            +0.2        0.19 ± 22%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.2        0.20 ± 47%  perf-profile.children.cycles-pp.task_tick_mm_cid
      0.00            +0.2        0.20 ± 39%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.2        0.21 ± 36%  perf-profile.children.cycles-pp.activate_task
      0.00            +0.2        0.22 ± 54%  perf-profile.children.cycles-pp.update_wall_time
      0.00            +0.2        0.22 ± 54%  perf-profile.children.cycles-pp.timekeeping_advance
      0.00            +0.2        0.22 ± 27%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.2        0.22 ± 30%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.00            +0.2        0.22 ± 27%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.00            +0.2        0.23 ± 24%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.2        0.23 ± 27%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +0.2        0.24 ± 76%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.00            +0.2        0.24 ± 76%  perf-profile.children.cycles-pp._copy_to_iter
      0.00            +0.2        0.24 ± 76%  perf-profile.children.cycles-pp.copyout
      0.00            +0.2        0.25 ± 32%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.2        0.25 ± 32%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.3        0.26 ± 30%  perf-profile.children.cycles-pp.irq_work_tick
      0.00            +0.3        0.27 ± 29%  perf-profile.children.cycles-pp.try_to_wake_up
      0.00            +0.3        0.27 ± 47%  perf-profile.children.cycles-pp.get_cpu_device
      0.00            +0.3        0.28 ± 27%  perf-profile.children.cycles-pp.check_cpu_stall
      0.00            +0.3        0.30 ± 50%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.00            +0.3        0.31 ± 73%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.00            +0.3        0.31 ± 27%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.3        0.31 ± 42%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.3        0.32 ± 33%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.3        0.32 ± 38%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.3        0.34 ± 36%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.00            +0.4        0.35 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.4        0.36 ± 42%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.4        0.37 ± 43%  perf-profile.children.cycles-pp.native_apic_mem_write
      0.00            +0.4        0.39 ± 23%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.4        0.39 ± 17%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.4        0.40 ± 23%  perf-profile.children.cycles-pp.rb_erase
      0.00            +0.4        0.40 ± 31%  perf-profile.children.cycles-pp.local_clock
      0.00            +0.4        0.41 ± 30%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.08 ±223%      +0.4        0.50 ± 14%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.5        0.46 ± 21%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.08 ±223%      +0.5        0.55 ± 15%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +0.5        0.47 ± 20%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.5        0.48 ± 26%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.00            +0.5        0.49 ± 36%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.5        0.50 ± 25%  perf-profile.children.cycles-pp.irqentry_enter
      0.00            +0.5        0.51 ± 22%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.5        0.52 ± 33%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.5        0.52 ± 29%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.5        0.54 ± 26%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.6        0.55 ± 11%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.6        0.56 ± 29%  perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.6        0.57 ± 18%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.00            +0.6        0.57 ± 22%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.6        0.58 ± 28%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.6        0.59 ± 20%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.6        0.61 ±  6%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.7        0.68 ± 25%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.7        0.74 ±  5%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.8        0.75 ± 13%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.8        0.76 ± 25%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.08 ±223%      +0.8        0.84 ± 15%  perf-profile.children.cycles-pp.load_balance
      0.00            +0.8        0.76 ± 25%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +0.8        0.78 ± 17%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.8        0.80 ± 22%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.9        0.89 ± 17%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.9        0.89 ± 18%  perf-profile.children.cycles-pp.perf_rotate_context
      0.00            +0.9        0.92 ± 24%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.9        0.95 ± 19%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.08 ±223%      +1.0        1.04 ± 14%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +1.1        1.05 ± 17%  perf-profile.children.cycles-pp.ktime_get
      0.00            +1.3        1.34 ± 18%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.00            +1.6        1.55 ± 22%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +1.6        1.60 ± 18%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +1.6        1.64 ± 16%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.08 ±223%      +2.5        2.54 ± 10%  perf-profile.children.cycles-pp.__do_softirq
      0.00            +2.5        2.46 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.00            +2.5        2.46 ±  7%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.00            +2.5        2.46 ±  7%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.00            +2.5        2.46 ±  7%  perf-profile.children.cycles-pp.irq_work_run
      0.00            +2.5        2.46 ±  7%  perf-profile.children.cycles-pp.irq_work_single
      0.00            +2.5        2.46 ±  7%  perf-profile.children.cycles-pp._printk
      0.00            +2.5        2.52 ±  6%  perf-profile.children.cycles-pp.irq_work_run_list
      0.00            +2.8        2.76 ± 20%  perf-profile.children.cycles-pp.scheduler_tick
      0.08 ±223%      +3.0        3.13 ± 11%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.00            +3.8        3.76 ± 20%  perf-profile.children.cycles-pp.menu_select
      0.08 ±223%      +4.8        4.92 ±  8%  perf-profile.children.cycles-pp.update_process_times
      0.08 ±223%      +5.3        5.41 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
      0.08 ±223%      +5.8        5.90 ± 79%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.08 ±223%      +5.8        5.90 ± 79%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.08 ±223%      +5.8        5.90 ± 79%  perf-profile.children.cycles-pp.start_kernel
      0.08 ±223%      +5.8        5.90 ± 79%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.08 ±223%      +5.8        5.90 ± 79%  perf-profile.children.cycles-pp.rest_init
      0.08 ±223%      +6.0        6.13 ±  4%  perf-profile.children.cycles-pp.tick_sched_timer
      0.08 ±223%      +9.8        9.85 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.08 ±223%     +11.8       11.92 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.08 ±223%     +12.4       12.48 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.16 ±223%     +18.6       18.80        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.16 ±223%     +20.1       20.24 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     21.44 ± 35%     +40.0       61.40 ±  2%  perf-profile.children.cycles-pp.intel_idle
     25.58 ± 45%     +59.1       84.64        perf-profile.children.cycles-pp.cpuidle_enter_state
     25.58 ± 45%     +59.2       84.82 ±  4%  perf-profile.children.cycles-pp.start_secondary
     25.58 ± 45%     +59.3       84.86        perf-profile.children.cycles-pp.cpuidle_enter
     25.58 ± 45%     +64.1       89.64        perf-profile.children.cycles-pp.cpuidle_idle_call
     25.66 ± 45%     +65.0       90.72        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     25.66 ± 45%     +65.0       90.72        perf-profile.children.cycles-pp.cpu_startup_entry
     25.66 ± 45%     +65.0       90.72        perf-profile.children.cycles-pp.do_idle
      0.00            +0.1        0.13 ± 36%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.00            +0.1        0.14 ± 48%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.00            +0.1        0.14 ± 37%  perf-profile.self.cycles-pp.trigger_load_balance
      0.00            +0.1        0.14 ± 33%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.14 ± 45%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.00            +0.1        0.15 ± 27%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.2        0.15 ± 42%  perf-profile.self.cycles-pp.call_cpuidle
      0.00            +0.2        0.15 ± 32%  perf-profile.self.cycles-pp.timerqueue_del
      0.00            +0.2        0.16 ± 33%  perf-profile.self.cycles-pp.irqentry_enter
      0.00            +0.2        0.16 ± 40%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.00            +0.2        0.18 ± 48%  perf-profile.self.cycles-pp.task_tick_mm_cid
      0.00            +0.2        0.18 ± 48%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.2        0.19 ± 22%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.2        0.20 ± 50%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.2        0.20 ± 52%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.2        0.20 ± 42%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.2        0.20 ± 46%  perf-profile.self.cycles-pp.tick_nohz_stop_idle
      0.00            +0.2        0.21 ± 47%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.2        0.21 ± 32%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.00            +0.2        0.22 ± 27%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.2        0.22 ± 20%  perf-profile.self.cycles-pp.cpuidle_enter
      0.00            +0.2        0.22 ± 34%  perf-profile.self.cycles-pp.tick_irq_enter
      0.00            +0.2        0.22 ± 29%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.2        0.22 ± 37%  perf-profile.self.cycles-pp.load_balance
      0.00            +0.2        0.23 ± 25%  perf-profile.self.cycles-pp.irq_work_tick
      0.00            +0.2        0.24 ± 30%  perf-profile.self.cycles-pp.__irq_exit_rcu
      0.00            +0.2        0.24 ±  9%  perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.2        0.24 ± 25%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.00            +0.2        0.24 ± 28%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.00            +0.3        0.26 ± 23%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.3        0.27 ± 52%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.3        0.28 ± 27%  perf-profile.self.cycles-pp.check_cpu_stall
      0.00            +0.3        0.28 ± 40%  perf-profile.self.cycles-pp.perf_rotate_context
      0.00            +0.3        0.28 ± 64%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.3        0.30 ± 50%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.00            +0.3        0.31 ± 27%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.00            +0.3        0.31 ± 37%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.00            +0.3        0.34 ± 26%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.00            +0.3        0.34 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.3        0.35 ± 39%  perf-profile.self.cycles-pp.scheduler_tick
      0.00            +0.4        0.35 ± 37%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.4        0.36 ± 44%  perf-profile.self.cycles-pp.native_apic_mem_write
      0.00            +0.4        0.38 ± 20%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.00            +0.4        0.39 ± 27%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.00            +0.4        0.40 ± 23%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.4        0.41 ± 30%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.4        0.44 ± 12%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.5        0.46 ± 31%  perf-profile.self.cycles-pp.timerqueue_add
      0.00            +0.5        0.46 ± 21%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.00            +0.5        0.51 ± 22%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.5        0.52 ± 29%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.5        0.54 ± 44%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.6        0.55 ± 11%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.00            +0.6        0.55 ± 21%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.6        0.56 ± 12%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.6        0.58 ± 19%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.6        0.60 ± 25%  perf-profile.self.cycles-pp.ktime_get
      0.00            +1.6        1.57 ± 29%  perf-profile.self.cycles-pp.menu_select
      0.00            +2.0        2.02 ± 18%  perf-profile.self.cycles-pp.cpuidle_enter_state
     21.44 ± 35%     +40.0       61.40 ±  2%  perf-profile.self.cycles-pp.intel_idle



***************************************************************************************************
lkp-cfl-d2: 12 threads 1 sockets Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz (Coffee Lake) with 32G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/need_x/option_a/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/true/500px Copy From Window To Window/debian-x86_64-phoronix/lkp-cfl-d2/x11perf-1.1.1/phoronix-test-suite

commit: 
  a525b95417 ("cpufreq/amd-pstate: Remove fast_switch_possible flag from active driver")
  278dfbd17c ("cpufreq: Return failure if fast_switch is not set and fast_switch_possible is set")

a525b954173e74cd 278dfbd17c5d0767834471d7fea 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6          100%           6:6     kmsg.cpufreq:fast_switch_possible_is_enabled_but_fast_switch_callback_is_not_set
         %stddev     %change         %stddev
             \          |                \  
    711.17 ± 13%    +756.8%       6093 ± 45%  phoronix-test-suite.time.involuntary_context_switches
    125556            -4.0%     120523        phoronix-test-suite.time.maximum_resident_set_size
    193366           -23.6%     147783        phoronix-test-suite.time.minor_page_faults
     35.17          +136.0%      83.00        phoronix-test-suite.time.percent_of_cpu_this_job_got
     28.44          +251.3%      99.90        phoronix-test-suite.time.user_time
   1411873 ±  7%     -79.4%     290969 ± 10%  phoronix-test-suite.time.voluntary_context_switches
     11105            -7.3%      10294        phoronix-test-suite.x11perf.500pxCopyFromWindowToWindow.operations___second
 1.596e+09           -10.0%  1.436e+09        cpuidle..time
   3803740 ±  2%     -31.3%    2612320        cpuidle..usage
      4.28            -4.0        0.32        mpstat.cpu.all.iowait%
      2.26 ±  2%      +1.4        3.70        mpstat.cpu.all.irq%
      0.20 ±  3%      +0.1        0.26        mpstat.cpu.all.soft%
      1.61 ±  2%      +0.6        2.23        mpstat.cpu.all.sys%
      2.87            +9.7       12.59        mpstat.cpu.all.usr%
     88.00            -9.1%      80.00        vmstat.cpu.id
      2.50 ± 20%    +380.0%      12.00        vmstat.cpu.us
      2093            -2.3%       2045        vmstat.io.bi
  10868294           -76.8%    2519224        vmstat.memory.cache
  21085319           +40.1%   29541029        vmstat.memory.free
      0.00         +1e+102%       1.00        vmstat.procs.r
     32259 ±  3%     -52.1%      15452 ±  2%  vmstat.system.cs
     18239            -7.5%      16870        vmstat.system.in
    459850            -9.1%     417876        meminfo.AnonPages
  10854060           -77.5%    2446909        meminfo.Cached
  10787077           -78.3%    2346035        meminfo.Committed_AS
   1211148 ±  2%      -7.4%    1121115        meminfo.Inactive(anon)
     99909           -24.9%      75030        meminfo.KReclaimable
    150648           -23.1%     115779        meminfo.Mapped
  22114323           +38.6%   30641210        meminfo.MemAvailable
  20999037           +40.7%   29538155        meminfo.MemFree
  11664521           -73.2%    3125406        meminfo.Memused
     22823           -71.3%       6547        meminfo.PageTables
     99909           -24.9%      75030        meminfo.SReclaimable
     96043           -35.6%      61884        meminfo.SUnreclaim
   9422747           -89.2%    1015386        meminfo.Shmem
    195953           -30.1%     136915        meminfo.Slab
   8667525           -96.4%     308501        meminfo.Unevictable
  12972755           -75.7%    3154603        meminfo.max_used_kB
      0.42 ± 21%     +77.8%       0.75 ± 21%  sched_debug.cfs_rq:/.h_nr_running.avg
     13959 ±  5%    +127.0%      31685 ± 12%  sched_debug.cfs_rq:/.min_vruntime.avg
     30077 ±  8%    +127.7%      68497 ± 16%  sched_debug.cfs_rq:/.min_vruntime.max
      7885 ±  9%    +118.6%      17233 ± 12%  sched_debug.cfs_rq:/.min_vruntime.min
      6353 ± 13%    +143.0%      15442 ± 18%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.41 ± 21%     +45.6%       0.60 ± 11%  sched_debug.cfs_rq:/.nr_running.avg
    370.63 ± 14%     +45.2%     537.98 ± 11%  sched_debug.cfs_rq:/.runnable_avg.avg
    961.25 ±  8%     +45.3%       1397 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
    259.86 ±  9%     +43.6%     373.22 ± 12%  sched_debug.cfs_rq:/.runnable_avg.stddev
      6354 ± 13%    +143.1%      15448 ± 18%  sched_debug.cfs_rq:/.spread0.stddev
    352.22 ± 13%     +32.7%     467.44 ± 11%  sched_debug.cfs_rq:/.util_avg.avg
    935.44 ±  7%     +32.4%       1238 ±  6%  sched_debug.cfs_rq:/.util_avg.max
    256.68 ±  9%     +34.4%     345.04 ± 10%  sched_debug.cfs_rq:/.util_avg.stddev
     76.34 ± 22%     +78.9%     136.54 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    753033 ±  6%     +18.8%     894877 ± 10%  sched_debug.cpu.avg_idle.avg
      0.54 ± 42%    +243.8%       1.85 ± 13%  sched_debug.cpu.clock.stddev
      0.00 ± 12%     +78.0%       0.00 ± 13%  sched_debug.cpu.next_balance.stddev
      0.43 ± 23%     +74.1%       0.75 ± 18%  sched_debug.cpu.nr_running.avg
    199704 ± 17%     -53.6%      92716 ± 19%  sched_debug.cpu.nr_switches.avg
    449460 ± 20%     -53.4%     209625 ± 18%  sched_debug.cpu.nr_switches.max
     58141 ± 39%     -71.6%      16484 ± 29%  sched_debug.cpu.nr_switches.min
    117521 ± 17%     -51.4%      57142 ± 25%  sched_debug.cpu.nr_switches.stddev
    114963            -9.1%     104454        proc-vmstat.nr_anon_pages
    553299           +38.5%     766481        proc-vmstat.nr_dirty_background_threshold
   1107953           +38.5%    1534837        proc-vmstat.nr_dirty_threshold
   2714060           -77.4%     612214        proc-vmstat.nr_file_pages
   5249754           +40.7%    7384644        proc-vmstat.nr_free_pages
    302779 ±  2%      -7.4%     280420        proc-vmstat.nr_inactive_anon
      6151            +1.4%       6236        proc-vmstat.nr_kernel_stack
     37671           -23.2%      28939        proc-vmstat.nr_mapped
      5705           -71.3%       1638        proc-vmstat.nr_page_table_pages
   2355704           -89.2%     253805        proc-vmstat.nr_shmem
     24977           -24.9%      18757        proc-vmstat.nr_slab_reclaimable
     24010           -35.6%      15470        proc-vmstat.nr_slab_unreclaimable
   2166906           -96.4%      76929        proc-vmstat.nr_unevictable
    302779 ±  2%      -7.4%     280420        proc-vmstat.nr_zone_inactive_anon
   2166906           -96.4%      76929        proc-vmstat.nr_zone_unevictable
  10747274 ±  3%     -92.9%     765514        proc-vmstat.numa_hit
  10756248 ±  3%     -92.9%     765422        proc-vmstat.numa_local
  10997298 ±  3%     -91.8%     902283        proc-vmstat.pgalloc_normal
    501839            +6.5%     534236 ±  2%  proc-vmstat.pgfault
  10872643 ±  3%     -92.9%     775875        proc-vmstat.pgfree
     55315           +28.2%      70928 ±  2%  proc-vmstat.pgreuse
  10027217 ±  3%     -97.0%     305188        proc-vmstat.unevictable_pgs_culled
  10027217 ±  3%     -97.0%     305188        proc-vmstat.unevictable_pgs_rescued
  10027229 ±  3%     -97.0%     305217        proc-vmstat.unevictable_pgs_scanned
     51.17           +88.2%      96.32        turbostat.Any%C0
    340.83           -51.4%     165.67        turbostat.Avg_MHz
      8.10           +12.6       20.71        turbostat.Busy%
      4202           -81.0%     800.00        turbostat.Bzy_MHz
    849019           -12.5%     743127        turbostat.C1E
      3.53            -1.0        2.48        turbostat.C1E%
     72327 ±  2%     -66.7%      24104 ±  2%  turbostat.C3
      2.99 ±  3%      -2.7        0.31 ±  2%  turbostat.C3%
    723419           +14.3%     827187        turbostat.C6
    848543           -20.8%     671679        turbostat.C8
     47.43           -12.0       35.46        turbostat.C8%
     19.64           +24.4%      24.45        turbostat.CPU%c1
      5.18 ±  3%     -92.3%       0.40 ±  4%  turbostat.CPU%c3
     27.31           -50.3%      13.58        turbostat.CPU%c7
     32.05           +32.8       64.90        turbostat.CPUGFX%
     18.82           -77.2%       4.28        turbostat.CorWatt
     69.50           -44.1%      38.83        turbostat.CoreTmp
     73.77           -12.0%      64.94        turbostat.GFX%C0
     26.07 ±  2%     +32.0%      34.42        turbostat.GFX%rc6
     11.01           -13.8%       9.48        turbostat.GFXWatt
   1003094 ± 11%     -99.4%       5641 ± 53%  turbostat.POLL
      0.10 ± 10%      -0.1        0.01 ± 35%  turbostat.POLL%
     68.83           -43.1%      39.17        turbostat.PkgTmp
     30.81           -52.5%      14.65        turbostat.PkgWatt
      2.72            -4.7%       2.59        turbostat.RAMWatt
     84.82          +168.2%     227.52        turbostat.Totl%C0
    100.09           -21.4%      78.69        perf-stat.i.MPKI
 4.224e+08           -21.1%  3.333e+08        perf-stat.i.branch-instructions
      2.16 ±  3%      +1.8        3.93        perf-stat.i.branch-miss-rate%
  12591395           +10.0%   13851976        perf-stat.i.branch-misses
  21154943           -12.8%   18457066 ±  2%  perf-stat.i.cache-misses
 1.278e+08           -21.3%  1.006e+08        perf-stat.i.cache-references
     32972 ±  3%     -52.4%      15699 ±  2%  perf-stat.i.context-switches
      2.39           -46.7%       1.27        perf-stat.i.cpi
 3.498e+09           -47.9%  1.823e+09        perf-stat.i.cpu-cycles
     26.99 ±  2%      +7.8%      29.10 ±  2%  perf-stat.i.cpu-migrations
    647.57 ± 10%     -67.8%     208.52 ±  6%  perf-stat.i.cycles-between-cache-misses
      0.21 ±  4%      -0.0        0.17 ±  3%  perf-stat.i.dTLB-load-miss-rate%
    616008 ±  3%     -22.4%     477839 ±  4%  perf-stat.i.dTLB-load-misses
 4.915e+08           -26.4%  3.616e+08        perf-stat.i.dTLB-loads
 2.558e+08           -33.0%  1.714e+08        perf-stat.i.dTLB-stores
    458573 ± 27%     -40.5%     272629 ± 14%  perf-stat.i.iTLB-load-misses
   4257436 ±  2%     -16.5%    3554676 ±  2%  perf-stat.i.iTLB-loads
 2.038e+09           -22.3%  1.584e+09        perf-stat.i.instructions
      0.50           +67.1%       0.83        perf-stat.i.ipc
      5.03 ±  7%     -58.7%       2.08 ± 10%  perf-stat.i.major-faults
      0.29           -47.9%       0.15        perf-stat.i.metric.GHz
    659.63 ±  2%     -21.7%     516.58        perf-stat.i.metric.K/sec
    108.42           -25.7%      80.56        perf-stat.i.metric.M/sec
      3039            +5.6%       3211 ±  2%  perf-stat.i.minor-faults
      0.00 ± 17%      +0.0        0.00 ± 12%  perf-stat.i.node-load-miss-rate%
   1450700            -6.0%    1363538        perf-stat.i.node-loads
      0.00 ± 28%      +0.0        0.00 ± 19%  perf-stat.i.node-store-miss-rate%
   6054128 ±  3%     -79.8%    1225203 ±  2%  perf-stat.i.node-stores
      3044            +5.5%       3213 ±  2%  perf-stat.i.page-faults
      2.98            +1.2        4.15        perf-stat.overall.branch-miss-rate%
     16.55            +1.8       18.35 ±  2%  perf-stat.overall.cache-miss-rate%
      1.72           -32.9%       1.15        perf-stat.overall.cpi
    165.40           -40.3%      98.75        perf-stat.overall.cycles-between-cache-misses
      0.58           +49.1%       0.87        perf-stat.overall.ipc
      0.00 ± 40%      +0.0        0.00 ±  9%  perf-stat.overall.node-store-miss-rate%
 4.195e+08           -21.1%   3.31e+08        perf-stat.ps.branch-instructions
  12510468            +9.9%   13751528        perf-stat.ps.branch-misses
  21007097           -12.7%   18338973 ±  2%  perf-stat.ps.cache-misses
 1.269e+08           -21.2%   99965770        perf-stat.ps.cache-references
     32738 ±  3%     -52.4%      15579 ±  2%  perf-stat.ps.context-switches
 3.474e+09           -47.9%   1.81e+09        perf-stat.ps.cpu-cycles
     26.81 ±  2%      +7.8%      28.90 ±  2%  perf-stat.ps.cpu-migrations
    611716 ±  3%     -22.4%     474612 ±  4%  perf-stat.ps.dTLB-load-misses
 4.882e+08           -26.4%  3.591e+08        perf-stat.ps.dTLB-loads
  2.54e+08           -33.0%  1.702e+08        perf-stat.ps.dTLB-stores
    455336 ± 27%     -40.5%     270782 ± 14%  perf-stat.ps.iTLB-load-misses
   4227298 ±  2%     -16.5%    3531717 ±  2%  perf-stat.ps.iTLB-loads
 2.024e+09           -22.3%  1.573e+09        perf-stat.ps.instructions
      5.00 ±  7%     -58.8%       2.06 ± 10%  perf-stat.ps.major-faults
      3019            +5.6%       3187 ±  2%  perf-stat.ps.minor-faults
   1440523            -5.9%    1354982        perf-stat.ps.node-loads
   6011497 ±  3%     -79.8%    1217164 ±  2%  perf-stat.ps.node-stores
      3024            +5.5%       3189 ±  2%  perf-stat.ps.page-faults
 2.908e+11           -19.6%  2.338e+11        perf-stat.total.instructions
     42.60 ±  8%     -23.2       19.38 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     40.68 ±  8%     -22.8       17.90 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.00 ± 15%     -16.6        3.44 ± 12%  perf-profile.calltrace.cycles-pp.drm_ioctl_kernel.drm_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.45 ± 15%     -16.4        4.07 ±  9%  perf-profile.calltrace.cycles-pp.drm_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.70 ± 14%     -16.3        4.44 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.64 ± 17%      -5.3        0.30 ±101%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dentry_kill.dput.__fput
      5.64 ± 17%      -5.3        0.30 ±101%  perf-profile.calltrace.cycles-pp.shmem_evict_inode.evict.__dentry_kill.dentry_kill.dput
      5.62 ± 17%      -5.3        0.30 ±101%  perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill.dentry_kill
      7.24 ± 39%      -4.2        3.05 ± 15%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.08 ± 18%      -1.5        2.60 ±  9%  perf-profile.calltrace.cycles-pp.do_writev.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.89 ± 18%      -1.4        2.47 ± 10%  perf-profile.calltrace.cycles-pp.vfs_writev.do_writev.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.71 ± 18%      -1.3        2.37 ± 10%  perf-profile.calltrace.cycles-pp.do_iter_write.vfs_writev.do_writev.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.55 ± 18%      -1.3        2.30 ± 10%  perf-profile.calltrace.cycles-pp.do_iter_readv_writev.do_iter_write.vfs_writev.do_writev.do_syscall_64
      3.49 ± 17%      -1.2        2.27 ± 11%  perf-profile.calltrace.cycles-pp.sock_write_iter.do_iter_readv_writev.do_iter_write.vfs_writev.do_writev
      3.29 ± 18%      -1.1        2.14 ± 10%  perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_write_iter.do_iter_readv_writev.do_iter_write.vfs_writev
      2.48 ± 23%      -1.0        1.48 ± 13%  perf-profile.calltrace.cycles-pp.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.70 ± 18%      -1.0        2.72 ±  9%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
      2.26 ± 23%      -0.9        1.37 ± 12%  perf-profile.calltrace.cycles-pp.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.67 ± 39%      -0.8        0.90 ± 26%  perf-profile.calltrace.cycles-pp.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.00 ± 23%      -0.8        1.24 ± 11%  perf-profile.calltrace.cycles-pp.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.06 ± 41%      -0.7        0.33 ±101%  perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64
      1.57 ± 39%      -0.7        0.86 ± 25%  perf-profile.calltrace.cycles-pp.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.89 ± 24%      -0.7        1.19 ± 14%  perf-profile.calltrace.cycles-pp.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64
      1.48 ± 40%      -0.7        0.80 ± 27%  perf-profile.calltrace.cycles-pp.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.75 ± 23%      -0.7        1.09 ± 17%  perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg
      1.70 ± 23%      -0.7        1.05 ± 16%  perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
      1.09 ± 18%      -0.6        0.44 ± 72%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
      1.12 ± 19%      -0.6        0.53 ± 47%  perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.do_iter_readv_writev
      1.26 ± 18%      -0.5        0.72 ± 16%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.do_iter_readv_writev.do_iter_write
      0.75 ± 16%      -0.5        0.28 ±100%  perf-profile.calltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.____sys_recvmsg
      1.14 ± 16%      -0.4        0.69 ± 49%  perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.96 ± 17%      -0.4        0.53 ± 48%  perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
      1.01 ± 16%      -0.4        0.59 ± 48%  perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.92 ± 16%      -0.4        0.52 ± 47%  perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      1.34 ± 16%      -0.4        0.95 ± 20%  perf-profile.calltrace.cycles-pp.__entry_text_start
      1.05 ± 14%      +0.4        1.44 ± 15%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.76 ± 18%      +0.5        1.22 ± 12%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      1.14 ± 15%      +0.5        1.64 ± 12%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.10 ±223%      +0.5        0.65 ± 11%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.09 ±223%      +0.6        0.64 ± 18%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.09 ±223%      +0.6        0.66 ± 19%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.08 ±223%      +0.6        0.73 ± 16%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.40 ± 20%      +0.8        2.22 ±  9%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.09 ±223%      +0.8        0.94 ± 23%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.68 ± 20%      +0.9        2.58 ±  8%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.42 ± 10%      +1.0        2.40 ± 14%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.14 ± 20%      +1.0        2.16 ± 10%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.89 ± 22%      +1.0        2.92 ± 10%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      3.14 ± 26%      +1.7        4.86 ±  9%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.81 ± 26%      +2.1        5.95 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.93 ± 26%      +2.3        6.25 ±  7%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      6.30 ± 18%      +3.2        9.46 ±  9%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      6.93 ± 20%      +3.5       10.46 ± 11%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     37.49 ±  5%     +21.5       59.02 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     42.24 ±  4%     +22.4       64.61 ±  8%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     42.29 ±  4%     +22.4       64.67 ±  8%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     42.28 ±  4%     +22.4       64.66 ±  8%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     39.44 ±  4%     +22.7       62.12 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     27.18 ±  6%     +23.8       50.99 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle_ibrs.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     40.48 ±  6%     +25.5       65.93 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     45.98 ±  4%     +26.8       72.75 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     42.67 ±  8%     -23.3       19.40 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     40.70 ±  8%     -22.8       17.93 ±  5%  perf-profile.children.cycles-pp.do_syscall_64
     20.00 ± 15%     -16.6        3.45 ± 12%  perf-profile.children.cycles-pp.drm_ioctl_kernel
     20.45 ± 15%     -16.4        4.08 ± 10%  perf-profile.children.cycles-pp.drm_ioctl
     20.71 ± 14%     -16.3        4.44 ±  8%  perf-profile.children.cycles-pp.__x64_sys_ioctl
     15.06 ± 17%     -13.4        1.71 ± 15%  perf-profile.children.cycles-pp.shmem_read_mapping_page_gfp
     14.79 ± 18%     -13.1        1.68 ± 17%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      5.78 ± 16%      -5.0        0.78 ± 14%  perf-profile.children.cycles-pp.dentry_kill
      5.80 ± 17%      -5.0        0.80 ± 13%  perf-profile.children.cycles-pp.__fput
      5.78 ± 16%      -5.0        0.78 ± 14%  perf-profile.children.cycles-pp.__dentry_kill
      5.77 ± 16%      -5.0        0.77 ± 14%  perf-profile.children.cycles-pp.evict
      5.77 ± 16%      -5.0        0.77 ± 14%  perf-profile.children.cycles-pp.shmem_evict_inode
      5.76 ± 16%      -5.0        0.77 ± 14%  perf-profile.children.cycles-pp.shmem_undo_range
      5.79 ± 16%      -5.0        0.80 ± 12%  perf-profile.children.cycles-pp.dput
      7.28 ± 39%      -4.2        3.08 ± 14%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.96 ± 23%      -3.9        0.09 ± 43%  perf-profile.children.cycles-pp.poll_idle
      3.36 ± 18%      -2.9        0.45 ± 15%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      3.07 ± 17%      -2.7        0.32 ± 50%  perf-profile.children.cycles-pp.clear_page_erms
      3.00 ± 23%      -2.5        0.47 ± 30%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_folio
      2.90 ± 16%      -2.5        0.41 ±  9%  perf-profile.children.cycles-pp.release_pages
      2.76 ± 16%      -2.4        0.34 ± 12%  perf-profile.children.cycles-pp.__pagevec_release
      2.76 ± 48%      -2.3        0.42 ± 35%  perf-profile.children.cycles-pp.check_move_unevictable_pages
      2.67 ± 48%      -2.3        0.41 ± 39%  perf-profile.children.cycles-pp.check_move_unevictable_folios
      2.52 ± 17%      -2.2        0.36 ± 15%  perf-profile.children.cycles-pp.truncate_inode_folio
      2.55 ± 24%      -2.1        0.42 ± 35%  perf-profile.children.cycles-pp.shmem_alloc_folio
      2.32 ± 17%      -2.0        0.33 ± 16%  perf-profile.children.cycles-pp.filemap_remove_folio
      2.17 ± 22%      -1.8        0.38 ± 33%  perf-profile.children.cycles-pp.vma_alloc_folio
      1.95 ± 17%      -1.7        0.30 ± 11%  perf-profile.children.cycles-pp.__filemap_remove_folio
      4.09 ± 18%      -1.5        2.60 ±  9%  perf-profile.children.cycles-pp.do_writev
      3.89 ± 18%      -1.4        2.47 ± 10%  perf-profile.children.cycles-pp.vfs_writev
      1.72 ± 19%      -1.4        0.32 ± 33%  perf-profile.children.cycles-pp.__folio_alloc
      1.75 ± 20%      -1.4        0.36 ± 31%  perf-profile.children.cycles-pp.__alloc_pages
      3.71 ± 18%      -1.3        2.37 ± 10%  perf-profile.children.cycles-pp.do_iter_write
      3.56 ± 18%      -1.2        2.32 ±  9%  perf-profile.children.cycles-pp.do_iter_readv_writev
      3.50 ± 17%      -1.2        2.27 ± 11%  perf-profile.children.cycles-pp.sock_write_iter
      1.32 ± 15%      -1.2        0.15 ± 19%  perf-profile.children.cycles-pp.free_unref_page_list
      3.29 ± 18%      -1.1        2.14 ± 10%  perf-profile.children.cycles-pp.unix_stream_sendmsg
      1.40 ± 23%      -1.1        0.29 ± 36%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.26 ±  8%      -1.1        0.16 ± 30%  perf-profile.children.cycles-pp.xas_store
      2.90 ± 20%      -1.0        1.85 ± 14%  perf-profile.children.cycles-pp.sock_recvmsg
      1.24 ± 14%      -1.0        0.22 ± 21%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      2.70 ± 20%      -1.0        1.68 ± 17%  perf-profile.children.cycles-pp.unix_stream_recvmsg
      2.64 ± 20%      -1.0        1.64 ± 17%  perf-profile.children.cycles-pp.unix_stream_read_generic
      2.48 ± 23%      -1.0        1.49 ± 13%  perf-profile.children.cycles-pp.__sys_recvmsg
      1.24 ± 15%      -1.0        0.26 ± 49%  perf-profile.children.cycles-pp.folio_add_lru
      3.74 ± 17%      -1.0        2.76 ±  8%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.18 ± 25%      -1.0        0.23 ± 41%  perf-profile.children.cycles-pp.rmqueue
      2.26 ± 23%      -0.9        1.37 ± 12%  perf-profile.children.cycles-pp.___sys_recvmsg
      1.08 ± 16%      -0.8        0.24 ± 50%  perf-profile.children.cycles-pp.folio_batch_move_lru
      1.17 ± 66%      -0.8        0.33 ± 25%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.67 ± 39%      -0.8        0.90 ± 26%  perf-profile.children.cycles-pp.__x64_sys_epoll_wait
      2.00 ± 23%      -0.8        1.24 ± 11%  perf-profile.children.cycles-pp.____sys_recvmsg
      0.85 ± 28%      -0.7        0.12 ± 50%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.57 ± 39%      -0.7        0.86 ± 25%  perf-profile.children.cycles-pp.do_epoll_wait
      0.87 ± 29%      -0.7        0.17 ± 31%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      1.48 ± 40%      -0.7        0.80 ± 27%  perf-profile.children.cycles-pp.ep_poll
      0.76 ±  9%      -0.6        0.12 ± 21%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.74 ± 13%      -0.6        0.10 ± 22%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.73 ± 15%      -0.6        0.10 ± 50%  perf-profile.children.cycles-pp.lru_add_fn
      0.73 ± 15%      -0.6        0.12 ± 60%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.72 ± 29%      -0.6        0.10 ± 58%  perf-profile.children.cycles-pp.rmqueue_bulk
      1.26 ± 19%      -0.5        0.72 ± 16%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
      1.12 ± 19%      -0.5        0.61 ± 18%  perf-profile.children.cycles-pp.alloc_skb_with_frags
      0.57 ± 11%      -0.5        0.08 ± 21%  perf-profile.children.cycles-pp.__mod_node_page_state
      1.09 ± 19%      -0.5        0.60 ± 19%  perf-profile.children.cycles-pp.__alloc_skb
      0.57 ± 37%      -0.5        0.08 ± 81%  perf-profile.children.cycles-pp.charge_memcg
      1.18 ± 14%      -0.5        0.69 ± 13%  perf-profile.children.cycles-pp.consume_skb
      0.60 ± 19%      -0.5        0.12 ± 21%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      1.16 ± 20%      -0.5        0.70 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.54 ± 15%      -0.5        0.08 ± 51%  perf-profile.children.cycles-pp.__free_one_page
      0.43 ± 26%      -0.4        0.04 ±101%  perf-profile.children.cycles-pp.find_lock_entries
      0.43 ± 17%      -0.4        0.05 ± 81%  perf-profile.children.cycles-pp.xas_load
      1.14 ± 16%      -0.4        0.76 ± 26%  perf-profile.children.cycles-pp.__sys_recvfrom
      0.54 ± 13%      -0.3        0.22 ± 30%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.42 ± 18%      -0.3        0.10 ± 53%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.52 ± 15%      -0.3        0.20 ± 25%  perf-profile.children.cycles-pp.do_mmap
      0.60 ± 16%      -0.3        0.29 ± 22%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.75 ± 19%      -0.3        0.45 ± 26%  perf-profile.children.cycles-pp.ep_poll_callback
      0.33 ± 21%      -0.3        0.04 ±104%  perf-profile.children.cycles-pp.xas_clear_mark
      0.62 ± 11%      -0.3        0.34 ± 19%  perf-profile.children.cycles-pp.unix_destruct_scm
      0.60 ± 12%      -0.3        0.34 ± 18%  perf-profile.children.cycles-pp.sock_wfree
      0.63 ± 11%      -0.3        0.37 ± 27%  perf-profile.children.cycles-pp.skb_release_head_state
      0.53 ± 20%      -0.3        0.27 ± 33%  perf-profile.children.cycles-pp.kmalloc_reserve
      0.30 ± 20%      -0.2        0.05 ± 72%  perf-profile.children.cycles-pp.xas_find_conflict
      0.30 ±  9%      -0.2        0.06 ± 80%  perf-profile.children.cycles-pp.rcu_do_batch
      0.28 ± 34%      -0.2        0.05 ±107%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.52 ± 23%      -0.2        0.29 ± 17%  perf-profile.children.cycles-pp.skb_release_data
      0.41 ± 19%      -0.2        0.18 ± 34%  perf-profile.children.cycles-pp.mmap_region
      0.48 ± 20%      -0.2        0.25 ± 33%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      0.78 ± 16%      -0.2        0.57 ± 18%  perf-profile.children.cycles-pp._raw_spin_lock
      0.24 ± 26%      -0.2        0.03 ±101%  perf-profile.children.cycles-pp.folio_unlock
      0.35 ±  9%      -0.2        0.14 ± 22%  perf-profile.children.cycles-pp.rcu_core
      0.48 ± 20%      -0.2        0.30 ± 21%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.42 ± 10%      -0.2        0.24 ± 21%  perf-profile.children.cycles-pp.unix_write_space
      0.39 ± 25%      -0.2        0.21 ± 34%  perf-profile.children.cycles-pp.ep_autoremove_wake_function
      0.49 ± 19%      -0.2        0.31 ± 28%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.22 ± 21%      -0.2        0.05 ± 72%  perf-profile.children.cycles-pp.__list_add_valid
      0.21 ± 19%      -0.2        0.04 ±105%  perf-profile.children.cycles-pp.try_charge_memcg
      0.23 ± 24%      -0.2        0.06 ± 58%  perf-profile.children.cycles-pp.__folio_throttle_swaprate
      0.44 ± 23%      -0.2        0.27 ± 22%  perf-profile.children.cycles-pp.sock_poll
      0.22 ± 24%      -0.2        0.06 ±110%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.32 ± 26%      -0.2        0.17 ± 33%  perf-profile.children.cycles-pp.__kmem_cache_free
      0.19 ± 25%      -0.2        0.04 ±115%  perf-profile.children.cycles-pp.blk_cgroup_congested
      0.28 ± 28%      -0.2        0.13 ± 17%  perf-profile.children.cycles-pp.unix_poll
      0.35 ± 29%      -0.1        0.21 ± 30%  perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
      0.18 ± 20%      -0.1        0.04 ±110%  perf-profile.children.cycles-pp.memset_orig
      0.35 ± 27%      -0.1        0.22 ± 39%  perf-profile.children.cycles-pp.rep_movs_alternative
      0.30 ± 15%      -0.1        0.18 ± 27%  perf-profile.children.cycles-pp.__slab_free
      0.23 ± 24%      -0.1        0.11 ± 36%  perf-profile.children.cycles-pp.copy_msghdr_from_user
      0.16 ± 37%      -0.1        0.05 ± 77%  perf-profile.children.cycles-pp._copy_from_iter
      0.20 ± 28%      -0.1        0.10 ± 67%  perf-profile.children.cycles-pp.mod_objcg_state
      0.19 ± 25%      -0.1        0.08 ± 65%  perf-profile.children.cycles-pp.import_iovec
      0.18 ± 23%      -0.1        0.07 ± 80%  perf-profile.children.cycles-pp.__import_iovec
      0.30 ±  9%      -0.1        0.19 ± 33%  perf-profile.children.cycles-pp.kmem_cache_free
      0.15 ± 29%      -0.1        0.06 ± 64%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.15 ± 20%      -0.1        0.08 ± 30%  perf-profile.children.cycles-pp.dma_resv_iter_walk_unlocked
      0.15 ± 19%      -0.1        0.09 ± 37%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.06 ± 50%      +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.02 ±141%      +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.account_process_tick
      0.02 ±141%      +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.link_path_walk
      0.06 ± 59%      +0.1        0.14 ± 20%  perf-profile.children.cycles-pp.rb_insert_color
      0.02 ±141%      +0.1        0.10 ± 46%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.02 ±146%      +0.1        0.11 ± 30%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.00            +0.1        0.10 ± 36%  perf-profile.children.cycles-pp.pipe_write
      0.01 ±223%      +0.1        0.11 ± 28%  perf-profile.children.cycles-pp.task_tick_idle
      0.05 ± 76%      +0.1        0.15 ± 24%  perf-profile.children.cycles-pp.dup_mmap
      0.20 ± 21%      +0.1        0.30 ± 24%  perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.1        0.10 ± 36%  perf-profile.children.cycles-pp.show
      0.00            +0.1        0.10 ± 36%  perf-profile.children.cycles-pp.show_time_in_state
      0.09 ± 49%      +0.1        0.19 ± 18%  perf-profile.children.cycles-pp.copy_process
      0.06 ± 75%      +0.1        0.17 ± 21%  perf-profile.children.cycles-pp.dup_mm
      0.00            +0.1        0.11 ± 34%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.02 ±144%      +0.1        0.13 ± 28%  perf-profile.children.cycles-pp.do_futex
      0.01 ±223%      +0.1        0.12 ± 30%  perf-profile.children.cycles-pp.futex_wait
      0.05 ± 49%      +0.1        0.16 ± 44%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.02 ±149%      +0.1        0.14 ± 35%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.05 ± 47%      +0.1        0.16 ± 20%  perf-profile.children.cycles-pp.error_entry
      0.02 ±141%      +0.1        0.13 ± 34%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.19 ± 17%      +0.1        0.31 ± 24%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.02 ±146%      +0.1        0.14 ± 31%  perf-profile.children.cycles-pp.__x64_sys_futex
      0.09 ± 49%      +0.1        0.21 ± 22%  perf-profile.children.cycles-pp.__do_sys_clone
      0.09 ± 49%      +0.1        0.21 ± 22%  perf-profile.children.cycles-pp.kernel_clone
      0.01 ±223%      +0.1        0.13 ± 58%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.04 ±101%      +0.1        0.16 ± 41%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.00            +0.1        0.12 ± 45%  perf-profile.children.cycles-pp.traverse
      0.03 ±102%      +0.1        0.15 ± 45%  perf-profile.children.cycles-pp.vfs_write
      0.11 ± 15%      +0.1        0.24 ± 17%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.18 ± 22%      +0.1        0.31 ± 26%  perf-profile.children.cycles-pp.find_busiest_group
      0.04 ± 73%      +0.1        0.17 ± 45%  perf-profile.children.cycles-pp.ksys_write
      0.00            +0.1        0.13 ± 41%  perf-profile.children.cycles-pp.vsnprintf
      0.00            +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.pipe_read
      0.05 ± 45%      +0.1        0.19 ± 18%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.42 ± 19%      +0.2        0.58 ± 13%  perf-profile.children.cycles-pp.perf_rotate_context
      0.18 ± 29%      +0.2        0.34 ± 18%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.04 ± 71%      +0.2        0.20 ± 27%  perf-profile.children.cycles-pp.do_filp_open
      0.04 ± 71%      +0.2        0.20 ± 27%  perf-profile.children.cycles-pp.path_openat
      0.04 ± 75%      +0.2        0.22 ± 50%  perf-profile.children.cycles-pp.do_read_fault
      0.10 ± 32%      +0.2        0.28 ± 45%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.05 ± 45%      +0.2        0.24 ± 22%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.02 ±142%      +0.2        0.21 ± 56%  perf-profile.children.cycles-pp.filemap_map_pages
      0.14 ± 31%      +0.2        0.33 ± 11%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.04 ± 72%      +0.2        0.23 ± 18%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.12 ± 25%      +0.2        0.31 ± 33%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.04 ± 71%      +0.2        0.23 ± 18%  perf-profile.children.cycles-pp.do_sys_openat2
      0.07 ± 58%      +0.2        0.26 ± 26%  perf-profile.children.cycles-pp.__mmput
      0.07 ± 58%      +0.2        0.26 ± 26%  perf-profile.children.cycles-pp.exit_mmap
      0.27 ± 27%      +0.2        0.46 ± 23%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.14 ± 31%      +0.2        0.34 ± 29%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.06 ± 25%      +0.2        0.25 ± 15%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.29 ± 23%      +0.2        0.48 ± 25%  perf-profile.children.cycles-pp.handle_mm_fault
      0.10 ± 17%      +0.2        0.31 ± 39%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.09 ± 23%      +0.2        0.31 ± 31%  perf-profile.children.cycles-pp.load_elf_binary
      0.35 ± 24%      +0.2        0.57 ± 20%  perf-profile.children.cycles-pp.exc_page_fault
      0.34 ± 24%      +0.2        0.57 ± 19%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.39 ± 11%      +0.2        0.62 ± 34%  perf-profile.children.cycles-pp.rebalance_domains
      0.09 ± 21%      +0.2        0.32 ± 33%  perf-profile.children.cycles-pp.search_binary_handler
      0.10 ± 13%      +0.2        0.33 ± 31%  perf-profile.children.cycles-pp.bprm_execve
      0.09 ± 21%      +0.2        0.33 ± 32%  perf-profile.children.cycles-pp.exec_binprm
      0.01 ±223%      +0.3        0.26 ± 49%  perf-profile.children.cycles-pp.seq_read_iter
      0.47 ± 14%      +0.3        0.72 ± 14%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.46 ± 14%      +0.3        0.71 ± 14%  perf-profile.children.cycles-pp.tick_irq_enter
      0.24 ± 28%      +0.3        0.51 ± 15%  perf-profile.children.cycles-pp.read_tsc
      0.12 ± 15%      +0.3        0.41 ± 27%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.12 ± 17%      +0.3        0.41 ± 27%  perf-profile.children.cycles-pp.do_execveat_common
      0.41 ± 25%      +0.3        0.70 ± 11%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.14 ± 23%      +0.3        0.44 ± 30%  perf-profile.children.cycles-pp.clockevents_program_event
      0.50 ± 21%      +0.3        0.83 ± 18%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.09 ± 33%      +0.4        0.48 ± 35%  perf-profile.children.cycles-pp.vfs_read
      0.09 ± 31%      +0.4        0.51 ± 32%  perf-profile.children.cycles-pp.ksys_read
      0.40 ± 13%      +0.4        0.82 ± 15%  perf-profile.children.cycles-pp.ktime_get
      1.54 ± 11%      +0.5        2.00 ± 10%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.98 ± 17%      +0.5        1.47 ± 11%  perf-profile.children.cycles-pp.scheduler_tick
      0.47 ± 19%      +0.6        1.03 ± 27%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.78 ± 19%      +0.9        2.69 ± 10%  perf-profile.children.cycles-pp.update_process_times
      2.09 ± 19%      +0.9        3.03 ±  9%  perf-profile.children.cycles-pp.tick_sched_handle
      1.22 ± 15%      +1.0        2.22 ± 10%  perf-profile.children.cycles-pp.intel_idle
      1.50 ±  9%      +1.1        2.56 ± 17%  perf-profile.children.cycles-pp.menu_select
      2.34 ± 20%      +1.1        3.43 ±  7%  perf-profile.children.cycles-pp.tick_sched_timer
      3.76 ± 21%      +1.8        5.56 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      4.39 ± 21%      +2.2        6.63 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      4.53 ± 21%      +2.5        7.00 ±  6%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      6.93 ± 17%      +3.5       10.44 ±  7%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      7.50 ± 17%      +3.8       11.31 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     42.29 ±  4%     +22.4       64.67 ±  8%  perf-profile.children.cycles-pp.start_secondary
     27.19 ±  6%     +23.8       51.00 ±  2%  perf-profile.children.cycles-pp.intel_idle_ibrs
     40.99 ±  6%     +25.6       66.55 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     41.02 ±  6%     +25.6       66.63 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
     45.98 ±  4%     +26.8       72.75 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     45.98 ±  4%     +26.8       72.75 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     45.95 ±  4%     +26.8       72.73 ±  2%  perf-profile.children.cycles-pp.do_idle
     43.10 ±  5%     +26.9       70.00 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      3.86 ± 23%      -3.8        0.08 ± 59%  perf-profile.self.cycles-pp.poll_idle
      3.56 ± 19%      -3.4        0.15 ± 37%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      3.03 ± 17%      -2.7        0.28 ± 40%  perf-profile.self.cycles-pp.clear_page_erms
      3.81 ± 18%      -1.3        2.49 ± 15%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      3.73 ± 17%      -1.0        2.76 ±  8%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.08 ± 26%      -0.9        0.15 ± 38%  perf-profile.self.cycles-pp.check_move_unevictable_folios
      0.64 ±  9%      -0.6        0.07 ± 71%  perf-profile.self.cycles-pp.xas_store
      0.66 ± 14%      -0.6        0.09 ± 62%  perf-profile.self.cycles-pp.release_pages
      2.03 ± 18%      -0.5        1.50 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.61 ± 11%      -0.5        0.09 ± 83%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.54 ± 13%      -0.5        0.08 ± 21%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.54 ± 15%      -0.5        0.09 ± 44%  perf-profile.self.cycles-pp.lru_add_fn
      0.52 ± 16%      -0.4        0.08 ± 82%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.52 ± 11%      -0.4        0.09 ± 66%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.40 ± 15%      -0.3        0.06 ± 83%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.40 ± 17%      -0.3        0.06 ± 48%  perf-profile.self.cycles-pp.__free_one_page
      0.41 ± 18%      -0.3        0.10 ± 50%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.33 ± 29%      -0.3        0.04 ±105%  perf-profile.self.cycles-pp.shmem_alloc_folio
      0.30 ± 26%      -0.3        0.03 ±100%  perf-profile.self.cycles-pp.__filemap_remove_folio
      0.28 ± 21%      -0.2        0.03 ±101%  perf-profile.self.cycles-pp.vma_alloc_folio
      0.28 ± 16%      -0.2        0.04 ±112%  perf-profile.self.cycles-pp.__alloc_pages
      0.40 ±  3%      -0.2        0.16 ± 35%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.88 ± 10%      -0.2        0.64 ± 13%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.28 ± 35%      -0.2        0.05 ±107%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.77 ± 16%      -0.2        0.56 ± 19%  perf-profile.self.cycles-pp._raw_spin_lock
      0.20 ± 23%      -0.2        0.05 ± 72%  perf-profile.self.cycles-pp.__list_add_valid
      0.39 ± 17%      -0.1        0.26 ± 29%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.17 ± 21%      -0.1        0.04 ±110%  perf-profile.self.cycles-pp.memset_orig
      0.29 ± 17%      -0.1        0.16 ± 20%  perf-profile.self.cycles-pp.__slab_free
      0.15 ± 15%      -0.1        0.03 ±101%  perf-profile.self.cycles-pp.try_charge_memcg
      0.20 ±  9%      -0.1        0.10 ± 50%  perf-profile.self.cycles-pp.kmem_cache_free
      0.14 ± 23%      -0.1        0.04 ±107%  perf-profile.self.cycles-pp.__import_iovec
      0.18 ± 24%      -0.1        0.10 ± 30%  perf-profile.self.cycles-pp.sock_wfree
      0.12 ± 12%      -0.1        0.04 ±112%  perf-profile.self.cycles-pp.tick_nohz_stop_idle
      0.11 ± 27%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.filemap_unaccount_folio
      0.02 ±141%      +0.1        0.08 ± 27%  perf-profile.self.cycles-pp.account_process_tick
      0.06 ± 50%      +0.1        0.12 ± 16%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.14 ± 29%      +0.1        0.22 ± 15%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.01 ±223%      +0.1        0.09 ± 48%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.02 ±144%      +0.1        0.10 ± 36%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.06 ± 73%      +0.1        0.15 ± 29%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.05 ± 52%      +0.1        0.14 ± 20%  perf-profile.self.cycles-pp.rb_insert_color
      0.01 ±223%      +0.1        0.11 ± 28%  perf-profile.self.cycles-pp.task_tick_idle
      0.00            +0.1        0.10 ± 20%  perf-profile.self.cycles-pp.tick_sched_timer
      0.04 ± 47%      +0.1        0.16 ± 45%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.05 ± 46%      +0.1        0.16 ± 20%  perf-profile.self.cycles-pp.error_entry
      0.01 ±223%      +0.1        0.13 ± 58%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.11 ± 15%      +0.1        0.24 ± 17%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.05 ± 72%      +0.1        0.18 ± 47%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.10 ± 25%      +0.2        0.28 ± 38%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.05 ± 45%      +0.2        0.23 ± 21%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.10 ± 32%      +0.2        0.28 ± 45%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.21 ± 13%      +0.2        0.40 ± 33%  perf-profile.self.cycles-pp.ktime_get
      0.14 ± 29%      +0.2        0.33 ± 11%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.10 ± 17%      +0.2        0.31 ± 39%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.24 ± 27%      +0.3        0.50 ± 16%  perf-profile.self.cycles-pp.read_tsc
      0.72 ± 19%      +0.3        1.03 ± 14%  perf-profile.self.cycles-pp.cpuidle_enter_state
      1.22 ± 15%      +1.0        2.22 ± 10%  perf-profile.self.cycles-pp.intel_idle
     27.18 ±  6%     +23.8       50.98 ±  2%  perf-profile.self.cycles-pp.intel_idle_ibrs





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



--0KnvGdYZjz/yEpkn
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc2-00007-g278dfbd17c5d"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.4.0-rc2 Kernel Configuration
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
# CONFIG_RT_GROUP_SCHED is not set
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
# CONFIG_CHECKPOINT_RESTORE is not set
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
# CONFIG_EMBEDDED is not set
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
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
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
# CONFIG_X86_CPU_RESCTRL is not set
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
# CONFIG_X86_SGX is not set
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
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
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
# CONFIG_PM_DEBUG is not set
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
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
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
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
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
# CONFIG_SLAB_FREELIST_HARDENED is not set
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
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
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
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
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
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
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
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
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
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

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

# CONFIG_IP_SET is not set
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
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

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
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
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
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_MQPRIO_LIB=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
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
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
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
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
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
# CONFIG_FW_UPLOAD is not set
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
# CONFIG_ZRAM is not set
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
# CONFIG_SCSI_DEBUG is not set
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
# CONFIG_DM_DEBUG is not set
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
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
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
# CONFIG_NETDEVSIM is not set
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
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
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
# CONFIG_IR_SHARP_DECODER is not set
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
# CONFIG_RC_LOOPBACK is not set
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
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
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

# CONFIG_DRM_VGEM is not set
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
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
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
# CONFIG_VIRT_DRIVERS is not set
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
# CONFIG_STAGING is not set
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
# CONFIG_IOMMUFD is not set
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
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
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
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
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
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_DEBUG is not set
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
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
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
# CONFIG_CRYPTO_SM4_GENERIC is not set
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
CONFIG_CRYPTO_OFB=m
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
# CONFIG_PRIME_NUMBERS is not set
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
CONFIG_ZSTD_COMPRESS=y
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
# CONFIG_DMA_MAP_BENCHMARK is not set
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
CONFIG_FRAME_WARN=2048
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
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
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
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SLUB_DEBUG is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
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
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

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
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
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
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
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
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
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
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
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
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
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

--0KnvGdYZjz/yEpkn
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='phoronix-test-suite'
	export testcase='phoronix-test-suite'
	export category='benchmark'
	export need_memory='8G'
	export job_origin='phoronix-test-suite-part1.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-csl-2sp7'
	export tbox_group='lkp-csl-2sp7'
	export submit_id='646a82ad28d5ea5a367f1ad7'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp7/phoronix-test-suite-performance-sin-glibc-bench-1.6.1-debian-x86_64-phoronix-278dfbd17c5d0767834471d7fea71d3127c3ecfb-20230522-23094-320k2o-5.yaml'
	export id='639f5ab40c9c960738f55dc01ffa5ce53c27717d'
	export queuer_version='/zday/lkp'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=96
	export memory='512G'
	export nr_hdd_partitions=1
	export nr_ssd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part1'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204000G800RGN-part1'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part2'
	export brand='Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz'
	export need_kconfig=\{\"XFS_DEBUG\"\=\>\"n\"\}'
'\{\"XFS_WARN\"\=\>\"y\"\}'
'\{\"PM_DEBUG\"\=\>\"n\"\}'
'\{\"PM_SLEEP_DEBUG\"\=\>\"n\"\}'
'\{\"DEBUG_ATOMIC_SLEEP\"\=\>\"n\"\}'
'\{\"DEBUG_SPINLOCK_SLEEP\"\=\>\"n\"\}'
'\{\"CIFS_DEBUG\"\=\>\"n\"\}'
'\{\"SCSI_DEBUG\"\=\>\"n\"\}'
'\{\"NFS_DEBUG\"\=\>\"n\"\}'
'\{\"SUNRPC_DEBUG\"\=\>\"n\"\}'
'\{\"DM_DEBUG\"\=\>\"n\"\}'
'\{\"DEBUG_SHIRQ\"\=\>\"n\"\}'
'\{\"OCFS2_DEBUG_MASKLOG\"\=\>\"n\"\}'
'\{\"DEBUG_MEMORY_INIT\"\=\>\"n\"\}'
'\{\"SLUB_DEBUG\"\=\>\"n\"\}'
'\{\"EXPERT\"\=\>\"y\"\}
	export commit='278dfbd17c5d0767834471d7fea71d3127c3ecfb'
	export ucode='0x5003303'
	export need_kconfig_hw='{"I40E"=>"y"}
SATA_AHCI'
	export rootfs='internal-lkp-server:/osimage/debian/debian-x86_64-phoronix'
	export run_on_local_disk=true
	export force_reboot=1
	export kconfig='x86_64-rhel-8.3'
	export enqueue_time='2023-05-22 04:44:30 +0800'
	export _id='646a82c528d5ea5a367f1ad9'
	export _rt='/result/phoronix-test-suite/performance-sin-glibc-bench-1.6.1/lkp-csl-2sp7/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/278dfbd17c5d0767834471d7fea71d3127c3ecfb'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='21f900bd86b062a08979cdfed379e9e950090bd5'
	export base_commit='f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6'
	export branch='linux-review/Wyes-Karny/amd_pstate-Add-fast_switch-callback/20230518-010448'
	export result_root='/result/phoronix-test-suite/performance-sin-glibc-bench-1.6.1/lkp-csl-2sp7/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/278dfbd17c5d0767834471d7fea71d3127c3ecfb/3'
	export scheduler_version='/lkp/lkp/.src-20230519-164518'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/initramfs/initramfs-20191118.cgz'
	export bootloader_append='root=/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part2
rootflags=subvol=debian-x86_64-phoronix
remote_rootfs=internal-lkp-server:/osimage/debian/debian-x86_64-phoronix
RESULT_ROOT=/result/phoronix-test-suite/performance-sin-glibc-bench-1.6.1/lkp-csl-2sp7/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/278dfbd17c5d0767834471d7fea71d3127c3ecfb/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/278dfbd17c5d0767834471d7fea71d3127c3ecfb/vmlinuz-6.4.0-rc2-00007-g278dfbd17c5d
branch=linux-review/Wyes-Karny/amd_pstate-Add-fast_switch-callback/20230518-010448
job=/lkp/jobs/scheduled/lkp-csl-2sp7/phoronix-test-suite-performance-sin-glibc-bench-1.6.1-debian-x86_64-phoronix-278dfbd17c5d0767834471d7fea71d3127c3ecfb-20230522-23094-320k2o-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3
commit=278dfbd17c5d0767834471d7fea71d3127c3ecfb
initcall_debug
nmi_watchdog=0
max_uptime=2100
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-11/278dfbd17c5d0767834471d7fea71d3127c3ecfb/modules.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export repeat_to=6
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-11/278dfbd17c5d0767834471d7fea71d3127c3ecfb/vmlinuz-6.4.0-rc2-00007-g278dfbd17c5d'
	export dequeue_time='2023-05-22 04:49:12 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp7/phoronix-test-suite-performance-sin-glibc-bench-1.6.1-debian-x86_64-phoronix-278dfbd17c5d0767834471d7fea71d3127c3ecfb-20230522-23094-320k2o-5.cgz'

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

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor debug_mode=0 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='glibc-bench-1.6.1' option_a='sin' $LKP_SRC/tests/wrapper phoronix-test-suite
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='glibc-bench-1.6.1' option_a='sin' $LKP_SRC/stats/wrapper phoronix-test-suite
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	env debug_mode=0 $LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time phoronix-test-suite.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--0KnvGdYZjz/yEpkn
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/phoronix-test-suite-part1.yaml
suite: phoronix-test-suite
testcase: phoronix-test-suite
category: benchmark
need_memory: 8G
phoronix-test-suite:
  test: glibc-bench-1.6.1
  option_a: sin
job_origin: phoronix-test-suite-part1.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
- kbuild_queue_analysis
queue: bisect
testbox: lkp-csl-2sp7
tbox_group: lkp-csl-2sp7
submit_id: 646a6ad028d5eaf8bb7eea1f
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp7/phoronix-test-suite-performance-sin-glibc-bench-1.6.1-debian-x86_64-phoronix-278dfbd17c5d0767834471d7fea71d3127c3ecfb-20230522-63675-ty996t-0.yaml"
id: 187b53cf4e3c18814b56d744b96d3f1793a7f45b
queuer_version: "/zday/lkp"

#! /db/releases/20230517200055/lkp-src/hosts/lkp-csl-2sp7
model: Cascade Lake
nr_node: 2
nr_cpu: 96
memory: 512G
nr_hdd_partitions: 1
nr_ssd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part1"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204000G800RGN-part1"
swap_partitions:
rootfs_partition: "/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part2"
brand: Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz

#! /db/releases/20230517200055/lkp-src/include/category/benchmark
need_kconfig:
- XFS_DEBUG: n
- XFS_WARN: y
- PM_DEBUG: n
- PM_SLEEP_DEBUG: n
- DEBUG_ATOMIC_SLEEP: n
- DEBUG_SPINLOCK_SLEEP: n
- CIFS_DEBUG: n
- SCSI_DEBUG: n
- NFS_DEBUG: n
- SUNRPC_DEBUG: n
- DM_DEBUG: n
- DEBUG_SHIRQ: n
- OCFS2_DEBUG_MASKLOG: n
- DEBUG_MEMORY_INIT: n
- SLUB_DEBUG: n
- EXPERT: y
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-profile:
  debug_mode: 0

#! /db/releases/20230517200055/lkp-src/include/category/ALL
cpufreq_governor: performance

#! /db/releases/20230517200055/lkp-src/include/queue/cyclic
commit: 278dfbd17c5d0767834471d7fea71d3127c3ecfb

#! /db/releases/20230517200055/lkp-src/include/testbox/lkp-csl-2sp7
ucode: '0x5003303'
need_kconfig_hw:
- I40E: y
- SATA_AHCI

#! /db/releases/20230517200055/lkp-src/include/phoronix-test-suite
rootfs: internal-lkp-server:/osimage/debian/debian-x86_64-phoronix
run_on_local_disk: true
force_reboot: 1
kconfig: x86_64-rhel-8.3
enqueue_time: 2023-05-22 03:02:41.136742566 +08:00
_id: 646a6ad028d5eaf8bb7eea1f
_rt: "/result/phoronix-test-suite/performance-sin-glibc-bench-1.6.1/lkp-csl-2sp7/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/278dfbd17c5d0767834471d7fea71d3127c3ecfb"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 21f900bd86b062a08979cdfed379e9e950090bd5
base_commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
branch: linux-devel/devel-hourly-20230518-181700
result_root: "/result/phoronix-test-suite/performance-sin-glibc-bench-1.6.1/lkp-csl-2sp7/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/278dfbd17c5d0767834471d7fea71d3127c3ecfb/1"
scheduler_version: "/lkp/lkp/.src-20230519-164518"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/initramfs/initramfs-20191118.cgz"
bootloader_append:
- root=/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part2
- rootflags=subvol=debian-x86_64-phoronix
- remote_rootfs=internal-lkp-server:/osimage/debian/debian-x86_64-phoronix
- RESULT_ROOT=/result/phoronix-test-suite/performance-sin-glibc-bench-1.6.1/lkp-csl-2sp7/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/278dfbd17c5d0767834471d7fea71d3127c3ecfb/1
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/278dfbd17c5d0767834471d7fea71d3127c3ecfb/vmlinuz-6.4.0-rc2-00007-g278dfbd17c5d
- branch=linux-devel/devel-hourly-20230518-181700
- job=/lkp/jobs/scheduled/lkp-csl-2sp7/phoronix-test-suite-performance-sin-glibc-bench-1.6.1-debian-x86_64-phoronix-278dfbd17c5d0767834471d7fea71d3127c3ecfb-20230522-63675-ty996t-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- commit=278dfbd17c5d0767834471d7fea71d3127c3ecfb
- initcall_debug
- nmi_watchdog=0
- max_uptime=2100
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-11/278dfbd17c5d0767834471d7fea71d3127c3ecfb/modules.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /cephfs/db/releases/20230517200055/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 4.20.0
repeat_to: 3

#! user overrides
kbuild_queue_analysis: 1
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-11/278dfbd17c5d0767834471d7fea71d3127c3ecfb/vmlinuz-6.4.0-rc2-00007-g278dfbd17c5d"
dequeue_time: 2023-05-22 03:15:03.135543569 +08:00

#! /cephfs/db/releases/20230519164737/lkp-src/include/site/inn
job_state: finished
loadavg: 1.70 0.88 0.35 2/1111 7847
start_time: '1684692027'
end_time: '1684692127'
version: "/lkp/lkp/.src-20230519-164557:eaff8b9cdc4e:d2fd25d67481"

--0KnvGdYZjz/yEpkn
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "phoronix-test-suite" "run" "glibc-bench-1.6.1"

--0KnvGdYZjz/yEpkn--
