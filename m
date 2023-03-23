Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731B26C6A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCWOLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjCWOLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:11:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C1E2D16A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbSWXW/E9PBPtEVPMbji9w8aKupopMtQisfS8ILW5VubpkyyyB17AosJ2x3r4fYuauHY5PazBDNIrgKb9vBhUoY3wpD+MJmLwl23cDGOYoMGULr0QxIhYfXbCdQlj5UWjnJk2CX7m/1cxOSvzJaYfM66cc+v9EDEgrIyC59WoN1yUkt6jQ2H/R5ckszJeRbU3yy8+dKRbVeKLhLfqwC71BvuOADz04K3kSCm19ycp8ybf0ysxUf3SeWRJjuyJfMphOe71SeXYUesS0gQOZo48TsqzVgp4RuefwrrXGIAM0QCJbuiqVrHxQi9VdrLUKVeNXelFCrLxnPEIb68zLr7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PJUvcQLH/qhmKpS2HRY7F738+O77TPjp3qSMMfKxbI=;
 b=gBbB+mNtzE/OMwIVraEKipcwHIX4s3AMUHFUAYbTeD/Yo+M6T2KkS5YyIw6mduLr/kzeXjKmKOY1w5rjopBAIT7vq5JKTOZ9VSMXoITUwrAsgN8c4BHmdX7M5nho5cUzc/sb11A/mNCAXqvB0QiPAHmrlctX23d7nXudtoXDxwbytQYNFyZ1f3kAOXGuazVJu/2s1/+OZ2CrLzU/t318VaTpUAFT16pFDlA2WM2swGc8iJ+LeJQYrKm4U8YScX28lToN1KNK3uIIn0yfJSa/gi/yii1Qwvx2HcJhJnH6dcFkgVuNaMoXe40rYBRd0TNMW9saRaoiS1m0LA6VdGFXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PJUvcQLH/qhmKpS2HRY7F738+O77TPjp3qSMMfKxbI=;
 b=L4ztO5WEo9kNCLxqBSwxw7/69wD78BJ6HiBOZKkUoyR5iYp8RrICEE69zOlPFx1iHQqhbJgi4u6eNrqjSJhzxaeBWlBbXcpMzz8rN1qt7mZBNVfDskrl6G36WcnRACNcVThpxmLeTlajknA52tDBnHP9Sb+v/2er8giu3RAr05c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 14:11:39 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%6]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:11:39 +0000
