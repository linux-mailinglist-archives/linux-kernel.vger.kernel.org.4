Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0091D63CF13
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 07:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiK3GD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 01:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK3GDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 01:03:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C38748FD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669788203; x=1701324203;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0G2HLMS5AKWRUUsBVtKQPllJAB1xsfZXQtvrKl9nsHA=;
  b=ipe3SNxO2yh5N5dJaCwqFiYPRKRAz2aH423Z4WMZq2LYCPpxEFSR5VwU
   4Pj+KOxMVd2jznrKxMsjz68Y3Kla8pXXG9Okj0hPbGSCtwDOcCa8dCqt/
   tHQsGXi/xdWsHpGyd4XVW8qQMk0CmLvSci80FOgpHm5xZ8g+RIPpemJzm
   jC263SONWpv5jHX/cDQMH1+a4y9WzidJq8K6NK1rzhhF8d/1CVb2i9kEo
   BjkqriIZEQVbp3aAPHL2fxi8OtlFd0jTvVlnHmoKdgdJdEyk75QfTn5fa
   02eFqCUDj+gsNui8bnA55FBoNQ42kn7TGneKtiK8MtXkOCpTDwH13UP0N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342237066"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="342237066"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 22:03:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="818509425"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="818509425"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2022 22:03:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 22:03:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 22:03:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 22:03:20 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 22:03:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meTuuyZfi6kc1aMG+jhm5ppeHCEK4DBAu1SfHPACpZ7OIEgaLmPGgIJuA7Sivk23RGP7hUTU+8B27BaVpOr16/mUCUwOq6M577CgK7Gf1GHA8nUKvz+adsGwa1IV2XZyZZBHx/v6scKddM1uvlqPanKWpEBxHub9M+WNlbnPiDBErI4XFukv6akytIInPWfDrCPisPq29MGTPbsqlKCr/QBdBTTHn+xyxZE/w/iSDwzXdYrDEEz9NQnY6Uu5NCbch6ssb7EAGNaWRxmsCSvhmSC62rezhc5LYoD8H/Cp0849iSj4OTJYZYsqOI69PFiVAIbkaCQ6RlTBZUTFV4JGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzcgVp9d3dPiRF/AEgZpv6b8iKUnkdMDrgvEsW87Kp4=;
 b=Ia80IGEwBiRFMClh/60+otsxtFWGSY0FHfoL3eyamJZBLvDsSlySIddiqRsdWph4x6jDUVIaaAe/1XnYXuNsBMAPerJLtOghF2mQb2Ce//pUVb6Q9dVRXA99Xx2pVJIVBwzZj8yNL1emlbvpjlhTUPAUXjyPHy+m1wo8c6LWl4zAXQZ2x5T2AuW0oRFSjPd64jFIZbo7Nco0E8w1uIfoSg6EYO3mpmXtkuO91kx+gvYcDyme7KncP2cz4Y4Jw16gleWV6ayuQU/Rwxa0z2D1JtpZrKIe1apKJ7HumuXTshrBXWSr/pOQLtcH2+Kmq/aLxVI5zXdqk1GHA3Cpc0w0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:03:16 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%6]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 06:03:10 +0000
Date:   Wed, 30 Nov 2022 14:00:04 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <sboyd@kernel.org>,
        <corbet@lwn.net>, <Mark.Rutland@arm.com>, <maz@kernel.org>,
        <kernel-team@meta.com>, <ak@linux.intel.com>,
        <zhengjun.xing@intel.com>, Chris Mason <clm@meta.com>,
        John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
