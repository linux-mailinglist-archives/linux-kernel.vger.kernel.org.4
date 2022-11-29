Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8449D63C0CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiK2NQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiK2NPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:15:31 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BA1EE2A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9unCnfXGwCNkjc1A5YCKCYRWIL14Apkzye5qFkGDkV6TsFIGQMQC+siCKnBSSWKLxWJIapg0l6YMHxMOELbyw1TTTnKQohwZPBcSNNzxUCo80xMj3gG2CYoYUE0CcdnVdE5VTwtJ8X9ES68KiXFuYhWr8R5NYIWUJw+M6Lcp1AnstHv2+h4huYpo24yHQMpL1AoXNGAewvhGE3YvAMekvVOPRVhnxxM4nVv6R8qVoCE0e/4b7xZqC8j2CpX0Lx/9m/KrT48bZKc7LywLpkb8g42GVkuY1X9n8tjETlFFSK5dshzox5yAj/YvaUb4NyotYtEmJRYZ/tB0GTKy8IMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoNc7WMFqvCpqENmJI9oXp7MifvnMhjbNXt2VBkU+1A=;
 b=HIPFzQcIcPFd9JwaireU1/eEwR0UfkC8Xts+gOvlPtG44ZM80i5AULhPRyG/ggHQ1S+Mf1uhQVySMmopTza3wMy8BMHWGsMF7PWZfIURuTRiqynkMVPeznTEuNOd3h7xk1h5Cz70tVWOwtIZPgUm0UcDXonkUr+CN8l9GSyy1FrNphmVK0QDQJCBHV0dKgl2eG50tRf/x7iTLxs22Y4j0mWAp/zVbu4sp0NDQVhsuFGxePap/VHc3JHuenc8UxcZtFdOL9mzkdoah/ILSgDsNpVNMVNhJw/XeIzGCxuW307MTysmcNsIZgj4sHvs3K5eZY7jgBs5WQs3FW/Ov2Gn8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoNc7WMFqvCpqENmJI9oXp7MifvnMhjbNXt2VBkU+1A=;
 b=hi984R8nxg8b1h6wK/ZX/Gvj7hk46W3XQyGmNKSzGdfm71s+/ntAbkOuWz0lztRFDQrv3dyk8lc4QqpmKexu57IEFkX6/LJwxsbsNDit+9jQbYH6YX8pAhvZ8HI1vrKzVDR6ZyuRtpu2WyPJvPLXAPo+vIrxzZX8YJjono18ZukGrmetQypnRtqvWCPZCRe4kcz29B9sWIw5utCet4YiXFFzvAQY/skZjyiE9jChHy5vP/dABLD28kxw31tYnYkvNaC0r+wP6xaR4Bskxhum9DvOWLqCGNFjZINXaUuUKFeUiRAstKxxNfutRzWJGRIFZGudvM15hwMwxKuQORk+SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 13:15:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 13:15:21 +0000
Date:   Tue, 29 Nov 2022 09:15:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        john.garry@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v3 1/5] vfio/migration: Add debugfs to live migration
 driver
Message-ID: <Y4YF6KmQMys+w2hi@nvidia.com>
References: <20221128031200.11017-1-liulongfang@huawei.com>
 <20221128031200.11017-2-liulongfang@huawei.com>
 <Y4S59c2dWqdrdUlg@nvidia.com>
 <ca3059d7-c73c-e712-9924-94891229cefd@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca3059d7-c73c-e712-9924-94891229cefd@huawei.com>
