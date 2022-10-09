Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54965F8A4D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJIJJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJIJJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:09:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A23231214;
        Sun,  9 Oct 2022 02:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665306561; x=1696842561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A+8sBr5Nis3L2/wWoWJ3luDJahn8XAGcK0TJAXGQbhM=;
  b=kZIhK5UAn8XmXbgKKifPpWT4+ZMlE8kszS0knke/m8iHOhNTvGSaeyd5
   G/Yb8YGYROfw1qmJeZGp93N1BrmO7iuvIWlKMlljptOb/mQZ1mTm7sOww
   U8yunT/hXFMcjGW32xa3/Awkt1IrRW2xDclfwIK77M7S3wqwpL9vfpxKe
   Zw8cjNbv15+Vo6pMtfooz/Pf3weuUEoo8I1NR8BBBqvKkppnNfj37+4f5
   Qac+xgkfGdFRK4XnncxdolAkgRjdxUIb7Yfvc/jy376ehDZRQUv+iZnt7
   Wo+kNjcEWqHRyl83ZoX88Sg45zPBioKoIh8Ir7d7Av/wjBbJuABKbRYCe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="305630738"
X-IronPort-AV: E=Sophos;i="5.95,171,1661842800"; 
   d="xz'?yaml'?scan'208";a="305630738"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 02:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="870795082"
X-IronPort-AV: E=Sophos;i="5.95,171,1661842800"; 
   d="xz'?yaml'?scan'208";a="870795082"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 09 Oct 2022 02:09:18 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 02:09:17 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 02:09:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 9 Oct 2022 02:09:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 9 Oct 2022 02:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUuihqzpA6+9cFOY7VnzJRluNFjDTFekzu2kRdF2ReOioV9TSzlvbPyevhIdA43ZXzLC2v6VzIuQ15arWvmuOqOv5mLhinCuKLkTH7OueX88oJhO/XD9ZPfpTub6p5PeToWwi280P8b6O8o//wQ/j+g+tb3ELbmgsd1vDWQs5DKi6R/xtjN4jR7NyajH3Ub1xD1fOgKYv4pwVB+O8YMIHNpXAjUdiAWPgNnR33Yw0GO/zv1NqXztIAQdMuUOEdWYvvvjY/OMoxmnFes+hHcaOUoRrXP8d/pGnZOJz5OJQKEeBwCcpmcsWRHCqjM9Y3ePB5N0Xl+Ge4a9zeryGsjP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsnX9uk92Ya9WmGH4vTWCw/AeYZ0w3lfeveWfWtQmyQ=;
 b=jPhmOpjFf34aHzZRhu8KFQT6fTSJLjD5m7tshoit8q3jXFB3OogdlHHFdi5RhG3vw4ZwOUFZEjX/Vy+jw3zBtL20N0x1K2hDGwvJqkRszEyeZuWHgFeijx+2Fg4baaYDzdy/7mp+tJPs/Nja8KDNtCPs/O3vG60o6tt6nK9DjyT7pvNqZ4ED/XvHCuSV89WC+ihzHnEAkDg3IhuD4zw81wHEed8gOQQVlXxEPtm/CAD0UBo/LvmVfx0yi9PYzktoiuGW/lyhEx9md12sQz1jvGu2reBZjSkPvnc5gwDS2nJRaN/IPm7uSTOLsEAGiElaelkrI/wEzza4xag5B0e5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) by
 MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sun, 9 Oct
 2022 09:09:12 +0000
Received: from DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::3a1b:7b6b:aded:fbfc]) by DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::3a1b:7b6b:aded:fbfc%5]) with mapi id 15.20.5654.025; Sun, 9 Oct 2022
 09:09:12 +0000
Date:   Sun, 9 Oct 2022 17:07:37 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     <lkp@lists.01.org>, <lkp@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: [KVM] 21d4c575eb: perf-sanity-tests.Test_event_parsing.fail
Message-ID: <202210091636.2f13027d-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="3rmRS0lZBdM/b5cE"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6397:EE_|MN2PR11MB4677:EE_
X-MS-Office365-Filtering-Correlation-Id: c61b746f-10f7-4926-a573-08daa9d5edc7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHRLwFXTgN8LGdabC/BN4GC2ewyUwXht6WwU7zWd6wp8jXRYag42M+McRFqCUnZdkUwQWCOz9zVajjwI0CzvfAJMcaTM0+sdSE+0RJj5i9vdpH+vDUIsD1aAZtiD9WdzdwNDgbJ6XrN68fg7Upj93Bbpl//4szPpHdHP6f8c80IXs3zctr6Ebz+OH01omyVncv9CR2mkD6sXZwS/3ECMIRF2uQ4p+j0Z3eLb4w31DZ0e2Amz4jUui8jbX59U1ebx7+0iOBxJX5pvQioIo2R3OKkHRJs6wzrynCrRkC1uCRvO0dqxGFD/AaOXKrJbVdcQ/M75joeSTOFXUJoOuPHx5U8wNmxo125GGaZ07pt9j/KINYkJOdSdJHF062TEZpEV2g+n/uHQypdatoEdoHDzuvai/kaSR3azxf/jVN/k5SsE8u0P+w/IKFGUXkrDvp6FJsUmP/ru3F1QjK2wz/mmV9p20FjeXeBRWJvrYsFI8+C5jgLMTUf9fUpHr2FJ9kFqVv/Q3reb9QxEa5ca3IXt6qNZAHRqqZakHwj5pg+T3ShZWThOQsIV5ICetqv70d46nQ+t6KzOQti0ZKGB2Mr878aco4jM3ZT9kJLEYuZ3PxehmEo43KWeKil2hQlDgLHTw0mdtWW98Bu+q4rDEzdQvopjy5npqjd9qpTeOl8ZlbnSSzowfkTO+mrdWGoUEVu6wnrYYV8+Wz7gccIr1ObDdKyBG/p08B1Sq26Wf29i0wiIcnDeGChCyJRXudKnQk1Uu5p+TqKiDmr3QRKcs4IQzAleyXtLfjQsW/NpJBUiuXDmgpgxC5Wd6j6V208E2mHPP6OJnAlp2IEe2txTk44kOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6397.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199015)(83380400001)(5660300002)(36756003)(235185007)(8936002)(2906002)(2616005)(1076003)(6512007)(186003)(8676002)(30864003)(4326008)(6666004)(44144004)(66556008)(66946007)(6506007)(41300700001)(26005)(66476007)(38100700002)(82960400001)(86362001)(21490400003)(478600001)(6486002)(316002)(6916009)(966005)(54906003)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kUFoiqwiPUDCab0AFPbUnyd1mz5gq1bBM/v33uMJA3DNtM6syMmBYoNBB4O1?=
 =?us-ascii?Q?SMnFAS1x4dXXxZY1Wx7i3eRF93DI04PKp7RmSJYKPx2RchyHuPE6BEtY83CR?=
 =?us-ascii?Q?wdI8avi706R+oebT7Y+o5yb7ymISAYaDj//GAdwTXVfN2qQj9aNAko3p0R95?=
 =?us-ascii?Q?F964lYxp5GtyJ743LBUExPXGa4/6siSxMYN6YUbLRo9omNlWbFsJ8203bkFZ?=
 =?us-ascii?Q?HU40yHHuc4DMRprPiJRfRaT/lOuP/HVkdUpnB0Qlg+oWfISdprnTk2XGYNeT?=
 =?us-ascii?Q?lLW7S6j4mFlidi3PUQVRjCoXsTca2CG7u3bgwJNv0LOShQgcTwpEF8bE59/H?=
 =?us-ascii?Q?/ZuqN13B46T+Lpp4qK84xN6whzW3beQQf3wLGDddLL2kFjEAKC77LGl43d8M?=
 =?us-ascii?Q?oFadutmdKrIp31tW6Y0bxabYHn0mgpMsW3nGqNhLUsWjPbJ5XTqodXAII83o?=
 =?us-ascii?Q?OjoaONq6o7ur+APjybLIixbUdce4wV+T2q1VfDhgcfM2Yk5Ms9uNRvLsUr1G?=
 =?us-ascii?Q?+b8+7Fxl0fn8OhlvyaatOVzkOzGpbkjW7NiPAa5XVFaKJb1AiA5VQiIZnzv3?=
 =?us-ascii?Q?l40tqEHZHhZJNVAgnaJKzQFI7cpLr6DAOqQiKvwxTC4teFHuO5UU58jru/dK?=
 =?us-ascii?Q?8DBzh9jHoW79onTJ4O+4XUQOc84lrw7v7zXSKQKFZrcSjVpUgQ/VzW23Lpw4?=
 =?us-ascii?Q?YgZ6P75jinGaSspWS+aQTUWMtP+Pq/21QhJ57tuu3+wOgUnv7z61qVgAvXbd?=
 =?us-ascii?Q?OEUTCvdw2MgkPKrypK23vkYpM+jPinQB3Cg6Y0lichoS2h7N0/EDPszSdIh7?=
 =?us-ascii?Q?weMyFRtpFA+vcBHOa4RGV+zSbLwbYC1ZZxaF9UkRuunYuXiJbdgWl/RHVdxU?=
 =?us-ascii?Q?2H/oKOS9lfen45buggwSzmeQAFkF3qGoRDxiqyNkVsiertg8gITds8hn1c0j?=
 =?us-ascii?Q?UadRmxj5J5FmVu4hFTX0nsEwtPG/vH9jgniC5m8tim3Q+N5WJQAkI2fzwZ8N?=
 =?us-ascii?Q?BrLezcU1fyKFIjB9bJoN3Fwgl78dhOcCnVU6OJdhiqswQqM3szvj7t7GDG1T?=
 =?us-ascii?Q?QfKQWiuF2ffr/vjfXTVTsN1/hncA2H1vrePnP8F9pHY9kF+JXI7GpaqOi21g?=
 =?us-ascii?Q?ok44lOt2yQBiSkJ6cHhn/ceep/bluet/8S1E6zqFwhDKl/q/A25ixiiTmGxZ?=
 =?us-ascii?Q?fef6FmgWSsy4inq6Ms3/QipkJHYu1FnZkCQGXYOXJsgheVRR3yl6/SnmwRZA?=
 =?us-ascii?Q?lQpl1CkfTV5sql00A3SEMUpigWgFU0PCHW5IJvY2FJMpXYgQiV+O4Na4FHAn?=
 =?us-ascii?Q?A/RgPT3RLkl2PQo7K7iz0NavajAvUOE5lH1xDV9cFBXOeSyhV4laq73M8yHa?=
 =?us-ascii?Q?Ip4L5CZRLCAThSpMKwTtCVg4kk8Yxdw9ACrdsogAkY6qakGjXS8y54eLdwEF?=
 =?us-ascii?Q?gex1ZSCwP1hok3C9OQigdtGJh1akULJSbPJuG5gVeyuvMd3R5cvOgo3auiDo?=
 =?us-ascii?Q?RRU5g0nbb6TtNx94M/Suf17hES0KqRx9G6fw5ep8zq1OTfrQBZu+0fNkiJR/?=
 =?us-ascii?Q?QafuVYTtlIrKPfNKVCLo5OkHzbNLhjvy6X+FLlWH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c61b746f-10f7-4926-a573-08daa9d5edc7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6397.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 09:09:11.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4umqNP3wIfLbQzqnbkRsPZYJvNmdSt69tzte4XLMEDODbeTMDScNMaoi58hY7MPKrIYUFVTbRVFm00vn3bj+5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--3rmRS0lZBdM/b5cE
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: 21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba ("KVM: x86: Print error code in exception injection tracepoint iff valid")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc

