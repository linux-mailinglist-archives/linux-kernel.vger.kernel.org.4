Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1E67FE3D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 11:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjA2KjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 05:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjA2KjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 05:39:04 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1A62202D
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:39:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRCRcfaTmszSbwzl9DrDW2WcxQl6RQbe/UU11r+LhNcpcgiAnJxotgaCAGIAMomIk9SqitADTCSR/RcxB+fCnCRlP3ZlfixdK84dXDjGYsLzWUiSwoRWd11fsRpKc1a+8vYHMJCoYPBGQATKbimmPTWD1H1U8ZNZSQRTySI6pSFXC3+RYSE0ajMy5WjRkUaro9ScbhWLEw1BpSmpCJwq/8Wl663NHUefvgozXpvSJVucsVheZMU/aIYIrdLgGQ4UM119pFq+Q+BZ97Bd0mW7i5C4G4CbGC/0hOoSOutVYPfvMZRaIlmKvAKYsvFhTMiXU4JEAs9MCfUoScJUkPrxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inYXyKYynlPZJNJ4krE28NexTYaE41LMfKQivTKYls8=;
 b=hOQR1J4DihiMzsXffc9zQVoKWHUuRw/B9iAsmolBGHy//+Pt1uarKk8vi2CkgVEyGFCpWfwJo2cyZWF1WMLGmohIV5xvQqvQjBGSJThng0sJpAurOtvn5QGYbqMMYqUxexqZSRumG6t2yzgZZcjlOI7kRXZPjYoTWc23UlLlgpS6+toFf7hZ84b2rPBLRcdnIYSDzcAHHkcgpMwMUK1vLGTtB2Xf6gfPx2GFc6YChiSrt3UnBrgk26SOUHee5rL852SjfSiCG3QEawSp6LjUZG0tUZlLF+DTR+A1hBCBS4O4EhEg0rycNWc6hDJrbugszxnn76Y6vBEptKzUkMw6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inYXyKYynlPZJNJ4krE28NexTYaE41LMfKQivTKYls8=;
 b=R5YBxA754kMvD031t/MyrPcU9IqTpKZqWj8+CAm+JZhbG5VCZKkYaNuhbsWEid3YCclUh9kJDu+CsYmhH2MvsepGtWP8F9rJdkVeZBM5JaRVaVRYCsVP189INIUb/kZOiCKpi00FSffmrrXuOkIMw4ciatFcgsxhk1AGPVC0r93d3XLY5lH5WQ6U0lRurzI07ilEIP7cFYk8Na4b9N98hM72YtMBqtx1Aua0zJjnF7MRWcwWoIImay+Q4nFANY7WuDDnXJzgwkhPGPDYW4GIrey0pmRt6J8c3kWIZYe8ZlxshBWlMBgrF8Bp78/i91gCesSApHOA3+/lecq76ncyow==
