Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDF261175E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJ1QSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiJ1QRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:17:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4272529B;
        Fri, 28 Oct 2022 09:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+soRhhielPloVlmJj0f0itCnPJuxkklpY6w94cGqTcBQ0KnPljAa62FidCWCwqtYnzLTHmLYfREYpTwQkjdUhIZyLYaW8t6iUBpFwaWdYrHgjkeA3d3Jjw7ICEU7z+T5KTdDaHu1G+VyWoAc0ni0yShhpjUbfjM444XSqAIZGfI4JAyFhFabpyEcHJX/CbatIUSIa82EHBj316F//yB8z4UyTss0ONWlGvVK/yZxOq6pMqhCi3s+Mfzh5XVEI5nsB2yCv6pKQUZbunkO0OIi+1zrx9+0fFOor+/EFf5hwxcfE3GxuOxCIySuzV+P9OHn2AfzPQWO90xsLNeyXxq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsRZ9DpD/39rDOKurENNJx/UMJc72xe52+9EhqKmztk=;
 b=TH+me6JE94uFo+tE3i6pJMXqzGo0Uj2EK3vtQc9OPrzorsoz6pQYqX7Etaoq+jjuO0zy6XENBar9tQzt0lWRfXZW+tTuQcJszoukaAX9kpKenx+0svy6AN3/qHxeAK6/dHqzR6uXLnoIGwg90vxikVcvoMpVY7bW50pAuBJFlcuiutMo5DmOdtROptwaDfw7HtNnZrn0CtPbPfJfvSKL7wYDyxWdoDy/oup+Bm5SjidDEy0tZhLyKd3oKTuVhTqHR9u1vw0OlxKaC43bzAk5g+/BFvQgV1V2CW6szvLXQwvERpRI9TJ2+QBgnFMgfV5Lun+AokOdoCR6XCobTbvAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsRZ9DpD/39rDOKurENNJx/UMJc72xe52+9EhqKmztk=;
 b=aB5eLstyduvdWSn91G2awZUsRxKFs0kiMeaU4+bbtHmHoAVav6++QjW/CXhh2PXn7r50CfS0mlCPJwbBGGx7H6IuMhLOFY5M1UXc112HRoLIzUztuZhZAvQKpxdfEinpNZcluMy5VnZV3B8sQbTpXeg4Zrnbz9g2QuQ4YFmDYZu6A0dKvzN/uWaxGJa3DyASBtuxMKsxEEv92N5qMCmOjhw+DZKs0TCSwR639edfYoxXc0ipprol/exfjxiPh5tnSAyFBDxIpmLAPXSFN2gs0ACdh5Lx9i+7ZOxP/GQ0uNGtqoQ6EvNDsG7BLjneNRW7UROwLUuSCxu6TX3tZAAY7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 16:16:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 16:16:45 +0000
