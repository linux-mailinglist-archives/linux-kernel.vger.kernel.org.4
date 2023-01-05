Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A7265F52D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjAEUZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjAEUZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:25:52 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F80F15F24;
        Thu,  5 Jan 2023 12:25:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6Ajz1JbGOi8ttVzjaZAGefGKyWIZt0gcaCR6kO+k8YkF2hDeDfQbCV/daSRPW3BdnmnDy5eTGhs0ft6NvXRy5F3q5dMZpz/043IR3Z8Shg619czPtQdvFyqw9evcCsNk4ycxHxPxA4OFjQOYDJ1UWblngmuFdvPxbYDQw8S8Q5ANPV76oXiSpDDpotTOqxypVeCkJXpKW95EqZLcKEfYdNmzsPaLsLcs6eiUBYW7c9rsbEul6jUlpA304FTIAl+f/3MRVcbPz7VGqwVRodvpojo7wB6gJNZxQpo4gOuo6J0sOfyf4GHF4eWv2aYJdnMD2hkew88dKDbuWZfjRHZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=706I8s8ymPJmB1LjWd5YnsxEYFLwL1h6V+UbCNHhDqU=;
 b=jKQAp+Vv4OSA5iHhKUjL13G3TV+sS26ZkbklreDJNTQrm1v4uqjoDvOmLUnXbg8vbT3vqNBr29sxOFk1bOI+IhkeYVNY3yi6BP1nVZGUcdmWh/3E2DzVLWO70idgG7WH7BKY+nPewKM3oq6YOo30AcdnOBM24T5DSRAJ17Ypk6XBurLdTIGXN5cKpRRuoLi2Sdb6HMF007xeC6in/P2e/95mMgOogeqpd7N/sx+5sC+TyFKxAamm8AyrPuQfJGcghzeE3apxqBBCAuS3Re9hT1Tv1wCvXkJ9uA4CGMnYWsnTWIb8e4WNvhdUSTXwO/LP2XK1ngVgsx6y692lQzu7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=706I8s8ymPJmB1LjWd5YnsxEYFLwL1h6V+UbCNHhDqU=;
 b=aWaGQBJDeVqC8TAY17bd/D/s07O0BWhJcVvfZ6vuD4lDv/K6aiylQqQs3Ytymr785Uf15eEgT/BfroHhE+uHLWnnZFYgj2w6dJX8FS7aH3xjUj0ir6ZsCkw8tm9Y/Y1BblSlV274KYOQJ0uDfkK8zcnkr+ddNtusS2hGL1DjUdgcoqY+HOS2kQEaZB2xmg0OZ6rEB7Imc0JjJrEXNLUKSUwQ/fn3SiC0XfxgHN8O5ncceOsGYCny2TqrdxZ44qN7jZJkpYp0ONWIoRXp/F0+X0QeEBCndZLizb3ilg2XZVz/EzJN0n7q9NKSi+d2D/YM0k9N0bKr6dxnP5aMwATWTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 20:25:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 20:25:49 +0000
Date:   Thu, 5 Jan 2023 16:25:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org, axboe@kernel.dk,
        hch@lst.de, alex.williamson@redhat.com, leonro@nvidia.com,
        maorg@nvidia.com
Subject: Re: [PATCH] lib/scatterlist: Fix to merge contiguous pages into the
 last SG properly
Message-ID: <Y7cySyZKh+R49/BO@nvidia.com>
References: <20230105112339.107969-1-yishaih@nvidia.com>
 <Y7ctsw8ffhSsBZ4v@nvidia.com>
 <81470f28-2bcf-b3cc-4824-6e45343dbd77@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81470f28-2bcf-b3cc-4824-6e45343dbd77@deltatee.com>