Received: from MW4PR03CA0242.namprd03.prod.outlook.com (2603:10b6:303:b4::7)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Sun, 29 Jan
 2023 10:39:00 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::db) by MW4PR03CA0242.outlook.office365.com
 (2603:10b6:303:b4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33 via Frontend
 Transport; Sun, 29 Jan 2023 10:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.17 via Frontend Transport; Sun, 29 Jan 2023 10:38:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 02:38:52 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 02:38:51 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Sun, 29 Jan 2023 02:38:51 -0800
Date:   Sun, 29 Jan 2023 02:38:50 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Message-ID: <Y9ZMulxEyGvnvW0X@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <002911839dd30990d5e3135f8a0f8d41f14e856b.1674939002.git.nicolinc@nvidia.com>
 <BN9PR11MB527697E1E24784576C3FB7628CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527697E1E24784576C3FB7628CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: e86f3ba0-99be-4ba7-ac9b-08db01e5082b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /v2EZVeXet5RxSuSrRngTj7iEoy2nqvFAC2a2B7XaRjsKiepXoTKf1Uwlqcv4HEQ6UR9aqL/OfU7F9XQcK2dsU5rnt/MTTUFlyjkia3SoOvTMuQx3ducfSHDpeYtxpax2OFJ37KPnUx2GqhVoouUDwsjkTVnfPsE3Hasi4GFhu2ARMbSpCNbRN3XWrdGkfhzCta6Ek2gsHNJM6/+lm7vuJH4g97ESpyrxYFzPQDidHv0cV1Ym8i/kXWM22S/oEicfCzTPxloXGqkpot9eUvjqOdkvp0Qiugqif8P8SomXk6KzRHW2wz7Ta0iefZmbEZcxbDgP5p7OnFaUwKobyFnWYULPN6fQpaX/UuxKcxNWSA6al7YtWmMWsHYMrH7S9R4m1PhlqVys9cj3LSmU1dzvrvnujZpghefVuEtEZzm/0yYnoaPNDJcDbZ4Drb45mbN3mVElLLCovECupFsx+TetbdaMcAouspZ2BhJJvMKl6l4yO2QyWIVtYdnvIHfK62FJ7W52c7WvJRUXh3BMv/QXyddobouDi5emBrXDqAjLzFcIX1cXwnrp5W4QDFP72TwfqVV9G3rE4KPEo0GiraB9CvpxyHTcgaA+30VC4IKEC209w0kZ2sBrasDMAI3UpuYhDuu0go76PxVv1sZse19GY21nzf7NtOYFHdPkJeF82NjhB3wSNcUVokTaPIupkzCL9EgWB85oGkwZtUA2KTIsg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(41300700001)(70206006)(70586007)(83380400001)(4326008)(6916009)(8676002)(8936002)(316002)(40460700003)(9686003)(26005)(186003)(356005)(47076005)(426003)(36860700001)(33716001)(40480700001)(55016003)(2906002)(5660300002)(54906003)(336012)(478600001)(82740400003)(7636003)(82310400005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2023 10:38:59.8338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e86f3ba0-99be-4ba7-ac9b-08db01e5082b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 09:37:00AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Sunday, January 29, 2023 5:18 AM
> >
> > -static bool iommufd_hw_pagetable_has_group(struct
> > iommufd_hw_pagetable *hwpt,
> > -                                        struct iommu_group *group)
> > +static bool iommufd_hw_pagetable_has_device(struct
> > iommufd_hw_pagetable *hwpt,
> > +                                         struct device *dev)
> >  {
> > -     struct iommufd_device *cur_dev;
> > -
> > -     list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
> > -             if (cur_dev->group == group)
> > -                     return true;
> > -     return false;
> > +     /*
> > +      * iommu_get_domain_for_dev() returns an iommu_group->domain
> > ptr, if it
> > +      * is the same domain as the hwpt->domain, it means that this hwpt
> > has
> > +      * the iommu_group/device.
> > +      */
> > +     return hwpt->domain == iommu_get_domain_for_dev(dev);
> >  }
> 
> Here we could have three scenarios:
> 
> 1) the device is attached to blocked domain;
> 2) the device is attached to hwpt->domain;
> 3) the device is attached to another hwpt->domain;
> 
> if this function returns false then iommufd_device_do_attach() will attach
> the device to the specified hwpt. But then it's wrong for 3).
> 
> Has 3) been denied in earlier path? If yes at least a WARN_ON for
> case 3) makes sense here.

The case #3 means the device is already attached to some other
domain? Then vfio_iommufd_physical_attach_ioas returns -EBUSY
at the sanity of vdev->iommufd_attached. And the case #3 feels
like a domain replacement use case to me. So probably not that
necessary to add a wARN_ON?

> > @@ -385,10 +372,8 @@ void iommufd_device_detach(struct
> > iommufd_device *idev)
> >       struct iommufd_hw_pagetable *hwpt = idev->hwpt;
> >
> >       mutex_lock(&hwpt->ioas->mutex);
> > -     mutex_lock(&hwpt->devices_lock);
> >       refcount_dec(hwpt->devices_users);
> > -     list_del(&idev->devices_item);
> > -     if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> > +     if (iommufd_hw_pagetable_has_device(hwpt, idev->dev)) {
> >               if (refcount_read(hwpt->devices_users) == 1) {
> >                       iopt_table_remove_domain(&hwpt->ioas->iopt,
> >                                                hwpt->domain);
> > @@ -397,7 +382,6 @@ void iommufd_device_detach(struct iommufd_device
> > *idev)
> >               iommu_detach_group(hwpt->domain, idev->group);
> >       }
> 
> emmm how do we track last device detach in a group? Here the first
> device detach already leads to group detach...

Oh no. That's a bug. Thanks for catching it.

We need an additional refcount somewhere to track the number of
attached devices in the iommu_group.

Nicolin
