Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6746BBD21
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjCOTWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjCOTWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:22:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7869B2CC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678908157; x=1710444157;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uep+zaG5R0unC1YrMIOBxmS3zGYO2BVuqNokvh43sDM=;
  b=VOTLmo2VSYFKS8scOiaU3nMo6GBKnq3lhDiL4bT5ivC2rKDr87st/85T
   178NmHT3XHKsv4Of6clT6vlqPdUZm3Kvq5mzG20TofzKjuKbeoYzFR9Ur
   pqcp8T/AW6jT7NISMseK4wFYBjDhhuwqStAil2iTZWbiuoLpz/bg5oZ8t
   2Q5PnC9Kbn29+CbbXCdrCqkiQqnuOHPnyHibxi1K7Mz/CCURAdCZtp7Bq
   xjTFt5ihuzLBLNN0GfpdO159gl3e0HQOl48UNmvyN9nsIhcTYywGru/4k
   udYyw82kGoN7tqvhluMAdNg21Gi5J0DAEyUL0emVmLRBjSb3jEUGf++3h
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="339341339"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="339341339"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 12:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="709788579"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="709788579"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2023 12:22:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 12:22:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 12:22:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 12:22:36 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 12:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAstlaaxM6UF3ZAA7978sUVf8dXHoV7bgV7uMt0kpKZcsgEnYB4h6VE3/TtYpb0X6PpKsAkiW7k+QJVJ49fp3ocNp1dXF/Jgas2BTeoN7E0K2XvpSGTb3SysKnO6VrHzY3Gvh3TFUNbwuydidsii/QLixaJLOwQO+NLGVWp8GIir+IH+ScLLcTs4zRkJNFmNM4CZcu5GjzSpEpcTdUGH1srwDmlGoe2lZdmx3IEfyHluT1z/+5u5MBDajjbZa00t0EDpqVafZI+ZulkIsDW3TnYLHfr0ksqjhMVcFpSN0A/wtuX5UfCRFiecKLXgTT9ED4ELWXNrCoTYD7+15kEzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3/y6jZ5dleoHjq6C5P3P3kEXMixIJpEMp1rqb40Zbw=;
 b=Ml1+NNcGGR2TbdThhwT6aWr6mI7ailKzIzsC7KNklJESSkdibWM21y03vMt6xTRrD9ycia9CmI2ojOiUD+f3pAAuUjWC6cZJ8JbLF2tYYevj8ZJvGlzCBVRDjeQ1RVSxyTQNG8ADJQp2lePi1KUCD9fJC4W36YJYH0ZWXL51mgI6tNsGumL6Qut0+nCOXmoC5JcT6mQOxyOtPdT4iOpkrkHfedEK2ACPU+gv/FtXKtW3b3Wiik6wrDyme2QkGByBrXb1BCI/rlaWprO5iAG/g1WFi0knW4J5Zky5o0ck3kNvPlsjaTf5DcYjCnUuqDl/5qciaCukm+0NJ4fzz6ss7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5552.namprd11.prod.outlook.com (2603:10b6:5:399::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 19:22:32 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Wed, 15 Mar 2023
 19:22:32 +0000
Date:   Wed, 15 Mar 2023 12:22:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
CC:     <gregkh@linuxfoundation.org>, <outreachy@lists.linux.dev>,
        <martyn@welchs.me.uk>, <manohar.vanga@gmail.com>,
        <zoo868e@gmail.com>, <jerrykang026@gmail.com>,
        <cuigaosheng1@huawei.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
Subject: Re: [PATCH v2 2/2] staging: vme_user: remove unnecessary blank lines
Message-ID: <64121af3e399e_253a1e294a2@iweiny-mobl.notmuch>
References: <4bdfd864b573c164df30ec738afc93b06ce0d573.1678887330.git.eng.mennamahmoud.mm@gmail.com>
 <15b80b699315993d7f0da638f805446f6dc0b480.1678887330.git.eng.mennamahmoud.mm@gmail.com>
 <dcd9b79-bbd5-f160-317b-7fdd6ca6fc64@inria.fr>
 <b37352ef-959e-d950-c0c6-32e1c7268b79@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b37352ef-959e-d950-c0c6-32e1c7268b79@gmail.com>
X-ClientProxiedBy: BYAPR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::44) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5552:EE_
X-MS-Office365-Filtering-Correlation-Id: d690d6b5-79cf-478c-3128-08db258a9fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Q1jHjEe4cW6p027OcwkqfMrvTkQa4xHJ81D9aauWGeyAhKdk/fGdvSvkHl1Bwb0VX26+udaspjRQ1w5PjJZiAzRZHFugathtn8W+aC3GC97sZBJKqCsf/uk4VpEIbZx83gE2h+tHa1SUNQnKPe+QKqWMZG9WhyuuO4GX8PZRlgKytHFSktc8G51e5Ld164ACydilAZlL1iEa2ucsKTup/QB69YkTbW4OOoWlrJ3gjYJ8uyhnnRa2Ob+rBngE8/20oJ9/m5Ayawrj/PQmqR0YtF0PM+jLHBs+S+yBO0sWjVEsFKqUJcDj+GEX0Q667SlCGMBXJFBU7Hu4t8SL41sLsEYvuiLlboYeOP/gqz/GtwAfLnbcnCfAKq4O+4LPLWVRfdwjo1j3BNcxdsDo3tITS/nrUQyggIUpiA08cfLVDALiTSpWCclmUi/DWPtJtuNusBdrPA9TuF5sOpHoGJ9SDk1PRqr7yJaRRXkHPSg+130AGRXjOMIsHEireakMKga8vdSDwrqFzWvSUddrj5pyF1H3GBClIAfPJAqMkWB2a47eMH/GSSUJWCxpVHh1VgxXN/d8MeGe4PHjssu4GIPzJcsi9YLooP1x8XMOIb4rfD6oBStGlt5wGFUMTjKJ2jp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199018)(66946007)(66556008)(4326008)(66476007)(8676002)(5660300002)(7416002)(110136005)(316002)(38100700002)(2906002)(8936002)(44832011)(41300700001)(82960400001)(478600001)(83380400001)(6486002)(186003)(86362001)(966005)(6506007)(26005)(6666004)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmlEaDZEcU9BOE13aktud0VGcHd6V1U0UkRKd2FQQ0dRK1lZSnhCdkdqdnlp?=
 =?utf-8?B?YnhLc0dQVWE3WWlLT0NnRGxRSmRjZ2d1UDZIQ3NsNnllSVhhT0dITkJOYjB5?=
 =?utf-8?B?S21jUVFZczFPbkdWODJVekRtQlVHSHFUYXl0YTFhTDlXWE5KVlh1elJWclFJ?=
 =?utf-8?B?RitnN2ZvaXhyS1g3TEIrTHoralJXQ1RZMHJMTVN1MWZDVGVZQWZmNGM2M1Ar?=
 =?utf-8?B?N0UyZjZhV0hBckpKWThFNE96ZTdGWklxaVo3djJqb3RTSDVqRi9lb01qOXV1?=
 =?utf-8?B?cjA0QnVWVXhWckpnaE92bXQ3ZUJHQVcrUkhYMk50TEVSamNLTHhVOHU0L29T?=
 =?utf-8?B?eDJvVHNpdDdoYWs5V2hENHRMSVRadFl6V293Q3N0RDVJU2l5UGNaWCtQVGhu?=
 =?utf-8?B?bXBJL2VkN3VPSHQyWE1zQnIrSUk2RjM5SXAwZW9TWG4weWc4OHlVKzViRWpq?=
 =?utf-8?B?N09WVGlweTZlUFNuTm1IRWZ2dUJTSUsxc2huay9WSHY2Yk5kWFhodXhENG9p?=
 =?utf-8?B?RUhtVU9hTEUwOHd5czlQWFZuU1BqZmxKMlQwdTRjQ1RFWE1TWmZpWDloZ2FL?=
 =?utf-8?B?Um5Uc0NkMlJPY0dGVVBLdSs4b0I5M3kyZWl4OXR5VFQzYVNLQ1ZYa2dmTjh2?=
 =?utf-8?B?aHdUUm9qcHRtUmlhTUVqd2EzT09kSlU4ZFdUdm1iZzUyUXlJdkE5YkVsalcw?=
 =?utf-8?B?Unh6RG5PRUhYRkp3ZllqYW4wN21RMm9lRitsN2JJaHZRckQxdDNiQzhocXJ4?=
 =?utf-8?B?c3kwTjdka0ZtWDdJKzNBaDlCYWNTaFF2cTlCeC9zV0w0dmIxeTM5dlg5ajY2?=
 =?utf-8?B?alg4Wi81OXBKbVdSOGFRQWxZUmc2QzR6TnMxb1l3RlBSbEJQZUNZdEtTQWlW?=
 =?utf-8?B?citxZ05UdEFrYzZuSUFYOTZYVmFJbWNEc0JwRklBalBNZUJlcGFCN2Fuay8w?=
 =?utf-8?B?RkxaTm5PVzl0UjZFTVN2enJOL0hhRVU2ck43N1hud1hmTTdpUUc5NC8wOCs0?=
 =?utf-8?B?Qm4xWXNvUDJNQXRRTEVCYlZuTXpXRVhHeGQvN1pBWHdWb1FYTFFLMVc2cjI3?=
 =?utf-8?B?V0Y4bkZ5dWFtMW9lUzJ4ZzNWZCs0YTR5RWZCSE14T3c1V1c2NmZuVHZWQnB4?=
 =?utf-8?B?dm1jamhERGpSL1d5cVlCUWhMazJoZkx6Y1VidW5udHQvd29uejNRQmFEc1Bi?=
 =?utf-8?B?NWd3SjdOaXVWaFRPK2ZVem5ZZ3F2d21yMm9xSUtOWGg5c0JDc3RGc1FUVTZw?=
 =?utf-8?B?QTJnVGY5bStpVE1CUVVMdmhvZnF1aWVHRWEzV2t5SmdlbkhKcFZNWGEwMDM5?=
 =?utf-8?B?WTIvZk9rWFBOTnRNODNSbEI1OGdFcG94bSs2SHRjcmptcDF0VlBnWFAyMVVM?=
 =?utf-8?B?MXlnN3dKbEFGblpHaTBPYTJNcXNJS2VjUzFGMXNTeE9SbTZsM2llYlpCWEN5?=
 =?utf-8?B?SE9XVTliT3FCWGMyUnpadzZNVG15VlRaM0JMWUVNeWhMT3FBUkV2SUxRZFlP?=
 =?utf-8?B?dW9zT2lJTlhuVThEdW9VenovVjFLSHdiaVhoLy81WTZaanlTSE5yVmlzVkgx?=
 =?utf-8?B?eHBCSjNRVG1ZMDBkamtRbElvVkFvZGV6R2RsWEp4M3I1TUkxNXVOQWd2TTR5?=
 =?utf-8?B?b1N5WTdhQTNHOE92Y0dHMnVyQkZmUXRyT2kxTzFaVi9mbE9vNHZURGdoeHh5?=
 =?utf-8?B?MWtkNjNEQ0JlK1pBMzl2MmorbUFJQkROWVRMRTROdWpTWHk2VElldTVxTWVs?=
 =?utf-8?B?MUFHQlZ1YVlkc1ZLN3VXZ0xOdFQ3ZlM5cVp0RFl0VnBRZFN3VUFCVzBqTndj?=
 =?utf-8?B?dytTUHdyZW1MWGErd29GRnUwUVlTVGVuMzFOVi9tdHRxTDAwODBnWTR1TGh0?=
 =?utf-8?B?UzZWemFkM2JKSVlmd3o1RGQralF1N2ZOYk9CSk1scno5U3lBNnFmMXdEbzVR?=
 =?utf-8?B?TG5zSTExR1hna3A4RHlBZVZIaldiQlJSY1cxSVZpUUllTkJRVTA5Tk13Z1Nv?=
 =?utf-8?B?eWJaaWd6NUtSOXpmSnVpUjh4cjRBSFVnM1lQN1dReWd1UU94MkFNam9VM0xq?=
 =?utf-8?B?czdlVVBZT2hkUFVJNm5nYmdoekovK3UyeGZ0SDNMTG9Sc1VDNExDTTBZUDlC?=
 =?utf-8?Q?gS84U9JS04/hwrcSzpZj5YAZQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d690d6b5-79cf-478c-3128-08db258a9fc4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 19:22:32.0612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdYo4fIEi+1u2pNYhX2/zkat6JATFHxvAUGPrDENeH/0f/EZWsPHO1dOVASAOQafJPRx6u4vTMS6QOH1J8/f7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5552
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Menna Mahmoud wrote:
> 
> On ١٥‏/٣‏/٢٠٢٣ ١٥:٤٥, Julia Lawall wrote:
> >
> > On Wed, 15 Mar 2023, Menna Mahmoud wrote:
> >
> >> remove unnecessary blank lines before a close brace
> >> as reported by checkpatch script
> >>
> >> "CHECK: Blank lines aren't necessary before a close brace '}'"
> >>
> >> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> >> ----
> > This should be three -s, not four.
> >
> >> changes in v2:
> >> 	edit commit message
> >> ---
> > -s aren't needed here.
> >
> > julia
> 
> 
> I see, Thanks Julia

I agree with Julia that they are not needed here but they also don't hurt
anything.  git format-patch (or b4 etc) add another '---' to the commit
message automatically.

https://lore.kernel.org/all/20221216-cxl-ev-log-v7-2-2316a5c8f7d8@intel.com/

So assuming you had something like ...

<quote>
----
changes in v2:
	edit commit message
</quote>

... in the patch commit message.  That is perfectly ok and I would not
worry about the tools adding a second '---'.

But as Julia said you must make sure to have only 3 '-'s.  :-D

Ira
