Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18899704396
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjEPCrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEPCrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:47:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D864B61B8;
        Mon, 15 May 2023 19:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coq/FrplMQqxQkWRsScVr37qs6u/BJZL854QRBv51cryAXdLJH/yh1qe1H4s9qVNccXeLn8PaOm1OE1+D5yWntLxt/9w2mJLRuOupLOkxNxV0BoZsSgFaVRDKB/YTBJsYQ744ZHrPF1Xl3X5UkcQ9v3vvBgzswuuyppyNaBPRyFHLacPSTo/JIFXNhKZK0CeT2zEkXRitBX+I/S9xJikVk3uEejYbpRc2/112B0zATv2Qq1OQzaeC8cNZY2KQp/9KD6C5rBaqi9VD3yHf2lf4T2XonMAfT0b8sq9/U6cIzPG7PRRoh2MffMte9caqirp4UpsJXxkASddy7O5ufPsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVU8en4DwbOAXrS1CcTACrpNerZebMGtrjVlTqUaaLQ=;
 b=nZQBmYsrk2c+hJyuJ2HjSSCaqh/ZYi57Kb2NIzH0Ue78zqImQbqWCFO2Xbooay9HKxouecLot4u/RMhYfzOkoj84/wNB7Auyx7fIOTYuclcf/yToYB6G2G/KLBgdyyiyAWHC/sMnPigih3QLnbEfzuJ/ZuDSi7YQN2qfGQ7MB46qRJTb/LMcFnY3xw66zfXTha9dHivlI7oNkI6BAGrmiVPA8SqAxPZVbEg/3LP7zZTi/vheE7Iw/N+hUKuLR4s8Nez/+MArARaUJSITyuAyXpIjmw8DKRiPFfZBfF1QkusOHb+fJKzUoCUnNEVvzJkggAHSVX1hq9yJXJ+b6GMN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVU8en4DwbOAXrS1CcTACrpNerZebMGtrjVlTqUaaLQ=;
 b=UyyVMoBJnT/arzpnQMe4wdHIG+Iltsc4YMjZ6t/X7p4m9VF1bIgO8qmUd4RiGCsXC5eHnKpbtX97+ktNXyk8jLR8gDkajL+SbDfiMjdTqvVHOA2F39rsAaxU93V4/BP+WMp8T8N+2QANZJYWM0uhDFl/vxiX271R7q3ngpUcVss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 02:46:49 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 02:46:49 +0000
