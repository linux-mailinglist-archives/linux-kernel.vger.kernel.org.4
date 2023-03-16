Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3826BC610
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCPGV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjCPGVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:21:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6747D7B13C;
        Wed, 15 Mar 2023 23:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678947709; x=1710483709;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8s4xKEdaq3Hey97tTkko2m7AAvjciNudQxr/GT4yS6U=;
  b=iQF8kWnljpcfSNFooiEqCOUGmjtmxYEByTwxQbd3pK48LWlaeKRwvC+d
   3zibLLB0hKIMEwBgDNNvnJedCCUXKsGB9Hm17JM4j3JUON2aF/Cn4IUiS
   YPqssfq0pIEYISC0EpkzKCtd0p4W1ABaR+adu8as23W0kqxpjbS2dB4ad
   tiLJ4c8WXm+R1kjbsm3Ov+cWUHYQpqPQlZ9JQRiQitkIq04oIkRQl32yJ
   yPz6BNtgDx73q7vr30twQnXaH+bwvAc5dpkWQCfSavkBdmQjB6w7Mt6iV
   SUqmWDustvtyCyYnzMh5LPHjRjuhtJxo42CZc67fmUKazESGw7Q0Jok/f
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="318299894"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="318299894"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 23:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="803588503"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="803588503"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2023 23:21:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 23:21:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 23:21:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 23:21:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 23:21:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWRIHrtqO+SgGTmMGBXYqpRuNZx07yaU+AUUzrVWG5F8P3HBMDsRI+y2ANwGHVMe5rBeNyUv4Ocg2J8sdnbB3d8oq+ZrTUwLet3rC9MStZwPoNY1Skplv5iQt2UgkhuqKOLwh5DWuUtLB5Ie/Se3FByV2/HeN1xQzhCWgqz++2kms8SMKTUIXnSsis0ErMOhRz0r57e3z2GSjoz9ojKmjrdZ4meBjLbs9gDDmCbIHC6T03zEesUeZpLpTgNvUVDkBVKLD/GTf6/f/4Sg43NUJt2nojZH80cDedqHjfdL2BxZ8xknD09ptjrT+Mqyu747p+bq3P/Zp8FN4hbn/6npeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3n4ag7Rcr5ia+e2QtakfT4pknND3ywNwRYjHgsXUSs=;
 b=lwFRkvjVFUOCycXUEncws3Cfyi2WJbmT++F//hesFD1HtWOYvdSDUuPjNNfCN9xKM3J6DQIlTb26eOCy4fz9IXAn0pE/Pv+ZJTigi9R0mN40koj6+d0zkhvkHIrEYwu7OZocDKI5/yeqEQrNlNUqTkcDRExm2leeMNbyl573+gna6Ie4ExFHxeNlFEle8cVCumvzdyMQLOVzDSasMHSh1Lgz23+jJIxnCwXRu7Zp5wf3XjTZRhIFa0/m6qDWZYGDvWVFcEzmZUTtmOQMZ7Z44wDkC8mAaMtY4yRH8Ziro0TfV/8bO8si3xRWnCeS6wUpiUOPwZj+vjjF/zUs56i4Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DM4PR11MB7400.namprd11.prod.outlook.com (2603:10b6:8:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 06:21:42 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::66b:243c:7f3d:db9e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::66b:243c:7f3d:db9e%3]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 06:21:42 +0000
Date:   Thu, 16 Mar 2023 14:18:57 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        <linux-perf-users@vger.kernel.org>
Subject: Re: [linus:master] [perf symbols] ce4c8e7966:
 perf-sanity-tests.Test_data_symbol.fail
