Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46C5618E16
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiKDCRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKDCRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:17:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411B4388A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667528235; x=1699064235;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RcIn19ZEZBFclmhnpoXBS8wEtXm1wb/f5AjdJZNqjO4=;
  b=JrQLzLSxNPBmOlEYBOTL+w6LtygW2ca3JISAw/xhc0nWFdCkIIBA05bg
   0ig5NSTrCJBnrPR5dGcNsOHX+SggSH1C1WYrNPs3+nH+sTrY33iIX72bH
   BoiZ944DYJEqWEGNCf30UNUFaQdd7ENhQJqmXt6aB9bD5dI/cmrIBnOd/
   Woew1yS5QDCc7oNZO3e40mDB6TzAheQsD7KMcCPVRSMtT9TNgFAfiCNBq
   CadGhKAPEyE3AgT/NONSAgL78EfN94HWpYbFkdY+DqcGsfDq3Ln4wKT1f
   dG8NSKMbP5U9RPvNnueD6n2ZbOBZrqPoP9sNG5E6ayA6NY9bBYaAn7W7a
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="396159536"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="396159536"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 19:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809899824"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="809899824"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 03 Nov 2022 19:17:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:17:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:17:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 19:17:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 19:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZSbUtX3sbKGPCGp+zgc/tnH0YooL1DcxwbDgiWIdddaHsRDtECl1GghSlaTcx5hDm35/5GFAxzy2uXfAwgGslJ11vnIJNLtQyL2ZjNK2TV/tbwH3PHPdr6klnM2gw12r+rAfYbg3OSchS/+WckRc2Iy+NbpxNCT2KlDmZcKD6eF2NV86y9rxzE38/JxTxAGs9CH8sss3BHqfKWBeEm5s3CK9y3Xj28FoZd1b1gzCG9B6RH0S5635uMC/ecTBLzOiGOqpGq95AtSxRopPpLm47xBMTmaogIrQOVBtuNpzYQMu97xySlBCgoYTUT0FbOmhkdvljVk//FnSzMxHjHrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yzlASrwj8CKrPvZ/wER0NtAaTp976bQCG7A1d/YtQY=;
 b=cPSgX8igibrb1WtQrzaeuUGeSRM96VYPuk1HZk/om154qffeWeYf4EQX8FSVXQkepOwmJRbgjsS901Af6SEIbLy08hAjOtteJkKoHFHMrLtvcXfeZtsWm0xTrdcZ8NHJoOoAFeum/JHB3sT8h6Lllhegx8n6urIlz0yZqxwrl2CB2qWk1uehaM6vBCUW2UvqzNNKhDnMx+3dgdZdxY212io2cgVUsB1MWL5bm3uGkrQkQH6DUvvFQlfVgYcOP9eOGEVN3Dvr030l3teA01U8kI/Bq6oqwJIDAcJALbDI7NE9t5kPqBOArLc3X/uL6kZRtb3URADoKKsrrO3N9kMSCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA1PR11MB5946.namprd11.prod.outlook.com (2603:10b6:806:23a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 02:17:10 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b%3]) with mapi id 15.20.5769.021; Fri, 4 Nov 2022
 02:17:10 +0000
Date:   Fri, 4 Nov 2022 10:13:59 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>, <sboyd@kernel.org>, <corbet@lwn.net>,
        <Mark.Rutland@arm.com>, <maz@kernel.org>, <kernel-team@meta.com>,
        <neeraju@codeaurora.org>, <ak@linux.intel.com>,
        <zhengjun.xing@intel.com>, John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/2] clocksource: Add comments to classify
 bogus measurements
