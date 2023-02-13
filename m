Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06C76950BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBMTdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBMTdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:33:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527FC211DD;
        Mon, 13 Feb 2023 11:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676316749; x=1707852749;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N1Mx/ZUwtrMlVJyoS0WWIPB2+ycGXyKKHySSSyRR1Is=;
  b=ilC680RSq1JLofKJtoY70kmAGEk50dGQnfLvXxMyIKfYpFGNKGcZ09KC
   CpxidNKJJrge4XRRklvZ9qatibCzCR7RuU3o1naQJj1vKdgRgI9GCFFYf
   X8+X+NQ0ZsGQ6//12Uq9DOOO71YMdbBA9IM0/D+OHZdUuv9wrnVU5Dss0
   cPR0/OzUPBjtdQ97gW8Xvtf9IFyGLsxHODKmfwu5vBhbF1FOO8vAzzIts
   F5WVIorMqG75umsZMuQF/8+b3NOUu21CL6JBsqgpzWPjoge1O2E+lTJA3
   kZWIlGj1sbWkHKjNKmJmuEJ1tMwhKQfdZsqAbL8bmAi69KyLd4BjBojBL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="319004201"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="319004201"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:31:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="732607469"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="732607469"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 13 Feb 2023 11:31:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 11:31:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 11:31:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 11:31:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 11:31:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MysP116Nz2H9URyn8zAm2ABqjEse+mopnqhVgf8g2FQ3MH+LqoQZJF1UpUoBV0lW+sEuFDv1j0HttVI3p0u6vMgkIE8MljORAT02wFdsQEuasMB5D8BfD44TatthGdNKD59noIqxbAI0AEA3e+rZAQBLWyLecrNEbSOyJ1X3g8NN0XkoISPkseieM/E35qTn4BNIt8XqFVKrxEasHrzI1/3s6msS/e31P/HqY7EQHVPC1Uu444pPN+vbzFneXPx4xsma9+2O9KL77xxRZnhDcWGr9N3HK42MW1peFC+Mdma36JE/6XPsE3soOWzUI8LJi/rhlsYi8vVH7Dwguy/viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IXQTOVX32QfFn7woH4FgpbAp6Wusn57svQofSzu/xg=;
 b=G/e3U+cHegI29T6Tj++9eE/h5KjWhVDwqhQRuZgtI2vJmP8FN58veY1Dwt9DtKCasYCtQclXuI7/dORdZmuk0rWZgpLTBoXkUDQbqq+pB1h5LOyYkYWpWb9t2ZqpkYpWvnq0rbDLkrNFP5gtwjOjDKSUPlM1r2UQ2aAOlnf5NJrf8rktstkyMY98PSKp8UbAObbejtLoY0E3UhDamUVsZQb1b1pzLVrEBHZ5H6ze0Zj4SYXLTdX12ALAxYyiEjB/qpgN0HYY87495CsSB8mcb3F+qQWUHsaWK1V1uVDN591klNrTxyd/ztaxMwTt9WIEqpMEwqtTYGb0xgC84yJ7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 19:31:54 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3%4]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 19:31:54 +0000