Message-ID: <bd4f84ff-640d-02bf-1abd-58bc8362edb8@amd.com>
Date:   Tue, 16 May 2023 08:15:05 +0530
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
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <631876a2-5946-82d5-6f70-bf7734db3992@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::34) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: a85f68ca-7ec6-4702-7a65-08db55b7cbcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hy6DHZjqCQuTufPyY1c8pzqmRSaCz4mrpELLR5KUhthJ8FYV5vsb9yEAu6nCaO5wIcU6p/sVmmSy9fiyIhyK5VABs2LHP/BLX5BV0Gg/LhNpZQD7xFa1IwridptP7FOwB+AwOp9UlJZN9Grny0opSlE8az4HGyPz/8pGFlKLLfDGrFZl0I4taMbTqUnlFw73Xxhhk8bz32aGbzBDCQmzGvpQCWhfiKiew7Xy/8IXZwPEyQ5MRuXz5kAguWRZwtdALMJhQeNAGtGiGyLvHSpNgwAiKgDcl/BKyIlqENmbVCRznXPaLqaiEJm+1ri8bxoj+0mcSiy2qm3+CGixvgz7WvpoHXehIzmKnhnDhMbF9k0LSY7ydMMnKstktqMx1bqlAVYgbturY6frLXjqRyJQs/2WTmQuyps2gcWplypidLXD/HoX+uAAyjZdupbpAak3eedlWIpDKTG2xSqQi8gTHYdC35G/Un/th5YfPEQh+MImrDC4T7ki3ZSKHTet2/wtprriCTXtnnyMJnna0kNk09rI+dIEsor/Q5dFV60Af9yT6dOpJcP911XcTzbnxPWVlky/WDEQpVTg7J2WPpYko4jD5Ol3S1O9UKgPnqV+/BOXXOkYUTv8RyYKzdNjV/NxreaF7mAzke/s12lJO52FJU05qW4qjh3m5SZMKqMwFqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199021)(478600001)(6666004)(8676002)(41300700001)(66476007)(66946007)(4326008)(66556008)(6916009)(316002)(54906003)(8936002)(38100700002)(36756003)(186003)(31686004)(6506007)(2616005)(6512007)(53546011)(2906002)(26005)(83380400001)(31696002)(86362001)(7416002)(44832011)(5660300002)(6486002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3I0VnNXeGhrNFNHeklnRnQ5bUtKbHZ1Z2VoaFI5Ym94ZFFZbjRqSnhwWGNY?=
 =?utf-8?B?enNXOGl1a0VJM2ZJc29laDlIZ09URTBLUmlSRk5jQ3RlYWFlbEJZaHFGVWFH?=
 =?utf-8?B?QXpwYm5XSFpjYTJHTUprY0FZVWVlYVFQZmNyZUdCbXAvT0ZUU1ovVDFZNWty?=
 =?utf-8?B?QjJWZ2pHYzh6TVhjK0xnTnowU2NFeC82Y05FRHptUzNBWDJmSmVFU2g2b2ov?=
 =?utf-8?B?WW5kNW9YckJZYkhTUktrRkJmb1daNkZSK3NHTld0OHZqbG9oVklvdnkydENw?=
 =?utf-8?B?RDBGN0tGdEE5NjRXdmxPRldSWTRtdFFBUnI3WWdUTDlXSzdid1R1TlZRMENP?=
 =?utf-8?B?WDNaNE1QdllwWEtLZjF4M0xSK1ZHSTBBMWIyNFN2MVhsWEpEL3hoYjVuaUF2?=
 =?utf-8?B?YVhtTDcrNkhoeDBBWjNRYWxSWDRTMjA1OG5lSlZPZjZJVG5rTkVPaEpEQkxL?=
 =?utf-8?B?bHFaYzQ0bHdQclh5emJQMjBNWjFqRFNVQ3I0Mzhkby91ZDlINUl2U0VRNDAr?=
 =?utf-8?B?SzJSZWZScTkrL1YxaHdNS1o0dTRBbUV4VzdWaytpM1VlVG1PYm5STnFMeFM0?=
 =?utf-8?B?dXduVjFCWWh4SXp1MDhzZFFPUFBkVU1vL1BYRmErRFM0UkFYYXE4V3drenlY?=
 =?utf-8?B?R09uTW1mNXFqOTU5TUlUaXFMZitlaXFYRXB2SEU3UG1odEFrMFkyelFVcWkx?=
 =?utf-8?B?YmFGeWJiNy9aeU9MUkxXR3VTSWNEUGh0QXpLZ0pVenpnVHlSQWs0amtjVm1M?=
 =?utf-8?B?NHpIM1ZWSXRCSjFjdkZCOSs5R0Y2ME1jcmlEOHNxUWVtbW5oaE11bzIwTm5J?=
 =?utf-8?B?TzVUcjRrcFl3d3hjOURkb1dJQjYvb1NsMzlGYjlLS2ZjVTUzdStiRGlWMTA1?=
 =?utf-8?B?czFJKzlMWjVSZWJaSXNqK2pZMWM5T1RKbWtqckVpMFgrSmk2ZSs4ektiU215?=
 =?utf-8?B?QlZhYXhYNGdsNHR4eUx2TDE3YVltWGhiaTYyWnVmMW9yMDNYVnNRSHdPbG5v?=
 =?utf-8?B?cFY2eUN4M01EQy9QdzlKTVIyRUtzY3preDlOWXU2aDdPZzJGQ1NHY2pMek1n?=
 =?utf-8?B?bG41VngwSFVSUEY4MGdTKzBrT1kwZHdzR2p4dDhjUlFTdmsvMytJRFI2VmVw?=
 =?utf-8?B?blJCT2EzWU9PSWFZdk51eW5nSmxUMy8zQlhhajR1bVVTeFR0Z3lIV0RUT2g2?=
 =?utf-8?B?NEN1NURBMytxQk5Dbk1kcmJwUGFiUjg3UVFWbGhQR0JXd3M1Q21RQnNLKy9l?=
 =?utf-8?B?eFlKZFNSR29uSm9lOC9yek9tQW1FY0RXOUVONndaQk02WUxGMjNRUlB3bVNw?=
 =?utf-8?B?T3RVWGR5OTdQT29OczFtTGxJajFmRjQ0L0cyOWYyNnhXUVowaG43UnJyV3cy?=
 =?utf-8?B?KysrMFlVbmJNZk9zYkRJNHlDb2FRTEVuWW82YVdySGtjMnFXd3R1MGZjdk1J?=
 =?utf-8?B?T1lTby9QYVZyZmN4VXlERzlUbStMbTNLMWhQUDhyTk5oUmdsUVFZaUpFUFVt?=
 =?utf-8?B?TnFNNElpcWloUFY1Tm5oNzNPSVkybm1vWDdkYllsM1BwT1lHbWRzMnZQM2pw?=
 =?utf-8?B?eG5KZjdEVC9uK0RJZHp5UlNva2FzS29IUVF1bUh6RkR3cE0rWmpXUk5PcjZx?=
 =?utf-8?B?dXp0UXJmc3c1WmFrTXNGNzhISkJPUXExclFRTGF5WHdyTzY1czZuUUNXN29D?=
 =?utf-8?B?TXZ3TVJNd2x6Y3hpKzc3c0RVdlJ0aE1JTHdEcy83RzMxWnFsSTM1WmhzVnhL?=
 =?utf-8?B?Um1LQ1hBcm1RejlBTkY1MkZ4L0hpU2oxNWsrMUx1UzAxYi9obzZIZEhOUW8x?=
 =?utf-8?B?ZS9WOWFpUnVSUXNJRUcxLzZpZ2NubkFQQTMzdjl2bmxzUmgwMmVncW1FcXZs?=
 =?utf-8?B?QnJ2TS9LdFoyNUUvQkZEcXpoVlVxZjVHRGpsSndWeDdzeWhadEJHODRhRUVC?=
 =?utf-8?B?eFFWWDIwTmN6eERsQmxwaFlGWWtNdVdlQ2RTblhZUHRPNkhrdmZ0WkNnSldL?=
 =?utf-8?B?ZGo2ejhTTHNndGlybytCbzF0K2FKUG9rZGdKNnRZZnJ4K0FucmQwbTNPaTVm?=
 =?utf-8?B?SjUwSGVpUUlHNGlsUGY5RjJTdi9zRGxIK3NhQ0gzcFBWUWlzUUpGaXlvdHdK?=
 =?utf-8?Q?jUuCXvtN0lywh4+KMHzlea9Xw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85f68ca-7ec6-4702-7a65-08db55b7cbcf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 02:46:49.4295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kahN1tfeRZ1XkfwdW7PMOKKPcZzxeEh+dJBz2okUW8HgP6lZdM7+d+AvSJj3oIl1fEwZZ/CjHzgwYizG4acRHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-Apr-23 7:53 AM, Ravi Bangoria wrote:
> On 08-Apr-23 3:14 AM, Namhyung Kim wrote:
>> Hi Ravi,
>>
>> On Fri, Apr 7, 2023 at 4:25 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>>
>>> Kernel IBS driver wasn't using new PERF_MEM_* APIs due to some of its
>>> limitations. Mainly:
>>>
>>> 1. mem_lvl_num doesn't allow setting multiple sources whereas old API
>>>    allows it. Setting multiple data sources is useful because IBS on
>>>    pre-zen4 uarch doesn't provide fine granular DataSrc details (there
>>>    is only one such DataSrc(2h) though).
>>> 2. perf mem sorting logic (sort__lvl_cmp()) ignores mem_lvl_num. perf
>>>    c2c (c2c_decode_stats()) does not use mem_lvl_num at all. perf mem
>>>    prints mem_lvl and mem_lvl_num both if both are set, which is ugly.
>>>
>>> Set mem_lvl_num, mem_remote and mem_hops for data_src via IBS. Handle
>>> first issue using mem_lvl_num = ANY_CACHE | HOPS_0. In addition to
>>> setting new API fields, convert all individual field assignments to
>>> compile time wrapper macros built using PERF_MEM_S(). Also convert
>>> DataSrc conditional code to array lookups.
>>>
>>> Interpretation of perf_mem_data_src by perf_mem__lvl_scnprintf() was
>>> non-intuitive. Make it sane.
>>
>> Looks good, but I think you need to split kernel and user patches.
> 
> Patch #1 to #3 are kernel changes. Patch #4 to #9 are userspace changes.
> Arnaldo, Peter, please let me know if you wants to split the series and
> resend.

Hi Peter, tools/ patches are already upstream. Can you please pick up
kernel changes.

Thanks,
Ravi