Message-ID: <ZBK00bqcyl2lnG8W@yujie-X299>
References: <202303061424.6ad43294-yujie.liu@intel.com>
 <d62c6cc7-9f43-2c23-d9e2-1ddbd0f5234c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d62c6cc7-9f43-2c23-d9e2-1ddbd0f5234c@intel.com>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DM4PR11MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: 646a035f-fe9e-475d-de65-08db25e6b55d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MG85TZAiC39bEV87WB8CIFuVOWfeZHhRrHMMRFUlwOiswEtgP3qhgGBrSfd1Jmgwwx0PgNBd27H8B0dO5mwGGUtULFv9U1sq6NdUp7duQ/t79PQ5OK0ALsSvHO3/aXy1eed+Of6mfIk7TNcw9trYRotlpGs10KKajtuY2Hv5PkgO7lX68uv/FOaBe2Rzvk/GI+1bri3CAgu/IgGpjHev3Bv27TE4nLlHzSryFReV0A4dt7eK7QcbGtDyZ/tW9j0WTqAaic4ILp18yD7Ge0juhuBC3Ru660ALGVLnp63sM6whl98XBZH079qdBPhfYFIXVY2oBJUh87U91LMNxgCLsDo1iGbDmImSiOs/HbQLACycsA5FEIGTAWi4enLBFWrpObb4MmI65BrmjlXA/oX343x6STNMkijXoVGz1KzX6AhzkdBXw7vCf20cPlCabldyBSJsd1WYnWta+Sp5isNfrBsoF/+knf11dROl0rQCLDMzIjUGbRVclihqiAVDZPbu88LFozsoX3UDHvPTRNzUcPxOS7zAcRUPAtAaiFU4aBtK4xfh3tIdB8i5LoejWQ5T6QABSUPAcuOC/nFquERsEyv+j2f5Eyk+hfAtAc8dMRLKrgkCdKI4RI4c9Hfz5GtCL9OvJmdIFax6Sn1a1G/AN4ksYaxdFMnE6kcmWgC2Vf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199018)(2906002)(5660300002)(41300700001)(44832011)(8936002)(6862004)(66946007)(66556008)(4326008)(66476007)(8676002)(83380400001)(478600001)(186003)(6506007)(966005)(26005)(33716001)(6486002)(316002)(9686003)(82960400001)(53546011)(6666004)(6636002)(6512007)(86362001)(38100700002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8W8oX8jj0raZe1c75O6JTAChNiSe2hDX4EGeCildlvI/cccB8ZKoDVfshyNA?=
 =?us-ascii?Q?Q6s2pez8cUrRXD1MPTYoThEq41JJtTSqWsAPq/IvUFTvZLSqSBPVzsd9CmP0?=
 =?us-ascii?Q?46H2dm17YLnHydjgs1lTIB7ust6jZ3Kr6wXYTZ5gLe4P3xl2LA2/rUFwxu/t?=
 =?us-ascii?Q?ouaSs2jVeKfIvgwahVJhhwo2+ztIrMzNOp5xeLIHxPhr9wuSCBFQpObHKwpZ?=
 =?us-ascii?Q?ZsoalkW9G4/Tynffw+AbeG6CUWPcgmljW+UPoS6M2447A0qknMt5FfZ5BJr5?=
 =?us-ascii?Q?dshTcoIfvsnPX2d7H6IVlDKQ258rMBR9EKC3hKLOpK30slzCn9OweHkqIcPh?=
 =?us-ascii?Q?8YSGtcJX6U2qDT00HDCrzCVt52srQmVNKyeJa9qIvoBFU4+nyHLBncqtYxt+?=
 =?us-ascii?Q?RX1QjEUXaX4mTNcXvxFy8M5ZhU+AQsO1IDZxCyEHlc9MfCyK3r1oj+EqRYRp?=
 =?us-ascii?Q?Ox4+2bZ7l/s7NoDe+bUNqdId0NhoOIBjCqUzFg9yb8TUfIZbXRo+hGeXzPa9?=
 =?us-ascii?Q?etr6gw60zcJ92atMmMoM/ZMTIXSATvFxT79fsQZeZttMl6KVl6Vso49uKoD9?=
 =?us-ascii?Q?EzqEDEXZ2cdYDPdR7fVmj6Ibp+mikvJSOu0plrXeXAUQQb/bzA4CUIn0+Npj?=
 =?us-ascii?Q?MKC/o70zuT/wWiSVao/pWpcoWy+wMPlO3U7TdOiUT4Qu3qgA1ImqsdjNbAi/?=
 =?us-ascii?Q?XkAQn+kJH6gxY3vW3kU6J2PGuoJ6AOSyQKtFupITQQdCchIyCg7bxrAoPHfS?=
 =?us-ascii?Q?IBzM6QyUKI1tGk4VaU2YRws4n4msMoSVuhMRS/hymQ3NFnK2GHbygBkObJQy?=
 =?us-ascii?Q?U6UCMdhE/kEn1RQcTApalnO2W2k+OH4HigQ5SimkraEx/e7lgKWRghQmpgIq?=
 =?us-ascii?Q?6DRA3FkcSrz13yeVFJF2yymPrRAvRLbZXkTSfExfBfH5BgkeIuB/hwv3jCPg?=
 =?us-ascii?Q?OdZBZBXchpeK5P8ut9eTb1yhOKrVKNfNgTbltg+YMX1WzaBKRBfWhWFItqPX?=
 =?us-ascii?Q?0wOQeiSbzhNrIQ9eZNj7Zcgd2fgUpUxecioq/2eTv4jIL9wFxaSJBEvaZxJ/?=
 =?us-ascii?Q?x2BvPacMyS8mXvcWaG957CYfQlbvGF4CzPf0IG1KVY0tbohisFiKBAOah8Fs?=
 =?us-ascii?Q?+lltBmJGEmMaO5xmjbFeh8jDc/XUP4gFQkP62a+p7VSOMN4uP/HXwO+isFF5?=
 =?us-ascii?Q?1X8R5uEbGTf9db4C3A8pa1Dq4gtF5daMQbmp/FiS+ZaBO692TtFWESb/eu4d?=
 =?us-ascii?Q?Uh4pG6ZO3gLbFiJbvaX0nGlkM/D+9u8fMcre2E6zbgR+xi9VvKvZJaNQTlKf?=
 =?us-ascii?Q?xk2q4DxUDSnCX2Xl++Ijv6Fj6p8oxGiAmq8VhldtZSwGADl/XhdsBKXvkjyK?=
 =?us-ascii?Q?2voEiEIexkKWwoKh0wP5cfpNFd3UfFLO10n97dsirfvQX3U2e1Fg6U90NXrQ?=
 =?us-ascii?Q?MsnohVMGfENSTPCiVOs6ae70zNzYf7xvhAPIT1vzfuBpSng1coK0j3ILgumP?=
 =?us-ascii?Q?UTa9obqyDWTdctnQ81KkJzdxx5HLjK2Hpx0U7OOKXsgFjTNA1iZzJWNWLDKG?=
 =?us-ascii?Q?G1/LpTJDpnTBjDUZ6F0fXFrGZRw2SssRy4Trf8/o?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 646a035f-fe9e-475d-de65-08db25e6b55d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 06:21:42.2183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXTLxp5S4MwmI/sx4y27Tr0EhCng7w5Smq2hiqBFsKjho8jcA2kzafUE28QvgbhPgfZqNSvJ43lzLg1JG92Gcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7400
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 03:20:09PM +0200, Adrian Hunter wrote:
> On 6/03/23 08:30, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we sent a report when this commit was in linux-next/master:
> > 
> > https://lore.kernel.org/all/202302092156.c0b14693-oliver.sang@intel.com/
> > 
> > This commit has been merged to mainline and we still observe similar
> > failures, so we report again FYI.
> > 
> > We noticed perf-sanity-tests.Test_data_symbol.fail due to commit (built with gcc-11):
> > 
> > commit: ce4c8e7966f317ef2af896778b5fa9105a5cd351 ("perf symbols: Get symbols for .plt.got for x86-64")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linux-next/master 1acf39ef8f1425cd105f630dc2c7c1d8fff27ed1]
> > 
> > in testcase: perf-sanity-tests
> > version: 
> > with following parameters:
> > 
> > 	perf_compiler: clang
> > 
> > on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > 2023-02-08 19:29:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-ce4c8e7966f317ef2af896778b5fa91
> > 05a5cd351/tools/perf/perf test 105
> > 105: Test data symbol                                                : FAILED!
> > 
> > 
> > =========================================================================================
> > tbox_group/testcase/rootfs/kconfig/compiler/perf_compiler:
> >   lkp-kbl-d01/perf-sanity-tests/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/clang
> > 
> > commit: 
> >   51a188ad8c2d8 ("perf symbols: Start adding support for .plt.got for x86")
> >   ce4c8e7966f31 ("perf symbols: Get symbols for .plt.got for x86-64")
> > 
> > 51a188ad8c2d89c5 ce4c8e7966f317ef2af896778b5 
> > ---------------- --------------------------- 
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |    
> >            :6           50%           3:6     perf-sanity-tests.Check_branch_stack_sampling.fail
> >            :6          100%           6:6     perf-sanity-tests.Test_data_symbol.fail
> >            :6           33%           2:6     perf-sanity-tests.perf_record_tests.fail
> > 
> > 
> > If you fix the issue, kindly add following tag
> > | Reported-by: kernel test robot <yujie.liu@intel.com>
> > | Link: https://lore.kernel.org/oe-lkp/202303061424.6ad43294-yujie.liu@intel.com
> > 
> > 
> > To reproduce:
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         sudo bin/lkp install job.yaml           # job file is attached in this email
> >         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
> >         sudo bin/lkp run generated-yaml-file
> > 
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> Works fine for me.  See below.
> 
> You will have to debug your environment:
> Add option -v to perf test (e.g. perf test -c "data symbol") and
> add 'set -x' to tools/perf/tests/shell/test_data_symbol.sh