on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


2022-10-08 04:47:21 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 1
  1: vmlinux symtab matches kallsyms                                 : Ok
2022-10-08 04:47:23 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 2
  2: Detect openat syscall event                                     : Ok
2022-10-08 04:47:23 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 3
  3: Detect openat syscall event on all cpus                         : Ok
2022-10-08 04:47:23 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 4
  4: Read samples using the mmap interface                           : Ok
2022-10-08 04:47:24 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 5
  5: Test data source output                                         : Ok
2022-10-08 04:47:24 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 6
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : FAILED!
  6.2: Test parsing of "hybrid" CPU events                           : Skip (not hybrid)
  6.3: Parsing of all PMU events from sysfs                          : Ok
  6.4: Parsing of given PMU events from sysfs                        : Ok
  6.5: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
  6.6: Parsing of aliased events                                     : Ok
  6.7: Parsing of terms (event modifiers)                            : Ok
2022-10-08 04:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 7
  7: Simple expression parser                                        : Ok
2022-10-08 04:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 8
  8: PERF_RECORD_* events & perf_sample fields                       : Ok
2022-10-08 04:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 9
  9: Parse perf pmu format                                           : Ok
2022-10-08 04:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 10
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
2022-10-08 04:47:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 11
 11: DSO data read                                                   : Ok
2022-10-08 04:47:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 12
 12: DSO data cache                                                  : Ok
2022-10-08 04:47:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 13
 13: DSO data reopen                                                 : Ok
2022-10-08 04:47:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 14
 14: Roundtrip evsel->name                                           : Ok
2022-10-08 04:47:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 15
 15: Parse sched tracepoints fields                                  : Ok
2022-10-08 04:47:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 16
 16: syscalls:sys_enter_openat event fields                          : Ok
2022-10-08 04:47:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 17
 17: Setup struct perf_event_attr                                    : Ok
2022-10-08 04:48:12 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 18
 18: Match and link multiple hists                                   : Ok
2022-10-08 04:48:12 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 19
 19: 'import perf' in python                                         : FAILED!
2022-10-08 04:48:12 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 20
 20: Breakpoint overflow signal handler                              : Ok
2022-10-08 04:48:12 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 21
 21: Breakpoint overflow sampling                                    : Ok
2022-10-08 04:48:12 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 22
 22: Breakpoint accounting                                           : Ok
2022-10-08 04:48:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 23
 23: Watchpoint                                                      :
 23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
 23.2: Write Only Watchpoint                                         : Ok
 23.3: Read / Write Watchpoint                                       : Ok
 23.4: Modify Watchpoint                                             : Ok
2022-10-08 04:48:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 24
 24: Number of exit events of a simple workload                      : Ok
2022-10-08 04:48:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 25
 25: Software clock events period values                             : Ok
2022-10-08 04:48:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 26
 26: Object code reading                                             : Ok
2022-10-08 04:48:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 27
 27: Sample parsing                                                  : Ok
2022-10-08 04:48:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 28
 28: Use a dummy software event to keep tracking                     : Ok
2022-10-08 04:48:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 29
 29: Parse with no sample_id_all bit set                             : Ok
2022-10-08 04:48:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 30
 30: Filter hist entries                                             : Ok
2022-10-08 04:48:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 31
 31: Lookup mmap thread                                              : FAILED!
2022-10-08 04:48:37 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 32
 32: Share thread maps                                               : Ok
2022-10-08 04:48:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 33
 33: Sort output of hist entries                                     : Ok
2022-10-08 04:48:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 34
 34: Cumulate child hist entries                                     : Ok
2022-10-08 04:48:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 35
 35: Track with sched_switch                                         : Ok
2022-10-08 04:48:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 36
 36: Filter fds with revents mask in a fdarray                       : Ok
2022-10-08 04:48:39 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 37
 37: Add fd to a fdarray, making it autogrow                         : Ok
2022-10-08 04:48:39 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 38
 38: kmod_path__parse                                                : Ok
