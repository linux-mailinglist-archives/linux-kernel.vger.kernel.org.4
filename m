Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18666945BF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjBMMY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjBMMYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:24:54 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A818B07
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:24:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSgkqB2+WZJ/dMgycvgXnHX2oVbbtm0RweW+FhgZvW5e5wLyxRcMcGmuiAB4svEQBD3aQ/mQSpZG4N+pbpLlSICjCp7bLQVJc54isfDstp6QdX1rNzkhTmNiQJOHyTZc2KS6NbqsFT+TY7fvuxRMWvebjTnjiL7iL/X9q+ciJ7E9RvdARihBcFDwkzn5+TyudIU79Kbdnan2tpMTtXxFk6VexIYJSWdF5mqOT2bECNDMw1aU+swx3Uwlya2xavauUHAdCWDV/8rHPS5xi5g2BYjh5/1qdC/VwdF8t7/W8MaKxdid8IraHKmsjd6WMaj6rywAP9rhrQH3sfPKgWspkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xXS5RSWpoOlvnNfeQkeTwNMoZj7tE/h0FjNdM6tFDY=;
 b=fEeXhR/a7+eieLAQwr85hEYLXBzGYm/7jfQ/E2h48i18ksN53GyfjSzjBxEzG1sieo1CBNyoM/9gG6o9ZT/skIMu55jb2ZAMxyjQBWnq9Uu8t0+JVq4aoYTfCC9F44sG2Avl9qXrYBAh1rnCbe6AZtt2Bhsvto4BnN7N/ZqtQItyk5sGKdLOZXfsqNr7M2I8fsLVCiQQbwACKhhmReTRxcA7ZN0elfs9BQjG51B8xIvvy22nvkrvVgp+ojbwDyJvhUlHrplCz0cP4yrJWdpmwfQFD3pV1ZnW93JQ8ogrFfvRvF3k72o1nRP7MWP/j7yB/txtelPZc/XRdgEISRNvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xXS5RSWpoOlvnNfeQkeTwNMoZj7tE/h0FjNdM6tFDY=;
 b=JMnSvJFIX5qKtyWY8gTsqDxmxluGXxLDZ1VVy7NnA0Z67/NgEdvx7Y6WresAwfw71+ddVv16uRExiodtAOqEuRpb83ICTIrFGj6mbA7B9zIhnTSHiI3TNeiwKdTKlI8Wy0IHGifOovmxaeMNzovCpx4pWxGUW/L5zvreRBUa9ykcbQy5WcpuxFRUw13CrggA1uFYu6C33/pprJzeIDYdQKKl4dIH1zF90USJxv2W2quoR9ktjtisKU7aeEEwMNSeHsYf4atDQXSy2/AjSucimb04M4in6yZDapX+idw6fjPv+xzO/owfmsYv850hzEkcXQkJ8sSdoP/401nMdog4xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Mon, 13 Feb 2023 12:24:48 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::e3cb:bdc3:f869:36ae]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::e3cb:bdc3:f869:36ae%8]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 12:24:48 +0000
