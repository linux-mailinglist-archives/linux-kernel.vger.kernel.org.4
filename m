Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F1A6074EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiJUKVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiJUKVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:21:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4F1257612
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666347681; x=1697883681;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iXmLgYK7Hy/PbHsA7CqmSz5tuwUqyrsNPSc2Us6Z440=;
  b=V4GzV3FR3XZ0Hpc3ddVhG/wc5yWk5fOedyZVvrsc+HQY278RXyBpUsgM
   ZtRgg1Uk5USpMLlG97Ep9Bj6V+7/mPBVc3tcvBPoaerf76zcIgMnnZGu/
   im4CGicnyOjdEK6CndanZ3tzWjHB4rXM1ly+39xJSTsozmWBfpnyeGFRE
   66dkRkG7BHWCQ+ulVxvzWiC/e5K++X5LTeYxoDRCs1eUPn7GKVI5Dh3OD
   8DTO4NQJ9h8SZNRcqgI8QcGKjMCK3nVaHAuKd+yvH9baKZX6LHMgC2n7+
   kYWYL37d9w+QcgDokFDSd5TOjYo6Ol61cwe8AxvJM7KhbmnFgumAe3bFF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="290275684"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="290275684"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 03:21:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="875613865"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="875613865"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 21 Oct 2022 03:21:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 03:21:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 03:21:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 03:21:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 03:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+t1Xdc5NfDkBr+lKL8s5QK0fB028tbuTgJtwprD+m7isLRgIcpqLkk5vXcr65+pB2U6xdyK8OsAS6Gb2pcyLTBDoveWrydMImUOWs3LEdzHfIF4qe1GdS3+9cjjy95fMrieRaXBMYrIEwslIkxXoHpyt6SdmF3Ni8IAoaKibOLW1maZHzenWrh66UR+YtQhLnRTY0Q2KlJ48O1mo9tANi7uWUk3dIDUv/yj5IiWNtIOGR/bLFNukQZtuKYBeBG/aKL0Z6k5mu8QGn9p2DdiYAbi39qFfnxcTGjjXXh4PZcJ5KDHZ57oP1eRjgSlBvSQl4RYtfZo+c3t6nO2/yLAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGVjl1UZD2piDaC22IAv9BUMmubhzA2FV7owLtViF5A=;
 b=iVyxi/3NlENwjTlz9qjQVrwrlzDkJPUoiZFB9zhsKEgtMncFzPfsv9eE5WydmxqWL7vOwc7Pi7AShAWaz4MxKPC9NSP5x/kfTWZLyUnjdtHaq+0Ml/5YG5W73I/tLBb9bfaLfbeB1GRCP5LhfZGTV50rSFNqo50xPyVhfA37XsdON5endhmIAjzhG8VM26asuMA/vIu9bMHWFbjabWbYV6kH56bqzpfzPLSCpQ4KkgM1imVMMXoT9MAWSSjqdrktHYDLsCGvP8qzKOzdJU6sW5J/vMSp60YqGI1Lfl+y3XJUBS36fmmLwjIvhymy7WSv2TrwGAAXQYXLbHeITGT3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 10:21:07 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6%3]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 10:21:07 +0000
Date:   Fri, 21 Oct 2022 03:21:03 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/5] x86/microcode: Simplify init path even more
Message-ID: <Y1Jyj/MjhzJjU0rb@a4bf019067fa.jf.intel.com>
References: <Y1A5YHzmzab8LrYD@zn.tnic>
 <20221019175426.31025-1-bp@alien8.de>
 <20221019175426.31025-2-bp@alien8.de>
 <Y1BOkbXsQxCZK3U7@a4bf019067fa.jf.intel.com>
 <Y1BSF8ck0RD9UpLd@zn.tnic>
 <Y1EEObR7keIDJtVJ@zn.tnic>
 <Y1FjlfVQupDc7q1r@a4bf019067fa.jf.intel.com>
 <Y1Jl0tojpBzY2y/8@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1Jl0tojpBzY2y/8@zn.tnic>
