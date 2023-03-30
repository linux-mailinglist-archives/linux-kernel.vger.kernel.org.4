Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1BA6CFA44
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjC3Ei5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC3Eiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:38:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35683359B;
        Wed, 29 Mar 2023 21:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH1xcaNkGDyv4fBVK3eK/eaUUy+g2nwRr6KRcNCX/DTDBBwE6Hd9N6l3PcJ6txy4so/Qgb8qY+o3CVhUz3S0+UcR/k6EnTQ7J5p1DuOteynPa5+lyT1zNhj/o834LDHU1oEuyp4tHsYVdS8/3ZabnR1MMYLqLwpZaZOwHxVJJ6g1nMA6LhE7QPiqcvjXDlMeeL1OCPmZlfRJKT34CSaAc/kgYN/CbBJ98bjJZRqIQHFIaEpinhaRGSxT7H9Z7++s+ONBCHAxIZvVAofkdC1y0bE42Qd14STVmxXXr9swpQ6Av8qPEVI16ES1huUQWMdk9yS+Lb5ME/XzCQ7V1cEpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyroXkbdPdHm/ct59Bae/nqltTWeV2xO/2rFB3DGk5o=;
 b=Um+mrSy5KD/Id+OxvFKwW4o/EUV9TYbdlsgm/zhBwFXw/6dOn1TQY/a7QOX7yuyajgRd6NA691+6EOO6dhYHL7fXZLtZh+4WrqWS1vQUqfHdwFMF/au7CamMJVeSAw0+3ivpOfZlxiYXLjaFeGkNdjYLkEBOKSs4KolBgT4vtJNwstjVlMrEnBFRrZ7rzZ/+NjcwJpBybZoSlNY90/ls7BJ7E67D7wIsiJzk3eI99BEv3FGmWtgxwFP+fAfdGs27IxN5lrmFWFC9Lc+Qo2AXr+Q51nP6rtpIU8fm59QTtSI1eXPSg5F9fPNqD8FG9lN1JDQv7GYhlFmUgLP829iThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyroXkbdPdHm/ct59Bae/nqltTWeV2xO/2rFB3DGk5o=;
 b=UQgggM0QLPQPwT4Ey7aB7rMnw3t/8WGkN5o/MJDWOW7Gqqm7pCFSMf5P4wJPUj0NICFvE4H+Zn6CCYe3MJ+2hIQSZSSQx9xhvMSGcG92fM0nBpFZcozxKz9yBUN/lJFP33/5t/Lmoyo0DdazNy5+Eg7AZdUekGVGhSRnOYMLO04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Thu, 30 Mar
 2023 04:38:47 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%5]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 04:38:47 +0000