2022-10-08 04:48:39 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 39
 39: Thread map                                                      : Ok
2022-10-08 04:48:39 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 41
 41: Session topology                                                : Ok
2022-10-08 04:48:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 43
 43: Synthesize thread map                                           : Ok
2022-10-08 04:48:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 44
 44: Remove thread map                                               : Ok
2022-10-08 04:48:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 45
 45: Synthesize cpu map                                              : Ok
2022-10-08 04:48:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 46
 46: Synthesize stat config                                          : Ok
2022-10-08 04:48:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 47
 47: Synthesize stat                                                 : Ok
2022-10-08 04:48:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 48
 48: Synthesize stat round                                           : Ok
2022-10-08 04:48:41 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 49
 49: Synthesize attr update                                          : Ok
2022-10-08 04:48:41 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 50
 50: Event times                                                     : Ok
2022-10-08 04:48:41 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 51
 51: Read backward ring buffer                                       : Ok
2022-10-08 04:48:41 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 52
 52: Print cpu map                                                   : Ok
2022-10-08 04:48:41 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 53
 53: Merge cpu map                                                   : Ok
2022-10-08 04:48:41 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 54
 54: Probe SDT events                                                : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 55
 55: is_printable_array                                              : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 56
 56: Print bitmap                                                    : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 57
 57: perf hooks                                                      : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 59
 59: unit_number__scnprintf                                          : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 60
 60: mem2node                                                        : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 61
 61: time utils                                                      : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 62
 62: Test jit_write_elf                                              : Ok
2022-10-08 04:48:43 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 63
 63: Test libpfm4 support                                            :
 63.1: test of individual --pfm-events                               : Skip (not compiled in)
 63.2: test groups of --pfm-events                                   : Skip (not compiled in)
2022-10-08 04:48:43 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 64
 64: Test api io                                                     : Ok
2022-10-08 04:48:43 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 65
 65: maps__merge_in                                                  : Ok
2022-10-08 04:48:43 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 66
 66: Demangle Java                                                   : Ok
2022-10-08 04:48:43 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 67
 67: Demangle OCaml                                                  : Ok
2022-10-08 04:48:43 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 68
 68: Parse and process metrics                                       : Ok
2022-10-08 04:48:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 69
 69: PE file support                                                 : Ok
2022-10-08 04:48:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 70
 70: Event expansion for cgroups                                     : Ok
2022-10-08 04:48:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 71
 71: Convert perf time to TSC                                        :
 71.1: TSC support                                                   : Ok
 71.2: Perf time to TSC                                              : Ok
2022-10-08 04:48:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 72
 72: dlfilter C API                                                  : FAILED!
2022-10-08 04:48:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 73
 73: Sigtrap                                                         : Ok
2022-10-08 04:48:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 74
 74: x86 rdpmc                                                       : Ok
2022-10-08 04:48:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 75
 75: Test dwarf unwind                                               : FAILED!
2022-10-08 04:48:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 76
 76: x86 instruction decoder - new instructions                      : Ok
2022-10-08 04:48:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 77
 77: Intel PT packet decoder                                         : Ok
2022-10-08 04:48:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 78
 78: x86 bp modify                                                   : Ok
2022-10-08 04:48:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 79
 79: x86 Sample parsing                                              : Ok
2022-10-08 04:48:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 80
 80: build id cache operations                                       : FAILED!
2022-10-08 04:48:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 81
 81: daemon operations                                               : Ok
2022-10-08 04:49:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 82
 82: perf pipe recording and injection test                          : Ok
2022-10-08 04:49:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 84
 84: probe libc's inet_pton & backtrace it with ping                 : Ok
2022-10-08 04:49:18 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 86
 86: Zstd perf.data compression/decompression                        : Ok
2022-10-08 04:49:21 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 87
 87: perf record tests                                               : Ok
2022-10-08 04:49:25 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 88
 88: perf record offcpu profiling tests                              : Skip
2022-10-08 04:49:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 89
 89: perf stat CSV output linter                                     : FAILED!
2022-10-08 04:49:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 90
 90: perf stat csv summary test                                      : Ok
2022-10-08 04:49:32 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 91
 91: perf stat metrics (shadow stat) test                            : Ok
2022-10-08 04:49:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 92
 92: perf stat tests                                                 : Ok
2022-10-08 04:49:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 93
 93: perf all metricgroups test                                      : Ok
2022-10-08 04:49:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 94
 94: perf all metrics test                                           : FAILED!
2022-10-08 04:53:18 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 95
 95: perf all PMU test                                               : Ok
2022-10-08 04:56:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 96
 96: perf stat --bpf-counters test                                   : Skip
2022-10-08 04:56:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 97
 97: Check Arm64 callgraphs are complete in fp mode                  : Skip
2022-10-08 04:56:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 98
 98: Check Arm CoreSight trace data recording and synthesized samples: Skip
2022-10-08 04:56:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 99
 99: Check Arm SPE trace data recording and synthesized samples      : Skip
2022-10-08 04:56:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 100
100: Check Arm SPE doesn't hang when there are forks                 : Skip
2022-10-08 04:56:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 101
101: Miscellaneous Intel PT testing                                  : FAILED!


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/r/202210091636.2f13027d-yujie.liu@intel.com


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.


-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--3rmRS0lZBdM/b5cE
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-5.19.0-rc1-00042-g21d4c575eb4a"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.19.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-5) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23890
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23890
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
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
CONFIG_WATCH_QUEUE=y
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
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_DEFAULT_ON=y
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
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
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
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
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
CONFIG_ARCH_NR_GPIO=1024
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
CONFIG_RETPOLINE=y
CONFIG_CC_HAS_SLS=y
# CONFIG_SLS is not set
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
CONFIG_ARCH_RANDOM=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
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
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

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
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_POWERNOW_K8=m
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
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
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
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

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
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
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
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
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

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
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
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
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

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
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
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
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
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_VM_GET_PAGE_PROT=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
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
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
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
CONFIG_NFT_OBJREF=m
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
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
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
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
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
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
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
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
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
CONFIG_NET_EMATCH_IPSET=m
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
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
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

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
# CONFIG_CAN_SJA1000_PLATFORM is not set
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
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
# CONFIG_NET_9P_RDMA is not set
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
CONFIG_PCI_MSI_IRQ_DOMAIN=y
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
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
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
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
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

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
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
# CONFIG_SCSI_DPT_I2O is not set
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
# CONFIG_SCSI_EFCT is not set
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
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

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
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
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
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
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
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
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
# CONFIG_JME is not set
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
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
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
# CONFIG_VXGE is not set
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
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

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
# CONFIG_PCS_XPCS is not set
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
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
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
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
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
CONFIG_SERIAL_JSM=m
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
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
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
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
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
# CONFIG_GPIO_ADP5588 is not set
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
# CONFIG_PDA_POWER is not set
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
CONFIG_SENSORS_ADM1021=m
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
# CONFIG_SENSORS_ASPEED is not set
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
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
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
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
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
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
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
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
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
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
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
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
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
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
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
# CONFIG_MFD_INTEL_M10_BMC is not set
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
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
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
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
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
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
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
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

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

# CONFIG_SOUND is not set

