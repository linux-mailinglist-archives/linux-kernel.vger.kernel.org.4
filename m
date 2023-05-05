Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E1F6F8AC7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjEEVYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjEEVYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:24:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E67525D;
        Fri,  5 May 2023 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683321856; x=1714857856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l/UznuiOmANKD9EgXM+38uqfqxS+FOI7dRZsDjb9Skw=;
  b=doIwYHqjXJCY5ETZrGw9gRcI8O4h6auzJ00RRFZ1vQX7g0Yth4YiREL+
   UTvlCMroqJya5GviM2a6aFjc3iJ/zRHL3gu5kmVbn19VMrTYCO6CddAsc
   mqfuWkkj8mBVyJsMvnCnJ6H65FnQtUkluG1l7rP3DMMs1qxgp5FWuiEf0
   wa2IMusJ6izHI5Exxs3OlzaScUMRu+/VxyUz/AH0k+ezoA/otO9+cwOGT
   tDIcVF+3srjdcAXmUSvtHWKyWmdqzYynEbZRPkFylyouV/0jNqW8n/7ou
   czh6R6iCTf7fa8KNjidZ3/+ywMbrXC7yxdjEXwBLOvtxtY589pQ6rfsCb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="348126738"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="348126738"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 14:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="787302175"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="787302175"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 05 May 2023 14:24:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 14:24:15 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 14:24:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 14:24:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 14:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+UqHJXEVKICSdgYb9Q6PQR1Fo0YJ4sl0E/q1SHdBEJBN3SOdv9IfFezTkq/IFFJK6q5QnPXRUPGXYGGLUkzopulI53LVcWrVvIKDLhxbm2Ochrq3wzhlVFdXC7eA3eAft5aXR5Py8/URaqettfG6RyRLZVzi8X8ye4nQiRaPItfjqr/qGt31H9WRC1TWYHoInNg1PuQzgS+K9vSasCFP+PJAEl9pOiz+g/gfjlGHP0qF8AV5UuEP5gpLjmv/nXa5Bd6gSoqtpSq2d/nh7qUuuR40kKcHf49bLTFy2LoerfxQ/p5jjgGdkrjpnaZu/3riwcWxJhV/SlMI/jMqb9WUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VElvLT76T/qyA7cT3c9sWL94pHTjjrC8SESVij4rRn4=;
 b=NPTn41mNr8+Cwejix8YEr08mgFK7YsEYprSAG9Xd0ZVe4VFRIWaKkUnNHE524UxVMHSX3aCRo33+Nx5NiPCCZw3nR9wQXdNdDFHASXKhsuHSBltuDG7NxFPt36x1sw1atQIVyrT7w/3ly3vx/f5ZggeC1U/p8CZBxzWCcAPul9wRssNBZDuIP5pSh0yA2UGar7L6+Dr2AEWzKktn1SbV0c1DJH6tNQ1OKwH5FNS6AX0ePqsjOv/hcyDhUVcg/6/MPe1X9g8/cT3IgBQtAB7wPD5p5/DWDa9NgxZ6Jd9rqbjkn4Md7KHrp1M5NoU8SqWMQ+vcogoBe2r7QviHA+ZCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 5 May
 2023 21:24:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 21:24:11 +0000
