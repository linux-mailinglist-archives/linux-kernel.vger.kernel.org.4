Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D510B6B5640
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCKARz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCKARx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:17:53 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E552F135960
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:17:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQIF25NDSGDLgiLIXN8XC7/9OjM5rJw9S/U4rEEQy4q9BgmZAQVJLKI17Pfhccg9b2Cy58rUkDzCAm10tXregMXi2rdrt9GoMBuuPAQENsqSiMCyK/EsBXqxJQxCIU35VpZp4RVOkgVrZyPOazQR5dLhuhQpfJGrQfNrfZ3mCm1LoBCyb6ooBzBbPXelVn+5r8MrnY5Sk9I+tUzNMXdmTtQDaWlwjF1P9DFw8coy3IoBkePnf8ZSH3iC7plHf4bl9BTu65BhL5XkzooOHnsY7fh14e9et+CyNeh08PvuJBGmDJJDJ5zEe7ebLwzy/C5YZSSNUDDixBs4jsjZZJ8rMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l9nRlxvauMZwdn5YO5yYioP7I3aDQZd7VF5cXKw1sU=;
 b=K9NWT+SQLMjl2bHo5rRLOFROB85lRMjCT/i491BZUGCO1sHGk/g9j1jkJ924+ljBwm1C7r+qMWcdXoaR7iky+shyKLTorSd1Y6JOi/DWuwgHabehnU7VwSPMhAFKyWaKmcWhH76YESu9maDkSo1dNQ0JYNhmQdNOudx2OaieZg4ltakEK5M9ekS8AYn30O3YIb3WFspcfGFPBNR/dFWJVLhSUovtIg4dZoo/mmVPGg0pF803NLXiI7fJn0pypkmPvIzDoxIeWrsGGatBuJ2lMjDNAMcgJUvd7drKjAGTbydoG/rd/eBfxCFYVmWajwA37jp7A/3nHP7V8F70qFV/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l9nRlxvauMZwdn5YO5yYioP7I3aDQZd7VF5cXKw1sU=;
 b=IG+VQk2vJpXhB9xfdNQ3cilfWdVFsB+RpYumKoqvMBp7oGVLqxRx0JFBvagLlo5P0R9xuXp4+BCKQHbnXpQrRhrqW3eLmUZ0BNMrb9fGR6iqpVBz5uazziSKSBtEa6/ltH0YTMQI8Bc1UyssLFwyDUvkF3OaEZb6SBEd+hluYkT3D1SEAwOAUGVpDpl4jgmyzVsCpL7LmwMMHEE/Xu6RijLkJvTR9nvmUVFIRG1rcKAI2pZStwJvjsrjBW1E2ks+CMDHB3DkkZuWF0LThdBxNYK+RCjMtZ2KUUrvgi5+QBtvnLg/cE0SGbHe7jLychPOHitG4XiZ5aVHjTaBuU6oMw==
Received: from MW4PR04CA0294.namprd04.prod.outlook.com (2603:10b6:303:89::29)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Sat, 11 Mar
 2023 00:17:49 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::c0) by MW4PR04CA0294.outlook.office365.com
 (2603:10b6:303:89::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Sat, 11 Mar 2023 00:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.22 via Frontend Transport; Sat, 11 Mar 2023 00:17:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 16:17:42 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 16:17:41 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 16:17:40 -0800
Date:   Fri, 10 Mar 2023 16:17:39 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
CC:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 03/14] iommufd/device: Setup MSI on kernel-managed
 domains
