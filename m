Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAE374F0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjGKNyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGKNyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:54:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B778BBC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/wF36jzXvpk2IDxg9JPEyKFLZt3q/oFUWkNqx1l8oFhZ4BTPbiGy9VVcPgKsaVTZafBxCP8HC5Bge2K1eFcj2GWrxXTq+GzikPZzuUB9gNaXn0GO+Cp+hrMZ75MN8+eag131Smqoi6hTWBYqtrmmpc/lhnTBkotEFtP98MTWx3L4BgpWn0HrK3b7I4NY2yhplo/5k+ALGbJo89H06pDLwnMXCxSSmUIr93A4+j3ZGRPTwj7W+or7edDZQhhm5QiyiePe3QqLuybDlk7FY8z1g8331lHrTAGiDNfNZgALNWRHC/MavgWYcyaMm6xJWZ+0dz3Hy9BGYQTpJ2mIq8JcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iJxDcQdGxA5wBQulnfCsiVXVjoHU0XeMw/1lyau40s=;
 b=R9AfY/m65Ih8uD4wQ2rBR2dM0hFFYENMkBoDIXAmi6/7E0P2OhGmXDlDhpIQ9Kmqid8f2tUgs4qvjQvMPfW0Zlsukaw2miSDodQAo8CHQPny3HmYQXET+KSd6np/p5dNqALVORCJNrp341hEskfVGsnV55deTTGaq6eQ3NCq/SVXMsbkVjp3JwlfWY6YSYiOfm9nP7V2Ce/neUTmS/bnwSjadhmMTYtGINb+QgJSo7MO7o7W2TykJyC9QP0ZIL80yawClujhiitwomyGNccfrdoi/e2iv5uEIo/4BnimfAP+NJcNfF4A9WYvaew1slcxGlm9oETVzN7ZZT4wasQRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iJxDcQdGxA5wBQulnfCsiVXVjoHU0XeMw/1lyau40s=;
 b=tRcNHTWlgr+PIrxd8B349YmB0Z455SLZIEEj9qarCe/v4c0t81qnS6E/bfe55BjnXec3/GGV5+kesurJgaF7CrE9h/0LV7KiL+aTl2zAY9KPaxuP7XiC6Z57Z5MMo54dqpi3wGfsXxpcVwerM9P2bGDvCh0rpDeVh3erlaOya9Jzw+Os44EEZ/utSq0hXghvSELFStPyWQiHP2mNOpUqmGYW/XKvlAPVP8ovK9P8PSaeUtXlwZAQ6ReDWbWVo70GLNWWJ++wEpzJqxD4OgXI27skmC90T9sZj5hy+yztEFByFIcYhzMUrxKY8w7HydJcGqNDwDYR7MGnD4ykcQ9JjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 13:53:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 13:53:57 +0000
