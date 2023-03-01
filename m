Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9639E6A66F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCAERB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCAEQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:16:58 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46783527F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:16:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBoe0xxjdN+r6PPaEvhXR1/BApKf1SYpp2NoNZpIalS6wb4zwzGou7q4mVmDZgK01Tl9VaDacE/ggFIz4xQuOPsZlb7MxTh2eVUCwtLyec2JODHMzk+GpdVKuHKe7xEeM/JrU7eTbCvyaly9IZcqmAQKE0kzDcpNGzrRZmTMkfO1KfUsvLYHm8WNx+wFKmxI9wEIq6Sp+6SGw2dh3R5PZDykqnbesP2tWRT6VF/0Zll6cjWc9aLY8Zs4S0cjq2bP7rpVz3Y2p5teKZOzLtHHTp5XfZRLmKczxjdvYnu1SNFfIjyqDK6b/QwAqgTbjZBy2cNHpyc6CSF2w9Etu3LxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb6n2T8VsGIzEF+HAdvn81qk0ChFPODI4JHVB/y4xhg=;
 b=a4e8CcC2/5JtDjjvSgMhDBBcbDb4JBy0QI4EZcT/F+mPYDv1SCh3W5iy7EU21SQry6uMUqIOe8DLFg4NqoygbohgP1ZqeG9QioZERnAV4R1iO38pv6/LGDjobtTfwQB8nO3z4aF+HML/d6hgmN8y6mxS/VLkZm8b3g+S/azaaUQMzOCRAqgNYlFhxXGU1zppJKSUuQO19Xf6nf54egY0bygVzRk15QlOW7KNXyz7dbSUeHaIUVNNEyYf2J6XWvjN6Z9xH004niFIXJciug+yJ2f7+tiDTBiUAjYnbAij8dh85QGLmUe/Yjafyh0KRAMZUgOG6aoWiFBGxHkjXwnkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb6n2T8VsGIzEF+HAdvn81qk0ChFPODI4JHVB/y4xhg=;
 b=2/8UBoqZST17VuwFPtqB/LZeWQYn8rPQmBtMScxmxNOdmwb8UfgIGYuu6SdMhjfQ59HtfgTx9/9Sas3eNmumiH0VCAgOz33ZGFpqK8N2hOYcYJDH367UtFgyexZwTDpS8Y46+rlvya157FjIJqd7+UezsuV5/q3uuL/MMonVFWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2997.namprd12.prod.outlook.com (2603:10b6:a03:db::16)
 by CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 04:16:40 +0000
