Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C6574352B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjF3Ghd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjF3Gh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:37:27 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C417E30DF;
        Thu, 29 Jun 2023 23:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kF+ICk87iP3cO/BBwRx7dnCzTETgzKAJe5rQlTx8/pL9IVpFATyqT78mV5I+XwJF8TgWflEUy1UIEG8LAr9/MXJ6bt5EKoh6/eR0cqT6SBsSOeHYMiRojH/wAgCRz/W2nSr/E2h9AvD+GuqSuNV5cQugXQDfzrzwwukNh6zCr04H9M7gSTUJ32plOXMpmYpb9SsUlOEp5+Cs1D4FsIxdv5adiHcEsW/Fz3bofxvJF+lzPXM/oo6w/ccFaQ/6JkbTNwIXyRU2awpCl/YzY0AeWNq+SFKGs9cQy7ndeTwMTXJ59eVowbeUO1/ax9sWB4ZPwaPNtdgr7+wVTf6/NTdvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhBDt9qtENWE1uaEbfrbq0Hd6p//zMuumIdgh03/mfM=;
 b=inTA5w87jInpiFINU8siwcXBqkTBZm5Sslt6V9uNeiyC5sd8c2VxxDOUbTv/+oCmquXgR9rRKfTW7q7qkSeDQmaN+pK0/lP7w3hhHPG+vSKqcXMOpjrFTVVO8NdtkKDhDcb5rT0ljhvW8iYj9jIIbLydnNz5ypMoU5QJi5ah45BdWbQFcLgzt4XvDyvPM/bt4iKblwZkRW1yxkoKdOhz98LyFxxf4TdFomcf8qKZT0mj84nloMsoa6FE8tVNYPOwW9Qw348n1XVexQfZUZLl4FfbMxsruwIVqSDLjCJsOt8q2xpTANfGtaVu1HgwJHKC/QW+j6F0iaXk9ysXE3hwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhBDt9qtENWE1uaEbfrbq0Hd6p//zMuumIdgh03/mfM=;
 b=5ImMe+Fp55tx9ku8Nk3MfjLR6ffj8JmX8xK4TuiSmFLq3FKkMQr9f8Tzolm6vxXGrqZ5qG1znzYewEO9NgOUuoZ3gLMm15Fo2W34LV05CTv98zNB9HDsqV1A1JOEdbVA0SmYNhQT2IqWvCMZcT2clMR2j4AmvkoG97SRhrKDsl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 06:36:55 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 06:36:55 +0000
