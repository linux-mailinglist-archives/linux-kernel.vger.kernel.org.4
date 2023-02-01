Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1F568706D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjBAVS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBAVS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:18:26 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871216F20D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:18:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnXlhzOONYF9Ypermr3qMSTBAVXOWvuZvCKpi4yyD02popLcuj9eMHvPOq50UVoRB/ncpX2Fnnl+7InvoPqg/tuw5BqAJl8+iPw80q1+TKyBesjLol7j7NWnjd8GmzE/v3N4RptCkRNQYMZ+YUOdGgubSVgA8pOT5PAQEJs9MDHi9OBN2+IVxGK96bh4/YRVsNHYx8fpgK3uC4+qTF3GyqeiJwJcHFpzBXS8Sd0Ii6Oy1lXi4fJYLuQM2OCkixbMx6He0KnK2Ew4PYsBbhp3Y+KJ+Yo3n4oo0/aED3tds+ti5eq1xFmLlBcq1SMcKt40PAphIedWDU6OH2GQ5yZgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1IDttaQsSGuc8DRIRAOlq3DgOAWB0N7V5XTJmXjk7Y=;
 b=NqsSkO3dI/ak3DZz4uIHNkTXgsz6tcbRVJ/Z15ykVTvgdvXaRe9L6foNeOEZZdmoc4/m4y6N91N+NT2r1b+xSVWHD+pADShPwiKsEE3zo50rAH5gGv3dtjjczHs6CLe3Iysm4xtl5cV630iHLsVpFAnRberU1nQzrCB+0ORi+GoFYEgZeNseKZZ+PV8VPHEfpJXYA26F3mIHTeHT2LmTdcEjdGKDm0Xv/dP1xPpja6DX0zjH9Jwl1tD9jXZ3HtxiuM3QV/iVkWrR+igUcxSHCw8x3mkI4t8FUwz7xyCz0A0y277agsM63J7cXf57Z6EFhNHFd+wMVK7jugRkHG6dLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1IDttaQsSGuc8DRIRAOlq3DgOAWB0N7V5XTJmXjk7Y=;
 b=fUJx0D1ApTRI7s2AJe/bN6WbGHIsZTG7D5hwIqwOPGHEqvFgF2daPjIp+EVBiFMCOXxCjcMFw2eqAaQWFhESPucpJ362hmCUBBMWe5hE6hjLGLYfOtkqAi8gGvbJEVROYrVSVn4p0BUBvIQhfiGLYO/h4GZZ1DiEAOA5ivkEWpB22h1Wbc+kvrVRj8RqpRFv4slJTBBjXKYYJgmLJRBJ4bZaDHiMOZKPzIEpVDPgtPA7GarWz0SCYB8vyuqmb2NzWKWI0SKkiEuCP30dAAMwt4d4985PEDJO7VGcvQEMd3T/S5s9Z1QbnHm9CCU5NpKUDd9sTY7/MyEPdiU0aV5njQ==
