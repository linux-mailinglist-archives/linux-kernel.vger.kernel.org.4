Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA236B56BC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjCKA1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjCKA1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:27:22 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0438613FF14
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:25:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haJrIw2q9GZq6CPXPRSMQmL+qjmo9jKQHZ1wXw7/YtPyb1b10d42cRwh/1ZBTymmljuI6+TiazRMVbypHVOryx5ZAeeyFgOo4bEXZZgioSbssrDHffNdOSsF1JISVurxDt/6G8YJ4x22n1iG0Cwrncp0HgN7MgQSodzHQRZW6k+MbdKJcCjFg/4EOxbWXWsHNgwFo5mkAFYfD1kHhR6A/yRGAdgrjtOnzzZ81FA6o0Y1BCKTWogKfRZEc/bDXTLrsy99kaxdkIkMW8T618oDLTL8NUauuPsLPYiUYFYSjmswyrbOJxc+8rnmpA5gol7PyXBhUFqSgfHc3X5eKUSY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUFFFAuR1QTyqIhB3kNEYP/nCU/qllnv2yLIACLXRi0=;
 b=FpRfTWwD6mv2G7gisEKzJbd2KT9yXFweqwS3siRIIA3/QCPwg3AIQPZMKpptX5JnwQPZAXkEvkfB0Ecs+sTf7D+eZEMxEmzk5YTPatCJGBwBjXbD5e/MOco53xgXtURewwFjvRkKoA82gI/S2ukpRFbh5JQFhHye1rVl4JyjNVeh8su1oUdFVHY/mm71JXMWPuvsBk7fyV+3wBqnJWvMLyvU7OhUCcCoMynD5KMH8JXub8bq6aGYys6nZA03KIFEUVMmIbz2bYXU9uSsx9V0+b/nRWiVVuRyL9//lVNSEivtw3ixaZRxSfPkb1AZa9UuvBwf7h2oh0y2qsCXFgk5oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUFFFAuR1QTyqIhB3kNEYP/nCU/qllnv2yLIACLXRi0=;
 b=uEW0cpNLvwyYKkfQ+nyPXfJ4jjsktVWc0S5jf2ZJyNlgUO74DuL9EGMSEBlCY1hAibo/lNltA7RWE+FEv2aej6eviqaiu/XVqIAKJkVYgrSAuORaPb9huPHsl76V2EoATmU7EVpMYAVJ5sbUU65cXufMP514Q3ltOmf+oSexb7Ikqja9xkNGugXjE+C4io+9wxPXnjYYfwbymD6XZ+mTrQmp1EV3hCSgnW4hiXsJvx8LevPD+j3FJrR6k7FR5mO9mRHrSIkGEu4i9yJm2qqi0e5SiO1y1rcMq7kzxB93dpElsNOs9J99Z/rRisSondwGk+GAh9Cr4mzw5nxgL48kOA==
Received: from MW4PR04CA0330.namprd04.prod.outlook.com (2603:10b6:303:82::35)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sat, 11 Mar
 2023 00:24:23 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::c4) by MW4PR04CA0330.outlook.office365.com
 (2603:10b6:303:82::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Sat, 11 Mar 2023 00:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20 via Frontend Transport; Sat, 11 Mar 2023 00:24:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 16:24:22 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 10 Mar 2023 16:24:22 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 10 Mar 2023 16:24:21 -0800
Date:   Fri, 10 Mar 2023 16:24:20 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Eric Auger <eric.auger@redhat.com>, <robin.murphy@arm.com>,
        <will@kernel.org>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 05/14] iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
Message-ID: <ZAvKNHy+B/Xe2Smf@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <c62c9405ff31ab3c97a9165ff710dce68217fe22.1678348754.git.nicolinc@nvidia.com>
 <1c18d68c-a20d-0f6d-4bf7-56f40557d151@redhat.com>
 <ZAtjYFMio7t66KWy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAtjYFMio7t66KWy@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c26e3b7-1ab0-4acf-7b05-08db21c6f6da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McEWbIXm6fjJ1D5odT17d1XCbCysL/1q1j94SU1u1j8svsllmOseQkmce4Iuk48yDeZ3M/AjHNxqxjLTG7GTfZg2UDzAgW9aMrYKH1fn1p+wlKPQmMJ3Ma6FTkL7Q7Yv/D02r959GBHJt0I4km9tQkaCO0pFroVFkFexPtGqx3hSMUGJz2wg0vdh+ZsS1m5veJexOSU268ZlSe8o+dzd1T9/+yCSL5htwuBZKSKVDPVymsGo9AaQ9dD2+HzQ4r0wTy9fKoB1CugCnO8cKDHiBTPhGF6DEFCnl1m+iN/OvHGWncVdAT6btZaqsGtMUUduQNfXllpQ3Os+hx+mz3JdVv3umkeGrIgMTNpNLd5QYwge3qHQhWTu0QJ5VLI7uggjo7AQhdz2DIAJni36Nmi4gSR+QJ4q1VV/bB5HEqVxGdJDHE5+xT3ZuvW2T93fa+H+FBu9wlQT/MgSyuxN/42Hav7iHNGfxS8zuN45HhY2XX8Ed561pthkngAYU6xgkpWs9NwOYsbTbC0JZWz+6IBD5DM9Yp0hKp6wDUl02eCVfG+lnoioPItc0JS45fXjh3q0IhCrXyK8vGa9XEpf31qOgTxUQPUpdF/nXmwzH+TYhzw1FyiuQt24o6NYDVkpU5ZTNhnfGpSlmjxEylLsSnFpruhoN4R8UmDG9Jl4bPlEVMbg60oO5ad7GzfkR+C4OxqCPIY/Vkq2FoV2RzkfqoUaOTcwPNTbdLTYw0ybLgtxbsat8jpnfJR/LnprXctLdzAtTQC0sfUader4cTHVG+JQzfNp14jfiiJmyEmk3C+E5WA=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(36840700001)(46966006)(40470700004)(70586007)(70206006)(8676002)(4326008)(36860700001)(82740400003)(426003)(47076005)(82310400005)(336012)(41300700001)(7636003)(33716001)(316002)(966005)(6862004)(186003)(26005)(6636002)(54906003)(9686003)(356005)(40460700003)(4744005)(7416002)(478600001)(8936002)(40480700001)(55016003)(5660300002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 00:24:23.0874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c26e3b7-1ab0-4acf-7b05-08db21c6f6da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 01:05:36PM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 10, 2023 at 05:39:22PM +0100, Eric Auger wrote:
> 
> > > Also drop the unused arm_smmu_enable_nesting(). One following patche will
> > > configure the correct smmu_domain->stage.
> > >
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ------------------
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
> > If you go this way you may also remove it from arm/arm-smmu/arm-smmu.c.
> > Then if I am not wrong no other driver does implement enable_nesting cb.
> > Shouldn't we also remove it and fellow iommu_enable_nesting()?
> 
> Yes, lets just put this patch in the series please:
> 
> https://lore.kernel.org/kvm/0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com/

Oh. Didn't read this before sending my previous reply..

Will do that.

Nic
