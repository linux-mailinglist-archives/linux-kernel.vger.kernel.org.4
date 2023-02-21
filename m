Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6950269D7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 02:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjBUBNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 20:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjBUBNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:13:16 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB92993DB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:13:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3ocy6YA3js+W9f4vR7DXXb7Rb4HvL5oqY+nlOcVsnxn5Y6avkbvRcSnWdTiCx96QoxofI8KVU8sbTQpugF7MsycMHcshlijQf0SUNlaHZnJqBApY6nVwOg5cELJ+2Qpg4sxZS7h9UUC5KdumRWvYIBdWIFggTIeT47QzpR7OOWLWdkTLkLbtBRJREUYzijiyP8BzJM4RMQ8tG3erf4EqZKIg9H2lkbx9a5ZQHc6/nZzQNHTQvt1vJNgg3y1Y+bLfURLob9JGeU2LC2TgNtU+WTwQZat3co10EQd4m0FwNws1kJWDofGAo6fXr1zTrfXs2RYksMWXXc91uS5kB6PjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6MJq3McgVP8I9pTozyzpLNE3cNs6pqUueqxl2xfESE=;
 b=eD/isWYAvkewsrh8SAGYbE9De9k7SxvL+PKsDG//O3IfvTc4PRdjPok2Kyg56T0SqNSbJrr2C5VoakKDu5WL5xiMqXh+XcDUkKrW6rK1zKazExQfUqmg2uWOq5dafFmh4iRUUotsstGgETg0LYoAoC0EH8gqFpbbHNHKr83L6oEWamQPU92warP/b60FbS8gAQ7qYET72KO+PV8Di4HZjETqPbWFO0U9oeFeprLlMXuCVfaQRtvx4j9ExsScoHvSLo7G64M79WLuCnO9YJlxYDMtwkOCdA2KiOfb2gD/HE6NnYo7DYq2y2jW0GdT5/0prObbFoNVZCXbe48WWWcFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6MJq3McgVP8I9pTozyzpLNE3cNs6pqUueqxl2xfESE=;
 b=rXKNFfvoDuIOA5sr6DeeRI6ZPE/0rKVocRPo3wFGBbGKUYdMKCjxGpb7S9YEc27fY9EgKcyQLmuYILFcXc5Rf3ZJB1nGsQF6q2p8f7xK/gAwTJv+jWu3dtN+cB1QAUC0YtTIQruuIFAxsykrJJtWGTFNT2ChhhyN7+pxGwmZQ+kT3QaV3LY3zzcWDkz3IMhrY7VEH8w6N78nz3eWUevx0phNcrcU4qXoak99kjY1l6pEL36i59Z9t4puP/1JYT5hBD+oICyfo7urJphiNDb6hyKrLiiwtOHRVQqCagUnMnwnvkgEkUWuF71/Eyqc2yI+wpH5GkTYtOW1f/pDyLUjzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 01:13:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6111.019; Tue, 21 Feb 2023
 01:13:08 +0000
Date:   Mon, 20 Feb 2023 21:13:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iommu: Same critical region for device release
 and removal
Message-ID: <Y/Qao5Yvam1YPXKi@nvidia.com>
References: <20230217094736.159005-1-baolu.lu@linux.intel.com>
 <20230217094736.159005-4-baolu.lu@linux.intel.com>
 <Y++f8UmMK4AvrwBF@nvidia.com>
 <71646179-0da1-8136-f60c-9b31f9c7da6d@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71646179-0da1-8136-f60c-9b31f9c7da6d@linux.intel.com>