Message-ID: <0a2a5ba2-ee00-971c-fb1e-7ede8426a089@amd.com>
Date:   Thu, 30 Mar 2023 10:08:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] perf/x86/ibs: Set mem_lvl_num, mem_remote and mem_hops
 for data_src
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, acme@kernel.org,
        eranian@google.com, kan.liang@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230327130851.1565-1-ravi.bangoria@amd.com>
 <CAM9d7ciQLXAcVwFJWeJDHwkwUQ-rnHvdetYsQn7w83kkOsFKWg@mail.gmail.com>
 <00f1954f-cf55-d954-5dc6-0da95f8ea308@amd.com>
 <CAM9d7cgHL=aXffUtu7CSNdfsVnDoO1cEzBSSpdYVQh9ZrbL-zQ@mail.gmail.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7cgHL=aXffUtu7CSNdfsVnDoO1cEzBSSpdYVQh9ZrbL-zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BN9PR12MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: f71b8a1c-f197-4353-0028-08db30d8a68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4w5li/u/Z4N2R5Tp7MmI3vmFqzaoOARXO4l6yqegXfv0Kh766x07C+chUj811SeuEbMXs9yxyOgqT/W7JR8K5NLXbrD3aOFsj6RPPvP4YobhZ5Ofw1JGZMqbVKqSxbDAKg8Z+HCqHHNt43Fa8Jt9wF3hIhrADQb7Z52j+21s6zaXcdTeO1D23ks6Dme6uZf5yoSfcYuCMJIhIzIfL7aAh5qSsi75GvLiL/Q8vRi8CBiVU2MWJGSrz5s/OblaK5zvBYl208kthQ3+Puf8oT4+n5VXjJ2/Dke6ehQAL742E2FYEh7VfeusuJJUFTxnEdJI5v//HhfIL/8NOUAoBy7ekphbKx0o6MApLpJByzVP64vEnlckfGDT2Ck5i0TqFM+dnJPxh8nCiXVmKV2Mqvqhz8xePnUCPpTVKwUkpH2+ClWdLUpEF9+2H4g2LSfBaJdjwIh03Ix/Y2CIjL4T36I/O45NyINpfnQ2Yk81BiRlNfuTI6mzMGRhP1CbUWbNszYZ1AuDrwnTzW01/DuD6XgSWBP4GX9YwnT+YWz+i2Of1b+6JhkE6iugjrjx1vUdZ1U5zTbAwIoJ8RPjULisuu6y+wM0psUnn7rsxRUTirIo8jvjxaB8x3OWjSrewKs4HoP7uBZWwJWJn4hZIA/mCzChw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(36756003)(66556008)(66476007)(8676002)(6512007)(6916009)(66946007)(316002)(53546011)(2616005)(6486002)(83380400001)(6506007)(186003)(26005)(31686004)(6666004)(4326008)(478600001)(86362001)(44832011)(38100700002)(8936002)(31696002)(7416002)(41300700001)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajBRcCtMNU9maU5rSHkwOEphaEFpNnF4WTFBajI1cWp3RHduVmJ4REVPOVl3?=
 =?utf-8?B?eUZBL0RXNWpMSTVzQmgySEFvM0hWd21HVjB2S3lLajNOZlJqRkhxMS84cG56?=
 =?utf-8?B?QjUxWkNOb0drVko4SzQrKzhNUnNERER0aXFUQUZUR050ZUhVaWFRakswZXFH?=
 =?utf-8?B?QkNhOWVrWlc1dFNnMEpkMTVuUEtzZnV5UDJoOW5yNFJ3aGJCYVdXTmpkUEll?=
 =?utf-8?B?RHIyRlNGV0dGUlRjb25mOWh6ZG1iVEF0U29mekZvTHBOYXNVOVppZWt1MHFv?=
 =?utf-8?B?RmsyazJEUk52a25JUW5WNTJGYUNJcjFZakZ4N0RTYyt2b1FFaTE3RVk1VWs4?=
 =?utf-8?B?c1ptME5LMlM4Ulh2Q1JpZVJEdnYxUjVOVGZEazhsQUdTZFZSYnVEOWUyd0Mv?=
 =?utf-8?B?ZW40SkNhN3hCWHliZWI1RWgybUVzeC9TZSt6ZlowMysxK1FKTDhNSDU1SW5Z?=
 =?utf-8?B?dW8yZ09xSGV1TzJTNWt5aFZpdEZDSUdkUDhyNTFuM2hsVEo3SGh0YjRtV2Vu?=
 =?utf-8?B?bFhJV3hLeXRyU0pESlpVc2lYYTBESE9Rck14SExNUGRlMGluMVJaMVczdGxP?=
 =?utf-8?B?aDFJd0RIUHVaN1ZudVdzcFJ4ZC9jZzI5c2k2Ym5ZT1Y5dXVTSU11QWxteU00?=
 =?utf-8?B?WHFrYkpqYVM1MjlrcDF6QXlIOExFblNINHZPOThpUEJkQUtOWFQvMTFjZXY4?=
 =?utf-8?B?U3VCVy9XUzVycTFxeEQ0T1p3TCtoQmJsWCtMM3p5R05wTENwKy9TaGRCNlcv?=
 =?utf-8?B?WlpzUkZsbGlWYmkxTHQyTzkvcDM3empudXp5S3F1VFZqN2tsT29WMjF6d3Qy?=
 =?utf-8?B?UG5IUDZzS1huQVAzNklxNW5Gcmp0djh6TEVkN3ZLNDhGOXF4TWFNNG5IYlFT?=
 =?utf-8?B?VytmZDZCVFBxeE9ybm9OV1JTektYVlpEZk03bTZSQVVWVWdNWkZxODgxeTB2?=
 =?utf-8?B?NkVFZEsrL2RYSlBIZmxCclJZcmVTa1lYVXEvTTFTZGE3Vk41c0s5cUIwUVlW?=
 =?utf-8?B?RjZUdTZYaUFlUXhQV0hpTUNCOVJ1ZllzaVdDWFVQOUxTUlNWWGlmNEZ3NS9R?=
 =?utf-8?B?NlFEMlc0ZzZiQXhyK01CTmFwbXhFdzRTTTk5L2JkM1huVTlocm1TTXM3clU5?=
 =?utf-8?B?L01ZcTBycitCS2Qycm02ZUtHb1FCZU5iYm51SlRyZUswRmYyOFk1aWFqbXNE?=
 =?utf-8?B?RDVvczJUOWl2U3RmZWZZZ2hKbVFFSCtFOUlPdFpUZENIcVJmSUtHdmkwSE0v?=
 =?utf-8?B?NDJpSjRIcWNyNVNqYWtoRDc4eDZaN1Noak1hR2hVRGI1bVJzNzdmdThHalIw?=
 =?utf-8?B?NDRXb2QzNndibGJCZDU3eGl5a2hIdDBLZ0NXMkV5R2xNRTFVdGY3RVBmV3Zh?=
 =?utf-8?B?SE5jL296YlZHSnFqQi8vRzJFKzh3clI1TnJnMFBTTXA5N0xaelNFRWttU1NO?=
 =?utf-8?B?eU9vTElMNm9ORU1yVFczRVhHM2NVOEFKVjArRUJEWnF3MXdyVHdjSjBObytV?=
 =?utf-8?B?NTBxbHc2MC8vbDdSRnVpTWQ2ZkRSSmU5Y0UyMnlHcUpxMi9XUzc1RXNraHlM?=
 =?utf-8?B?Wjh4SmI4RHNWRUtuMDBCTjd2c3Voc0dQa3NaYkh1R3JOUmI4YmgwbDZOTmlJ?=
 =?utf-8?B?YW9WWUQ4T3QvMjRzVGRwTmJmUzh3VzdpQWJGWU5lODlWWjdoYUJRMHJ2ZkV0?=
 =?utf-8?B?S2Q0b3VzVVUxeFc2VmlnNHJRaUpLR2ZpSWd1WmtrbS8va2NSUlBHZm5xa081?=
 =?utf-8?B?L2JBTUFmSjRCUkZ1U044ZU4vYUVpZTM5cDZLc08xN0I2OExZODBuNmVlREZM?=
 =?utf-8?B?UWpBL3RhVVNRakdlQitvSHp5MXNsdGs5UzhPdyt2Zmx4bTh6ekdqMXhQY05s?=
 =?utf-8?B?cnYrZmdwNUk0OVIrYlhEVm9velVkMVR5bFZwYUpBS0VwWSs0a0s4SjNMWUoz?=
 =?utf-8?B?UnpBQlg0RnJmTEd0d3gxeG9PcmNnTU5PQTk4MHRUYXd5bEh2TVlzaVhqNFJy?=
 =?utf-8?B?UDVYYTh5UXlRREwwem90eW1GMVNQMTEzL3BhMTBzRXduUnBrRWk1VW9UK2tP?=
 =?utf-8?B?TGViSnBKeHF3Y3JXMVcwTlpoTUZFS0xOMHFCRzVOR3EwNlZCVUlMbzdQMThE?=
 =?utf-8?Q?pkW3IFdzy5nrR5j6UeAn3/LmK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71b8a1c-f197-4353-0028-08db30d8a68b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 04:38:47.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdNxjw1IpNpe6AiriBdO+NAl48REccZ6Gyg/EjDCe8LqVI3gWRIUeFYXut0CJNWDRSge5GQlJRyacGD4r+BqVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Mar-23 5:17 AM, Namhyung Kim wrote:
