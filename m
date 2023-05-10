Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881406FE5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbjEJVK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJVK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:10:57 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BDB2103
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxLS+j3NT5jcuCJyimzCANSp94/b99idzzbU2wUfTPqaM9ghL8N5nfUd9u3mnN/CGZKhOr15TorZa/EBQbEvajteeeYx8kdCayISd7ClVX4XoHqPkoXUS2DuEcykISvNqYEl7PHVIvgnK+njiZR88HY+SyVM67p44gq5+mS0QXMOFNYma2JaCmUAAjRtzpfl1f9H/yYVOpP7mBm7RBglTCzKspIn3GMLKpwuMsWTYWh5KMNm/Qi2tMpLBLxXwYZ0mKUuivIfwQcSS/HIQq0w9YN3XWlo09hJeEU8x0WOwlhXaxns/JT7trTjXKiJH+S8MoGbeZEI5NEhUa0voD2iqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKQWilM2TdzxsBd5QJu4ltFNwcAwZDF8l02y6FfF30k=;
 b=jPdCOL0q7eKojkLWceiPYgZbie84DKDzIpxJBo+sFERLs0IRRvbwlACi9I4HgvigW1fQUdx7TJ2AvkzC0Th583QlC+jH6AdJZ7hvPjh3gtdwsWMczmBc7WdG8RlIJb5hYz8BozsyveRucR09N7Jw3opoN7Gpjygn7QT8O+41MRFKSvtUvOoyz9ShKRmJCElXMFKXNhmmVwo2L4q62apxSVo705d0IfZ09lpTHsgJ6iYCGkM17R4S/U2BuvXrZe45uR0NO9Rv1Y5waADs8JCb0FJNPWS2xb6GlAmryU45AqxE/0MQ98SvOUjsoimLvMi/6gBgUg15wJ0v4Q2ZAdDvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKQWilM2TdzxsBd5QJu4ltFNwcAwZDF8l02y6FfF30k=;
 b=Ca6QqEAZas+yuumc9bpg1KsGc7YO91T6fgBe9GqkNLTS21QfXCZylFUJZZVFn25UfIRVRj5jy+QSW6uRBMcqnz+ipXqqxp8Pb31wD0+bvRXToMi4KYspaUeKKXwFe09+OoI3L2dYk26yx+wU/PZsyezvvHLBtboivz6HGU8+CFiSvUzJPrpFNWsA0Ar0pD+U4EQpRr0XpyeQDpLdX0LQOzfPcMCkyL5Ky8cFcWQ5AlvLZcOZ1Fm8H2ymCM3db14iSP7q8SGYfbbRzEXDYZUS12IWgMyPPTNjXlTiKme09vqMKOQx0U80wvs97H7xv8cZgbxyNTYXvPms6u7TBohWJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20; Wed, 10 May 2023 21:10:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 21:10:53 +0000
