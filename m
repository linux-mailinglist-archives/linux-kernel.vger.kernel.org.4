Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B4B71A282
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjFAPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbjFAPZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:25:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A01B3;
        Thu,  1 Jun 2023 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685633109; x=1717169109;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uqoypT2AzYO6T4VwzRI3FcYtLihmrDy8A4zn7zUgV0U=;
  b=nCEAopnZ7vLogofthKSg0+UBut4ByrDbTq7qr60WT2xNWM4j1g3+j30i
   ZV9CwiLb4JArte7+tJF4FIqE9bBgn+pMigT+e690gnTf7SKcgiDCMVG8h
   FQILsbvFSkXHX1knuozKn+9hSNxH5oXqNvKireYODKrOh/zHyIjjEyC3i
   r4qIjYD4JZaHupqo4l6cLMyjqjkBDYf+FMFsJyaQVuaQ9eUK6ZuVnZ3IO
   y36GB5v0rDkpsAwitIpqn4vOpz7iDdEhrFCv+w0ruY9Gpsext/bPqe9Wf
   UeBLP5Fp9XeXp32YYKTMqhtdLYqUrk9hTeNc6oPMwwb+AZbg/nVFbyVYK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419110367"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419110367"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 08:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="707409432"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="707409432"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 01 Jun 2023 08:24:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 08:24:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 08:24:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 08:24:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 08:24:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOuvP+wNRYJaDtdgN0SUGrgs+Fd3u5DINuiLW/KtuCBJQF7cNgvnNtSYBGeJ0uF4aKmhT7nDV7x7ylcCWU8sHBW1wi7g5fTvxvCf6Y/ZCed5lndKmVXV2uiewAQGDSVIKC11xKCFmvIYNjnaPtMjdOaW1n1qRGMHToq9q/PNCs5+ALHmGPippffE1ni52qbV1YOupJIatXnC9vwSkTnf5TsF0eFFil5vmj78bkM9lIWGcHQslNwM0vVt5KYrsPv0ztwtNZwBSi3WOj+z/9tFHZ6KRzqupcBPJ5HduuDbQYB5nkZbFferVLTwO0JrMndGwf7KiICb4F3LglC+0tFAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzsxpye32j2BZeGZHljJMHJsz5JZsaizUXKlI9He2cg=;
 b=ZaXZSpVQaYpigtoWcQqs6sMhRPyWfB1M/9i0wWL7VBMZ0y5+rSWxCWRNEb6L3FqWr4/K//+7JCF4LxCY4qzQ6WUhpb9FxDOFQDtNK6RNb+n/YvZx+4W7SDNTP0tI24tSeFeOk4Uo5ubhqyUPAhYWIOSUJVImNI9M+j4aw9AoSn+x6YhlKE9IfjdEdzudh8zTZZ9X12Hakko/QsmIFCKscx5G0UcjNf2es1PjSasjgbm47O36AQBTPu1rfHWw7l4gudFqxo1fmebEWKNB8ov68L94Z1zKBTZ8OGmAgU/7ANS2vTv2qb2N7mytpSmHo2dDxNrJe5ggfDjF4BzH0YDz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB5826.namprd11.prod.outlook.com (2603:10b6:806:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 15:24:48 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2%4]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 15:24:47 +0000
Message-ID: <9997bc22-239b-ccc5-e7d4-a179144fdde3@intel.com>
Date:   Thu, 1 Jun 2023 08:24:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH] acpi: Fix header declaration of acpi_arch_dma_setup() w/o
 CONFIG_ACPI
To:     Robin Murphy <robin.murphy@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>, <lpieralisi@kernel.org>,
        <sudeep.holla@arm.com>