Message-ID: <49de2976-6e8e-0987-b423-ad65ae3bd148@amd.com>
Date:   Thu, 23 Mar 2023 19:41:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] perf/x86/ibs: Set data_src.mem_lvl_num as well
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230311000642.1270971-1-namhyung@kernel.org>
 <2154046a-2081-606d-a1ea-33fd2d48cce7@amd.com>
 <CAM9d7chDaKn57UT9D+BeZBwAQ3Mo4bVgJpign4O0De=9sFsu=w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAM9d7chDaKn57UT9D+BeZBwAQ3Mo4bVgJpign4O0De=9sFsu=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::11) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: e48c448a-7cbb-4371-0a2c-08db2ba88501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65FaqxO7uA/3bz676jQNHKqYerror6jJWOCeeVV4XEjl9DVHd5WufGB2XPiO3oXAFiTvDfAoXnJ4uzvn5OzxAyiJqURG92f8BZ/vbK7JBgPhs8IwFF1w+DD9KRlGZ3CJrFs66fnVxjosfh+RySj/3ESprqPVJz6Zn4NdijY8Um3ei4ukMQhgmlr3JxThFV8xwf+0JJId9JtHV3kgeu33FD92ppMBv7BqeODvStcyPpIFm2FzLR+TWV9XGmEF4dBQknjjdMj5OFY4UIwzAw25wD3nffafU0Yq0Uy6Kk8ttF39RgHiUEm0lFg9auF7DvP6qSjyGvA9V25WGPnaDqKYeHHhPVRO7rVGp799FneI9iVNKmTm0YjBucEeCjcc1PHhDbaV79UrbEqwRFn5j7Y6iAIFz32/V3h5cd0ozvFcahFN+bSfvAICEKo+h4TKIZ06FdV8JQ589OTVjegjhpIhj9TX2FBfB3t1L+/aVYYjfZ/JBcMB9iPVgsN04eiEW7JF9aosGgjt90Pnj1kXdc9FcqDEB69aDqDl/h0V9Jgw4p7rT2spv32iMwaeIIt4fH+2UWjJVLVxTPj2HfhKjkauEtyeMhNPfsdpFcn/FVs9tQc17S9N127Zx1rfQuf5NQrA5gccmWpHgT1LcSikIzH6IeeWQ+7Wlgj+x964W+atHRxOucblNbqK2OGzGPVv8cl1PAZr9P5+59PCOKDSIIHOrhiAp3xzqa3Lgpt0cFXoblw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199018)(2616005)(86362001)(6486002)(31696002)(6666004)(26005)(6512007)(6506007)(83380400001)(186003)(31686004)(41300700001)(478600001)(54906003)(316002)(8676002)(6916009)(4326008)(66946007)(66556008)(66476007)(38100700002)(5660300002)(36756003)(2906002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHhwOWRZMWM0cWNLL3ZzMGJGS1B5bGlHNlVBOHdoRktKaWpXTWw2cUdDTEhq?=
 =?utf-8?B?eE5Qd28wK1I4YlV4NHh0a1k3RU9XZG9FOFZyVVE5RVFqSEZxVHlDNGFKYXJR?=
 =?utf-8?B?MkJraWNHNStnRnNRaWMxek16MnUyZlVuUUlBK3B3OVhMU1pER0QrQjBDSzVQ?=
 =?utf-8?B?MllRbmZVSWpzUHU4WHJNYVFRZmN3WFR4NUpLOTEwL29BTjQ2V0JxN092MHhZ?=
 =?utf-8?B?ZUdURmFYaVQyMXRMZVdiZUk3L2paQkVBSHp4NVEvQWxLWUFKdFZHajQ0NDlr?=
 =?utf-8?B?RXBsSkN6ZG0vNnhWUlNWdGl2dFo4K0JMeHlKNDZvK1BJcUgzQ1ovWGVMU244?=
 =?utf-8?B?cnE4THVCZWNyOTVwVEx6aHdWeVNheWc4Y2RweHNMT3JsRzgxMTVPVGF5K1p1?=
 =?utf-8?B?dzljMG8rcTFJd1pBUUxRVnhyVWpkeTEvUmMrd3kyTjUrSGhlbGlEWUwzZEVF?=
 =?utf-8?B?WFhQaTB4aGgzQkxmZWdnR2hoeFdReHhBb2U3bjJxRmszS1Z4WXcrK1N4cFV3?=
 =?utf-8?B?cEp2SFlCYldtbFVWL1UyNGNyTENRU2JmT2M3TUpFMVc4Q0k4WXRKMHgyVW92?=
 =?utf-8?B?amNaSlZKYllEbUp3Zk5ISHo2VjFVWk15ZDV5WUl2OHdpMzlzUmxuTmQyRTgx?=
 =?utf-8?B?WWtEZFZNNlNBT1RFM0U3US96M2JnRUEwejh6K1d5bFQ2SGhVZVlpRVZtNlhs?=
 =?utf-8?B?Z09uY2d2YjEvaE1WRHZFTUtncXZYNDM2eGpJZ25aMitkSUxvcjVvbXZiTThu?=
 =?utf-8?B?ZTRTeFZCRUFaMHlMdTRGbUZWRy9qTGg0MUI2RERaaXdMZ0hZaS9FYWh2MjFU?=
 =?utf-8?B?eTdHTUxRWk1idTlaaGFRUWpKRVpvSVdXK2hLcTdpdTYvZkVwNngwbU1KLzky?=
 =?utf-8?B?RnNpWjhkeXVNdHJRMm9mNXp0VnV2Q05GbTl1QWRmRThoQ1dmVGQrR2tGNmh0?=
 =?utf-8?B?KzVOaDZ5NlZqam10N1BwYzBxRldjbWZwT2Z5Z3hQT3h2RGpZZmcvb3l0RlI4?=
 =?utf-8?B?QjI4OTk1ZzZTelN1TUlTQ1ZEWjdNWG5UTGZJRzVUVWtOdzVpbC92UkQ2QnRN?=
 =?utf-8?B?Zk9rdGM5ZHZsVnprbGxHUzJKNDV2VFVraW5NeXI4SlVUS0FJK3lKUlpxbUhV?=
 =?utf-8?B?WlVOWVp1cW1hWHROOXFPbERDUjM0cFZJZGNhT0JtWTdVNE1yNVUxTE1sK2NC?=
 =?utf-8?B?REZLalYza1ZLSGgyN2tEck9vMVoyVkhNRGhEOGgrRlNER1JEcEh3SjlsNUhO?=
 =?utf-8?B?Y3hENEF4VHgvVTNXeE1XeUk2SVg1OEpiUzBhYmVGdlREWmlQODlHck9yMlRx?=
 =?utf-8?B?N29SNHhUczcwMTQ0QUorNS8ySEd4NWZQQ0oyQmZTWWk3K29IL1RtMTl1UGdL?=
 =?utf-8?B?dzFweTFOREV5NUkwRjJReTkxN2hLbS9ySkVGNlAwaWFJdG5ENjJpYUFUcUFL?=
 =?utf-8?B?NXRWU1p2dHpqVHphUHNMeitIQURIeEhLWjRaMGRDYnFNVllyREs3enhhd0w4?=
 =?utf-8?B?R1VZek1EWFNTci9ZSkVoSGdURjdBbUpGN1phcXVEa1FxMXoxajFtaXVTMFdi?=
 =?utf-8?B?dGdLZEVNekpCc2MwMGdidGNWUGhvZGdIZ2RFdkhlS21ZcDRPOGxTY2lpczZQ?=
 =?utf-8?B?VkgwaW1HUnRpQ0pER1RWUWFacVFPYmZHMVNDWXZ0NVdaZ1FtaVJpL2RiVGpv?=
 =?utf-8?B?NVdyeWJWNkZKdjJOVzJWb0I4Z0FUK2xSZ2o1ZjMyMGEwSjNRNlcwN05CdGYv?=
 =?utf-8?B?cTM3TnN3QklGRFFPdWhHdTBKN3A5RUYzeWpjb01CdGYvZjkzUDJUNkxBS1po?=
 =?utf-8?B?VDhlOFF6TVVudVZGTGVMcUd0bE5qVFFKbGlJRHkrWUtUazVsRVF1SkhWazJX?=
 =?utf-8?B?ak03ZjJJd1FMZXowdUJ6a3ZjWEtoTEtLT01JSFV3M1JBMnJLVk5hM1QyamNZ?=
 =?utf-8?B?a3BGdzhIOVprT0VBUFRXRCt3R0U4dVd1Tm5ra1B1c2NNSWV2UmJFZlVpT2l4?=
 =?utf-8?B?Ly8rZTBlVkcxczF6cTU0WWRmSlVucXRCdzFUbWlVVTFJWmk0Y1JsL1BJdGZC?=
 =?utf-8?B?ME5nbm1xY1VNTmVoV2doMlJjcDlWV2xYZDRNRmdUcDVyZGVCUWZML202OXRz?=
 =?utf-8?Q?gjgbH4R9V/Tfd+R4Owj0ybFeO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48c448a-7cbb-4371-0a2c-08db2ba88501
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:11:39.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvP2bslzm2x6sMHrWJbLT/LM9k/IvFqwfK0X67HGE2IUS4RGtE3xxChYccmkeAxEHrA9L7mHBMckW38JqZr/Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

>>> @@ -748,12 +750,14 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
>>>       if (ibs_caps & IBS_CAPS_ZEN4) {
>>>               if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE) {
>>>                       data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
>>> +                     data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
>>>                       return;
>>>               }
>>>       } else {
>>>               if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
>>>                       data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_REM_CCE1 |
>>>                                           PERF_MEM_LVL_HIT;
>>> +                     data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
>>
>> mem_lvl_num does not have option to set multiple sources. Setting just
>> PERF_MEM_LVLNUM_L3 is bit misleading here. Documentation (PPR 55898 Rev
>> 0.70 - Oct 14, 2022) says:
>>
>>  "data returned from shared L3, other L2 on same CCX or other core's
>>   cache trough same node."
>>
>> As per my knowledge, "shared L3" and "other L2 on same CCX" has similar
>> latency. But request need to go through DF for "other core's cache trough
>> same node" which incurs higher latency. Thus, setting both is important.
>> This was one of the reason to not use mem_lvl_num in IBS code.
> 
> I suspect it's a quality issue for CPUs prior to Zen4 not to identify
> data source precisely.  How about setting LVLNUM_ANY_CACHE then?

Ok. Although, ANY_CACHE is mostly clueless, adding HOPS_0 will make it
more consumable. There are many other places where this patch needs to
set mem_remote and mem_hops. Also, these changes will result in too many
assignment operations. So, I think IBS code should switch to using
PERF_MEM_S() macro. Do you mind if I send v2 with all those changes?

> 
>>
>> 2nd reason was, perf c2c (c2c_decode_stats()) does not use mem_lvl_num.
> 
> Maybe we can change that.  It'd be easy as long as they provide
> the same information.  IOW mem_lvl = mem_lvl_num + remote + snoop.
> 
>>
>> 3rd reason was, perf mem sorting logic (sort__lvl_cmp()) does not consider
>> mem_lvl_num.
> 
> Likewise.
> 
>>
>> 4th one was, if I set both mem_lvl and mem_lvl_num, like what other archs
>> do, `perf mem report` prints both, which is kind of ugly:
>>
>>           464029  N/A
>>           340728  L1 or L1 hit
>>             8312  LFB/MAB or LFB/MAB hit
>>             7901  L2 or L2 hit
>>              123  L3 or Remote Cache (1 hop) or L3 hit
>>
>> Without mem_lvl_num it's much cleaner:
>>
>>           330057  N/A
>>           229646  L1 hit
>>             5842  L2 hit
>>             5726  LFB/MAB hit
>>               78  L3 or Remote Cache (1 hop) hit
> 
> Agreed.  It doesn't need to repeat the same information.
> 
>>
>> I think we should clean this before applying this patch? Other option is
>> to add bpf filter support for mem_lvl. What do you think?
> 
> I still prefer using mem_lvl_num as I think it's the way to go,
> but I'm open for change.

Sure. 2nd, 3rd and 4th are all tool side improvements. Although it would
be good to fix those, let me post v2 of this patch for now?

Thanks,
Ravi
