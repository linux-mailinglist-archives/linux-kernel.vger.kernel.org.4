Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C95685D2E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjBACLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjBACLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:11:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EED4B4BE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 18:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675217469; x=1706753469;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=2j9urF0RR/A0pSWEkFdpzEMGOKbH4wxhtAjL62P6AdI=;
  b=muSp/OaZdpIRnjA6DWIgg5IleUlSrK3TfoNW8uHguYqUpXGcxBEUFe6X
   kNQznS+gckS0LHT628klZQmXbDQTceElHsoQq/CZkYqmlDgCN3trueKAK
   dRqZ66wxzUKQJQZdCRefT3Qb3RgwF4xt7YMVxyreumC/qE5xi1eiUDLGd
   qTzIlHRPpHb5qPdF92iQrY37RJt6e82oo8lkxfSbQ5xmz1UOFAaq/V51C
   Fyik33TYJCHvGUVWf8t3hYdnK+dOpkdjSjKAhvTQLSGKuJt+OjJL8zfz1
   iWZLU3z8CNz2/H3VuOzPcgbsY6/uvRSXl5ooXn141CFl7ggLvCztVxM4C
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="355345097"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="355345097"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 18:10:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="658118864"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="658118864"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 31 Jan 2023 18:10:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 18:10:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 18:10:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 18:10:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 18:10:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCqoaxZzg14ZblQwC77oxoTZfDymzosMncRDblcd6ie3fwOdei+4bCBjTG1mtpwX46hHQMb/U8a1vDzVOAWwLPm30INf/pEkNGqH5hC5biClkslcCcaZ4RHwNWQkbf6vf94cfyBbV9BdVrxyRvbtLsuNWcAvnDW/ughe/CDwFKdXs41UWlUeKWkFDYETvs90M3f0lxKETe2O/+Qm7AjUlKRKZvNh0KPqlG/amO81dbRDOwFC/i6xUFVI6Kznv/sy8JUY/p+Ho77vM3ilOQBwidFE4LkUfNG8N0I3pA70QMr4FU7dV5j+qaJmUU3Y1C/xYBNbAooSX/qKYTVhCxZRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD1qvsHEutURpoGBnl95CIMNHQnSR3fVcpZJ7vnNdMM=;
 b=WiXX/R8LHF7A8wL3RS7cPSuFb5hCjHAHPN7dVnkIu2s5HyUXRFF2lndD4NbxOvxQc0qzk+ePXfvCWjhbGkiciZeyteg08plnVMq2EDUU2qyuwdQAb1BZ+9fWGT34Y6GCEFs4FOlfj/+ENEuQMhwRwPk9ER/M0dGSfQveNL9hX3YWOD2qvTt6MXM8MEERbSYrwN1RIkTvKuExsP4lk++jvEubtD5Xahmq/ts4D1b9edw1G/qdp9/P0uRtb+muhk0cbhusN84opTnbKAaELBG5anAV7ZRDUL/dAT4h4+0DvJXn8HVL4c+qxF5MtYz6k+zK8EbnFUYfuqVOCQ52HFkV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CH0PR11MB5476.namprd11.prod.outlook.com (2603:10b6:610:d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 02:10:12 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209%5]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 02:10:12 +0000
Message-ID: <243f684d-93a3-3aa4-cfc7-cfc0f9fd53cd@intel.com>
Date:   Tue, 31 Jan 2023 18:10:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/7] x86/cpu: Disable kernel LASS when patching kernel
 alternatives