X-ClientProxiedBy: MW3PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:303:2a::24) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SJ0PR11MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: 124a921e-8535-457f-72bc-08dab34df751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSZ4cG6oXuhbhVk4K3LJueM/os6mJhyvNCijKH12Fuf9E5D2whfhMDFCR6kB3eM0le2mlBne84Ol7gCCODSROqsBa+02CF02C4OGktIOmYmrytKQJDr6oU2olrQidlPL7y59mRvQkFOnIFeoa3L3Gj+nmC4xZ25VJ/KVvfvHu9YYzo9mQQ5wFjuJevWRPGry3ifHXk2V4PUZurPYnvkdRAY49iUGjIOrUv+L2QK0jWiJ+RBbEcwCtQl6gflsIG2yZdyiu95ufpHUw5aTDNK2ETt+W0l0/VFdcPs5dUZ1Zja0pDh1WaeVSO/bWgY0POR41ll21nYjoojyLQZvUk48cND23og9y4dBnXd3ubEWf8lHjBeeTVNp/H11pbkB2RRQssIzkfZQ7sZBWacHllunkbjFpS3NV3+W8CrvU67+JJpMu5wrpZdh5puwfRc5rv1MIbrPAqXcs+jmvzojtrGVNtt+xY2eTnZ0+tofyNujLWguQ/CXT2P8RD8RRuhxxvgIPAg6US89yq23ICmDhW8qdxbfIUFrMxgBTkvI3cWSpa0oa3iQJ8nQEPPqx2c4UkIl7mu/GQ1uP69NgVoUojPVosZHOuT5H2o+Gg89jkXnWxBLwUgh/9tIW8Q7ZOakxFxchlr5ZF6zd1lQuLKAi+2+j6jyElyiOueNhTXzdB6g4/zvKUvsczgFEWKC0mL/ErM5nFzqm7/ycXpIT0My4NIyiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(66946007)(8936002)(4326008)(316002)(66556008)(44832011)(2906002)(6916009)(41300700001)(66476007)(54906003)(8676002)(6486002)(86362001)(6506007)(38100700002)(6666004)(107886003)(6512007)(478600001)(26005)(83380400001)(82960400001)(5660300002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ByO26LSpkRTM1o9TU8CRCkn3jQVOQOOV8ndRy4uC0Er28Wz/zbpXQ+t5jsc1?=
 =?us-ascii?Q?Z369wnN+lSa6EPJpspAdVOj1P6OujDR331emcka4BTSofM/IFly3G3qiNz/L?=
 =?us-ascii?Q?OzZf8fFVRy8zEolNpbDkDPlAMd0oNIBaNnuwYuEy5hjWZN71oWv/r2qkzLfy?=
 =?us-ascii?Q?qjLl02DRzaikK1TX+DyzXqRKgikaJZd45eiITsQzQ24t0nAukCC0IRvqnCp3?=
 =?us-ascii?Q?frDFI+HWZRtVzzfp8kh3n3tYSINVRn3Le/uVFw42F2gG/t3pg3Q3O/T9LpPU?=
 =?us-ascii?Q?lZYEA3XnvOsVhaqkbcRQHJIPe03f+bqCSIDEz8sKmuMRgusH3SpbGqmxiLYZ?=
 =?us-ascii?Q?3aZOMx5nW8skzSF2BjKONRA6yL07MIyzeTVK4hYXAZgmgOMGoG+9EqUex+xB?=
 =?us-ascii?Q?83wII7VN0mH1mHQLWeoph8PtaWZqMV/4EAwTZGRatlXplLiGAktPwPfq5ZSt?=
 =?us-ascii?Q?QxNlPgyxS6U0pvzuHxbcxQ+jisqWnnv41XJaIXwQ5v+i2YLlD6CqwoYBY/mV?=
 =?us-ascii?Q?YIIBeaWTTE10WY4E6Mi2ppYN1XIS5mFgfrlF+oKlWegiT1KNkcUSz0m3rDXB?=
 =?us-ascii?Q?GeW0ClYT2kI1Vs5MjheGU3cum9vCnvGyw0kvvOdxt8crEKK71wltpmpWfn6k?=
 =?us-ascii?Q?1pVEinS9LVp/RJijol71lZmW9l0mA7lwmYUGMdMRjFFTLc/nYR+GhB8D9pE9?=
 =?us-ascii?Q?dAEysoq5agVxhFsGnjexJACM51gM1xT653lf9SK4skdap4lABiBXNzTpJsLg?=
 =?us-ascii?Q?BNXYbCG0IIO5a+gvEu/0uPQ7CnIyOThX4ok/QwvIGlpqAOtPlBYKsE2+tZwe?=
 =?us-ascii?Q?A2csAP70eGWXxIEqnajEhZhqCRr5qXHekGhpa6vw8H5H2vyrqArtysa4z9XD?=
 =?us-ascii?Q?pLLH6JsKo/HL1WUFLTdvgYRlba0pb76ZO/LLoSS1FzyPCxiYwrhnMwsPID8I?=
 =?us-ascii?Q?3U3MlMNJtUM5EzejAWP3Vc2lgljX587ALmlK9T4IXIV6j1FAKrb5FDcF0QyL?=
 =?us-ascii?Q?OxraJS90tXu0T6LsyJUy5roxU4hmZuVFv9PGbRkfJbDe7RUr5K38IIQG9zLg?=
 =?us-ascii?Q?b/6FS01UtDbVhR0/jcpG0hz4NvdJKuVaSEkjYpkGcBDTWBJct23qq5TTVnGq?=
 =?us-ascii?Q?OhjUVhnZWwwZXOsBjd4Lx5qj+ijAZwGO+45LfnofbB27GSiXceZkc7y9NZV1?=
 =?us-ascii?Q?dGbDg7wT8ZZdhlumGH6qWCDBZ5oG/fPIG393skjB7Rfgc6390fLmJfQfxxKl?=
 =?us-ascii?Q?sxysRf+dQrt47l0ukPLVrK7a/KUAzZYLXQ+CBnoXbEC9/6Rev8oApjw5zVfL?=
 =?us-ascii?Q?b0H/8euNkoZWlqj+SdoENHmP5miFdAPUYeJ/4g+011BcabNjXrRNEQdjcMrF?=
 =?us-ascii?Q?KpKpceAhoGgEG9Sz0RXlgTiuJ2A+wgnqPY8KgBTS3EoNm2slQnfOUQrUs+mv?=
 =?us-ascii?Q?14maj8Jr40oOMjXDcAqvLTVylKMbli5ixR/nbc3O7uehT5355ppionAem2dX?=
 =?us-ascii?Q?FVZxcZzTGEvPiFJ2BiwtQgfauiHX9VaIGbwx5Ion6DXf4pdw6Tg3Lj8cDGxH?=
 =?us-ascii?Q?QAYwp5wG+Yow5SeKPRENcm+oCJ+sH/ZdYB2wdJKJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 124a921e-8535-457f-72bc-08dab34df751
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 10:21:07.0603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fhg/oQ6h2jahtZibWXAt06D8HqocW26U/IffE0bq9lf5J39/MZca6+7CTfDlok/Y+2u/bnXDHGhKT3sl9B3VeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5072
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 11:28:10AM +0200, Borislav Petkov wrote:
> On Thu, Oct 20, 2022 at 08:04:53AM -0700, Ashok Raj wrote:
> > - BIOS had version X
> > - Early applied Y > X
> > - I copied a new version Z > Y.
> 
> When exactly do you copy a new version?
> 
> Please write down the exact steps you're doing.

- Place a new version of microcode in /lib/firmware/intel-ucode/
- make install, it also ends up creating a new initrd
  image with the added microcode.
- Now put another new version in the same default directory.

0000000 0001 0000 0081 2b00 2022 0906 06f8 0008
------------------^^^^^^^^^ New revision
0000020 220a 855c 0001 0000 0087 0000 7b80 0008
0000040 7c00 0008 0000 0000 0041 2b00 0000 0000
----------------------------^^^^^^^^^ minrev

- reboot

During boot, i see early update message

microcode: early update: 0x2b000041 -> 0x2b000070, date = 2022-08-22

0x41 is the version from BIOS, 0x70 is what got updated in early boot.
0x81 is sitting in the default directory.

After boot expect to see 0x81 as the revision. But its left with what was
loaded at initrd image. The filesystem still had 0x81, and can successfuly
load after boot is completed.

Cheers,
Ashok
