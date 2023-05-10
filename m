Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE966FD8B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbjEJH4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbjEJHz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:55:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2992D5E
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683705341; x=1715241341;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=sxW4TKzQrRXveUzIMkl3UHYNtQLofLbOznNlNhRgKB8=;
  b=Db8uXcPtIXrE2mSsVaK/5Fpo01S5R4N81v/1K9wCnHm9tWpYy1cueg+u
   n+1GZ3T49wzMx/yXUcyz9Krh8kmtm09iyeFRRXfcP/qUOQyqXygA+XiZu
   7gfmvgGOMQfAxjkKXg9KkrfU8EEgQ7+EessD3+R0Yi3zFYOE5/4OHZcD4
   xwsnlHPcK2vgHZa3yFhBPPGzDlLP98L/6xveP1nFB4265tcJvgHIsFajU
   zr3S7r+D42zC65YLsqxEpQgq6RYPZfEOuZBJTAjvGkwJvHvQD9TwHxpYh
   wqG1hQhpgdP4nbS6H7d6w+tbakl02jfV6dqnZw7sGcVeq+t1qn95JhJNi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="350188466"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="yaml'?scan'208";a="350188466"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 00:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="1029116319"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="yaml'?scan'208";a="1029116319"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 10 May 2023 00:55:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 00:55:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 00:55:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 10 May 2023 00:55:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 10 May 2023 00:55:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGDmqsDVAtX8SyE2mwDN0LD+JNvETuekSmu5xLa+7YD0AK8Xn/fepQFJo5c3uDFl8lI/P9icJXB0ARzYMvfQz4Z82uu0HBCxQfEQBuKkwoxOvl4O/bmUO9Z65Q+I6HME1bs6Uz/3YkaNqOYoOAVIzEXxEMl4QnN8CtmW35M5vshj+r07ryKhoVzxQvZM1/akf4povDX+YYhj2CnSkUDEivC9VbzMb+wbGG1ld0WJPPfdWt/qg2m831tNv1FPKKEyB9PeuE+i9VFfWPKHxChMRUlXTcLOJGjt0uKU6npcM8z0rmXqVJNuenpje1XAKuYm+SU/p6d6wfgspMF8IX7jwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vNWlhN++ZxDUiRuqk157SY39usaUoadpVSNdHt6Juk=;
 b=WvbL2HBFVGXT4ICCx9KF4tW79KkmrzQGii+tddmRaFq9BDY0/xVeZ8O33fjhrHjCeqkcuEYtbDn48DWagyFjfDXpMPqUIf35ODa+xvdgB8Y/92S8d1wv2MKKoToTHFNdHLXgNzEZm0dwe/HyvfCVCrUC0I37+nMJ7VoS60bTVg9ikNgvld7Bhh9Z3IrgxuC1oTsXVd68Gd65pXx382dJj1gGSKLL61o78LbqPUookY3O7DBQtwhi57M5ZDylvTSefZeo65YtcTROxxsQ6174nmnf3IYXczjhVDM6x7q4Wnl7d/8sWXDZA8dRcsAwZFh3JLCynp/UE31dPVZkeQhTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB7471.namprd11.prod.outlook.com (2603:10b6:510:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 07:55:25 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf%6]) with mapi id 15.20.6363.031; Wed, 10 May 2023
 07:55:25 +0000
Date:   Wed, 10 May 2023 15:55:12 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Raghavendra K T <raghavendra.kt@amd.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        "Disha Talreja" <dishaa.talreja@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Mike Rapoport" <rppt@kernel.org>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <yu.c.chen@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [sched/numa]  fc137c0dda:
 autonuma-benchmark.numa01.seconds 118.9% regression