Message-ID: <570ab4b9-eed7-3c5a-400a-261a9a205b4f@nvidia.com>
Date:   Mon, 13 Feb 2023 14:24:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/2] vdpa/mlx5: Initialize CVQ iotlb spinlock
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, si-wei.liu@oracle.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230206122016.1149373-1-elic@nvidia.com>
 <20230213071855-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <20230213071855-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0326.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::7) To DM8PR12MB5400.namprd12.prod.outlook.com
 (2603:10b6:8:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a36085-7673-4d34-aecc-08db0dbd4be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/5SzdvH+haEmdDY4xIn2SEMIVQb0dhLJLPx9id0T/qSfyVcR0beAfAPf/88lOhfEc0AyC2G44YR/ytRa1D/KRg0zLuHU4LrvVDjNWAbc4fw4JHJlxDkJxGDrJ6IKlel18axe6+c9VVjqn6jqP9InGSxQTkk8PHEK40rWI1ri4bvGS7r+1/eAgNPuchHd+gVKISebhR4DBxhDcg34VSQQd2ZTTVy3HYP3d3b1InEqPN4bbdgSO5f8ylCrZj6ahN3NV4JVGwOGqObeMNmDEv+vOJd8iR/9yUwSZbKKfns7NjIbMucwjfH0jnjtisvMWwS1nM7QSWPo7nnW1uu7oueyjX3EjV4YXycTyWXR4zyFKZc5y/XJ4ud4y4OmDADEGITgYr7Du06RoaITjujSvkWK0TCL29Qx6+fPSkOlS0CDsv52KHkJTNEEq0N8t7e3RhVNCk9RR6sVkjIN+/4uXYeWrn/QsMLsaooVO2l7ZIDlxl3wpYi7IdNYH3qi8wW7sBagVOpq4rP3q8fcxpVxcfVS6oZW7S6zEuWr7S1z1mEgXAdGagPXbgd0tGCPKMn1oxfvm0qXmXRxvc+GVEmBAVYTk+aJ7X8s7ixHEtUHXElITdEjWVai7AV+dKC4LDCPPZrNfij4hIW+tR8DBBNU8dyutUKrnm+g6J3xXV3Kq+kPH/U+UO01Cu7reaLOdhm0d11rppQ460ls2iREBTQYemM64Mll3tcwrTP9eJF1tOOgD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199018)(36756003)(2616005)(83380400001)(38100700002)(8936002)(41300700001)(5660300002)(6666004)(6506007)(2906002)(53546011)(6512007)(186003)(31696002)(6916009)(26005)(316002)(6486002)(86362001)(31686004)(66946007)(66556008)(66476007)(8676002)(4326008)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjlzRHpTSFRrUzhHcnZXNW1jTTgvR05VU1ltZDRMRTFLWG53bWFPVXBnTDBK?=
 =?utf-8?B?b29ib203YTBLUVdFTmMvTFFHRjI3elBST3JhZEQ2bmRxbSs1SHBBc0h6VzVV?=
 =?utf-8?B?dTFGTmd0eEY5eHl3S1ZGc3hESXJwSzVBekdkUnpWa3d3TG9xU2p6UmRCWGFh?=
 =?utf-8?B?ZWxhdE1qMFcybHVwd1NQdmhSUmNtdlBwZzNOVHluVXpYeHNtZGxMMHBteTFP?=
 =?utf-8?B?ZmdwOEhEUERBY1I4ZkhoSGhJWXdoQUtBaVB0ejhxaGt2TVNvQzFIN1JiS0hy?=
 =?utf-8?B?RnJlbmhjNXdJMlVSNXZyK20xcXJnTlorbHViTDc5U1hBeXlWNjh0enlZeUxl?=
 =?utf-8?B?endMSEVmYjZaTkJQQ05iMmlGWTg2NWIvTnp5S0ZsaGJldGo1RGZHaTlXSVpl?=
 =?utf-8?B?RXA5QjZtMllUQndCZUVrb1RHTjNwcFlKN2JGWnZmUTg2QUxiSTBSeEhYeHZ4?=
 =?utf-8?B?QlQwbFhQdHRVQ0JpRkFNejV2UkhXNEtBQmxRcE5uT0hJbUpwRllRWVM5M3FI?=
 =?utf-8?B?Z2pjckw3VGh1SUIyUU9wMWtWOFRaK2FLYTRQQ3NmbVRNbzZObUM3UElzWFBG?=
 =?utf-8?B?SDhTQzJpYkZJcHM4Y21TMUdyaHFSQWNDZkw3YWdMaVFEMGlmcXpERkJqY2Rs?=
 =?utf-8?B?NnNiM0NDcTFkMnNaQUh4Wk1sNkhwdnI1aEk2bTAyRk5xbjBqRG1JN1BUOHhh?=
 =?utf-8?B?SENIRXdObnN5K01udzdJUFpmVENOSVRibmlMdmlnbGNWbmx0S3JaSW1LRVZM?=
 =?utf-8?B?dEF3bS9aa1pJVHEzUHJnRzdjclN2VmNtVElDNkdSRTI2ckJpMVlQN0pHdEc1?=
 =?utf-8?B?ZTRXRStMb0FkbzlMMDRNbStVMnBDSlVQalF4TjBqTmh0OXk5L2svMStWUDZo?=
 =?utf-8?B?WTVaOFVEbkVGTEk3d2p4U205eTEyOVRSZFA5V0t1TE1NdGE5eWVSYWtlTkJz?=
 =?utf-8?B?bFYrdUFmV3AxZ3FiSDdWcU5pYVJDcWxweEFvdFBMcUYrakVZOElLME5hSXNt?=
 =?utf-8?B?Z1lnSHFtZUh3b3BqamVJYlpQR05DZWExek9YNSszdDFZZEdDeXBsZGJvQW5a?=
 =?utf-8?B?WmVvZndlMGZYVVdJL0xTY21GWTZKdXdTY1dlK3I0Z1hnUUkzZ2pBVzNvZHZi?=
 =?utf-8?B?ZGU4Q1ljQmRxQW54V1VvajByYXdyTmZiUFFDRWplQlRDaUVXejV4b0lQUjVO?=
 =?utf-8?B?WFBNZHlUakdWcUpXdm9LN3BCT294RmFKSGZpcHozZ0VKcnl1ejZ2b2JUQUpK?=
 =?utf-8?B?TlUyVjNrcHFUemJFL0xrWmF0SW5nTE5HMWdESk1hajJzN3phN0NTbGpmeW91?=
 =?utf-8?B?RVdwNklSRmhWTFBtdCt3U3IrN2Q0bU9VMXBmZGxIdzVHWVMzcHhOckhIMFh2?=
 =?utf-8?B?ZmNZTFN6R1JhNk1GalI3ZlJSb0x3eG9TaTg3Q2ZRZUpmRXVCNEw0bnZyMFl6?=
 =?utf-8?B?QUZpaExjeWp5RnFHdDJ0c2dPR2JWcHpYbkJFNzlhRHh2Q2p5N0lqUUJycTdP?=
 =?utf-8?B?WnpOeThPN2pWKzFaRTlyVlBYUkNKM0dwT3kyTHhNazliaW1LQnpXYTdTanVM?=
 =?utf-8?B?a0poVXdTZFZGTzZlTWV6RDZsTE91V3lZbUEzWGMzNTMxc0Vxc084N0JVZ3pE?=
 =?utf-8?B?ZTZCMEFLa0Q1cjVVUWNnZ3pmT3pHUC9XWnE1bzJ2cFNLOW9CU2docXF3VnFs?=
 =?utf-8?B?UnJXNHc1b0hjc1pIdzNpbXBzZTVmOWpxN2l0R2JTYVhBZmdVUXJQeVpTbmhn?=
 =?utf-8?B?Z0tmNy9Id0p6RkhMTy9WYmx6ZnBGRjJHY1JZNjBOYVRBbGdHUkRwTDB3WllK?=
 =?utf-8?B?SXlva0lGVktlQjVqU1dSbVI2NlhLQkFUeTk3eXBST01mM1had1NpYVNCQ243?=
 =?utf-8?B?b3J3MnpweGc3VndCVytHbVN3cjhTbzJxQTBIN0R4YjFVdlorZXRCa1RNSU51?=
 =?utf-8?B?d0xTdUwvTVQrZjY5NTlpckt1am5LMG1iWlVWY0hpN01IbGFDRktlalkxSVUv?=
 =?utf-8?B?Qmp3YUNLMjEyMjJ6dEMraW94TGw0SFFyV2QwWG94VDV4K281dmh2REcyVFRU?=
 =?utf-8?B?b1dEWmFHRVR2c3N2Z004dnVROW5jbkFLcXpYUWpIY1BCR1VlU2RyT05Sd016?=
 =?utf-8?Q?lvwxz2+x98qT4ZwehPAvPj01o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a36085-7673-4d34-aecc-08db0dbd4be5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 12:24:47.9049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AsBJdhErw3qbYtBVtLTgKJ+LVmFTekSAnmTD1iQV91xSauDjSI23kxGtzBC18kv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/02/2023 14:19, Michael S. Tsirkin wrote:
> On Mon, Feb 06, 2023 at 02:20:16PM +0200, Eli Cohen wrote:
>> Initialize itolb spinlock.
>>
>> Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
>> Signed-off-by: Eli Cohen <elic@nvidia.com>
> threading was broken here but whatevs.
What exactly do you mean by "threading was broken". Is it because I sent 
two unrelated fixes together appearing as patch 1/2 and 2/2?
>
>> ---
>>   drivers/vdpa/mlx5/core/resources.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
>> index 45ad41287a31..d5a59c9035fb 100644
>> --- a/drivers/vdpa/mlx5/core/resources.c
>> +++ b/drivers/vdpa/mlx5/core/resources.c
>> @@ -233,6 +233,7 @@ static int init_ctrl_vq(struct mlx5_vdpa_dev *mvdev)
>>   	if (!mvdev->cvq.iotlb)
>>   		return -ENOMEM;
>>   
>> +	spin_lock_init(&mvdev->cvq.iommu_lock);
>>   	vringh_set_iotlb(&mvdev->cvq.vring, mvdev->cvq.iotlb, &mvdev->cvq.iommu_lock);
>>   
>>   	return 0;
>> -- 
>> 2.38.1
