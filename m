Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6806429F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiLENzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiLENzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:55:14 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F880B6F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:55:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVHJhSqVevryCYoNAiHn8YbCzL3btchMMzdMYraRoa/rSCL4o8R3rOU3GJzJrVBm27eXGtUcIJ0mev2XSYelqseI6usnIlwzqUSfo6mrj65ccKEpiWsmPLHCjUsDU3btwolEZceu1r4C27S0k6Ce9aLc5+QoqDQDZ6Ivygud55eMjTMEAd++TP669bHlxFF9dW7GNxGi7pyUt2OFeqt+l3UzYutVjmIqjWR11xBEBfuMKYabBEIB3JCA3fT7xe9r1MLxLDfoPx4Byxql0WZdEWv0w8WpRCnAnvJMO0LjnEgaruH/FVXiVxzpDqWpt1/vlWzKHnDs1pko6coB6bhHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhPkXB+XuFvj7ZZ+5qlqEQmxK+pCOQs8aS3aS1sJzZ8=;
 b=B7S25/6gR213jXui8hOi4YrFvfp5Ux7tcXIb+QDnPIKqGpKlxwHsug+gOKyFALV5fZeVwfzeqdLk1pz8ZmjAdDKnRcAjPcxkmHXoymibx833qW78m0MiIXWYmyWcM4Z7Ljqh1nZ6omt3ZFJIGRfsBtnVcWIVDXpWKFgoMOI4JkIOH/m5MoN17owzl31s1oL2lYxXe41s0WotQdXTdhkrY8YcUXrEqNx/5HsMZfnz7PELO8wELtfFSKPs/L4bGhU7s4rTquMGyQ8fmoIl9niEXe9hAhCyx/+O389VLhwUxnsqrgFKwpcRXv1JDufqJ4QXLnWAKo6PV78uUcA+Y2S6jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhPkXB+XuFvj7ZZ+5qlqEQmxK+pCOQs8aS3aS1sJzZ8=;
 b=hU67spdkYJnFoqnPE1LThihdqobHEoUphn1E/t10HGX7xL9yZlPDLS/Il1q6xOKW0mLYswQ6wEv0sQi5gceqA3XMgY2+zpnRVyKpOjD2rxwGTcTcAlrXZbN5xxEHqVD7Liw38HjoShtySc9cODWLSqschqkjOnuZ0CG1MaZP9o5eIkzGJYD9h4Ru1Z4Ji4KJXX8q9oXh0PB9YbsmnskTUNlV0B6SnhI3+7G182JbNZiQmbGo4LIbw8IzsvBbwGfNm9F7g+QPuGUjDvPhEDy7wLXIKTu4askGp5wzNynuiLfFifJVkZoSF8GSTXNxHamfjtePpvlYwuXRtBVaRD9Jtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 13:55:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 13:55:12 +0000
Date:   Mon, 5 Dec 2022 09:55:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        john.garry@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v4 1/5] vfio/migration: Add debugfs to live migration
 driver
Message-ID: <Y434Pivb5PwzP0TI@nvidia.com>
References: <20221202092625.35075-1-liulongfang@huawei.com>
 <20221202092625.35075-2-liulongfang@huawei.com>
 <Y4oW/ToMZEUnlYZ1@nvidia.com>
 <f17dfd5d-3d65-d51e-426a-e60f7e99a3d6@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f17dfd5d-3d65-d51e-426a-e60f7e99a3d6@huawei.com>