Message-ID: <00865c8f-32eb-157f-ce05-2d5d0218559e@amd.com>
Date:   Fri, 30 Jun 2023 12:05:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/9] perf/mem: AMD IBS and generic tools improvements
To:     peterz@infradead.org
Cc:     mingo@kernel.org, eranian@google.com, kan.liang@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        leo.yan@linaro.org, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Namhyung Kim <namhyung@kernel.org>,
        acme@kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230407112459.548-1-ravi.bangoria@amd.com>
 <CAM9d7cijvZBsaXTMm8d=sxUWy6s+umCCnWhunD3KVhKbpVp_-A@mail.gmail.com>
 <631876a2-5946-82d5-6f70-bf7734db3992@amd.com>
 <bd4f84ff-640d-02bf-1abd-58bc8362edb8@amd.com>
 <cbca803c-c9b2-f851-6cf1-f9ed0223de13@amd.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <cbca803c-c9b2-f851-6cf1-f9ed0223de13@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::20) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdb907f-69ca-432f-9195-08db79346522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrKurTkoFZFVpYnWj29X2bfb80Q9diGJ1+G5MLUP1LdRqVPELgIPyN8eeO+UCY10/3i3kszuHPeuLNyXizgI4QRazE9jg87ySgNv9Wwtw0689tS8FXm3e0ge/XhXhXhEpGtRURfbCJA4ev8e6AHdre3c+Nk3VtiiUEWZoGYLuyx2JY7qX4lSHmY58HB0JjtbLWH2x9F0qhKCguwvDIjlWg/n7ctnycSesOdUDepjkx3y9LLiYvJokY7cq0Z7C1iAUWl3ALjt1qKaynLOtuI32YN+BEXz0aZFSKKd9YqHMHMG2VzizcdsJ7MyII1PAkEy2wAln1zfWEcU6JUslKUxUTtFyBgXTVL14Ro9hUV9lNr1KA2PXXQrlecq6CbEaCh4gBHU+C573P1M2zmCWL1FcXlIt+Gch3kOo5GvG1iutcloL5SmIJsoD8GB20cYq4oZmzrPyfcmymfqWJ2QikMQl2jEw59eWQuBl7B/8UdSBI/9nueEepM69zM+O8eBpdXCyIwONy9QPG5dx8xTzbQtgDzCRny6UKupOAgsnqDVqqbvtP6ZD3130J8BIYX8OnVdAfvWp3HD9P82tWrLdC84EisE4Mrktrs+osDKYEvfBLx5Dzyl0eIwpzvDMV2Vc0jr9RsQ+w8LsaZx/XhqhuZqRWCtXUOH+0ChiKYoEEsojYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(6666004)(53546011)(6486002)(2906002)(83380400001)(2616005)(38100700002)(26005)(186003)(6512007)(6506007)(41300700001)(86362001)(31696002)(54906003)(4326008)(8676002)(5660300002)(478600001)(66946007)(6916009)(66476007)(8936002)(36756003)(66556008)(316002)(31686004)(44832011)(7416002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUJaenVOZnNVbnlRQkx6blBKODZRTUJEOERUa1U5bjBsTy8zdzlKVHRzRktM?=
 =?utf-8?B?aldRZTFsSGRYdzRQSTd3amZiT0Q1YVZKNGFxUm01SllsOWNPL05XMmxHS3VO?=
 =?utf-8?B?cFp0VktMRHhSY1ZTOEJnemJnRDdKUHpJblFqODFTdVZiK0lXTXkyQkR6K2Rn?=
 =?utf-8?B?bzNjRGlGSHZBdVNkSkVHRWhQQWZSMnNGOFBrMUJ0ZEZVNWszRjBtVjZYMSt3?=
 =?utf-8?B?N0dxcGQvem9HbjZGbTF0T0NPM1JtSmNvMDZTTko3R3EzQ2lYZGhtNlExQTZR?=
 =?utf-8?B?Z3BqWnJ0a3IyL1R6K2d5RHM5KzVvVnMwSDYvanYyRXhOVHlvQmtrN0tzbGgr?=
 =?utf-8?B?SFR4WDZ0OTU5Znp5YlU1eW5Ia3crVGxGSElmZ3pWZkhBRmVuUkJMbldHWDNG?=
 =?utf-8?B?SFZBS0k4MUZJTW1OdTRybjNYRmQ0clhRY214QVhBeHU1TWFkenBOU0wvdFNF?=
 =?utf-8?B?Y3ZUdTlManFBeFVvNGRudjRmY2M0Y1hwWkZ5OEdBd0xmMEk1dndLT1hjR21i?=
 =?utf-8?B?Zm1GTVkvcmIyQ0d3bFhVUVdINHZiUUVqbkdxdXpmUWFNZzNUQzB0OGFRMEhx?=
 =?utf-8?B?SFRVR1VJdUl4T2JFck4zdTEyQ0VjOERQeVRRa09VbzFDaThlT01oM2FKMjFP?=
 =?utf-8?B?aWFlS2kwNGZDQTRDOHlmdHZVaEtpOTFmSUVEM3dZTngxR2xEQW9hL1pPZFRM?=
 =?utf-8?B?ZmxKbmpFMURUMkx0cFp1akY1S0JydiszSVlCVkYvdjU3dXhPQnhZYy92RVhl?=
 =?utf-8?B?elpEWk5nRVliYVI1THI0WVJJbzVOU013NkpsWk4wY1graUxXVXIrbzdpRDRI?=
 =?utf-8?B?UzRHWUpnY0RUVWVmZlJnVU03ZzZxM1BSM29WTlVqbXMyQXkyais3ZVdxZ0xB?=
 =?utf-8?B?T2ppYzhSaHhyTVdZMTZray9kYzMxTHg2WlJ0aldBbXVnZmswRmJ3Qi81Qld4?=
 =?utf-8?B?dU0yMEdJUWlSUkZiUU1FMWYreGNpSDFqTnNkcVZTb29Qc0RPYjNjTTlDUGZm?=
 =?utf-8?B?aDZKd1BUK09Oa2w0ZU9lT24xZlNMRjlNZkpoOE5ybWtRT1IvUmxZMlZURmM2?=
 =?utf-8?B?VnRkS0xiNHpwZ0pmbzZ6blQvZkhzaXhUYlpxUXhsR1BzcnhVbW91MVVlOTdu?=
 =?utf-8?B?S3hBcTNMTGEvNDFNV3ZNemkydTVpVFl1OGNRTzZyQmFaWFVIVmFnNGNzZmxG?=
 =?utf-8?B?U2tLSTN4akY4b2lXaCtDRUkrQWxNaVVVd0tsMjUvT1hSckVCOVYybWJOWlY1?=
 =?utf-8?B?Y0xyMi9FZldXU3BBbmNoRGF0T1ExU1ZzeG1XdWQrME1vUWVYNXJ1MTVUb1Ax?=
 =?utf-8?B?ZWVLczJYRnNwY2NhMmVoODV6OTA5aTY0N3NFWmV6OTlwSmpuSk9oQlVWN2Uv?=
 =?utf-8?B?TWMwVEQ4ZU5VamdJYkxXbFVHUjU1blA3dndtQUx2K3IrVEdGb3h0cnd2R1Vz?=
 =?utf-8?B?M2ZVWlVhMnRFdVNKeHNkVUdIZ2RrOWd5ZzNrcjRXMDJyYlV0TEdVRmxQbWpy?=
 =?utf-8?B?TFhDNmpHc252aVcrcDdiKzVsVlNpN1VDeWgxRHgzTDVTZXVOa1ZTWExGSGtj?=
 =?utf-8?B?SFhyaDlhSlRlRHhSQ3FrSkRnNTZVUTNmb3pzSFR4K09DNDNRa1MwaEI4S3B6?=
 =?utf-8?B?K1VFNWZTeGxYNDNpVkx6aUNqRXA2NTlpYjlOUWZTSnhFUUowaDFSUHRpdURw?=
 =?utf-8?B?aWlvNldpYUYwMnJpMzJNRVpZZzRjUW1IR0M2QVNzczFCek9kY053TW9pNUJM?=
 =?utf-8?B?OUExR1FvLzRDTktnVmdEQlp4aWFrMmI1cFZNU2lOMVpxWXhiU1A1RUpCYUU0?=
 =?utf-8?B?MnFyUXltSG12SStrWis1VmZRNThsUDAxaDJseXp3RHY3UnRMZ2p2WHp5NUk1?=
 =?utf-8?B?VG1ib0E0dkRCd2Q0VnpGSTZDaWZTdkZzdm5QU1l0cnI4NERkRXQzT296eHkw?=
 =?utf-8?B?aU8wb3BpNnJwY253UDJvM0xKK1J2L28rSG96K2JqVzhtY29XdTdvZk5aRUhr?=
 =?utf-8?B?Sk5URlhzN1FGZFppVHp4dWZyMFFmbG1EQTRlcUMwZ2tLTldoT2k0K0dBRUZo?=
 =?utf-8?B?KzdSNEFDN3lmN2UxbnY4enRpd0N1eDRoaG1CTmxOalJ3bExRRzRBR29MQ2xO?=
 =?utf-8?Q?Uu+6o3ogauyaaB1BgxW4nCx3w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdb907f-69ca-432f-9195-08db79346522
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 06:36:54.9584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7N6dysbVxadTnukRGrYvEDn02wPWgYVxh/rlf6HzGvJ1AXh6iX5VrpF/olMQxyijMKpU/JsNJeC0kNh3a8IAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-May-23 9:35 AM, Ravi Bangoria wrote:
> On 16-May-23 8:15 AM, Ravi Bangoria wrote:
>> On 10-Apr-23 7:53 AM, Ravi Bangoria wrote:
>>> On 08-Apr-23 3:14 AM, Namhyung Kim wrote:
>>>> Hi Ravi,
>>>>
>>>> On Fri, Apr 7, 2023 at 4:25 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>>>>
>>>>> Kernel IBS driver wasn't using new PERF_MEM_* APIs due to some of its
>>>>> limitations. Mainly:
>>>>>
>>>>> 1. mem_lvl_num doesn't allow setting multiple sources whereas old API
>>>>>    allows it. Setting multiple data sources is useful because IBS on
>>>>>    pre-zen4 uarch doesn't provide fine granular DataSrc details (there
>>>>>    is only one such DataSrc(2h) though).
>>>>> 2. perf mem sorting logic (sort__lvl_cmp()) ignores mem_lvl_num. perf
>>>>>    c2c (c2c_decode_stats()) does not use mem_lvl_num at all. perf mem
>>>>>    prints mem_lvl and mem_lvl_num both if both are set, which is ugly.
>>>>>
>>>>> Set mem_lvl_num, mem_remote and mem_hops for data_src via IBS. Handle
>>>>> first issue using mem_lvl_num = ANY_CACHE | HOPS_0. In addition to
>>>>> setting new API fields, convert all individual field assignments to
>>>>> compile time wrapper macros built using PERF_MEM_S(). Also convert
>>>>> DataSrc conditional code to array lookups.
>>>>>
>>>>> Interpretation of perf_mem_data_src by perf_mem__lvl_scnprintf() was
>>>>> non-intuitive. Make it sane.
>>>>
>>>> Looks good, but I think you need to split kernel and user patches.
>>>
>>> Patch #1 to #3 are kernel changes. Patch #4 to #9 are userspace changes.
>>> Arnaldo, Peter, please let me know if you wants to split the series and
>>> resend.
>>
>> Hi Peter, tools/ patches are already upstream. Can you please pick up
>> kernel changes.
> 
> Gentle ping, Peter!

Hello Peter, this is pending from long time. Can you please consider taking
it. Please let me know if you want me to resend the patches.

Thanks,
Ravi