CC:     kernel test robot <lkp@intel.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <168477156440.3873520.6153672647621739139.stgit@djiang5-mobl3>
 <0953941a-ad4e-ba7e-4f4e-64c47de71f0b@huawei.com>
 <1751a3c4-a6b0-0a8c-cd1b-c05d25d30380@arm.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <1751a3c4-a6b0-0a8c-cd1b-c05d25d30380@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:332::10) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f46799f-9de8-41f6-638d-08db62b4559a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+RgaFOZRa6tc3No7TKsuIAX9NNyqSV+hl/0yiLoQ4nlp+QxwIO0G/EF/Bwwr+EP+oR/+0BQ56/1dxgg/9BG9oD8JhydLm34JNCbhJ8puL7Z4/mnO68oFjhqwV316TsRov4/SaQDsR271fOmgEsqehemS7uAmEhJNY8cWI9bYLCvwiliOLYv9zUODm8yKD4/OgLn8blLP8N3aR9fASFHaeIThOm9G4VQJ/KqZrqCOTmQdvWH7enuVKfSLzR92cII1qyUNo8nvT4Le0I0wx8hHiCR+dxF9DglSbdeG8qQapqIfHpFtKiLurladdCbFw+OH1kCdvidN4j1rWQqezxIKZrc1Dcr1hb3Ftpj6FA7q5KXQorQSD9Xz50O3ZvNJYItmWdtLV38bq3gd3Vd2zFDtfWFc3hI0gL1HAAcDY/z0HwfPrs1I4LdjAi50WWMxmkYPYwupHyl4chpGZzYxnzO405rvCXcYHOQa/KylF8UiaEvDYjzzRx2cfltHf/cWnyMYeQZKCrKc/fpHoLm3EzzJx5+0DOX2CjgzyK4J7U9EF+Czuh0Je/nYQXxXf7yxSjoMjqE0XYzAAbPyJaebnwJgoLAFyP2a3Pg2ATwfsz/Gwwa2Ye56LgxlqyFhM+pfSZ8bUhVllSiaMFVvmNj+DmDIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(54906003)(110136005)(8676002)(8936002)(4326008)(2906002)(66556008)(66946007)(66476007)(316002)(41300700001)(7416002)(44832011)(31686004)(5660300002)(478600001)(6666004)(6486002)(53546011)(6512007)(6506007)(186003)(26005)(83380400001)(82960400001)(86362001)(2616005)(36756003)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3B0a3lvRW1aQ1ZDMFlSNmdiWkQ2NnV6WnFEVkVpcUc1SG5wRDdUSHVFV0lF?=
 =?utf-8?B?K0ZiSGR3aUwweWhPRkI3bml6QU1SV1BWMmxyU29EbmYvNmFmU0VUam5oUWxy?=
 =?utf-8?B?M2hFRGN6MStDbHFWTVNmZ0RRL0hEZHlod1JOTVZXVHUwaE1uanF6SkFvWFZ6?=
 =?utf-8?B?UG83ejdyUG1hdWdrYXRRWE5jc3NySnV0QnRSOWljaStQZCt2SWNRbUk0TEdX?=
 =?utf-8?B?cndycXpQeWlWOXY3bEdmeXlmbGhEZ3o4RjJnb0pKWjFsS0pLOEtPUURGQm9N?=
 =?utf-8?B?OW1rRFU0b3FMVkE2WVRqTkpnaXdHZEZ6Vkswa0JISHhIR044OEVXSjNQazBE?=
 =?utf-8?B?V0VQdTJYNmxoMTNaZWlSeE1UUHlhdW1aMFBWbHRPV1lHcjMwYjBMZ2RZcDh2?=
 =?utf-8?B?TEZOVnd2VnNyRTVIV2hteVdXWTFpTXRCejRzTWF6YlcycFQ3SDhaYzVvRDVF?=
 =?utf-8?B?WUlvUFg2TkVPZUU5N1FrMFBqaVpEbXAvS3VwZEltdDNsZWVuRXFSQm85VnVx?=
 =?utf-8?B?a3ZHa2RCYWNsSC9oRUZtSUZzMy9TVjlzN3hrV2hQNXQrNGkySDFIRTJFbTZP?=
 =?utf-8?B?MFB0ZUtLRVdjakVQWnJUejdYckYyM2R1TVlSZWhFZzczNkRPc2lqblpYQXpL?=
 =?utf-8?B?K0xJYll4a29PT3FTQnAxYWU5cUV0NkM2aTRjN1Avcy9oSVVlTUpVbityMW9L?=
 =?utf-8?B?WFNYcFY0emhrL0NqSnEyMEIyZTVNZ2thK042QjJzRjhjRk9rOVpSZGt3L2xI?=
 =?utf-8?B?dTFub2d5SGlqcEtIMXZsZmhqdlR5d2pQb2lCY3M1VmgrNDBGbzdhSU5qN0s2?=
 =?utf-8?B?bEJIU1dIaERWZTFnTlhSVkplaFpYQmcxai8rZjRmYjdpUXZYM3lCMFNJL0FP?=
 =?utf-8?B?c3dNbk9PdTNVMTFSYnJ6YkR3Sk1iYWdOVDl6MUgyMWZNNGhuZm4rb0FtYnBs?=
 =?utf-8?B?VHZveEE2RHN5eFJGK0d0T3o1cSt4UkU1MVNlc1d6cjJROFZWaWVNWUZDakRa?=
 =?utf-8?B?QVBkSnFNaFFvNyt1cFZCdGNUZkl3NjFrUkhQb0VpbGFSY1ZtdFRZejJ2UGM3?=
 =?utf-8?B?ZUM3Zm1yaEhnNDI4K25TR3ZzalNQbFoxZkUwUy90T1NIUyszYVpHRGpnOTc3?=
 =?utf-8?B?L0pVR3EvYlZ5d0ZGbVkzdHRTTHVXNGVUSmZ4UGFTQ25NR0RmRVFqdUNRcVF5?=
 =?utf-8?B?Q0xiYkc4NzY3ci9HM08zTEU3MXhCNTdoN0lndlIwcTRFdlhOMkEzaEIwcTg4?=
 =?utf-8?B?L1prZ0IwSEVpVHhBZkg4aHdsRzV3QlQ1aXZPS2dBd1lvUVJxZ0NISEpYZ05q?=
 =?utf-8?B?RXJyaFJ4Zi8yVFJSazZkeTVPS3J6QlZWaGJuVk81amtaQnFCajJ2VDVoTXVi?=
 =?utf-8?B?bndhbmZ2VG1FZC9xcUJ0cWlWWm1qOU5tSmNjYUlaK3R3K001VzI0T29tQ0Rx?=
 =?utf-8?B?Rnhsc0MyMUtPSW9rWkVwWk11eXRndmJ2Y081bjVVYitRTWhIdFVtNUhBdVAx?=
 =?utf-8?B?czJuRnlmdi9NOFg0SmxJcDBzVEVyUEpkaHZVeVpTTmRwNytFMmxMWk1HUkls?=
 =?utf-8?B?QjZUZTYvWnJGaWxhaTJTY2ZmN095b010ZUNyUC9IUmF1ZytuRHBGc1U3R044?=
 =?utf-8?B?YUVyV1QyZWpJRDRmcE9CeWljZDk1QWxQclNJWHF2QXJ5YnJ2Q0w1cjlPeitK?=
 =?utf-8?B?OW5NMkI4RUZOaHFHeFpYVnZjQXlVQXVaeWtUY2RDdEl0OUdIRWlKWkd2VCtL?=
 =?utf-8?B?QjFMdk1WWTM3VnVBMFZCWVFQcHp6RUpDVCtrZHFnMHIrR1BUT21rYm9PNFBV?=
 =?utf-8?B?a29iTDdTQS9KVUFXVUl4c1E1M1AvYTNFWjA1RTlaalBqclFUNmpDVUxxaWM5?=
 =?utf-8?B?cDlyb1IvVWtuaUE5YUo2UXYwY1dnaEQxenlTdVhFUlpjRDZMeTRTWDZZcHNO?=
 =?utf-8?B?dlhJK3lzSTdnWHo2YlNZenpGQkM0V25aKzFIaG9HNFZZOFpoV2NaSDN1Zm9T?=
 =?utf-8?B?TFMzQ1NWTTRWOHZvOGo4aUkzWEZ2WGwycUZWMnNmb3JBVzhaSVpkRWlmblU2?=
 =?utf-8?B?QUJoMnAwVkhGcmtvMmoyT1YvVGVpNmVYelhpNUxtWFZYNk5UTzAxeUYxUG5w?=
 =?utf-8?Q?EwePyB5xrRZa7Ntv89+00stcZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f46799f-9de8-41f6-638d-08db62b4559a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 15:24:47.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfILlAMv6oSQLJuB8EgRxDHRX6sR3FCK2Q0Ag6Xq1X6t3FxETMG91SoibnvYDPWHWMiCoeslvREp/1tndGs4wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5826
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/1/23 03:31, Robin Murphy wrote:
> On 2023-06-01 02:48, Hanjun Guo wrote:
>> Hi Dave,
>>
>> Sorry for the late reply, I have some comments inline.
>>
>> On 2023/5/23 0:06, Dave Jiang wrote:
>>> arm64 build can be done without CONFIG_ACPI. The ifdef bits for
>>> acpi_arch_dma_setup() is placed inside CONFIG_ACPI. When CONFIG_ACPI is
>>> not set, this causes warning reported by kernel test bot. Move the
>>> prototype declaration for acpi_arch_dma_setup() outside of CONFIG_ACPI.
>>
>> ...
>>
>>>
>>>>> drivers/acpi/arm64/dma.c:7:6: warning: no previous prototype for 
>>>>> function 'acpi_arch_dma_setup' [-Wmissing-prototypes]
>>>     void acpi_arch_dma_setup(struct device *dev)
>>>          ^
>>>     drivers/acpi/arm64/dma.c:7:1: note: declare 'static' if the 
>>> function is not intended to be used outside of this translation unit
>>>     void acpi_arch_dma_setup(struct device *dev)
>>>     ^
>>>     static
>>>     1 warning generated.
>>
>> drivers/acpi can only be compiled with CONFIG_ACPI=y, so
>> drivers/acpi/arm64/ will be the same, not sure how to trigger
>> this compile warning.
>>
>> I disable CONFIG_ACPI on my ARM64 machine, but didn't get the
>> warning you reported.
>
> Looking at the linked LKP report, it seems it's it's explicitly trying 
> to build drivers/acpi/arm64/ despite the config:
>
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 
> O=build_dir ARCH=arm64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 
> O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/acpi/arm64/
>
> So I guess it's a problem with the LKP setup? In general, trying to 
> build arbitrary parts of the kernel which are configured out can never 
> be expected to work.

It seems to be a problem triggered because I was working on some patches 
that added obj-y at the drivers/Makefile for acpi/ and opened the ACPI 
dir for !CONFIG_ACPI compile. The code has been reworked after comments 
from Rafael. So this is no longer a problem. Please ignore patch. Sorry 
about the noise.




>
> Thanks,
> Robin.