X-ClientProxiedBy: YT1P288CA0019.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::32)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b780dfe-dd33-4d91-a7b9-08dad6c8541a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPxTXbVhuWWVwr2ySruIhrJskNctT68lPwOlCymhpsFMEPM6yffHchb6y290Iu48qlIp88evNzVmJK32BDYHSK2QtuYJJfeus5CJ+c++4VUzGzudD9jPCiw80DkgJfMInKfkikwUSCaYqKFPkb8ihqz/GH6r0P+DnBMG4syqa6IFGYyHCBPHpoQaH4Fs5jbyv0+h+3l83+03Ncb65h/5q6Bqgo2eMWal0ZqrQdfTZGiYhTscKIYib+layv130nJLH5gQPYqYRflf8f43nEtr1bVGDTrLBK2f3o2ofeAVQ/hozdN8tka9ecmB2DrQHWMRmfNshEfkky3DLJH3n63Qg2HexGN0H2+nUiPzxbm+Mx9SRGomKHNTR62TkjTTcZv+Ad5Q5k+IdUCnqssSLtUsAN+uZmfyd2EP/frGFN21hSniMZvkPBLPhmCeDhRouNr9GDhkMvIAag1/eiG5H63Mbrhd7l9w2bQOHSu9r5Z+lh+UTvAY2OAIJFfFltFun65L3b6MUtG5Lkuvkpzm0mp4WnrlkjhtPZ1jT+4t0ETcCRSk3vjwFXJEidWNzgj9kPHD2IHGET5js1m6svp++rPslDnqZ1UD5jhNC945j0XzpDffDVX4yo+VJFJOH0ODpzRCClMTgthG346eUvrbH0O/Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199015)(36756003)(86362001)(6486002)(478600001)(53546011)(26005)(6512007)(4326008)(5660300002)(186003)(6506007)(8676002)(6916009)(66556008)(316002)(8936002)(41300700001)(66946007)(66476007)(2906002)(38100700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A6RO0OL0aVK4z3oGaPSkQA7pZOsbD4Iv4yImMshJ9bSCwrVJcBoEXeiRL5ar?=
 =?us-ascii?Q?99b42JHpNvIXvgZ97LzCyb6IIXEY3kJ31+BujYP5LcZemJCOipwP71Xid1Oc?=
 =?us-ascii?Q?uCYw2HN8gBuotkt+usI4qtWMuPDiJQWSOYFjwa8WUxj2W4Df5c9h18uhN945?=
 =?us-ascii?Q?kV2pvmB9TieenD4u46H2ZjlR0PK9yltubwvs3kb8BUpTdBY+oldhCi0/OXo5?=
 =?us-ascii?Q?HhRBkE+pztpSvWNHJpq9YQoU9R0AjxT9AkINnmbwW5O8acrOfK/53O3hxCgG?=
 =?us-ascii?Q?6gxRqJgVHGC2kpNtdiQy/ABBS5lX8CF6x3cLZ8Z1MPKI7TZcnwWlGOveQPV9?=
 =?us-ascii?Q?JKDlh4OOwSIQ6SAIerBbKckExMbx6vpD7P/Wa4hJlYf0OgO3lWun8BONC4+P?=
 =?us-ascii?Q?tJ1TiLcaQzJKtKK8g+lgKBxWucfBXvuRRPkmvjUNiaDBmBX4P7xaLdglheX5?=
 =?us-ascii?Q?gHtIbj4Bxx9ASP/aXMp5/KMPk81DjEaaCLHZ0KOzlcqnEEgcmzNStyYTG6zM?=
 =?us-ascii?Q?DFG1t0wczhD3akob63UF9JpcriPeLeTefFpcp7iubH/O3/JBtnJUdmSHPJPi?=
 =?us-ascii?Q?9eWQWwuoRNA8l8+wiuAcfQ3cjfwLYwicRynJpKI7yEPhBU2q0UNu6+8BJ6B8?=
 =?us-ascii?Q?0CTAxQLa8nSKgL0DwEUXAP4H/vGoINaeBRUSjJ/hn4oIFUvaHMpIK+vN23kz?=
 =?us-ascii?Q?L+ovHDA1VN7Mub9G7n1L1m24Cwz1fW2oHot4uWvChnb+ZtGyR+fwG0KKC17c?=
 =?us-ascii?Q?2xcNQYyH/LL/0T7mdUH4NvJk2EytWyAZ5BP72zwTqXQkmlC+s9+aFlRiPZV2?=
 =?us-ascii?Q?CzPGTXNBWzoeLxQ4BPEHvP+2WhK5XyLnWiD4dvTJXlc0XNLm+Sci+GHnqnlA?=
 =?us-ascii?Q?PqIAedeTIQEmewOES47OEJ/jUR5w7D4db3yh2yQwD0JoLAI4m9pXkgpnGWS0?=
 =?us-ascii?Q?k0SZa97hKCQAiteMFdAbOQjLpX4rVqHvxI0gUd3/ByUTTyy9Sa3kGO22agGN?=
 =?us-ascii?Q?72h1MGMhj+BAV2XjURUzUhVbvXF2EucGGgUPX0jXyocIQMvFq9jlMPwA3KNQ?=
 =?us-ascii?Q?fwesYVRxHjGS9CLxhZaHBBOZd8+Kd6IG26E9GcSy3TyQIcfyo42SVvO0dxrq?=
 =?us-ascii?Q?8WRO0Z+7LERhxb+8JvC1aZ22Cy/U3t+1d+xUu9yr5osoqKoQtNqV5mDDLLNj?=
 =?us-ascii?Q?W6koZcTG37D1oJA0lBLmmXQHzCj1o57c0YcuBHeUbRZe/1fTt8VFhpy0csr6?=
 =?us-ascii?Q?DmLu2Xonx1n21ANo+8/w7mGoxhtHTTTB/ScAjTJbVcoxDNwo8YsarnmhRv4b?=
 =?us-ascii?Q?pMZlvzdlRcHmqToS/njDM6kD5qMtQaN0Tv7Sc1ftIN2yYkv9p6nG5D1F5W3M?=
 =?us-ascii?Q?mjz3hJ7MYPHxgFplnwvf53eVCyMWfYPrYFd2HJ0BC8bgeLqQ2k7MTrUWfOo6?=
 =?us-ascii?Q?+8/7b2GpWeczERs2b2NCj+wt/heIg29c3r8mvxeZiImj9W26I4yr95nJVfQp?=
 =?us-ascii?Q?UETGRSS3Bz7bG+s2+5CVQaKlrtG/hg3ubD5h1Qpael26uUa3N+cV/dywY/yp?=
 =?us-ascii?Q?IcN31bk7eKy3ZB/C29NbAxrhZWwLBUR6ZC+t7aIp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b780dfe-dd33-4d91-a7b9-08dad6c8541a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 13:55:11.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PV1G1/REvjCWKTSrcDK73zPtL8tq20cQSFosCmbIpgZp+aZG1kFFf9HwcSu5TPkf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 09:39:29PM +0800, liulongfang wrote:
> On 2022/12/2 23:17, Jason Gunthorpe wrote:
> > On Fri, Dec 02, 2022 at 05:26:21PM +0800, Longfang Liu wrote:
> > 
> >> +static ssize_t vfio_pci_vf_state_read(struct file *filp, char __user *buffer,
> >> +			   size_t count, loff_t *pos)
> >> +{
> > 
> > This would be better to use debugfs_create_devm_seqfile()
> > 
> > Then you can simply use seq_printf()
> >
> 
> The previous debugfs used this method in my patch.
> Is it now recommended to use the interface with "devm" ?

It doesn't matter, the point is not the devm, it is to use the right
helper for the data you want to expose over debugfs 
 
> >> @@ -119,6 +129,8 @@ struct vfio_migration_ops {
> >>  				   enum vfio_device_mig_state *curr_state);
> >>  	int (*migration_get_data_size)(struct vfio_device *device,
> >>  				       unsigned long *stop_copy_length);
> >> +	int (*migration_get_data)(struct vfio_device *device, char *buffer);
> >> +	int (*migration_get_attr)(struct vfio_device *device, char
> >>  				   *buffer);
> > 
> > Still no to passing through debugfs ops, create these files in the
> > driver.
> > 
> 
> If this part is also created and enabled in the device driver, why do we need
> to put this debugfs in the vfio public framework?

To create the directory, and the few actually common files

Jason