X-ClientProxiedBy: BL1PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 70710f88-7168-4901-6135-08daef5b088d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SeoJIWXLpI6BKSNKFTDgERiVm4O56TI6BoSDe+18CkZeHSMMghXeCLObod2bD5y4Mb6cZf+aWg6wC1oX01EONzxUt76wuB0B9Hb1sDW3qr27QQWNVgsJxQ3Oo7xIUM2nVpFa+4Kc+8AoquHSE3KvefNzjl0HATzrGZNLKZDSc9M1Htj984X3rTwFSrfRU+rFdhqFuxZQBTmfpbtHvRr2Ww8T5QgzZjp63rVdO5Q497Ra4YGodPmIFtuvNmrtiCf62aPJunp3qYiDWWoJGGVaIYsCpnZtRmCxSO69iI7Jw12gjor8fcBzELbZT9Ci8gyMxTiBO7tSQP5lGGsqw/bavnxOZdVPxvjC4NqQGLNqMZI1RhsFYaZGbUc8WYZ7pDlQ9I7/pz4wKXV0iWseMLs6a5SatuyoW8u3BU6tb1DjE9WnN/gZ2k3MrbZ7rS34ObV4ajMQaoeY2soQLRLoUDWwax9nFLD5rQS/JggnPk1YUYusWdJEathfBW0L6W+LIp8nO7sdWJP32llFYNO87dt2a7X8s+QNg7CSkRJSO7Fm5g71JpyyQzgPqIeO4hvI+M96CcfEsa7SRdtUuROOoTQRcbaSpBctvDTAip7PG2AoKfp78iiszkAxwes0UWUzlm4VCLUJP3tH6k1PV2xaP5Og3yBWM+gSlwYKHhApH+g/OAmvFRrAML1d2wid8x7aJYDvMUlmaprszTfm/Y/JY7nqHy/TMPOHP7eCtbtJ487x5+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(26005)(186003)(2616005)(6512007)(83380400001)(36756003)(38100700002)(316002)(6916009)(2906002)(66946007)(4326008)(41300700001)(86362001)(8936002)(5660300002)(8676002)(66476007)(478600001)(107886003)(6486002)(66556008)(53546011)(6506007)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hs4IsYyB9PVA1gLwwWE1F729cdcIAWOsmsLC7heFVAi6G0Tw6J4okKhbIog9?=
 =?us-ascii?Q?RCI5WwmGuxsvLx01fcjb2IwJepUQkYWOTjyCTXmmKcbcYQf8j2CsiMhvx3o3?=
 =?us-ascii?Q?zhaDD+2KKRXuuJTGISHoszK9QsxoImxY7CUsBasWeoB1Sk6oFGm9b/w6CkXZ?=
 =?us-ascii?Q?vuFlKf2cEVa2XZ2pVmGA6mi1jH08GpA7JJ/82O+gDOljDMDymcJwpw/qb6M7?=
 =?us-ascii?Q?1PBV2rh3lvVmwVxUuN9Gv+Zzgcs9YGiLHm9ybFL9/I8csyktMu4yrNn0CwFu?=
 =?us-ascii?Q?q3IxxGSwUFNP7oD7LBaPfDcWLRg9qVFxK945gMyUaf3lCql6t0r6nvTRy4HL?=
 =?us-ascii?Q?4k3aOJzwAwdYpMzej0v7UWRXP5IKPt/XqeeJoEj+y0M1zQ2pxZ3q5Glgfd98?=
 =?us-ascii?Q?ksO3Glbcg2Ek4l47lUuUIMTt5hnkHRyGaymkKEyum66Els+z+6zsNRVicJrz?=
 =?us-ascii?Q?IgWJ9wXWyROoyTKPr5yh8XFDXSM8zTK2sRP5VniWlVeM0RCRnaZzLqxfxjne?=
 =?us-ascii?Q?pzKuzrhIlqD1KOQc5X320cmbH35F0FLEVA00RyG7ElxmGSNy/9KUUKM3Ub46?=
 =?us-ascii?Q?0hVs1dSSS0DQvEFkqC2iwqti0V1mpAYsh77plagxmMsdWgAAEHLx/TdTjr4b?=
 =?us-ascii?Q?MqjhNDGM1iUFWU5uis3RYuiWdCJMJFjeQwp51XCVchbxfpXpEarHRiyx06Wg?=
 =?us-ascii?Q?xzY8W31/pc83DRgFoTkoxdxcPcmWExpVvAekyfCc1KJZ31GMgDLnKFSsGmiq?=
 =?us-ascii?Q?zhTmPde5d5llJBqZyeRMZqajZqGANfAtV7oJacCvUfyVokFNwQSTSOrk1wRc?=
 =?us-ascii?Q?QVonA/cWaOIUhLGsAZAZyHy2uMbQi+Q/HVbBF6gn/en/X5q3lAesmjN2sWvK?=
 =?us-ascii?Q?TlOVb5mdkHwFA9OM52IoTTpMm7zpAqo4rQfHdR3r9Bces5YMtpDR79NTNbrV?=
 =?us-ascii?Q?wNjS+VXodmiMgCTWYYYDfkFu5iqI7wCdUORXFPaS2C6FcSITqZpbcIJUqL/q?=
 =?us-ascii?Q?IO5isCJBCINGmvmzZlVCISmVw4qY9Wy0b3gzUbA2jA1Feo2Ah4BBB5wQ4V2x?=
 =?us-ascii?Q?ss/I+DVIvROl/VWt3fj2bXXHvahq3EVeNLGnRlfT0m8ZHsEvi6VImsM+4hkF?=
 =?us-ascii?Q?DbMCj/KZtk+/COHhhhORIkdgepq7TaENB7U95dVfWxi6qwbrE1kxcBScaOs+?=
 =?us-ascii?Q?TySAb17zXKxj2AXTWs7+33Zn+MLzw1bQu5Z72zpadg7oqzkBpgkbB4X2ZscQ?=
 =?us-ascii?Q?lTO9KyS5EG81ma5N8xxzHYbBZwcvvo+Ako5n5Wzw/7sw8mVvO/5e/7+iugIs?=
 =?us-ascii?Q?FnjEUaKJPoAHJ2Ffl2rBSru+yPGiB/GWACp/L2XBr0JE6Rj0iFJEbcXRCANV?=
 =?us-ascii?Q?PfJD+AXrM+2FHSJqkD1h91Se4nL+B/+1ekuv67UtU9oH8Z/w8faB1AWdhV88?=
 =?us-ascii?Q?+a2mtJOlttDQvfoUt3kwo/vopMHIMo+L+K4VxNSu70a5ehzGQPYGm/WzWT4g?=
 =?us-ascii?Q?1LYRYDysOVUxY2H3zUo/zW/2UBNkyzUqzyABrb3XbqjBU/doNt4x5BCujRaz?=
 =?us-ascii?Q?xGHOvWuX6qpJINGwT00WrYhf+Gpw/q9aVVPj6f+I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70710f88-7168-4901-6135-08daef5b088d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 20:25:49.2310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsmP4k4CVXkL9J676r9eSE+QWkLxy6DlET2+N8ja4+/4ZmT+KhAEe21J+O4DtDpT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 01:23:52PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2023-01-05 13:06, Jason Gunthorpe wrote:
> > On Thu, Jan 05, 2023 at 01:23:39PM +0200, Yishai Hadas wrote:
> >> When sg_alloc_append_table_from_pages() calls to pages_are_mergeable()
> >> in its 'sgt_append->prv' flow to check whether it can merge contiguous
> >> pages into the last SG, it passes the page arguments in the wrong order.
> >>
> >> The first parameter should be the next candidate page to be merged to
> >> the last page and not the opposite.
> >>
> >> The current code leads to a corrupted SG which resulted in OOPs and
> >> unexpected errors when non-contiguous pages are merged wrongly.
> >>
> >> Fix to pass the page parameters in the right order.
> >>
> >> Fixes: 1567b49d1a40 ("lib/scatterlist: add check when merging zone device pages")
> >> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> >> ---
> >>  lib/scatterlist.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > rdma is pretty much the only user of this API and this bug is causing
> > bad data corruption, so I'm going to take it to the rdma tree and send
> > it tomorrow.
> > 
> > Which raises the question why the original patch was done at all,
> > nothing ever inputs pgmap pages into this function?
> 
> It was done solely because you had suggested it was necessary.
> 
> https://lore.kernel.org/all/20210929224653.GZ964074@nvidia.com/

Yes, but that was when I was expecting this would work with
FOLL_LONGTERM and PUP..

Jason
