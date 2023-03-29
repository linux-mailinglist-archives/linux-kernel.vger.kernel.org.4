Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D556CD6BA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjC2Jpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjC2Jpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:45:41 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1D09B;
        Wed, 29 Mar 2023 02:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2dlWt8Lqcw7KJMJYT9UUoFG7/+1k77wyG6Yi+J/UhVsjNhXi74ob8w0vWCL7wg4gIC/n0NV46LJCiExbuLAVu4mj6LsWFK9xU5uvryZECNnq/jZFvS1UXxpXk0Mcc4ElZ09p1U9EERoU+LVV6yl3EYJUSIGIeogRJ/algepiukU8JySPYmBcalF60M5WvaTpFigcYFp1UN2/qWtkinbVOtQ8fpLp6Ymok/xUmskSOrJVB5r6A8a+ShNCa4YsOk/bupdQrJvjGm3i/Wv7aeBoF2FewsZ2UNSeSb/la8cBMRM/n49+CWiUmshGwMctnFW1bA+Worp6GMYw/AulJ5ZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdzC0LrIqCbf492ugEDHaEwEGNEOv0pUWsFzh7JfL4c=;
 b=mhRqjdge6Sair/1QL4BFJ1WbEKKz/m5yrtTtX2BWXj1UAEiSNnJSZo2FxknUzIziPHP4TQs+HgCm9vjYfDXKoCBDCF8UadthNdUhJhRFGIusnSLqzJtEnwDuBkTDobK9x8QOjhuPruiJQHs0rIPL1o2iZFEFsx8mxqDO4/q3pAc+/VPl9GmSd7Xn6AY+yMn5qX84n0E/RBeH6yrPVMw1AYAq4AoF2V9JuXg19/J1DYU3WlqM8g+BPciS6pYAIlp3HHf3zj0J0pKPMBG8hhi0TchjCemzScOB6JXtoW7twcdGQEf5eMnV1y3PM/HuiaD+YUxY7KXYvc8AzTdAW4wPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdzC0LrIqCbf492ugEDHaEwEGNEOv0pUWsFzh7JfL4c=;
 b=X5VVqMlTfXtwibaI+yiGgIJ8yfDU4mdJd4edU1xxu0B84/xRdmLvmItL10q7oLTAe+60oBesg9GEMpljtMtHmANoehjBJxgOoIYFeUccQkwuma71sKMIcQIswWGCEGOk+xAKQGjx18Un0/imt9l0AO/O2DLVYHq1qTPYRXA1GIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 09:45:35 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%5]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 09:45:35 +0000