Date:   Wed, 10 May 2023 18:10:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] Add PASID support to SMMUv3 unmanaged domains
Message-ID: <ZFwIWz8kBL+bti1m@nvidia.com>
References: <20230510205054.2667898-1-mshavit@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510205054.2667898-1-mshavit@google.com>
X-ClientProxiedBy: MW4PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:303:6b::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 70881b9b-0278-4008-7e03-08db519b09f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+3NMCE0U7ghFoq9noXZ+B5dHlmtsjsGxepdc0tCg/Qn59mDq3eo3qMhEkNmPppZufmx9+y3bNey7hfuznBA4FcDChUo3bE1NMs1/7ukS1WrlqoQk0O4F3CjW60PFekdIefHJnHZS0078uXBX2eZAAq5iy/i6WSJv818/fnQyYMrqpJvxVXshp7S6J2fnLf6wFsjHu3z40q30GGsn2WYJ7dZ69DqV9WnJfdAVgXLtqv3qvuBezuiItN4SVEODMAOf21AX7cACKct4W+/vVlYUzhMtTIgnHhStNghb1esJbBclc/9ledEeuOKB6OnOCpLEyPhQK2VxEgyzSMD4hxpMvujP5pyzCQudHSo+niwxZVGVCmH7AE0wWeFaXi86it3KjVfOewTfGtffqE1eEXdzcuTr/B62ycB2ezoFIy8X9SfDK9feAIZbq34oxPo9s6olkTBIElAsOeJyJEEqm6Tz9jhOZKHTMb22RHLNU4bCDcc4JsssCeX/gmG6jp3oeZKXSCDbYC7OX+M9HzL/QwyXZenlq64fEHm8Pams8zSMnz1mHTloqGCxYRQxutncwVHI6UPskSZX9BDGDeBBY/RWBypffRD1YB5ZuCz2bO+HNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199021)(2616005)(83380400001)(2906002)(186003)(6916009)(66476007)(66556008)(316002)(41300700001)(66946007)(54906003)(4326008)(6486002)(478600001)(5660300002)(6506007)(6512007)(26005)(8936002)(8676002)(38100700002)(36756003)(86362001)(66899021)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VrJeY6oQYm0nLajRYwN5aZSNCZ+KBooGmI+0UuNOlF/qekSPa1CK9OWyE+c0?=
 =?us-ascii?Q?f4cxbngZy1eGq/YxlrhPi6ZDSCcHNhGgoHlE93h88Ani0AwC780Jq+ncLIzM?=
 =?us-ascii?Q?R8VjaiRjFSB6nMTEkhuJvLyWiU9/h7zzbRndhUbqCvQJubkxU6SKSDL/wwM/?=
 =?us-ascii?Q?lyh5C5sbLdBGfnGn8MEcdLm70nNdGx96X35ogPP+l897Cs47Pb3KUH8q2eZz?=
 =?us-ascii?Q?psikoqpEDCNGWsi9mFxTolmnwCtyqATNcHK7q6dGjyp8sH67+uzVoMAz0Lmo?=
 =?us-ascii?Q?TdyG/441zGVjL4ucXyxxDmWMS5ti7jSUPI54YrLia/yvQoaqqSpHojVLO8Zk?=
 =?us-ascii?Q?h7c4nDElbtuRo4mJkLHG9BmrfI2oiq8BiydvKKuHl/ludirE+oq7uRwbeQoq?=
 =?us-ascii?Q?iA1WQmQ9y2P4mjFKUMgUcZv173nUYqaFwsyy7WW5po7nFx3V7GADiuT8G7vt?=
 =?us-ascii?Q?a9oHbs/DgsheUFubSIQy2GmpvGfzJNoPVtZ5f4TtVWu1ml3yFu/oXibLmLUF?=
 =?us-ascii?Q?h33gLhvbBn9iqcjJlWexwIdfmpEynT+At38yukaB95WEnDZ8Nu1qc/vl34eT?=
 =?us-ascii?Q?DImrjXX1vvE42NhT1xFMNE4Wo6ajeSGM3gaO6QF/iJi6HjMAHB0HrB3AFNe+?=
 =?us-ascii?Q?elfZcxzQ1GzK7y2O3xhS6aE83ODRDKRzb3aQrCEXE3D15vHinBvu04w8pziB?=
 =?us-ascii?Q?l5ZOOvf8QYs7wvoxQyz38cmPZSWUgM388Z2MfXPtCjgYLtn1D0d8giVMykIn?=
 =?us-ascii?Q?DM1puYETnQeGHNevSOV7+/lD3vZZ1DQnpFLOyR1WGOEgXE4V3zs3NTpHY3Je?=
 =?us-ascii?Q?KrLbPmWGqwdLxZMHQ/846REOhrJuz5abfCrkHvd/wXN5BWsy68I5NRFT2HNB?=
 =?us-ascii?Q?+SfhVj6EugpdSp8NJJeA+ZOagREUBbky4XsLT/OQv7SbhPKf+XKFgI9HU4DA?=
 =?us-ascii?Q?JTP5kx0d8my2uDrCgDG38ZC6Wb/rE6vJAOdKIeTE95wcElA6phT9Ahf8GnFE?=
 =?us-ascii?Q?Hag1gSYCWRMs8+C0xrsrY5aJokpm0jV0564uIWuwp/11M4UfKXZR2f1GmUjb?=
 =?us-ascii?Q?EdZXyPAcV+fOpVVDoXDjY6FxRGCOx1kkLAnYXPqB1uEPtuPNBJpfiY8vf7tw?=
 =?us-ascii?Q?T5DBc3wjqR9QFmOJPZeBQLWSQGERAzmopXkE5BeFeAhtDbpCbWSburGlHOI7?=
 =?us-ascii?Q?+OS5SCbmlLLKG/iGfqfPq7JkLBpfdD8ZnKtwZdYbiyLMTZCu6Hyl8eghXPU1?=
 =?us-ascii?Q?ZU57KsnWrkbzXacc/kZcZJgSHWkT1KslG65YgyJw7cm0VGyGgB7WcOx8wqfr?=
 =?us-ascii?Q?c9tFyTdFF8e8LuIzmzYBtiW5mcsI+K3KK1rbZ/HtbttLGpAAXHGKUZ/I9TAq?=
 =?us-ascii?Q?X68AVWrrlBtb1mvISBu0YM46lrqu8zD4AabMQU5ibOXDER2aTH8L6stWs140?=
 =?us-ascii?Q?QiXRJ8hqxF/Cemvoac5dvI6mLSpAtKvS03nojAdpwTomixnrokiwlQyF1CQ0?=
 =?us-ascii?Q?Hrhy2OJyn3eq4TuWG0H5BbhHOxmrLeN28p/3MrDUD86HtsrLUdtbNXKjJLat?=
 =?us-ascii?Q?2svDv4Xz7zq0hXklp6s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70881b9b-0278-4008-7e03-08db519b09f3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:10:53.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uj53FJX6N/WBp28rVn+a6QhZ0Z41Umzim47FbYjzIHcM3/ZDThAp5/UUkKj+cj+o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 04:50:47AM +0800, Michael Shavit wrote:
