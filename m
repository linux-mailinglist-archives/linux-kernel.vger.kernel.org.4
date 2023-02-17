Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6683A69AFBE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjBQPsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjBQPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:47:57 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85D8EF9A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:47:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxBMVtiGfYqv5qud43oxCDkWFlGcnPtw2aY+hOStxHHMy+2nQroWIIyQMP0OlLsRPrznfSnU9UHKColwZUO08OTeK/Rbp/PwNY+hBksxoGeE6OR+ujyfevkgDArXqomJqKVjm1Y5q7YnhKqYztCJ6rqoDAJJBQe/CUiP6pi+rYwkpe/ObsKyE0mBCGHbrGdI4GBuPOActblOremxtNy7TUb0Y+JMfCdOxpPc4buPP0UgcJMzClQ9m9pVJK78G3/sdXEL243Ivoq3VEh7PlPrt4+aRZlzF1AgS5ZQ1ZRzE7AIk8FPEQagLqZeHQxPV4AidZL3gJeBlBoTZ9Hc5Jp10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzHPCbvH1osKi37Dqy/Jivh71ATbvZBZ6a/GdOAcHEU=;
 b=XpsMHgqdgN44jDoRV1OuACqOtYjk8NRgTFN4JAFmb4iG0XtJdLGpLZlxIIqZF2YASdrWah/JJTHL7wGh/+yBha6opWkmVRe8KXwUX9sp8VXLD9x9d687O5VC46TlyJJng6fxy1K7MZKqymlEGZy8+wx9kEuVPs0eqhXMqK0rFwGjjy6hBlMI34EHuLz5OXmqgC0OMIlbEJYAksHRzGF8WJtokCp/CJYXms4k+OVCw8cdemz4UW9Sm4Lt1gb3FAVHmL9/tHWBywTOm8HJbYQekGQ6zdwTht6jOGozWXnq3eFwQzcz2V5jr/vc52ouxzuKFqZlmGpPGb5BxxAs7YLwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzHPCbvH1osKi37Dqy/Jivh71ATbvZBZ6a/GdOAcHEU=;
 b=CuJs11mf6C4NZ1AUZAVk+TbdDzLYAozwpywaeO8mFSAAxBtcys4w6Am8QG/Wh9lGD0FnCvfwHsn6JrUWtiv3AGBlkVA1yxwJ9ytGh/4tZXltVkkEKYwB6Fgojqe/FNp4HojfogAkIaOir/aeFjhLyfwbdILnkAVmk6YOPqgwmCBUCkZJve/sLRamR+5JKxM4VUPwNfoQPXaCFF2r7gKyHIDeVeFsc21dKWhkzmub6kRrAdDSETvmOJaBZVUEpjV5NxO7H7qazi3anYnwFBZkP2O/Hp6d537KTNOLGAM0dVIPj9EiLuL/9mbfOfwrcwNpZ9EZqL8ERGqDNZT8jbjkEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 15:47:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 15:47:53 +0000
Date:   Fri, 17 Feb 2023 11:47:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] iommu: Extend changing default domain to normal
 group