Message-ID: <ZAvIo8P8SAZt9hOV@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <5149b7e711a46e81aea8515676cf0e45608b3afd.1678348754.git.nicolinc@nvidia.com>
 <919e32d5-26ef-7327-e25f-565967c94e6a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <919e32d5-26ef-7327-e25f-565967c94e6a@redhat.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cce3e22-7d6f-429f-dfca-08db21c60bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDHwpRaaeVDQls/5z01pN2J8SPXR5cWzaFNPw124luFq+InbPu768XkxQNrO3kSVV208rumpuZ735WBn/s8/8d/XdrxZMZAV0TX3CwiLNAf1X+WJlsFmztMtwLtVN9qpEdlc6C+XvQIlzG/CtqUxmTYp5ZWqjO/PMANAeKDG5tMOKYfoY4andN/hWTWFmATfM6e+9MA1nI4RdI/39gb+wwE8J0kZi1F6rMmeDVqHRMCwJC0Qp04i+6yg48IqxngmWf9VjW/cdcd6m1QsMcj6GerwkQVBDxYt7942bcwScyOmJ86OyFXC7BfiZQrB4cbvNGx+4+tjWYcj4DnhyaOsOP1oVwL8/1w0344K+Htg748aIqrah/YJGwfY2rVdTBshlolm09CFBEvBKY9Vn671Jy+s4tSM4vl1X9OjE5RTNWeqxMw3gd/v/O4cey7G+7Bu8ob5OneurXl9gO4yFq5FZ8MoBgLFChMLeH3l79ouULUKHioAGJu948t2gbvOTEOoBipCdpC8HOHU7uFRF+G6gPqmA7Di9mAAFO9ND8TZfjHJcVYnCRLGC2s2SCKzJw0abUgttUt1nDTsjNVXbb7k8q+a63+UqGL8px3Qu8DYXC/FUTx7n1lKr0/+rvwlkQQE9GWJXPWTs9P44sBhCh/diKvYfXY5NTGwa6K2mA0AvURbV4w4rJPR9fmTOKFYjk5V2mIHsYadGogM2tpJuzsvZq71ROAL+7AeeVf79SjYD38=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199018)(36840700001)(46966006)(53546011)(316002)(54906003)(478600001)(7416002)(2906002)(5660300002)(70586007)(70206006)(8676002)(4326008)(6916009)(8936002)(41300700001)(26005)(7636003)(36860700001)(55016003)(356005)(40480700001)(86362001)(33716001)(82740400003)(9686003)(186003)(82310400005)(83380400001)(47076005)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 00:17:49.0286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cce3e22-7d6f-429f-dfca-08db21c60bf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 05:45:20PM +0100, Eric Auger wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Nicolin,
> 
> On 3/9/23 11:53, Nicolin Chen wrote:
> > The IOMMU_RESV_SW_MSI is a kernel-managed domain thing. So, it should be
> > only setup on a kernel-managed domain only. If the attaching domain is a
> > user-managed domain, redirect the hwpt to hwpt->parent to do it correctly.
> >
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/device.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > index f95b558f5e95..a3e7d2889164 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -350,7 +350,8 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
> >        * call iommu_get_msi_cookie() on its behalf. This is necessary to setup
> >        * the MSI window so iommu_dma_prepare_msi() can install pages into our
> >        * domain after request_irq(). If it is not done interrupts will not
> > -      * work on this domain.
> > +      * work on this domain. And the msi_cookie should be always set into the
> s/And the/The/

OK.

> > +      * kernel-managed (parent) domain.
> >        *
> >        * FIXME: This is conceptually broken for iommufd since we want to allow
> >        * userspace to change the domains, eg switch from an identity IOAS to a
> > @@ -358,6 +359,8 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
> >        * matches what the IRQ layer actually expects in a newly created
> >        * domain.
> >        */
> > +     if (hwpt->parent)
> > +             hwpt = hwpt->parent;
> I guess there is a garantee the parent hwpt is necessarily a
> kernel-managed domain?

Yes. It must be.

> Is it that part of the spec that enforces it?

The hwpt_alloc() function has a sanity to enforce that.

> IOMMU_HWPT_ALLOC doc says:
> " * A user-managed HWPT will be created from a given parent HWPT via
> @pt_id, in
>  * which the parent HWPT must be allocated previously via the same ioctl
> from a
>  * given IOAS.
> "
> Maybe precise that in the commit msg?

There is a paragraph just above that, for kernel-managed HWPT:

455  * A normal HWPT will be created with the mappings from the given IOAS.
456  * The @data_type for its allocation can be set to IOMMU_HWPT_TYPE_DEFAULT, or
457  * another type (being listed below) to specialize a kernel-managed HWPT.

Perhaps we could rephrase "normal HWPT" with "kernel-managed
HWPT", to make it more clear.

Thanks
Nic