Thanks for the suggestion on debugging our environment.

We found that we were asked by developers to run perf test with
sanitizer on, so we build perf with some additional flags like
`make EXTRA_CFLAGS="-fsanitize=undefined -fsanitize=address"`, and the
test_data_symbol failure only happens when these flags are set, but
won't happen if do a make without those flags.

Could you please help check if above flags could impact the behavior of
perf test? Thanks.

Here are the test results with and without the flags:

$ make EXTRA_CFLAGS="-fsanitize=undefined -fsanitize=address"
$ ./perf test "data symbol" -v
105: Test data symbol                                                :
--- start ---
test child forked, pid 25107
+ skip_if_no_mem_event
+ perf mem record -e list
+ grep -E -q available
+ return 0
+ TEST_PROGRAM='perf test -w datasym'
++ mktemp /tmp/__perf_test.perf.data.XXXXX
+ PERF_DATA=/tmp/__perf_test.perf.data.t834P
+ trap cleanup_files exit term int
+ echo 'Recording workload...'
Recording workload...
++ grep -E -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo
+ is_amd=0
+ (( 0 >= 1 ))
+ PERFPID=25120
+ sleep 1
+ perf mem record --all-user -o /tmp/__perf_test.perf.data.t834P -- perf test -w datasym
util/util.c:527:2: runtime error: null pointer passed as argument 2, which is declared to never be null
+ kill 25120
+ wait 25120
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.154 MB /tmp/__perf_test.perf.data.t834P (993 samples) ]
+ check_result
++ perf mem report -i /tmp/__perf_test.perf.data.t834P -s symbol_daddr -q
++ awk '/buf1/ { print $4 }'
+ result=
+ '[' -z '' ']'
+ return 1
+ exit 1
+ cleanup_files
+ echo 'Cleaning up files...'
Cleaning up files...
+ rm -f /tmp/__perf_test.perf.data.t834P
test child finished with -1
---- end ----
Test data symbol: FAILED!