#
# HID support
#
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
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
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
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

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
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
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
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

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
# CONFIG_USB_ATM is not set

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
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
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
# CONFIG_MMC_REALTEK_PCI is not set
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
CONFIG_LEDS_CLEVO_MAIL=m
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
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
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
CONFIG_EDAC_I5000=m
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
CONFIG_RTC_DRV_V3020=m

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
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
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
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
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
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
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
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
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
# CONFIG_INTEL_ISHTP_ECLITE is not set
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
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
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
CONFIG_HWSPINLOCK=y

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
CONFIG_IRQ_REMAP=y
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
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

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
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
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
# CONFIG_IDLE_INJECT is not set
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
# CONFIG_ANDROID is not set
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
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
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
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
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
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
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
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_ZONEFS_FS is not set
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
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
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
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
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
CONFIG_MINIX_FS=m
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
CONFIG_NFSD_V2_ACL=y
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
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
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
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
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
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
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
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
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
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
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
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

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
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

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
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
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
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
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
CONFIG_DIMLIB=y
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
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_STACK_HASH_ORDER=20
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
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
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
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
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
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
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
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
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
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
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
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
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
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
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
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
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
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
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
# end of Kernel Testing and Coverage
# end of Kernel hacking

--3rmRS0lZBdM/b5cE
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='perf-sanity-tests'
	export testcase='perf-sanity-tests'
	export category='functional'
	export need_memory='2G'
	export job_origin='perf-sanity-tests.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis
bm_initrd_keep'
	export queue='validate'
	export testbox='lkp-skl-d05'
	export tbox_group='lkp-skl-d05'
	export submit_id='6340fa592fbbe03309c349c3'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d05/perf-sanity-tests-gcc-debian-11.1-x86_64-20220510.cgz-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba-20221008-78601-193z3p7-1.yaml'
	export id='ec1c400842e7694a01f4ce2d5ee77f012f0df139'
	export queuer_version='/zday/lkp'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c50091e544de-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export initrds='linux_perf'
	export commit='21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export ucode='0xf0'
	export bisect_dmesg=true
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2022-10-08 12:19:38 +0800'
	export _id='6340fa592fbbe03309c349c3'
	export _rt='/result/perf-sanity-tests/gcc/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='c5b4c66ff832dae9958ab2676a040584ea47fa61'
	export base_commit='4fe89d07dcc2804c8b562f6c7896a45643d34b2f'
	export branch='linus/master'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/perf-sanity-tests/gcc/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/1'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/perf-sanity-tests/gcc/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/1
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/vmlinuz-5.19.0-rc1-00042-g21d4c575eb4a
branch=linus/master
job=/lkp/jobs/scheduled/lkp-skl-d05/perf-sanity-tests-gcc-debian-11.1-x86_64-20220510.cgz-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba-20221008-78601-193z3p7-1.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/modules.cgz'
	export linux_perf_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/linux-perf.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20221001.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-b357fd1c2afc-1_20221001.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.17.0'
	export repeat_to=6
	export schedule_notify_address=
	export stop_repeat_if_found='perf-sanity-tests.Test_event_parsing.fail'
	export kbuild_queue_analysis=1
	export bm_initrd_keep=true
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/vmlinuz-5.19.0-rc1-00042-g21d4c575eb4a'
	export dequeue_time='2022-10-08 12:43:14 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d05/perf-sanity-tests-gcc-debian-11.1-x86_64-20220510.cgz-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba-20221008-78601-193z3p7-1.cgz'

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
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test perf_compiler='gcc' $LKP_SRC/tests/wrapper perf-sanity-tests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env perf_compiler='gcc' $LKP_SRC/stats/wrapper perf-sanity-tests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time perf-sanity-tests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--3rmRS0lZBdM/b5cE
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AAAAAARZWg==

--3rmRS0lZBdM/b5cE
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="perf-sanity-tests"
Content-Transfer-Encoding: quoted-printable

2022-10-08 04:45:21 make ARCH=3D EXTRA_CFLAGS=3D-fno-omit-frame-pointer -fs=
anitize=3Dundefined -fsanitize=3Daddress -Wno-array-bounds -C /usr/src/perf=
_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/to=
ols/perf
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4=
c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf'
  BUILD:   Doing 'make =1B[33m-j4=1B[m' parallel build
  HOSTCC  fixdep.o
  HOSTLD  fixdep-in.o
  LINK    fixdep
diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
diff -u tools/include/uapi/linux/prctl.h include/uapi/linux/prctl.h
diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm=
/disabled-features.h
diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufe=
atures.h
diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm=
.h
diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm=
.h
diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket=
.h

