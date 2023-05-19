Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB544708FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 08:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjESGn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 02:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjESGn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 02:43:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB3512C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 23:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hItJ+DljleSKOAhZjImhOE6d5PmeqigX8gThHT9Kt8GYnHg/7vAUuyH0/N5Qh7lfNUl00JJBa15OSL8xxG7LuG3sm9xH+mxZ2GHZ7lrMH6dMCHLMcsR+K0p8+5GXy0UaFlPOEIFXT8E087N53YUQ1J0utAlOYD6a1t7xTrjd4WNjBDDmVXbRmA0HkoKXl09b7/dEUlSwLqWyla94/TRGAeRTrR/pGnalc2yOqAq047PeeCu9iOPG+4Kcuv+CfctnxQ+aK4knRbrEj7PhJX6mD/M/gLoZiNl+1txY7zdnsfWsp03vT9K429uZ7PRMS4H5zB/72Z/EDFErdZHj2iOUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIhjpvXrVfi+hm+gmFK6h4I7nCtBN+WPB28aLWsH9A0=;
 b=RRACQyHAmnBudeM8jTad9KT4WWOiR4AUgnaMk0qzRlmfqZI+y6L+7/omwYA1DkZWg5S97+CqzqmxQQ16kVGnASRPxowa1RMUAbgUHyKF39wv0yN3rHuZm2JLemY/Y//IA7H3ivF7qRwVXYYAqVNpSVV2Fd2e2KwywPalQR1UFLvTs9SOQBTSkMQT+ODPlgn+v839dWfWEFbM3P69aolYeucOyTjHMZ2TBJOL6zZwQ+Luv/s18Dl3i90GXSx+7ZhGloO2Nas1YkX+lLH77BIkHEHcOGdmg6tVLRvhF4xVoDgsEoy43DdOs3STm3xoovGHfHgggbufia6qghWjxErluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIhjpvXrVfi+hm+gmFK6h4I7nCtBN+WPB28aLWsH9A0=;
 b=QtD2vCXq/xrlqeD/qekians2hkJZ/l3tw82pkeNim5fvKZ9eIWZfFqQqnjv0BU7BMBKShzx6MxcUO9aVpDmz4Z6joR6CKXzcZNtZzT3rShMq40p44ATDkdRGMgIndFIZlwZmDQ4aRiX2QdsNq/8jRMnppc7McDHRpSxhWxoIAR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Fri, 19 May
 2023 06:43:22 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::3d2c:e06a:5a1c:b1a4]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::3d2c:e06a:5a1c:b1a4%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 06:43:22 +0000