Message-ID: <Y2R1ZyJhgH5AZLvM@feng-clx>
References: <20221102184001.GA1306489@paulmck-ThinkPad-P17-Gen-1>
 <20221102184009.1306751-1-paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221102184009.1306751-1-paulmck@kernel.org>
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA1PR11MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: e0898f7f-102d-4a80-6e0d-08dabe0aadf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DKjSzp8qKAnA0EkM8fYtD6OV6F7tHRqzr2F0KnV2l+ns6JNRRp73lH6/IjEPrycZENC9d465p5GV/Yl5BKlJd9t83vfA+ma2t04g/EluGpE5rzoRYhHw0vz3MIYzFIAsP8fm97D3/iEvpBzPY/7515YxlOvb9nNiEfwl0olNVlIKvlxgAyDpXC+aZtTWVnYcG10SBlU3BkXBhasTF7dwZeK/IYgCIEj5z04NbL1HFyZM3M6RhNGNogVnlNjxgrKuzc6ZAULkEZFftwPGT18WeqxCG1AUDKG2htviHelmwrFb2AXJby6KJ22sx5XpsT5rDi6m7LxfjOKgCBA+XnasH+tiI0Kbibff0eUuK+fEHUVSHCvChVkGA29SQJ0KF3sIOMy8UpWWtVNOE+s0HA3E+yshK9OVDFnnDxvkCGBNMQ2RKzTCXd4fuWVjuqVz7qTYdQ9fgUrH4KhKyD1rzzFpsOoM/Bhv/sjbJRVaytnNEFBMe0NVz9F0bqnyWHAEEdQ8Bd5lai/pxVH5ez7UhhothyCPkv7EvhIvIvtH15hNF3PDkXJkCpFXxEQvLewaeY/XrWjQ6OzdwyYJuH2sH9M2ht0WumuE7rFJic5gF3PPJP5k+8vVad5t/I3bOUn+QgrdvZ33YXEzLL2eibQMw/jtwd0Rsry2wyIsHkp6bjQimDPrU+OqJyAYd8JRqoPLmM+sinv5o708G7VXErESd2JmHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199015)(38100700002)(82960400001)(44832011)(7416002)(2906002)(86362001)(83380400001)(186003)(26005)(9686003)(6666004)(6916009)(8676002)(6486002)(6512007)(316002)(54906003)(41300700001)(8936002)(4326008)(66556008)(66476007)(6506007)(5660300002)(33716001)(66946007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?caQIdyrzBP9XwlrnVbAzdEp9Wj7UaCwxW2JYh2+Zez1pGSf7BaOtjA9usVSO?=
 =?us-ascii?Q?dRNNcAe4JsclAN5eFuc+TLVrhDTATnHDumsVx0iNiF8krRbI8k4wypsIQEBv?=
 =?us-ascii?Q?PoatNR4lLbdk2xm7z+roXxUAX9S3dr9gZwx9Ldx8xJuKwcbT6zMwYJhLBb42?=
 =?us-ascii?Q?HFVRj3gebaRX0j8/pynYJh1fVzxRByYzualoTD3Nocv8tZ9xFrNGkpEBBFXd?=
 =?us-ascii?Q?V6DDlwNOWTrxIWw3msgl19kbcJLusqx/DCCq3qxU7E2yoxlUPsGCE/kydD1n?=
 =?us-ascii?Q?pFiSSwzMS96ETgHUgwJgRolrCynd+Nmu5L7hyqwqDiy/1SkQH0irwcz/1WKG?=
 =?us-ascii?Q?RbQH2ZJDLR2EgPMbHPM01iJIWxPejofM0xBIuNjx3STsi0ZaC6Ug5hUrmtED?=
 =?us-ascii?Q?3+VV89ry5GuC1D4lN9db1yUSrgNtgtjFjRWRBdT+TNtr9WlrtOxW52RyAHWD?=
 =?us-ascii?Q?ndwfx399+9Dipbq2+ONifiYh6MrD2je6DM+x5qo3TCRsdpZD2VaBX+PkptcZ?=
 =?us-ascii?Q?TeRwBRc4Pdrsp4SrvBymlcJnF8wBIy9kaOsKQbn0Fe/a3JveES1TKAmxlObx?=
 =?us-ascii?Q?XkZr9+WZjus+Ydg8/rqYue0IdUmUF2fqOG+nixzrUF6rlTJZkQGZ9upYwemm?=
 =?us-ascii?Q?dneSi1EwqMnM/Si6XwMHMnDsw5gV1h2mb8eWfpbz74CfVImVbEiZkBQLcZHQ?=
 =?us-ascii?Q?VwhLww1Ho563kz282auQyaQWGa1gUb9Bgpp9Z5PDnF7ZByD76YFGW3p5GelY?=
 =?us-ascii?Q?W5C0kjXFn8mx63qKujNN0oQSDliGhcvRg1QsU8047PmO5HSJJNXZWnmsindZ?=
 =?us-ascii?Q?+U4z6eNrY25au0PHOuRZWgz8Iqisbj/RmGu/nC+GFdhosPswkPMf/3bS5Fc1?=
 =?us-ascii?Q?CRfwzxIVlPmoDVNxy319mD1F4s/LBcIfhPTwdojqKRXiJsro71EW3sH4bNK5?=
 =?us-ascii?Q?y0hy0h8gF0n82+rFJZ4n9JqOE16YVebeRJPtos7rAE8yNBrS9KrAO/bnz8+n?=
 =?us-ascii?Q?gAH6TISxho5TBlmgaM/cnFUjYU91Dbpts3mkTykO3ai/p6w95oUHdUNCS5Q2?=
 =?us-ascii?Q?Cr7io/2tkTuLVCkxE8jLfwLXKoT/Z9rJYIc5TTCSzwGn9B0oKFbvfTUzL82O?=
 =?us-ascii?Q?QAEU3H4/r+vNi7I0nRBgqDBd/N8Bfd5FzqpkUlfNp2D/Lg7NUMSCT6/9udq1?=
 =?us-ascii?Q?uz/f3Z7fjcVKXwBN0KFxQcWrHecuFtsofnzV+pL9KhhCpBddXS7x7mLzefXu?=
 =?us-ascii?Q?6H/soQ2ImIwzuGOgpZq9ShjpfMJ6kTfxR4qM7fJ0UjTbSZYW78K0A0ytVpbd?=
 =?us-ascii?Q?JmYvI7/oYrO2Ct/j4lkLvX6sWwZY3761HAkzaXnD6gPHNkKw9tgOhTPsuDSm?=
 =?us-ascii?Q?jrQ6/hWnFBqAGonKtoYsF/Ywk5mQPgHZbMRxode8voVjmEAcEaf3m88Lsg1G?=
 =?us-ascii?Q?MIhZX3QuKew02U/u7Q47A3/oUeCbNCgP4Cz8UoU3+eWZc5dzN8M3ylZuldxI?=
 =?us-ascii?Q?o936nYwR4DRyrNDrFgGfFbAygK93zQSezTg+eJu2EqQagWIw9JoVsp4cSCTA?=
 =?us-ascii?Q?rny/2m5tQrIZDrtEw8o59j/jJN83yae4joJAXieL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0898f7f-102d-4a80-6e0d-08dabe0aadf8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 02:17:10.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXxMqKiiiINEBHBGvgZjDxePDuYIAieOqC8dc8nPxv7sWxVn3n5JuV4JOfEyQkKNTBqaQuBE/WN6jjp8ug/9CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5946
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:40:08AM -0700, Paul E. McKenney wrote:
> An extremely busy system can delay the clocksource watchdog, so that
> the corresponding too-long bogus-measurement error does not necessarily
> imply an error in the system.  However, a too-short bogus-measurement
> error likely indicates a bug in hardware, firmware or software.
> 
> Therefore, add comments clarifying these bogus-measurement pr_warn()s.

Looks good to me.

Reviewed-by: Feng Tang <feng.tang@intel.com>

> 
> Reported-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Waiman Long <longman@redhat.com>
> ---
>  kernel/time/clocksource.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index dcaf38c062161..3f5317faf891f 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -443,10 +443,12 @@ static void clocksource_watchdog(struct timer_list *unused)
>  		/* Check for bogus measurements. */
>  		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
>  		if (wd_nsec < (wdi >> 2)) {
> +			/* This usually indicates broken timer code or hardware. */
>  			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
>  			continue;
>  		}
>  		if (wd_nsec > (wdi << 2)) {
> +			/* This can happen on busy systems, which can delay the watchdog. */
>  			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
>  			continue;
>  		}
> -- 
> 2.31.1.189.g2e36527f23
> 