Auto-detecting system features:
...                         dwarf: [ =1B[32mon=1B[m  ]
...            dwarf_getlocations: [ =1B[32mon=1B[m  ]
...                         glibc: [ =1B[32mon=1B[m  ]
...                        libbfd: [ =1B[32mon=1B[m  ]
...                libbfd-buildid: [ =1B[32mon=1B[m  ]
...                        libcap: [ =1B[32mon=1B[m  ]
...                        libelf: [ =1B[32mon=1B[m  ]
...                       libnuma: [ =1B[32mon=1B[m  ]
...        numa_num_possible_cpus: [ =1B[32mon=1B[m  ]
...                       libperl: [ =1B[32mon=1B[m  ]
...                     libpython: [ =1B[32mon=1B[m  ]
...                     libcrypto: [ =1B[32mon=1B[m  ]
...                     libunwind: [ =1B[32mon=1B[m  ]
...            libdw-dwarf-unwind: [ =1B[32mon=1B[m  ]
...                          zlib: [ =1B[32mon=1B[m  ]
...                          lzma: [ =1B[32mon=1B[m  ]
...                     get_cpuid: [ =1B[32mon=1B[m  ]
...                           bpf: [ =1B[32mon=1B[m  ]
...                        libaio: [ =1B[32mon=1B[m  ]
...                       libzstd: [ =1B[32mon=1B[m  ]
...        disassembler-four-args: [ =1B[32mon=1B[m  ]

...                      /tmp/lkp: [ =1B[31mOFF=1B[m ]

  CC      exec-cmd.o
  CC      fd/array.o
  CC      event-parse.o
  CC      core.o
  CC      cpumap.o
  LD      fd/libapi-in.o
  CC      fs/fs.o
  CC      help.o
  CC      fs/tracing_path.o
  CC      fs/cgroup.o
  LD      fs/libapi-in.o
  CC      cpu.o
  CC      debug.o
  CC      str_error_r.o
  CC      pager.o
  LD      libapi-in.o
  AR      libapi.a
  CC      threadmap.o
  CC      parse-options.o
  CC      evsel.o
  CC      evlist.o
  CC      event-plugin.o
  CC      trace-seq.o
  CC      parse-filter.o
  CC      mmap.o
  CC      parse-utils.o
  CC      kbuffer-parse.o
  CC      zalloc.o
  CC      xyarray.o
  CC      tep_strerror.o
  CC      lib.o
  CC      run-command.o
  CC      event-parse-api.o
  CC      sigchain.o
  LD      libperf-in.o
  LD      libtraceevent-in.o
  AR      libperf.a
  GEN     common-cmds.h
  LINK    libtraceevent.a
  CC      subcmd-config.o
  LD      libsubcmd-in.o
  AR      libsubcmd.a
  HOSTCC  pmu-events/json.o
  CC      jvmti/libjvmti.o
  CC      plugin_jbd2.o
  HOSTCC  pmu-events/jsmn.o
  LD      plugin_jbd2-in.o
  CC      plugin_hrtimer.o
  HOSTCC  pmu-events/jevents.o
  LD      plugin_hrtimer-in.o
  CC      plugin_kmem.o
  LD      plugin_kmem-in.o
  HOSTLD  pmu-events/jevents-in.o
  CC      plugin_kvm.o
  GEN     perf-archive
  GEN     perf-iostat
  CC      dlfilters/dlfilter-test-api-v0.o
  CC      plugin_mac80211.o
  LD      plugin_kvm-in.o
  CC      dlfilters/dlfilter-show-cycles.o
  CC      plugin_sched_switch.o
  LD      plugin_mac80211-in.o
  CC      plugin_function.o
  LD      plugin_sched_switch-in.o
  CC      plugin_futex.o
  CC      jvmti/jvmti_agent.o
  GEN     /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/bpf_helper_defs.h
  LD      plugin_function-in.o
  LD      plugin_futex-in.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/bpf.h
  CC      plugin_xen.o
  CC      plugin_scsi.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/libbpf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/btf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/libbpf_common.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/libbpf_legacy.h
  LD      plugin_xen-in.o
  CC      plugin_cfg80211.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/xsk.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/bpf_helpers.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/bpf_tracing.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/bpf_endian.h
  LD      plugin_scsi-in.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/bpf_core_read.h
  CC      plugin_tlb.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/skel_internal.h
  LD      plugin_cfg80211-in.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/libbpf_version.h
  LINK    plugin_jbd2.so
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/usdt.bpf.h
  LINK    plugin_hrtimer.so
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/include/bpf/bpf_helper_defs.h
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/libbpf.o
  LINK    plugin_kmem.so
  LINK    plugin_kvm.so
  LD      plugin_tlb-in.o
  LINK    plugin_mac80211.so
  LINK    plugin_sched_switch.so
  LINK    plugin_function.so
  LINK    plugin_futex.so
  LINK    plugin_xen.so
  LINK    plugin_scsi.so
  LINK    plugin_cfg80211.so
  LINK    plugin_tlb.so
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/bpf.o
  GEN     libtraceevent-dynamic-list
  CC      builtin-bench.o
  CC      jvmti/libstring.o
  CC      jvmti/libctype.o
  CC      builtin-annotate.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/nlattr.o
  LD      jvmti/jvmti-in.o
  LINK    pmu-events/jevents
  LINK    libperf-jvmti.so
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/btf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/libbpf_errno.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/str_error.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/netlink.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/libbpf_probes.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/xsk.o
  CC      builtin-config.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/hashmap.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/btf_dump.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/ringbuf.o
  CC      builtin-diff.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/strset.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/linker.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/gen_loader.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/relo_core.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/usdt.o
  CC      builtin-evlist.o
  CC      builtin-ftrace.o
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/staticobjs/libbpf-in.o
  CC      builtin-help.o
  LINK    /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b=
61b5e9c162895fa7d4ba/tools/perf/libbpf/libbpf.a
  LINK    dlfilters/dlfilter-test-api-v0.so
  LINK    dlfilters/dlfilter-show-cycles.so
  GEN     python/perf.so
  CC      builtin-sched.o
  CC      builtin-buildid-list.o
  CC      builtin-buildid-cache.o
  CC      builtin-kallsyms.o
  CC      builtin-list.o
  CC      builtin-record.o
  CC      builtin-report.o
  CC      builtin-stat.o
  CC      builtin-timechart.o
  CC      builtin-top.o
  CC      builtin-script.o
  CC      builtin-kmem.o
  CC      builtin-lock.o
  CC      builtin-kvm.o
  CC      builtin-inject.o
  CC      builtin-mem.o
  CC      builtin-data.o
  CC      builtin-version.o
  CC      builtin-c2c.o
  CC      builtin-daemon.o
  CC      builtin-trace.o
  CC      builtin-probe.o
  CC      bench/sched-messaging.o
  CC      bench/sched-pipe.o
  CC      bench/syscall.o
  CC      bench/mem-functions.o
  GEN     pmu-events/pmu-events.c
  CC      pmu-events/pmu-events.o
  CC      bench/futex-hash.o
  CC      bench/futex-wake.o
  CC      tests/builtin-test.o
  CC      bench/futex-wake-parallel.o
  CC      bench/futex-requeue.o
  CC      bench/futex-lock-pi.o
  LD      pmu-events/pmu-events-in.o
  CC      tests/parse-events.o
  CC      tests/dso-data.o
  CC      bench/epoll-wait.o
  CC      tests/attr.o
  CC      bench/epoll-ctl.o
  CC      tests/vmlinux-kallsyms.o
  CC      bench/synthesize.o
  CC      tests/openat-syscall.o
  CC      tests/openat-syscall-all-cpus.o
  CC      bench/kallsyms-parse.o
  CC      bench/find-bit-bench.o
  CC      tests/openat-syscall-tp-fields.o
  CC      bench/inject-buildid.o
  CC      tests/mmap-basic.o
  CC      tests/perf-record.o
  CC      bench/evlist-open-close.o
  CC      bench/breakpoint.o
  CC      tests/evsel-roundtrip-name.o
  CC      bench/mem-memcpy-x86-64-asm.o
  CC      bench/mem-memset-x86-64-asm.o
  CC      bench/numa.o
  CC      tests/evsel-tp-sched.o
  CC      tests/fdarray.o
  CC      tests/pmu.o
  CC      tests/pmu-events.o
  CC      tests/hists_common.o
  CC      tests/hists_link.o
  CC      util/arm64-frame-pointer-unwind-support.o
  CC      util/annotate.o
  CC      tests/hists_filter.o
  CC      tests/hists_output.o
  CC      tests/hists_cumulate.o
  LD      bench/perf-in.o
  CC      arch/common.o
  CC      tests/python-use.o
  CC      arch/x86/util/header.o
  CC      tests/bp_signal.o
  CC      tests/bp_signal_overflow.o
  CC      arch/x86/util/tsc.o
  CC      tests/bp_account.o
  CC      arch/x86/util/pmu.o
  CC      tests/wp.o
  CC      arch/x86/tests/regs_load.o
  CC      arch/x86/tests/dwarf-unwind.o
  CC      arch/x86/util/kvm-stat.o
  CC      tests/task-exit.o
  CC      arch/x86/tests/arch-tests.o
  CC      arch/x86/tests/rdpmc.o
  CC      arch/x86/util/perf_regs.o
  CC      tests/sw-clock.o
  CC      arch/x86/util/topdown.o
  CC      arch/x86/tests/sample-parsing.o
  CC      tests/mmap-thread-lookup.o
  CC      arch/x86/util/machine.o
  CC      arch/x86/tests/insn-x86.o
  CC      arch/x86/util/event.o
  CC      tests/thread-maps-share.o
  CC      arch/x86/util/evlist.o
  CC      arch/x86/tests/intel-pt-pkt-decoder-test.o
  CC      arch/x86/util/mem-events.o
  CC      tests/switch-tracking.o
  CC      arch/x86/util/evsel.o
  CC      arch/x86/tests/bp-modify.o
  CC      arch/x86/util/iostat.o
  LD      arch/x86/tests/perf-in.o
  CC      arch/x86/util/dwarf-regs.o
  CC      arch/x86/util/unwind-libunwind.o
  CC      arch/x86/util/auxtrace.o
  CC      arch/x86/util/archinsn.o
  CC      tests/keep-tracking.o
  CC      arch/x86/util/intel-pt.o
  CC      arch/x86/util/intel-bts.o
  CC      tests/code-reading.o
  CC      util/block-info.o
  CC      util/block-range.o
  CC      util/build-id.o
  CC      tests/sample-parsing.o
  LD      arch/x86/util/perf-in.o
  LD      arch/x86/perf-in.o
  LD      arch/perf-in.o
  CC      ui/setup.o
  CC      ui/helpline.o
  CC      util/cacheline.o
  CC      ui/progress.o
  CC      util/config.o
  CC      tests/parse-no-sample-id-all.o
  CC      ui/util.o
  CC      util/copyfile.o
  CC      ui/hist.o
  CC      tests/kmod-path.o
  CC      util/ctype.o
  CC      util/db-export.o
  CC      tests/thread-map.o
  CC      util/env.o
  CC      tests/llvm.o
  CC      util/event.o
  CC      tests/bpf.o
  CC      util/evlist.o
  CC      tests/topology.o
  CC      tests/mem.o
  CC      tests/cpumap.o
  CC      util/evlist-hybrid.o
  CC      tests/stat.o
  CC      util/sideband_evlist.o
  CC      tests/event_update.o
  CC      util/evsel.o
  CC      tests/event-times.o
  CC      tests/expr.o
  CC      tests/backward-ring-buffer.o
  CC      util/evsel_fprintf.o
  CC      tests/sdt.o
  CC      tests/is_printable_array.o
  CC      tests/bitmap.o
  CC      util/perf_event_attr_fprintf.o
  CC      tests/perf-hooks.o
  CC      tests/clang.o
  CC      tests/unit_number__scnprintf.o
  CC      tests/mem2node.o
  CC      tests/maps.o
  CC      util/evswitch.o
  CC      tests/time-utils-test.o
  CC      util/find_bit.o
  CC      util/get_current_dir_name.o
  CC      util/kallsyms.o
  CC      tests/genelf.o
  CC      util/levenshtein.o
  CC      tests/api-io.o
  CC      util/llvm-utils.o
  CC      tests/demangle-java-test.o
  CC      util/mmap.o
  CC      tests/demangle-ocaml-test.o
  CC      ui/stdio/hist.o
  CC      tests/pfm.o
  CC      tests/parse-metric.o
  CC      util/memswap.o
  BISON   util/parse-events-bison.c
  CC      util/parse-events-hybrid.o
  CC      tests/pe-file-parsing.o
  CC      util/perf_regs.o
  CC      ui/browser.o
  CC      tests/expand-cgroup.o
  CC      util/path.o
  CC      util/print_binary.o
  CC      tests/perf-time-to-tsc.o
  CC      util/rlimit.o
  CC      ui/browsers/annotate.o
  CC      util/argv_split.o
  CC      util/rbtree.o
  CC      tests/dlfilter-test.o
  CC      ui/browsers/hists.o
  CC      tests/sigtrap.o
  CC      tests/dwarf-unwind.o
  CC      tests/llvm-src-base.o
  CC      tests/llvm-src-kbuild.o
  CC      tests/llvm-src-prologue.o
  CC      tests/llvm-src-relocation.o
  CC      util/libstring.o
  LD      tests/perf-in.o
  CC      scripts/perl/Perf-Trace-Util/Context.o
  CC      util/bitmap.o
  CC      util/hweight.o
  CC      ui/browsers/map.o
  CC      util/smt.o
  CC      util/strbuf.o
  CC      ui/browsers/scripts.o
  LD      scripts/perl/Perf-Trace-Util/perf-in.o
  CC      scripts/python/Perf-Trace-Util/Context.o
  CC      util/string.o
  CC      ui/browsers/header.o
  CC      ui/browsers/res_sample.o
  CC      util/strlist.o
  LD      scripts/python/Perf-Trace-Util/perf-in.o
  LD      scripts/perf-in.o
  CC      trace/beauty/clone.o
  CC      trace/beauty/fcntl.o
  CC      util/strfilter.o
  CC      trace/beauty/flock.o
  CC      trace/beauty/fsmount.o
  CC      trace/beauty/fspick.o
  CC      trace/beauty/ioctl.o
  CC      trace/beauty/kcmp.o
  CC      trace/beauty/mount_flags.o
  CC      trace/beauty/move_mount.o
  CC      trace/beauty/pkey_alloc.o
  CC      ui/tui/setup.o
  CC      trace/beauty/arch_prctl.o
  CC      ui/tui/util.o
  CC      trace/beauty/prctl.o
  CC      trace/beauty/renameat.o
  CC      trace/beauty/sockaddr.o
  CC      util/top.o
  CC      ui/tui/helpline.o
  CC      trace/beauty/socket.o
  CC      ui/tui/progress.o
  CC      trace/beauty/statx.o
  LD      ui/tui/perf-in.o
  CC      util/usage.o
  CC      trace/beauty/sync_file_range.o
  CC      trace/beauty/tracepoints/x86_irq_vectors.o
  CC      util/dso.o
  CC      util/dsos.o
  CC      trace/beauty/tracepoints/x86_msr.o
  LD      trace/beauty/tracepoints/perf-in.o
  LD      trace/beauty/perf-in.o
  CC      perf.o
  CC      util/symbol.o
  CC      util/symbol_fprintf.o
  CC      util/color.o
  CC      util/color_config.o
  LD      ui/browsers/perf-in.o
  LD      ui/perf-in.o
  CC      util/metricgroup.o
  CC      util/header.o
  CC      util/callchain.o
  CC      util/values.o
  CC      util/debug.o
  CC      util/fncache.o
  CC      util/machine.o
  CC      util/map.o
  CC      util/maps.o
  CC      util/pstack.o
  CC      util/session.o
  CC      util/sample-raw.o
  CC      util/s390-sample-raw.o
  CC      util/amd-sample-raw.o
  CC      util/syscalltbl.o
  CC      util/ordered-events.o
  CC      util/namespaces.o
  CC      util/comm.o
  CC      util/thread.o
  CC      util/thread_map.o
  CC      util/trace-event-parse.o
  CC      util/parse-events-bison.o
  BISON   util/pmu-bison.c
  CC      util/pmu-hybrid.o
  CC      util/trace-event-read.o
  CC      util/trace-event-info.o
  CC      util/trace-event-scripting.o
  CC      util/trace-event.o
  CC      util/svghelper.o
  CC      util/sort.o
  CC      util/hist.o
  CC      util/util.o
  CC      util/cpumap.o
  CC      util/affinity.o
  CC      util/cputopo.o
  CC      util/cgroup.o
  CC      util/target.o
  CC      util/rblist.o
  CC      util/intlist.o
  CC      util/vdso.o
  CC      util/counts.o
  CC      util/stat.o
  CC      util/stat-shadow.o
  CC      util/stat-display.o
  CC      util/perf_api_probe.o
  CC      util/record.o
  CC      util/srcline.o
  CC      util/srccode.o
  CC      util/synthetic-events.o
  CC      util/data.o
  CC      util/tsc.o
  CC      util/cloexec.o
  CC      util/call-path.o
  CC      util/rwsem.o
  CC      util/thread-stack.o
  CC      util/spark.o
  CC      util/topdown.o
  CC      util/iostat.o
  CC      util/stream.o
  CC      util/auxtrace.o
  CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
  CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
  GEN     util/intel-pt-decoder/inat-tables.c
  CC      util/intel-pt-decoder/intel-pt-log.o
  CC      util/intel-pt-decoder/intel-pt-decoder.o
  CC      util/scripting-engines/trace-event-perl.o
  CC      util/arm-spe-decoder/arm-spe-decoder.o
  LD      util/arm-spe-decoder/perf-in.o
  CC      util/intel-pt.o
  CC      util/scripting-engines/trace-event-python.o
  CC      util/intel-bts.o
  CC      util/arm-spe.o
  LD      util/scripting-engines/perf-in.o
  CC      util/s390-cpumsf.o
  CC      util/parse-branch-options.o
  CC      util/dump-insn.o
  CC      util/parse-regs-options.o
  CC      util/parse-sublevel-options.o
  CC      util/term.o
  CC      util/help-unknown-cmd.o
  CC      util/dlfilter.o
  CC      util/mem-events.o
  CC      util/vsprintf.o
  CC      util/units.o
  CC      util/time-utils.o
  BISON   util/expr-bison.c
  CC      util/branch.o
  CC      util/mem2node.o
  CC      util/clockid.o
  CC      util/list_sort.o
  CC      util/bpf-loader.o
  CC      util/bpf_map.o
  CC      util/bpf-prologue.o
  CC      util/symbol-elf.o
  CC      util/probe-file.o
  CC      util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC      util/probe-event.o
  CC      util/probe-finder.o
  CC      util/dwarf-aux.o
  LD      util/intel-pt-decoder/perf-in.o
  CC      util/dwarf-regs.o
  CC      util/unwind-libunwind-local.o
  CC      util/unwind-libunwind.o
  CC      util/data-convert-bt.o
  CC      util/data-convert-json.o
  CC      util/zlib.o
  CC      util/lzma.o
  CC      util/zstd.o
  CC      util/cap.o
  CC      util/demangle-ocaml.o
  CC      util/demangle-java.o
  CC      util/demangle-rust.o
  CC      util/jitdump.o
  CC      util/genelf.o
  CC      util/genelf_debug.o
  CC      util/perf-hooks.o
  CC      util/bpf-event.o
  CC      util/bpf-utils.o
  FLEX    util/parse-events-flex.c
  FLEX    util/pmu-flex.c
  CC      util/pmu-bison.o
  FLEX    util/expr-flex.c
  CC      util/expr-bison.o
  CC      util/expr.o
  CC      util/parse-events.o
  CC      util/parse-events-flex.o
  CC      util/pmu.o
  CC      util/pmu-flex.o
  CC      util/expr-flex.o
  LD      util/perf-in.o
  LD      perf-in.o
  LINK    perf
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf'
2022-10-08 04:47:17 cd /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c57=
5eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf
2022-10-08 04:47:17 mkdir -p /pkg
2022-10-08 04:47:17 mkdir -p /kbuild/obj/consumer/x86_64-rhel-8.3-func
2022-10-08 04:47:17 cp /pkg/linux/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1=
e6d956b61b5e9c162895fa7d4ba/vmlinux.xz /tmp
2022-10-08 04:47:18 unxz -k /tmp/vmlinux.xz
2022-10-08 04:47:21 cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-8.3-fu=
nc
ignored_by_lkp: BPF filter
ignored_by_lkp: LLVM search and compile
ignored_by_lkp: Add vfs_getname probe to get syscall args filenames
ignored_by_lkp: Use vfs_getname probe to get syscall args filenames
ignored_by_lkp: Check open filename arg using perf trace + vfs_getname
ignored_by_lkp: builtin clang support
2022-10-08 04:47:21 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 1
  1: vmlinux symtab matches kallsyms                                 : Ok
2022-10-08 04:47:23 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 2
  2: Detect openat syscall event                                     : Ok
2022-10-08 04:47:23 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 3
  3: Detect openat syscall event on all cpus                         : Ok
2022-10-08 04:47:23 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 4
  4: Read samples using the mmap interface                           : Ok
2022-10-08 04:47:24 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 5
  5: Test data source output                                         : Ok
2022-10-08 04:47:24 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 6
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : FAIL=
ED!
  6.2: Test parsing of "hybrid" CPU events                           : Skip=
 (not hybrid)
  6.3: Parsing of all PMU events from sysfs                          : Ok
  6.4: Parsing of given PMU events from sysfs                        : Ok
  6.5: Parsing of aliased events from sysfs                          : Skip=
 (no aliases in sysfs)
  6.6: Parsing of aliased events                                     : Ok
  6.7: Parsing of terms (event modifiers)                            : Ok
2022-10-08 04:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 7
  7: Simple expression parser                                        : Ok
2022-10-08 04:47:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 8
  8: PERF_RECORD_* events & perf_sample fields                       : Ok
2022-10-08 04:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 9
  9: Parse perf pmu format                                           : Ok
2022-10-08 04:47:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 10
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
2022-10-08 04:47:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 11
 11: DSO data read                                                   : Ok
2022-10-08 04:47:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 12
 12: DSO data cache                                                  : Ok
2022-10-08 04:47:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 13
 13: DSO data reopen                                                 : Ok
2022-10-08 04:47:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 14
 14: Roundtrip evsel->name                                           : Ok
2022-10-08 04:47:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 15
 15: Parse sched tracepoints fields                                  : Ok
2022-10-08 04:47:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 16
 16: syscalls:sys_enter_openat event fields                          : Ok
2022-10-08 04:47:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 17
 17: Setup struct perf_event_attr                                    : Ok
2022-10-08 04:48:12 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 18
 18: Match and link multiple hists                                   : Ok
2022-10-08 04:48:12 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 19
 19: 'import perf' in python                                         : FAIL=
ED!
2022-10-08 04:48:12 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 20
 20: Breakpoint overflow signal handler                              : Ok
2022-10-08 04:48:12 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 21
 21: Breakpoint overflow sampling                                    : Ok
2022-10-08 04:48:12 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 22
 22: Breakpoint accounting                                           : Ok
2022-10-08 04:48:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 23
 23: Watchpoint                                                      :
 23.1: Read Only Watchpoint                                          : Skip=
 (missing hardware support)
 23.2: Write Only Watchpoint                                         : Ok
 23.3: Read / Write Watchpoint                                       : Ok
 23.4: Modify Watchpoint                                             : Ok
2022-10-08 04:48:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 24
 24: Number of exit events of a simple workload                      : Ok
2022-10-08 04:48:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 25
 25: Software clock events period values                             : Ok
2022-10-08 04:48:13 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 26
 26: Object code reading                                             : Ok
2022-10-08 04:48:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 27
 27: Sample parsing                                                  : Ok
2022-10-08 04:48:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 28
 28: Use a dummy software event to keep tracking                     : Ok
2022-10-08 04:48:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 29
 29: Parse with no sample_id_all bit set                             : Ok
2022-10-08 04:48:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 30
 30: Filter hist entries                                             : Ok
2022-10-08 04:48:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 31
 31: Lookup mmap thread                                              : FAIL=
ED!
2022-10-08 04:48:37 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 32
 32: Share thread maps                                               : Ok
2022-10-08 04:48:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 33
 33: Sort output of hist entries                                     : Ok
2022-10-08 04:48:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 34
 34: Cumulate child hist entries                                     : Ok
2022-10-08 04:48:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 35
 35: Track with sched_switch                                         : Ok
2022-10-08 04:48:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 36
 36: Filter fds with revents mask in a fdarray                       : Ok
2022-10-08 04:48:39 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 37
 37: Add fd to a fdarray, making it autogrow                         : Ok
2022-10-08 04:48:39 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 38
 38: kmod_path__parse                                                : Ok
2022-10-08 04:48:39 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 39
 39: Thread map                                                      : Ok
2022-10-08 04:48:39 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 41
 41: Session topology                                                : Ok
2022-10-08 04:48:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 43
 43: Synthesize thread map                                           : Ok
2022-10-08 04:48:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 44
 44: Remove thread map                                               : Ok
2022-10-08 04:48:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 45
 45: Synthesize cpu map                                              : Ok
2022-10-08 04:48:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 46
 46: Synthesize stat config                                          : Ok
2022-10-08 04:48:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 47
 47: Synthesize stat                                                 : Ok
2022-10-08 04:48:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 48
 48: Synthesize stat round                                           : Ok
2022-10-08 04:48:41 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 49
 49: Synthesize attr update                                          : Ok
2022-10-08 04:48:41 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 50
 50: Event times                                                     : Ok
2022-10-08 04:48:41 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 51
 51: Read backward ring buffer                                       : Ok
2022-10-08 04:48:41 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 52
 52: Print cpu map                                                   : Ok
2022-10-08 04:48:41 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 53
 53: Merge cpu map                                                   : Ok
2022-10-08 04:48:41 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 54
 54: Probe SDT events                                                : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 55
 55: is_printable_array                                              : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 56
 56: Print bitmap                                                    : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 57
 57: perf hooks                                                      : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 59
 59: unit_number__scnprintf                                          : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 60
 60: mem2node                                                        : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 61
 61: time utils                                                      : Ok
2022-10-08 04:48:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 62
 62: Test jit_write_elf                                              : Ok
2022-10-08 04:48:43 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 63
 63: Test libpfm4 support                                            :
 63.1: test of individual --pfm-events                               : Skip=
 (not compiled in)
 63.2: test groups of --pfm-events                                   : Skip=
 (not compiled in)
2022-10-08 04:48:43 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 64
 64: Test api io                                                     : Ok
2022-10-08 04:48:43 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 65
 65: maps__merge_in                                                  : Ok
2022-10-08 04:48:43 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 66
 66: Demangle Java                                                   : Ok
2022-10-08 04:48:43 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 67
 67: Demangle OCaml                                                  : Ok
2022-10-08 04:48:43 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 68
 68: Parse and process metrics                                       : Ok
2022-10-08 04:48:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 69
 69: PE file support                                                 : Ok
2022-10-08 04:48:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 70
 70: Event expansion for cgroups                                     : Ok
2022-10-08 04:48:44 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 71
 71: Convert perf time to TSC                                        :
 71.1: TSC support                                                   : Ok
 71.2: Perf time to TSC                                              : Ok
2022-10-08 04:48:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 72
 72: dlfilter C API                                                  : FAIL=
ED!
2022-10-08 04:48:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 73
 73: Sigtrap                                                         : Ok
2022-10-08 04:48:45 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 74
 74: x86 rdpmc                                                       : Ok
2022-10-08 04:48:46 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 75
 75: Test dwarf unwind                                               : FAIL=
ED!
2022-10-08 04:48:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 76
 76: x86 instruction decoder - new instructions                      : Ok
2022-10-08 04:48:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 77
 77: Intel PT packet decoder                                         : Ok
2022-10-08 04:48:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 78
 78: x86 bp modify                                                   : Ok
2022-10-08 04:48:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 79
 79: x86 Sample parsing                                              : Ok
2022-10-08 04:48:47 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 80
 80: build id cache operations                                       : FAIL=
ED!
2022-10-08 04:48:48 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 81
 81: daemon operations                                               : Ok
2022-10-08 04:49:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 82
 82: perf pipe recording and injection test                          : Ok
2022-10-08 04:49:16 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 84
 84: probe libc's inet_pton & backtrace it with ping                 : Ok
2022-10-08 04:49:18 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 86
 86: Zstd perf.data compression/decompression                        : Ok
2022-10-08 04:49:21 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 87
 87: perf record tests                                               : Ok
2022-10-08 04:49:25 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 88
 88: perf record offcpu profiling tests                              : Skip
2022-10-08 04:49:27 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 89
 89: perf stat CSV output linter                                     : FAIL=
ED!
2022-10-08 04:49:29 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 90
 90: perf stat csv summary test                                      : Ok
2022-10-08 04:49:32 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 91
 91: perf stat metrics (shadow stat) test                            : Ok
2022-10-08 04:49:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 92
 92: perf stat tests                                                 : Ok
2022-10-08 04:49:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 93
 93: perf all metricgroups test                                      : Ok
2022-10-08 04:49:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 94
 94: perf all metrics test                                           : FAIL=
ED!
2022-10-08 04:53:18 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 95
 95: perf all PMU test                                               : Ok
2022-10-08 04:56:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 96
 96: perf stat --bpf-counters test                                   : Skip
2022-10-08 04:56:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 97
 97: Check Arm64 callgraphs are complete in fp mode                  : Skip
2022-10-08 04:56:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 98
 98: Check Arm CoreSight trace data recording and synthesized samples: Skip
2022-10-08 04:56:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 99
 99: Check Arm SPE trace data recording and synthesized samples      : Skip
2022-10-08 04:56:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 100
100: Check Arm SPE doesn't hang when there are forks                 : Skip
2022-10-08 04:56:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c=
575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 101
101: Miscellaneous Intel PT testing                                  : FAIL=
ED!

--3rmRS0lZBdM/b5cE
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/perf-sanity-tests.yaml
suite: perf-sanity-tests
testcase: perf-sanity-tests
category: functional
need_memory: 2G
perf-sanity-tests:
  perf_compiler: gcc
job_origin: perf-sanity-tests.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d05
tbox_group: lkp-skl-d05
submit_id: 6340c6582fbbe02b8830e222
job_file: "/lkp/jobs/scheduled/lkp-skl-d05/perf-sanity-tests-gcc-debian-11.1-x86_64-20220510.cgz-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba-20221008-76680-1szrf3w-0.yaml"
id: 545694245afea63332f7618350131ca5d09b302b
queuer_version: "/zday/lkp"

#! hosts/lkp-skl-d05
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c50091e544de-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

#! include/category/functional
kmsg:
heartbeat:
meminfo:

#! include/perf-sanity-tests
initrds:
- linux_perf

#! include/queue/cyclic
commit: 21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba

#! include/testbox/lkp-skl-d05
need_kconfig_hw:
- PTP_1588_CLOCK: y
- E1000E: y
- SATA_AHCI
- DRM_I915
ucode: '0xf0'
bisect_dmesg: true
kconfig: x86_64-rhel-8.3-func
enqueue_time: 2022-10-08 08:37:44.320416533 +08:00
_id: 6340c6582fbbe02b8830e222
_rt: "/result/perf-sanity-tests/gcc/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: c5b4c66ff832dae9958ab2676a040584ea47fa61
base_commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
branch: linux-devel/devel-hourly-20221005-073630
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/perf-sanity-tests/gcc/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/perf-sanity-tests/gcc/lkp-skl-d05/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/vmlinuz-5.19.0-rc1-00042-g21d4c575eb4a
- branch=linux-devel/devel-hourly-20221005-073630
- job=/lkp/jobs/scheduled/lkp-skl-d05/perf-sanity-tests-gcc-debian-11.1-x86_64-20220510.cgz-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba-20221008-76680-1szrf3w-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/modules.cgz"
linux_perf_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/linux-perf.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20221001.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-b357fd1c2afc-1_20221001.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01

#! /db/releases/20221005202439/lkp-src/include/site/lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.0.0-07362-g62e6e5940c0c
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/vmlinuz-5.19.0-rc1-00042-g21d4c575eb4a"
dequeue_time: 2022-10-08 10:17:44.488456256 +08:00

#! /db/releases/20221006170445/lkp-src/include/site/lkp-wsx01
job_state: finished
loadavg: 0.95 1.14 0.86 1/134 16684
start_time: '1665195584'
end_time: '1665196228'
version: "/lkp/lkp/.src-20221001-230556:450b29f71:37fc623e4"

--3rmRS0lZBdM/b5cE
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

make ARCH= EXTRA_CFLAGS=-fno-omit-frame-pointer -fsanitize=undefined -fsanitize=address -Wno-array-bounds -C /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf
cd /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf
mkdir -p /pkg
mkdir -p /kbuild/obj/consumer/x86_64-rhel-8.3-func
cp /pkg/linux/x86_64-rhel-8.3-func/gcc-11/21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/vmlinux.xz /tmp
unxz -k /tmp/vmlinux.xz
cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-8.3-func
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 1
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 2
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 3
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 4
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 5
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 6
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 7
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 8
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 9
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 10
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 11
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 12
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 13
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 14
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 15
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 16
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 17
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 18
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 19
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 20
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 21
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 22
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 23
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 24
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 25
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 26
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 27
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 28
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 29
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 30
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 31
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 32
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 33
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 34
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 35
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 36
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 37
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 38
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 39
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 41
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 43
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 44
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 45
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 46
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 47
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 48
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 49
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 50
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 51
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 52
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 53
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 54
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 55
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 56
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 57
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 59
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 60
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 61
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 62
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 63
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 64
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 65
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 66
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 67
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 68
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 69
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 70
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 71
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 72
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 73
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 74
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 75
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 76
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 77
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 78
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 79
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 80
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 81
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 82
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 84
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 86
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 87
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 88
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 89
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 90
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 91
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 92
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 93
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 94
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 95
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 96
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 97
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 98
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 99
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 100
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-21d4c575eb4a1e6d956b61b5e9c162895fa7d4ba/tools/perf/perf test 101

--3rmRS0lZBdM/b5cE--
