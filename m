Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C14A6153C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKAVHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKAVHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:07:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F701DA6E;
        Tue,  1 Nov 2022 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667336863; x=1698872863;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P+Uz5fWwoWognMn4Qqgtwa6OXLwcPIwmZNx1uCwRytA=;
  b=mlB9+XmKp3TUN1cNgEB923T9xcTVouzD0EYA3YfKMpJnZJUvUrpqV3al
   h5pD8zjiKes2E2XfF07+8tc6bLyGeh523L9wwYCbPWwnU3gA3D9zXFP5G
   Y7JVd6BypPXkiRuOA/AfIlwKO/CuAwyWKfd+nBLRfjfpwA5R2AP2mF9YJ
   YeaSrsznxqHYx+Piwuol6QkcHJuWuX2lunkpsTnLrIWRtzoPhWdGqPr1p
   gh+14aD78a7dESSBezSeSseE+nSjXZkmRTPCAaV940DaIcfRKyEtv6Ef3
   iaCFFEIqmqTYo/YThi2nBCK5ceqRSE/enF74zT4fTZslaCFeRHB/LYF2S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395553791"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="395553791"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 14:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="776636037"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="776636037"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2022 14:07:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 14:07:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 14:07:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 14:07:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 14:07:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByIbe/1o8Abq3V7gSJeJ5fgp4egpJVghGvvIDuN12EWecAwt4vlCeqQb/W14SM60QBtZmJs/WyytfmJ8hQwSPIqKAOUeCdWQtyaX/q0rn8N5cWZLq+t4SaT9IL2RW2LeRzf0GZ47LQXxXC8M1DHX7P+zPsBQwW+uZsFxnnV9Org+KnmQ5e9fzE5WUMIOSonr+t2KfUVaYH8F/g2gbW/OfqdStDsN/++dI1T/4irU32rdD+sN6VzHAib6j9H4w5RG7tRJELh2gM3ZCiBdbLkjqxfry043wFdmUdsTP2n6iyo2umbExA3C4AYd074+SWarkQ3iOCCZCc0hQSui/Px84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y3pB26BvgQb4SqWwUYxYfWXiQAy7DEkrBZ/wMxQvWU=;
 b=GAsvdYeQ6gohQM1HSYRFvw01p7ieUluJPtTppwepkoD7MaCq7gjipggduYcZrV3CXp3NFQg7jDdKv3c1ZN3Vt0OarMB0qn2ucwoHV4Hmx9dA0Yr+JbNfiyuS8qV20em6BSRMukNqwBI6k6OyZ7LM+2+Qw7fBA6fsdRA2SJYy3XEGYWCkfZ8m1K78jfRm9qBsYY4xnSm7DFn8rlsR/1P53Sv86Uvqp9vyB8eve9rgIXU7/YV+C5J8iY8d05w4I+R3h/jP+36bb37VkZirh3S6YoqoLLTSlZBCqfvSuuud1Ep57euczwxidTYTQyAI+CUEY8xBFT/RaHMiNrS56DzZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3771.namprd11.prod.outlook.com (2603:10b6:5:13f::15)
 by IA1PR11MB6123.namprd11.prod.outlook.com (2603:10b6:208:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 21:07:17 +0000
Received: from DM6PR11MB3771.namprd11.prod.outlook.com
 ([fe80::c5b4:b2:b261:1562]) by DM6PR11MB3771.namprd11.prod.outlook.com
 ([fe80::c5b4:b2:b261:1562%7]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 21:07:17 +0000
Message-ID: <e1a0c31c-c1a8-02de-800a-1087adacfada@intel.com>
Date:   Tue, 1 Nov 2022 14:07:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 09/14] platform/x86/intel/ifs: Use generic microcode
 headers and functions
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-10-jithu.joseph@intel.com>
 <8cb7050c-d8e4-08ff-fb34-1df207a738db@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <8cb7050c-d8e4-08ff-fb34-1df207a738db@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To DM6PR11MB3771.namprd11.prod.outlook.com
 (2603:10b6:5:13f::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3771:EE_|IA1PR11MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: c34d3e1a-f055-4da4-618e-08dabc4d0ed1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyVR4vMqlRRqB7lNq4tq4d7nGwFK6tU4RC0A8bMfepxL7UMxFfZene4GFaG7vimjK+dm0caqlsnvWhsAAGUG+55XrSzLUQP27Q4qCHO6iTnAggyerxRyiAGDTH05rmzTRA6FhDV0CQmvF7ckvVHBoL3bptjXIzN792DqhW2NQks71DZQtF4url3GS2u9rd/mPfcdtr8AOfClpr0GfIARaZhipB72d3VoYKF7pSapPk0YwPEzX1CKl59Ykaxz6DoPPUUPPbD26ws5vaqKp74+K11j+Aq+bZtG5IAc36koE6wpIBxftPewqiRdWE1rYXmV6BQYuVmE1Ew8rxxcSx9dincKPm5yQ8mfFLote+SKttuvHq63zp8JJTBG5LaNYglidgqCYb+gdXVD/Ioib0wgTg312/hrjygRVWJSbDCE6q5zNP+ssNh3gQNi1Z6h1cpT7p4ZdCAaJvJBHuCxduhUI45+VJOekeeUIh4j1Xb10aWZzIRrtuUR17k19aAH0WzaD+ttRdXAkjVKbtUhR9aSs3vggkHVbcTq2mJjB4jLPOHcreg3VPOlGdUvbFZw7KwkaS+Ji7jTuU49o+QIBP2HiP5DTR1tOjRJXNE9TEZ+SLhoUZFz94a31/0Jtae3s/1BIYUSqzJirY8Tx3mDnJ2S9YxqlpC4qzGk4cPO2aFbZMyQ/6nkeMhguXv0yzutv5NdfUy9eRAHxmWnrBFp0CA3uFmf/nY5f6QwsaqcsNUbQg55Z5vN5D+oGhB++xbNYudqoRngyZ991gxQh8kN8N43U8ug6ZL9Ps+2O8/lkT7l6JtVlDQoy0NI2UBektKlO0Qxbu7JpDoOvDrx8ytcm6jRew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(6666004)(66476007)(66946007)(4326008)(66556008)(316002)(8676002)(83380400001)(41300700001)(6486002)(26005)(38100700002)(53546011)(6512007)(86362001)(82960400001)(186003)(2616005)(31696002)(2906002)(31686004)(36756003)(6506007)(478600001)(7416002)(5660300002)(8936002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si9JZ2NEY244OTlDL1NhTFFXRGIxU0FUeHNtSmFJTkQ5QWw5dWRRTThqSjZN?=
 =?utf-8?B?eW10dCt1NGNETGp5ejU0alJSU3VjM0YzRXFjdUxFdkZEYkxMRDc2ekhaalYx?=
 =?utf-8?B?VERxbVBCbkFWaTN1Um1tVEVYTlFNREJsb3BMM2FrSnNndUkveUN5WDduQ3ky?=
 =?utf-8?B?dW5ka2NWV0M0TVNSVng1STJnYk5ybDEzMjZPb3NITFFObzBLb1NYNWZOYVdj?=
 =?utf-8?B?d0Z3bWhJbWM5bzYzNkVTSFg2VlJLUlFnZnllYzNNUWkrdy9lRlNVbEttYmF0?=
 =?utf-8?B?cDlSY0VSWjZTbTNqWXFPbGVFMHVFNG0vOUZtMEZGdHdDazYxWEFxVlJxK3Ev?=
 =?utf-8?B?YkVqWGlsYUZqUkpETlcyNUxmODBmN2ZhU0lZdmRINm9oOXd5d3d1cllsRnRZ?=
 =?utf-8?B?T1oyTXovLy9lUE5WbWhETGtEMnhUcEx6MWJ4QVhyeDVTdzM4ZVhFclI0Q2Nl?=
 =?utf-8?B?a2pSazF0R21aWEtsSXcvTHBXekdYNDg5NFBBNzFMK0pIT1ZKZU93VGgwZ1pF?=
 =?utf-8?B?Tm54c3cwVEZBeFM4K0svc3d6Um9HQWdIMFppVld2Q3dVYXNITURkRE05d0lJ?=
 =?utf-8?B?S1hXdGgvcTY5amdsd1RqMUVvRmNpZXBxMUlyTFAzOFV5dmlrYTBFQzI5VGZ5?=
 =?utf-8?B?b3pBRlZVMmZVY1lscWZHaVBCSW1RMFd6RVNmcDlHRHhxQXhuT2JGay9CWU41?=
 =?utf-8?B?a2UwTVJ4a2tMTDVlRTliMU1hQnJxV1hQOHhTNWJlanQ0SWdvQWIyUHZxOTBm?=
 =?utf-8?B?Vk90OCs3MEM5dkpqUXd6ZHV3azFKdlhJNHl4MXBLUGpMMkpuREdvZ3lsNmtO?=
 =?utf-8?B?YkhXV01sSVYzbXVoa1ZyUVlHSkpkcjRGS1Mvb3l3bnZ4WWVsNjJGanNNNEIr?=
 =?utf-8?B?djNrL2llN3IrQkdHbUhUV0NQNGd3UFNJdEFvU0RGd21qYWt3RzV6LzhUQUFQ?=
 =?utf-8?B?djhwNUJBMGd1RUJtdmRvOWJtNlJtbUcyRGZjNXNveS91NzFEOFhWdFZLS1lt?=
 =?utf-8?B?TnJ6Y3VqcEdOL0tRUzRWamFDN2o0a09wWW1wRld2OWRjb3BUSEFQejRNbklU?=
 =?utf-8?B?REZ3dmFpQjlOTGc1Qyt2ZDVlcjhnZXl2UDQ4bUdVUDJaMFlhSnRJb3I2SkxZ?=
 =?utf-8?B?UDR2VVM4YUI0a1V6KytwZS9Tc1c0WlhGdFFOdDRMb2hnSHZsTVBaU3lycWFa?=
 =?utf-8?B?STdtdTZrUi84OUpOeTNwa2RhVGhad2JqNWZGZ0ZBajVKMi94WGVEZmVDVldi?=
 =?utf-8?B?M0c4UzRqT0FRNXg1Mm15R1J2ZHR5OGRyeTFPd3ZpQ3dsNEhhWWtncm9GbVFD?=
 =?utf-8?B?UGhaMjNJeEYreW5zdmlGK2k5RWpNRXlRcGlmVjR6L2xRQmozODZPUC9QbG55?=
 =?utf-8?B?TVc1eTMwdXpNZk0yc1RKYWRnNFIydnBGUmxqK2sxM2tpZ1JDdGZvWW9YbGNE?=
 =?utf-8?B?dGFQanRlblE3dkpQMFNDakM5Mm02SktZcFYyaDFYb0VUL0xUV0VINGF2MFVW?=
 =?utf-8?B?d2owWXIzaXpnYitpZ2RnMndjeDZ5V0R4dVJ2L0UrenRLVjZOZHU4T2twVmhr?=
 =?utf-8?B?cW4yTzR4cDdVVnp1Sm5NQ2N3dzY4Qm1NdHEzbWptdmE4M3hUMXkwOFZvaVNO?=
 =?utf-8?B?aTExY0dSTXh1YlhYM2Vxd2EzVXFVOWxjN0VranM1WW52T2I0SG5uWmwvYkFz?=
 =?utf-8?B?aXVDM0VCeW9HNHAwM284Q3pzb1dVY0hMNGFvbmJzcUFCVVBiVGx0d3MyNnZr?=
 =?utf-8?B?Z0V0Ym80R3gycGd2eDRhVkxkOVhYaGVNdHgwVlZqTFV2Y001NWV3UXhTZ3Rk?=
 =?utf-8?B?QjVWVThTdmh4b3IvTVd2Z1UrZFlhSHhLRTRiTTJMd21FV2RqTDdUVkFJWUdJ?=
 =?utf-8?B?ZzVXZ2RBNHJPK1hqNXEwaFVjQmhmcGMrTllHbEl1MTFKblJhc05OUFM5VHRq?=
 =?utf-8?B?c3l0RW13djlGNjE2YVZrSnBIeGNXaEUzZG9XRjlnWG5Yd2F1c2ZtVTYyY2Z4?=
 =?utf-8?B?YTlmSm52d1JOUkhzU0RDbndrSGFObUl5VEtoaWFwSkNDdXZvYlFlTW55V0xw?=
 =?utf-8?B?Q1cwM2ExYWNlLzBpTm5WSmU2Tm53a005bjNKSVZQc0k2WVA0K0JoNXB1WElx?=
 =?utf-8?B?bkY4NzlyaVAzT0YzRE9jVmFXSFJ0aDAyMk1ad0xXM0pnVWNHS2VmYU85R0ti?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c34d3e1a-f055-4da4-618e-08dabc4d0ed1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 21:07:17.5328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdONlgTbnTcu37WEWvBMcf/HSiRPdpgJdhka+ExKnC6mlEgto4LI3mb9x5BKyHeAOqWVcG+qyA6cGNyaMSxExw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6123
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2022 11:37 AM, Sohil Mehta wrote:
> On 10/21/2022 1:34 PM, Jithu Joseph wrote:
>> Newer IFS test image headers will use  microcode_header_intel->hdrver = 2,
>> so as to distinguish it from microcode images and older IFS test images.
>>
> 
> IIUC, older IFS test images would no longer be supported. Have they been released publicly?

This is true. The modified driver would need compatible images. It has not been widely release (note that the driver is under CONFIG_BROKEN today)

> 
> What would happen if someone tries to load one? I am guessing one of the error checks would catch it. It might be useful to describe this error signature in the commit message.

This will be caught by the sanity_check()

	if (microcode_intel_sanity_check((void *)data, true, IFS_HEADER_VER)) {
		dev_err(dev, "sanity check failed\n");
		return -EINVAL;
	}

Further the version mismatch dev_err from microcode_intel_sanity_check() would also be visible

> 
>>   -    if ((data_size + MC_HEADER_SIZE > total_size) || (total_size % sizeof(u32))) {
>> -        dev_err(dev, "bad ifs data file size.\n");
>> +    if (data->hdrver != IFS_HEADER_VER) {
>> +        dev_err(dev, "Header version %d not supported\n", data->hdrver);
>>           return -EINVAL;
>>       }
>>   -    if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
>> -        dev_err(dev, "invalid/unknown ifs update format.\n");
>> +    if (microcode_intel_sanity_check((void *)data, true, IFS_HEADER_VER)) {
> 
> I referred to this in a another patch. The data->hdrver is already verified above, why is there a need to pass it as a parameter as well.

Yes,  I noted the rationale in my response

> 
>> +        dev_err(dev, "sanity check failed\n");
>>           return -EINVAL;
>>       }
>>   -    mc = (u32 *)mc_header;
>> -    sum = 0;
>> -    for (int i = 0; i < total_size / sizeof(u32); i++)
>> -        sum += mc[i];
>> +    intel_cpu_collect_info(&uci);
>>   -    if (sum) {
>> -        dev_err(dev, "bad ifs data checksum, aborting.\n");
>> +    if (!microcode_intel_find_matching_signature((void *)data,
>> +                             uci.cpu_sig.sig,
>> +                             uci.cpu_sig.pf)) {
>> +        dev_err(dev, "cpu signature, pf not matching\n");
> 
> What does pf stand for? It would be good to avoid abbreviations for error logging.
> 

intel_cpu_collect_info() comments call it as "processor flags from MSR 0x17" ... I will 
expand "pf" to "processor flags" in the above message

> 
>>   /*
>>    * Load ifs image. Before loading ifs module, the ifs image must be located
>>    * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
>> @@ -252,12 +189,11 @@ int ifs_load_firmware(struct device *dev)
>>           goto done;
>>       }
>>   -    if (!ifs_image_sanity_check(dev, (struct microcode_header_intel *)fw->data)) {
>> -        dev_err(dev, "ifs header sanity check failed\n");
>> +    ret = ifs_image_sanity_check(dev, (struct microcode_header_intel *)fw->data);
>> +    if (ret)
>>           goto release;
>> -    }
>>   -    ifs_header_ptr = (struct ifs_header *)fw->data;
>> +    ifs_header_ptr = (struct microcode_header_intel *)fw->data;
> 
> The use of a global ifs_header_ptr seems problematic. The semaphore operation before calling ifs_load_firmware() makes it seem concurrency is expected. Can ifs_load_firmware() really be called concurrently?

Multiple simultaneous loads or simultaneous loads and run_tests should not be allowed from IFS device standpoint

Synchronization in the form of "down_interruptible(&ifs_sem)" is in place at the sysfs entry points (run_test_store() and current_batch_store()). If that was not present there is nothing preventing multiple loads (current_batch_store()) or runtests from being called concurrently.


> 
> If that is not true can we use a mutex for synchronization?

Since we are using the semaphore initalized to 1 (using DEFINE_SEMAPHORE), I believe it can be replaced by mutex APIs (mutex_lock_interruptible() in place of aforementioned down_interruptible()) . However I feel this change can be taken up separately as current series doesn't introduce any synchronization mechanisms and the existing locking in place seems sufficient for the synchronization needs of the device and its operations.


Jithu