Message-ID: <6d62686f-964d-342c-e085-0eae2555cc54@amd.com>
Date:   Fri, 19 May 2023 12:13:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/4] Follow-up "Fix excessive CPU usage during compaction"
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230515113344.6869-1-mgorman@techsingularity.net>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20230515113344.6869-1-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::33) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|DM6PR12MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: a03f6a6b-92e9-4bfc-1551-08db583456b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9175yt5AjWAo+ANdl603HDaO7nOTUyLutDPyED+4SmC2wiza5vth6kgyTStAzP7oAy7NMAR2lbaLNOdVCj/2LwszkPhYVpOUPe1CCm63+3HupicqXPaeoj1ThVxiUst+FJ6ksKBth9lPP5ZpAYvF9JpjMW8ANP0Jcq6Z4MDtXhXyqbqwony8Q3y+xOdDCsUslt6LJd4XkJ9mlsY1Rprb328J+K5t0eALp9GTNnVIoUtK1FiiEXkP+bOC+mKp+PQeTqhO+nBIDCAFz5EWK+LbBYwLBXgyzU9rVJ6XAtbgpg72CM4dXvf9JD/35NfPUIkQuaFjwBe0srNWSfqtzUtj9697W87QWBUCo1mYAd3q5nFei44BOEZps8XTY7frn1ExhzrEPW5wLwqZ8O2a500R0HuBOlZQi1wfOpajzEdUSf2jxbM4DopAmPJfhTMQvDCjem0T8JTJydMR/tJ+khGWtE1rljpilQXJMcsjBooNSeEmHiPJ12oVLfpj7u/ngxjApQUlZfNoXBJp1kbsrk3vViSwOQSBb0d6rJdbn/iK26vRTHo9apHKDFRuCdLEMtI/WQShATmwfy8th5VgcP/H0MtJ71oRL3akiW1qqMxKeyDNmvVF+Uo8BdtBXMKG8XFrGGeLLDBzCS20RlDAEj3ZbxGMc/FjuUCHzEdc0Na+ZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(6486002)(6666004)(54906003)(478600001)(83380400001)(2616005)(186003)(26005)(6512007)(6506007)(36756003)(38100700002)(53546011)(31696002)(966005)(7416002)(5660300002)(8936002)(8676002)(41300700001)(2906002)(31686004)(110136005)(4326008)(316002)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmRueXBELzZUV0hZaXRRdDBsakkvazU0UjhrSmxQa3h1Sk4zaUxFVzNuZG9C?=
 =?utf-8?B?VER6VzZRRzZGaDBMZ2ZiMkZMWnBIM040V1RMa0QzSU43WWZDVUJTOGxmTjdW?=
 =?utf-8?B?V3FVcTVKN21PbHVvaU01QVl6bWsvVTZFVW94ZjlzaTZGVFVkb1NJeE05RnJt?=
 =?utf-8?B?ZnNoeWpCVFBWd2p0STNWYTlndFZEZUkzVkFYczFtUnVPV1ZFdHI2a3VCdjNF?=
 =?utf-8?B?YkdkUGkxdWJHODhmdS9tZnQwS1djUUErTTRGaStTcDdLaHdzYXhjcnpVcm1x?=
 =?utf-8?B?VC8zeS91R3ZSUzhvY3lzL2dXczZZSmhhcEN5dmRqWW9qRTNtMnRJeEdvMTQy?=
 =?utf-8?B?Ym5ZNUtxMlkxbHNWQnZROWhSUWsxdlh4TG1Hby9CVnRCdDEzaTI5NWdaRWpZ?=
 =?utf-8?B?anRlczFvVkZ2M0h3WVkvV25CUVJmNjdJZ1Z5cjdBOWMvODJKN1E5OUoyVFBz?=
 =?utf-8?B?M2h2UitocjEzczVJNVlUTnUrc1lTb25uVm9CbCtUNzNNQnpLQmxaajN5NXRT?=
 =?utf-8?B?YW5KZnRuczVCcTU4aTJLeUkyUGIzRHBHaTVEdi91TzNkK2lkY2xCSFdFaE8y?=
 =?utf-8?B?c2RHNnRPdEYzcDdVMHU0V2F2SmxYUUpmM1JXVkxjblR4NnpSTGVadWliTS9x?=
 =?utf-8?B?NVdZaWpVRnBOUXBBOXA4a2ZNamxFSTcwVVhVWTBhdTVuUUFYWGpJQ1h4TmNM?=
 =?utf-8?B?THRLRzZ6cERDZlp2YlgrQ2tTMEtDRERJVkttb2MvOFN1U3RKcjFrbmpuczVK?=
 =?utf-8?B?cEpubzk2TXZRcDR2QWVKQWt1ZkdHYjhlbWQ3UWxENFZ5YjducEttZS9udFF3?=
 =?utf-8?B?cFVocTY1VlRXQzF3bWhSeFNmOXRKZ0RYTTdxQk9QNGVLenR0YU5PaUk2ME1y?=
 =?utf-8?B?VW5xMER4UkM5NERUVkxDVXplNjJZaVh1YzlLTlV2MFRnNFVnSkxWY200WDhl?=
 =?utf-8?B?MUl3M2dIbDhkZ1lrTW42NFc0SDN5a1VjWFJHanRCc1ZKeU53RVdsY2hsNnFv?=
 =?utf-8?B?Zmk5NDQvMTc2elk5RStmVWxSQlVhaFVIY2ZBbVFZVWI1QkVwU1AyL2NDZEFw?=
 =?utf-8?B?WjR2Vm9ud3hZbHBEcENrWnNxRU5CRXlVbGdYa1lxTFN1SFBiNk1tWWllZXRB?=
 =?utf-8?B?S3VXcjZwVmpTWWlERkVnaE9Jd3BNQTl5eEtwUWg0UExPY05RbWVmNlRtL1o5?=
 =?utf-8?B?UnA3Ukx2Q0d1QVMwYm5NdlpmQ1pDU0sxT0dwdEJrUnRtZ1ZRNlFaWC8vR3dD?=
 =?utf-8?B?cFJBVDNhSm15Ymt6VkQ0LzB6bFVlREJPL1dwTTAxdHBZR1MySlJLS21WalFn?=
 =?utf-8?B?SEw4bVA2cnZlWUlISTFiRFY3VHBkMmhrdXp5Vzl3MWdrNXNpbmRkWlFXenpO?=
 =?utf-8?B?TXoyVytKU2kvaDJ0ZXV3VWs4OVJ1SkFWY2dTU3N4dE5LVW1EN1VDU2VRMVMz?=
 =?utf-8?B?ZFRHdHpEOUtUcGtsYWNidHJOSklaUUFwMGNJak1VL3B5czBRWVZhNlM3eVpG?=
 =?utf-8?B?dmp4cmhKQzVpdVpUZTN2RHF1ak1LRkM5Zjg4elVXZzF0bEV1T2c0ZXMwd1VX?=
 =?utf-8?B?MkhpM0w2azljV0JFYWY2TjJHOFVKU2k1TzdsMFRSL00rdjNBSjgxTlJEd2Vr?=
 =?utf-8?B?M2Z2MWJQS2hRcDJqV1ltem4vV1NxN2F1RU9RK1pPd0FvbTZESTY5TStBTDFC?=
 =?utf-8?B?L2RWeU9zNjlnL0dXK3hmMThveFhBcXlHZlZVVktWMEJCYTJ3bWxNbXJwaG0r?=
 =?utf-8?B?Nm0vckVIYmlJZGFqY1UxQ09jS2lYRy9BbGc3bXE2d01JbUtFTjM1eEtxSHVi?=
 =?utf-8?B?eXgwUlVIZEprMnBWeVlVSitCaFM3Q0dXTzh4a3pZR1d0dE9CTWJvcm9xWlpU?=
 =?utf-8?B?ODNjTmJnRFlOVWZHZ3hCM0Z6azNkeTl5bEhyUUliNlozMks2VG5naUNEUEFj?=
 =?utf-8?B?S3BzUk1TTEJNQ3d0eWNNR3lkcEhuTW5OWEozSTM0eHBZYk5xZVdlcjVOTWdQ?=
 =?utf-8?B?Q1ROOUwwblJzOHhwbmxCUEI2ekE1aGlpenlSVFVMOG9zK0RQU3BjUHNEa3JP?=
 =?utf-8?B?YzRUVTJpeFNpWmp1YlJ2cTM0RDhUNEpiaGRjTytrNUxIMEtZMFFjNU01SXlH?=
 =?utf-8?Q?7+YgfmVIkiLi6PblONmhiqAZm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03f6a6b-92e9-4bfc-1551-08db583456b4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 06:43:22.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkX26Oqn7HzfI6f622u3JaRbVLhcp/oh4DAirPJ7M6fw3zR8pmESqL2FinYbZLY5/015BNbcfEJmzNx9jan0Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/2023 5:03 PM, Mel Gorman wrote:
> The series "Fix excessive CPU usage during compaction" [1] attempted to
> fix a bug [2] but Vlastimil noted that the fix was incomplete [3]. While
> the series was merged, fast_find_migrateblock was still disabled. This
> series should fix the corner cases and allow 95e7a450b819 ("Revert
> "mm/compaction: fix set skip in fast_find_migrateblock"") to be safely
> reverted. Details on how many pageblocks are rescanned are in the
> changelog of the last patch.
> 
> [1] https://lore.kernel.org/r/20230125134434.18017-1-mgorman@techsingularity.net
> [2] https://bugzilla.suse.com/show_bug.cgi?id=1206848
> [3] https://lore.kernel.org/r/a55cf026-a2f9-ef01-9a4c-398693e048ea@suse.cz
> 
>   mm/compaction.c | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)
> 

Hello Mel,

Not sure how much this info would help, (also I saw it is in Andrew's
tree already) But was curious to evaluate the  patchset from perf
perspective, and I have run mmtest usemem so here is the result (Only
for  compact cases).

kernel configuration:
1) base 6.4.0-rc2
2) patchseries
3) base - revert of 7efc3b726103

Summary,
The result shows decent improvement from perf perspective as well as
compaction related data.

$ cat kcompact_fix_result_thp_madv

SUT : 256 cpu two node milan