Message-ID: <00f1954f-cf55-d954-5dc6-0da95f8ea308@amd.com>
Date:   Wed, 29 Mar 2023 15:15:23 +0530
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
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7ciQLXAcVwFJWeJDHwkwUQ-rnHvdetYsQn7w83kkOsFKWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 67429c34-8ab1-4a54-0b66-08db303a5815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRkkapWBpU5lmURTM6BwODGFIiE7vATIbAVJW81krrsM2Z2OONws96FAt6X2yQt14KItGRxCPNiKm8pEDtxhp0LpXLVTe5MlXSLYFiJsYn5luVqvdjB6vW5XpWdeWUFRqhsjZIL+3GmMf3JrIwsLn7yWIN5XBLYu+PuExMloHQW3bLmALs51chdKFKIH12tXX5mxWM9+ZGRDW4NIKY+iAMzVMf+xQPcuOYCmws2zzpvyD/g8qiW0jPskOY/p8tiyt+gWKu5m12gdTa7R8b6bIKrB91aPVpis+2tf3v2cBBCOc9HIrRCxbgfcivfW5k93bcMtRg1TltG+AvGPKOk+tOmRPRA3iXykiL1LzTP5xJHDUoua2e2HtWPqZPL+n+4HcPv9CieIhIe3xFPa8B91/TEiGag9otUfWkG6XkH5WyDarXxaXAgPbgdC8xpHcjWGHXt1yDR5MCRxwN5VFw8O+0mgqA+n5vD8/kEyp+AgZRKeL5JlPXjYLcnx5rG88Ke1avQl9IznCm9KBAtKbJ581ncN0n4E4CoDCTNYfHUdihdpyqZ8Xo7LbI8GS1sDBxGVdu/OABthYFG2duRIZ0kb5uQt9Ch0PJn91yn7Y6AT/BvZkjecpJfn7qOuqZYGcRWwVWRJUK+vdojXGZbiQSN0Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(478600001)(66476007)(8676002)(7416002)(6916009)(316002)(41300700001)(66556008)(5660300002)(8936002)(186003)(44832011)(66946007)(26005)(2616005)(6666004)(83380400001)(6486002)(6506007)(6512007)(4326008)(86362001)(2906002)(38100700002)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjFpbzRJdW5EaDBsYTYvNld3dGpLSUg1dHVETkZ5RXUvZTM2MXJLTjNKQjJV?=
 =?utf-8?B?ZzV1dlJDVHNrV2FuRDh6MURDS2Z1Z2hJMXBBK1gvbitCVnF0S1VWVWhaK3F1?=
 =?utf-8?B?ZUN5REhRQXUwZGxSMFAxUCsxeDVqME1vaHZVYUN6bFJsVmdBZXpWbnJEQzFs?=
 =?utf-8?B?cnJYMkxqOTdIM0w3bFM2U05Mdzh5SXhwZzQrUk1JWmhuc2tkM1pkdjRCUmxx?=
 =?utf-8?B?VDBoWUZFSmRrdE5KczlBVGxaSzNJTmlpamtwNVVMUm1QVHJ4WVNBTDdsZ0M3?=
 =?utf-8?B?aERPQldCR3E3bTI1ejJmL3p0bHhRTWhLVFhqeVlxZkNDc1JQb1NtNkVrYkFz?=
 =?utf-8?B?eEphb1Y5bjZwb082R252MTRpcmVWUERkRWxaWlRsaGVKeCttOEJ2enRERVN0?=
 =?utf-8?B?M0Y0N3pxb05naG8zTDkyUEN1alZhT0Rwcm1ydzdtYnJ2cnhDL3dpZWhvcnVC?=
 =?utf-8?B?VktwUXA3Vm1iOHBEelFNMlBJUzlod01PdThEc1NJLzZBWFdCT0xDR3BZZXZl?=
 =?utf-8?B?SFFPRHh1WVNLTFdMb0s2OEEzKytmTHpqU2MyY2wzYUpJbFI1WWphaE83S09i?=
 =?utf-8?B?M1Y3R0FvcnFPeXVIZXdueERxS0VrOEx6WFBnbC9qL2FpNEc1b21qYmQwYUlm?=
 =?utf-8?B?Ly9pbEZrUmRMWjN3Ty9sVE4zOWZKN3NPVGJVNE9tTkw2amhpOFBxWkxiZmh6?=
 =?utf-8?B?ZytPZTVZZzl3bzdVNDZabjRaR0wrSkxzN3R0Qzc5eVVaOVl3YlUyWTI3bURj?=
 =?utf-8?B?bG5NRmQ5OEpGdHJUSzNGczdURklhZlgzRTd3OGhPYUpuMVhIL1p3WXdDSHlK?=
 =?utf-8?B?a3ZZZ3ZvZU1jSCsxM1R0RTgvUlRkemJtOTVuNlJ3KzlQb3pVVjJSU1cxY2ND?=
 =?utf-8?B?K3JrMDZ5UFJXUm5jTlpHNTdaNmdiTnFrUkZ6elFIbDMxK2s1aWppUzRSelVN?=
 =?utf-8?B?M09lNHlITDFPNkttSnBVUENycGN2TTBjc0xFaDN6ZEsveGJRN2xhYWRRMGVm?=
 =?utf-8?B?Vm1FNlNaL1g3RDUxTU45VzFwYXVieFY5cVpRaC9YWGdwbU5wM1g2S1hVVnRY?=
 =?utf-8?B?MjB4V0hONXBWcFNlcVErSzk1b0xGU2xCS3RDQUNDUHdIa0w5aVk2SU5KTzgz?=
 =?utf-8?B?V0xZdUx4dUtiZ0lYS1ZWTjJkVC9OT1QvYzJQV0tncmdMSllhQlBWY2pUQ1Na?=
 =?utf-8?B?M1FvODgvZ3k5MGR1K2crUHVlQWplS1lQZ3p1U2VDbHJKUklmTkRRdDk3dlUw?=
 =?utf-8?B?UyswZDd4a0FyS0xYMHUzOGp6R2l0dnUxQ2l0M21aUlZCWGJGVE1QemoxekpM?=
 =?utf-8?B?WkNkVm93SVM0dW5nOUQ1aWZ4cU5BMnEwWkRqRGFUZEd5ekpJbU9GOW8wQjJE?=
 =?utf-8?B?VHVLa3NRcy9TTFZaMlBUQUg2cVV0TVA2M25YNDl5WGlzcW40QVF4TGhxY1Yx?=
 =?utf-8?B?Y2hFMEsrOG5lWTZ1dW1UWGljQnUxdmFJWkpFUkZobmMwQWxKQU9Pcnh5elpk?=
 =?utf-8?B?eEh5NkdYRDhPWitUeEZsak9aWmtvbXBSTE1SSWYraUdROVkrQzR0a1RKdVp3?=
 =?utf-8?B?TUJ3VWFnaEpMQ09FTElxdHRQanFtZmNOSmtsNHZjbWFvQ01xQ2t5UklUdkJs?=
 =?utf-8?B?M3FGY0hBYm5SS1ZGRHBIUjdkVFlBejFZZ2grNU5VeE1kMGF0QmpBbHl5ejVE?=
 =?utf-8?B?NW5EYy9wSmRGSzZrRWxhRUdhN2pBU1hjbDFCaFhhaTRvWnZzSXRjOVpRd0p6?=
 =?utf-8?B?anhRWFpxYi9wMWFSTnUwdFFKVjlJSWVsNlN6TFdwSndZcWFDQ0tSQ0RnZGE1?=
 =?utf-8?B?YWpFcS9QcUpjOSt4YUJNVTZJWlpJcGpEL0dDRENscm9PZjdCbEdFb1FmYWs2?=
 =?utf-8?B?dzB2Slh4NC9BVU0yQUtISjJEenhGQmthbWlWY1pocGZTUWFnb0ROYUdQLzFH?=
 =?utf-8?B?RU5PSTRuMXBMSVJkbnloKzdQVVRCVFhjVVJwdFQvZVAvc3d4S240NDcrSXdo?=
 =?utf-8?B?ZEZCMnoveStNd0t4U0pNK2JrUFVwSzlQRG5Tb0JvWmdualVWL2dORTh0Zjlx?=
 =?utf-8?B?aFdHbmdRSU91SHdReCtNSVdsUXVrMnFOdnhGMWk3WWRUcGkwSHMxTmV4Z05O?=
 =?utf-8?Q?/w1e6R9rQ8m/28NdI1PsMs45S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67429c34-8ab1-4a54-0b66-08db303a5815
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 09:45:35.1243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSz9B3y1rRO1AXd2q/rzO/2KZrO+jDWwcSd6PEJP88k5viJQ64RtxJQrVjob+bA+tT/tB+rB4MHT5wE1M6S37A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
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

