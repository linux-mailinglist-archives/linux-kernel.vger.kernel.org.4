Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B219666BF92
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjAPNTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjAPNS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:18:27 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C293B7EE1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:17:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iophe91Rw9adECjWtvBCvhlWs61B164RlKzJZWLZAO5g2GNRO2ubs7Jxgbi7rPePIDmOf+ZGs/VRXEA1UCvM3LJRrst9gH4BjJLx3LZjtiDCEZ56svl3EMpy9mKqFrzFBepPyq7F/hJVQCHASJoLXsnMDap/bORUk/GJKJA264+HkR95KvS3WI5WPXV2ONR2B4f+m+7SlJ0UGvXVK3Uv6UqW6N9TVFG4WlI4OAWW26GBzEKgza/0S16B1Hw55WScMAABJdsRH73NIiMAJmk1somdomZ4+qKdhcLAnyPS4U+8IfEuKWGaD/R6FFQUVI+mZb0APv1x3wGT8E3KA6a58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oxKv5RXU0tHKcrxAYR7u75avAOR8cnHtqjJKm2jXWI=;
 b=Ijj1AkXmkKmuW7TMjbTPan/vn54nCnwB+Dyc0MDgVz0G3TL9wfBcTbQruwVkdv7PkcOF4g91+CQf38AyDhBNFfYwhTscWvLfcd4nOXHEKaxuC5jrHVaLm+0+xoCEVsvHSudVahTWXs0eEKERNdyOY/LrD97HDT/JPnzwwuI75Ts10CUB4oQdl1pkeMs8Wcl+IqLZRV+SPjmSMydg/gGtWz7zUNm20AijJPijKFNynFBUgNynMlM5JPFjIDLlJ7ItsC2FJYHyLzCDuNoYk3uTQ+0KbqcLf78vEPbrkHBQk/XCk60r3Fq4aOkyRT9qntUADpghgQHs41u7A5Aok3q56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oxKv5RXU0tHKcrxAYR7u75avAOR8cnHtqjJKm2jXWI=;
 b=5RnrB/u858npr6JD0TWI2y+WAx6FOLDH5yalt0DthXBr8i4wyCW5AnGv1pNB2XTBjgg7ZmvtujfzLhs1C08FJ2/gJrbvEvhBPLa6j/mTWKgIS3lLvG8/MhGJ48eUzLAACWDR8YN1sfSyraQ1bqWKxAEjGmO5PEeSPfuToF9JxHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 13:17:40 +0000
