Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B08072F4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243280AbjFNGhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243229AbjFNGh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:37:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D41FD5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686724643; x=1718260643;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bqvSfgCLLLl5ghNLaU/tYA7OntuUY0oXfYm/esadzu8=;
  b=BYR2yIPWpoMJxjjU4TYV1dE3vnIFm1bVLK2j+sd+4i7+/Biy8byEfgHq
   ynqdz35tsBT+qPrNk7j5ASUqWwNnr1A9gMw1Szuerj7Gd76IcO8PrLaCl
   N22Dd91TqDmYoTARpbWi4OBRgGWd+85U2D4d1Erls/GrWlW3+6dWAxVG8
   JdFhrNYYWMV2lJHgo3jsk/c+rT2r5iV4iM+blZFNRd8odh18wLW13xzRh
   T3YpF1VTWFmHdVw6A6aXmmL6Gi/F1uxad+xZpB8o7sOV33K/6xvZqXBGu
   AgNK4VqtF8E+qJoJOFVKmy1GyeDE2tShbjr+3g4BDMc94gG07jaqzAJiV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="386941815"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="386941815"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 23:37:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="856387287"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="856387287"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2023 23:37:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 23:37:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 23:37:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 23:37:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 23:37:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdcO8otINMH2kU6tj+D/VbhWl9Y9iBBsynk/MBpdxs4LQPk3LxhEHRjeb/1htJBk1W+2HMUxX2EKS4cWvrag6X7JVFe/77nY2mesDrFT2x2NM6YkR8dHZ4w7NJmEP+xP6dv82Nse76Boui0aY2UNIm1sR9XSpEyo6oqfdpZ4coV34Y7xQDjTV1Z0z6TCyAcTBGwaQuDuY92Py6JkolCEhDl/QBqW1zShBIkbEj/5hAhrBOJbERjDTiXnotUETw7xgYzNyYvezJfd9FwBka9hxvcNHTjEfAaUstDD6QRa02YKXf1aUx94ECyqhSFduSj69Kxf8mbaebV9fZmQCVWKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFct9IaPPo4J9QR0AExFP5zxOi1dhhmxiUlAgM8VFUA=;
 b=IQa80pZJYfYZIMEtHktpYYb33+xkquzPSPR3fRc0R/P2I2RXTwvP1mbC5xNYsI0vhKSHCSOhJ0qYH2+Jdv8S6rEBBCamhNjWTlVWIQtdBMdrjb2linjL0nen4qXdbrb/XINOkwod0HFVKyzrhu3MD4vCEbtnZ1/pQ7Q1+kyN2E2ZTi8vJSghaSZDk0HObezWbgJutf/c30ZmlHN9bEBvMH3Fd5g0Aa5CflzXEnxIeGEsLNUs2pHSGd8wvA7qmR00OP/KG3+fgzOmj1WRMmk+2QG1XpdFFwQZog9WDkFQiSvv6u5YKj4GtnUngYoqqorug7n05FiS6DLVGdJsQeJZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA0PR11MB7212.namprd11.prod.outlook.com (2603:10b6:208:43e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Wed, 14 Jun
 2023 06:37:20 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 06:37:20 +0000
Date:   Wed, 14 Jun 2023 14:37:03 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "zhangqiao22@huawei.com" <zhangqiao22@huawei.com>
Subject: Re: Reporting a performance regression in sched/fair on Unixbench
 Shell Scripts with commit a53ce18cacb4
Message-ID: <ZIlgD36syo5nGoZI@chenyu5-mobl2.ccr.corp.intel.com>
References: <F4B69136-C13A-4449-9005-4BB0617E60AC@oracle.com>
 <CAKfTPtCBQJYfFgFhA6=364onup2TU1hrTxJYJA5OiSJ_ECB0JA@mail.gmail.com>
 <7C9D3ABF-E878-4B75-9ED6-AD6EFB6243C5@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7C9D3ABF-E878-4B75-9ED6-AD6EFB6243C5@oracle.com>
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA0PR11MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e7254ab-74a3-44d0-98d4-08db6ca1cdce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0G2EWzafXndhOoHqwkYJ5hI3lhG4NUWhYXADRs+ccJh4ngmkQBeBBBqaWxKY5P9GJPbwtdNUet6LW7vJ5yjeuY0i5+6knd5p9OQK0imiuVcMP4K1TsJghKl+KCYpkOTCEk02MR6RwhItIDD+PHlkFQwabBmhZMHaIl477NVH2S85gvFCNJjrN6Go2d1o5en/peacZp+ruxNh7EQtbXprXW8lGlyVXRJNvb/BjxGQPl36CgO7keQbp373yXak+K2f/wYvN66hKSTdL/PBkaesd46T7ow+YesrUoNRW7VpwImEhGF6xI5iaOIE+L6WC2fwZKzQpP3/qXCPauOJDkYCKouYOw2hrlOzc06WufIONoGyQGH/EDh7gbJWMsvrOkCy+E6F3yd/0tcV4unpEAXCmg3qrX7Ig8v3ayFGqjaNm7JXl9SuRmMtuBPvSHYy7Dphn4MUT1nu6tCz9PccW7lvfY6rp4U98qCYVM/RybFoBjWmOtSouNwKIk3+/Hh03ZQ/9jfDe1HXHplua/JBsCq7h9/QCt2wjZYvD4egHU2n3mgjTODcDU5CWFW7MHM/5agNUm2q0gevxBr2/Y34oQjBRWRgnRNlWGIk0EcJ1Akh7MM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(186003)(6916009)(6506007)(26005)(53546011)(6512007)(86362001)(82960400001)(38100700002)(83380400001)(84970400001)(6486002)(6666004)(54906003)(19627235002)(41300700001)(478600001)(8936002)(5660300002)(316002)(8676002)(4326008)(2906002)(66476007)(66946007)(66556008)(98903001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ampad1hmZ0lsb1V3cnp5czkwM3hOaXA3TkdpRnlxYUZTeTk3SXcrK2VNTmdy?=
 =?utf-8?B?cUdaUUJlMjZKaGRsZkJkZXd0NHVLdzV4alY2WjBWOGwxN283ZElROFZMY2lx?=
 =?utf-8?B?ZE1uVWhYeEJpeFNOSDF3WGxqeElYVHFxNkJyajBTdE5CME1keGtaOWN0UnA0?=
 =?utf-8?B?TzJIY2lFc25TaGxoaEd3RWdpYkJmOUU4c2huekU3RCs1NFRoU1QwYW9wV2hN?=
 =?utf-8?B?RStRMElPODNCdVQwZ3RaRmsvS2F5am9mWFI1UVlnQzI2YW0rQ09kQ1pVVUNW?=
 =?utf-8?B?M09CYlpZWGFXZUVRYTZnU2VuS1pJNFNqWS9sSzYzaUNJRmh1UVY5K0xzQks0?=
 =?utf-8?B?cTBWODRMWVV6RzkvaEtVWVNPYkVCZmZoWDN3aFRVR1d5NkpTVThsTUpjcHdO?=
 =?utf-8?B?VWphVk1rbUQ4dnQwaTgwM0srUHFiLytTZUZWVmhDTGwzMXdYWUE1dW5lQnF5?=
 =?utf-8?B?clJkUi8xaHNIVjA2cDc3NzdoU3h1aUNTdENla3JFMmErMGhwd1Fnd1l2UmxQ?=
 =?utf-8?B?ZWtXcWtiOGdqSEdRc2hxVlpQLzUwMkhEUWl2clJvWFdNZGdLODI0TEorYVY0?=
 =?utf-8?B?MVpYN3QxTVE5WU03OXU2L2swRm11dTgzTWV3Mit5eWo3Z1R6a3lxM3ZQVm9s?=
 =?utf-8?B?ZWFiTk5rc1BGUHJPMHJkUnZsNTRmZkxzeFdYUXpsTEFvcHVEME9kT0kwRmw3?=
 =?utf-8?B?c1l3NWVJQjViZEJYOEFUSWMrTWJralNKclhHY0JXc09Gd2liRFpBZXdtWmNH?=
 =?utf-8?B?anpGOG5EQ2Z2TlF6WmlCRmxnakpVMFNsb3F1cmxJUExrQkhnanU2d3BoSjAz?=
 =?utf-8?B?VXFRRVpoNVdUSHZZYkc2TDlRMWJHQnc5OXpGMGZhNmtJWEZhR3FEamdzd2pI?=
 =?utf-8?B?SEgranN0azRGTCtENDcwN0V5OWFxaTB0Y2taSWlURWdoRk1hcXRTVnJCbFFq?=
 =?utf-8?B?QmNybXVwZFowQ1FmNHY4QWdzV3JXMmFablFrZEVSKzFXSzliKzZUSU1KZHBm?=
 =?utf-8?B?YjR4b3UwOU9FbUFpc0tBZEN3b0VlVVNFMTFDYXAzQ3RvcW1GaXN2VkkvdzZI?=
 =?utf-8?B?Y28yMW1kMXNFUmtETGlpQ3BXOFFPQmZuN0U3Nk1KK3hHU09tYTVMZUtBQm1k?=
 =?utf-8?B?ekhEb2hTYk1vUXZ0MjY4YlZzT3lIVDlRY1F5QVZkVUl1NWcxYlpnMEc3ejNu?=
 =?utf-8?B?eVRVQkxCWEg0L3VSa0lYZnppT21UYytKcE1VSHNhbkVqSWw2eHEzWFlZdEd5?=
 =?utf-8?B?bzZtSk4wS1NuckxXUi9hZGg4NTZOK2M4UmFCaXRPMm9Sek9UaFJSYmVISkl3?=
 =?utf-8?B?VlR3SlRpeGw1a0pObTl2d1ZhS0xHWCt5QzFsTFY4N3VQc3BUYVp3R0NXcCtM?=
 =?utf-8?B?MjlMbjBWUFptb0k0azJrVFYwcXZkUFhqZ3dKK01Wd0NTbjlxR2NNaFhNZjJT?=
 =?utf-8?B?NldCZGFjUm5TZml0K1JvSVhWTjZGeW9GZ2JvWVlpWHlGdENrWkpMVldCUVhy?=
 =?utf-8?B?NVRicThFcGxHajJiaEtQTmpOZTFkdEZucE9nbU1scXNHOUFvc0hKcW82ekJD?=
 =?utf-8?B?VWNoWkVQZWt4Y3V5M3hxQ3ZJaU93U0tCeHRqUTU0aWN2ZnNYS21yeUJmZnNI?=
 =?utf-8?B?bWw1YkRWZ3U4b2dmZnhYZ3FXOWtPNnBBeUxSRm5PQk9Bb3BJVm1yUXpmbFJz?=
 =?utf-8?B?dWJuaHdFYnY2bnJESEdORFZxeFNpT2pFMFdPbWpwSjRNR3lvazdZSVRlMFky?=
 =?utf-8?B?U05Ra1FnY3R6ZFJ4TjFIZGdTanB5UzR5VUZpL1QzN09hTUxaRmlVTXZkRHVy?=
 =?utf-8?B?N1d2Vm4xRGNiK3ZjM0NUejF4d0FSeTY4clpIKzNVQ2pyNkIxcHYzTmlNSzZ1?=
 =?utf-8?B?T2xEbVpEb1BwSk5aVlArc3d5NENZT1h4TFZmL2IzbTlmeHA0L2VIU3c2dWM1?=
 =?utf-8?B?ZndkVGpnakhhdjRWUUN0VmJiNThDMlFVOVRZQkp4dCs4WDhZQlZsOVYrUHh4?=
 =?utf-8?B?MGU2RE9kUm54NFZuamQ0UlZiQnI1V0daV21KdlFIeXlwWi9JdndTNDJtbmxn?=
 =?utf-8?B?ZHA3MkZBUzlSeHdJSUFvU3dFNnlMNVNWM2p5aGpzYnBxbmtoTmVCV3k2bHMz?=
 =?utf-8?Q?PSXc0W/7THv1tPL4iiXkNHEyV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7254ab-74a3-44d0-98d4-08db6ca1cdce
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 06:37:20.2827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enPdMzVL5oOr97ommemRUgztD93hK/A1ZMBeBVMV0dqe5bcWDd4xkfB9iypb4FNpg1UziP/RdmvnVIT9Y9aRpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7212
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-13 at 19:35:55 +0000, Saeed Mirzamohammadi wrote:
> Hi Vincent,
> 
> > On Jun 9, 2023, at 9:52 AM, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> > 
> > Hi Saeed,
> > 
> > On Fri, 9 Jun 2023 at 00:48, Saeed Mirzamohammadi
> > <saeed.mirzamohammadi@oracle.com> wrote:
> >> 
> >> Hi all,
> >> 
> >> I’m reporting a regression of up to 8% with Unixbench Shell Scripts benchmarks after the following commit:
> >> 
> >> Commit Data:
> >> commit-id        : a53ce18cacb477dd0513c607f187d16f0fa96f71
> >> subject          : sched/fair: Sanitize vruntime of entity being migrated
> >> author           : vincent.guittot@linaro.org
> >> author date      : 2023-03-17 16:08:10
> >> 
> >> 
> >> We have observed this on our v5.4 and v4.14 kernel and not yet tested 5.15 but I expect the same.
> > 
> > It would be good to confirm that the regression is present on v6.3
> > where the patch has been merged originally.  It can be that there is
> > hidden dependency with other patches introduced since v5.4
> 
> Regression is present on v6.3 as well, examples:
> ub_gcc_224copies_Shell_Scripts_8_concurrent: ~6%
> ub_gcc_224copies_Shell_Scripts_16_concurrent: ~8%
> ub_gcc_448copies_Shell_Scripts_1_concurrent: ~2%
> > 
> > 
> >> 
> >> ub_gcc_1copy_Shell_Scripts_1_concurrent  :  -0.01%
> >> ub_gcc_1copy_Shell_Scripts_8_concurrent  :  -0.1%
> >> ub_gcc_1copy_Shell_Scripts_16_concurrent  :  -0.12%%
> >> ub_gcc_56copies_Shell_Scripts_1_concurrent  :  -2.29%%
> >> ub_gcc_56copies_Shell_Scripts_8_concurrent  :  -4.22%
> >> ub_gcc_56copies_Shell_Scripts_16_concurrent  :  -4.23%
> >> ub_gcc_224copies_Shell_Scripts_1_concurrent  :  -5.54%
> >> ub_gcc_224copies_Shell_Scripts_8_concurrent  :  -8%
> >> ub_gcc_224copies_Shell_Scripts_16_concurrent  :  -7.05%
> >> ub_gcc_448copies_Shell_Scripts_1_concurrent  :  -6.4%
> >> ub_gcc_448copies_Shell_Scripts_8_concurrent  :  -8.35%
> >> ub_gcc_448copies_Shell_Scripts_16_concurrent  :  -7.09%
> >> 
> >> Link to unixbench:
> >> github.com/kdlucas/byte-unixbench
> > 
> > I tried to reproduce the problem with v6.3 on my system but I don't
> > see any difference with or without the patch
> > 
> > Do you have more details on your setup ? number of cpu and topology ?
> > 
> model name	: Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz
> 
> Topology:
> node   0   1 
>   0:  10  21 
>   1:  21  10 
> 
> Architecture:          x86_64
> CPU op-mode(s):        32-bit, 64-bit
> CPU(s):                56
> On-line CPU(s) list:   0-55
> Thread(s) per core:    2
> Core(s) per socket:    14
> Socket(s):             2
> NUMA node(s):          2
>
Tested on a similar platform E5-2697 v2 @ 2.70GHz which has 2 nodes,
24 cores/48 CPUs in total, however I could not reproduce the issue.
Since the regression was reported mainly against 224 and 448 copies case
on your platform, I tested unixbench shell1 with 4 x 48 = 192 copies.


a53ce18cacb477dd 213acadd21a080fc8cda8eebe6d
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
     21304            +0.5%      21420        unixbench.score
    632.43            +0.0%     632.44        unixbench.time.elapsed_time
    632.43            +0.0%     632.44        unixbench.time.elapsed_time.max
  11837046            -4.7%   11277727        unixbench.time.involuntary_context_switches
    864713            +0.1%     865914        unixbench.time.major_page_faults
      9600            +4.0%       9984        unixbench.time.maximum_resident_set_size
 8.433e+08            +0.6%   8.48e+08        unixbench.time.minor_page_faults
      4096            +0.0%       4096        unixbench.time.page_size
      3741            +1.1%       3783        unixbench.time.percent_of_cpu_this_job_got
     18341            +1.3%      18572        unixbench.time.system_time
      5323            +0.6%       5353        unixbench.time.user_time
  78197044            -3.1%   75791701        unixbench.time.voluntary_context_switches
  57178573            +0.4%   57399061        unixbench.workload

There is no much difference with a53ce18cacb477dd applied or not.





a2e90611b9f425ad 829c1651e9c4a6f78398d3e6765
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
     19985            +8.6%      21697        unixbench.score
    632.64            -0.0%     632.53        unixbench.time.elapsed_time
    632.64            -0.0%     632.53        unixbench.time.elapsed_time.max
  11453985            +3.7%   11880259        unixbench.time.involuntary_context_switches
    818996            +3.1%     844681        unixbench.time.major_page_faults
      9600            +0.0%       9600        unixbench.time.maximum_resident_set_size
 7.911e+08            +8.4%  8.575e+08        unixbench.time.minor_page_faults
      4096            +0.0%       4096        unixbench.time.page_size
      3767            -0.4%       3752        unixbench.time.percent_of_cpu_this_job_got
     18873            -2.4%      18423        unixbench.time.system_time
      4960            +7.1%       5313        unixbench.time.user_time
  75436000           +10.8%   83581483        unixbench.time.voluntary_context_switches
  53553404            +8.7%   58235303        unixbench.workload

Previously with 829c1651e9c4a6f introduced, there is 8.6% improvement. And this improvement
remains with a53ce18cacb477dd applied.

Can you send the full test script so I can have a try locally?

thanks,
Chenyu