> On Wed, Mar 29, 2023 at 2:45 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> Hi Namhyung,
>>
>>>> @@ -716,25 +748,19 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
>>>>          * DcMiss, L2Miss, DataSrc, DcMissLat etc. are all invalid for Uncached
>>>>          * memory accesses. So, check DcUcMemAcc bit early.
>>>>          */
>>>> -       if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO) {
>>>> -               data_src->mem_lvl = PERF_MEM_LVL_UNC | PERF_MEM_LVL_HIT;
>>>> -               return;
>>>> -       }
>>>> +       if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO)
>>>> +               return L(UNC);
>>>
>>> Hmm.. it seems we don't have PERF_MEM_LVLNUM_UNC.
>>
>> Right. Is it worth to introduce one?
> 
> I think MEM_LVLNUM should express every memory level in MEM_LVL.

Ok.

> 
>>
>> On a side note, I came to know that IBS OpData2[RmtNode] is not applicable
>> when DataSrc=7 (I/O). So, I need to respin this patch with that change.
>>
>> [...]
>>
>>>>  check_mab:
>>>> @@ -830,12 +810,11 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
>>>>          * DataSrc simultaneously. Prioritize DataSrc over MAB, i.e. set
>>>>          * MAB only when IBS fails to provide DataSrc.
>>>>          */
>>>> -       if (op_data3->dc_miss_no_mab_alloc) {
>>>> -               data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
>>>> -               return;
>>>> -       }
>>>> +       if (op_data3->dc_miss_no_mab_alloc)
>>>> +               return L(LFB) | LN(LFB);
>>>>
>>>>         data_src->mem_lvl = PERF_MEM_LVL_NA;
>>>> +       return 0;
>>>
>>> Wouldn't it be 'return L(NA) | LN(NA);' ?
>>
>> IBS has no instruction type filtering, i.e. it tags whatever instruction it
>> sees at overflow. When IBS tags non-load/store instruction, data_src->val is
>> set to PERF_MEM_NA, which does not initialize mem_lvl_num (Shall we change
>> that?). If I set both LVL_NA and LVL_NUM_NA for load/store with no DataSrc
>> info, perf mem output becomes funny:
> 
> Probably worth changing PERF_MEM_NA.