Message-ID: <Y++hqGY3qg7EKZLY@nvidia.com>
References: <20230217094736.159005-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217094736.159005-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:208:32d::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: da1b7af2-d271-4706-305d-08db10fe54e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /t8uJAY9hRbsvKfCoUGYQ6BG6xj6gP4RWwTQUW9m6o83HwoNYoA/NPa4HeQK5fKcXwpZpfuIhPC1QD/acGNVlBv0BcwDlZ2M7D6kX2IrZ3+a43Avl8JwbfX8l4MP5I1AJw1s5v9s8gqxXGpBXNhyqXNcRy8Sm6rH8suFKFSsU8P+8bPH/hNeyPqLX934sKQ1HsgCbLAig3/t3H5ZQIwGVA1YxJQHarsrN/sDF2SBcSPA4qrGFlykvkP5z8ThtY56ZMt6LfP1drfDE5JCxdf5KMsDuaCewrRiNZcyuNpnCwbRUR2zmPL7IxLMF8c54mgxxkzc38/q6N8H5ZiYVrryk9VO0BouWd571PSp8oi0MNQ7W6h4wcN1oEvA5YZMqh61jMunf+gz+mUJKUXCzoKXA0ef+86y/sGzk76THm1Ra2l6UP+erOpJ2MdCRYBncbmkTM2Rk0XCbQpnCDK9nijLiQ/owbzRCkM9Ao7AFDHOhLMTUnz5ykxGgINXHv2qbuKK67nvcaplUwV+s2Zx23PMmFJXb2fDTcMjg0Pk7tCb/3yXln8jhObxRNwz5OERHd8dubn7/xlcckOfyOWvSJzzDgoe7B5C8aLyzu2rAimQxkuRVVsgL6B4O+HyNtmTSmWy/FQJMjmUFhJ1q1dRjjntF5BxHnNeINWVLCVw3O459WaGH56VcB9G128+m/TX8CmcbuKCEzX0ZWqpRiQhl1UqjwqQcRdp8TsGYBkywFuxO4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199018)(478600001)(6486002)(966005)(26005)(6512007)(186003)(316002)(54906003)(83380400001)(2616005)(6506007)(8676002)(66556008)(4326008)(66476007)(66946007)(6916009)(41300700001)(5660300002)(38100700002)(8936002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ifysIwscIfshoqhElon2dmRP8CuWzSAIAk6OQ4QDSXsAYthncIpWej/t5Ald?=
 =?us-ascii?Q?mO29ivVLJnvGluT12Mgj6T3sW41dONrYVmYvT8e45Q3rQVWSDw4WWVpwON3A?=
 =?us-ascii?Q?knhqgeIFoFVcKslXMzo0gxqpynJ89gMLGDDWewgEAcfnCiZoFTCLIaU+Y0Ww?=
 =?us-ascii?Q?ISpaIhYYHTFhF2csdjPOE38cAE1sQGYjg3jFjHLM+l9lnrTLH9HLcxPnU3gQ?=
 =?us-ascii?Q?FUeWqtkmfLpSBfuSC9X40Bgcp/sqO56QDnX/fcQ2Oz7p79fbrHtfva2bCuit?=
 =?us-ascii?Q?SUMXy8Iotap6mAWzB4O1hXNOCm4z1Q3uXBIqf5tu951Ica9lRv3nUdxsdPdW?=
 =?us-ascii?Q?x7gi5JKuFOoAQGm6evH/mL64MU0y6EhhFbcn80TErieOCd/VzRjF9dBWrufj?=
 =?us-ascii?Q?nmKNdUC75GJqMx1/9CKvjCJaNaKTJP2fFoTPAQfJ2KVJd7Mtud4/7pXK9sem?=
 =?us-ascii?Q?4A47ypkALgZKbfcVjoUC4h9SdyqwbDKTQx74+eqSOD57nEvWlhhEXSM8FGu3?=
 =?us-ascii?Q?aW9opQYQnvgfGXdrGHuJkviXxGoU9a84+uHwhPoakkyQnxVChYrkxW3Vz5a9?=
 =?us-ascii?Q?KgTifVmbOfwh8NpQs5sBsg6H5LAD9Uq0QWzlwITYHnfDXSh3DhqI5jXjT/tI?=
 =?us-ascii?Q?AqEKBrUK5Nx8SmpAwN8T3scOZW7C+cf2RkKUtsAC6gf9srcUVGGagBODr6NP?=
 =?us-ascii?Q?eWJs1yasZE4blBz7u/v38J8lWyQsGrEtOGl1ZtoFcsAJuBxWkj5Qb5+L2wk8?=
 =?us-ascii?Q?QdjjwmM2XsXkkwt+dE2oWKaFVJu0o7+oMGkvXk+oAkoywZUughaFe06/KfVZ?=
 =?us-ascii?Q?7FusYFI6NmdTvrpctIjjqzy6/lJEe/IHoBPfNbhtDJib7+1pkTAn8hOrXNNd?=
 =?us-ascii?Q?NJmKGujQ9CEMVXKKG+0o7/PKwVvm+p7WL/opIiZYxcPoCRNWAbZPLH9CI27r?=
 =?us-ascii?Q?j4LOruMLetOutFc/nb4NXTGpv7Z2c1V/wqVqifmE1uFtirRnkkejcAng8shw?=
 =?us-ascii?Q?+4bIR8bHSSbvUZ1fyGg3eUBRKctTtDrXe25XllzkU0ct5nqJZhh5jHL3+/uC?=
 =?us-ascii?Q?ALEnvYeTgYs1Moj5fZ1Ir8BzImZjjUkkQt+d5wP5CPKOMebgfYKUAZemXnTZ?=
 =?us-ascii?Q?CClAuU1hu3czz2HHBL4eVU3qg5Z3aI7FYtDx3/OUCnl//DCR9laI+z7EvNmz?=
 =?us-ascii?Q?OZw3tgjarh6C+oKfQm57MgUknNrPx9mGpdgQZxEfosW1DLsm64MmZ3Uge8xV?=
 =?us-ascii?Q?k9Gbp0wBoWr3ntkiSuZfSa0+O0mWcLUBScFck9Ltz//I3cC8QlCpYqgBoNM+?=
 =?us-ascii?Q?4p//FRG1Zvn+gVQWRg2xSDq/d1aIT5/UJUyL1cQ8m48ggpfiLP+xQChCO1BF?=
 =?us-ascii?Q?2VTw2H7PWC+ED8rfpMbe8FZFU8MLFWIxKZ0XjpkWyO7+M5JtqsiFUPjpKKP/?=
 =?us-ascii?Q?4wgAOwSQq1zN1S6jFd1yHBYUHrvTWrPK1i2ZfmJfkxKubmXbURr4n4JUub+4?=
 =?us-ascii?Q?vSeusdD3d9tNSSAjyQ/bSVYA+ZOaIMKa2Fv9SYnSlGj85MNBhl3xM76IMWwr?=
 =?us-ascii?Q?SLwDLT88qkG7GKP50DLhONVWc2hzxkYAkakse34K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1b7af2-d271-4706-305d-08db10fe54e1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 15:47:53.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3pk49j5qssp3m9D7PtILShpJ7XKIBvo4R5R34MfmD5EWGbVR8vBKcTI/3QA5h/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 05:47:30PM +0800, Lu Baolu wrote:
> The IOMMU group sysfs interface allows users to change the default
> domain of a group. The current implementation uses device_lock() to make
> sure that the devices in the group are not bound to any driver and won't
> be bound during the process of changing the default domain. In order to
> avoid a possible deadlock caused by lock order of device_lock and
> group->mutex, it limits the functionality to singleton groups only.
> 
> The recently implemented DMA ownership framework can be applied here to
> replace device_lock(). In addition, use group->mutex to ensure that the
> iommu ops of the devices is always valid during the process of changing
> default domain.
> 
> With above replacement and enhancement, the device_lock() could be
> removed and the singleton-group-only limitation could be removed.
> 
> The whole series is also available on github:
> https://github.com/LuBaolu/intel-iommu/commits/iommu-sysfs-default-domain-extension-v2
> 
> This series is on top of below series from Robin,
> https://lore.kernel.org/linux-iommu/cover.1674753627.git.robin.murphy@arm.com/
> 
> Please help to review and suggest.

Given the overall situation, I think my suggestion to use
arm_iommu_release_device() might be more short term practical.

Jason