Message-ID: <202305101547.20f4c32a-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="ksk6qpSXzNdvl33U"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f90a18-ac54-4195-53d6-08db512be943
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Jzn13wzs7ihqCkxDC8OixXG35MIAlONWRS8QiR9L2yyzNU6wKaciYOyRH3QbEk98IbdIzdaU/62lVZylvx3Gy2zr/D57eElWUbQdsSudSH0rMFrsqPIuYhxr0l2ePn8S+cHRi8DROgLgD1YSzLveXaxMRnJWnEXG5d8LWpi/DNB2Emd5op/0gbBz5qTkR7zfMmtbDyWHWAdxQUdGHlfN/Rb5L4Hd9qx7AnlmNb7cC04ooCqpDcOPaILnS4siJwADJoAGHPCyah7tQWPKJSOHljZxUZpKYfieSypGZQbwOjeZsP9hD8f7nZW5wlypzZXSjj4oigxfQkEbDFv6pExEENB5h2cPToUV2efwZQLvdRIdJ62JoCnLtoUCKlz/U20+9oLbl2AKWYW+YkHOgGYeDvbhuOvsk8Zw1NxPCuKXaHNXd36uiqNiPZCEGWXUNJss1oFBCb9ajkj+5E1OfMHGjHANosFG7eqEC46CF/gktvULszQwJYGFJP37AVL6/HnG5LIl70N2bdgr8fdm63YImSPjJR9gvx2m17z+3858MwOJB/izGzUUPX+QtYNpTBEX6Qy4crEmdFnFW8EgEj/XKSWyXQYP5ZCklikTsY3JAXNGmg/lgubveJV5lOBa0SnUfPFhBtmZrhxXnCqG3jZ4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(66476007)(66946007)(4326008)(6916009)(82960400001)(316002)(38100700002)(107886003)(8936002)(8676002)(54906003)(19627235002)(83380400001)(26005)(1076003)(6506007)(6512007)(86362001)(41300700001)(5660300002)(66574015)(66556008)(235185007)(7416002)(478600001)(966005)(36756003)(2616005)(6666004)(21490400003)(2906002)(30864003)(44144004)(186003)(6486002)(2700100001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?U1hY6HJbo+L4RhfwrWXlX8l0G/mZwD/yY9d06Vk3to1zYWDya0Q9UJceQg?=
 =?iso-8859-1?Q?d6yUqqL1qCcp4EzEL0prJHF0BFTKK+M9F4JXN0qvhXidqT2ZlX2jOEHM8F?=
 =?iso-8859-1?Q?JAm9nDmVsWjmdncklEumwZWqcdVUNgMxxBfZxooTgTHyp2/awlvO4eE85i?=
 =?iso-8859-1?Q?OuvbUj60eQ5pSCBhyL1AfPQP+s4VFVPqk/tv8wEKiANQ7OmGBacx/swoCX?=
 =?iso-8859-1?Q?yBecKrICRtw10TGcCLjPu2bASdupJhxb/BKMdcJh5W3E8RBktv8R7PdUsw?=
 =?iso-8859-1?Q?hwVQSECo50471KrXazwdhIC+uRC3OUWg93Bm1XRC4FZl319+fucKAHNDD6?=
 =?iso-8859-1?Q?Il6ZN4lWRhym7YshlqGLTiBAbssD/dlmy6HXq44n7+Sh9MAAcGkGfAqGoU?=
 =?iso-8859-1?Q?ROj0P64SWSBrOqwD4q9vodrKBBRbUWh0NniXaeAhv/VG7K9cRkJScoQfHH?=
 =?iso-8859-1?Q?Dw7fui7thVOY9iZcrO9atAUd5DjYeDxOqGr2cLjJZyJZAMFNm1+Zc18aKT?=
 =?iso-8859-1?Q?ieKFCvv1u9tsevv7aSaQYEmm1ywtFzoCwUNPz7v36FmbUhnvOlE4uJUhvU?=
 =?iso-8859-1?Q?scsTW36kyCSTYT7u5JdKVGPAhj3g8j128kRY39yPAyFgOXxELqeC855KaR?=
 =?iso-8859-1?Q?v+P3N3D9WCsNA9aym9E6HULswwRe+MIdilvaJjIswfBv3YpsEloFmbdACH?=
 =?iso-8859-1?Q?pfbJWpm9g035gyj3aN81Q6xySpt7KC3WPrhPJrOpAkoA+RYwEVYBoO+G4V?=
 =?iso-8859-1?Q?q/Xm3wp0A+AHP30IKC6n+iOPoK0ob+zRN8KsPKus4/tMfFDyKpgv07cec8?=
 =?iso-8859-1?Q?lirkFkZetipbU0v5nlYjzPnfB9AbWPKoUxNxFKg6W8+wnbEYXrNnC7JrCj?=
 =?iso-8859-1?Q?/pwpK7ZjXpJ0T0pnJOowOZEGVqmHXCBjnZmyktSBKtFl6/bCQLem9/8nvj?=
 =?iso-8859-1?Q?cnQcMrNbQ/NwpPSetHakxYwnjPzm2AjYyhGp7UWTUWZgk63DvkeGjfSuQi?=
 =?iso-8859-1?Q?JTc1QgI9qr6QhurfkbPzJW+NB81mPxS6Dw7HUjnnOJhGRzqP5SyBhkIIXv?=
 =?iso-8859-1?Q?zkoJerhiS0TDDkKMNBHKDDwn84mmUOa4z+Hn+321tQRs8BareCSwYMFI7u?=
 =?iso-8859-1?Q?0Qv0lQKgveOSdvOdw3MLU5xVNA53OY+BiXRse7SJKq+iIfqnw7keJYuytz?=
 =?iso-8859-1?Q?56m1I70Ve3f8e2Xo3zV/0NU/rydp86OQRlW9wW8XJKi9UMyBFW7ewANw5l?=
 =?iso-8859-1?Q?RspKpbPwnmg8cQd8A9cPSikWAR6HmIlG+rnOIdZdz37iSevl0OGcyQORvl?=
 =?iso-8859-1?Q?2jCHlQcms1wiWkTIkO/8ZoH9Lg777xjKGKA4vOHE9WdD4oJxLCnwxe5o7E?=
 =?iso-8859-1?Q?cR1aVlSoYkaiWBWFlPrUicUFNh/eBlRCBrIQ8pJ+MKjLY5Cid2XasCDihK?=
 =?iso-8859-1?Q?g3jvW3tXw+dvhyPD5sXYpDpvNPDPQlfqoOik/VEeLGEAJ9SfPWvUl9c4xX?=
 =?iso-8859-1?Q?qazqZpdIRkQWxnofIm3RjGHjshQOIg8RjduoGJCSNvvoFULsxeQi2XzthR?=
 =?iso-8859-1?Q?stFMlX0pdi2zGJ8ju6yv/I6ozDFbeKfqcZOg9H9nHQxVyNiFFy0LW/ob3t?=
 =?iso-8859-1?Q?c74YgXHbuXXmnP4BuuAfJq4C/IQp7R1PkMNn+H7tioGmM6INplMWzbzQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f90a18-ac54-4195-53d6-08db512be943
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 07:55:25.1962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wVmSu87lbOyjT/lHJMvu5Pxan66Msoi1aoL+ZINu7OCGXmYgdZ+cVFEmBYWQtES0xEJNTuSa9TdlF+qtRcZIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ksk6qpSXzNdvl33U
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Hello,

kernel test robot noticed a 118.9% regression of autonuma-benchmark.numa01.seconds on:


commit: fc137c0ddab29b591db6a091dc6d7ce20ccb73f2 ("sched/numa: enhance vma scanning logic")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: autonuma-benchmark
test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz (Cascade Lake) with 128G memory
parameters:

	iterations: 4x
	test: numa02_SMT
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | autonuma-benchmark: autonuma-benchmark.numa01.seconds 39.3% regression                         |
| test machine     | 224 threads 2 sockets (Sapphire Rapids) with 256G memory                                       |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | iterations=4x                                                                                  |
|                  | test=numa02_SMT                                                                                |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | autonuma-benchmark: autonuma-benchmark.numa01.seconds 48.9% regression                         |
| test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz (Cascade Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | debug-setup=no-monitor                                                                         |
|                  | iterations=4x                                                                                  |
|                  | test=numa02_SMT                                                                                |
+------------------+------------------------------------------------------------------------------------------------+


one thing we want to mention is this is numa02_SMT test, but we found the
regression mostly for autonuma-benchmark.numa01.seconds
summary as below and detailed data is in [1]

=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp9/numa02_SMT/autonuma-benchmark

ef6a22b70f6d9044 fc137c0ddab29b591db6a091dc6
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    198.95 ±  7%    +118.9%     435.43 ±  2%  autonuma-benchmark.numa01.seconds
     14.30 ±  2%      -3.3%      13.83 ±  2%  autonuma-benchmark.numa02.seconds
     12.46            -1.1%      12.33 ±  2%  autonuma-benchmark.numa02_SMT.seconds


=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/numa02_SMT/autonuma-benchmark

ef6a22b70f6d9044 fc137c0ddab29b591db6a091dc6
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    191.58 ±  2%     +39.3%     266.89        autonuma-benchmark.numa01.seconds
      8.06            +0.2%       8.08        autonuma-benchmark.numa02.seconds
      6.41 ± 12%      +8.1%       6.93        autonuma-benchmark.numa02_SMT.seconds


then we test again with the perf monitor disabled to reduce the impact by perf
since perf profile data has many perf command related functions.
we could see the performance delta is reduced (even numa01 still have around 50%
regression).

=========================================================================================
compiler/cpufreq_governor/debug-setup/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/performance/no-monitor/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp9/numa02_SMT/autonuma-benchmark

ef6a22b70f6d9044 fc137c0ddab29b591db6a091dc6
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    203.37 ±  8%     +48.9%     302.87 ±  3%  autonuma-benchmark.numa01.seconds
     13.85            -0.4%      13.80        autonuma-benchmark.numa02.seconds
     12.20            -0.2%      12.18        autonuma-benchmark.numa02_SMT.seconds


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202305101547.20f4c32a-oliver.sang@intel.com


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

[1]

=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp9/numa02_SMT/autonuma-benchmark

commit: 
  ef6a22b70f ("sched/numa: apply the scan delay to every new vma")
  fc137c0dda ("sched/numa: enhance vma scanning logic")

ef6a22b70f6d9044 fc137c0ddab29b591db6a091dc6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    198.95 ±  7%    +118.9%     435.43 ±  2%  autonuma-benchmark.numa01.seconds
     14.30 ±  2%      -3.3%      13.83 ±  2%  autonuma-benchmark.numa02.seconds
     12.46            -1.1%      12.33 ±  2%  autonuma-benchmark.numa02_SMT.seconds
    907.24 ±  6%    +104.0%       1850        autonuma-benchmark.time.elapsed_time
    907.24 ±  6%    +104.0%       1850        autonuma-benchmark.time.elapsed_time.max
    391359 ±  7%    +109.6%     820115 ±  2%  autonuma-benchmark.time.involuntary_context_switches
   1674215 ±  3%     +25.4%    2099248        autonuma-benchmark.time.minor_page_faults
     68259 ±  7%    +104.6%     139628        autonuma-benchmark.time.user_time
     33292 ± 17%     -31.5%      22801        autonuma-benchmark.time.voluntary_context_switches
     90254            -1.3%      89057        vmstat.system.in
 8.255e+09 ±  4%     +97.9%  1.634e+10 ±  6%  cpuidle..time
   8518920 ±  4%     +98.1%   16871964 ±  6%  cpuidle..usage
    953.10 ±  6%     +99.0%       1896        uptime.boot
     11931 ±  2%     +68.5%      20105 ±  5%  uptime.idle
     31722 ±  2%     +35.7%      43051 ±  3%  meminfo.Active
     31610 ±  2%     +35.9%      42947 ±  3%  meminfo.Active(anon)
      1567 ±  3%     +28.0%       2006        meminfo.Mlocked
     44483 ±  4%     +20.2%      53481 ±  5%  meminfo.Shmem
      0.05 ± 17%      -0.1        0.00 ±115%  mpstat.cpu.all.iowait%
      1.57            +0.9        2.44        mpstat.cpu.all.irq%
      0.05            +0.0        0.08        mpstat.cpu.all.soft%
      2.47 ±  3%      -1.0        1.51 ±  4%  mpstat.cpu.all.sys%
   1325319 ± 13%     +67.1%    2214191 ±  6%  numa-numastat.node0.local_node
   1669069 ± 11%     +46.6%    2446395 ±  6%  numa-numastat.node0.numa_hit
    343780 ± 19%     -32.5%     232190 ± 24%  numa-numastat.node0.other_node
   1351528 ± 11%     +58.0%    2134780 ±  5%  numa-numastat.node1.local_node
   1632897 ±  8%     +53.8%    2511008 ±  4%  numa-numastat.node1.numa_hit
     25990 ±  6%     +24.2%      32278 ±  9%  turbostat.C1
      0.08 ± 14%      -0.1        0.03 ± 17%  turbostat.C1E%
   8339796 ±  4%     +99.9%   16670602 ±  6%  turbostat.C6
      0.42 ± 11%     -44.0%       0.24 ±  7%  turbostat.CPU%c6
  83201587 ±  6%     +97.6%  1.644e+08        turbostat.IRQ
     32712 ± 16%     +51.9%      49691 ±  7%  turbostat.POLL
      0.34 ± 13%     -43.8%       0.19 ±  7%  turbostat.Pkg%pc2
    250.53            -5.1%     237.66        turbostat.PkgWatt
     27.99           -20.6%      22.23        turbostat.RAMWatt
      4846 ±  8%     +87.7%       9098 ± 12%  numa-meminfo.node0.Active
      4790 ±  8%     +88.9%       9047 ± 12%  numa-meminfo.node0.Active(anon)
      8801 ±  7%     +53.5%      13508 ±  8%  numa-meminfo.node0.Shmem
     26801           +26.6%      33928 ±  5%  numa-meminfo.node1.Active
     26745           +26.7%      33875 ±  5%  numa-meminfo.node1.Active(anon)
   2666372 ±  2%     +40.1%    3735457 ± 18%  numa-meminfo.node1.AnonHugePages
   2730009 ±  2%     +39.4%    3806916 ± 17%  numa-meminfo.node1.AnonPages
   2738755 ±  2%     +39.2%    3813200 ± 17%  numa-meminfo.node1.Inactive
   2738657 ±  2%     +39.2%    3813099 ± 17%  numa-meminfo.node1.Inactive(anon)
     35654 ±  5%     +11.9%      39902 ±  6%  numa-meminfo.node1.Shmem
      1198 ±  8%     +89.0%       2264 ± 12%  numa-vmstat.node0.nr_active_anon
      2201 ±  7%     +53.5%       3380 ±  8%  numa-vmstat.node0.nr_shmem
      1198 ±  8%     +89.0%       2264 ± 12%  numa-vmstat.node0.nr_zone_active_anon
   1669280 ± 11%     +46.5%    2445929 ±  5%  numa-vmstat.node0.numa_hit
   1325531 ± 13%     +67.0%    2213724 ±  6%  numa-vmstat.node0.numa_local
    343780 ± 19%     -32.5%     232190 ± 24%  numa-vmstat.node0.numa_other
      6697           +26.5%       8473 ±  5%  numa-vmstat.node1.nr_active_anon
    682644 ±  2%     +39.4%     951464 ± 17%  numa-vmstat.node1.nr_anon_pages
      1301 ±  2%     +40.0%       1822 ± 18%  numa-vmstat.node1.nr_anon_transparent_hugepages
    684804 ±  2%     +39.2%     953008 ± 17%  numa-vmstat.node1.nr_inactive_anon
      8923 ±  5%     +11.8%       9977 ±  6%  numa-vmstat.node1.nr_shmem
      6697           +26.5%       8473 ±  5%  numa-vmstat.node1.nr_zone_active_anon
    684803 ±  2%     +39.2%     953007 ± 17%  numa-vmstat.node1.nr_zone_inactive_anon
   1632842 ±  8%     +53.7%    2510369 ±  4%  numa-vmstat.node1.numa_hit
   1351473 ± 11%     +57.9%    2134142 ±  5%  numa-vmstat.node1.numa_local
      7883 ±  2%     +36.3%      10741 ±  3%  proc-vmstat.nr_active_anon
   1436177            +7.4%    1541812        proc-vmstat.nr_anon_pages
      2739            +7.9%       2956        proc-vmstat.nr_anon_transparent_hugepages
   1439302            +7.3%    1544428        proc-vmstat.nr_inactive_anon
    391.83 ±  3%     +28.1%     502.00        proc-vmstat.nr_mlock
      3729            +5.2%       3925        proc-vmstat.nr_page_table_pages
     11118 ±  4%     +20.2%      13362 ±  5%  proc-vmstat.nr_shmem
      7883 ±  2%     +36.3%      10741 ±  3%  proc-vmstat.nr_zone_active_anon
   1439302            +7.3%    1544428        proc-vmstat.nr_zone_inactive_anon
    175921 ±  3%     -79.8%      35622 ± 13%  proc-vmstat.numa_hint_faults
    115702 ±  8%     -78.5%      24909 ± 19%  proc-vmstat.numa_hint_faults_local
   3304700 ±  4%     +50.1%    4959330        proc-vmstat.numa_hit
    102422 ±  4%     -94.8%       5353 ±  7%  proc-vmstat.numa_huge_pte_updates
   2679582 ±  4%     +62.4%    4350898        proc-vmstat.numa_local
    623652            -2.4%     608410 ±  2%  proc-vmstat.numa_other
   8685106 ±  6%     -87.5%    1082922        proc-vmstat.numa_pages_migrated
  52587827 ±  4%     -94.6%    2850465 ±  7%  proc-vmstat.numa_pte_updates
   4004609 ±  4%     +58.4%    6344664        proc-vmstat.pgfault
   8685106 ±  6%     -87.5%    1082922        proc-vmstat.pgmigrate_success
    165180 ±  6%     +77.9%     293828 ±  2%  proc-vmstat.pgreuse
     16935 ±  6%     -87.6%       2100        proc-vmstat.thp_migration_success
   6874624 ±  6%     +99.4%   13705216 ±  2%  proc-vmstat.unevictable_pgs_scanned
   1366547 ±  4%     +65.9%    2267715        proc-vmstat.vma_lock_abort
      2047 ± 83%    -100.0%       0.00        proc-vmstat.vma_lock_retry
   1291100 ±  2%     +13.6%    1467326        proc-vmstat.vma_lock_success
      4716 ±  9%     -21.9%       3683 ± 16%  sched_debug.cfs_rq:/.load.min
  43237186 ± 10%    +123.3%   96553100 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
  44834019 ± 10%    +125.1%  1.009e+08 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
  39418790 ± 11%    +123.0%   87908268 ±  4%  sched_debug.cfs_rq:/.min_vruntime.min
   1144476 ±  6%    +146.3%    2818840 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.08 ± 28%     +40.8%       0.11 ± 15%  sched_debug.cfs_rq:/.nr_running.stddev
      6.39 ± 45%     -69.0%       1.98 ± 18%  sched_debug.cfs_rq:/.removed.load_avg.avg
     69.51 ±  8%     -42.9%      39.71 ± 34%  sched_debug.cfs_rq:/.removed.load_avg.max
     19.45 ± 25%     -56.8%       8.40 ± 23%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      2.31 ± 46%     -65.1%       0.81 ± 25%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
      7.72 ± 26%     -53.9%       3.56 ± 30%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      2.31 ± 46%     -65.1%       0.81 ± 25%  sched_debug.cfs_rq:/.removed.util_avg.avg
      7.72 ± 26%     -53.9%       3.56 ± 30%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    163.15 ± 13%     +22.1%     199.24 ±  9%  sched_debug.cfs_rq:/.runnable_avg.stddev
   3361686 ± 17%    +112.3%    7136786 ± 18%  sched_debug.cfs_rq:/.spread0.avg
   4951283 ± 11%    +132.6%   11515787 ± 15%  sched_debug.cfs_rq:/.spread0.max
   1139698 ±  6%    +146.6%    2810782 ±  6%  sched_debug.cfs_rq:/.spread0.stddev
    113.85 ± 22%     +28.3%     146.07 ± 10%  sched_debug.cfs_rq:/.util_avg.stddev
    451.84 ±  6%     -98.4%       7.03 ± 41%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1078 ±  8%     -78.1%     235.96 ± 34%  sched_debug.cfs_rq:/.util_est_enqueued.max
    290.02 ±  7%     -87.9%      35.06 ± 30%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    489663 ± 22%     +65.4%     809711 ±  5%  sched_debug.cpu.avg_idle.min
    192021 ± 10%     +25.1%     240152 ±  4%  sched_debug.cpu.avg_idle.stddev
    465375 ±  7%    +101.8%     939116 ±  4%  sched_debug.cpu.clock.avg
    465585 ±  7%    +101.8%     939460 ±  4%  sched_debug.cpu.clock.max
    465153 ±  7%    +101.8%     938746 ±  4%  sched_debug.cpu.clock.min
    124.32 ± 11%     +66.1%     206.49 ±  7%  sched_debug.cpu.clock.stddev
    458182 ±  7%     +99.9%     916080 ±  4%  sched_debug.cpu.clock_task.avg
    459113 ±  7%    +100.3%     919749 ±  4%  sched_debug.cpu.clock_task.max
    442945 ±  8%    +103.3%     900390 ±  4%  sched_debug.cpu.clock_task.min
      1728 ±  6%     +82.2%       3149 ± 31%  sched_debug.cpu.clock_task.stddev
     13277 ±  7%     +61.4%      21433        sched_debug.cpu.curr->pid.avg
     16890 ±  6%     +69.9%      28705 ±  4%  sched_debug.cpu.curr->pid.max
      9462 ± 17%     +57.5%      14904 ± 14%  sched_debug.cpu.curr->pid.min
      1346 ± 36%    +132.5%       3129 ± 27%  sched_debug.cpu.curr->pid.stddev
    675236 ±  3%     +40.6%     949396        sched_debug.cpu.max_idle_balance_cost.max
     38536 ± 16%    +141.1%      92913 ±  4%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 11%     +63.6%       0.00 ±  7%  sched_debug.cpu.next_balance.stddev
     11174 ±  7%     +87.4%      20935 ±  4%  sched_debug.cpu.nr_switches.avg
     50841 ± 15%     +60.9%      81805 ± 20%  sched_debug.cpu.nr_switches.max
      3594 ± 12%     +77.5%       6378 ±  9%  sched_debug.cpu.nr_switches.min
      8462 ±  9%     +65.1%      13969 ± 12%  sched_debug.cpu.nr_switches.stddev
    465146 ±  7%    +101.8%     938733 ±  4%  sched_debug.cpu_clk
    462205 ±  7%    +102.5%     935792 ±  4%  sched_debug.ktime
    465863 ±  7%    +101.7%     939438 ±  4%  sched_debug.sched_clk
     56.31 ±  4%     -37.4%      35.24        perf-stat.i.MPKI
 1.195e+08           -12.0%  1.051e+08        perf-stat.i.branch-instructions
   2170451 ±  3%     -16.8%    1806326        perf-stat.i.branch-misses
     65.87            +1.1       67.01        perf-stat.i.cache-miss-rate%
  19697358 ±  3%     -39.5%   11911557        perf-stat.i.cache-misses
  29660372 ±  4%     -39.7%   17871038        perf-stat.i.cache-references
    422.84            +4.4%     441.24        perf-stat.i.cpi
    135.40           -15.3%     114.62        perf-stat.i.cpu-migrations
     11842 ±  3%     +56.8%      18564        perf-stat.i.cycles-between-cache-misses
      0.04 ±  2%      -0.0        0.04 ±  5%  perf-stat.i.dTLB-load-miss-rate%
     74639 ±  2%     -23.4%      57162 ±  4%  perf-stat.i.dTLB-load-misses
 1.655e+08            -9.8%  1.494e+08        perf-stat.i.dTLB-loads
      0.26            -0.0        0.23        perf-stat.i.dTLB-store-miss-rate%
    215751           -13.8%     185908        perf-stat.i.dTLB-store-misses
  91617620            -8.4%   83893934        perf-stat.i.dTLB-stores
    498608 ±  8%     -24.3%     377270 ±  3%  perf-stat.i.iTLB-load-misses
 6.137e+08           -11.2%  5.447e+08        perf-stat.i.instructions
      1366 ±  3%     +12.4%       1535        perf-stat.i.instructions-per-iTLB-miss
      0.01 ±  5%     -25.2%       0.00 ±  4%  perf-stat.i.ipc
      3.26 ±  2%     -19.7%       2.62        perf-stat.i.metric.M/sec
      4232           -20.9%       3346        perf-stat.i.minor-faults
     54.83            -2.4       52.43        perf-stat.i.node-load-miss-rate%
    397861 ±  2%     -39.9%     239208        perf-stat.i.node-load-misses
    311437 ±  3%     -29.3%     220078 ±  4%  perf-stat.i.node-loads
     36.23 ±  8%     +14.7       50.97        perf-stat.i.node-store-miss-rate%
  11382299 ±  9%     -54.5%    5178565        perf-stat.i.node-stores
      4232           -20.9%       3346        perf-stat.i.page-faults
     48.36 ±  2%     -32.1%      32.86        perf-stat.overall.MPKI
      1.82            -0.1        1.72        perf-stat.overall.branch-miss-rate%
    357.56 ±  2%     +12.8%     403.43        perf-stat.overall.cpi
     11082 ±  4%     +64.5%      18230        perf-stat.overall.cycles-between-cache-misses
      0.04 ±  2%      -0.0        0.04 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.24            -0.0        0.22        perf-stat.overall.dTLB-store-miss-rate%
      1246 ±  8%     +17.4%       1462 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.00 ±  2%     -11.4%       0.00        perf-stat.overall.ipc
     54.93            -3.7       51.19 ±  2%  perf-stat.overall.node-load-miss-rate%
     33.16 ± 11%     +16.9       50.11        perf-stat.overall.node-store-miss-rate%
 1.192e+08           -12.5%  1.043e+08        perf-stat.ps.branch-instructions
   2173761 ±  3%     -17.6%    1791060        perf-stat.ps.branch-misses
  19774101 ±  3%     -39.5%   11970134        perf-stat.ps.cache-misses
  29613162 ±  4%     -40.0%   17774173        perf-stat.ps.cache-references
    135.25           -15.7%     113.97        perf-stat.ps.cpu-migrations
     72513 ±  2%     -24.4%      54824 ±  4%  perf-stat.ps.dTLB-load-misses
 1.649e+08           -10.1%  1.483e+08        perf-stat.ps.dTLB-loads
    216266           -13.5%     186980        perf-stat.ps.dTLB-store-misses
  91180718            -8.7%   83287491        perf-stat.ps.dTLB-stores
    495096 ±  9%     -25.2%     370277 ±  3%  perf-stat.ps.iTLB-load-misses
 6.121e+08           -11.6%  5.409e+08        perf-stat.ps.instructions
      4183           -21.4%       3288        perf-stat.ps.minor-faults
    396633 ±  2%     -40.5%     236105        perf-stat.ps.node-load-misses
    325540 ±  3%     -30.8%     225344 ±  4%  perf-stat.ps.node-loads
  11391808 ±  9%     -54.5%    5184100        perf-stat.ps.node-stores
      4183           -21.4%       3288        perf-stat.ps.page-faults
 5.551e+11 ±  4%     +80.4%  1.001e+12        perf-stat.total.instructions
     12.12 ± 49%     -12.1        0.00        perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.cmd_sched.run_builtin.main
     12.12 ± 49%     -12.1        0.00        perf-profile.calltrace.cycles-pp.cmd_record.cmd_sched.run_builtin.main.__libc_start_main
     12.12 ± 49%     -12.1        0.00        perf-profile.calltrace.cycles-pp.cmd_sched.run_builtin.main.__libc_start_main
     14.02 ± 39%     -11.7        2.32 ± 88%  perf-profile.calltrace.cycles-pp.main.__libc_start_main
     14.02 ± 39%     -11.7        2.32 ± 88%  perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
     14.02 ± 39%     -11.7        2.32 ± 88%  perf-profile.calltrace.cycles-pp.__libc_start_main
     12.52 ± 39%     -10.9        1.60 ± 95%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
     10.90 ± 49%     -10.9        0.00        perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.cmd_sched.run_builtin
     10.85 ± 49%     -10.9        0.00        perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.cmd_sched
     21.20 ± 41%     -10.1       11.08 ± 18%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
     21.20 ± 41%     -10.1       11.08 ± 18%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
     21.16 ± 41%     -10.1       11.04 ± 18%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      7.20 ± 32%      -5.9        1.25 ±175%  perf-profile.calltrace.cycles-pp.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output
      7.20 ± 32%      -5.9        1.25 ±175%  perf-profile.calltrace.cycles-pp.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      7.02 ± 31%      -5.8        1.22 ±176%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events
      1.88 ± 13%      -0.7        1.18 ± 11%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      1.89 ± 13%      -0.6        1.24 ± 18%  perf-profile.calltrace.cycles-pp.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work
      1.89 ± 13%      -0.6        1.24 ± 18%  perf-profile.calltrace.cycles-pp.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work
      1.89 ± 13%      -0.6        1.24 ± 18%  perf-profile.calltrace.cycles-pp._printk.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work
      1.89 ± 13%      -0.6        1.24 ± 18%  perf-profile.calltrace.cycles-pp.vprintk_emit._printk.irq_work_single.irq_work_run_list.irq_work_run
      1.89 ± 13%      -0.6        1.24 ± 18%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit._printk.irq_work_single.irq_work_run_list
      1.89 ± 13%      -0.6        1.24 ± 18%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit._printk.irq_work_single
      1.89 ± 13%      -0.6        1.24 ± 18%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit._printk
      0.84 ± 22%      -0.4        0.40 ± 71%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.71 ± 21%      -0.4        0.29 ±101%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.76 ± 21%      -0.4        0.40 ± 71%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.76 ± 21%      -0.4        0.40 ± 71%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.90 ± 18%      -0.3        0.56 ± 45%  perf-profile.calltrace.cycles-pp.__close_nocancel
      0.86 ± 19%      -0.3        0.54 ± 45%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.84 ± 19%      -0.3        0.54 ± 45%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.30 ±101%      +0.7        1.04 ± 28%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00            +0.7        0.74 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.readn.evsel__read_counter
      0.30 ±101%      +0.7        1.04 ± 28%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00            +0.7        0.74 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read.readn.evsel__read_counter.read_counters
      0.00            +0.8        0.77 ± 11%  perf-profile.calltrace.cycles-pp.__libc_read.readn.evsel__read_counter.read_counters.process_interval
      0.00            +0.8        0.77 ± 12%  perf-profile.calltrace.cycles-pp.readn.evsel__read_counter.read_counters.process_interval.dispatch_events
      0.00            +0.8        0.78 ± 15%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.8        0.80 ± 15%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.8        0.80 ± 25%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.readn
      0.00            +1.1        1.05 ± 22%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread
      0.00            +1.1        1.05 ± 22%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00            +1.1        1.08 ± 23%  perf-profile.calltrace.cycles-pp.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread.ret_from_fork
      0.26 ±141%      +1.1        1.36 ± 13%  perf-profile.calltrace.cycles-pp.evsel__read_counter.read_counters.process_interval.dispatch_events.cmd_stat
      0.00            +1.1        1.15 ± 24%  perf-profile.calltrace.cycles-pp.rcu_gp_fqs_loop.rcu_gp_kthread.kthread.ret_from_fork
      0.00            +1.4        1.37 ± 24%  perf-profile.calltrace.cycles-pp.rcu_gp_kthread.kthread.ret_from_fork
      5.16 ±124%     +15.0       20.16 ± 44%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      1.78 ± 42%     +15.6       17.34 ±  9%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
      5.22 ±124%     +15.6       20.79 ± 45%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      5.26 ±124%     +15.8       21.07 ± 45%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record
     14.02 ± 39%     -12.2        1.82 ± 83%  perf-profile.children.cycles-pp.cmd_record
     12.12 ± 49%     -12.1        0.00        perf-profile.children.cycles-pp.cmd_sched
     14.02 ± 39%     -11.6        2.41 ± 81%  perf-profile.children.cycles-pp.main
     14.02 ± 39%     -11.6        2.41 ± 81%  perf-profile.children.cycles-pp.run_builtin
     14.02 ± 39%     -11.6        2.42 ± 80%  perf-profile.children.cycles-pp.__libc_start_main
     21.20 ± 41%     -10.1       11.08 ± 18%  perf-profile.children.cycles-pp.record__finish_output
     21.20 ± 41%     -10.1       11.08 ± 18%  perf-profile.children.cycles-pp.perf_session__process_events
     21.16 ± 41%     -10.1       11.04 ± 18%  perf-profile.children.cycles-pp.reader__read_event
      7.20 ± 32%      -5.9        1.25 ±175%  perf-profile.children.cycles-pp.__ordered_events__flush
      7.20 ± 32%      -5.9        1.25 ±175%  perf-profile.children.cycles-pp.perf_session__process_user_event
      8.07 ± 26%      -5.6        2.52 ± 68%  perf-profile.children.cycles-pp.perf_session__deliver_event
      2.08 ± 45%      -1.3        0.80 ± 83%  perf-profile.children.cycles-pp.do_sys_poll
      2.09 ± 45%      -1.3        0.81 ± 82%  perf-profile.children.cycles-pp.__poll
      2.08 ± 45%      -1.3        0.80 ± 83%  perf-profile.children.cycles-pp.__x64_sys_poll
      1.73 ± 45%      -1.1        0.67 ± 82%  perf-profile.children.cycles-pp.do_poll
      2.38 ± 15%      -1.0        1.37 ± 12%  perf-profile.children.cycles-pp.wait_for_lsr
      2.40 ± 14%      -1.0        1.44 ± 16%  perf-profile.children.cycles-pp.serial8250_console_write
      2.41 ± 14%      -1.0        1.45 ± 16%  perf-profile.children.cycles-pp.console_flush_all
      2.40 ± 14%      -1.0        1.45 ± 16%  perf-profile.children.cycles-pp.irq_work_run_list
      2.41 ± 14%      -1.0        1.46 ± 16%  perf-profile.children.cycles-pp.console_unlock
      2.40 ± 14%      -1.0        1.45 ± 16%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      2.40 ± 14%      -1.0        1.45 ± 16%  perf-profile.children.cycles-pp.sysvec_irq_work
      2.40 ± 14%      -1.0        1.45 ± 16%  perf-profile.children.cycles-pp.__sysvec_irq_work
      2.40 ± 14%      -1.0        1.45 ± 16%  perf-profile.children.cycles-pp.irq_work_run
      2.40 ± 14%      -1.0        1.45 ± 16%  perf-profile.children.cycles-pp.irq_work_single
      2.40 ± 14%      -1.0        1.45 ± 16%  perf-profile.children.cycles-pp._printk
      2.40 ± 14%      -1.0        1.45 ± 16%  perf-profile.children.cycles-pp.vprintk_emit
      1.07 ± 30%      -0.8        0.30 ± 94%  perf-profile.children.cycles-pp.machine__process_mmap2_event
      0.92 ± 31%      -0.7        0.25 ± 91%  perf-profile.children.cycles-pp.map__new
      0.88 ± 36%      -0.6        0.29 ± 52%  perf-profile.children.cycles-pp.vsnprintf
      0.73 ± 41%      -0.5        0.22 ± 67%  perf-profile.children.cycles-pp.seq_printf
      0.56 ± 37%      -0.4        0.14 ±119%  perf-profile.children.cycles-pp.machine__findnew_vdso
      0.90 ± 25%      -0.4        0.50 ± 13%  perf-profile.children.cycles-pp.rcu_do_batch
      0.57 ± 23%      -0.3        0.29 ± 21%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.93 ± 16%      -0.2        0.68 ± 14%  perf-profile.children.cycles-pp.__close_nocancel
      0.35 ± 42%      -0.2        0.12 ± 76%  perf-profile.children.cycles-pp.__libc_calloc
      0.30 ± 19%      -0.2        0.12 ± 19%  perf-profile.children.cycles-pp.__slab_free
      0.48 ± 17%      -0.2        0.33 ± 36%  perf-profile.children.cycles-pp.__fxstat64
      0.34 ± 26%      -0.1        0.21 ± 22%  perf-profile.children.cycles-pp.single_release
      0.36 ± 20%      -0.1        0.24 ± 23%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.18 ± 34%      -0.1        0.06 ±106%  perf-profile.children.cycles-pp.number
      0.14 ± 31%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.flush_memcg_stats_dwork
      0.14 ± 33%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
      0.14 ± 33%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__mem_cgroup_flush_stats
      0.14 ± 33%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.cgroup_rstat_flush_irqsafe
      0.44 ± 11%      -0.1        0.35 ± 10%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.24 ± 25%      -0.1        0.16 ± 10%  perf-profile.children.cycles-pp.__kmem_cache_free
      0.29 ± 16%      -0.1        0.21 ± 25%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.02 ±144%      +0.1        0.08 ± 29%  perf-profile.children.cycles-pp.activate_task
      0.04 ±102%      +0.1        0.10 ± 19%  perf-profile.children.cycles-pp.__perf_event_read
      0.11 ± 31%      +0.1        0.18 ± 18%  perf-profile.children.cycles-pp.__send_signal_locked
      0.05 ± 71%      +0.1        0.12 ± 26%  perf-profile.children.cycles-pp.__x64_sys_ioctl
      0.08 ± 34%      +0.1        0.16 ± 15%  perf-profile.children.cycles-pp.complete_signal
      0.06 ± 51%      +0.1        0.14 ± 46%  perf-profile.children.cycles-pp.ioctl
      0.06 ± 51%      +0.1        0.14 ± 50%  perf-profile.children.cycles-pp.perf_evsel__disable_cpu
      0.01 ±223%      +0.1        0.10 ± 53%  perf-profile.children.cycles-pp.__get_task_ioprio
      0.05 ± 73%      +0.1        0.15 ± 51%  perf-profile.children.cycles-pp.perf_evsel__run_ioctl
      0.06 ± 75%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.__kmalloc
      0.09 ± 55%      +0.1        0.21 ± 13%  perf-profile.children.cycles-pp.perf_event_read
      0.03 ±144%      +0.2        0.18 ±  9%  perf-profile.children.cycles-pp.__perf_read_group_add
      0.04 ±105%      +0.2        0.21 ± 29%  perf-profile.children.cycles-pp.swake_up_one
      0.03 ±103%      +0.2        0.22 ± 23%  perf-profile.children.cycles-pp.rcu_report_qs_rdp
      0.01 ±223%      +0.2        0.22 ± 25%  perf-profile.children.cycles-pp.detach_tasks
      0.21 ± 36%      +0.2        0.42 ± 17%  perf-profile.children.cycles-pp.__evlist__disable
      0.53 ± 21%      +0.2        0.76 ±  8%  perf-profile.children.cycles-pp.__orc_find
      0.08 ± 84%      +0.2        0.31 ± 12%  perf-profile.children.cycles-pp.evlist__id2evsel
      0.35 ± 33%      +0.3        0.62 ± 28%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.42 ± 28%      +0.4        0.78 ± 30%  perf-profile.children.cycles-pp.security_file_permission
      0.39 ± 42%      +0.4        0.79 ± 12%  perf-profile.children.cycles-pp.perf_read
      0.93 ± 19%      +0.6        1.49 ± 11%  perf-profile.children.cycles-pp.dequeue_entity
      0.06 ± 80%      +0.6        0.63 ± 24%  perf-profile.children.cycles-pp.rebalance_domains
      1.08 ± 21%      +0.6        1.66 ± 12%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.55 ± 12%      +0.6        2.12 ± 10%  perf-profile.children.cycles-pp.unwind_next_frame
      0.78 ± 21%      +0.6        1.35 ± 19%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.67 ± 29%      +0.6        1.26 ± 12%  perf-profile.children.cycles-pp.__irq_exit_rcu
      1.76 ± 17%      +0.6        2.36 ±  6%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      1.79 ± 12%      +0.6        2.42 ± 10%  perf-profile.children.cycles-pp.perf_callchain_kernel
      0.68 ± 35%      +0.6        1.33 ±  9%  perf-profile.children.cycles-pp.readn
      2.11 ± 14%      +0.7        2.78 ±  7%  perf-profile.children.cycles-pp.update_curr
      2.23 ± 15%      +0.8        3.01 ± 11%  perf-profile.children.cycles-pp.get_perf_callchain
      2.29 ± 15%      +0.8        3.08 ± 11%  perf-profile.children.cycles-pp.perf_callchain
      2.49 ± 16%      +0.8        3.33 ± 10%  perf-profile.children.cycles-pp.perf_prepare_sample
      0.50 ± 45%      +0.9        1.37 ± 13%  perf-profile.children.cycles-pp.evsel__read_counter
      2.95 ± 16%      +0.9        3.87 ± 10%  perf-profile.children.cycles-pp.perf_event_output_forward
      2.99 ± 16%      +1.0        3.95 ± 10%  perf-profile.children.cycles-pp.__perf_event_overflow
      0.14 ± 71%      +1.0        1.16 ± 25%  perf-profile.children.cycles-pp.schedule_timeout
      0.07 ±101%      +1.1        1.15 ± 24%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      3.25 ± 15%      +1.1        4.32 ± 10%  perf-profile.children.cycles-pp.perf_tp_event
      2.68 ± 19%      +1.2        3.92 ± 14%  perf-profile.children.cycles-pp.cmd_stat
      2.54 ± 20%      +1.2        3.79 ± 16%  perf-profile.children.cycles-pp.read_counters
      2.66 ± 19%      +1.3        3.92 ± 14%  perf-profile.children.cycles-pp.dispatch_events
      2.64 ± 19%      +1.3        3.90 ± 14%  perf-profile.children.cycles-pp.process_interval
      0.09 ± 99%      +1.3        1.37 ± 24%  perf-profile.children.cycles-pp.rcu_gp_kthread
      2.73 ± 17%      +1.7        4.39 ± 16%  perf-profile.children.cycles-pp.schedule
      3.41 ± 14%      +1.9        5.33 ± 16%  perf-profile.children.cycles-pp.__schedule
      3.34 ±  7%     +15.6       18.99 ±  9%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.20 ± 16%      -0.9        1.28 ± 16%  perf-profile.self.cycles-pp.io_serial_in
      0.52 ± 17%      -0.2        0.28 ± 21%  perf-profile.self.cycles-pp.__alloc_pages
      0.26 ± 24%      -0.2        0.06 ± 53%  perf-profile.self.cycles-pp.delay_tsc
      0.32 ± 48%      -0.2        0.12 ± 78%  perf-profile.self.cycles-pp.__libc_calloc
      0.37 ± 44%      -0.2        0.19 ± 52%  perf-profile.self.cycles-pp.mutex_lock
      0.30 ± 20%      -0.2        0.12 ± 19%  perf-profile.self.cycles-pp.__slab_free
      0.44 ± 11%      -0.1        0.35 ± 10%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.05 ± 83%      +0.1        0.12 ± 19%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.00            +0.1        0.07 ± 18%  perf-profile.self.cycles-pp.__perf_read_group_add
      0.09 ± 27%      +0.1        0.17 ± 24%  perf-profile.self.cycles-pp.update_rq_clock
      0.03 ±101%      +0.1        0.12 ± 31%  perf-profile.self.cycles-pp.evlist_cpu_iterator__next
      0.00            +0.1        0.09 ± 46%  perf-profile.self.cycles-pp.__get_task_ioprio
      0.06 ± 52%      +0.1        0.17 ± 37%  perf-profile.self.cycles-pp.security_file_permission
      0.09 ± 81%      +0.2        0.28 ± 23%  perf-profile.self.cycles-pp.evsel__read_counter
      0.21 ± 33%      +0.2        0.42 ± 37%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.53 ± 21%      +0.2        0.76 ±  8%  perf-profile.self.cycles-pp.__orc_find
      0.08 ± 83%      +0.2        0.31 ± 12%  perf-profile.self.cycles-pp.evlist__id2evsel
      0.19 ± 64%     +15.1       15.31 ±  8%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt


***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets (Sapphire Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/numa02_SMT/autonuma-benchmark

commit: 
  ef6a22b70f ("sched/numa: apply the scan delay to every new vma")
  fc137c0dda ("sched/numa: enhance vma scanning logic")

ef6a22b70f6d9044 fc137c0ddab29b591db6a091dc6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    191.58 ±  2%     +39.3%     266.89        autonuma-benchmark.numa01.seconds
      8.06            +0.2%       8.08        autonuma-benchmark.numa02.seconds
      6.41 ± 12%      +8.1%       6.93        autonuma-benchmark.numa02_SMT.seconds
    829.64 ±  2%     +36.4%       1131        autonuma-benchmark.time.elapsed_time
    829.64 ±  2%     +36.4%       1131        autonuma-benchmark.time.elapsed_time.max
    549857 ±  4%     +38.7%     762520        autonuma-benchmark.time.involuntary_context_switches
     20703            -1.9%      20305        autonuma-benchmark.time.percent_of_cpu_this_job_got
      2041            +2.4%       2091        autonuma-benchmark.time.system_time
    169755 ±  3%     +34.1%     227625        autonuma-benchmark.time.user_time
     36362 ±  7%     -61.8%      13887        autonuma-benchmark.time.voluntary_context_switches
 1.172e+10 ±  8%     +72.4%  2.021e+10 ±  2%  cpuidle..time
  12059145 ±  8%     +72.0%   20740506 ±  2%  cpuidle..usage
      1469           +16.9%       1717        meminfo.Mlocked
    219033 ±  7%     +41.2%     309205 ± 28%  meminfo.Shmem
   1421566 ±  3%     +38.5%    1968458 ± 10%  numa-numastat.node0.local_node
   1844276 ±  6%     +29.3%    2384098 ±  7%  numa-numastat.node0.numa_hit
    887.93 ±  2%     +34.0%       1189        uptime.boot
     23259 ±  4%     +37.1%      31889        uptime.idle
      2533 ±  2%      -4.2%       2426        vmstat.system.cs
    232791            -1.7%     228729        vmstat.system.in
      6.30 ± 10%      +1.7        8.00 ±  2%  mpstat.cpu.all.idle%
      0.02            -0.0        0.00        mpstat.cpu.all.iowait%
      1.05            -0.1        0.96        mpstat.cpu.all.irq%
      0.07            +0.0        0.10        mpstat.cpu.all.soft%
      1.27 ±  2%      -0.3        0.97        mpstat.cpu.all.sys%
      4988 ±  6%     +55.2%       7744 ± 10%  numa-meminfo.node0.Active
      4924 ±  7%     +57.3%       7744 ± 10%  numa-meminfo.node0.Active(anon)
     68570 ± 29%     +75.8%     120551 ± 34%  numa-meminfo.node0.Mapped
    840.67 ± 70%     +94.2%       1632 ±  7%  numa-meminfo.node0.Mlocked
     10013 ±  6%     +37.3%      13744 ±  5%  numa-meminfo.node0.Shmem
    208910 ±  8%     +41.7%     295980 ± 29%  numa-meminfo.node1.Shmem
      1231 ±  7%     +57.1%       1934 ± 10%  numa-vmstat.node0.nr_active_anon
     17238 ± 29%     +77.0%      30511 ± 34%  numa-vmstat.node0.nr_mapped
    210.67 ± 70%     +93.0%     406.67 ±  7%  numa-vmstat.node0.nr_mlock
      2503 ±  6%     +37.2%       3434 ±  5%  numa-vmstat.node0.nr_shmem
      1231 ±  7%     +57.1%       1934 ± 10%  numa-vmstat.node0.nr_zone_active_anon
   1844152 ±  6%     +29.2%    2382388 ±  7%  numa-vmstat.node0.numa_hit
   1421442 ±  3%     +38.4%    1966749 ± 10%  numa-vmstat.node0.numa_local
     52210 ±  8%     +42.3%      74312 ± 29%  numa-vmstat.node1.nr_shmem
   5516135 ±  8%     +73.2%    9554162 ±  2%  turbostat.C1E
      2.89 ± 10%      +0.8        3.67 ±  2%  turbostat.C1E%
   6357647 ±  8%     +73.1%   11003447 ±  2%  turbostat.C6
      3.38 ± 11%      +0.9        4.27 ±  2%  turbostat.C6%
      6.47 ± 10%     +25.7%       8.13 ±  2%  turbostat.CPU%c1
 1.964e+08 ±  2%     +31.3%   2.58e+08        turbostat.IRQ
    666.93            -3.9%     640.93        turbostat.PkgWatt
     71.58           -30.3%      49.92        turbostat.RAMWatt
     30776 ±  3%      +5.8%      32575 ±  3%  proc-vmstat.nr_active_anon
   1525450            +2.1%    1557803        proc-vmstat.nr_anon_pages
      2907            +2.6%       2982        proc-vmstat.nr_anon_transparent_hugepages
    760615            +3.0%     783336 ±  2%  proc-vmstat.nr_file_pages
   1549400            +3.4%    1602815        proc-vmstat.nr_inactive_anon
    366.67           +16.6%     427.67        proc-vmstat.nr_mlock
      4181            +3.4%       4322        proc-vmstat.nr_page_table_pages
     54864 ±  7%     +41.4%      77580 ± 28%  proc-vmstat.nr_shmem
     30776 ±  3%      +5.8%      32575 ±  3%  proc-vmstat.nr_zone_active_anon
   1549399            +3.4%    1602815        proc-vmstat.nr_zone_inactive_anon
   3979410           +14.1%    4539497        proc-vmstat.numa_hit
     80851 ±  3%     -97.6%       1967 ±  6%  proc-vmstat.numa_huge_pte_updates
   3261402           +17.0%    3816708        proc-vmstat.numa_local
   7983190           -94.9%     405403 ±  8%  proc-vmstat.numa_pages_migrated
  41654608 ±  2%     -96.9%    1294611 ±  4%  proc-vmstat.numa_pte_updates
 2.339e+08            -4.1%  2.243e+08        proc-vmstat.pgalloc_normal
   4206095           +16.6%    4903734        proc-vmstat.pgfault
 2.338e+08            -4.2%   2.24e+08        proc-vmstat.pgfree
   7983190           -94.9%     405403 ±  8%  proc-vmstat.pgmigrate_success
    160314 ±  2%     +22.5%     196345        proc-vmstat.pgreuse
     15546           -95.0%     778.00 ±  8%  proc-vmstat.thp_migration_success
   6675456 ±  2%     +32.3%    8834816        proc-vmstat.unevictable_pgs_scanned
   1398244           +20.6%    1686461        proc-vmstat.vma_lock_abort
      1691 ±  8%    -100.0%       0.00        proc-vmstat.vma_lock_retry
   1495234            +2.7%    1535106        proc-vmstat.vma_lock_success
     18882 ± 35%    +385.5%      91667 ± 24%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   4227647 ± 35%    +382.2%   20387480 ± 23%  sched_debug.cfs_rq:/.MIN_vruntime.max
    281894 ± 35%    +383.8%    1363727 ± 24%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      8.84 ± 23%     -27.1%       6.44 ±  7%  sched_debug.cfs_rq:/.load_avg.avg
    495.77 ± 85%     -69.3%     152.19 ± 15%  sched_debug.cfs_rq:/.load_avg.max
     41.39 ± 71%     -59.5%      16.77 ± 16%  sched_debug.cfs_rq:/.load_avg.stddev
     18882 ± 35%    +385.5%      91667 ± 24%  sched_debug.cfs_rq:/.max_vruntime.avg
   4227648 ± 35%    +382.2%   20387480 ± 23%  sched_debug.cfs_rq:/.max_vruntime.max
    281894 ± 35%    +383.8%    1363727 ± 24%  sched_debug.cfs_rq:/.max_vruntime.stddev
  99585977 ±  5%     +41.4%  1.408e+08 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
 1.022e+08 ±  4%     +41.5%  1.446e+08 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
  80885546 ±  2%     +36.8%  1.107e+08 ± 10%  sched_debug.cfs_rq:/.min_vruntime.min
   2263985 ±  3%     +36.3%    3086252 ± 17%  sched_debug.cfs_rq:/.min_vruntime.stddev
    384.30 ±113%     -85.5%      55.89 ±  2%  sched_debug.cfs_rq:/.removed.load_avg.max
     42.99 ± 11%     -31.4%      29.51 ±  5%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     42.97 ± 11%     -31.3%      29.51 ±  5%  sched_debug.cfs_rq:/.removed.util_avg.max
   7991223 ± 11%     +32.6%   10600334 ± 16%  sched_debug.cfs_rq:/.spread0.max
 -13413285           +75.5%  -23533995        sched_debug.cfs_rq:/.spread0.min
   2251246 ±  3%     +35.7%    3054867 ± 17%  sched_debug.cfs_rq:/.spread0.stddev
    488.32 ±  6%     -98.4%       7.59 ± 94%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1316 ±  3%     -65.2%     458.48 ± 36%  sched_debug.cfs_rq:/.util_est_enqueued.max
    312.92 ±  6%     -85.7%      44.71 ± 56%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
   1427145 ±  2%     +30.6%    1864124 ±  2%  sched_debug.cpu.avg_idle.avg
    376380 ± 20%    +136.3%     889390 ±  3%  sched_debug.cpu.avg_idle.min
    439922 ±  3%     +36.5%     600395 ±  2%  sched_debug.cpu.clock.avg
    440560 ±  3%     +36.5%     601438 ±  2%  sched_debug.cpu.clock.max
    439196 ±  3%     +36.4%     599201 ±  2%  sched_debug.cpu.clock.min
    384.40 ±  8%     +67.5%     643.80        sched_debug.cpu.clock.stddev
    435381 ±  3%     +36.5%     594324 ±  2%  sched_debug.cpu.clock_task.avg
    436669 ±  3%     +36.5%     596141 ±  2%  sched_debug.cpu.clock_task.max
    407687 ±  3%     +38.7%     565411 ±  2%  sched_debug.cpu.clock_task.min
      1972           +12.1%       2211        sched_debug.cpu.clock_task.stddev
     15199 ±  2%     +25.9%      19133 ±  2%  sched_debug.cpu.curr->pid.avg
     19055 ±  2%     +21.8%      23203 ±  2%  sched_debug.cpu.curr->pid.max
      1263 ± 18%     +30.2%       1644 ± 16%  sched_debug.cpu.curr->pid.stddev
      0.00 ±  7%     +67.7%       0.00        sched_debug.cpu.next_balance.stddev
      5438           +27.6%       6938 ±  2%  sched_debug.cpu.nr_switches.avg
      1684 ±  2%     +19.6%       2014 ±  4%  sched_debug.cpu.nr_switches.min
    439184 ±  3%     +36.4%     599183 ±  2%  sched_debug.cpu_clk
    434534 ±  3%     +36.8%     594518 ±  2%  sched_debug.ktime
    440279 ±  3%     +36.3%     600265 ±  2%  sched_debug.sched_clk
     47.32 ±  5%     -34.1%      31.20 ±  2%  perf-stat.i.MPKI
 3.453e+08            -9.5%  3.125e+08        perf-stat.i.branch-instructions
   1882849            -6.8%    1755021        perf-stat.i.branch-misses
     29.52            -0.7       28.82        perf-stat.i.cache-miss-rate%
  39865923 ±  3%     -32.7%   26846308 ±  2%  perf-stat.i.cache-misses
  90451157 ±  3%     -30.0%   63286362        perf-stat.i.cache-references
      2483 ±  2%      -4.2%       2377        perf-stat.i.context-switches
 5.997e+11            -2.1%  5.869e+11        perf-stat.i.cpu-cycles
    237.67            -8.7%     217.07        perf-stat.i.cpu-migrations
     87198 ±  3%     +44.5%     126003 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.08 ±  3%      +0.0        0.12 ± 10%  perf-stat.i.dTLB-load-miss-rate%
    275303 ±  5%     +58.6%     436747 ± 11%  perf-stat.i.dTLB-load-misses
 4.474e+08            -7.7%   4.13e+08        perf-stat.i.dTLB-loads
      0.56            -0.0        0.53        perf-stat.i.dTLB-store-miss-rate%
   1032613            -6.0%     970353        perf-stat.i.dTLB-store-misses
 1.959e+08            -2.9%  1.903e+08        perf-stat.i.dTLB-stores
 1.675e+09            -8.4%  1.534e+09        perf-stat.i.instructions
      2.68            -2.1%       2.62        perf-stat.i.metric.GHz
      1498            -1.5%       1476        perf-stat.i.metric.K/sec
      3.31           -12.8%       2.89        perf-stat.i.metric.M/sec
      4947           -13.5%       4277        perf-stat.i.minor-faults
     45.78 ±  2%      -8.0       37.82 ±  7%  perf-stat.i.node-load-miss-rate%
    808466           -53.6%     375110 ±  3%  perf-stat.i.node-load-misses
    984274 ±  4%     -22.8%     760195 ± 11%  perf-stat.i.node-loads
      4947           -13.5%       4278        perf-stat.i.page-faults
     51.07 ±  3%     -25.2%      38.19        perf-stat.overall.MPKI
      0.55            +0.0        0.56        perf-stat.overall.branch-miss-rate%
     42.92            -1.4       41.52 ±  2%  perf-stat.overall.cache-miss-rate%
    369.25            +8.2%     399.67        perf-stat.overall.cpi
     16877 ±  5%     +49.5%      25239 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.06 ±  4%      +0.0        0.10 ±  9%  perf-stat.overall.dTLB-load-miss-rate%
      0.53            -0.0        0.51        perf-stat.overall.dTLB-store-miss-rate%
      0.00            -7.6%       0.00        perf-stat.overall.ipc
     42.61           -10.8       31.85 ±  7%  perf-stat.overall.node-load-miss-rate%
 3.361e+08           -10.5%  3.009e+08        perf-stat.ps.branch-instructions
   1845829            -8.4%    1690701        perf-stat.ps.branch-misses
  35855895 ±  4%     -34.3%   23550666 ±  3%  perf-stat.ps.cache-misses
  83542707 ±  4%     -32.1%   56718514        perf-stat.ps.cache-references
      2469 ±  2%      -4.1%       2368        perf-stat.ps.context-switches
 6.037e+11            -1.7%  5.936e+11        perf-stat.ps.cpu-cycles
    235.31            -9.1%     213.98        perf-stat.ps.cpu-migrations
    262765 ±  5%     +53.5%     403343 ±  9%  perf-stat.ps.dTLB-load-misses
 4.376e+08            -8.4%  4.008e+08        perf-stat.ps.dTLB-loads
   1034201            -6.0%     972631        perf-stat.ps.dTLB-store-misses
 1.941e+08            -2.8%  1.886e+08        perf-stat.ps.dTLB-stores
 1.635e+09            -9.2%  1.485e+09        perf-stat.ps.instructions
      4761           -13.8%       4104        perf-stat.ps.minor-faults
    801748           -54.5%     364866 ±  3%  perf-stat.ps.node-load-misses
   1080815 ±  4%     -27.3%     785292 ±  8%  perf-stat.ps.node-loads
      4761           -13.8%       4104        perf-stat.ps.page-faults
 1.358e+12           +23.8%  1.681e+12        perf-stat.total.instructions
     16.32 ± 53%     -16.3        0.00        perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.cmd_sched.run_builtin.main
     16.32 ± 53%     -16.3        0.00        perf-profile.calltrace.cycles-pp.cmd_record.cmd_sched.run_builtin.main.__libc_start_main
     16.32 ± 53%     -16.3        0.00        perf-profile.calltrace.cycles-pp.cmd_sched.run_builtin.main.__libc_start_main
     14.04 ± 45%     -14.0        0.00        perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.cmd_sched.run_builtin
     14.02 ± 45%     -14.0        0.00        perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.cmd_sched
     15.72 ± 49%     -13.9        1.80 ±  7%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
     15.58 ± 49%     -13.9        1.70 ±  7%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
     15.56 ± 49%     -13.9        1.69 ±  7%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     15.18 ± 50%     -13.7        1.52 ±  8%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     17.01 ± 44%     -11.7        5.27 ±  4%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     11.57 ± 65%     -11.6        0.00        perf-profile.calltrace.cycles-pp.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     11.37 ± 65%     -11.4        0.00        perf-profile.calltrace.cycles-pp.migrate_misplaced_page.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     11.36 ± 65%     -11.4        0.00        perf-profile.calltrace.cycles-pp.migrate_pages.migrate_misplaced_page.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault
     11.36 ± 65%     -11.4        0.00        perf-profile.calltrace.cycles-pp.migrate_pages_batch.migrate_pages.migrate_misplaced_page.do_huge_pmd_numa_page.__handle_mm_fault
     10.69 ± 65%     -10.7        0.00        perf-profile.calltrace.cycles-pp.move_to_new_folio.migrate_pages_batch.migrate_pages.migrate_misplaced_page.do_huge_pmd_numa_page
     10.69 ± 65%     -10.7        0.00        perf-profile.calltrace.cycles-pp.migrate_folio_extra.move_to_new_folio.migrate_pages_batch.migrate_pages.migrate_misplaced_page
     10.67 ± 66%     -10.7        0.00        perf-profile.calltrace.cycles-pp.folio_copy.migrate_folio_extra.move_to_new_folio.migrate_pages_batch.migrate_pages
     10.52 ± 65%     -10.5        0.00        perf-profile.calltrace.cycles-pp.copy_page.folio_copy.migrate_folio_extra.move_to_new_folio.migrate_pages_batch
      8.81 ± 15%      -3.5        5.30        perf-profile.calltrace.cycles-pp.read
      8.70 ± 15%      -3.5        5.24        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      8.71 ± 15%      -3.5        5.25        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      8.57 ± 15%      -3.4        5.18        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      8.50 ± 15%      -3.4        5.12        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.64 ± 15%      -2.7        2.91 ±  4%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.60 ± 15%      -2.7        2.90 ±  4%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      4.62 ± 16%      -2.5        2.09 ± 13%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.60 ± 16%      -2.5        2.09 ± 13%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      4.27 ± 16%      -2.3        1.97 ±  6%  perf-profile.calltrace.cycles-pp.proc_single_show.seq_read_iter.seq_read.vfs_read.ksys_read
      5.22 ± 14%      -1.9        3.34 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.20 ± 14%      -1.9        3.33 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.14 ± 15%      -1.8        2.32 ± 12%  perf-profile.calltrace.cycles-pp.open64
      3.77 ± 17%      -1.8        1.95 ±  6%  perf-profile.calltrace.cycles-pp.do_task_stat.proc_single_show.seq_read_iter.seq_read.vfs_read
      4.08 ± 16%      -1.8        2.28 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      4.07 ± 15%      -1.8        2.27 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      4.09 ± 16%      -1.8        2.28 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      4.05 ± 15%      -1.8        2.25 ± 12%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.48 ± 11%      -1.6        0.83 ± 21%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      2.37 ± 12%      -1.6        0.75 ± 21%  perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.56 ± 10%      -1.5        4.04 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      5.56 ± 10%      -1.5        4.04 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.56 ± 10%      -1.5        4.04 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.55 ± 10%      -1.5        4.03 ±  6%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.56 ± 10%      -1.5        4.04 ±  6%  perf-profile.calltrace.cycles-pp.execve
      2.23 ± 13%      -1.5        0.73 ± 22%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newstat.do_syscall_64
      2.21 ± 13%      -1.5        0.73 ± 22%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newstat
      3.92 ±  9%      -1.0        2.88 ±  7%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.59 ±  8%      -0.9        0.68 ± 75%  perf-profile.calltrace.cycles-pp.__poll.__cmd_record.cmd_record.run_builtin.main
      1.58 ±  8%      -0.9        0.68 ± 75%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll.__cmd_record.cmd_record.run_builtin
      1.58 ±  8%      -0.9        0.68 ± 75%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll.__cmd_record.cmd_record
      2.44 ±  9%      -0.9        1.54 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.44 ±  9%      -0.9        1.54 ±  6%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.57 ±  8%      -0.9        0.68 ± 75%  perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll.__cmd_record
      1.57 ±  8%      -0.9        0.68 ± 75%  perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      2.43 ±  9%      -0.9        1.54 ±  6%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.70 ± 10%      -0.8        1.91 ±  6%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      2.71 ± 10%      -0.8        1.92 ±  7%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      2.71 ± 10%      -0.8        1.93 ±  7%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      1.80 ± 10%      -0.7        1.06 ±  5%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      1.82 ± 10%      -0.7        1.08 ±  5%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.81 ± 10%      -0.7        1.07 ±  6%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      1.27 ±  8%      -0.7        0.54 ± 75%  perf-profile.calltrace.cycles-pp.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.29 ±  6%      -0.6        1.67 ± 18%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      1.31 ± 13%      -0.6        0.76 ±  7%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.94 ±  3%      -0.5        0.43 ± 74%  perf-profile.calltrace.cycles-pp.perf_poll.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
      1.35 ± 18%      -0.5        0.86 ± 20%  perf-profile.calltrace.cycles-pp.__xstat64
      1.32 ± 18%      -0.5        0.84 ± 21%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64
      1.32 ± 18%      -0.5        0.84 ± 21%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      1.29 ± 18%      -0.5        0.81 ± 22%  perf-profile.calltrace.cycles-pp.cpu_stopper_thread.smpboot_thread_fn.kthread.ret_from_fork
      1.31 ± 17%      -0.5        0.83 ± 21%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      1.02 ± 15%      -0.4        0.62 ±  6%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      1.13 ± 14%      -0.4        0.76 ±  5%  perf-profile.calltrace.cycles-pp.alloc_bprm.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74 ± 13%      -0.4        0.37 ± 71%  perf-profile.calltrace.cycles-pp.pcpu_alloc.__percpu_counter_init.mm_init.alloc_bprm.do_execveat_common
      1.11 ± 12%      -0.4        0.74 ± 19%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
      1.11 ± 12%      -0.4        0.74 ± 19%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.07 ± 14%      -0.4        0.71 ±  6%  perf-profile.calltrace.cycles-pp.mm_init.alloc_bprm.do_execveat_common.__x64_sys_execve.do_syscall_64
      1.01 ± 14%      -0.3        0.68 ±  6%  perf-profile.calltrace.cycles-pp.__percpu_counter_init.mm_init.alloc_bprm.do_execveat_common.__x64_sys_execve
      1.02 ±  4%      -0.3        0.69 ±  7%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.68 ±  8%      -0.3        0.36 ± 70%  perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      0.68 ±  9%      -0.3        0.36 ± 70%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
      1.27 ± 11%      -0.3        0.97 ±  9%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      1.10 ± 17%      -0.3        0.80 ± 22%  perf-profile.calltrace.cycles-pp.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn.kthread.ret_from_fork
      1.18 ± 14%      -0.3        0.89 ± 13%  perf-profile.calltrace.cycles-pp.__vfork
      1.10 ± 10%      -0.3        0.82 ±  5%  perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      1.11 ±  3%      -0.3        0.84 ±  8%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.11 ±  3%      -0.3        0.84 ±  8%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.14 ± 15%      -0.3        0.87 ± 14%  perf-profile.calltrace.cycles-pp.kernel_clone.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      1.15 ± 15%      -0.3        0.88 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      1.14 ± 15%      -0.3        0.88 ± 14%  perf-profile.calltrace.cycles-pp.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      1.15 ± 14%      -0.3        0.89 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__vfork
      1.05 ±  7%      -0.2        0.86 ±  6%  perf-profile.calltrace.cycles-pp.sched_exec.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.92 ±  6%      -0.1        0.78 ±  5%  perf-profile.calltrace.cycles-pp.find_idlest_cpu.select_task_rq_fair.sched_exec.bprm_execve.do_execveat_common
      0.92 ±  6%      -0.1        0.78 ±  5%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.sched_exec.bprm_execve.do_execveat_common.__x64_sys_execve
      0.87 ±  6%      -0.1        0.74 ±  5%  perf-profile.calltrace.cycles-pp.update_sg_wakeup_stats.find_idlest_group.find_idlest_cpu.select_task_rq_fair.sched_exec
      0.89 ±  5%      -0.1        0.76 ±  5%  perf-profile.calltrace.cycles-pp.find_idlest_group.find_idlest_cpu.select_task_rq_fair.sched_exec.bprm_execve
      0.17 ±141%      +0.4        0.61 ±  6%  perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
      0.17 ±141%      +0.4        0.61 ±  6%  perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event
      0.57 ±  4%      +0.5        1.03 ± 14%  perf-profile.calltrace.cycles-pp.perf_mmap_fault.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.64 ±  7%      +0.5        1.12 ± 15%  perf-profile.calltrace.cycles-pp.__do_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.76 ±  8%      +0.5        2.26 ±  7%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.18 ±141%      +0.5        0.68 ±  6%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime
      0.22 ±141%      +0.6        0.78 ±  7%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
      0.00            +0.6        0.57 ±  7%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages.__folio_alloc
      0.00            +0.6        0.59 ±  7%  perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
      0.00            +0.6        0.59 ± 13%  perf-profile.calltrace.cycles-pp.finish_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.00            +0.6        0.60 ± 10%  perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter
      0.00            +0.6        0.63 ± 13%  perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable
      0.00            +0.8        0.75 ± 32%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu
      0.00            +0.8        0.81 ±  6%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity
      0.00            +0.8        0.82 ± 27%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.8        0.82 ± 28%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.9        0.85 ±  6%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair
      0.00            +0.9        0.89 ±  6%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair.__schedule
      0.18 ±141%      +0.9        1.08 ±  4%  perf-profile.calltrace.cycles-pp.find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable
      0.18 ±141%      +0.9        1.08 ±  4%  perf-profile.calltrace.cycles-pp.mt_find.find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.98 ±  7%      +0.9        2.88 ±  7%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +0.9        0.91 ± 27%  perf-profile.calltrace.cycles-pp.evlist__id2evsel.evsel__read_counter.read_counters.process_interval.dispatch_events
      0.00            +1.0        0.98 ± 18%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.0        0.98 ± 18%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.0        1.01 ±  6%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +1.0        1.05 ±  7%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.00            +1.1        1.07 ±  7%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.rcu_gp_fqs_loop
      0.80 ± 21%      +1.1        1.88 ± 11%  perf-profile.calltrace.cycles-pp.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio.shmem_alloc_and_acct_folio
      0.80 ± 21%      +1.1        1.88 ± 11%  perf-profile.calltrace.cycles-pp.__folio_alloc.vma_alloc_folio.shmem_alloc_folio.shmem_alloc_and_acct_folio.shmem_get_folio_gfp
      0.42 ± 72%      +1.1        1.52 ± 12%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.18 ±141%      +1.2        1.39 ± 11%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.__folio_alloc.vma_alloc_folio
      5.51 ±  8%      +1.3        6.78 ± 13%  perf-profile.calltrace.cycles-pp.ret_from_fork
      5.51 ±  8%      +1.3        6.78 ± 13%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.58 ± 70%      +1.3        1.87 ± 28%  perf-profile.calltrace.cycles-pp.evsel__read_counter.read_counters.process_interval.dispatch_events.cmd_stat
      0.00            +1.5        1.49 ±  7%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread
      0.00            +1.5        1.50 ±  6%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00            +1.5        1.54 ± 53%  perf-profile.calltrace.cycles-pp.__pthread_disable_asynccancel.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
      0.00            +1.6        1.58 ±  4%  perf-profile.calltrace.cycles-pp.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread.ret_from_fork
      0.00            +1.7        1.75 ± 52%  perf-profile.calltrace.cycles-pp.ring_buffer_read_head.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      0.00            +1.8        1.75 ± 52%  perf-profile.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      0.00            +1.9        1.91 ±  3%  perf-profile.calltrace.cycles-pp.rcu_gp_fqs_loop.rcu_gp_kthread.kthread.ret_from_fork
      0.90 ± 20%      +2.0        2.94 ±  6%  perf-profile.calltrace.cycles-pp.vma_alloc_folio.shmem_alloc_folio.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      0.93 ± 18%      +2.1        3.05 ±  7%  perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      1.46 ±  9%      +2.2        3.61 ±  7%  perf-profile.calltrace.cycles-pp.shmem_write_end.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write
      0.00            +2.2        2.23 ±  3%  perf-profile.calltrace.cycles-pp.rcu_gp_kthread.kthread.ret_from_fork
      2.63 ± 12%      +2.4        4.99 ±  2%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable
      2.05 ± 29%      +2.9        4.97 ±  3%  perf-profile.calltrace.cycles-pp.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter
      4.09 ±  3%      +3.9        8.01        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable
      4.16 ±  3%      +4.0        8.15        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write
      4.77 ± 11%      +4.0        8.78 ±  3%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      4.86 ± 11%      +4.1        8.99 ±  3%  perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write
      5.19 ±  8%      +4.5        9.68        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.__generic_file_write_iter
      6.87 ±  6%      +7.1       13.95 ±  5%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write
      6.38 ±  8%      +7.7       14.12 ±  4%  perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      9.62 ±  8%     +11.6       21.24 ±  6%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter
      9.67 ±  8%     +11.8       21.50 ±  6%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      9.78 ±  8%     +12.0       21.78 ±  6%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write
      9.55 ± 13%     +13.0       22.53 ± 30%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main.__libc_start_main
      9.54 ± 13%     +13.0       22.53 ± 30%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.run_builtin.main.__libc_start_main
      7.33 ± 15%     +13.2       20.53 ± 32%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin
      7.87 ± 15%     +13.8       21.70 ± 33%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin.main
     23.97 ±  7%     +25.5       49.46 ±  3%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
     24.04 ±  7%     +25.7       49.71 ±  3%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
     24.12 ±  7%     +25.9       49.98 ±  3%  perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.34 ±  7%     +26.2       50.56 ±  3%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     24.46 ±  7%     +26.4       50.86 ±  3%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.writen
     24.57 ±  7%     +26.5       51.08 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.writen.record__pushfn
     24.58 ±  7%     +26.5       51.10 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write.writen.record__pushfn.perf_mmap__push
     24.66 ±  7%     +26.6       51.29 ±  3%  perf-profile.calltrace.cycles-pp.__libc_write.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
     24.91 ±  7%     +28.1       52.99 ±  4%  perf-profile.calltrace.cycles-pp.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      6.71 ± 95%     +29.8       36.47 ± 11%  perf-profile.calltrace.cycles-pp.__cmd_record
      4.58 ±118%     +31.1       35.66 ± 10%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      4.67 ±117%     +31.2       35.86 ± 10%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      4.72 ±116%     +31.2       35.97 ± 10%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record
     16.32 ± 53%     -16.3        0.00        perf-profile.children.cycles-pp.cmd_sched
     18.49 ± 40%     -12.4        6.13 ±  3%  perf-profile.children.cycles-pp.__handle_mm_fault
     19.38 ± 38%     -12.0        7.43 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
     11.95 ± 64%     -11.9        0.07 ±141%  perf-profile.children.cycles-pp.migrate_misplaced_page
     11.93 ± 64%     -11.9        0.07 ±141%  perf-profile.children.cycles-pp.migrate_pages
     11.93 ± 64%     -11.9        0.07 ±141%  perf-profile.children.cycles-pp.migrate_pages_batch
     11.66 ± 65%     -11.6        0.06 ±141%  perf-profile.children.cycles-pp.do_huge_pmd_numa_page
     10.90 ± 64%     -10.8        0.06 ±141%  perf-profile.children.cycles-pp.move_to_new_folio
     10.90 ± 64%     -10.8        0.06 ±141%  perf-profile.children.cycles-pp.migrate_folio_extra
     11.40 ± 61%     -10.8        0.57 ± 68%  perf-profile.children.cycles-pp.copy_page
     10.86 ± 64%     -10.8        0.06 ±141%  perf-profile.children.cycles-pp.folio_copy
     21.02 ± 35%     -10.5       10.55        perf-profile.children.cycles-pp.do_user_addr_fault
     21.21 ± 35%     -10.4       10.77        perf-profile.children.cycles-pp.exc_page_fault
     22.22 ± 33%     -10.3       11.95        perf-profile.children.cycles-pp.asm_exc_page_fault
      8.84 ± 15%      -3.5        5.31        perf-profile.children.cycles-pp.read
      9.33 ± 14%      -3.2        6.13 ±  5%  perf-profile.children.cycles-pp.vfs_read
      9.53 ± 13%      -3.2        6.36 ±  6%  perf-profile.children.cycles-pp.ksys_read
      7.48 ± 14%      -3.1        4.39 ±  3%  perf-profile.children.cycles-pp.seq_read_iter
      5.64 ± 15%      -2.7        2.91 ±  4%  perf-profile.children.cycles-pp.seq_read
      5.39 ± 14%      -2.4        2.99 ± 11%  perf-profile.children.cycles-pp.do_sys_openat2
      5.41 ± 14%      -2.4        3.02 ± 11%  perf-profile.children.cycles-pp.__x64_sys_openat
      5.12 ± 15%      -2.3        2.80 ± 12%  perf-profile.children.cycles-pp.do_filp_open
      5.11 ± 15%      -2.3        2.79 ± 12%  perf-profile.children.cycles-pp.path_openat
      4.27 ± 16%      -2.3        1.97 ±  6%  perf-profile.children.cycles-pp.proc_single_show
      3.78 ± 17%      -1.8        1.96 ±  5%  perf-profile.children.cycles-pp.do_task_stat
      4.15 ± 15%      -1.8        2.33 ± 12%  perf-profile.children.cycles-pp.open64
      2.56 ± 11%      -1.7        0.86 ± 20%  perf-profile.children.cycles-pp.__xstat64
      2.57 ± 10%      -1.6        0.93 ± 19%  perf-profile.children.cycles-pp.__do_sys_newstat
      2.56 ± 10%      -1.6        0.92 ± 19%  perf-profile.children.cycles-pp.vfs_fstatat
      2.44 ± 12%      -1.6        0.84 ± 21%  perf-profile.children.cycles-pp.vfs_statx
      2.49 ± 13%      -1.6        0.94 ± 21%  perf-profile.children.cycles-pp.filename_lookup
      5.59 ± 10%      -1.5        4.05 ±  6%  perf-profile.children.cycles-pp.__x64_sys_execve
      5.58 ± 10%      -1.5        4.05 ±  6%  perf-profile.children.cycles-pp.do_execveat_common
      2.46 ± 13%      -1.5        0.93 ± 21%  perf-profile.children.cycles-pp.path_lookupat
      5.56 ± 10%      -1.5        4.04 ±  6%  perf-profile.children.cycles-pp.execve
      2.20 ± 14%      -1.3        0.86 ±  9%  perf-profile.children.cycles-pp.walk_component
      2.12 ± 13%      -1.2        0.94 ±  4%  perf-profile.children.cycles-pp.link_path_walk
      3.96 ±  9%      -1.0        2.91 ±  7%  perf-profile.children.cycles-pp.bprm_execve
      2.17 ± 17%      -1.0        1.13 ± 23%  perf-profile.children.cycles-pp.lookup_fast
      2.52 ±  9%      -0.9        1.60 ±  6%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      2.52 ±  9%      -0.9        1.60 ±  6%  perf-profile.children.cycles-pp.do_group_exit
      2.51 ±  9%      -0.9        1.59 ±  6%  perf-profile.children.cycles-pp.do_exit
      2.01 ±  2%      -0.9        1.12 ± 57%  perf-profile.children.cycles-pp.__poll
      2.49 ± 10%      -0.9        1.60 ±  5%  perf-profile.children.cycles-pp.__mmput
      1.99 ±  2%      -0.9        1.11 ± 58%  perf-profile.children.cycles-pp.do_sys_poll
      2.47 ±  9%      -0.9        1.59 ±  5%  perf-profile.children.cycles-pp.exit_mmap
      1.99 ±  2%      -0.9        1.11 ± 58%  perf-profile.children.cycles-pp.__x64_sys_poll
      2.72 ± 10%      -0.8        1.93 ±  7%  perf-profile.children.cycles-pp.exec_binprm
      1.92 ± 21%      -0.8        1.13 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.71 ± 10%      -0.8        1.93 ±  7%  perf-profile.children.cycles-pp.search_binary_handler
      2.70 ± 10%      -0.8        1.91 ±  6%  perf-profile.children.cycles-pp.load_elf_binary
      1.88 ± 21%      -0.8        1.11 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.69 ± 21%      -0.7        0.95 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.82 ± 10%      -0.7        1.09 ±  6%  perf-profile.children.cycles-pp.exit_mm
      1.61 ±  4%      -0.7        0.89 ± 57%  perf-profile.children.cycles-pp.do_poll
      1.58 ± 10%      -0.7        0.89 ±  6%  perf-profile.children.cycles-pp.do_open
      1.13 ± 12%      -0.7        0.47 ± 21%  perf-profile.children.cycles-pp.step_into
      2.29 ±  6%      -0.6        1.67 ± 18%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.16 ±  7%      -0.6        0.54 ±  5%  perf-profile.children.cycles-pp.filemap_map_pages
      1.44 ± 21%      -0.6        0.82 ±  5%  perf-profile.children.cycles-pp.tick_sched_timer
      1.41 ± 21%      -0.6        0.80 ±  6%  perf-profile.children.cycles-pp.tick_sched_handle
      1.01 ± 14%      -0.6        0.40 ± 23%  perf-profile.children.cycles-pp.pick_link
      1.39 ± 21%      -0.6        0.79 ±  7%  perf-profile.children.cycles-pp.update_process_times
      2.36 ± 12%      -0.6        1.76 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      1.30 ± 10%      -0.6        0.71 ± 10%  perf-profile.children.cycles-pp.task_work_run
      0.92 ±  8%      -0.6        0.34 ±  3%  perf-profile.children.cycles-pp.__fxstat64
      0.91 ± 18%      -0.6        0.33 ± 14%  perf-profile.children.cycles-pp.try_charge_memcg
      2.59 ± 11%      -0.6        2.01        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.14 ± 26%      -0.6        0.57 ±  7%  perf-profile.children.cycles-pp.task_tick_fair
      0.82 ± 13%      -0.6        0.25 ± 18%  perf-profile.children.cycles-pp.__lookup_slow
      0.65 ± 41%      -0.6        0.08 ± 17%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      1.34 ± 10%      -0.6        0.78 ±  2%  perf-profile.children.cycles-pp.unmap_vmas
      1.31 ± 22%      -0.6        0.75 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      1.21 ± 16%      -0.6        0.66 ± 36%  perf-profile.children.cycles-pp.open_last_lookups
      1.18 ± 11%      -0.5        0.65        perf-profile.children.cycles-pp.zap_pmd_range
      1.16 ± 11%      -0.5        0.63        perf-profile.children.cycles-pp.zap_pte_range
      1.21 ± 10%      -0.5        0.68        perf-profile.children.cycles-pp.unmap_page_range
      0.90 ±  8%      -0.5        0.39 ± 10%  perf-profile.children.cycles-pp.pid_revalidate
      0.56 ±  7%      -0.5        0.06 ± 71%  perf-profile.children.cycles-pp.newidle_balance
      0.86 ±  3%      -0.5        0.36 ± 11%  perf-profile.children.cycles-pp.next_uptodate_page
      1.16 ± 19%      -0.5        0.66 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
      1.42 ± 14%      -0.5        0.92 ±  9%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.22 ± 12%      -0.5        0.73 ±  6%  perf-profile.children.cycles-pp.do_dentry_open
      1.37 ± 14%      -0.5        0.89 ±  9%  perf-profile.children.cycles-pp.do_mmap
      1.29 ± 18%      -0.5        0.81 ± 22%  perf-profile.children.cycles-pp.cpu_stopper_thread
      1.28 ± 13%      -0.5        0.81 ±  9%  perf-profile.children.cycles-pp.mmap_region
      0.85 ± 21%      -0.4        0.40 ±  4%  perf-profile.children.cycles-pp.__close_nocancel
      1.39 ± 16%      -0.4        0.94 ±  7%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.90 ± 17%      -0.4        0.46 ± 10%  perf-profile.children.cycles-pp.getdents64
      0.90 ± 17%      -0.4        0.46 ± 10%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.90 ± 17%      -0.4        0.46 ± 10%  perf-profile.children.cycles-pp.iterate_dir
      0.89 ± 16%      -0.4        0.45 ±  9%  perf-profile.children.cycles-pp.proc_pid_readdir
      1.45 ± 16%      -0.4        1.01 ± 10%  perf-profile.children.cycles-pp.mm_init
      1.03 ± 26%      -0.4        0.62 ± 39%  perf-profile.children.cycles-pp.__d_lookup_rcu
      1.37 ± 16%      -0.4        0.96 ±  9%  perf-profile.children.cycles-pp.__percpu_counter_init
      1.34 ± 17%      -0.4        0.94 ±  9%  perf-profile.children.cycles-pp.pcpu_alloc
      1.05 ± 15%      -0.4        0.65 ±  5%  perf-profile.children.cycles-pp.charge_memcg
      0.73            -0.4        0.35 ± 21%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.64 ± 22%      -0.4        0.26 ±  7%  perf-profile.children.cycles-pp.ptrace_may_access
      0.69 ±  4%      -0.4        0.31 ± 34%  perf-profile.children.cycles-pp.wait_for_lsr
      1.13 ± 14%      -0.4        0.76 ±  5%  perf-profile.children.cycles-pp.alloc_bprm
      1.11 ± 12%      -0.4        0.74 ± 19%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.70 ±  9%      -0.4        0.34 ± 10%  perf-profile.children.cycles-pp.tlb_finish_mmu
      1.04 ±  9%      -0.4        0.69        perf-profile.children.cycles-pp.finish_task_switch
      1.16 ± 20%      -0.4        0.80 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.62 ± 12%      -0.4        0.27 ± 19%  perf-profile.children.cycles-pp.inode_permission
      0.95 ± 24%      -0.3        0.60 ±  7%  perf-profile.children.cycles-pp.rcu_do_batch
      0.99 ± 14%      -0.3        0.65 ± 13%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      2.00 ±  9%      -0.3        1.67 ±  7%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.13 ± 12%      -0.3        0.80 ±  4%  perf-profile.children.cycles-pp.__mmdrop
      1.57 ± 10%      -0.3        1.25 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      0.91 ±  8%      -0.3        0.59 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.65 ± 18%      -0.3        0.34 ±  7%  perf-profile.children.cycles-pp.__fput
      1.89 ±  8%      -0.3        1.58 ±  6%  perf-profile.children.cycles-pp.find_idlest_cpu
      1.27 ± 11%      -0.3        0.97 ±  9%  perf-profile.children.cycles-pp.begin_new_exec
      1.10 ± 17%      -0.3        0.80 ± 22%  perf-profile.children.cycles-pp.migration_cpu_stop
      0.50 ± 18%      -0.3        0.20 ± 18%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.71 ± 25%      -0.3        0.41 ±  7%  perf-profile.children.cycles-pp.alloc_empty_file
      0.83 ±  9%      -0.3        0.54 ± 21%  perf-profile.children.cycles-pp.serial8250_console_write
      0.83 ±  9%      -0.3        0.54 ± 21%  perf-profile.children.cycles-pp.console_unlock
      0.83 ±  9%      -0.3        0.54 ± 21%  perf-profile.children.cycles-pp.console_flush_all
      1.18 ± 14%      -0.3        0.89 ± 13%  perf-profile.children.cycles-pp.__vfork
      0.69 ± 26%      -0.3        0.40 ±  7%  perf-profile.children.cycles-pp.__alloc_file
      0.59 ±  5%      -0.3        0.30 ± 36%  perf-profile.children.cycles-pp.__wait_for_common
      0.83 ±  9%      -0.3        0.55 ± 18%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.83 ±  9%      -0.3        0.55 ± 18%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.83 ±  9%      -0.3        0.55 ± 18%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.83 ±  9%      -0.3        0.55 ± 18%  perf-profile.children.cycles-pp.irq_work_run
      0.83 ±  9%      -0.3        0.55 ± 18%  perf-profile.children.cycles-pp.irq_work_run_list
      0.83 ±  9%      -0.3        0.55 ± 18%  perf-profile.children.cycles-pp.irq_work_single
      0.83 ±  9%      -0.3        0.55 ± 18%  perf-profile.children.cycles-pp._printk
      0.83 ±  9%      -0.3        0.55 ± 18%  perf-profile.children.cycles-pp.vprintk_emit
      0.59 ± 12%      -0.3        0.31 ± 16%  perf-profile.children.cycles-pp.kmem_cache_free
      0.74 ± 21%      -0.3        0.46 ± 20%  perf-profile.children.cycles-pp.vmstat_start
      1.10 ± 10%      -0.3        0.82 ±  5%  perf-profile.children.cycles-pp.exec_mmap
      0.56 ± 12%      -0.3        0.28 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      1.02 ± 13%      -0.3        0.75 ±  3%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.49 ±  5%      -0.3        0.22 ± 32%  perf-profile.children.cycles-pp.change_prot_numa
      1.14 ± 15%      -0.3        0.88 ± 14%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.65 ± 11%      -0.3        0.39 ±  6%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.64 ± 19%      -0.3        0.38 ±  4%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.63 ± 19%      -0.3        0.37 ±  6%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.45 ± 16%      -0.3        0.19 ± 17%  perf-profile.children.cycles-pp.d_alloc
      0.50 ± 21%      -0.3        0.25 ± 13%  perf-profile.children.cycles-pp.proc_task_name
      0.41 ± 25%      -0.2        0.16 ±  6%  perf-profile.children.cycles-pp.security_ptrace_access_check
      0.28 ± 17%      -0.2        0.04 ± 71%  perf-profile.children.cycles-pp.flush_tlb_func
      0.50 ± 16%      -0.2        0.26 ±  9%  perf-profile.children.cycles-pp.proc_fill_cache
      0.96 ± 13%      -0.2        0.73 ± 14%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.27 ± 14%      -0.2        0.04 ± 70%  perf-profile.children.cycles-pp.lookup_open
      0.78 ±  7%      -0.2        0.55        perf-profile.children.cycles-pp.wp_page_copy
      1.73 ±  8%      -0.2        1.50 ±  6%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      1.76 ±  8%      -0.2        1.54 ±  6%  perf-profile.children.cycles-pp.find_idlest_group
      0.94 ± 12%      -0.2        0.72 ±  5%  perf-profile.children.cycles-pp.io_serial_in
      1.12 ± 11%      -0.2        0.90 ±  6%  perf-profile.children.cycles-pp.wake_up_new_task
      0.60 ± 19%      -0.2        0.39 ± 18%  perf-profile.children.cycles-pp.set_task_cpu
      0.52 ± 15%      -0.2        0.31        perf-profile.children.cycles-pp.elf_map
      0.67 ± 21%      -0.2        0.46 ± 25%  perf-profile.children.cycles-pp.write
      0.54 ± 18%      -0.2        0.33 ± 17%  perf-profile.children.cycles-pp.perf_trace_sched_migrate_task
      0.49 ±  4%      -0.2        0.28 ± 30%  perf-profile.children.cycles-pp.task_numa_work
      0.65 ± 14%      -0.2        0.44 ±  7%  perf-profile.children.cycles-pp.do_anonymous_page
      0.48 ± 13%      -0.2        0.28 ±  3%  perf-profile.children.cycles-pp.setlocale
      0.27 ± 33%      -0.2        0.07 ± 18%  perf-profile.children.cycles-pp.free_unref_page
      0.56 ± 14%      -0.2        0.36 ± 10%  perf-profile.children.cycles-pp.free_pgtables
      1.45 ±  3%      -0.2        1.25 ±  8%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.30 ± 19%      -0.2        0.10 ± 16%  perf-profile.children.cycles-pp.___slab_alloc
      0.44 ± 11%      -0.2        0.25 ± 13%  perf-profile.children.cycles-pp.__do_sys_newfstat
      1.05 ±  7%      -0.2        0.86 ±  6%  perf-profile.children.cycles-pp.sched_exec
      0.58 ± 23%      -0.2        0.39 ±  7%  perf-profile.children.cycles-pp.fold_vm_numa_events
      0.23 ± 37%      -0.2        0.04 ± 73%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.34 ± 17%      -0.2        0.15 ±  6%  perf-profile.children.cycles-pp.__d_alloc
      0.79 ±  5%      -0.2        0.60 ±  9%  perf-profile.children.cycles-pp.__cond_resched
      0.30 ±  8%      -0.2        0.12 ± 21%  perf-profile.children.cycles-pp.may_open
      0.35 ± 10%      -0.2        0.17 ± 16%  perf-profile.children.cycles-pp.vfs_fstat
      0.38 ± 30%      -0.2        0.20 ± 16%  perf-profile.children.cycles-pp.wq_worker_comm
      0.29 ± 19%      -0.2        0.11        perf-profile.children.cycles-pp.single_release
      0.36 ± 20%      -0.2        0.18 ± 21%  perf-profile.children.cycles-pp.next_tgid
      0.44 ± 16%      -0.2        0.26 ±  8%  perf-profile.children.cycles-pp.__open64_nocancel
      0.37 ± 32%      -0.2        0.20 ±  6%  perf-profile.children.cycles-pp.__slab_free
      0.36 ±  8%      -0.2        0.19 ± 75%  perf-profile.children.cycles-pp.poll_freewait
      0.37 ± 18%      -0.2        0.19 ±  6%  perf-profile.children.cycles-pp.__d_lookup
      0.33 ± 11%      -0.2        0.16 ± 13%  perf-profile.children.cycles-pp.dput
      0.32 ± 18%      -0.2        0.15 ± 14%  perf-profile.children.cycles-pp.vsnprintf
      0.43 ± 11%      -0.2        0.27 ± 13%  perf-profile.children.cycles-pp.mod_objcg_state
      0.25 ± 17%      -0.2        0.09 ± 24%  perf-profile.children.cycles-pp.__lock_task_sighand
      0.44 ±  6%      -0.2        0.29 ±  8%  perf-profile.children.cycles-pp.__mmap
      0.25 ± 28%      -0.2        0.09 ± 13%  perf-profile.children.cycles-pp.apparmor_ptrace_access_check
      0.41 ± 15%      -0.2        0.25 ± 26%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.23 ± 12%      -0.2        0.08 ± 36%  perf-profile.children.cycles-pp.generic_fillattr
      0.20 ± 13%      -0.2        0.04 ± 76%  perf-profile.children.cycles-pp.shuffle_freelist
      0.51 ± 16%      -0.2        0.36 ± 18%  perf-profile.children.cycles-pp.perf_callchain_user
      0.22 ± 13%      -0.2        0.07 ± 28%  perf-profile.children.cycles-pp.allocate_slab
      0.52 ± 11%      -0.1        0.37 ±  7%  perf-profile.children.cycles-pp.wait4
      0.68 ±  4%      -0.1        0.54 ±  5%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.23 ± 17%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__kmem_cache_free
      0.45 ±  3%      -0.1        0.31 ±  5%  perf-profile.children.cycles-pp._dl_addr
      0.32 ± 19%      -0.1        0.17 ±  9%  perf-profile.children.cycles-pp.d_hash_and_lookup
      0.23 ± 12%      -0.1        0.09 ± 35%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.25 ± 19%      -0.1        0.11 ± 73%  perf-profile.children.cycles-pp.add_wait_queue
      0.23 ± 14%      -0.1        0.09 ± 18%  perf-profile.children.cycles-pp.sync_regs
      0.25 ± 24%      -0.1        0.11 ± 37%  perf-profile.children.cycles-pp.pid_nr_ns
      0.21 ± 10%      -0.1        0.07 ± 28%  perf-profile.children.cycles-pp.seq_printf
      0.46 ± 11%      -0.1        0.32 ± 10%  perf-profile.children.cycles-pp.kernel_wait4
      0.45 ± 11%      -0.1        0.32 ±  9%  perf-profile.children.cycles-pp.do_wait
      0.31 ± 10%      -0.1        0.17 ± 30%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.46 ±  8%      -0.1        0.33 ±  5%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.32 ±  5%      -0.1        0.19 ±  4%  perf-profile.children.cycles-pp.getname_flags
      0.28 ± 16%      -0.1        0.15 ± 10%  perf-profile.children.cycles-pp.__vm_munmap
      0.32 ± 24%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.__memset
      0.39 ± 16%      -0.1        0.27 ± 12%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.22 ± 11%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.vm_area_alloc
      0.26 ± 18%      -0.1        0.14 ± 12%  perf-profile.children.cycles-pp.proc_pid_get_link
      0.44 ± 13%      -0.1        0.33 ±  6%  perf-profile.children.cycles-pp.__get_user_pages
      0.17 ±  7%      -0.1        0.05 ± 74%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.42 ±  6%      -0.1        0.30 ±  5%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.45 ± 13%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.22 ± 11%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.26 ± 13%      -0.1        0.15 ± 17%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.32 ± 10%      -0.1        0.21 ±  5%  perf-profile.children.cycles-pp.setup_arg_pages
      0.22 ± 24%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.task_dump_owner
      0.20 ± 23%      -0.1        0.10 ± 17%  perf-profile.children.cycles-pp.__kmalloc_node
      0.34 ±  7%      -0.1        0.23 ± 24%  perf-profile.children.cycles-pp.perf_event_mmap
      0.33 ±  7%      -0.1        0.22 ± 24%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.53 ±  4%      -0.1        0.43 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
      0.27 ± 17%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.load_elf_interp
      0.16 ± 16%      -0.1        0.06        perf-profile.children.cycles-pp.__dentry_kill
      0.29 ± 16%      -0.1        0.19 ±  2%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.32 ± 12%      -0.1        0.22 ± 11%  perf-profile.children.cycles-pp.single_open
      0.40 ± 11%      -0.1        0.30 ± 16%  perf-profile.children.cycles-pp.put_prev_entity
      0.23 ± 15%      -0.1        0.13 ± 21%  perf-profile.children.cycles-pp.drm_gem_vunmap
      0.23 ± 15%      -0.1        0.13 ± 21%  perf-profile.children.cycles-pp.drm_gem_shmem_vunmap
      0.39 ± 10%      -0.1        0.29 ±  8%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.28 ± 16%      -0.1        0.18 ± 13%  perf-profile.children.cycles-pp.__x64_sys_readlink
      0.23 ± 15%      -0.1        0.14 ± 20%  perf-profile.children.cycles-pp.drm_gem_vunmap_unlocked
      0.27 ±  9%      -0.1        0.18 ±  5%  perf-profile.children.cycles-pp.shift_arg_pages
      0.19 ± 24%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.__x64_sys_close
      0.17 ± 14%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.page_remove_rmap
      0.27 ± 16%      -0.1        0.18 ± 13%  perf-profile.children.cycles-pp.do_readlinkat
      0.23 ± 14%      -0.1        0.14 ± 15%  perf-profile.children.cycles-pp.user_path_at_empty
      0.35 ±  6%      -0.1        0.26 ± 18%  perf-profile.children.cycles-pp.diskstats_show
      0.16 ± 25%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.path_init
      0.13 ±  9%      -0.1        0.05 ± 70%  perf-profile.children.cycles-pp.getenv
      0.13 ±  9%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.13 ±  9%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.mas_preallocate
      0.17 ± 19%      -0.1        0.09 ± 31%  perf-profile.children.cycles-pp.do_open_execat
      0.17 ± 17%      -0.1        0.08 ± 31%  perf-profile.children.cycles-pp.__ptrace_may_access
      0.21 ± 12%      -0.1        0.12 ± 16%  perf-profile.children.cycles-pp.strncpy_from_user
      0.21 ±  6%      -0.1        0.13 ± 13%  perf-profile.children.cycles-pp.unlink_file_vma
      0.14 ± 26%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.20 ±  8%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.unmap_region
      0.36 ± 11%      -0.1        0.28 ±  8%  perf-profile.children.cycles-pp.release_pages
      0.16 ± 36%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.errseq_sample
      0.11 ± 22%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.perf_rotate_context
      0.22 ±  9%      -0.1        0.14 ± 28%  perf-profile.children.cycles-pp.atime_needs_update
      0.25 ±  6%      -0.1        0.17 ±  7%  perf-profile.children.cycles-pp.proc_pid_cmdline_read
      0.17 ± 14%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.mas_walk
      0.22 ±  8%      -0.1        0.15 ± 17%  perf-profile.children.cycles-pp.kmalloc_trace
      0.13 ±  9%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.vmstat_shepherd
      0.11 ± 16%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.slab_show
      0.12 ± 13%      -0.1        0.05 ± 84%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.18 ± 16%      -0.1        0.11 ± 26%  perf-profile.children.cycles-pp.fput
      0.15 ± 23%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.filp_close
      0.31 ±  7%      -0.1        0.25 ±  8%  perf-profile.children.cycles-pp.__check_object_size
      0.13 ± 17%      -0.1        0.07 ± 79%  perf-profile.children.cycles-pp.free_unref_page_list
      0.20 ± 12%      -0.1        0.13 ± 19%  perf-profile.children.cycles-pp.select_task_rq
      0.10 ± 21%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.touch_atime
      0.16 ± 10%      -0.1        0.10 ± 14%  perf-profile.children.cycles-pp.__call_rcu_common
      0.24 ±  3%      -0.1        0.18 ± 17%  perf-profile.children.cycles-pp.malloc
      0.14 ±  9%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.10 ± 16%      -0.1        0.04 ± 76%  perf-profile.children.cycles-pp.get_pid_task
      0.28 ±  3%      -0.1        0.22 ± 18%  perf-profile.children.cycles-pp.do_cow_fault
      0.11 ± 12%      -0.1        0.05 ± 72%  perf-profile.children.cycles-pp.thread_group_cputime_adjusted
      0.11 ± 15%      -0.1        0.05 ± 71%  perf-profile.children.cycles-pp.thread_group_cputime
      0.17 ±  7%      -0.1        0.11 ± 14%  perf-profile.children.cycles-pp.seq_puts
      0.14 ± 18%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.move_page_tables
      0.16 ±  7%      -0.1        0.10 ± 19%  perf-profile.children.cycles-pp.drm_gem_shmem_put_pages_locked
      0.16 ±  7%      -0.1        0.10 ± 19%  perf-profile.children.cycles-pp.drm_gem_put_pages
      0.10 ±  4%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.strlen
      0.15 ± 26%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.node_read_vmstat
      0.16 ± 15%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.seq_open
      0.18 ± 14%      -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.15 ± 11%      -0.1        0.10 ± 12%  perf-profile.children.cycles-pp.create_elf_tables
      0.13 ± 16%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.find_extend_vma
      0.14 ± 14%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__access_remote_vm
      0.09 ± 18%      -0.1        0.04 ± 76%  perf-profile.children.cycles-pp.d_path
      0.26 ±  6%      -0.0        0.21 ±  4%  perf-profile.children.cycles-pp.copy_strings
      0.11 ± 14%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.stop_one_cpu
      0.10 ± 12%      -0.0        0.06 ± 71%  perf-profile.children.cycles-pp.__list_add_valid
      0.08 ± 14%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.do_brk_flags
      0.12 ± 20%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.14 ± 26%      -0.0        0.10 ± 17%  perf-profile.children.cycles-pp.get_zeroed_page
      0.09 ± 18%      -0.0        0.05 ± 72%  perf-profile.children.cycles-pp._exit
      0.11 ±  4%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.part_stat_read_all
      0.17 ±  7%      -0.0        0.12 ± 10%  perf-profile.children.cycles-pp.strnlen_user
      0.27 ±  6%      -0.0        0.23 ±  7%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.08 ± 22%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.__d_add
      0.15 ± 12%      -0.0        0.11 ± 19%  perf-profile.children.cycles-pp.do_notify_parent
      0.15 ±  9%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.clear_page_erms
      0.12 ± 13%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.complete_signal
      0.12 ±  4%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.unmap_single_vma
      0.09 ± 18%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.16 ± 10%      -0.0        0.13 ± 13%  perf-profile.children.cycles-pp.exit_notify
      0.11 ±  8%      -0.0        0.08 ± 30%  perf-profile.children.cycles-pp.check_move_unevictable_pages
      0.12 ± 13%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.vma_complete
      0.12 ±  6%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.mas_split
      0.13 ± 12%      -0.0        0.10 ± 19%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.09 ± 13%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.map_vdso
      0.08 ± 14%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__install_special_mapping
      0.12 ± 10%      -0.0        0.09 ± 18%  perf-profile.children.cycles-pp.free_swap_cache
      0.09 ± 14%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp._copy_to_user
      0.07 ± 17%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.pgd_alloc
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__queue_work
      0.07 ±  6%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.get_cpu_idle_time_us
      0.07 ±  6%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.get_idle_time
      0.12 ± 11%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.perf_swevent_event
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.04 ± 71%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.error_entry
      0.07 ± 11%      +0.0        0.12 ± 29%  perf-profile.children.cycles-pp.__kmalloc
      0.04 ± 73%      +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.set_next_entity
      0.09 ±  9%      +0.1        0.15 ±  8%  perf-profile.children.cycles-pp.swake_up_one
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.perf_mmap__write_tail
      0.00            +0.1        0.06 ± 23%  perf-profile.children.cycles-pp._IO_file_fopen
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__mod_timer
      0.13 ± 21%      +0.1        0.20 ± 17%  perf-profile.children.cycles-pp.folio_unlock
      0.38 ± 10%      +0.1        0.44 ±  8%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.07 ± 23%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.rcu_report_qs_rdp
      0.07 ± 17%      +0.1        0.14 ± 29%  perf-profile.children.cycles-pp.xas_start
      0.03 ± 70%      +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.access_error
      0.02 ±141%      +0.1        0.09 ± 13%  perf-profile.children.cycles-pp.perf_mmap__consume
      0.06 ± 79%      +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.p4d_offset
      0.08 ± 14%      +0.1        0.16 ± 17%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.11 ± 11%      +0.1        0.19 ± 23%  perf-profile.children.cycles-pp.current_time
      0.08 ± 27%      +0.1        0.17 ± 29%  perf-profile.children.cycles-pp.__perf_read_group_add
      0.04 ± 71%      +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.__get_vma_policy
      0.17 ± 28%      +0.1        0.26 ± 17%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.05 ± 77%      +0.1        0.15 ± 21%  perf-profile.children.cycles-pp.shmem_is_huge
      0.47 ± 12%      +0.1        0.57 ±  9%  perf-profile.children.cycles-pp.security_file_permission
      0.30 ± 14%      +0.1        0.40 ± 10%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.05 ± 72%      +0.1        0.15 ± 13%  perf-profile.children.cycles-pp.down_read_trylock
      0.20 ± 16%      +0.1        0.30 ± 10%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.43 ± 13%      +0.1        0.54 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.10 ± 32%      +0.1        0.21 ±  8%  perf-profile.children.cycles-pp.blk_cgroup_congested
      0.11 ± 32%      +0.1        0.22 ±  7%  perf-profile.children.cycles-pp.__folio_throttle_swaprate
      0.00            +0.1        0.11 ± 12%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.03 ±141%      +0.1        0.14 ± 40%  perf-profile.children.cycles-pp.update_curr_rt
      0.03 ±141%      +0.1        0.14 ± 46%  perf-profile.children.cycles-pp.task_tick_rt
      0.34 ±  7%      +0.1        0.46 ±  6%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.21 ± 21%      +0.1        0.32 ± 17%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.31 ±  6%      +0.1        0.43 ± 12%  perf-profile.children.cycles-pp.folio_add_lru
      0.05 ± 71%      +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.xas_alloc
      0.49 ± 13%      +0.1        0.62 ±  6%  perf-profile.children.cycles-pp.orc_find
      0.00            +0.1        0.13 ± 13%  perf-profile.children.cycles-pp.policy_node
      0.00            +0.1        0.13 ± 43%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.10 ± 27%      +0.1        0.22 ±  9%  perf-profile.children.cycles-pp.xas_store
      0.00            +0.1        0.14 ± 13%  perf-profile.children.cycles-pp._IO_fread
      0.36 ± 12%      +0.1        0.50 ± 11%  perf-profile.children.cycles-pp.drm_fbdev_damage_blit_real
      0.37 ± 11%      +0.1        0.51 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.07 ± 23%      +0.1        0.21 ±  9%  perf-profile.children.cycles-pp.xas_create
      0.00            +0.1        0.14 ± 36%  perf-profile.children.cycles-pp.generic_write_checks
      0.66 ± 12%      +0.1        0.81 ±  5%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.07 ± 11%      +0.1        0.21 ± 36%  perf-profile.children.cycles-pp.file_update_time
      0.75 ±  7%      +0.2        0.90 ±  4%  perf-profile.children.cycles-pp.__unwind_start
      0.32 ±  7%      +0.2        0.48        perf-profile.children.cycles-pp.__fdget_pos
      0.12 ± 16%      +0.2        0.28 ± 33%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.10 ± 45%      +0.2        0.27 ±  8%  perf-profile.children.cycles-pp.inode_to_bdi
      0.13 ± 10%      +0.2        0.31 ± 29%  perf-profile.children.cycles-pp.workingset_activation
      0.21 ± 37%      +0.2        0.41 ± 34%  perf-profile.children.cycles-pp.__evlist__disable
      0.60 ±  6%      +0.2        0.79        perf-profile.children.cycles-pp.__orc_find
      0.00            +0.2        0.21 ± 29%  perf-profile.children.cycles-pp.rcu_gp_cleanup
      0.00            +0.2        0.22 ± 20%  perf-profile.children.cycles-pp.__snprintf_chk
      0.00            +0.2        0.23 ±  9%  perf-profile.children.cycles-pp.xas_nomem
      2.67 ±  3%      +0.2        2.92 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.39 ±  9%      +0.2        0.64 ±  3%  perf-profile.children.cycles-pp.do_set_pte
      0.17 ± 17%      +0.2        0.42 ± 24%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.41 ± 12%      +0.3        0.67 ±  6%  perf-profile.children.cycles-pp.__count_memcg_events
      0.92 ± 10%      +0.3        1.18 ±  5%  perf-profile.children.cycles-pp.filemap_get_entry
      0.00            +0.3        0.26 ± 39%  perf-profile.children.cycles-pp.force_qs_rnp
      0.15 ± 19%      +0.3        0.42 ± 10%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.09 ± 21%      +0.3        0.36 ±  8%  perf-profile.children.cycles-pp.zero_user_segments
      0.45 ± 15%      +0.3        0.73 ±  5%  perf-profile.children.cycles-pp.xas_load
      0.22 ± 16%      +0.3        0.51 ±  9%  perf-profile.children.cycles-pp.__vm_enough_memory
      1.52 ±  8%      +0.3        1.82 ±  7%  perf-profile.children.cycles-pp.__do_softirq
      1.58 ± 15%      +0.3        1.87 ±  4%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.35            +0.3        0.66 ± 12%  perf-profile.children.cycles-pp.perf_mmap_to_page
      2.34 ±  3%      +0.3        2.67 ±  2%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      2.18 ±  7%      +0.4        2.53        perf-profile.children.cycles-pp.perf_callchain_kernel
      1.97 ±  9%      +0.4        2.34 ±  2%  perf-profile.children.cycles-pp.unwind_next_frame
      0.77 ±  9%      +0.4        1.14 ±  6%  perf-profile.children.cycles-pp.___perf_sw_event
      1.04 ± 14%      +0.4        1.42 ± 10%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.37 ± 15%      +0.4        0.75 ±  2%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.75 ± 10%      +0.4        1.15 ±  5%  perf-profile.children.cycles-pp.__perf_sw_event
      3.86 ±  8%      +0.4        4.26 ±  3%  perf-profile.children.cycles-pp.__schedule
      0.44 ± 10%      +0.4        0.85 ±  3%  perf-profile.children.cycles-pp.finish_fault
      0.85 ±  4%      +0.5        1.31 ±  9%  perf-profile.children.cycles-pp.perf_mmap_fault
      1.11 ±  3%      +0.5        1.57 ± 10%  perf-profile.children.cycles-pp.__do_fault
      1.18 ±  4%      +0.5        1.72 ± 13%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.32 ± 45%      +0.6        0.89 ± 26%  perf-profile.children.cycles-pp.rebalance_domains
      0.32 ± 31%      +0.6        0.91 ± 28%  perf-profile.children.cycles-pp.evlist__id2evsel
      1.99 ± 11%      +0.7        2.66 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
      1.30 ± 12%      +0.7        2.03 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.71 ± 13%      +0.7        1.44 ±  7%  perf-profile.children.cycles-pp.mt_find
      1.55 ±  8%      +0.7        2.29 ±  2%  perf-profile.children.cycles-pp.__folio_alloc
      2.98 ± 11%      +0.8        3.73 ±  3%  perf-profile.children.cycles-pp.schedule
      0.66 ± 13%      +0.8        1.43 ±  7%  perf-profile.children.cycles-pp.find_vma
      0.93 ± 15%      +0.8        1.75 ±  3%  perf-profile.children.cycles-pp.rmqueue
      1.07 ± 10%      +0.9        1.95        perf-profile.children.cycles-pp.dequeue_entity
      1.16 ± 10%      +0.9        2.05 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.74 ± 24%      +1.1        1.87 ± 28%  perf-profile.children.cycles-pp.evsel__read_counter
      5.53 ±  8%      +1.3        6.79 ± 13%  perf-profile.children.cycles-pp.ret_from_fork
      5.51 ±  8%      +1.3        6.78 ± 13%  perf-profile.children.cycles-pp.kthread
      0.20 ± 44%      +1.4        1.62 ± 49%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.53 ± 20%      +1.4        1.96 ± 43%  perf-profile.children.cycles-pp.perf_mmap__read_head
      0.53 ± 20%      +1.4        1.97 ± 42%  perf-profile.children.cycles-pp.ring_buffer_read_head
      0.17 ± 33%      +1.5        1.63 ±  4%  perf-profile.children.cycles-pp.schedule_timeout
      1.65 ± 11%      +1.6        3.28        perf-profile.children.cycles-pp.vma_alloc_folio
      0.13 ± 47%      +1.8        1.91 ±  3%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      1.40 ±  9%      +1.8        3.22        perf-profile.children.cycles-pp.shmem_alloc_folio
      1.62 ±  3%      +2.0        3.62 ±  7%  perf-profile.children.cycles-pp.shmem_write_end
      0.16 ± 38%      +2.1        2.23 ±  3%  perf-profile.children.cycles-pp.rcu_gp_kthread
      2.34 ± 11%      +2.6        4.97 ±  3%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_folio
      5.43 ± 10%      +3.8        9.22        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      4.95 ± 11%      +4.0        9.00 ±  2%  perf-profile.children.cycles-pp.shmem_write_begin
      6.97 ±  6%      +6.9       13.84 ±  5%  perf-profile.children.cycles-pp.fault_in_readable
      7.00 ±  6%      +7.0       13.97 ±  5%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
     10.06 ±  7%     +11.6       21.68 ±  6%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      9.84 ±  8%     +11.7       21.52 ±  6%  perf-profile.children.cycles-pp.copyin
      9.94 ±  7%     +11.8       21.79 ±  6%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
     64.07 ± 10%     +12.2       76.28        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     63.99 ± 10%     +12.2       76.21        perf-profile.children.cycles-pp.do_syscall_64
     24.02 ±  7%     +25.5       49.50 ±  3%  perf-profile.children.cycles-pp.generic_perform_write
     24.08 ±  7%     +25.7       49.74 ±  3%  perf-profile.children.cycles-pp.__generic_file_write_iter
     24.15 ±  7%     +25.9       50.01 ±  3%  perf-profile.children.cycles-pp.generic_file_write_iter
     24.90 ±  7%     +26.1       51.01 ±  3%  perf-profile.children.cycles-pp.vfs_write
     25.04 ±  7%     +26.3       51.30 ±  3%  perf-profile.children.cycles-pp.ksys_write
     32.57 ±  9%     +26.4       59.00 ±  5%  perf-profile.children.cycles-pp.__cmd_record
     24.72 ±  7%     +26.7       51.39 ±  3%  perf-profile.children.cycles-pp.__libc_write
     24.94 ±  7%     +28.1       53.03 ±  4%  perf-profile.children.cycles-pp.writen
     25.22 ±  7%     +28.7       53.97 ±  4%  perf-profile.children.cycles-pp.record__pushfn
     26.03 ±  6%     +30.4       56.40 ±  6%  perf-profile.children.cycles-pp.perf_mmap__push
     26.64 ±  6%     +31.0       57.67 ±  6%  perf-profile.children.cycles-pp.record__mmap_read_evlist
     11.30 ± 61%     -10.7        0.57 ± 68%  perf-profile.self.cycles-pp.copy_page
      1.88 ± 16%      -0.9        0.95 ±  7%  perf-profile.self.cycles-pp.do_task_stat
      0.80 ± 15%      -0.6        0.24 ± 18%  perf-profile.self.cycles-pp.try_charge_memcg
      1.01 ± 26%      -0.6        0.46 ±  8%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.85 ±  4%      -0.5        0.36 ± 10%  perf-profile.self.cycles-pp.next_uptodate_page
      0.92 ±  9%      -0.4        0.49        perf-profile.self.cycles-pp.zap_pte_range
      0.54            -0.3        0.22 ± 23%  perf-profile.self.cycles-pp.pid_revalidate
      0.48 ± 10%      -0.3        0.18 ± 31%  perf-profile.self.cycles-pp.inode_permission
      0.98 ± 13%      -0.3        0.70 ±  4%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.52 ± 22%      -0.2        0.28 ±  5%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.45 ± 14%      -0.2        0.22 ± 19%  perf-profile.self.cycles-pp.kmem_cache_free
      1.73 ±  8%      -0.2        1.50 ±  6%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.57 ± 18%      -0.2        0.38 ±  5%  perf-profile.self.cycles-pp.pcpu_alloc
      0.40 ± 17%      -0.2        0.21 ± 18%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.37 ± 32%      -0.2        0.19 ±  6%  perf-profile.self.cycles-pp.__slab_free
      0.56 ± 22%      -0.2        0.38 ±  6%  perf-profile.self.cycles-pp.fold_vm_numa_events
      0.37 ±  8%      -0.2        0.20 ± 14%  perf-profile.self.cycles-pp.do_dentry_open
      0.73 ± 11%      -0.2        0.58 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.40 ± 15%      -0.2        0.25 ± 25%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.22 ± 12%      -0.1        0.08 ± 40%  perf-profile.self.cycles-pp.generic_fillattr
      0.30 ± 21%      -0.1        0.15 ± 16%  perf-profile.self.cycles-pp.__d_lookup
      0.33 ± 16%      -0.1        0.19 ±  2%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.23 ± 14%      -0.1        0.09 ± 18%  perf-profile.self.cycles-pp.sync_regs
      0.42 ±  2%      -0.1        0.29 ±  5%  perf-profile.self.cycles-pp._dl_addr
      0.23 ± 14%      -0.1        0.10 ± 35%  perf-profile.self.cycles-pp.pid_nr_ns
      0.64 ± 10%      -0.1        0.52 ± 10%  perf-profile.self.cycles-pp.io_serial_in
      0.29 ± 33%      -0.1        0.17 ± 14%  perf-profile.self.cycles-pp.__alloc_file
      0.42 ±  6%      -0.1        0.30 ±  4%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.39 ± 16%      -0.1        0.27 ± 12%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.22 ± 23%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.task_dump_owner
      0.25 ± 11%      -0.1        0.15 ± 17%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.16 ± 16%      -0.1        0.07 ± 11%  perf-profile.self.cycles-pp.proc_fill_cache
      0.25 ± 11%      -0.1        0.16 ± 24%  perf-profile.self.cycles-pp.mod_objcg_state
      0.29 ± 10%      -0.1        0.21 ± 11%  perf-profile.self.cycles-pp.do_syscall_64
      0.13 ± 30%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.filemap_map_pages
      0.16 ± 34%      -0.1        0.08 ± 27%  perf-profile.self.cycles-pp.errseq_sample
      0.13 ± 24%      -0.1        0.06 ± 23%  perf-profile.self.cycles-pp.__lock_task_sighand
      0.16 ± 25%      -0.1        0.08 ± 22%  perf-profile.self.cycles-pp.lookup_fast
      0.15 ± 16%      -0.1        0.08 ± 31%  perf-profile.self.cycles-pp.__ptrace_may_access
      0.17 ± 12%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.mas_walk
      0.47 ±  9%      -0.1        0.40 ±  3%  perf-profile.self.cycles-pp.__alloc_pages
      0.15 ±  8%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.malloc
      0.13 ± 33%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.wq_worker_comm
      0.12 ± 21%      -0.1        0.05 ± 71%  perf-profile.self.cycles-pp.__call_rcu_common
      0.14 ± 11%      -0.1        0.08 ± 44%  perf-profile.self.cycles-pp.atime_needs_update
      0.17 ± 10%      -0.1        0.11 ± 15%  perf-profile.self.cycles-pp.io_serial_out
      0.24 ±  8%      -0.1        0.18 ± 14%  perf-profile.self.cycles-pp.update_load_avg
      0.14 ± 33%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.next_tgid
      0.10 ± 19%      -0.1        0.04 ± 73%  perf-profile.self.cycles-pp.pick_link
      0.10 ± 14%      -0.1        0.05 ± 72%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru
      0.09 ±  9%      -0.1        0.04 ± 73%  perf-profile.self.cycles-pp.strlen
      0.08 ±  5%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.getenv
      0.21 ±  7%      -0.0        0.17 ± 14%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.22 ±  2%      -0.0        0.18 ± 12%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.17 ±  7%      -0.0        0.12 ± 10%  perf-profile.self.cycles-pp.strnlen_user
      0.13 ±  3%      -0.0        0.09 ± 33%  perf-profile.self.cycles-pp.fput
      0.10 ±  4%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.part_stat_read_all
      0.08 ± 14%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.__output_copy
      0.15 ±  8%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.clear_page_erms
      0.25            -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.09 ± 18%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.11 ±  7%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.unmap_single_vma
      0.12 ±  4%      -0.0        0.10 ± 12%  perf-profile.self.cycles-pp.fsnotify_perm
      0.08 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.__check_object_size
      0.07 ± 14%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.get_cpu_idle_time_us
      0.09 ±  5%      +0.0        0.12 ± 21%  perf-profile.self.cycles-pp.__perf_sw_event
      0.12 ±  8%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.perf_swevent_event
      0.20 ± 10%      +0.0        0.25 ± 10%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.11 ±  8%      +0.1        0.16 ± 10%  perf-profile.self.cycles-pp.exc_page_fault
      0.02 ±141%      +0.1        0.08 ± 16%  perf-profile.self.cycles-pp.error_entry
      0.28 ± 13%      +0.1        0.34 ±  8%  perf-profile.self.cycles-pp.handle_pte_fault
      0.13 ± 16%      +0.1        0.19 ± 19%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.13 ± 25%      +0.1        0.20 ± 17%  perf-profile.self.cycles-pp.folio_unlock
      0.07 ± 20%      +0.1        0.14 ± 28%  perf-profile.self.cycles-pp.xas_start
      0.18 ± 18%      +0.1        0.25 ± 15%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.20 ± 16%      +0.1        0.27 ± 23%  perf-profile.self.cycles-pp.perf_exclude_event
      0.07 ± 11%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.do_fault
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.folio_mark_dirty
      0.00            +0.1        0.07 ± 35%  perf-profile.self.cycles-pp.__perf_read_group_add
      0.05 ± 84%      +0.1        0.13 ± 16%  perf-profile.self.cycles-pp.p4d_offset
      0.03 ± 70%      +0.1        0.11 ± 19%  perf-profile.self.cycles-pp.access_error
      0.08 ± 14%      +0.1        0.16 ± 17%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.09 ± 35%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.blk_cgroup_congested
      0.10 ± 19%      +0.1        0.19 ± 12%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.17 ± 28%      +0.1        0.26 ± 17%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.05 ± 71%      +0.1        0.15 ± 14%  perf-profile.self.cycles-pp.down_read_trylock
      0.02 ±141%      +0.1        0.12 ± 10%  perf-profile.self.cycles-pp.__get_vma_policy
      0.05 ± 74%      +0.1        0.15 ± 19%  perf-profile.self.cycles-pp.shmem_is_huge
      0.29 ± 12%      +0.1        0.39 ± 11%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.14 ± 13%      +0.1        0.25 ±  6%  perf-profile.self.cycles-pp.handle_mm_fault
      0.00            +0.1        0.10 ± 19%  perf-profile.self.cycles-pp._IO_fread
      0.04 ± 73%      +0.1        0.15 ± 43%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.06 ±  8%      +0.1        0.17 ± 14%  perf-profile.self.cycles-pp.do_set_pte
      0.00            +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.policy_node
      0.00            +0.1        0.12 ± 10%  perf-profile.self.cycles-pp.fault_in_iov_iter_readable
      0.00            +0.1        0.13 ± 43%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.49 ± 12%      +0.1        0.62 ±  7%  perf-profile.self.cycles-pp.orc_find
      0.36 ± 10%      +0.1        0.49 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.05 ± 71%      +0.1        0.19 ± 12%  perf-profile.self.cycles-pp.shmem_write_begin
      0.50 ±  8%      +0.1        0.64 ±  7%  perf-profile.self.cycles-pp.perf_mmap_fault
      0.11 ± 14%      +0.2        0.27 ± 33%  perf-profile.self.cycles-pp.workingset_age_nonresident
      0.10 ± 49%      +0.2        0.26 ±  9%  perf-profile.self.cycles-pp.inode_to_bdi
      0.11 ± 12%      +0.2        0.28 ± 32%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.10 ± 12%      +0.2        0.26 ± 17%  perf-profile.self.cycles-pp.security_vm_enough_memory_mm
      0.17 ± 26%      +0.2        0.34 ± 18%  perf-profile.self.cycles-pp.generic_perform_write
      0.08 ± 16%      +0.2        0.26 ± 17%  perf-profile.self.cycles-pp.__vm_enough_memory
      0.59 ±  7%      +0.2        0.79        perf-profile.self.cycles-pp.__orc_find
      0.00            +0.2        0.21 ± 22%  perf-profile.self.cycles-pp.__snprintf_chk
      0.34 ± 15%      +0.2        0.55 ±  6%  perf-profile.self.cycles-pp.__count_memcg_events
      0.00            +0.2        0.21 ±  8%  perf-profile.self.cycles-pp.xas_nomem
      0.37 ± 14%      +0.2        0.58 ±  2%  perf-profile.self.cycles-pp.xas_load
      0.12 ± 26%      +0.2        0.34 ± 39%  perf-profile.self.cycles-pp.evsel__read_counter
      0.49 ±  4%      +0.3        0.75 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.34 ±  5%      +0.3        0.60 ±  9%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.34 ±  4%      +0.3        0.64 ± 13%  perf-profile.self.cycles-pp.perf_mmap_to_page
      0.16 ± 13%      +0.3        0.47 ±  5%  perf-profile.self.cycles-pp.rmqueue
      0.28 ± 18%      +0.3        0.61 ±  5%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.17 ± 28%      +0.4        0.62 ± 13%  perf-profile.self.cycles-pp.shmem_alloc_and_acct_folio
      0.54 ± 12%      +0.5        1.01 ±  8%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.65 ± 12%      +0.5        1.16 ±  6%  perf-profile.self.cycles-pp.__handle_mm_fault
      1.18 ±  4%      +0.5        1.72 ± 13%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.32 ± 31%      +0.6        0.90 ± 27%  perf-profile.self.cycles-pp.evlist__id2evsel
      0.13 ± 16%      +0.6        0.73 ±  5%  perf-profile.self.cycles-pp.vma_alloc_folio
      0.59 ± 20%      +0.6        1.20 ± 43%  perf-profile.self.cycles-pp.record__mmap_read_evlist
      0.21 ± 34%      +0.6        0.86 ± 46%  perf-profile.self.cycles-pp.record__pushfn
      0.68 ± 12%      +0.7        1.42 ±  7%  perf-profile.self.cycles-pp.mt_find
      0.50 ± 20%      +1.4        1.89 ± 44%  perf-profile.self.cycles-pp.ring_buffer_read_head
      0.20 ± 41%      +1.4        1.59 ± 49%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      1.40 ±  3%      +1.6        2.97 ± 11%  perf-profile.self.cycles-pp.shmem_write_end
      2.00 ± 14%      +2.2        4.16 ± 19%  perf-profile.self.cycles-pp.fault_in_readable
      9.90 ±  7%     +11.4       21.28 ±  6%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string



***************************************************************************************************
lkp-csl-2sp9: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz (Cascade Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/debug-setup/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/performance/no-monitor/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp9/numa02_SMT/autonuma-benchmark

commit: 
  ef6a22b70f ("sched/numa: apply the scan delay to every new vma")
  fc137c0dda ("sched/numa: enhance vma scanning logic")

ef6a22b70f6d9044 fc137c0ddab29b591db6a091dc6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    203.37 ±  8%     +48.9%     302.87 ±  3%  autonuma-benchmark.numa01.seconds
     13.85            -0.4%      13.80        autonuma-benchmark.numa02.seconds
     12.20            -0.2%      12.18        autonuma-benchmark.numa02_SMT.seconds
    921.30 ±  7%     +43.2%       1318 ±  3%  autonuma-benchmark.time.elapsed_time
    921.30 ±  7%     +43.2%       1318 ±  3%  autonuma-benchmark.time.elapsed_time.max
    100152 ±  7%     +25.0%     125198 ±  6%  autonuma-benchmark.time.involuntary_context_switches
   1693712 ±  2%      +5.0%    1778818 ±  2%  autonuma-benchmark.time.minor_page_faults
      7776            -4.7%       7409        autonuma-benchmark.time.percent_of_cpu_this_job_got
     69860 ±  8%     +37.4%      95961 ±  4%  autonuma-benchmark.time.user_time
     39149 ±  8%     -56.8%      16895 ±  3%  autonuma-benchmark.time.voluntary_context_switches





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



--ksk6qpSXzNdvl33U
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.3.0-rc4-00203-gfc137c0ddab2"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.3.0-rc4 Kernel Configuration
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
CONFIG_SRCU=y
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
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
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
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
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
# CONFIG_SYSFS_DEPRECATED is not set
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
# CONFIG_EXPERT is not set
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
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

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
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
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
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
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
CONFIG_CPU_UNRET_ENTRY=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_CPU_IBPB_ENTRY=y
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
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
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
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
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
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
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
CONFIG_NETFILTER_XTABLES_COMPAT=y

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
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
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
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
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
# CONFIG_IXGB is not set
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
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
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
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
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
CONFIG_I2C_SMBUS=y
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
CONFIG_I2C_I801=y
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
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
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
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
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
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
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
# CONFIG_INTEL_MENLOW is not set
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
CONFIG_LPC_ICH=y
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

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
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
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
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
CONFIG_FB_CMDLINE=y
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
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
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
# CONFIG_LEDS_TRIGGER_GPIO is not set
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
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
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
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
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
CONFIG_IOASID=y
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
# CONFIG_TEE is not set
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
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
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
CONFIG_PRINT_QUOTA_WARNING=y
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
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
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
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"

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
CONFIG_OBJTOOL=y
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
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
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
CONFIG_PER_VMA_LOCK_STATS=y
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
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
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

--ksk6qpSXzNdvl33U
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='autonuma-benchmark'
	export testcase='autonuma-benchmark'
	export category='benchmark'
	export iterations=4
	export job_origin='autonuma-benchmark.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-csl-2sp9'
	export tbox_group='lkp-csl-2sp9'
	export submit_id='6453a8ad63d7180713407c13'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp9/autonuma-benchmark-performance-4x-numa02_SMT-debian-11.1-x86_64-20220510.cgz-fc137c0ddab29b591db6a091dc6d7ce20ccb73f2-20230504-132883-1js575k-4.yaml'
	export id='653239987f85f0a43b7cb4d30f233f9261acf148'
	export queuer_version='/zday/lkp'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=88
	export memory='128G'
	export nr_hdd_partitions=4
	export nr_ssd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC13Q1RD-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part1'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part2'
	export brand='Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz'
	export commit='fc137c0ddab29b591db6a091dc6d7ce20ccb73f2'
	export ucode='0x5003303'
	export need_kconfig_hw='{"I40E"=>"y"}
SATA_AHCI
INTEL_TH
INTEL_TH_ACPI'
	export kconfig='x86_64-rhel-8.3'
	export enqueue_time='2023-05-04 20:44:29 +0800'
	export _id='6453a8c363d7180713407c14'
	export _rt='/result/autonuma-benchmark/performance-4x-numa02_SMT/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/fc137c0ddab29b591db6a091dc6d7ce20ccb73f2'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='2bce2e4ad6465f26d505cea06520e9f25f150752'
	export base_commit='457391b0380335d5e9a5babdec90ac53928b23b4'
	export branch='linus/master'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/autonuma-benchmark/performance-4x-numa02_SMT/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/fc137c0ddab29b591db6a091dc6d7ce20ccb73f2/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/autonuma-benchmark/performance-4x-numa02_SMT/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/fc137c0ddab29b591db6a091dc6d7ce20ccb73f2/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/fc137c0ddab29b591db6a091dc6d7ce20ccb73f2/vmlinuz-6.3.0-rc4-00203-gfc137c0ddab2
branch=linus/master
job=/lkp/jobs/scheduled/lkp-csl-2sp9/autonuma-benchmark-performance-4x-numa02_SMT-debian-11.1-x86_64-20220510.cgz-fc137c0ddab29b591db6a091dc6d7ce20ccb73f2-20230504-132883-1js575k-4.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3
commit=fc137c0ddab29b591db6a091dc6d7ce20ccb73f2
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-11/fc137c0ddab29b591db6a091dc6d7ce20ccb73f2/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/autonuma-benchmark_20220718.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/autonuma-benchmark-x86_64-fdf7a42-1_20220605.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20230402.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.3.0-rc7'
	export repeat_to=6
	export schedule_notify_address=
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-11/fc137c0ddab29b591db6a091dc6d7ce20ccb73f2/vmlinuz-6.3.0-rc4-00203-gfc137c0ddab2'
	export dequeue_time='2023-05-04 20:46:02 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp9/autonuma-benchmark-performance-4x-numa02_SMT-debian-11.1-x86_64-20220510.cgz-fc137c0ddab29b591db6a091dc6d7ce20ccb73f2-20230504-132883-1js575k-4.cgz'

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

	run_test test='numa02_SMT' $LKP_SRC/tests/wrapper autonuma-benchmark
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='numa02_SMT' $LKP_SRC/stats/wrapper autonuma-benchmark
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

	$LKP_SRC/stats/wrapper time autonuma-benchmark.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--ksk6qpSXzNdvl33U
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/autonuma-benchmark.yaml
suite: autonuma-benchmark
testcase: autonuma-benchmark
category: benchmark
iterations: 4x
autonuma-benchmark:
  test: numa02_SMT
job_origin: autonuma-benchmark.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
- kbuild_queue_analysis
queue: bisect
testbox: lkp-csl-2sp9
tbox_group: lkp-csl-2sp9
submit_id: 645362ef63d718946e5cf5fa
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp9/autonuma-benchmark-performance-4x-numa02_SMT-debian-11.1-x86_64-20220510.cgz-fc137c0ddab29b591db6a091dc6d7ce20ccb73f2-20230504-37998-1py48oq-0.yaml"
id: 6c5000e1cb6f023e375ef117a81adfecbcc8561f
queuer_version: "/zday/lkp"

#! /db/releases/20230429150311/lkp-src/hosts/lkp-csl-2sp9
model: Cascade Lake
nr_node: 2
nr_cpu: 88
memory: 128G
nr_hdd_partitions: 4
nr_ssd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC13Q1RD-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part1"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part2"
brand: Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz

#! /db/releases/20230429150311/lkp-src/include/category/benchmark
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

#! /db/releases/20230429150311/lkp-src/include/category/ALL
cpufreq_governor: performance

#! /db/releases/20230429150311/lkp-src/include/queue/cyclic
commit: fc137c0ddab29b591db6a091dc6d7ce20ccb73f2

#! /db/releases/20230429150311/lkp-src/include/testbox/lkp-csl-2sp9
ucode: '0x5003303'
need_kconfig_hw:
- I40E: y
- SATA_AHCI
- INTEL_TH
- INTEL_TH_ACPI
kconfig: x86_64-rhel-8.3
enqueue_time: 2023-05-04 15:46:55.861957195 +08:00
_id: 645362ef63d718946e5cf5fa
_rt: "/result/autonuma-benchmark/performance-4x-numa02_SMT/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/fc137c0ddab29b591db6a091dc6d7ce20ccb73f2"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 2bce2e4ad6465f26d505cea06520e9f25f150752
base_commit: 457391b0380335d5e9a5babdec90ac53928b23b4
branch: linux-devel/devel-hourly-20230501-191049
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/autonuma-benchmark/performance-4x-numa02_SMT/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/fc137c0ddab29b591db6a091dc6d7ce20ccb73f2/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/autonuma-benchmark/performance-4x-numa02_SMT/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/fc137c0ddab29b591db6a091dc6d7ce20ccb73f2/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/fc137c0ddab29b591db6a091dc6d7ce20ccb73f2/vmlinuz-6.3.0-rc4-00203-gfc137c0ddab2
- branch=linux-devel/devel-hourly-20230501-191049
- job=/lkp/jobs/scheduled/lkp-csl-2sp9/autonuma-benchmark-performance-4x-numa02_SMT-debian-11.1-x86_64-20220510.cgz-fc137c0ddab29b591db6a091dc6d7ce20ccb73f2-20230504-37998-1py48oq-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- commit=fc137c0ddab29b591db6a091dc6d7ce20ccb73f2
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-11/fc137c0ddab29b591db6a091dc6d7ce20ccb73f2/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/autonuma-benchmark_20220718.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/autonuma-benchmark-x86_64-fdf7a42-1_20220605.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20230402.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01

#! /db/releases/20230430200016/lkp-src/include/site/lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.3.0-14788-g47116b89bf38
repeat_to: 3
schedule_notify_address:

#! user overrides
kbuild_queue_analysis: 1
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-11/fc137c0ddab29b591db6a091dc6d7ce20ccb73f2/vmlinuz-6.3.0-rc4-00203-gfc137c0ddab2"
dequeue_time: 2023-05-04 16:19:23.883403376 +08:00

#! /db/releases/20230504152259/lkp-src/include/site/lkp-wsx01
job_state: finished
loadavg: 44.95 70.82 67.28 1/838 57609
start_time: '1683188448'
end_time: '1683190336'
version: "/lkp/lkp/.src-20230430-200205:236b18d8fe13:46412388565a"

--ksk6qpSXzNdvl33U
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done


--ksk6qpSXzNdvl33U--