Yeah seems so.

> 
>>
>>   $ sudo ./perf mem report -F sample,mem --stdio
>>   #      Samples  Memory access
>>   # ............  .......................................
>>   #
>>             1914  N/A                   <====== Non-LS
>>              905  L1 or L1 hit
>>               19  L3 or L3 hit
>>               16  L2 or L2 hit
>>                6  N/A or N/A hit        <====== LS with no DataSrc info
>>                6  Local RAM or RAM hit
>>                4  Remote node, same socket RAM hit
>>                3  Remote core, same node Any cache hit
>>                2  Remote node, same socket Any cache hit
> 
> Maybe that's better to differentiate them :)

:). I would rather add instruction type column and print non-LS, L, S or LS.

> 
>>
>> Also, L(NA) is PERF_MEM_LVL_NA | PERF_MEM_LVL_HIT. If I just return L(NA),
>> perf tools shows it as "N/A hit".
>>
>> So, until tool code gets refactored, setting mem_lvl = NA here is hiding
>> tool's dumbness :(. Maybe I should refactor perf_mem__snp_scnprintf() as
>> part of this patchset.
> 
> I think we can change the tool independently - preferring MEM_LVLNUM
> if present but you might want to add an option to override.
> Given IBS didn't set it so far, the output would remain mostly the same.

Sure.

Thanks,
Ravi
