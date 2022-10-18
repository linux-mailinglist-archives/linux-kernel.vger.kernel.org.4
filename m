Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D306030D7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJRQgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJRQgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:36:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EA6DD8BD;
        Tue, 18 Oct 2022 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666111008; x=1697647008;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Xy+nB9ZV6BDR7eLgX9QWXYth0xD567KoN2R/2tJehU=;
  b=Iy3QyIlwUKBpbDMTnIiwy2lidjQaqrRDoZWUCXRU3khkkkPdQVEg3QVq
   6vx9/cOAe27/tjxGk9tlhhT9AOGNoyAMziHWQ12cXnSJL5S/dp0Pirthn
   gfxw5+6cbgt6Ul15KLGbpIaNNupZCya1nj6DuSo2ho8RoWue3cYsH1zWX
   YSwuETmDu+ABuRulsbzbiQhcTFwWjsc8hPFnic76kvoVisP6LaKYCzqfJ
   qb0VGOGolqQjZUeMrJ4s5PxixvvaZKF0b1wDcic1RIf+7+0i9F7FNA3Kp
   Y+1Sssfb6h7ZB+qhsE8qW8EM7zRyTXCBb3ozntQ7GqMGZ8tuvBVHxtvLB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="293530825"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="293530825"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 09:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="606626439"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="606626439"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 18 Oct 2022 09:36:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 09:36:46 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 09:36:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 09:36:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 09:36:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLFl16F1+wHQPNaop4EL4R1QK6AQ3iQxjjEGnVNlaxtJUuViTBXFd4dhDG0iwu9KZFAle6Y9YGuiVx7Qxn7foAX3bOz6hdKTZfAKop58+bZSz4YEeJahfCOoylHHpUWsPiiXwd6fbHvS0L1CW7ywWCaCBKnTM4gmYl8JN4JDMfxmmOoz4gZRZsu/O/GOK05BiiDAXmEK0bDN5sa44s7oLdMBVW5vDBfZHPzXS2gTreKUiiwneXVxo9midDlbqZh6pt1cJuoFBlovV5Mj0tlkcw0yxfD3izvtPsl4miszjMcymXwMSbrJWAzmqDo8TCNFIDz6NB5rn76rUMUbiWT4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TRXhgWrNO8XPRo7lEU2I5X/a4nDSHg2+TnO+xakPpI=;
 b=YPV2XaSxkNRr9Uis+/aAIAZni6KgZe0CA0YTypUUcT0iBG+FzWG9KSWr3EhMkdcHpYiwV9xpMnQ1rTxjqjBUeGFK+xNAz3SdxC8xjfJ6490xE3w2TIFRfwfSdJzxyssuBO+SGhGM4/ENrkqeINmlNQUEcaasuxU90AkRVc7mRVJL4FhlWi4Lnspht8PbUXLRvwxu1zD7VOGPNboxYwmDpNIRR0wKGjAtP4ZIu9a6kC+15P0tlG1Sbbj+JXIgM9uKY9SYoUismB5T9JEJFMhBs9NBChYPXo9gW1SzkhRquctBQgFdfkeEkyrvyZS8OPHiNbRD8plKE0Fh77TyUVT0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DS0PR11MB7358.namprd11.prod.outlook.com (2603:10b6:8:135::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 16:36:43 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::6262:c42:ea50:926e]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::6262:c42:ea50:926e%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 16:36:43 +0000
Message-ID: <6b4aefb2-01a9-1489-8669-1af20e88f669@intel.com>
Date:   Tue, 18 Oct 2022 18:36:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [REGRESSION v6.1-rc1] rtc: cmos: rtcwake broken on NUC8i7HVK
To:     Kalle Valo <kvalo@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-rtc@vger.kernel.org>, <regressions@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <87edv6mlow.fsf@kernel.org>
 <b2be77b0-bafb-0519-33cb-359d83ded4d8@leemhuis.info>
 <87a65tmwuj.fsf@kernel.org>