$ make
$ ./perf test "data symbol" -v
105: Test data symbol                                                :
--- start ---
test child forked, pid 17241
+ skip_if_no_mem_event
+ perf mem record -e list
+ grep -E -q available
+ return 0
+ TEST_PROGRAM='perf test -w datasym'
++ mktemp /tmp/__perf_test.perf.data.XXXXX
+ PERF_DATA=/tmp/__perf_test.perf.data.qqdDQ
+ trap cleanup_files exit term int
+ echo 'Recording workload...'
Recording workload...
++ grep -E -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo
+ is_amd=0
+ (( 0 >= 1 ))
+ PERFPID=17247
+ sleep 1
+ perf mem record --all-user -o /tmp/__perf_test.perf.data.qqdDQ -- perf test -w datasym
+ kill 17247
+ wait 17247
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.364 MB /tmp/__perf_test.perf.data.qqdDQ (5039 samples) ]
+ check_result
++ perf mem report -i /tmp/__perf_test.perf.data.qqdDQ -s symbol_daddr -q
++ awk '/buf1/ { print $4 }'
+ result='buf1+0x0
buf1+0x38
buf1+0x38
buf1+0x0'
+ '[' -z 'buf1+0x0
buf1+0x38
buf1+0x38
buf1+0x0' ']'
+ IFS=
+ read -r line
+ '[' buf1+0x0 '!=' buf1+0x0 ']'
+ IFS=
+ read -r line
+ '[' buf1+0x38 '!=' buf1+0x0 ']'
+ '[' buf1+0x38 '!=' buf1+0x38 ']'
+ IFS=
+ read -r line
+ '[' buf1+0x38 '!=' buf1+0x0 ']'
+ '[' buf1+0x38 '!=' buf1+0x38 ']'
+ IFS=
+ read -r line
+ '[' buf1+0x0 '!=' buf1+0x0 ']'
+ IFS=
+ read -r line
+ return 0
+ exit 0
+ cleanup_files
+ echo 'Cleaning up files...'
Cleaning up files...
+ rm -f /tmp/__perf_test.perf.data.qqdDQ
test child finished with 0
---- end ----
Test data symbol: Ok


--
Best Regards,
Yujie