Received: from IA1PR12MB6481.namprd12.prod.outlook.com
 ([fe80::a5ce:541c:39fe:9370]) by IA1PR12MB6481.namprd12.prod.outlook.com
 ([fe80::a5ce:541c:39fe:9370%5]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 13:17:40 +0000
Message-ID: <8d44d547-2da0-008a-e0eb-e42d40ab993d@amd.com>
Date:   Mon, 16 Jan 2023 07:17:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] iommu/amd: Force SNP-enabled VFIO domain to 4K page
 size
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     joro@8bytes.org, robin.murphy@arm.com, ashish.kalra@amd.com,
        thomas.lendacky@amd.com, vasant.hegde@amd.com, jon.grimm@amd.com
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From:   Eric van Tassell <evantass@amd.com>
In-Reply-To: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:208:23b::34) To IA1PR12MB6481.namprd12.prod.outlook.com
 (2603:10b6:208:3aa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6481:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c28c6a5-2147-4b4b-9284-08daf7c40b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJtzlvzxSYOuMizbrHu2duJEfmB3UKAvJgxrPptLbjgjc9OvXGGcqw8WWfYBDjHGf3y/hSqFDJilwzW6w/umpHIfWSpasOqB5cwVETcCfSjVKFxnfq0a2nr7uEzOuf7nAJFSijzTBL4EmRzMp1zjeBd3J2nACZBOXGPy8BnLJ83GDF22LadBHY2BPNCwVebCghj2M+857m9+Fq4FAyLi5T3ngTQs3h7ZU6lQtK2HZKFDJnDQajAeza/ya2KGC4uXsNfghpGYc2Uk5OfuTE2ZQLyUNcQV+JQK2+r0Dikjuq7Ipobo7WYznr5yY5+3JlPCBRUCjU+WOMzq9+7uHomSBcV1vXvnx1CWqnFsBxK1hSa2NURvRENGMbrWPVslboNmZd1w53rK9IbmYjl1g+7CXumUle8DVT7TRMwsxSTmt8wMuLpfRArpFGtU/qkDEudl0GOfv+ggsTJ3dgsvBcpKcCVjGkUmBYEtAT2Q2GfkDAJYd3sPcCKJFy4LCl1BYMYq7rxw7UZwwveKVK8XkJHzeW3UYwt7idfvRfVCwZIbMt7eB/vayuuf5gvymXb7Fxkz8LEKZJCWZG1lA/FUkZ5LD2CpOIBbrYNxHDgLleDJj3ELjqvbyEiItlvIm3v8MUpkTv5GlxurDVjpkupWixG0UeprzeJrImqlNFMDiB3IqFaPt7RaN4ZU5SVDV4dM99zCPlyPf+wrmuUpxrpCdy6b9XQ7BPqC0cNex85uw3ild38=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(36756003)(31696002)(83380400001)(53546011)(186003)(6512007)(26005)(4326008)(8676002)(66556008)(66946007)(2616005)(66476007)(41300700001)(316002)(6506007)(6486002)(478600001)(38100700002)(2906002)(5660300002)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkZkVnUvZGk5OGVZVkdiNnhRdGZQZ25WbXhCM0ZjcE9vN3FqZW4rcGRtTHFt?=
 =?utf-8?B?VXRDRldHSkRmeHpBWnVYL2pySVA0ajJZSDI5MHgvSkNTblozOFlDSXRNTTRs?=
 =?utf-8?B?U0ZBNDVjNlBrWFlkZzNjZkxXR3hsNlZrRHJvK0xKRDlUOCtrcmhHbERIb1Rq?=
 =?utf-8?B?czZUeUhsek0xZ1ZFSzI1dVA5a3l2dUZUMlI0YnFKRUtuaEZLVXdpWHpjVGM0?=
 =?utf-8?B?bTU1VjZiR1FVN0p5RTR3TGI2OG9TeGI1MDdncWhQNm1qbEZmMzBUM24reGZv?=
 =?utf-8?B?TFppemRmNlpGTHZ6aDJoUzdTRFUxYjZUU214SlErMFliWUJUZVlCK2l0SzFm?=
 =?utf-8?B?TEJVMlErSXh0MDFnaWNsMmU3d0h6ZVNmSjYvR2tVWTF1djczSWVKdGZXc21u?=
 =?utf-8?B?dzFjeE1GMnJZbGtQMk1Kb29BV3IzMlpqVnNScnhPMG1ZVFd1OXBvRlpHV1NT?=
 =?utf-8?B?Wk1uVDdJVjZ5Zk9UbkUrOFdzajN2bVowTndReWdUbFd4WU94akNUczFFMlUy?=
 =?utf-8?B?OEFIU0JCbEdxU3JiU0lENW9IdzlUb3FYQUFLUWVLZ1ZoVlp6S2RNdzJDd1Fx?=
 =?utf-8?B?NUM4WnRoUURxV3FIRGxHM3NQaVBxbEZWcGJPTFB3QXVjZXFvR2hxZlZNaFlW?=
 =?utf-8?B?RzJvUEJ2QlY2VEVERzBoV2QybHlvYWRBREFETUJzSFYyS3Q0S0Z2Ni8yQkh5?=
 =?utf-8?B?b1ozbDNLWVloTnhQU3UzdnREaTJlOVdXMUVMeU9VZ0ROcFFLY3pmYXRid0xO?=
 =?utf-8?B?OVVwN0d0WkRRV3lXN0dTdE5Dd3FZZktxd0JtZFVZcUNUelRaejlPTmZpTGhM?=
 =?utf-8?B?WnVnTWc5bzFuaGNoOXhSWUhRcCtIUmYwWnhHdjdaWll2VWM3Yzd6QnZNcHRZ?=
 =?utf-8?B?MDhYNis2Q3VISHp6YlJEVGJELzd0eVBVNDJvSmxnUUszZWt2SUJrZ2QxamZz?=
 =?utf-8?B?YWJkZUFjdkhlRGpxdHJZSVFYNitCdzJmemNoaG5nc0lpTGZ1WkVlajY3Uk0y?=
 =?utf-8?B?b2duNEVvaFhYL1lKc3R0S0hHK2VaRTk1NUxuSWhDanRockR4S3VleStRaWhE?=
 =?utf-8?B?ZmZYRW5IcFBDNW9YeFUwL0tVZkpwOXZETnZpcTVNL3J1TTE1TWRvTkU4aTkw?=
 =?utf-8?B?SW5yejlaVnlhTmJCVThGOXNxdlBLZWpNTTg3dWF2MjQwM2IvKyt6NlFOSnBK?=
 =?utf-8?B?MkVQZ0RPdzB2QXk0TGxCeUYxZWZtMnZuaGpXUUFEaEpycU5DQ2Q2UW5iUW12?=
 =?utf-8?B?R0NxZ3RiS2pKUUxvK3EvUnVDZlN6S3ZxSlFtTi9IeW41STVVaVFweFBHSHVX?=
 =?utf-8?B?THhWVmpDMW53V0tCZmV1NmRFUXBLa1dFaldmQ1NoL0dYNEt6WCtDV3B5dnR1?=
 =?utf-8?B?bW0zOGdmMHFpMlB4R0RTbXgyZTFRNm9VakErVHkrT2JmaEZKdWt3NEtWcGxY?=
 =?utf-8?B?TnZ3eW8wMVByMVgrT1NPMVQyN2I5N1BjVFBmdDRlK1RxazRDekZuSXBIcnhZ?=
 =?utf-8?B?YVdLYm12bkZOQUdEb1JubGdoekVWdUdSb1FLZXBaRFlLUFhJNDkyNGovb0Iv?=
 =?utf-8?B?TXROSWd2RnRNMk5NdVBsUjZZNzQxd1IwWTcyNGE4NHllOHJSREdKTk1ucWw0?=
 =?utf-8?B?V2tBbnVOYVZSM1ZEdUMzcXBaU2xoclRnRGxXc3hYakdCQXZUNGIrM2p5UGdQ?=
 =?utf-8?B?VUk3aTR3NjJwRWNGUVU3U205SjVJeUsydjBDQURRMHA2Vml1cmFDZDdVUVBz?=
 =?utf-8?B?OTBMbnlXQkdNV1g5eHlPZHpxbnJVOVNsY21qSTA0M3FnNjNWVUdBTENJZ3Iv?=
 =?utf-8?B?UTVyL21QSlNJQlhsZDNVNnBZbjZraHJuVGZjOVVUSWVPYmRMMDV0UnhFN1dN?=
 =?utf-8?B?N1BTWFBPNnpvUTh2K2txejY2SklJdlZrb1pna291VnlFK1pmY0lRZm5hZ0F3?=
 =?utf-8?B?dVVHS3M2QUVMcDNRV2VMMVBsY2JuVUJYUTNGVWt0Z1lHMnNjRXpHeTNMdHlI?=
 =?utf-8?B?VzBUWDZPaVd0VG1PdDh4TEJ1akhFclhjM0QzZE9OQnhiNk5zTXlxZ3lpdmcy?=
 =?utf-8?B?b2hCZ3NMcmZMMGxTUTRib1J5UDZzV0xuVTlXdzJKR3BTbVJUMTZpSTI2Mkd4?=
 =?utf-8?Q?GrRbFQ027JgIPCdJ4BZQ5hISF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c28c6a5-2147-4b4b-9284-08daf7c40b6a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 13:17:40.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wn3Y7vXuBlgjmNjxuvDUNeFjFOu3CtOo6Ihd+XF1NDLYBdGrZsGmGQgD9x7l0M8CQupUZ4n64dOAmTnFMQO1XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

what commit should this series apply onto?


-evt

On 1/10/23 08:31, Suravee Suthikulpanit wrote:
> To support VFIO pass-through device with SNP-enabled guest, IOMMU needs to
> setup IOMMU page table with matching page size to the RMP. In order for
> the IOMMU driver to setup page table appropriately, it needs to determine:
>
> 1. If an IOMMU domain is a VFIO domain (PATCH 1)
> 2. If an IOMMU domain belongs to an SNP-enabled guest (PATCH 2,3)
> 3. Appropriate page size the IOMMU domain (PATCH 4)
>
> Please note that patch 2/4 is a preparatory patch for an upcoming series
> to support SNP, which implements the call-back for the struct
> amd_iommu_svm_ops.is_snp_guest().
>
> Best Regards,
> Suravee
>
> Suravee Suthikulpanit (4):
>    iommu/amd: Introduce Protection-domain flag VFIO
>    iommu/amd: Introduce structure amd_iommu_svm_ops.is_snp_guest()
>    iommu: Introduce IOMMU call-back for processing struct KVM assigned to
>      VFIO
>    iommu/amd: Force SNP-enabled VFIO domain to 4K page size
>
>   drivers/iommu/amd/amd_iommu_types.h |  3 ++
>   drivers/iommu/amd/iommu.c           | 45 +++++++++++++++++++++++++++--
>   drivers/iommu/iommu.c               | 10 +++++++
>   drivers/vfio/vfio_main.c            |  1 +
>   include/linux/amd-iommu.h           |  6 ++++
>   include/linux/iommu.h               |  4 +++
>   6 files changed, 67 insertions(+), 2 deletions(-)
>