X-ClientProxiedBy: MN2PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:208:239::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: a1035737-b67b-44ef-64c7-08db13a8caf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZILYSkKP1CBjWHLY1YdexEZfNIkAtZaDFyp0DjUR+aAsL8jzmvqOxCAKoMXUW3v0KhhijzgA6KAq2CXPbhaTHZuuVHLm+gg6F8udOf0KPPxCG/YAMAJ9PwAp2XTUVwPVMiYd5P0RWEpxAs/jYKJYr+vd7KmTXD0FndteG3tMPeWG32icd3TsxP/4J6dPmsHhvReVDoY5Z0/+r86Rsxyw75bh8Mbq126PnVxDExKuYbtyI+mNf9oEjhJJTp414X/b/2YxFBbXU+tunXZLXKRmfH74b/ZaPhP2k3gE7d0KjFlrlkPiuqsplgaKhHtVIH20iyLcfek9a/38+9zNicqzm3l01bVpirKp0a75spZC43aE/bk4OEBHQAgaNRkhSJha+jh5hF09DPUyw7tZMq83FbdPt7f6K84U4GAsdMtsgWLo7CyqK4TszE3wckYnPXGDPTZCLEfjCsCEigmJsd/4nxmsSeiyJpZEYxMN/k507teFVw+JsGWqIIlmjkfMMIPANbqO/sbGw2yQAJrsiPYHKPmQoufU+v8T3u2j1VHxUXc30qROdyWRngOzoBHm1VkDbSHkKrcioQEHCrTIZ54VYoN+HXGprgZY74XsTAJX3VF5tSrDU+XJoIJGgIw+OBAeijUqv7furlFcoLIcDCaUVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199018)(38100700002)(2906002)(8936002)(5660300002)(6512007)(26005)(54906003)(186003)(83380400001)(41300700001)(2616005)(36756003)(8676002)(6916009)(66556008)(66946007)(4326008)(66476007)(6486002)(86362001)(6506007)(478600001)(316002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?30jvQAa84SCPxJKsFpp76tMnJ86IYEsW8jERqnErxVkX1B9N1EnhL0UzkgUe?=
 =?us-ascii?Q?dGM7H/pbkjDVXCFUKjZMoow/vjYtx7Efd7zaMIxQjlcoqgycip48IWOfBZz0?=
 =?us-ascii?Q?O0joYtvu4y4ANGYg5bOFHVpiQaXSNxElB9fP17PBZJIhxRkIEP/f3EC2VbHD?=
 =?us-ascii?Q?TcN1Hl1JIJQfDfNamZzI4n9RhRR2k79+7fj8c8b5zOnsY5MYCbUHGM8WCID8?=
 =?us-ascii?Q?jf8zvlVHKDW5JANA10uAu4xc2e+9G+hiYQSui9ghSewZP5TCNXzQ8f7oay+7?=
 =?us-ascii?Q?LjjDxgB9kVoZX2Kxo/hoMnTmEgAYx77xKBl+gSyu/U8gnVfecxqFcdQsXtf/?=
 =?us-ascii?Q?ChB3OIk57qxutnYMvr1Xnsw/u5mmTSW8HypAr8+zKONXhifj7bX7zOdLB/0u?=
 =?us-ascii?Q?hIpv/YBz5hbIum0oUzFC7WsNq3gE5TnRylpcAUxI/SSjs+A/d5LI+J5mUURs?=
 =?us-ascii?Q?wxjqMasEchiEOkymnLPagJfp6hqydW5efOuiFGb1n0CaARWidIRE/owop4FJ?=
 =?us-ascii?Q?Og3xuqVJmrJbnTODRKvXlZ2EveIWV1zfxbWp9vcLZ6L7tXraluCR4NAhWCk9?=
 =?us-ascii?Q?RI89tn28bi34LzbqlzmSR2hOY+zp6oyfCctQtlZf08Tsu7tJ179kPDSAVNmH?=
 =?us-ascii?Q?U9gr7kqgeF3Uk2P2AMKECsI99nvOAIdMTBYn8yZQtwjPSefs3GUsSWGP4TFr?=
 =?us-ascii?Q?jco6b2JaBNOHrsfOX3VMbdh4L5y+VsHAw438OIRt8lkhFtBZrjeg610xNjZr?=
 =?us-ascii?Q?R7C8NGncpMQlE5PWZfCUwyCGp/qiki3sikuvTeh+JXnpKt5vau9JzIC79YcO?=
 =?us-ascii?Q?qGtk/UtFkEESCF/D6Gna0bgrEYbxYmpHEQPtTYJAoOWRGAah3yB9Pjdrs0nn?=
 =?us-ascii?Q?OSt7QSN5IgyZMVcBunTIcG5Z5+i4NL7YOebcTaUVhW8QmEDUMWP9USmGhhhw?=
 =?us-ascii?Q?ffic45L976QCGBx7HSodftWJsfYoDXI/rHCetshk6VL50j30a39xh1skWaya?=
 =?us-ascii?Q?ub0kxhUOpzMNgd1cMx7juzpDPCGddlzkOvdNL4ZS/Nu7SroahM0fPYX9a/l8?=
 =?us-ascii?Q?CI7xxE+mg/+d9xdn2CJB1LVnFVHAC5aG7Zi3OacH3uplVFbg7F8aOw4PULMK?=
 =?us-ascii?Q?DSMKBpNjTa2X/yRW3yp4nH9ppNW8f3Ds/G9vZ1VgS78hls9FogmcUqV/9uOf?=
 =?us-ascii?Q?85beuukwas8B/gweVD3vFS1agzNNkBfhxW6DCR2Nj+vu7e+e97sSSZ+JrqP0?=
 =?us-ascii?Q?Ekgsc95Zyd6cZmlHsVB0ewqHMAouhi1qhi85ZpyDnD6TVHn3FNsICALiIMOM?=
 =?us-ascii?Q?cY2w8FpPH3+YCjPIIALfeqzQZcmI/hoMR3V5rfqdmTEH69NfdFUEbcXUIX+j?=
 =?us-ascii?Q?P7QlGkSHSlU62/hDwoNVXAF3pS7+Y8f9lUp/OJe2SFeOIgBc7eHBZcChOiXS?=
 =?us-ascii?Q?zKdRN7xUApYINnxYVCsS5M+frIfsL9IDguKYwO8pPl1GkXphdzP6DV83suLI?=
 =?us-ascii?Q?7/9aT9bC5ujx6eDWXEDrVaRsga7+DDo5ECBQwCFtG4FrVJUxK1JWNNlcnPHL?=
 =?us-ascii?Q?lWwG71+tYoUPsWfymiyp+RxnLeL6SgCggG03TtIw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1035737-b67b-44ef-64c7-08db13a8caf0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 01:13:08.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DOIyWiD2DxLpKLpD/eth0IrX1Hm5vKq+tvLOPtHMIkiFWWoXF4anbtq6XHRKoIL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 03:29:12PM +0800, Baolu Lu wrote:
> On 2/17/23 11:40 PM, Jason Gunthorpe wrote:
> > On Fri, Feb 17, 2023 at 05:47:33PM +0800, Lu Baolu wrote:
> > > In a non-driver context, it is crucial to ensure the consistency of a
> > > device's iommu ops. Otherwise, it may result in a situation where a
> > > device is released but it's iommu ops are still used.
> > > 
> > > Put the ops->release_device and __iommu_group_remove_device() in a some
> > > group->mutext critical region, so that, as long as group->mutex is held
> > > and the device is in its group's device list, its iommu ops are always
> > > consistent.
> > > 
> > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > ---
> > >   drivers/iommu/iommu.c | 15 +++++++++++++--
> > >   1 file changed, 13 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 6247883991e2..093692308b80 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -101,6 +101,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
> > >   static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> > >   static ssize_t iommu_group_store_type(struct iommu_group *group,
> > >   				      const char *buf, size_t count);
> > > +static struct group_device *
> > > +__iommu_group_remove_device(struct iommu_group *group, struct device *dev);
> > > +static void __iommu_group_release_device(struct iommu_group *group,
> > > +					 struct group_device *grp_dev);
> > Seems like a hunk is missing from this patch?
> 
> Did you mean below block of change? If so, I will add it in the next
> version.

I  mean this changed the protoype but I didn't see a change in the
actual funtion?

> By the way, can I add you signed-off-by when I use the code you posted
> in the discussion thread?

Yes

Jason
