Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663B56B6CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 01:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCMAib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 20:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCMAi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 20:38:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A51E1EF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 17:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678667908; x=1710203908;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zIDzHS98Bx4Ll/s1PowvBQEr3pBZoVCs9f4AsoKP2gs=;
  b=PXomOtgRZ/bcv/QP1EpYVRU0cP7/AT6dtWAKh5aAgDFxy+eoRMQGxGqi
   Px8FQxLCYzoVlsULI+5NPPG1l9oRK0jmdQrAJlikwFdmTN1EhrKr6cbeF
   Heiqz4hxzv4Cd6tiRmN98f3G3NtFHX6LEXqOfS8YnH7wkieitpf014+ON
   dk8Y2KrLWbIxMI4SBgc2TJN/p1MN3TZk7SjS5yBNXS0XrSVsRdTG+KOpl
   DqNyOlBKO/G2MiWgNdnSABTDn5gLlU+AGpbc2rj6a7ePaAVoWf/zob/dC
   AT8ESMLXLM8xHx4Entbdib6A2FFNLdbZYL1sqQhnqUlT5wAj5ZEeW4YkB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="337056013"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="337056013"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 17:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="710935188"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="710935188"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 12 Mar 2023 17:38:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 17:38:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 17:38:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 12 Mar 2023 17:38:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 12 Mar 2023 17:38:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3uyh8RDhRqDp9+lvN6OqxWKyui4oqZ/drpPA8D+MkbVr2ZJmCTMIgOfdwg9ChzQpFB7JoTLVYbKc1GFg8Ln+yB8yRGG4MOVmhCYle5E+uWm6j/uR+tU8W7V/4CjanAaMGs8jXTpxZds1DUPmVqbcIZZw4SRPj3NB/4ok0d+E32onYnbJSQnbFsPLqA492k3fXbUgz8c/91Tv+hrg7jVmL5PaFW1qjZT0uBYvWtDNXJRCHk2jFvzjIb5XKhB7d4RNTjP6CjQkizZBCENDzJjvFkoxMeqOtwJkfY64MOhQawdDewo87heaCstptkahiKkbPP9G9mrCmNfILXeVb2lAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FheZ9GPO01SnsW3+AN6Z7lQNrIj7hIPDklcSN+A6tNo=;
 b=GipBzVZ7TB7CbxUY/WRn/I4wrUlOy/3i/NCGhYH6oGwAfahKEFCIVkSpzCPnfZuegQWueH2DP21mjz/QnwWgJIdNxFYWHN7kDYNt2oWVDglkeXZpyHgFSp9BMeTCgA7UkSw5rRqn4Kt/DuGe+tTDEbrEcZrtZXLKqsiFzXjBGvxutWjB3Ixx9J98zrhODmVs4iU5BPMZ85tvBRUH4rMI9CdBpK3+2KbcjRRloOPsg+u54vCNFNBL1hE3aGysfZdiuk64Ys5YUkukbYNstGTVZCpwQaJ/1ie9plVEnoiyw+E0zwnRgD0NyaoOkKli9+wnXzSBbZ8cvkQsLnHssknyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB8065.namprd11.prod.outlook.com (2603:10b6:806:2de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 00:38:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 00:38:21 +0000
Date:   Sun, 12 Mar 2023 17:38:17 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     kernel test robot <lkp@intel.com>,
        Kloudifold <cloudifold.3125@gmail.com>,
        <teddy.wang@siliconmotion.com>, <sudipm.mukherjee@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-staging@lists.linux.dev>,
        <outreachy@lists.linux.dev>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: sm750: Rename camel case functions in
 sm750_cursor.*
Message-ID: <640e7079b2723_229a8929448@iweiny-mobl.notmuch>
References: <ZAuiDTDT8dmBcRoH@CloudiRingWorld>
 <202303110849.X24WnHnM-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202303110849.X24WnHnM-lkp@intel.com>
X-ClientProxiedBy: BYAPR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:a03:60::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: bf346700-951b-4960-a320-08db235b3f36
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0joKhsdnygaK3D6z3XS0v7/bit6HnDqpsqcfQoUoV5odmFOPbRKX5t97Mc0LqIiEsa/1+obNXcCWXp+A5g34Xiakv6/vQ0VNGWRUg8MBNcCHquu7j5lUom2cmGrhrLk4B2RL3NJWwe6H//4dPz9LMYINykxVJsH+0eWE3HQF3Q6sMU3OLwUJXm4D9BS2EMkRYqh9Bb51vnLyPYEvMVpeMD4KubEJh40UlbgWG2tyQvE/16tvcLT7bOwEAq0JyL0Mtbczzxk47c5vZTL5EGjth/+s//Y2hUSQCGpDwfwJ3QcKJMzRJHP668QIlkCR+AArDeyYIi8e6jFqYl5SYziM0zYYijnWpuN4nWEkGbdcfyztx1a90bqpFEGUhOvXX9Kew/BzGnWCi5Oy7wFPAH8ZhMhZgf6EyOcmHnUXzJW8gTkbC0itXe1hm6G5IHRGEopmv5+Lwo6WvSVykkWjWrbX2plaXxvb8yGKPiy94Tg+wO0EO/vOsGDFsg5K9KHUIx2OiMzyqdFhcXxJ7AnsRnF9OSjw6bZjJ6P/gHZpSDVF/S6pC/f1ay+SvgPV3CEuyt0TfQmpbtboRO+BiwgBPehWM0qP3P+zti6hBAyiW9nQe0XlvEIwN+68qptA/nYqu4SXlpH0EL7S9F3o9CeIS/KcqwXaN1qW4x0J1NkLzVJbjfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199018)(9686003)(6512007)(26005)(6506007)(6666004)(186003)(44832011)(2906002)(6486002)(966005)(83380400001)(5660300002)(316002)(110136005)(66556008)(41300700001)(66946007)(66476007)(38100700002)(8676002)(4326008)(478600001)(8936002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?737wgA5EsEEw32YpF0fOOV0dtvh1q8uZZoord99i4k/OcmIqr3D7nQMgws3u?=
 =?us-ascii?Q?z5a1YzD5RqNrVUIEp9FU7Z9EjRCwFN6EiWZD1qYWxOJ1Z1tBCJ6TzpwBiuj5?=
 =?us-ascii?Q?JMx8HN20WcXCsi1hQehjfn+lzAB3tPuGaQirpoXk9SQmjzR82XOnmDLNzsn1?=
 =?us-ascii?Q?f6ysEqMaaztviiVX8lOHIBpy9IdK0i88juWZRTpTNczOwgZ4VYSJuSPyVLRS?=
 =?us-ascii?Q?S5J//dXezFGF8M9Co3pD/u7cJjm216eAW0of6Ftzje2VTb+wT0VYzELIXj5v?=
 =?us-ascii?Q?D301uGBiqTxHZ2Xb4UQ79wd5V1z8AckzEXIEZMfkdRolaHlVE6IlEPSMHGzM?=
 =?us-ascii?Q?f5fnMufVAsM8VZQ6RVwh6QRN/vA7aCnJIwNBfxUM2w8eNClLxyxBU54v0vUn?=
 =?us-ascii?Q?CxVPah8OEqpxV41bWvuGe5lBMg/1xIqHfaTJlR3cnUU3sRzb0Q0MaL0xtut3?=
 =?us-ascii?Q?l2CGI5y2w08Nen1rV/Rt6wyKfq8acRZRtmMh0WTLDr8Bzt8v0/66x+Y0/04M?=
 =?us-ascii?Q?NJ20E2rwg9KScKXdK7JoeuHKPc8pccsXKoVm7U+Nim4jWlxUdhSxWU+BAbfH?=
 =?us-ascii?Q?QoYKtH6FAP1SK4iNzhJS7gLBUgbqhddHNW/ReFTrUd/gLAKYPuo5QrH5pOZv?=
 =?us-ascii?Q?lnvfjdRVCTQxLN7/VrJgZPwEsCIH6Mvt3MsFqB7B8o1z00MIeAI+NI/wUInh?=
 =?us-ascii?Q?gJwwGRN1rKGEoP8AwNUEFckrFUn4rVA2dzwWtScZ06DPcQ80++YIzVyVRjlN?=
 =?us-ascii?Q?5NRoHA+eRFMkvT68M9AdHKImwscqSV1VpPRxh5LFf4/+RZ6UokXOd8zdv/5h?=
 =?us-ascii?Q?VHobjfY5kQBWvKBX++abafuDwZkaW/Wircsa2VPQH+N2xCxVOk81cbhJAJOv?=
 =?us-ascii?Q?JW7ad11NQ9ZA2XsjVVUCfWo5SYySQKevv0QBz7Du5fduO6DAnUvHKaqzwxYD?=
 =?us-ascii?Q?vYQncu7bHzoUnwqy8+eeLiq2wfsl4e505o+O5x3GH05USyQUWo11YsVPmEqG?=
 =?us-ascii?Q?oq9sPCdNcVJyd0QlQtrwSfH971z+4Y68mghfdqswRHfjhNmYt4HsVaIgLjYz?=
 =?us-ascii?Q?la7TuSpaiMdgQVZR+zD2aHZPyZnozNy5krznXmU70G022c+BBtxMtHNumJVd?=
 =?us-ascii?Q?vXv/sgoS5Nnh3xIiUrHc2EaKSl4MKF6+gq5u0bXoBPr6zxIzAe9DmxZ+2J95?=
 =?us-ascii?Q?3/zmlAvyppITees9Hq0mmlM9di4O04yU7OG4XW3A5WNVk11Nlos6bfvdWAFI?=
 =?us-ascii?Q?wVMUbBl/JbjsHB2lfIY5egJ3XjAtJ/K7oNOEycOWJg3+5Jojb1+HFR+yMLqg?=
 =?us-ascii?Q?/en0oBEv9Z7IbU0TlTLTZl2UHOfgUUgOkcERvAAj8eRk5y4YxVV3YpvE+DpM?=
 =?us-ascii?Q?hiEvx6yjfoBPZ7IqU/0rtJDp4Pmlc8eWlBtDGRUR5aKyAf8i2CmM8Dlpc9X2?=
 =?us-ascii?Q?MxYt08qcv4Q7Y0kUM+RLtECJyZ2XNBkZC6hqWHyVw50PsoZjt4/gjndZDx4I?=
 =?us-ascii?Q?PjTDi1M4NW71F0Vur5iDqokinlrEewMu8BsdrkAe2zzQFoIdKWiQOS0VnHSl?=
 =?us-ascii?Q?YTt3M+EQUJJ2RBeBXvuflD2gyw7CE12pa44p1H4Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf346700-951b-4960-a320-08db235b3f36
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 00:38:21.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHvhipZ0NCh/l/Nr+IzyYtK6fE45kTW284InBJUbX5wbK3dVFClYL0uTqBZNHHl8WeQVMtDoYyhAYJOF62uvgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8065
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot wrote:
> Hi Kloudifold,
>
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on staging/staging-testing]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kloudifold/staging-sm750-Rename-camel-case-functions-in-sm750_cursor/20230311-053447
> patch link:    https://lore.kernel.org/r/ZAuiDTDT8dmBcRoH%40CloudiRingWorld
> patch subject: [PATCH] staging: sm750: Rename camel case functions in sm750_cursor.*
> config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230311/202303110849.X24WnHnM-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/c82f66fbd5902ae486c4e2227e5071a59c49a05a
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Kloudifold/staging-sm750-Rename-camel-case-functions-in-sm750_cursor/20230311-053447
>         git checkout c82f66fbd5902ae486c4e2227e5071a59c49a05a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/staging/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/

Kloudifold,

As this report shows it looks like you did not compile your patch before
sending it.  Please do so at a minimum.

Also, when making substitutions such as this 'git grep' is your friend:

$ git grep sm750_hw_cursor_setSize
drivers/staging/sm750fb/sm750.c: sm750_hw_cursor_setSize(cursor,
drivers/staging/sm750fb/sm750_cursor.c:void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h)
drivers/staging/sm750fb/sm750_cursor.h:void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h);

Ira