>> @@ -716,25 +748,19 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
>>          * DcMiss, L2Miss, DataSrc, DcMissLat etc. are all invalid for Uncached
>>          * memory accesses. So, check DcUcMemAcc bit early.
>>          */
>> -       if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO) {
>> -               data_src->mem_lvl = PERF_MEM_LVL_UNC | PERF_MEM_LVL_HIT;
>> -               return;
>> -       }
>> +       if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO)
>> +               return L(UNC);
> 
> Hmm.. it seems we don't have PERF_MEM_LVLNUM_UNC.

Right. Is it worth to introduce one?

On a side note, I came to know that IBS OpData2[RmtNode] is not applicable
when DataSrc=7 (I/O). So, I need to respin this patch with that change.

[...]

>>  check_mab:
>> @@ -830,12 +810,11 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
>>          * DataSrc simultaneously. Prioritize DataSrc over MAB, i.e. set
>>          * MAB only when IBS fails to provide DataSrc.
>>          */
>> -       if (op_data3->dc_miss_no_mab_alloc) {
>> -               data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
>> -               return;
>> -       }
>> +       if (op_data3->dc_miss_no_mab_alloc)
>> +               return L(LFB) | LN(LFB);
>>
>>         data_src->mem_lvl = PERF_MEM_LVL_NA;
>> +       return 0;
> 
> Wouldn't it be 'return L(NA) | LN(NA);' ?

IBS has no instruction type filtering, i.e. it tags whatever instruction it
sees at overflow. When IBS tags non-load/store instruction, data_src->val is
set to PERF_MEM_NA, which does not initialize mem_lvl_num (Shall we change
that?). If I set both LVL_NA and LVL_NUM_NA for load/store with no DataSrc
info, perf mem output becomes funny:

  $ sudo ./perf mem report -F sample,mem --stdio
  #      Samples  Memory access
  # ............  .......................................
  #
            1914  N/A                   <====== Non-LS
             905  L1 or L1 hit
              19  L3 or L3 hit
              16  L2 or L2 hit
               6  N/A or N/A hit        <====== LS with no DataSrc info
               6  Local RAM or RAM hit
               4  Remote node, same socket RAM hit
               3  Remote core, same node Any cache hit
               2  Remote node, same socket Any cache hit

Also, L(NA) is PERF_MEM_LVL_NA | PERF_MEM_LVL_HIT. If I just return L(NA),
perf tools shows it as "N/A hit".

So, until tool code gets refactored, setting mem_lvl = NA here is hiding
tool's dumbness :(. Maybe I should refactor perf_mem__snp_scnprintf() as
part of this patchset.

Thanks,
Ravi