Date:   Tue, 11 Jul 2023 10:53:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Zhang, Tina" <tina.zhang@intel.com>
Cc:     Michael Shavit <mshavit@google.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Message-ID: <ZK1e8Rbg3MiB/e+P@nvidia.com>
References: <20230606120854.4170244-1-mshavit@google.com>
 <20230606120854.4170244-15-mshavit@google.com>
 <ZH9oQMmI8CezMCnx@nvidia.com>
 <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com>
 <MW5PR11MB588179952AEDB50D9259549C892FA@MW5PR11MB5881.namprd11.prod.outlook.com>
 <ZKw38RrJ0FG8zbqt@nvidia.com>
 <MW5PR11MB58818828160F5AA41756D45A8931A@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB58818828160F5AA41756D45A8931A@MW5PR11MB5881.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: a0167975-bd24-40c1-519e-08db8216457f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zB6xkr8Y40OU8h80L2iH5bkyipuAwOWE2nNjZpPCqL3dnxmlvaTXsPEl0V2xW/is9rtimoggV29K0ECEea6hzm2ZA2fgZIFOYUbzDVW9zd7Z/nwOa4if3Uk2diFoc8w8FgT6yg5NkqGzC64QChd7qoviiXmscT/rbaq9iQdJPBnGjkreCgKiR3u8erHHjw61Foi/X/2kEjOUjEBPUDMXZXTIIp/knneV9mIQGc6PtI93NCD27unw/5C2HvLFPwMDTMCdpHi7AsecUttc/kqCrB27rrRdRF98A9Qv7tGE0OnuAl/Oa5y3W/niqNCV5SBNCFiysMlZS7NZgHPtA9yLZPXaxqcvPfHC50/dU2MQp6HeznOhWRHbYrjJQHtJyHxFUq9dOqbBf2lRcPUrvkkFsKMgxY7pcn8jFdqWL9dORUj2CaFY8ow+V9ZBNWiCPQ9uLtYu63ha8C7ZURZjZOhkjmcF6R+TNg6tl5DR7F1o72PEBqqUCWzoTumNX1Iv0+ziGBY/SzCKDDy0Z6Ptvldg4NTqZk8L13VHEZvdChk+JDSlHdpFXGNy0m8Th3Hh6a0q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(38100700002)(86362001)(36756003)(6666004)(6486002)(54906003)(26005)(186003)(6506007)(6512007)(478600001)(2616005)(2906002)(316002)(7416002)(66556008)(5660300002)(6916009)(66946007)(66476007)(8936002)(8676002)(83380400001)(4744005)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IW2RfSB8uNtnj4dl2cSsBazoUVRhEnJNi9sRIhZtZp3lswwnfFidzncflzld?=
 =?us-ascii?Q?k+3kZX4ZutZthF4/XOmnGBLXoHqyeGX8kQy+FDZQTEovDxiUWdxnpTadIhHY?=
 =?us-ascii?Q?l4tWUfsKSaxZaAp+POQOBfcqvLwV78J9UIVN9tMqKMOiserfsP92rP7VzLC8?=
 =?us-ascii?Q?//FVKnFZXVm2SjOW5FgIOuzQfV4mKMaR3IUZiBSevKr0YAB7IrGYriE6rrS8?=
 =?us-ascii?Q?diGVWjPJGgEGOjJEIHn8osogqXlGl5ztPYKEoQ/G3xYRd1sr5zigNJD4zso6?=
 =?us-ascii?Q?Kj84+yaL0ZUQsh0gLA6wMukkX7sjnV099tenv+UwQrWeMYwz60ajvTsyDCV4?=
 =?us-ascii?Q?kB8IJJUOWdWDghwKgnJK2fO/Roa+aWjutoZBUzRR6EZwlV6bjUFufhM6vOcF?=
 =?us-ascii?Q?ABsLSv+Mzc8K2CUHVadHuoMA802Gb/YEA8DARY1BlLqC0e3P4YpPLgkmOC4s?=
 =?us-ascii?Q?oHNggIXbe3UK5fhVvd+8/rPwH2O1fPxOe9PRlocWXWQWUQDBdiu43d7L7kyS?=
 =?us-ascii?Q?Oaf3mIonJnc5behRNkqA5LKDmcgyDQKVRmIwCm5EyWVo0/+2iUcxDhgP+Xuw?=
 =?us-ascii?Q?OCeY8dA5n1PQHBAhj3kSbNURztEXNRfBNULO28CB1nGP8aEDEjTWLAqlBuLD?=
 =?us-ascii?Q?yfwCXxx2f0/6T4uzJ8RsIMKRSRapXQNmvfinnPfoUUxmaTqWhRmAkYUixL2v?=
 =?us-ascii?Q?zFLUwP2w8ZfIK1Jbkv/RLM4FrDUyF/AK4iWucEJk7H6ePL0jLoMsrdiKb7vZ?=
 =?us-ascii?Q?XFKqOpoj2r6ApPOMgSuKtkWvEsJLKxPkA5ouRGIxdTZHQXC0+o/xTWS7a58a?=
 =?us-ascii?Q?kNKdaEVJYOWPg2GGnLtuozAMPPxNrQfecGHcf0m1UUMwxjjDr/W7XnEUohyP?=
 =?us-ascii?Q?oFt0otV9OafbsUMX2ZAa3YxiBDlZe1FPfwYWgMEDnjyyzy1+lS8Mv9ohOjQ2?=
 =?us-ascii?Q?79wFaEUK9TyRf+qBK8uJQK25jgeF/xgJLGs1Q87HtKh10ipn46Y/PMhAaPE2?=
 =?us-ascii?Q?kt4pBZmqVxGrGD+adnMZePMpcTJq/Gzyt0bTQaD29x9xyzmNI3l8TcT48Lol?=
 =?us-ascii?Q?Dz8m6GXn9QZNjhYNWxfQ2NLEc0dxy/kPQUveT3qNTl6y2D94VyQScoevZAv6?=
 =?us-ascii?Q?HA/wEyyHvqKNkHDpOqNqKFzeheGlwc8FDFuXKb2fLUPIDXKygIpONOnClbvL?=
 =?us-ascii?Q?hqOhwzG8MybOB4RJMAyNp9u/esMfWWFiSr3V3QgI7nVxxMhQkrMEcLsWqgeb?=
 =?us-ascii?Q?bdO5kC7ycfdJP3+WkdhN5psclvEyar34lokdk2jINfP1s+/+UgM7E/uX7tEC?=
 =?us-ascii?Q?cPVuuzwK8ZOrtq9qOtqFFpVNjwip8FkdE4muiFtRwNmOOsbqE/NU6FCAsd3B?=
 =?us-ascii?Q?Z4NDX3J3u1SFDnr0VhP8GB1V8FHMtw1LjujsHl1l+jmUEPpAahelg2ZCmUVP?=
 =?us-ascii?Q?OxM/wOn9enyrGRy7QdZeFBJ84+8UVGo+5wfObjdzATZbZNwUG5sknkMkBQBM?=
 =?us-ascii?Q?wER8kBVaQA71yC8RNdbSRlUW/++myv4FcBTNDJFN/Cr/9sLbasxXRad/fWM8?=
 =?us-ascii?Q?t6Tqzoobiv7Faj5TuEMoKeviXLh7WxYSEhV2OFfZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0167975-bd24-40c1-519e-08db8216457f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 13:53:57.5641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VnXAWSrmVJWbsaQeAKA4+qLSTbt68FiCM8tOaZzc0zcQ7C6bdpowc4mXVCF+L7W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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

On Tue, Jul 11, 2023 at 12:26:56AM +0000, Zhang, Tina wrote:

> The motivation is mainly to for performance optimization for vIOMMU,
> though it could also benefit native world.
> 
> Currently, in invalidate_range() callback implemented by VT-d
> driver, due to lacking sva_domain knowledge (i.e.,
> intel_invalidate_range() doesn't know which IOMMUs' IOTLB should be
> invalidated), intel_invalidate_range() just performs IOMMU IOTLB per
> device and that leads to superfluous IOTLB invalidations. 

You get the sva_domain from container_of on the notifier

The sva_domain has a list of all the devices and iommu's that it is
connected to

The driver optimizes the invalidations based on the list.

The core code de-duplicates the sva domain so there is usually only
one.

If someone creates two SVA domains then the driver is less optimal, oh
well.

The driver should not look inside the mm_struct and certainly should
never try to get a "SVA domain" from it.

Jason