usemem
                       6.4.0-rc2              6.4.0-rc2-compactfix 
6.4.0-rc2-revert
Amean     syst-1      102.18 (   0.00%)       98.98 *   3.13%* 
96.96 *   5.10%*
Amean     elsp-1      220.57 (   0.00%)      215.96 *   2.09%* 
212.49 *   3.67%*
Amean     syst-3      126.34 (   0.00%)      122.39 *   3.13%* 
124.09 *   1.78%*
Amean     elsp-3       84.72 (   0.00%)       81.91 *   3.31%* 
82.46 *   2.66%*
Amean     syst-4      142.64 (   0.00%)      130.69 *   8.38%* 
131.19 *   8.03%*
Amean     elsp-4       79.48 (   0.00%)       66.60 *  16.21%* 
66.37 *  16.49%*

                      6.4.0-rc2  6.4.0-rc2-compactfix    6.4.0-rc2-revert
Duration User        2106.24             2065.61        2047.87
Duration System      2598.68             2464.98        2466.33
Duration Elapsed     2693.98             2551.89        2529.83

                                 6.4.0-rc2 
6.4.0-rc2-compactfix            6.4.0-rc2-revert
Ops Minor Faults                  2440289187.00          2356626072.00 
         2354663705.00
Ops Sector Reads                         556.00                1028.00 
               2400.00
Ops Sector Writes                      20388.00               15556.00 
              16744.00
Ops Page migrate success            94642602.00            40234601.00 
           38486059.00
Ops Page migrate failure                2161.00                 467.00 
                725.00
Ops Compaction pages isolated      116977416.00            80467188.00 
           76966075.00
Ops Compaction migrate scanned     136909038.00            60060978.00 
           60479389.00
Ops Compaction free scanned        165907615.00            95661742.00 
           89794809.00
Ops Compact scan efficiency               82.52                  62.78 
                 67.35
Ops Compaction cost                   101419.99               43712.83 
              41834.25
Ops Kcompactd wake                         0.00                   0.00 
                  0.00
Ops Kcompactd migrate scanned      136909038.00            60060978.00 
           60479389.00
Ops Kcompactd free scanned         165907615.00            95661742.00 
           89794809.00
Ops NUMA alloc hit                1834950351.00          1853285684.00 
         1867258209.00
Ops NUMA alloc miss                413982625.00           359494012.00 
          345537623.00
Ops NUMA alloc local              1834950349.00          1853285649.00 
         1867258632.00
Ops NUMA base-page range updates   202326681.00           149242271.00 
          147460952.00
Ops NUMA PTE updates               202326681.00           149242271.00 
          147460952.00
Ops NUMA hint faults               195595665.00           148152760.00 
          146173618.00
Ops NUMA hint local faults %       159439097.00           148150869.00 
          146169658.00
Ops NUMA hint local percent               81.51                 100.00 
                100.00
Ops NUMA pages migrated             36155998.00                1454.00 
               3596.00
Ops AutoNUMA cost                     980081.58              741808.52 
             731900.38

Thanks