Date:   Fri, 28 Oct 2022 13:16:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rdma tree
Message-ID: <Y1wAbLvXq5vYVuDi@nvidia.com>
References: <20221028063328.29b404bd@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028063328.29b404bd@canb.auug.org.au>
X-ClientProxiedBy: BLAPR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:208:32e::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f3f60c-64eb-4818-bf62-08dab8ffcee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gtls1Ny/h4UUKcKke5Lupcl0VusisTiXgASn4ctdeP1gQBJXecEL0+h8M3A6utq3MK2cKIkHNyo6Oo3FmlWHlFF8SJh7l5wC8jvRjpT/MvUc3ZPSk4ajrBlafNQA6dK/hbXwqjmZtktxOzAf8O90PLKihX0AG4TmLQhDes/Wd0Ysey6uUYr5yj29qShXq1W3GMJFIHKvtaO0iYXDOUSND2LWLEOEW9FFOAi2qdRh2lJpeypuXvgwXZ0uz0lKuPFfSkOlQLk8lmBJfLLLavtY1NZpNDLUSCsj5TGnf1kltBN+yxRjQZB0mSxsiBBLrZwpak8tU++ddMwfeNQeVBVLThbo7TtcuFF9j2mApUpzl3CzLJ3xxRz2GCO9ZIaFqDKcWfo4N8NAxMzw5oNaHXCMLGV+KP8d3UWNJEjo/bw7DGTIoUgZa64h3eJngCWvi5vmRfPBY/7OCJYAQHzr22tFLfcuoh3G2ZK9KsRW9OZ/78OR8633nlCwc8QbAEcPddQghWiGKPoB6hUIJ9oppHmPVwRAPzVvo6auMh4UMjVolMrbcjyUY1orbyYqIZj3c3YPqtYiS11jtI+ccBKYEFiLiPRtoem2J+yms527yjBUuDY8GKJ03FlUieSlVSG9iqy2BDzGJ4j7mFIY671BDre/1LQUbvdkYS6zh9khTZ1PnZsmWfT3zeudR2CUVF6mosg1M43bFCKguDdwCNgwgZWZag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(38100700002)(36756003)(4744005)(66946007)(66476007)(2906002)(316002)(6916009)(54906003)(8676002)(4326008)(86362001)(8936002)(41300700001)(66556008)(186003)(5660300002)(2616005)(478600001)(6512007)(6486002)(26005)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mekQQpcTHcUnw/P36MFeUnvYtUfv5vsApd9RYHWYWbcY408oyy/r1gEdfRL0?=
 =?us-ascii?Q?+vRVv2Fq+YYlyCbmJWfxrFcghraQccr2KiDjXaehY2Je6xPHi1qD3jss9Z1N?=
 =?us-ascii?Q?A5VRLJUU4O9XSkzC6/b+fhtVBJbXMH/WJ6LxuoWGrYzgsS6GTLGyN1aAijKV?=
 =?us-ascii?Q?udFmUUY7YMqn5sol22kqr+MumSPOtW1wI1OF+7EElATE1REVwSvyHG/+jmqW?=
 =?us-ascii?Q?+aBAaXxAkfpAuqkop6+VNp+vpGt8hiB6IcS4jR1i1KjbWUaPdA1N2pPJdeft?=
 =?us-ascii?Q?j0e6nRVEkEhJumw1fCIZSB5lXRHVX0eFLqRKqY+e279l8dz4tBpCKuYMii/s?=
 =?us-ascii?Q?R+M1ogrhoGBkQhWO2D6Rixrr2ocFTWfsKSkynmamaZ+V03JvSsZVFrBBGKCI?=
 =?us-ascii?Q?vHFUggoMuVMFpYpJ94iwiyLvggjJm1i3iYpiKWeOtCFmkhFglq79KPSvNDSs?=
 =?us-ascii?Q?nOsCA7LPYGjdMxnv/MGWYIUU5eqpuYnYhSo9Tp3+MgnXpEfQJwjr21OLC4A+?=
 =?us-ascii?Q?iHD1k/ta+PWEkzQ1ukqFPDWFEAfMkg5hmdUdbPtqmqJB6O5clfoZQ9PE0JSB?=
 =?us-ascii?Q?PEtcvgLKUgA8lasQXcslKpi9cqpqZWMAMdiN93QfK10zWUNe2ZXSGVvwrmEn?=
 =?us-ascii?Q?vpvo6wOu5+VioCIrW87J1YFvjl2Aq9ujT0GjbivJi4x9/gDpjTqeD2cnkNFV?=
 =?us-ascii?Q?7tUNJMizrFMWAcEGH7867FYNhLSJmSOel1ZmgleePlM/2trdyYsxDjRK9sTp?=
 =?us-ascii?Q?APKyYkFiQf/vLciBmTyGPy8IRv3mqWALNzrBb5li4Qi/tOqgBmK138fZf1wS?=
 =?us-ascii?Q?XLovr9N6T96jmVupNFeciUDrFP+vwnuRJhvrxwTz0kAVxaXDJ5myZfDNf86e?=
 =?us-ascii?Q?CvEns4oNz0YRh6iGFDF1fe6ejcwx0QmQaA8uctnZS/dxsQ8tpQOOdh2WkNxV?=
 =?us-ascii?Q?aMUfoIP+FI/Agf2VSpPt5hLADnx6Lb8jlxBrKCagkJ5xHaG+h+iN9WNTNInc?=
 =?us-ascii?Q?jGIlt0HEPsCidzsxSyIcPGTZRbVtnpQ4YZoZqXK+nZNJkNUoa8I/0sbZ+tPc?=
 =?us-ascii?Q?25k/6+EVV8K50+dVyLHCqIet8Fe6oMhijLw05o9EJBD1OvzmIu3idAvB63Jc?=
 =?us-ascii?Q?Qbz+oPrwKfP3A+a8C8x4sJPq3eLWmhONr+wiWMF6vI21AEOLS7oUGXhvKUbl?=
 =?us-ascii?Q?YUX84Yn/GIM+ba/RgA9HXryqbx4TX0+i3ZtYP3AuKQpxmBbuj57EQ9bksv3L?=
 =?us-ascii?Q?IYGuLCL6jLEMFxaWMa0TnysuhJWjAqVuxsMEb2JQff4l3/5jnwtb2w+3HDUZ?=
 =?us-ascii?Q?UhYUBRfmeoPhjmW3iJgJlHAeGRHH16M2UYm6M4Lly1ibS48Re3RGJelDsU/C?=
 =?us-ascii?Q?sljKmj/OHZPgH1m3rbiWMYPikRAHoD6SBNntUhqaiIurav0tN3wi2ih9XgI0?=
 =?us-ascii?Q?5o1R7KTqVCAFZ0drthp1Di4FnNOILlh1l8FvAIFyS7Quy+3J5xuu1raWR4mg?=
 =?us-ascii?Q?wzjN6xiWbKnsjWEYmwtXqTIy2NR/asPIwEAs6Ey7Mbep+GhPSWgVQCkLUZSl?=
 =?us-ascii?Q?mEVJ2dMmWoQNEN/8wcc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f3f60c-64eb-4818-bf62-08dab8ffcee8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 16:16:45.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2WnH/nbX2UdlxUhq6Gi/Hj1F9GqEKbSR4kBo+rA+fHATQDfySYWXsxXY2tR2Ey/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 06:33:28AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   cca19da0d998 ("RDMA/rxe: Remove unnecessary mr testing")
>   90f0afc4039b ("RDMA/rxe: Handle remote errors in the midst of a Read reply sequence")
>   aba632f6e406 ("RDMA/rxe: Make responder handle RDMA Read failures")
> 
> are missing a Signed-off-by from their committer.

I fixed it up, thanks

Jason