Received: from BN0PR04CA0099.namprd04.prod.outlook.com (2603:10b6:408:ec::14)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 21:18:23 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:408:ec:cafe::61) by BN0PR04CA0099.outlook.office365.com
 (2603:10b6:408:ec::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25 via Frontend
 Transport; Wed, 1 Feb 2023 21:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.17 via Frontend Transport; Wed, 1 Feb 2023 21:18:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 13:18:05 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 13:18:05 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 13:18:04 -0800
Date:   Wed, 1 Feb 2023 13:18:03 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9rW01eROepZuMt3@Asurada-Nvidia>
References: <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com>
 <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com>
 <Y9oNSUbDe1YOTj+b@Asurada-Nvidia>
 <Y9qK3nJHjU4Bvxaf@nvidia.com>
 <Y9qlb0SZWEpJs0v1@Asurada-Nvidia>
 <Y9qxdinaS6anoWhH@nvidia.com>
 <Y9q8llC0JVokHLf7@Asurada-Nvidia>
 <Y9rE6L8Nr0xShiKy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9rE6L8Nr0xShiKy@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1842be-9f52-4820-5e97-08db0499d987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fy130gaACuWk5B6MBs8E/8JMOXct63qoZ6FZbpSw7RS8rOOtOhZ01UMvFdnfMJcVbz2cZkbS0uevk2EdWYp6hLuqerDCq/+PppSlInj0m1N4loIE1Ol3GRlwaXgREvQ7rV4XUZe5SFSWsKGgi7frD7Do4ni+1Ch3ViAdZWEtge9P7RetdwXXO12KPMO6uyBdCCKiH6MOrfxsdOeLYKKkwNdLm2YgDN339nd41raXAMzfZhyxlXMTpqqaZqdp31o2z4rUMruqIqEJUDpzGWBQYCAKrDIsEatgMgpWfOwbTJOfMpb+fRYSanOFKHaeOaGB9jF54JnE46ejn+l4E08MNd8eh36tz2XhF5PjMOcoljhuwWrdsHkx5ZGiS+NJrV4PTWuibdGmFk36N1tFqUfRjsrBBzU80ImTgqdh0MhK+QMQ4q6RuGpHqzjL4IDPOjOeWwHStCEygJmuWtPTuk8mqP8tsPdyuI1GWu/pPkuP4bfh69gkKaI2sgqMZTLfZt58knOSkFP8ZxWc8r/luMtYe4UP3Z74HDuFnaeNKoA0Mo+4tAsVOszOn5c7VvScfxGYZn48F9mi1TxkGkC/ZkRLn2s5qLohyDstKjfDe8zmdbFJtqPEfI64Z0ALUKmfi/ciTFo2H+eOjQXGvlMUYi5Av7Lh8UvZqsnx43G7idwATA86tueA3OUyKghqifMq0S3vW7oXWf8Dwl3vRgybm5s5LA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(70586007)(5660300002)(8936002)(40480700001)(41300700001)(7636003)(70206006)(336012)(36860700001)(82740400003)(33716001)(82310400005)(4326008)(6862004)(8676002)(55016003)(478600001)(186003)(356005)(26005)(40460700003)(2906002)(47076005)(426003)(83380400001)(9686003)(316002)(86362001)(54906003)(6636002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 21:18:22.6904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1842be-9f52-4820-5e97-08db0499d987
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:00:40PM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 01, 2023 at 11:25:10AM -0800, Nicolin Chen wrote:
> 
> > The "finalise" is one of the very first lines of the attach_dev()
> > callback function in SMMU driver, though it might still undesirably
> > fail the replace().
> 
> It won't get that far.
> 
> Remember how this all works - only autodomains have the special path
> that allocates a domain, attaches the empty domain, and then populates
> it with the ioas. We made this special path specifically to accomodate
> the current ARM drivers, otherwise they wouldn't work at all.

Yes.

> replace can't do this - replace must always start out with a
> pre-existing hwpt that was allocated with a dedicated hwpt allocation
> ioctl.
> 
> Wwhen the hwpt was allocated it must be linked to the IOAS at that
> time, because we definately don't do defered IOAS linkage.
>
> So on ARM when you create an unfinalizes iommu_domain it cannot be
> added to the IOAS (because it has an empty aperture) and creation will
> fail, or worse, it will get added to an empty IOAS and make the IOAS
> permanently unusable.

IIUIC, user space might add some IOVA mappings to the hwpt/iopt,
before doing a replace(). If we do a deferred IOAS linkage to
this hwpt/iopt, it will cause a problem because we are adding
the reserved region for the MSI window later than IOMMU_IOAS_MAP
calls. Thus, "we definately don't do defered IOAS linkage".

With this justification, I think I should include my patch of
moving iopt_table_add/remove_domain(), in the replace series.

> > Hmm...in that case, we should hold two ioas->mutex locks in
> > addition to two device locks?
> 
> No, the device lock is the thing that protects the data you are
> touching no reason to make it any different.

Thinking it deeper: we don't really touch the old_hwpt->ioas or
its iopt, but only the new_hwpt->ioas/iopt to reserve the MSI
window, so there isn't an actual need to hold old_hwpt->ioas's
mutex.

I will prepare the replace series and send it by the end of the
day, upon certain level of sanity/verification.

Thanks!
Nic