Message-ID: <8d3cb414-88df-4c89-7dfc-6e598501d722@intel.com>
Date:   Fri, 5 May 2023 14:24:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 4/7] x86/resctrl: Re-arrange RFTYPE flags and add more
 comments
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177447844.1758847.17789021842152864417.stgit@bmoger-ubuntu>
 <67e00f1e-bbb2-59b6-fe34-758d5b268324@intel.com>
 <c1a309b0-3d29-151d-b1af-04d524cfbd83@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c1a309b0-3d29-151d-b1af-04d524cfbd83@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a2255b-4b33-4cf3-11a0-08db4daf11c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+oWkvnrtMgsopw4RbDZQGwFHMxAYzh5pWvV0E8RfxPcxE/bo65kgJGcnsFe9E5nOq1WkKPOFaOYFr9ych+DmZ8dSCt0wbFOAEKzVfVEU1sqxJdOdw/REwWBqrFhaRJy64+P6GITLADFEbj+Ejg34TRPcmBiUmvDm1sR/Tm0iIwavM8mipiDy2EoLBCPgtmidC+Offi2qV8k/hPkCt1VoR/+ceRD5Q3eNypbei69lHPsAfAJPtVRiK4rZ6ejiilvtVc1wOMgu42Bq22CkT9VdSQJgsYw4QlMhoqbqeG7BSVcuTPyYy+Kzl2KJvFRB9/jBWDZ+jjCfiS4KL9aNvxnfMztvCDbK1z42zVaIVVJH+6KG+PqUnQE9YXtlY1tKyIqa83BWVBPM5NjT+QTf+w4Gp9M7SxcmU69UsueIAyTNEC6l6ooMz7m5x6povkFaEWaW1hT3LnfBoiBBiBV6HiS/2wPVdqZc1A7BJVSFs0L/TjuZ+vxJxBJE7zGBl3Qd9yM7uh0DHS7V7ugwyrNr+A+IRnWpoWQ4snml9qtT9+9yCSF/VTDlYjN+w08TpuDCGhDqHcvo8YOFYgosfbiVvE3iCkDZBB7IkQ6V2z8j1aUTNRAaSn1EsyYDBdYLdO4tq6HkOcFJmQCwXB+kOQi4v2LeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2616005)(8676002)(41300700001)(8936002)(478600001)(53546011)(6512007)(6506007)(7416002)(7406005)(44832011)(5660300002)(66556008)(66476007)(316002)(4326008)(2906002)(66946007)(38100700002)(82960400001)(31686004)(26005)(31696002)(6666004)(86362001)(186003)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ung5enMyWHVKSE4zQWxOcjZKUi9UeWFlb0UybnkxUEN3SHlyNzdIU2czM0xR?=
 =?utf-8?B?bXhvdmZQMjRkVzNWd3FubzY4WmxLNzBIUjZmaVJkZzh4WnpDZWt6NU1DblFU?=
 =?utf-8?B?VE9xUVI2bTFYcU9NZ1p0SXlIM3JXRGNKYmFmWEJQYmZsa1Ixd2QxS1dGVlhN?=
 =?utf-8?B?TlZxM1U0SXF1R3RxckZNM0FxU3V6VmRMTmZOM2NtZUdORmtveWlCcjNJelBk?=
 =?utf-8?B?NnUxQ0hSVFRPV3hxdmZzanFqUGl1cDBQRml2dEQ3bFVCTzRsUGh6bE4vaWhC?=
 =?utf-8?B?Z2JOTmNxV1o2TTIzb05tdzlWVlQxV0ZTRXhudVdSYXpuTk84Z3ZTSlM5QkhG?=
 =?utf-8?B?ZUZWSkhIUXZndjRCdGczZHpPcDdYS3BuMU9VWWdiVXkzR1dyUjRBSnpWNmxn?=
 =?utf-8?B?TGR1NWlUYjh3RG1DZXFFZ1FRdEZVWEhic250WklONG0weFh6d0FPOGwrdDha?=
 =?utf-8?B?aXVYVmxjZDduQ0hGU3pnRDR4KzMvRG9qRUFKZEljakpjekRQVkRwSm1xK2tN?=
 =?utf-8?B?QTA0dkx5VU5wdGtFQlBYZ1p6Q1pBN004UnFXcmZjV1RXZGhLSjNUZGU2ZDJ1?=
 =?utf-8?B?dis1T0VXZUtPek1mZzhET2tMQ1dCSE9kUUVoUGc2djRJdkwzVThvdHJRdkh6?=
 =?utf-8?B?U25FNi9JU21TYnNZcytySmdHdTZHRVB6eXhVdzM2NU1wWm5wcWF1ZG05RHlD?=
 =?utf-8?B?UXJreUdlMFFsTzlVR09UeGlpWnBBWERjN3RrdUVkTWpSQ2tlRVpHU3RCNGZP?=
 =?utf-8?B?VEQvR3ZzazBJM1poSFE4ZkJtSGxpTHFyazlrQ2duME9hR1Nzbjk2ZHlTUkRm?=
 =?utf-8?B?d3M1NjhoSXh6MDk5YldEZ0dpT2U0MHB3SlNicGZXWUJJUUxGSUxVSUtwRFZN?=
 =?utf-8?B?SG0wRUY5NWF3YzBQQzF1V2JoZ3pJT0tmcFcrckI4dHh0MW1FQmQ5azVRMlpo?=
 =?utf-8?B?bWJnVnBvdlp2SGN0NG40Q2pZSzF4QjRRTXh2cWVoeUVmMTdybk10WmVod2Vs?=
 =?utf-8?B?RlY3MHlreVRtOXQ2U1pyUnMvYjF6N0RrMDFCdkw1Ym1NZlYvd2RDSTZiUnBs?=
 =?utf-8?B?QzkvV2JIUHQrekVRbCtWVWlhcXVBZXY5Um9VSEtzWU16Q1RzSlBJb0ZqbWdu?=
 =?utf-8?B?UEtTSzdES2kwRUdmL1Jma1RrQUQ2bmUyajNuUGZzT1pkSXphZzJlS3FYQVJK?=
 =?utf-8?B?UkkzTmswM2c3QjgzZ2tWK0RnaGdzTms2MDNrb1MyMVZkSzc5NU90VElySnU0?=
 =?utf-8?B?eDlyQytPS0x0N3FEcWdUR2dSZWh2WG9tdWtadE1NaTNZWGV3azNxWVF6TWFV?=
 =?utf-8?B?SjVZcUVpN011MFI2UDN1LyswMWM3WDkvaERCQjJHS3RZaFhQeC9WMEwxcjdP?=
 =?utf-8?B?Vk5ETDJlK0VSdno2RXR4MUlIMmVmeUhxU2c3cmRDRExNT01NM1hGUUxmeWRE?=
 =?utf-8?B?c3ZwM0hxWmNYN2JwMCt1eFU0OWw5eWZ1T3g5UEM4QUlmZDZjVzNjSkhySHlu?=
 =?utf-8?B?NjE2NXV2Sm1Va21XYzZhZEJja21WM0FBOUZxVVE1WG43QnowSjR5Uk91TTJr?=
 =?utf-8?B?VmcxQ3oydEU5TXBqN3VyQTV1MkNweEF0TWZCQ0pmeURVSStockNoaDcvTmhu?=
 =?utf-8?B?eTRBRmpIcDZOTVNKWlYxMzgycm4vVW5YYWF3b3N1dkc5dVJERmpsQ2hmWldn?=
 =?utf-8?B?MnpLeVlhRzJmYjQwOElyVjhDb2V3bzE2bVVvTWsrTkNNaytaRTIxdTFVYko2?=
 =?utf-8?B?QXVmeXNUR21XRFF0UzB1UFFydENTT2hXQk1yWnlDTmkrS0ZMbzVJNVdBbDc0?=
 =?utf-8?B?RmxaSHRmS1VQYzZQd05pTXdJWjF6KzlxZlFHeG5tZ2tUVGhqNXo0MVNxeW5G?=
 =?utf-8?B?Rk9WUjFYdm9DVFJYNlh1eXJraTlRQVhDNzF1MFZ2MmJkZzZON1BONkFKeXVD?=
 =?utf-8?B?UVlZVS9Na3FmaTJNQmRvTFphR3NGQmFoV2gxSGhKWXQ4WUtDZTBGNnBUNVNU?=
 =?utf-8?B?Uk1Yb09qSkNxaUVpRUc4NlZ2bGFmdVF4Z0hjVGg2b0owc290L2l6TW5QNGNi?=
 =?utf-8?B?YnB0OXMvU3JTZXk1ZFhFdTNna1NpVUlnTGdTOUdBK0Z5R0Q5dW4vaTVycS9C?=
 =?utf-8?B?YXk1emtyVE56L3NpUytTNXdEeGY4VGZVWUtnNERwRXBoVVQ3K0poc29hb1M2?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a2255b-4b33-4cf3-11a0-08db4daf11c1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 21:24:11.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZG1jWWBruPIunJ/thqMaLsy61dg28wvGZSd4mnwqXPWm2ICdeXiqGGFPdmtkr4uJnG3oIz4WIacnqioeeBsIpdt95KL4zSnd8ogAFqJYOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 5/5/2023 1:40 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 5/4/2023 2:00 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 4/17/2023 4:34 PM, Babu Moger wrote:
>>> Remove gaps in bit definitions of RFTYPE flags and add more comments
>> Why is it necessary to remove gaps in the bit definitions?
> 
> Removing the gaps is not necessary definitely. I thought adding
> comments will help adding new flags in the future.
> 

I agree that removing the gaps are not necessary.

> If you want me to drop this whole patch, I am fine with it.> 

The comments may be useful. If you decide to keep it please review
it for consistency. The comments should not increase confusion.
For example,
* in one instance you refer to "info" and "base" as components, in
  another you refer to them as directories, which is confusing since
  there is a "info" directory but no "base" directory.
* related to previous item, the comments start by referring to the
  "info" and "base" components but then the comments switch to
  describing a "info directory structure and "group structure"
* the separator (---) is used above a header in one instance and
  below a header in another
* in some places you use the syntax:
	--> <flag name> (<dir name>, <dir name>)
  in other places you use:
	--> <flag name>
	   --> (<dir name>)
	   --> (<dir name>)

Reinette