> Hi all,
> 
> This patch series refactors the arm-smmu-v3 driver and implements the
> set_dev_pasid functionality for DMA and UNMANAGED iommu domains. As part
> of this effort, we also refactor the arm-smmu-v3 driver such that each
> iommu domain represent a single address space. In particular, stage 1
> domains hold a single ContextDescriptor instead of the entire STE entry.

I'm not sure what you mean "holds" a ContextDescriptor?

Ideally the iommu_domain should only hold a pointer to some table
top. Depending on the domain type this would be a S1 IOPTE table, S2
IOPTE table or a CD table. Plus the non-table domains like IDENTITY
and blocked.

Logically when an iommu_domain is attached to a device or a PASID a
STE or CD is generated from the iommu_domain's configuration but the
iommu_domain doesn't "hold" it

When a kernel-owned CD table is used it should be held someplace else,
certianly not in the iommu_domain. Logically as a per-device
structure, but maybe with optimizations for sharing.

> The refactor is arguably valuable independently from the set_dev_pasid
> feature since an iommu_domain is conceptually closer to a single address
> space than an entire STE. In addition this unlocks some nice clean-up of
> the arm SVA implementation which today piggybacks SVA domains on the
> "primary" domain.

I always thought of this as sort of a pre-calculation of the STE, that
gets cached in the iommu_domain? Not sure the pre-calculation is that
valuable though..
 
> path forward for set_dev_pasid support? Or could a uAPI that only
> exposes a single CD instead of the entire STE be an appropriate fit for
> the nesting use cases?

The uAPI is to create an iommu_domain that holds a CD Table Top
located in user memory, it cannot deviate from this. These kinds of
iommu_domain's can only be pointed at by STEs.

Again it doesnt really "hold" the STE, but we can compute a STE that
points to the SD Table that it does hold.

Other than this, it is good to take this project on, getting PASID
support aligned with the new API is something that needs to be done
here!

Thanks,
Jason