Message-ID: <Y4bxZCEAmPnALsRV@feng-clx>
References: <Y32HFE+BaATh9+l/@feng-clx>
 <20221123212348.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4QZzzk+FdGj4AXm@feng-clx>
 <20221129192915.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4az+FT5YjpAWjZc@feng-clx>
 <20221130041206.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4bg1H/HLRLfucNO@feng-clx>
 <20221130051600.GL4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4brjD/xUDlzJ4v7@feng-clx>
 <20221130055024.GM4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221130055024.GM4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|BN0PR11MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: ad43044e-b93f-41f4-62ae-08dad2988eb4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZdrHmSVuLwkI6r6Mm2VdgglcA/nhJi0LtXdFCK/SpnoP+o76A/0dXGd2eijq1Fa1wK0hn0t1bj7HIIjUwNSvdHDABhO2MREeikKX8badBqW7qiYBFcQb9OTchtHqQMUYQJfer6MCkn3NEgZROysBfuJEAoDzhZn9d5dtljM5tzZwgdwAaDkuS7ysmTG92EqnhcumuT+8NRpsrgVTKGmD/nfqau115CbAxvMKe88GnqGvIF91Pkl96+sbF0tXPwNmJ2BP5U3UbcaTyL+ZAN4oqMwoN97dRqsGjK43x9RvFIuc+ErdYj9tuxS7ESBqV1EDoVkBN4+gr/AZNmKMIRSpNbF+o8HHtGDUYb4DNpj5f9k8IAA5WpMWyBDrPNRLZw/+n2QyknIgteK/5lOu57D/3ZqbK73OptWO15C7dCpZD43BNFrSB/kYBc63lfmTqP49WHNo/2pv7WLAakZVEF/yw244CUOhcxbMG+aiaSNKP6u3UNtQyzkx4vv/8efAii5ZATm3//+Y+UY5jZBsD4N05DOBhvYcuaXKNhhTI32MMxai2/5GgSZxWWGURWEFcw4Tg9D0ATHPC/DL6QK4rGkAU6eCAPIBB5m5KfGAPGHowUaQjVJCcxgo/7EMJfRKti/R1hVYseTa7dkSFhm5CMYOlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199015)(6512007)(8936002)(26005)(186003)(54906003)(6916009)(316002)(478600001)(9686003)(6666004)(6506007)(6486002)(38100700002)(86362001)(82960400001)(33716001)(5660300002)(83380400001)(7416002)(2906002)(4326008)(44832011)(66556008)(8676002)(66946007)(66476007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QndkTU9Bc0lFdWpHZitpTngvUHJpSk5xbVpBREM2OHliYUh4UEQ3NFdISTk5?=
 =?utf-8?B?c2hkRjF4d1A3QmJpVkFxRHEvdWJGb1ZjK1E0ZHFNMXZKT29aYStEMUJUSFU4?=
 =?utf-8?B?RGMrSEV4UDVneDBub0JnVldvWFVFdGxlRHJQUURhYm1HQ0xLU2RTRFY2Yi9F?=
 =?utf-8?B?cm5EbHVjNG9wdFJ6dkxlT3hMdlFnNGtqS0gzdzBoci8yWHpBZmZIeGpzdW0x?=
 =?utf-8?B?b3pra1R4M1A0ZlN0c3hidTQxTzhTQWJybWsrMlIzS1RWdlZVaGx3ODh3em9u?=
 =?utf-8?B?UUpxbXpod3pHWjNTSytCQlNOWW1CQzBNY2h4MitSKy9senNCYUE5R0E0Qkt5?=
 =?utf-8?B?SWRLNXArRkkySGNoVGhpTDJhK3l1RHVxK1paU2NKUG01MDVKdTRPaDgxd1V4?=
 =?utf-8?B?TU5GNmdKaG9mY0tObTM2OUllNUI0YThFZXpCU3VvdDlTQW9uVCtHQjNabTRY?=
 =?utf-8?B?UjQ5NnhJMnhqeFdpSnBxL2NUVDgvNGo2SkwvNXIyekFCK0g0Yjd1TjROakth?=
 =?utf-8?B?VG5Zd251c05KVkIvYjU3TGw2L1gzK1ZBY1NmWW9FRjRJS0R0Mm1vcjhmNHZ2?=
 =?utf-8?B?a1grNnAvRmZKR3E2NGVTODZrelF0VFNJMG04dUNnNkIyRkgwQVpYV1VVODlQ?=
 =?utf-8?B?UjNZM3doY2w4bXN0V2tHMisxWWRtRVQvSVZPMVhKcHN4WmxsQzdPd3NXaUkv?=
 =?utf-8?B?cWx4QmJtZFNNaWdXVGEyRk1PMEdqcEZMb0V3cC8xaGdKM3gvV2l2b1czZld6?=
 =?utf-8?B?dzh3cFgyQVBnM2duRHJLWlJwcCtvV3RvZ2RtY0pBR3lQdjJ6NVhNT2QrQmpS?=
 =?utf-8?B?UG5Xamx0OU9zYkdwZW8wMUptdkJaWXFkK05vOFlWU3VKTytXWnlLYVdscWZI?=
 =?utf-8?B?YTZVZGkyOGdzNW94QWJSUkc2WWU1STRUMkVVU3N0REt2L2NvV3hqcXJ2eFhu?=
 =?utf-8?B?dUI4a3RJUEc1b2UxdWtlRExFTytMQ2tjcXlud1J2Y09za0RzdVAxRUM2TS9C?=
 =?utf-8?B?SHhwdk42UHMzOXcyZVdyemZjbitRQUpVK2Vpd2ZaL082N3gvbjJva1pPODNM?=
 =?utf-8?B?d2tGNngwYjJTQ2ppRVFFY0haV2hnOGNhSnRXNVNjK1JXQ1RrQ1VxRVYrbUJo?=
 =?utf-8?B?WTRRZndnWWdDS0Q3Mk9nLzlaVVdtY1lNU0hEVVpjL0l6UXd4ampiOXpRR0VD?=
 =?utf-8?B?SWxmRnZOV3V4ZWpQQVljVGNVNU9YdXhZcTZNT1crdGpFZHM0Qkx5NDdKekVZ?=
 =?utf-8?B?UjFQOWxxWXlRYnJFUEhmN1Z0a2E3VzJySmJTL1lCZXJGcDVLYkhxNWF1bGhm?=
 =?utf-8?B?cGt2MlVPb0gzajdZWEJ2T2tRa3ZEQTI2V1dKbDh1K0xtOHM5MzFyUnhIRG93?=
 =?utf-8?B?TmNaK2JnU1JvK0dvR1hzM01qRHhvaG5NdnFIc282NFBxRGdZN2ZXUUVZM1U2?=
 =?utf-8?B?ajZudm9BeEJWZFp0dFNIdG1PV3FxbElyU2Voay9lYjVIUkFwcjNyWElFOXQ4?=
 =?utf-8?B?V2NzZGtZZER4b2hVN2tEN1N3NUVJVXAveGdHaUk1eUJZYW9ZU3Vtb2pCcm9D?=
 =?utf-8?B?Q0pjeDIySmZVYjBuMGo0VDI2VXVOeHBmZTN3V1JqajNGZzZPUXRzZ2FsbDBu?=
 =?utf-8?B?VVhtTzQvdjVzN2xMSkN1dHQxQ3V1UC9vVWljVy9CS25Tdm9KZ3NzOEpkSFky?=
 =?utf-8?B?N3k4aXBtN2h6aUd3U0doRW83SXgxRTJlekNqaitCL1dXQVB3QlJWM1NMUzJU?=
 =?utf-8?B?UUJnUEtOdW12cVRFM0gzOFlLMlJ0WFZwN1l4aldqVms3Y3ZuQS9mR1AxdlIy?=
 =?utf-8?B?WHlBM0pBOVF3Z25YYk5MWDdqMTMyQkdDeStsQUFReFczQnRkRi9TMlFVTHVE?=
 =?utf-8?B?V3NhdWhYMVlRUjFKb0ovR25ObWJxaFpoTVBYdjIwR2h0Qm9FUUFraUJ5QW9i?=
 =?utf-8?B?SGNCVlBMMUwrdlh4QUFNcVZ6VzltOTBxcUZQTXAzLzdYbzV4OElKcTV2U2dP?=
 =?utf-8?B?UXVrUm1iNU13M2U4Umc5THZ0cDEyYlNndWlQVjRvYTNVeXo1VGFoTWVMVFk2?=
 =?utf-8?B?eVFwWElqMGpHWlArZEJWQmJobTI0aDVkUDhYVkgxMVBvNlJhUlFXZGNBSDNU?=
 =?utf-8?Q?FRfMKXWkmuvrQqO9uNoIVVPzb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad43044e-b93f-41f4-62ae-08dad2988eb4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:03:09.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZIub1DtjJ97KQKccKBVTCbKX1PaI50I0tVtPIi5Q1Rqdugstf252irIDG8SC2eEKoXmu3EIrdFyjR9LhxLF1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5709
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 09:50:24PM -0800, Paul E. McKenney wrote:
[...]
> >  
> > Great! As both HPET and PM_TIMER get the same calibration 1975.000 MHz,
> > and it matches the 40ms drift per second you mentioned earlier, this
> > seems like the CPUID(0x15) gave the wrong frequence number.
> > 
> > Or unlikely, HPET and PM_TIMER are driven by the same circuit source,
> > which has deviation.
> > 
> > Either way, I think the HW/FW could have some problem.
> 
> And this time with your printk()s:
> 
> [    0.000000] tsc: using CPUID[0x15] crystal_khz= 24000 kHz ebx=158 eax=2
> [    0.000000] tsc: Detected 1900.000 MHz processor
> [    0.000000] tsc: Detected 1896.000 MHz TSC
> [    5.268858] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [   25.706231] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> [   32.223011] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [   57.823933] clocksource: Switched to clocksource tsc-early
> [   58.144840] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [   63.613713] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> [   63.637323] clocksource: Switched to clocksource tsc
> [   64.673579] tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> [   64.703719] tsc: Previous calibrated TSC freq:        1896.000 MHz
> [   64.716816] tsc: TSC freq recalibrated by [PM_TIMER]:         1974.999 MHz

This confirms the tsc frequency is calculated from CPUID(0x15).

> What would be good next steps to check up on the hardware and firmware?

Maybe raise it to vendor? I have no idea how to check thos black boxes :)


> (My next step involves a pillow, but will follow up tomorrow morning
> Pacific Time.)
 
Really thanks for checking this through late night!

Thanks,
Feng

> 							Thanx, Paul