X-ClientProxiedBy: BL0PR01CA0019.prod.exchangelabs.com (2603:10b6:208:71::32)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: ba360f68-ee97-410c-a45b-08dad20bc47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8Gg8cMRLyJb8+4UJtvzoXCsfbFue2W/Q0eppJOz/Xhubk/yAwceCOzppNeyH1G3HvilddPTu5ejP3qVLW5GNAtrCQn2mHR6E4Fdv4YRJHJbFK1MWS2z/nlU4ZVFn/26jOy4cg80mYNj0o9LSRYPENzuTvc54qCZLJ+eCGro7BRnRkIsV5I5lZTbaFB/qWi/RRyJT/Rh2P7UqsQcNplU1KtwE0C3k+wb00fF9rMx/hcONwoKEDU0KqfDZNaqRyQeLdMgHza1cE5A0FVU7PkoQaACRhyplKr2VK+BdfYKTsojAQJScKjR4gTcIjIleY8XiT+/EK5Q0HV49IzOaB4Q2uxs6yGGljGRHDMwHeYRC+uap+xa/sivoo4pxgvEv25oiX0qBZq6CHFphvx3e7bACQqt15osY5e44ydiU8dtr1dHu1Z1Y3fq3vI7CNz3q+X99H64idbAJDxgrz7k5pSLyGewM/fhZP5gxVWAMPwP1TyjJZAXF5vIQKb1kynD8pGSnZyC3VoJ64IQax5aEJg87WnHh7n7i3sJa7JF5WKZvxEb24j57B016L0TW6nJeFS7sAI5uQG0CKbje7VSOI+AH0e2/62bt0J6D6PiCHUkJVmfBg2Gy7heFZZ1F3BFxfuQZXda2erhIIgZcP8ezzsBJr8dvjiYkfgor1y6XODLfS6/zMo6YB6wbSav1/VlUh+t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(6916009)(26005)(6512007)(5660300002)(316002)(53546011)(8676002)(41300700001)(66476007)(4326008)(36756003)(2616005)(66946007)(66556008)(8936002)(186003)(38100700002)(2906002)(86362001)(66899015)(6486002)(478600001)(6506007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sCeqPh2BjSGEuEWGw2zngwakMA2iJPCusLg5whCTlSw9/iuDckISthJgo1Ie?=
 =?us-ascii?Q?gEOiqLgRzjWMA9KkPmZzLRVzdeb+2n2N224rIu+ehSIdY6RJjxHQ03wYYW33?=
 =?us-ascii?Q?3EBXAreg5XJXqO4fUV2fYcFC2Rz5MuyAyLY+AiepLLH+Iwi7lWzcw6iXrpbg?=
 =?us-ascii?Q?3w6V61dy/9IYe5lt7M/y3UXCi/5VfY8LX52gGTjmK89v7Ti4ajEX97XtHYja?=
 =?us-ascii?Q?1+IWDN9OteBk0dj26C2p0BjjPA4yKRm1JXqauJvyXPX+gjRabr2oGv/gtLnJ?=
 =?us-ascii?Q?/0n814K0rHe4DT4w8hjyRZCOsg4xyGyyVGF2BbFLY5dGhfNnib0lzLh5S6Zm?=
 =?us-ascii?Q?dF8wCnErla6tI/BrMXrPFVEoNVV3x+soz050BsUXbOju4XJqvWl39wI2KB+D?=
 =?us-ascii?Q?YAK1AvlBkYF2ugYKnKF49onNydAr86Ep0E86g9WAPmGq6hq+UPjFTA1eDxhx?=
 =?us-ascii?Q?dtDZAYS5MDHHpYmzlWvy8Hd0nAss3Hy886ZLeXKOsZRHUvjjWMHR3jC2Mfv+?=
 =?us-ascii?Q?qXUhzCT00iYyBSJzd42ZteTFW4mG0RfU7UVH6lYRF22CrsJtZSToMvCfy9Vf?=
 =?us-ascii?Q?BxR8cjFpoNw0gYvsgWLrmBUG8AQS8UWeNtbLJ1BJa1L4L6oeapzlw/SjQszT?=
 =?us-ascii?Q?FLPVMr7FpE+BKgZGHfYACQLg12/CBXWc/ceTyLIY62y2JFanvhyTnKW45kTz?=
 =?us-ascii?Q?6iKhsnicVgMbneyPVAOXDQaxLoDExBR77LU7lPiD1FMZ6pcpZxLt68uBEolf?=
 =?us-ascii?Q?K3zoUoGPnOu2dCa1G87SQQiWG5s0ttsmXVdrHeJUQBmslS1zGKLev3xcKjqC?=
 =?us-ascii?Q?2xtS+2m3RFtg0IgXt73ZopCfuXsm7FFOTgzj4Xj+bJK5Oa9to9RB+VaYy0UB?=
 =?us-ascii?Q?i3br1znH3t0xbnbdb94oFJ8SfAk0pTOOnWD5stGJhgJZMkKXpvH3Tjg9Z6jL?=
 =?us-ascii?Q?s4hE0OBAXQOLTAgqFh40nT2a4560pXTX0QH4P4t3nMLy8u0MTybrm8Pjm4k6?=
 =?us-ascii?Q?D0phWjMiOyXA4DMxfRh08kqu0yAE92x+aqtce0ZJ376g3RsRF2w0Pu+8WIXp?=
 =?us-ascii?Q?r3bzhu2SobNly0eX0OmBFzzqb+mdCPhz/AccYOiouxzgceQXtvlmd2DCqqAm?=
 =?us-ascii?Q?NK+My5fRmXEWIYuy67fG+Cbn7VfYMFaHeAWBFIZekMtUIrcpL9dTu7CJqJcG?=
 =?us-ascii?Q?UGsuMEFE01/7hyJ0tO1VdQDRMpNl0SEGjbx8mV6eTcX2zYugoYbTU7q23JpD?=
 =?us-ascii?Q?ccL/LUBz8CjQnBoAgqgRVL8Stok0xspu64/g5S5/LmfhXi0gC6Nh36LGFG3W?=
 =?us-ascii?Q?GSuiF/kh1E11Hb0LLX1xN8RxglOs367wTfwlEejx4rFsMOLQMuQy/QHkvus9?=
 =?us-ascii?Q?7nQFH1oWxAaWOqbyK+YdRkFoli43Uoaq3I7PD78mPtno3A1Cx/oYham8OGLQ?=
 =?us-ascii?Q?lhrjximJ7csYQ0YEK06mZs1RRMtMs7Zq1DqF6oDUuSdHyBYtZ35V0tRZrBfF?=
 =?us-ascii?Q?9vWxv+p5Qcpt5A6oZu7/DpMwmdFJ2p9hNEhtRhARjPYzNV0oNGeZtWvQbTil?=
 =?us-ascii?Q?qsfyKOKG5Od1sMpSoFA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba360f68-ee97-410c-a45b-08dad20bc47b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 13:15:21.0819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQkzSOMyE/xYE/s1Q6jmT+abnz4+QPTdGZk+yfMaHIKVxfwdB1KedXeORbt5s+P8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:02:46AM +0800, liulongfang wrote:
> On 2022/11/28 21:39, Jason Gunthorpe wrote:
> > On Mon, Nov 28, 2022 at 11:11:56AM +0800, Longfang Liu wrote:
> > 
> >> @@ -119,6 +132,9 @@ struct vfio_migration_ops {
> >>  				   enum vfio_device_mig_state *curr_state);
> >>  	int (*migration_get_data_size)(struct vfio_device *device,
> >>  				       unsigned long *stop_copy_length);
> >> +	int (*migration_get_data)(struct vfio_device *device, char *buffer);
> >> +	int (*migration_get_attr)(struct vfio_device *device, char *buffer);
> >> +	int (*migration_debug_operate)(struct vfio_device *device,
> >>  				   unsigned int cmd);
> > 
> > Please don't do wrappers like this, give the variant driver a chance
> > to create its own files natively under the debugfs directory
> > 
>
> Using this public debugfs file does not need to deal with file
> creation and destruction.
> The driver only needs to define its debug operation command,
> isn't it simpler?

No, it is obfuscating the normal kernel apis, what if a driver wants
two files?

debugfs is not a heavy burden to implement files for.

Jason