Received: from BYAPR12MB2997.namprd12.prod.outlook.com
 ([fe80::dc93:d53:3c95:696c]) by BYAPR12MB2997.namprd12.prod.outlook.com
 ([fe80::dc93:d53:3c95:696c%3]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 04:16:38 +0000
Message-ID: <bf81bb27-d8cb-d994-e78d-caccc55eaa26@amd.com>
Date:   Wed, 1 Mar 2023 09:46:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V3 0/4] sched/numa: Enhance vma scanning
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
References: <cover.1677557481.git.raghavendra.kt@amd.com>
 <20230228132425.1e18d47bdc4f406220a4a409@linux-foundation.org>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20230228132425.1e18d47bdc4f406220a4a409@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::22) To BYAPR12MB2997.namprd12.prod.outlook.com
 (2603:10b6:a03:db::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2997:EE_|CYYPR12MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 7614f78d-4f9c-4915-933f-08db1a0bb30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YZ2xf7wdgVlCvXLMzTPLNpFYuRz1OJ1D66GcPfcs+JmXxg3bjz2Frm4cIfYOM1rR3C/z4VpSCYf5V/BFKt0OSsy/Mpv7ONKQBpm2JIhibew7EzJQH6lPsbFiSnhf1Ynw38z6LMBDGBhR4wsUvEe7il0zPFRZd6nAjgW0Sjv3lC8pWYep/4slQT78HY1bud0NG7M7K0g63RZ3+hteF3rNxxV5ieypKfWJx4HBZ7y377TSonV5qLll05ncCeAbcyPZ5eK/09AV45/Gq2Ug54dMz8Ig4F6soYxnJH+rC4E97ywS/uIVdGA8gJS2W9sdnIkJNcPjfdYLNA62PIgV/jeNU4RuWMINGJVDhSW8BP2Mi6RGZeHp/uf0BhIf/9ggBfSLzMUGJ1Uj9l0pQnA8LK3XwLBc2ubTuIfCh85UxBuHQ3w3KvRi3Y5FTLvNdDwoyuTUr1/L9OQJGCc8XMutZPkBFjWTyu9wRHUc3443x4geGtlK0/5mvgpR3Rq00iu9pe2YCQcI3lZQuAR57inPkWknxpbRD3gsmA16r82BLT7G1NFoqWgjcH44/yeQu+lo3W6Fwps7BQmY1Y7q8aA4KSWuLmRt1Xe7JUlxHHwfR8w8sQcfr8nN6kRM9+DeGDKDdKdCMkj5Yw6Hjl1E0xf2QWlJ+OPtFdyWizIHAUs+V4i4n2oazAWnEB9w20S+OQhhpcAJwzm/DsCDAj5WQiXI+p3YwM1kvcB79TQfEozl3Q8pbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199018)(31696002)(36756003)(38100700002)(54906003)(66556008)(6916009)(66476007)(66946007)(4326008)(41300700001)(316002)(8936002)(2906002)(5660300002)(4744005)(83380400001)(2616005)(6666004)(478600001)(6486002)(6512007)(6506007)(186003)(53546011)(8676002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjYvSE45d3ZvYjRxMnBUbU1LeTJ4T0xaU29pYng3KzlNZEhtRE9NWUZMSyty?=
 =?utf-8?B?RU5KYmxkNVhwK08zWEk4TzFSaTdNYno3UTBFOHpUajFjUkZ4SlNoSEF1Mk1a?=
 =?utf-8?B?ZmdrUHY2bGoxT0NSdHJGV1BhS2tva3hEdHNnOGFtYlVod1ZBRnZ4cUVWVG85?=
 =?utf-8?B?WG1ZR1crTDFSQ3hxblNINGlrM3FyRTJlUE8ybmxFS3FlOEpSZXpPYUE3WU85?=
 =?utf-8?B?T09seFRkVE9OODhPRmprRldWOHNzNG9UT3BpRnJjZVY4eFhoNDN4WkhOUTNh?=
 =?utf-8?B?eTdiVFZDNEY3OGdLc2R6SGJrTWc3ZWY0ZlMxWFlCTExXVjRmR1l6YjVRbVU0?=
 =?utf-8?B?WlcxVE5yZGdsaFNmLzcrbUp6K1M2OXdUbE1uckJJZzZhR09zV0NEZjB1L2l0?=
 =?utf-8?B?VFQvdVVWVjVjU3MyVGFwYk9IbUZoa0gzdmFyalhuRjZRVkNyTDJuSzcwMHc5?=
 =?utf-8?B?WjBFTVJ3R1pVVEdiNkhQZ2huazUvOHpvY2hidXA0ejBJZ3ZTczN3Nmhjc085?=
 =?utf-8?B?OEJWbUp3cGtxcmJmMnFNR050U3hMQXp6cmJTOUc0ZWJySXRpUEVWeTB3YVds?=
 =?utf-8?B?eGZ2NWlnQktCNDBHdGhGYjhqeFg0WEN3K25UVGdkclRTZFFMVzhTOFdNTE9R?=
 =?utf-8?B?TitxOGtSeUVOWjBwZ3ZORThrUGdFZEtFRXpXVTdEQ0tNYzlxYjZHK0xIQU5F?=
 =?utf-8?B?OFR4N1BUZHEzMDNQaXFpQ2NNakxkNkc4ajNDZlJpUEFMSFdXM0JER1RKNVFS?=
 =?utf-8?B?REpMQ0V0UEYweGVidzc0ZU5hUVFMOWRBQW1XaW0zWmp6QVZ4ZnZoc0JDTmJp?=
 =?utf-8?B?YlBqQmZXRmpidzc1RUxqa0hFa3E3U1JzWFhCbmI1aCtZZlBsS2dHbHRpTjNU?=
 =?utf-8?B?VkUxN1NqQ2ViZ2Zhb3hmSUdaK3ZkVmF2S01WLzR2dkZvZzIzb0ZJa0w4Sjhp?=
 =?utf-8?B?ajc4RWRGNFo1Rk1XMkVvQThHNStocVdxWFpVbDVKSXRQclU5b0UwM3Eyelhj?=
 =?utf-8?B?MVNCWDZIckd6NlFyaXUvd0hJZHhZZ1BQd3Y4TUxSbFlkbVhwY3Nud24wdUd1?=
 =?utf-8?B?ZFV5SHdXRUJ6Q2lwWUJwMXp6SkkzMG1uUWt3WW9GaHhXbEJtM25udC90NTV0?=
 =?utf-8?B?aDdEZnFreWZEZHh3TFpERTlJWVBaZjRQbUt0ZUxNR1lFbEptdlNEcXVJWWJm?=
 =?utf-8?B?NU5PQTJGbmMrN2tzeWNjWnMvR3FWNENZOW12KzJqTnZmaURlUXhSTmFPM0ZU?=
 =?utf-8?B?d284ZDFqTWxndHEwRWlXZktOWjBRaTFZNms0ZS9qZXFQdFVGY05mOUdhUmtQ?=
 =?utf-8?B?N0lQcXdpVGNLTnl2MTM2aVB4Q0YwZ3JOTTE2QU1Fc2FZblkrZUx6SVhxSzIv?=
 =?utf-8?B?bEh1aGVlRzNFTjlEVkRXdXFlSUVGRmtrUkREZjJUQXU1U0p1RlhJa21nSVRG?=
 =?utf-8?B?V0RjS3IyU0VuYm83cEZDNDZQakxsNHNPc3BuZDdPTHd0MjM1YWVLcTBQZTEv?=
 =?utf-8?B?M2hZOHQ1d09qYWc0SG14T1ZBVERnSjljTzBzWklaVEdQYklrS2doa2VpWEcr?=
 =?utf-8?B?WEhva0FVSk5LclVOblhibDA5bWxVZXdBTEV4aDkvYXg2cVpzOVFuLzNjTE9E?=
 =?utf-8?B?WFFpOGdGNjgwN0tJS2RUYVhwVG9ic05OeWtpbnFsS2lFMnBKUzg5djlaQnBY?=
 =?utf-8?B?SCtYV3pmaFdGQkF1a2NXOWZ0SGZsWVNWbVB0TzE1TEhOTW05L0tpVTBpQitB?=
 =?utf-8?B?L2xIam5BRHV6dlFIYkhWMnE0SHQxa3pHaytQVkJKR2ZWNnJxNlozeGZzRlUw?=
 =?utf-8?B?SG5NRmxSbTIvWUJNS0RCNWR2M0NpSVBHZk5NQkR2UHNmSitKaEczNG5oL3Ni?=
 =?utf-8?B?bG1NUml4UnlXczlOejZyK2tXdzNMeHVDWWswT2FCM3EwWHY2Z2I5TEw1MGJO?=
 =?utf-8?B?YlgrcDZOclFzbXF5QTZGQ1B3VVUvc1B2U3dDemxLQUc3M3A4bmh5VEZoV2Jy?=
 =?utf-8?B?RWc1YTV0WlhEcCtxOENSK2J6cFovZGZic2V0ZEgrbDBoM2R4Q3Z0R2dpd0xB?=
 =?utf-8?B?ZGVWNmlkSERSZ09DMnM5RTZnL0RpSkp0ZXV0U1BaUlF5MnRmUC9kRGpBTGJB?=
 =?utf-8?Q?aU5RHKXZ191Ml2Rg2lYc6miKq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7614f78d-4f9c-4915-933f-08db1a0bb30d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 04:16:37.8076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9MVM0wI5YWm6Ni5SwvexBuApFLL9S5UOg+hyEa0W3DVrURfGLcwTF2NwuiSBd2n3WPUg/zGN19XvG/iVIeZcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/2023 2:54 AM, Andrew Morton wrote:
> On Tue, 28 Feb 2023 10:20:18 +0530 Raghavendra K T <raghavendra.kt@amd.com> wrote:
> 
>>   The patchset proposes one of the enhancements to numa vma scanning
>> suggested by Mel. This is continuation of [3].
>>
>> ...
>>
>>   include/linux/mm.h       | 30 +++++++++++++++++++++
>>   include/linux/mm_types.h |  9 +++++++
>>   kernel/fork.c            |  2 ++
>>   kernel/sched/fair.c      | 57 ++++++++++++++++++++++++++++++++++++++++
>>   mm/memory.c              |  3 +++
> 
> It's unclear (to me) which tree would normally carry these.
> 
> But there are significant textual conflicts with the "Per-VMA locks"
> patchset, and there might be functional issues as well.  So mm.git
> would be the better choice.
> 
> Please can you redo and retest against tomorrow's mm-unstable branch
> (git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)?  Hopefully the
> sched developers can take a look and provide feedback.
> 

Thank you Andrew. Sure will do that.

