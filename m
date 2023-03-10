Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5C16B33A5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCJBaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCJBan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:30:43 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B39DF6C67
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:30:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBwrI8PypnoeMNBv637kiYjgu6bj+0d5zvP1/cb1YZ/Riva+6cDnFrrV3gxoO4AN6DMfLjlVaWhjaE0pCNDz7tZuRydkI83HVG7ZNg2ajoHPRV//PrUpFaz1qJi0jJZuFB19lyKXjumvOYlH7z6Du8PRT4O9WG3iDZlQkDyalUsoWl7DMAwplgxFAvCmSe2gZ8mLoAxN88adSgOtt3P9pgGapbimMmj56C/cstbFtjaDO6TDHcqFUMKyItsGQf7AeMB+oCjj1F9zphjlobssFY3l7xIUReNo4jJG9iO7i+Fkp7Ygj5BRZYMYCBFqK2DKd92DxsxDYOrFMjy79m4Qcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHfmjZbXijao6JxjRBtJuj/x2Nr2xKaQUE7PbQDFmZo=;
 b=REWBqUlvtNrGQgMtwlFjDqNNBreS0BeY3eqvyC4RtN8ftC8T08qFR7bNbx7AEovCt9Il9OdbRNPp8VvnlXkVLXkzgm3wXGy9KEXpCv9cN35+R0cVTTRzhwRjdpox3q1ka8cyrni0BX4lGA/NO2eo9rZxVAb7xJ4Mc4SlUzeWDOprug/+d+OxNt3ojhfE3DsrGSrnfplfwMIs///SnDVDaUrmh6MdaXMNl02iRRxbiSY8D5+IEgFLOHKrh/QeZI5JPxgSDKfjHJDVE/tLnWOn9lS0WWEJNBXbYzDUK+W/aUrHQoZ5JSUjiiGNDJ+tn75GZw/WGmgHfC6Yyzik98w+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHfmjZbXijao6JxjRBtJuj/x2Nr2xKaQUE7PbQDFmZo=;
 b=s8/YMPCpYIZ7RlLrQBMcm9A2MfznhppIAg2J99v+5garIJd4o/vvF3kF5tqVtK/c/495YPwurW/7K7sHgIXnBfqrLXPO5ESUm5nSVfKceV/9d6BcY1ur2R7XV3d0JicwNQ2CYg7sQyPYhzZOm7lwf+2YLsQhjy7Kkh6EISxlJwHt/IKEvBqTE03qrDCojRBcmMGvdl+pRPcRcf9zhKcUN2tkgQT2t/2k0iZ/4vqP5hSzkARrri/FbHH+posUHECDvRpJrJokK51kpKqjv8X4yO1/LyqIOJL56IZ2TGij8b5cuQ5BJqols2+ZSx5smgsWl0qxMOcD4uLkGQP6HX91aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 01:30:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 01:30:39 +0000