Content-Language: en-US
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <87a65tmwuj.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::20) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|DS0PR11MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb15a0e-49df-41b6-698c-08dab126f09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 447r/gMM1FsFLINXW4yjz1qjAXw0ZZ390+XlN0x1KoK7wVrkxrbBUFl9b1H4Jgkwo5BFMisuDhjv3VUqvLB4/1x48+2WbzmibuyheAIEosmNqxOYkM3rQwNV/ktZf3s4FSfyDnq9qQB5YBSOhf8xGlPBlklopD1+dIb2LPQq3fPM5tLb80ydlHSzCNV27NEqstRlu0u+k1TbyxOZont1xtztHmWUsHfa1YpOsOPDd+y4su9jO8XfpICbGCttWCEn9tltLs35HkCHeYZweTPq1Glc/fP44IaVvN0yVl+WuxcTynLi4AZKGJPEY+/KT4sATb2yRvc8n5MXYs70GzY1FZsmVNtykaSrCGizePFjgbwCjZRkc8aUZEcOZgPMqxCyTRFBKIVpe8JB2dnITXDC8z4LQJSycEzkkUtMEwk5fv50b2e4lP0OewEDAUIUQTuhFOBWdUJhLS0UcPaNd5MoTh/uDZlfMdf4KTrFerGqcynYuMOFE1AoNSZm08vzglXL/jb2Bt9+Nhtj0ypuUiNi2atn/nOdVaQ89yCCh015m1pv0scI1rXTAUyT0d0EhB5E3FD8Bywc6om3QhLn82+7CVZoBZUeJuhw6p/bo6tUNYFj+NwTqSpHwpoD9BoaSYWi4huO8iZ5i254niAO0qNsxfyJm+3greOkZ4k95u3GUCR0FPYuadITP4Je5yslvxdxv0FZmC1sA5pkiAHIlKzrwwH856hK5pvR0ehN8/9IzFASKCuQ1kE1eLQsjzEDykeD5JtQva8HHa1ei3s0yGGrS8IYzVE0FNqzaZzibXJrliBJB5TuwgTHcKbE2yVG84F4zMS5WbKwrB1Cvn3JAoqpWmdtaEMyBwaVglnSyC7oNWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199015)(6512007)(26005)(2616005)(54906003)(316002)(66556008)(83380400001)(82960400001)(66946007)(186003)(4326008)(36756003)(36916002)(31696002)(5660300002)(8676002)(6486002)(966005)(86362001)(66476007)(478600001)(6666004)(53546011)(6506007)(110136005)(8936002)(41300700001)(38100700002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9yWjJWT0RaU0F6cXRnQkVHa1ZFYjZLR25ubFViZTdDeDJTdWlibWVwOE15?=
 =?utf-8?B?NjZkWnU1a1NFc2tka2ZXWFF6bVJZdFdOUmZtMkJEalgwRVZTNzMzVENjdnlM?=
 =?utf-8?B?dVhUVWNMcElncExJbXllWW5uZEJFWTE4NlM0Q09BVU8zNGtiMVZrWHBhVWxB?=
 =?utf-8?B?RDV2S3NkcTE5QTMyaHE2dzdjUkFWTXErLzN6Z1VOa0VwNEZQNXRzTzU1dXBm?=
 =?utf-8?B?cHJQTjltS1JUUk5wOXRrclFwbHcvWHJ4bW5QUmZVRS9BQUVkYzRwdDJNNExI?=
 =?utf-8?B?ZzBIR2xDQkxZbjN5T25BcHptZXF4SFIxeFZPeHNGaWpCeU9uRndBMTl6MkVw?=
 =?utf-8?B?b1UwVXBTL0NvazdvNmpmc1k2RmdXTStvd0ROVElGaStLalhLTURtQU04MWhB?=
 =?utf-8?B?MElqMUFTR2hRMWVCWUxXdTNpRFl3OHl1WVF4TVdIcVF1WFJvK1hHQzlKN3lO?=
 =?utf-8?B?RFpXcXNyQ1FCMHBmUFIxUlg1Tko0STdlOXJENGNmY0UyV2x1VDI2Wk8wQzhG?=
 =?utf-8?B?NDFucklTTm9hUFJsY0V3MDFVTTlFTFNGSmZUWXhZbjZORXJLd3IvV0Z1ZEQy?=
 =?utf-8?B?SC9KelQ4MktKUUxvSlNzR3c3dTV5a2dRUHF1Q3YvVGl5L0Q4cVg5cG8yZS9k?=
 =?utf-8?B?NzNZZ0Y1VVB1LzZ4Rm9vUTc2WjBVdGNmRHVJcVlRSUZjaG1LbUZ4Njk2REs3?=
 =?utf-8?B?UWFWcndTMDE1V294aFJjMmJiYzZGd3BWU2txVW5DOC9abEhRUnd3M0g5UjBB?=
 =?utf-8?B?UnRGREYrN0lrU05rM3FxY0xFK2hzTzhGK0RnU0xiZkt4RnV5cjBxTW1mMU5x?=
 =?utf-8?B?WXJ3ZDluVlhMOE1EcG9nVnMwZlhYNTgwd2E4RW5XVGsvQ1NVVURZRGtKUGRS?=
 =?utf-8?B?d1c3ZjBPWUgrOFdZa08rT0dZU0VFRmdKU3JCTjR1Qlo4OWUwNDdSc1dlRm9Q?=
 =?utf-8?B?SnBZVzV2QnJrK1ZxRFQ4MmZDcURrS3NvZVduMGRRQ3k2eXU2UXVjNWkzWmhC?=
 =?utf-8?B?OVk1dktzTUxXUnkwQ0JXNHhzSjhHTjVrMzlCcy81MFd6ZEpVSWxGQk1EWVBZ?=
 =?utf-8?B?QnRBd2FZREhTZGtsNlFQVk1PZExKQnRuNVg4MjUwVWJFMFpuZ0EwdjdVei9S?=
 =?utf-8?B?TkhwTXNSallML2xwYXo3UGgvZTZmaVFucnlBK3gxTXBpZjBsa05YNWlhbXl2?=
 =?utf-8?B?cnpDQ0lNR2l2TTBYT3Z0ZHhoL3VyU1VUTzhJUmJwdDZIaTh1Rk5GNnVhdGxz?=
 =?utf-8?B?RnZpY1p3NEs0S2JYYlFOWm9NV2xoYjdYWU05bjNqK1FtQi9ob1lTYWVib094?=
 =?utf-8?B?MXREMUM3UFdJdjMwQW5SMlJiV1JxUGg2aTZZNVV0NzA2U1B5TGJhVzF3OHNN?=
 =?utf-8?B?UmoxQjBYUTNxMmJIWHJlZ24xNlNXbHR3Y28yQ2pzTnBkdlYvdndtdTkzQ1Zm?=
 =?utf-8?B?NkFyK3VjOGJDaU1NKzE2bFJwQys2cUZXM3FObHkyOGhpdkxBMGZVeTJGSFo4?=
 =?utf-8?B?MGhIRFBmNmwvcDNVWTZBYm5tZVFpNGEvanFpcEtSWm1lcFhVQS84UUp5UDlr?=
 =?utf-8?B?WEFsa01vYWl1RGpSYUVkblpTVWNFejc4RWFwOXphL1UvRWJMYUJZOUZTM2dT?=
 =?utf-8?B?dmVudG1pQzQ0bUtEcSt1eWhlVVJ0azZNdGV1WmdNZGtZenVGSjkxYTcxVUdy?=
 =?utf-8?B?anMvN2k4N1VQNFJqeHVpMWFOZ2xRbTlUTG9pL2xTOFA2U1JaR2R3c01nblFx?=
 =?utf-8?B?WTBHZ1hiMjdwL2NTY3NjR0Z0eStmNjhLeWhEMWRwdEIrWExlb3pVS1ZBckdQ?=
 =?utf-8?B?VS96MkdSenZYR2NKczRQV3Btc3FKb283QkU0Y3RndTJxb2hJL0xrdFlyRGxQ?=
 =?utf-8?B?bXVzbytlL2hGd0l6L3ZpSys2aEphcXdYUWpRTGN6RUpjRzIrUGpEY0pqVHkr?=
 =?utf-8?B?ay96V2pVT0pHYXBXNWt6ZDZqMVVoUEpBSmMyc3c4N3RxRU8wcDhvQm1GNjNN?=
 =?utf-8?B?TDdWQ2g1NU1ObG5Kb25hZXJFRFFCUldUOUZwRDdVUXc2b3ZkU2diblQvWFRi?=
 =?utf-8?B?TEJXeW1WKzBvV2JjdHhCRmJBWkpqcTZ2UEE3VTJnYTErZ0lHYlJ6TUFlWHBN?=
 =?utf-8?B?c3h5aVdsVVhvelhzWHJEN3puamZDcldSQlBJMnBvMWt0TmRtL2VSSzR4NElK?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb15a0e-49df-41b6-698c-08dab126f09f
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 16:36:43.3323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37gY+/Ajiuv3gETAz24VZhgbKTZemm9cq5Oda8M3pJgS8OtrzBqNVy5279HPkUpdWOK3WgUbVcIP74iK/LffB7AK7DuQnp8E8HaLaUKqmnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7358
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2022 9:09 AM, Kalle Valo wrote:
> Thorsten Leemhuis <regressions@leemhuis.info> writes:
>
>> On 17.10.22 18:58, Kalle Valo wrote:
>>> I upgraded my NUC8i7HVK test box to v6.1-rc1 and noticed that my suspend
>>> tests with ath11k were broken, the box never woke up from suspend
>>> automatically and I had to manually push the power button to trigger
>>> resume. This is the command I used:
>>>
>>> sudo rtcwake -m mem -s 30
>>>
>>> v6.0 works without problems and a bisect found this commit:
>>>
>>> commit 4919d3eb2ec0ee364f7e3cf2d99646c1b224fae8
>>> Author:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> AuthorDate: Wed Oct 12 20:07:01 2022 +0200
>>> Commit:     Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> CommitDate: Thu Oct 13 23:27:52 2022 +0200
>>>
>>>      rtc: cmos: Fix event handler registration ordering issue
>> FWIW, Todd also reported this yesterday:
>> https://lore.kernel.org/all/967cfe4e2dba242352ccd1cd00bdbcfb48bdd697.camel@linux.intel.com/
>> https://bugzilla.kernel.org/show_bug.cgi?id=216600
>>
>> And Zhang Rui provided a patch in bugzilla that should fix this.
> Thanks, this is good info. Strangely enough Zhang's workaround in [1]
> did not fix the issue for me, rtcwake is still broken. Unfortunately no
> time right now to investigate further.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=216600#c3
>
Please try https://lore.kernel.org/linux-acpi/5887691.lOV4Wx5bFT@kreacher/