To:     Dave Hansen <dave.hansen@intel.com>,
        "Chen, Yian" <yian.chen@intel.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-4-yian.chen@intel.com>
 <693d8332-3b86-3dcf-fc87-5c3a08a752db@intel.com>
 <ad2da884-c8c8-bc57-e21f-452a08cb10cc@intel.com>
 <b9e73d06-bd95-7c54-3ff1-f9e43c9967a4@intel.com>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <b9e73d06-bd95-7c54-3ff1-f9e43c9967a4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CH0PR11MB5476:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdee372-e9a9-4b06-7107-08db03f9735d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjEIXpdJYWeVcgNQ0UB5e67Axi8el1ruemdg7zQcLf9ywdxOn8X3jS6WrH3sFCAqfFsDl3X2LNlthLBQyljL4imGOvRIUJsJL4lVo/g9AwOH5c1zHKKZGalcthXx2GeTsSwxOXKCUM099+PtpHcoxU9lz5zK1KolWmTJZ14/789K6IvRflbRY43lqWj0+LgStfkygR56oCJuWU5InSWSJzMyhoAgV+9YXQKbXAVVLTzYw4T3m7DlTyKNakOP9MB+uMrMv70HCMJUYM7dQKB6FxXZvf97aUxvWYHL+8fpdpTn3Zb5d5Yzux9RH/wwNK5/RL/lVx7n+4YyBxP83VWG4G4g2prxNYqYpx9DL5UMLv/y4Jn8NDQW9Feqx5oXfB8L+4IwD5ZP+WT7SH9P2bLLiAK+kgserF1xC5q0q0pWOfpzciF/RlOafn2PVqQXXBTigqTc73fCQau8heKI5tZ78HDWjZvJ96N912/FD1Cftq48tD+FoSKnx3saA0IX+xfvJe/0yhi6+db0y6hvBhtgJrqtiebmMF9SWPdOA0AlXrIJ4svb3a4nPDxzPHc/H+RXd9Y9l7lX4KjTG2T1zW+kH6lSQEcbRNFCTnO2n26gKjqj5IZleWnx55z0Q2l4yMiBw4BNGvNKA0MezM9PWDdX5S6axigONQ3eIhFF6aGP9am32DNqocdHyJHFCJtkRv28xV/+qtlfyY5hWf3x1QiyHkD5u03IKg1KVEQmZHdksYfheYuUAL27K6QulfLJE/qu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199018)(31696002)(6486002)(2616005)(478600001)(66946007)(8676002)(6506007)(66556008)(6512007)(41300700001)(66476007)(36756003)(26005)(53546011)(8936002)(6636002)(316002)(82960400001)(186003)(38100700002)(921005)(110136005)(83380400001)(86362001)(2906002)(44832011)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHJncmdwNTAzbVFYQWtvRVVTbkJmeUdOUWRNS1Y3cFFaTG5ZZWtsM2FSRi80?=
 =?utf-8?B?QU00bytRT2dIVG5RaGhKQ2VrOVpRVkF2akJBbXphQkkzS05Wc1I2QWJob096?=
 =?utf-8?B?QnJqdlR3amZHa1UwSEZrYllzZHRtbHZDa1RMcEtYTVMxTjJrMUZodlpsT2lO?=
 =?utf-8?B?RzlOa1ZUc1JDVUI5YWVtRlAxTDgwSnlDb1hsVktMa0h3L2RFbFViMk81c1NM?=
 =?utf-8?B?cVRjeEFWSVFMdXowUlhmQTFGTlJGaDZxazJ1Y1IvOXZFVkxlSVlmS2NBa3Ir?=
 =?utf-8?B?ZnVTNlV1azlXQno5b3V1NWdqT0dvdVE4b3hYdjR5RjZWZElUbUVkbW0yWjdW?=
 =?utf-8?B?akVXUE12aklaUGdSU3AzeWNQemVCbmZNM1o1TXgyZ1orZ2VJWEFqL0cxMmVa?=
 =?utf-8?B?N2tHZ2hTaHBGc0tZWWwvSTZwb1ZHV0daTzlTdVhTbFdiL3BSeStrVCtUWTdk?=
 =?utf-8?B?WXdCVFR4bUlJUHloSnBDdFY4bVVPS2FzbEVxMTlybGswbHVQTlQyQVI2MUVT?=
 =?utf-8?B?QXUycExWczZJYW5OVWRWNG9CelNqbjcwR2l2TTVKaXI4VG9SaGhRUTJhZkJt?=
 =?utf-8?B?NStvVFVya25vSHlHT0pranVOdFlUSVhOaGlzNk9ROENreDcxMVlRRTc4M091?=
 =?utf-8?B?cmVEdlcvZWVKTDhaamh6R0luRlZXMjdJTXhJbnNINUhOZ3VBVVlsR0dTd0Jz?=
 =?utf-8?B?Nk9wemNUY04ycFVZL1ZCT0c1bERqUGl5SVl1VGc4Q1EvbytQeWFaN2pKcFBr?=
 =?utf-8?B?b1ByTjljOSt1alloeE4ydVFmSFFwYVQ0Q01OUEZ3SUorQnYvU05iYXFiQW1s?=
 =?utf-8?B?bXBHaUczOUI2ZWFwRy9xMnJPRUFtVEk2QmdaUWZiOWsxKzJEN2d5RWdNQ0NJ?=
 =?utf-8?B?WG5VajJZdDB3QVpuSnp6MjlITXAyMEdJaTFwUnV4bmxNTUJGMGxBV2JrYlhM?=
 =?utf-8?B?dUgvQll3K0VXcHFVcWVRSVNBbDJtMDA2VGhjSlhsZnZLV1Fqa29qWm9MaEhT?=
 =?utf-8?B?cG1KWm9tQkFMNVJWbldIZHpRWEtJZllDZ0dWTEpmbWRxTTkxcHNkZ01nVFla?=
 =?utf-8?B?dUtUcnRBSjJaajRCMlIxRXJucXRtRDhiNFFFSXZqc2RoaWJndlJZQ0U0a0Rj?=
 =?utf-8?B?MDVTM1ZFSThCNHJicGxyVlI4bnZWYU5zTmxaQ3QyMkoyblBGQkJnUWRnTzVn?=
 =?utf-8?B?WGdkZU5KMHROSkswcCtzWXBNcFVoa296YnZQeXczQ2ZXUlVLeUFDZlBnbVh2?=
 =?utf-8?B?UkplRjMzR3VBS1IxUzBxOFJ1ZWxGV2Vob1UvSUc5dlcvZHlHVjR2c050aXk1?=
 =?utf-8?B?YjdaV2owSnltSXZvWUdKQklOd2xZR1ppcFB2OWZiTkxLQkhHVnRpTXZoejNE?=
 =?utf-8?B?KzVKaENXQnRWTW85aUdOVWlaUFd4SmF0c1BRZTY0VVRtRllXOHNqSHdTem5L?=
 =?utf-8?B?Nk5TQ0h4MG9DTlhSMkZZcmU1alY5cFMyelBmMVJqeEpKSmJmWE9kUUVTN3Rt?=
 =?utf-8?B?NEE2YXQ0NHJmOUIxOERsZzlCRGNMTG9Ra3FtRklncDU2MjVTUDFxYUFVMENw?=
 =?utf-8?B?Mzd5OWsrdmx5ZWhGUmRpUmpQZW0yTDA1M1RleHlZdDlnRitwOUpsUlo0d2xV?=
 =?utf-8?B?OG9ZS3Z0WGEyTTFla1VKT3VTNHBaYWU4VkV4QWp1Tmt4cGVianNzUlVOMk16?=
 =?utf-8?B?YzYzanhPZU1qTDJ4eGdzWlBUTnROckFOTzBXdmhNd3B5aEhmM3ZsOUVGMWFK?=
 =?utf-8?B?ZFBrcVphOU94aWlXN04vVjV0cUt2OTRmcXhhQUdnaUgzb1Z1akpzS2ZBZ29L?=
 =?utf-8?B?TmVOaGp1L1J6Sjg0NEl2VEdxdVpxZDZwSCtHeExZYnN0VGVJWkVPUlNGdzBi?=
 =?utf-8?B?OEw1VVcrRnhpbjcwbUtBNno4YmE3eWhLOHJmbWF3Wld6QjVLVkFGSUhSSWhh?=
 =?utf-8?B?dVJ1R2hCZ01EZTdUUjJ4czQzZStPY2VhRzJBR3J5bWVQSXRpNGNBRzU1UXJJ?=
 =?utf-8?B?VWkrTklSTUNoSGI3TjhhaStqNDMyaXlMMml4bTMySkx4RjhTRW0raTNpTkIv?=
 =?utf-8?B?SmVtMWlPbVEyYXh4eW1BeGxBMnB0RllZSnpVVDJXYnhQNkJKT1VubVg2a0FU?=
 =?utf-8?B?YXBneXVQSTdMZVovc2tuMy9VUE9kNGsrME9mdXg0VDVaWjVLOGx2RkM3MEsy?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdee372-e9a9-4b06-7107-08db03f9735d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 02:10:12.2488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CBp/hUMNbr/fox0Jdfi8cAILsszpMJeM749OI/FSVM0+OdNDZrKWI2NtT1XDndLnMib8NcyvYo5miu+l+6ZjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5476
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2023 4:37 PM, Dave Hansen wrote:
> clearcpuid=smap means that the kernel should be running as if
> CPUID.(EAX=07H,ECX=0H):EBX.SMAP[bit 20]==0.  STAC/CLAC should #UD in
> that case.
> 
> The only reason that it happens to work is that STAC/CLAC apparently
> actually continue to work even if CR4.SMAP==0.
> 

It seems this is by design. I was trying to experiment with
clearcpuid=smap on an older platform (KBL). I noticed that even if
CR4.SMAP==0 the STAC/CLAC instructions do not fault.

The STAC instruction operation in the SDM also suggests that it may be
intentional. It does *not* list CR4.SMAP=0 as a reason for #UD.

#UD	If the LOCK prefix is used.
	If the CPL > 0.
	If CPUID.(EAX=07H, ECX=0H):EBX.SMAP[bit 20] = 0.


> I'm actually a _bit_ surprised by this, but I bet there's a good reason
> for it.
> 

I would love to find out the actual reasoning behind this. I'll try to
poke some of the architects internally.

> In any case, please just make LASS dependent on SMAP.  It's the right
> thing to do on several levels.

Anyway, the end result still remains the same. We should still make LASS
dependent on SMAP since:

1) The spec says that LASS enforcement only happens when SMAP is enabled.
"A supervisor-mode data access causes a LASS violation only if
supervisor-mode access protection is enabled (because CR4.SMAP = 1)"

2) In the extremely improbably case that LASS is available but SMAP is
not available on the hardware, the STAC and CLAC instructions will fault
due to the missing SMAP CPUID bit.

-Sohil