Message-ID: <2299e6f5-b7f7-c875-3244-9b4a311519d6@intel.com>
Date:   Mon, 13 Feb 2023 20:31:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ACPICA: Replace fake flexible arrays with flexible
 array members
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <linux-hardening@vger.kernel.org>
References: <20230127191621.gonna.262-kees@kernel.org>
 <20230213003546.GA3280303@roeck-us.net>
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20230213003546.GA3280303@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::12) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: db40c3c6-5304-4b92-febe-08db0df8f688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63GSRxYOmmO9nujjoCG4+/0/qc0fw92rGi6eGcWhHD82LESTa7MB/0qS7A/PDdxnNySRt7bjCNtDVJeeWZNlN/6cb/cFc65O/vBi+uzeBYeSFt44C21Tki5kCtn23VU4iEnezWDlfOWOOIT6BmTbP2RlSY2yCNrOZuoizFJSZKbPPNhO4pE4XN6n/fLOvGXu/T84vV+kMeZo/wgCzeZJgS3pEipHdjv/3Q/ePQTCVj+XfkHsOGUCGDmIAaL52bhVZ4zdOoNYQFjF6rzL4GRhaOYXgzonP4msAu1X+kOi4bqtYiCM6oon0NYLLJGkPpD/mAmecfnToVaojHKOEM+P+RtrIfLAuaw3DGVOtFQCJKFyAKyXGsv4+8ZI2GjDBxYgQucA7R6c5wSG7kmI1ph2R6Ovphc+Uvaho80T428auAN5HezvjI0e/nfxrAU1XqBqZE+DBq6HwEJxFpCZk7Rkkz7YF/kWJ5TZ8jEeaxAqnQBgTa4y72y/Xp21+r7Yq34SQfNvS3AAhENeP9DOhDi+LLLsgebd1xFBRpKp9RHN48/XZ4F4/WCNso0hOQMUXGHJ4pOwZbhndx4hNyx+9Y86XvkXsKB7Fl7p+v845RW6Kb4JV4bzeAq+wtbbKvF80Yc3oszpD4So3zNKRsYe1qUGNEA0pGoCWFMt1HT5lrLlp/bJTekFZ7Ro/txcB1sU2S0fTpGDV3ZM+IiLyl9Oo7ZOj5SeHlFcIjm6kNZja8G7kFdnayLrsTXp6Wxj65FWIoyxVRTwIw4qhGltI7Kr/8Bd+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199018)(4326008)(8676002)(2906002)(478600001)(66556008)(66476007)(66946007)(6512007)(186003)(966005)(31686004)(6486002)(6506007)(26005)(53546011)(2616005)(83380400001)(38100700002)(5660300002)(82960400001)(8936002)(6666004)(41300700001)(36756003)(316002)(31696002)(86362001)(110136005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlAvdEhUbU44RHNzQU9uSTRVZFhYc0hLRDBleWRSQVZ2ZWRnMUNjZ0lGb3JY?=
 =?utf-8?B?ODMyRTl1ZFdFcm9aN0Exc2JoaUEzK2huMUYxTm93V0E0YnFYSGtqSDZ6cFFa?=
 =?utf-8?B?aE5MUVdjUVFCVDFnWDRwZW9pamtzNHovaDVHaDZxK3RuSHd6RzVHaUZIdDlP?=
 =?utf-8?B?eGZJalVMWkRCWklCMmQ3b3JpT1crVzI0SjZBRUprOFVKNXFSanlRTHUycXpJ?=
 =?utf-8?B?bVJWTFMxcXNIcGxiYkl1dzlLckI5aFdrQ1hRK1E4eTBjOU93d0NSWTFqS3Bv?=
 =?utf-8?B?Y29sYlhFZ0dGcDZBcUk5NUE2QnNaMGMyNGtWTnVmNkpTTTd6Z0VDcDNyYUg5?=
 =?utf-8?B?cFkvdFFHbUszSGF2TjRBM09wSXEwUkRMblVXOVpFTEVSS0ZaeVBtQ3NGMFBo?=
 =?utf-8?B?MW92a1NkWkVCZDBFQ2pwUDRpVHFKRTBqUzNLM2FveHYraEE2TXNXdlJMVER0?=
 =?utf-8?B?L0oxVnpvSzdRTmZmZjFrMzYvNjRqaGhYTXhTVGRDN2NUSXE2amxwRHN2MGRG?=
 =?utf-8?B?b2FiczBtblRKeGdOWjZYM2UyYk0xeVpXbjZrZTVJL2NuMnJYdGVWZk9od3U3?=
 =?utf-8?B?UVJYZzdJcmFJSTdNUW85Mk1NcnlsQmsvb0dKYWRRSndQZW9CMFF3NGZjaUI1?=
 =?utf-8?B?UStKeUZSRGRRdzY0dUtBVUtIeVo0RHhOVlhqc3VSZDZwTHdGVldHdFl6cjA3?=
 =?utf-8?B?WkdET3VBeVlGK3RyNDg4WVVIa2w2ZnpxR2lzUys3dXVGZ1N3OWxaNUdxby9D?=
 =?utf-8?B?enRvdGZFUDU2MnNxbUJaRlkvQnJsL1JMZ3lNV2hNV0xGZ1RMSGdkYlV1c2ZO?=
 =?utf-8?B?MlRITFNKVzNqSE5XT2J2RzRObjBJTVZCS3dadVF0RDkrcUZHU1p1UDlJNGNh?=
 =?utf-8?B?SHBWK3ZIRnJ1U0VMMjZaWXpBWTd3YTV5WWozM0h1dk0rc1o2T1RVN2lZbXlQ?=
 =?utf-8?B?QU9XZVYvQUc0ODY3S3laQVJtRWk2SFBPUzZkNS9ORktpeVhyOElYYkEwcC9P?=
 =?utf-8?B?UE5RSXBWdkRINDZGUk5oT0x4dmVGeVBJM3ZXLzdlZ1JTNUNXSWdwTllrK2Jy?=
 =?utf-8?B?MlU3WFZwMW8xUWd1OHpUenNNK3NtblRRM25DM2U1bDIrNytQUXNjZzJnNk5L?=
 =?utf-8?B?U0gzNU9hcG04N2J1aUVZVWx2STRuNzlrenU5a2ptdUNtUGlpMjBqMldTN3Q0?=
 =?utf-8?B?NGh2eFlSN1dFUlpOQzl4NWpJYWZ2bWllQXJaUmMwanJNUVhMYlJIRVJBZnYx?=
 =?utf-8?B?VmNmZmpHMU9ZODcwNkNWRjlONStZb09DU3BYdUlBdGFKYUJQSmU0RDJodGt3?=
 =?utf-8?B?NmtpaGh2UHRBYkNjdFdsQmRuclRIbTFJMzUrNlVIeHFES0gyMjlMc3diTDMz?=
 =?utf-8?B?YTZ4UTc3N2dIcGpXeWsweU5vTVZEQTQ0Yklmd1BaZXlGa1FMM2VJSlcxRUhJ?=
 =?utf-8?B?bzAzejdUa0Q2T1E3bDZLKy9ETENCUllraWo4NldJQTBvNnMyYXg0Q2tUTyt5?=
 =?utf-8?B?cHBoUE9UZUhNczYrUGMrdVFRMklMbmU4MTh0QXg3bnVEV3BNVDc4SnhQMk9q?=
 =?utf-8?B?L0VKUG9SZi9YT3dzRGRvRlgweUVHaHpWK05BRWRKTXdoL2JkdW5aT0pMaWd6?=
 =?utf-8?B?YmVmaWhEaHAxS1N6MzdkTVNRTm5xYkRFejB2RGdFeE9sTEU0azBCRFJVSXlh?=
 =?utf-8?B?dnB6V3hsa1FnTzBqTHZPMmZzS096U2hoNFpnN1I4azB6cWQ5M0ZDTlNCdE1a?=
 =?utf-8?B?RnpaeUl2eGVkNm8vcTdNaEc2WVREYmlyWXV3bStpODZzMnFuVmQ5bGE4bFlx?=
 =?utf-8?B?Wkg0UzJyN2l6cnRKenB3YW1oL2p3bUVqZUhDRGFibmxMTzhRY01wQi92TWRM?=
 =?utf-8?B?NDZuM3dJa1ZiTjIyYlVyeDhTWFo1bnhzeTBUM29vZG9kVkprVjhBUllyeUlp?=
 =?utf-8?B?R0ptTDZqTG1rckNhSEpRaHFqdk9velJhUGwzczlvd2hFYWFvRE5UV2M2d0Yw?=
 =?utf-8?B?WS9ISzRVeFdmOG5INmxUUmRCVHJIc0FiZGcxQXdwL1JsM1hkNFBOMmJQcHRt?=
 =?utf-8?B?ZTNhaEI5VHhJaGJRamlmMWtpOG0yMWRCUElxeGM2cTlzL09sQzNGMk5Ma083?=
 =?utf-8?B?VTZGUXNOdHNZQ25aRWo3c0RJclk1NklJa05RYWljdGNiL1dVWjhUOURLdU1N?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db40c3c6-5304-4b92-febe-08db0df8f688
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 19:31:54.5873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8r1B/dmL0RT1g2caUMH30wiqi8C5ivf2WO0lOH8WIBg4xha6iwsipE1x1pc9ZNpy/wvJHfz9WYSTDQyjYKbHqYbPME2R+bH1EYAQKyl9m5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
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


On 2/13/2023 1:35 AM, Guenter Roeck wrote:
> Hi,
>
> On Fri, Jan 27, 2023 at 11:16:25AM -0800, Kees Cook wrote:
>> One-element arrays (and multi-element arrays being treated as
>> dynamically sized) are deprecated[1] and are being replaced with
>> flexible array members in support of the ongoing efforts to tighten the
>> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
>> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
>>
>> Replace one-element array with flexible-array member in struct
>> acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
>> padding in a union with a flexible-array member in struct
>> acpi_pci_routing_table.
>>
>> This results in no differences in binary output.
>>
>> Link: https://github.com/acpica/acpica/pull/813
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> This patch results in boot failures of 32-bit images.
> Reverting it fixes the problem.
>
> On the failing boot tests, I see messages such as
>
> ACPI: \_SB_.GSIA: Enabled at IRQ 117440528
> ERROR: Unable to locate IOAPIC for GSI 117440528
> ahci 0000:00:1f.2: PCI INT A: failed to register GSI
>
> ACPI: \_SB_.GSIG: Enabled at IRQ 117440534
> ERROR: Unable to locate IOAPIC for GSI 117440534
> 8139cp 0000:00:02.0: PCI INT A: failed to register GSI
>
> Given that 117440534 == 0x7000016, that looks quite suspicious.
> Indeed, after reverting this patch, the messages are different.
>
> ACPI: \_SB_.GSIA: Enabled at IRQ 16
> ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
>
> ACPI: \_SB_.GSIG: Enabled at IRQ 22
> 8139cp 0000:00:02.0 eth0: RTL-8139C+ at 0xd0804000, 52:54:00:12:34:56, IRQ 22

Thanks for the report, I have reverted this commit from my linux-next 
branch and will not include it into my 6.3-rc1 pull requests at all.

Thanks!


