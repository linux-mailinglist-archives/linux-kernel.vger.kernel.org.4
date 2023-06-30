Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C31674383F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjF3JXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjF3JXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:23:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1687135BC;
        Fri, 30 Jun 2023 02:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688117021; x=1719653021;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v+pyOGnnV8PRg23JLEgQxHV09DLKDMv5kiOi0HeGwsY=;
  b=kZvl8ovJGVSx201RPaTeXMD+pxGfj2X/C2trP6A6H9zlocCcVrZD9Mav
   oxNKf6yyUbYDm+NWzA94WkjJr1h8wn3qlwqfaLVAJGOb745iBuucN9LRe
   chpmH10HUICDc3FdkknVG3N+nzrT7GrOWtPygZicF6Fiy7wgTOoB4+kbt
   IG5VZrycM3CTx8k5kYTy4bVj1sjaTM05H+3yESkrk8UnkNLNqvRWJcINI
   P1ku9aA7LVW1xz7qqumjxnv2s8vHjOSBb0hzaPq5ihTaME9McDBRg9YdV
   UQkXr9etAMk9auyiBu+nxNtEKxeeYiKA8UqYQDk2LL14jqFB99hzcoI/K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="428397029"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="428397029"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 02:23:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841799478"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="841799478"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2023 02:23:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:23:39 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:23:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 02:23:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 02:23:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsGbr2E1JIbBASMtTpj+Zzo27thnCSU5k3NBGdPCwMd29JxsXnRTWcpO1Gj8xqwQVlLb4bsKaHkU2j5WWl7AReWM4jYsyVIoyJdXF714ao/a3JNsqIoCX6AGWdzajYKT5jpK2Lq+suGxzamhaSbmJcAoW9XIqshe4KvUZjGgikS5LbHGRC3HJn9H1Rx7xtYOxMbMYHa3AdB7NdxP+zWBVnhZ19TM2bguB7KUe1XcuZgebe0qhLMU4YdhRtKEi+WxD102Gy0ACUsyTLGz1oNozvJbprsRoPJkZOlK9rweUYYVBPn7DgRYmWeqiQYBQ9EqzRe5TQqxuYn+Zp9o/9tRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3YeItrOIJh8DuYeBOvrUFqN9Wx5CnhMuvTwY5bcNYE=;
 b=QhxrU1mmx9oF6HFmymITdQMXMd+N0yhCGVS1PwSAirHtabNiiuMYGthQil97+E6gBVurZPI2ZcaYVirypEsqF4krTYGOEDInjhgyCxxCYTOhXqDj8hpMwchIOgLfBqgbWv3PKAS59P5NHZFFed8J8Aa77MLk0873HAH47M39Emua9lUcrX4Xc0WLxCu6i+OPV0jmNH3iYzvKnzaWluAXzWmfwPmt89qKxJBEXCNghj8AK47fe99femrmZL9yhBspLJvI4+U1m2Fci3sM7+uZxwOrqtJT0Q2dPWkv72wXgLasIZfIJavnQt5qoSHt71BNnfezMqkcxWNA7klPT52+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SA1PR11MB5876.namprd11.prod.outlook.com (2603:10b6:806:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 09:23:33 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:23:33 +0000
Message-ID: <ba919f97-894f-8fd3-fdda-1f170c2a6fe6@intel.com>
Date:   Fri, 30 Jun 2023 11:23:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/5] acpi: Introduce new function callback for _OSC
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <andriy.shevchenko@intel.com>,
        <artem.bityutskiy@linux.intel.com>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <lenb@kernel.org>, <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <20230613161034.3496047-1-michal.wilczynski@intel.com>
 <20230613161034.3496047-4-michal.wilczynski@intel.com>
 <CAJZ5v0j+Wz7366kLT3ez5TNoGWXvsa53hBYYeS=aHgbTJUqvKg@mail.gmail.com>
 <CAJZ5v0gWuU1JPbzYpDZ6YQ4YNydyELQ9tXKcJgmLwe_=fZ521A@mail.gmail.com>
 <e94c0d23-4873-5c34-be24-c2208d03043f@intel.com>
 <CAJZ5v0h3mNFa4P+5o=LtUvTW4VnJs=4SJxvjoYMKCeir4tXfpQ@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0h3mNFa4P+5o=LtUvTW4VnJs=4SJxvjoYMKCeir4tXfpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::19) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SA1PR11MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abcbd37-fcb9-4eff-5730-08db794bacff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZCz2Dej+Avfb8c2tuku0yJuKOk9YeGpv+1sK32JkXwcyttijj2QZABwh4PnI3N4mrC+g84OJrWtwkh0+EeqGONgCy9bThng9oIxzHKdenb3qZixgyUMZQFts9G8TIDo6aPBbzRXMjYlp0PihJ8Jpzk29BWNEl6XInFQmG6Hizx1KifFqREBhQbaBEul9uQelCY2xAT3GNW4DdUHrhWnI+9LeRos3L+iQQlkT+YlB1ZxNFMOmUusnJwvy/53VPAv25ye484GsVc4p9USmsKaJMD1yekR9oD3k1c5kdRXNoN4+AxJhKDqYKo7vZdBNs0ESBXGyHJw91cttZ/fwrkl+HG0m5ay1rv785jM2InlOQcD1hJvPqEA+uva7qs+JR0CbyjeDOEo8k4+ayGbsbHRcdO95pca9ozAxm933InZMNjeoD2hMB5VLcZR8jy6RdYShO4cfi11yuBg70hW+WmkVmsxCD4ymtRZRxhHQhe9YSYjtITAHmriwCEpBRyRswlSHFL8CH5GeRkzhiOl+/EgggsBhKSesOSXN1AdW6x5ATHxBnt77KcuSz2jWMXQ8YJfznabzPDBzDllW+eGoiIjaTkTe1mdY/1uml8tiG4H9ghmbvrvLb1FgbqWQaXWzi3aEqjB2ilS1h5gjqHf4H3wxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(8676002)(316002)(66946007)(66476007)(186003)(4326008)(6512007)(6506007)(26005)(53546011)(6916009)(8936002)(6486002)(6666004)(41300700001)(66556008)(5660300002)(7416002)(2906002)(478600001)(2616005)(82960400001)(38100700002)(31696002)(86362001)(31686004)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUNaSmh3RXF6d050cHpRa0VRRERPNzZEeVJXbjRRMWlEeDdyN09tMXdrcEZo?=
 =?utf-8?B?Sm1oSGZXZGZiVWY3dUx3YXlCNWRyZXRCcVhhMnN4cFVwOFV4d1daVVg3WEJi?=
 =?utf-8?B?OVBoUGlncTdkZXFIa0ZIbkVJSmR6NzdqblB5Wm1FOUNaWm5mK0JpMDhEWU00?=
 =?utf-8?B?amdFRUFycHRXNnFzY0RqQW1HVlBoR2J5TnhaNHg0a2IxeFdoWEFkS3ROcFBO?=
 =?utf-8?B?TldaN0FFdXIvVFlMWmR1MEkrU1UwVFY1L2JNamxIZTRETEU0UXE3bkJHYVpO?=
 =?utf-8?B?NDIrQ0xNdXN0d29lN3FBT2dKNENadmg4SERxSlBkNUFDT3FkRkFFRTRpYWpP?=
 =?utf-8?B?elJWNGdsd0I3bTNhUjlMdFJlMGpQaXFtMXhmcVdHZWk0ak5iS3NPaGlUaXdU?=
 =?utf-8?B?WWRiRitLSkhqM1NzWjRvd0swN3oxSVRXa1BpSjFuZjY0OENjU1A5aW8xNERY?=
 =?utf-8?B?dmY2Qi9yY2F6S0lVSDFJMUsydC94ZkRrbTZBbm4yS1VZSzNIVUVZLzhEcVFz?=
 =?utf-8?B?YWVKYUlGcWg1Tlo3T1FLUzNwajRkRGl5NXdJTXhwKzlCUU1MNDBPZEdaelZK?=
 =?utf-8?B?UFNHRGRHNTFnUStVRk9ibU9KTm1pWEx6TXd4bTdFMFhraWduSmkveEtYdU9E?=
 =?utf-8?B?OWJ4MUZueGVmeTV5TUdNcnRmV2x6V2xjU1NpdnZlSW93M3RteXdLNXJtRmU0?=
 =?utf-8?B?OElnWjZ5K3RBanBjUjNCR2MxUWJ2Ym8xaWJGaXRUVjBJWkFKazl0dWxSVEQv?=
 =?utf-8?B?cGhsdERLRklrb2RCQnZRa1RsUHNoOUFEMmtVZmE4TVBxU2FFU1F2L241dEwr?=
 =?utf-8?B?SjZXR2ZBQ0hEQ05RbkNvNUNORktuWjdVM3V6TmpHcEdvMkxEd2ZMUUtZZy9H?=
 =?utf-8?B?QmpTd0hJdzJXR1hXZ0hxTUdKYmF6Q1NOdXgrN0g1Z0FaaUNFRUFRMVMzem9F?=
 =?utf-8?B?MmZ6dUhseFc4SHZ2SDRTNlAra01Rc3NTQzRuZVZBdjZpOHJ0dVZFclZRY09G?=
 =?utf-8?B?cWlYTDdLOEwvd0NWSmFLcFgyQXpKREFVajA5Nm5kSlBGUmtmQ1E5K3BiN3BT?=
 =?utf-8?B?eUozQzdBNXdKSG83NEs5ZVBVK0dYRUF4QXJIY3JkMVJscHlsZ0lRZUxXKyt3?=
 =?utf-8?B?VzgwMWV5MGhJWHdmT3BiWmc3cVNWc2k0ZmJoZFk4TGFNZld1VG5pL2l2Q1dH?=
 =?utf-8?B?c2lqVFhRem5xNjduYyt5Yi9jRUVOK0h1UkJyclE3dTNNYnhncXNlcDR4VEFH?=
 =?utf-8?B?TE5ETVVzdk5TTlFPdUxBUzY1VmJRS3F1MzIrOE9xd1VtQU93Y2NOUFNnbkhs?=
 =?utf-8?B?dmNadzE4bC9oQW1RaDh4U1Q2WGhhckRocCt2c2w1Z2t4SW83d1JTL0VjWU93?=
 =?utf-8?B?MGRYMzlJQ0sxeElOZmJUVFd1QkExNkh1OTVEa0lyZ2tlUlIvTWhZVXFUYmVh?=
 =?utf-8?B?ZFcvSzFCZFBBQnlML1creHZ3Wkhab2Nja3lWcnNMd1VHZDY5VGdxWmJZK2xw?=
 =?utf-8?B?WjVENEYvYkprUXg5RnJBVjZ5YjFiSGNTQWt5SEN4NkR3ZGh2RzRORVd5QU1U?=
 =?utf-8?B?YjY4TFoxSC9GVEk3eEVyTHFrbUZJS0FCcDNpV3BSaFZ0MnYzeXlvb1dON1Vh?=
 =?utf-8?B?RVhoQUJOVVp4Y1hsR3YycGR1RFU3RWdTUW13QWRra0pLZDF2MkxlcWFwbjVM?=
 =?utf-8?B?c3ROaTNLOUxaSlpyczJJQnJBV1daZS9Pcmw0ZFlLWVpYUHJLUVlsdWphZWFu?=
 =?utf-8?B?RFJnV2J6QUEzQTJ3L2lFNUJsdzJkTHBGb001ZmxSMjMrNDQ0cWhwcGUyUkNL?=
 =?utf-8?B?NUs0dzIraElXM0lPS29Ic0FUUUJETWZoTmJoWWRJVkUxancrMWwvODdMbXdy?=
 =?utf-8?B?MFBGVWl0bUsyQitUQnZBMW5ocFBuV1IwNzdIYTZiL21TY1JIcUFmUmtFd2kx?=
 =?utf-8?B?Z29WTFQ0cFVVQ1JjQkdOc3FaM2x4bzJwRGZTK29rR2tBZi9OMjBza1dveXFS?=
 =?utf-8?B?TjBialN0bC9raVZ5OWN4cnlnRklPK3pDTW9Kd2wzZVlDRkJyVDErZkxyeVdr?=
 =?utf-8?B?Mk0rUGU4RHNra2hJc0Y1d1ZITHJKWi8vZHhhemJiMGoxeDBZMXlrcXpzbHNx?=
 =?utf-8?B?akhTWFRmb1daSWhEL3hpSWMvU2pzanR2dThpZmZGcW1ld24yb2R4bTI2R0Zo?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abcbd37-fcb9-4eff-5730-08db794bacff
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:23:33.7381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oU9UsKeUqU8QWmZw55Cw9LSmg3sa6dLDEtb5Lm2iYVDorDZ9brci4gg2/ONO2KzOdgFUc7Xs4Mi6EQJPJFneOWuoLIXRJ2dG1LJFEzabXPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5876
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2023 11:10 AM, Rafael J. Wysocki wrote:
> On Fri, Jun 30, 2023 at 11:02 AM Wilczynski, Michal
> <michal.wilczynski@intel.com> wrote:
>>
>>
>> On 6/29/2023 3:15 PM, Rafael J. Wysocki wrote:
>>> On Thu, Jun 29, 2023 at 1:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> I would just say "Introduce acpi_processor_osc()" in the subject and
>>>> then explain its role in the changelog.
>>>>
>>>> On Tue, Jun 13, 2023 at 6:12 PM Michal Wilczynski
>>>> <michal.wilczynski@intel.com> wrote:
>>>>> Currently in ACPI code _OSC method is already used for workaround
>>>>> introduced in commit a21211672c9a ("ACPI / processor: Request native
>>>>> thermal interrupt handling via _OSC"). Create new function, similar to
>>>>> already existing acpi_hwp_native_thermal_lvt_osc(). Call new function
>>>>> acpi_processor_osc(). Make this function fulfill the purpose previously
>>>>> fulfilled by the workaround plus convey OSPM processor capabilities
>>>>> with it by setting correct processor capability bits.
>>>>>
>>>>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>> ---
>>>>>  arch/x86/include/asm/acpi.h   |  3 +++
>>>>>  drivers/acpi/acpi_processor.c | 43 ++++++++++++++++++++++++++++++++++-
>>>>>  include/acpi/pdc_intel.h      |  1 +
>>>>>  3 files changed, 46 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
>>>>> index 6a498d1781e7..6c25ce2dad18 100644
>>>>> --- a/arch/x86/include/asm/acpi.h
>>>>> +++ b/arch/x86/include/asm/acpi.h
>>>>> @@ -112,6 +112,9 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
>>>>>         if (cpu_has(c, X86_FEATURE_ACPI))
>>>>>                 *cap |= ACPI_PDC_T_FFH;
>>>>>
>>>>> +       if (cpu_has(c, X86_FEATURE_HWP))
>>>>> +               *cap |= ACPI_PDC_COLLAB_PROC_PERF;
>>>>> +
>>>>>         /*
>>>>>          * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
>>>>>          */
>>>>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>>>>> index 8c5d0295a042..0de0b05b6f53 100644
>>>>> --- a/drivers/acpi/acpi_processor.c
>>>>> +++ b/drivers/acpi/acpi_processor.c
>>>>> @@ -591,13 +591,54 @@ void __init processor_dmi_check(void)
>>>>>         dmi_check_system(processor_idle_dmi_table);
>>>>>  }
>>>>>
>>>>> +/* vendor specific UUID indicating an Intel platform */
>>>>> +static u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
>>>>>  static bool acpi_hwp_native_thermal_lvt_set;
>>>>> +static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
>>>>> +                                            void *context, void **rv)
>>>>> +{
>>>>> +       u32 capbuf[2] = {};
>>>>> +       acpi_status status;
>>>>> +       struct acpi_osc_context osc_context = {
>>>>> +               .uuid_str = sb_uuid_str,
>>>>> +               .rev = 1,
>>>>> +               .cap.length = 8,
>>>>> +               .cap.pointer = capbuf,
>>>>> +       };
>>>>> +
>>>>> +       if (processor_physically_present(handle) == false)
>>>> if (!processor_physically_present(handle))
>>>>
>>>>> +               return AE_OK;
>>>>> +
>>>>> +       arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
>>>>> +
>>>>> +       if (boot_option_idle_override == IDLE_NOMWAIT)
>>>>> +               capbuf[OSC_SUPPORT_DWORD] &=
>>>>> +                       ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
>>>>> +
>>>>> +       status = acpi_run_osc(handle, &osc_context);
>>>>> +       if (ACPI_FAILURE(status))
>>>>> +               return status;
>>>>> +
>>>>> +       if (osc_context.ret.pointer && osc_context.ret.length > 1) {
>>>>> +               u32 *capbuf_ret = osc_context.ret.pointer;
>>>>> +
>>>>> +               if (!acpi_hwp_native_thermal_lvt_set &&
>>>>> +                   capbuf_ret[1] & ACPI_PDC_COLLAB_PROC_PERF) {
>>>> Checking it in capbuf_ret[] if it was not set in capbuf[] is sort of
>>>> questionable.
>>>>
>>>> Note that acpi_hwp_native_thermal_lvt_osc() sets it in capbuf[] before
>>>> calling acpi_run_osc().
>>> So you moved setting it to arch_acpi_set_proc_cap_bits(), but then it
>>> should also be checked by the arch code.  That is, add an arch
>>> function to check if a given bit is set in the returned capabilities
>>> buffer (passed as an argument).
>> Hmm, maybe that's true, but the only reason we check that is so we can print
>> a debug message
> No, it is not the only reason.  The more important part is to set
> acpi_hwp_native_thermal_lvt_set if it is still unset at that point.

Yeah, that too. Okay I'll modify the code

>
>>  - that's pretty much a leftover after a workaround. Introducing
>> more arch code to accommodate this seemed wasteful, since in my understanding
>> all workarounds are meant to be removed at some point, even if it takes a long time
>> to do so.
> Not really, until the systems needing them are in use.

Yeah I suspect it might take a very long time, and I guess it's very hard to definitely
say that some piece of hardware is not used by **anyone**

>
>>> Also it can be argued that ACPI_PDC_C_C2C3_FFH and ACPI_PDC_C_C1_FFH
>>> should be set by the arch code too.
>> That makes sense, but technically is also a workaround, since we're basically
>> checking for some specific DMI's and then we disable mwait for them.
> But boot_option_idle_override is set by the arch code, isn't it?
>
> So the arch code may as well do the quirk in accordance with it.

I think so, I'll modify the code to move setting those bits to the arch part