Date:   Thu, 9 Mar 2023 21:30:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iommu: Cleanup iommu_change_dev_def_domain()
Message-ID: <ZAqIPCF2oShJKIiE@nvidia.com>
References: <20230306025804.13912-1-baolu.lu@linux.intel.com>
 <20230306025804.13912-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306025804.13912-7-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9c363a-c905-4aa6-5dd1-08db21070e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozBLnObi7/LZbiC28JCVa/3eR4W9L5p4Dln+eKoZa/TrpzvijF1klM8aDECE/iOuWeSoKYKysypL9AAJw1XzjUMuxhIr6qlXOjFbBUD1TLMz8p1JFFClFz0KzYu2+eKjtHegRHozFZE9lbVxTAPDFUMvu/frHRRocPvcbyLKWbx5QHkioit1ciTOUrLLAZQFOqaCwl9qRUPEuTa5SLrttXJ/736dEYO+gARwoAtGxPUcMf/dwY/wqT+RX4/nwGEFVktIBX8B2jxflqBsShxPRzNcU5UflCS8Wnmhnf4CPiKxBWlZyE754oXIl5JnTjT2dyTa6L87ztdNKW1jhmrTGFc2ksespL/oPX0A+DLIncvOrumuwOE2Hoh+muKkIzKPMYgmXeLxut0/FrJFyicNnB2s39GMT8OX0wixPQlFghWDvCs6arzetGeM8FEeuPCCtgq2sd4t75fMmcwENdVtN9m0nt/ecWMI6zp1qgcHDrBI6xia9ahVZsZn8pZROWi7UOStOGyZEjS+JmszjLYQDjuOCZEFwxsiXlJAjk22uMk6KJK5xG5UHaIjbGnmSiL9r6poc6XAkEKEOt1AImWNbCcuA+NBkAg4aGswi1pSVULsl58Ep5JtJ67GJkE6sMaboGOnNpTzNA7E9P4nMb4fJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199018)(38100700002)(36756003)(54906003)(478600001)(6486002)(5660300002)(41300700001)(316002)(2906002)(8936002)(66556008)(66946007)(66476007)(8676002)(4744005)(4326008)(6916009)(26005)(86362001)(6666004)(186003)(2616005)(6512007)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZHvLFGnukA2eKbdwAsm2tiyPhC6UI2jocxHyriitGtoYiOhQOMxrCesDvDvd?=
 =?us-ascii?Q?equPM6yOt6D6G3dGH1vcSPAS9srgbktGszbUk6JuJ6BaAfarjtZpX345Jzoa?=
 =?us-ascii?Q?LK8yxVaoY/t++q3qoyS7Ti8AyvonkJ6PfkuYW84+5Q8qC+mls7RawvXwjBID?=
 =?us-ascii?Q?R+tVpViP+36wLwjaPM3bKr6Ewmd8o6G/A+yYgA4PNLZmtNwRc1MbZLiA4nyn?=
 =?us-ascii?Q?usmW7H9V+90wNP1SNB2bZRLMAhdxo30NXXnCXyor7JTAePiK7zXH/6l1EDdE?=
 =?us-ascii?Q?gqoHvvCiGw+qnOkGn37kT9yzhZUyJsFhvb7m3JFTRjPo+xkgfxrwPpqZ6YAy?=
 =?us-ascii?Q?8pqJ6iZd35wjUc6q8m21AHBUb4SpXofqnb/2JfOPGjXkNeOgBQUvqJR+2fJF?=
 =?us-ascii?Q?xhasRPKam+nGM7SM1zjpz58HIU2scOHGZccXsbw1V5J/a1UPbOvtWC5Bv0KN?=
 =?us-ascii?Q?1Aqm/6naeiOtwbljxbHEaUuiuSOsFVyleBnhezONJxw4mdeNrA7PlA5IXdc0?=
 =?us-ascii?Q?6IK5gKQAWdZIHWQgRAv2HQ1PqRBYDbblh5YgJzG64ZqCgQlvlBWGQYVX3Vnd?=
 =?us-ascii?Q?NR3CIIygKs6fTFPXyasJicPZQ4jKqfoiB7ZYpHzr8p6k2nGOlXNL7+qGzHF4?=
 =?us-ascii?Q?c4B35gAC8FLTiG5Th7v62IWgynvCqyCd0K9h35YyfgtUYN7lu4KAude7Jcgy?=
 =?us-ascii?Q?qo/bUi7UDpCdFizpna1tjpNB5mvMnH0jOqOR6vFp6ayMbHOW2eMbQop2zIF8?=
 =?us-ascii?Q?8iZwqxJCEGYxUGpNLgD72Yp65AJK1Q7e4Dc7KsgfU4plzZv66rt3tUEbxI8d?=
 =?us-ascii?Q?+nrGER1pA09DDQS3S9Tqj0/Pz3WzzBPv+m97ThMXmtKl8/7IQDZxcGXHna++?=
 =?us-ascii?Q?61maX6z08LujI6LSpn/7tlMOuPt/6EnXfkcIgFAI7vJ9ZDgUH5kUQtktm1sz?=
 =?us-ascii?Q?Wemb3/q8C+E2mvwj3ot4PPBIoeig+8CvbwrcvY5/N3J9i69gJyn/BpIar9FL?=
 =?us-ascii?Q?vELuhs6+f/xlehQu0g3RvuL+De7kSEj5WaSA+V83f9VUpH0+kGJqW8hF4KAj?=
 =?us-ascii?Q?LdffizhVVtYCiXf9D7CjtibbXIoJCe8r1bjN6JzOACXQsoqf2pcoxW8i1g1u?=
 =?us-ascii?Q?Hd23dUKjyHcu0KM5sEeccXw+AOL3S2pn6IYA08U3H4+zss0X68KranFrlbmB?=
 =?us-ascii?Q?s8/D0WHLSRVPRVn6tTeYVbs//v+NUTEGmO4AwJMZX1JXhmUrdWZE64SJIeJH?=
 =?us-ascii?Q?c+pRwgPqC3ZTbZ722Kyx48XWE7k5aaoErREATiNa66Td9ygBkh3yTlXp4kzv?=
 =?us-ascii?Q?fM5DdypuDj1wGygLLs45lJGTeY5xxEVOEC2GkhoAJ6GcjpIbEolR8t4+YDp7?=
 =?us-ascii?Q?VWeaiJ+lYC6T4nBQv/MVS/COexw3ug3RZldHmq+aj88CZ2kPb2smiO2W6Gc3?=
 =?us-ascii?Q?2WbdzMyjelBLgPZZ39MEOTpwJ18MfSQuz5bEdgynBntduboUC1+eCvdoQ1Ag?=
 =?us-ascii?Q?iBNkTYcCkt3nyIW4Ips2rjJWFU0qax7mPqPcsKD6tLepKWuVSvg3j6mhPU3H?=
 =?us-ascii?Q?+1ATjwIKeWMz2NhjvFLbOl1HrpsE9nNhHQ8XZ5EJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9c363a-c905-4aa6-5dd1-08db21070e52
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 01:30:39.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pGibzg0R7mt3jXBNXRi8wy13Ca7DgGlo/VHXhgTS7al2O3CCa9Ap0gj7wn4XiM8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 10:58:04AM +0800, Lu Baolu wrote:
> As the singleton group limitation has been removed, cleanup the code
> in iommu_change_dev_def_domain() accordingly.
> 
> Documentation is also updated.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c                         | 81 +++++--------------
>  .../ABI/testing/sysfs-kernel-iommu_groups     |  1 -
>  2 files changed, 21 insertions(+), 61 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I am going to post a series that conflicts with this, but it can go
after this one

Thanks for doing this, it looks great

Jason
