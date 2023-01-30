Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E857B681A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbjA3T2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbjA3T2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:28:05 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1181A269D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:27:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ9mxGb1efmiaDJy/7xg3EodDHaZk9pjGiisotlXD2yqLGPSfsEfUZxulNLpFe15CziKziSTQl8XvXfcb0xrG7xv1zDVdfHfJU/tsXXB8MwpwTPxWm9dowFBchpj9R0GDgrWxnBFIdA7ojz7kYM2d4S3uuda1YvbCqDXm/SVVnRZEw9ACnPLIRk57nhd6gme3b7MqQCpHMsfECOJZT8fyiECT4bmx2gxAjdiMx/EjBi6hHLnvqjQPcSO/sUm7Qt7hac92fFrLclfdlWhVxXB9BniuaC26MaFk/6+xls4qawIa9ECJgeuJUtq8yF9ztmFYiJJWIwNRUsO0kiYwYapVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/nHW6O8NByM+fBYztB6vrC4vDIXFvyzsgihmCDejWA=;
 b=jCqyd6URn3Cbdiuo+/2bgegwcm28oZBOhIcmaBvCaMMUw0/Mf8lAWKR8ExQ9ymQpA3av27dtgWv3wtYMxodr3AVUydiMXqlCyrfEFBYt6iGuLhTG32QHh4dyGQEeEAb18hy6M8XcSJQVqpETT9QdV+yDrA/BTyiVzD8oExIv7gy6EsZ7v5p6+ekjJNdQIcREmr4pgQ4m7tR/FH8vLTGNEz03DQ2iUBXu0Ug4/zZHDCwNqlzwFJqxba2JY/lOL58s5LnwCI+q6KiFhHaas4ZmrsCwQ3nYLVHc7gSLjo4cBIDVYbrtBAXoiwK91Rp6vM1HloZn8hdZZrd3lfLkMwzgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/nHW6O8NByM+fBYztB6vrC4vDIXFvyzsgihmCDejWA=;
 b=IUNemRtm/T7p7vyY3Phw7IdTIM+AMG2dA39iIP5zoiTQ9Sh5Zj5j6RKGk475mX8bM7ot6GsdfOQqR79J4WXat1ddOHwupKNrPH2UkSnIf5oCNXsJYkCUOr4z5Wy6rQMCqdqrLSQzhUZ92l/JEe3EgkUURLy8beUpP+hK2XVaYod7ik9dWV9tlffC2tYANpeGtMQpvB4wAoJKqLulL77LOE0eqQyalCrPL9buk1gfJZ9L9F3xdCGqjqDcFe8Zl4TkZEo4PS530MUsHJTq3orI+VXR+pHAYlx5RdGtPcBB/90koMsLdH6pOtY87WcH0pTtDFTthODo/lTSwOhe/WdVnA==
Received: from DM6PR07CA0114.namprd07.prod.outlook.com (2603:10b6:5:330::29)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 19:27:52 +0000
Received: from DS1PEPF0000E652.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::e0) by DM6PR07CA0114.outlook.office365.com
 (2603:10b6:5:330::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 19:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E652.mail.protection.outlook.com (10.167.18.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.17 via Frontend Transport; Mon, 30 Jan 2023 19:27:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 11:27:39 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 11:27:39 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 30 Jan 2023 11:27:39 -0800
Date:   Mon, 30 Jan 2023 11:27:37 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9fcAdFxl7GVSH9r@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E652:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 547f455d-87d9-417e-b7d7-08db02f8145d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6HxSqoNc6a/jqWscc5DpCluDGfflG0rL217prJRoGUQVq7uN14LmyuCALlHCRogQkVPSw9yjAaj+5dJkM1A1J1wmpWkcT6d7dYA8/jC3oWgeecXFCio1I3PauSSqUJL6U8yxYiXnfgoeVZhGUPRe1bDNTqAtIzmX9ZvYbPGso2YvhpT+LXvlixumxk7ChYCnr6pbRiwB4bJ0Mb46IKlUiwxu3n0Lt5C5sGDuca3I+GHhr1BJb/2Kh4O8tm/PobhTmeiBuxxcmqjAR6QrVo4hs0kID205Hct53OnX6d3qcyMoJ5Hvy14HORdDqyPto7flbCc+ksuKEwBesNSLUxLA0D8Ad5I4mcADvLnn3iUH1tTqHEyQ+SQLQ7rww9JKgYSxUmTSvMrYrIAy9xGeTdfHBo/8kzh5AVC26pYU5TiCAfyr8DN2fS0YP4mffHhpiqvSmo98XZHmhgDKa0y2mS7p6q/v66re8nSK641rC/vwgcLOVoXBuXHceYE/1+LDJAMqirly2VKr5sPqLZIJZRYMcw8DI1zu6RHARopPeIrSjOBtGIxZp+gqrSyZ5jBQmX4zDiDNWIMjXsdX6KoCG4nzd9tamB+uRbxtWgn7Y9cUFfwKlJLA58ObVtRFPIMss+419+wD7nx2sbb4gPfVnRGWeQJDYwlviN9DZ3D+YbdZ94HaKO94HlO3y9pCWiQb9rVciXIY7Enm2ojdKPHqM+UjsUUfiRPpgyH6mLELZfqpe/w=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(2906002)(5660300002)(40480700001)(82740400003)(55016003)(186003)(26005)(9686003)(36860700001)(47076005)(7636003)(83380400001)(336012)(426003)(4326008)(86362001)(70206006)(8676002)(6862004)(316002)(41300700001)(6636002)(54906003)(8936002)(70586007)(40460700003)(478600001)(356005)(33716001)(82310400005)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 19:27:51.8325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 547f455d-87d9-417e-b7d7-08db02f8145d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E652.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:02:25AM -0400, Jason Gunthorpe wrote:
> On Sat, Jan 28, 2023 at 01:18:09PM -0800, Nicolin Chen wrote:
> > From: Yi Liu <yi.l.liu@intel.com>
> > 
> > Currently, hw_pagetable tracks the attached devices using a device list.
> > When attaching the first device to the kernel-managed hw_pagetable, it
> > should be linked to IOAS. When detaching the last device from this hwpt,
> > the link with IOAS should be removed too. And this first-or-last device
> > check is done with list_empty(hwpt->devices).
> > 
> > However, with a nested configuration, when a device is attached to the
> > user-managed stage-1 hw_pagetable, it will be added to this user-managed
> > hwpt's device list instead of the kernel-managed stage-2 hwpt's one. And
> > this breaks the logic for a kernel-managed hw_pagetable link/disconnect
> > to/from IOAS/IOPT. e.g. the stage-2 hw_pagetable would be linked to IOAS
> > multiple times if multiple device is attached, but it will become empty
> > as soon as one device detached.
> 
> Why this seems really weird to say.
> 
> The stage 2 is linked explicitly to the IOAS that drives it's
> map/unmap
> 
> Why is there any implicit activity here? There should be no implicit
> attach of the S2 to an IOAS ever.

I think this is supposed to say the following use case:

Two stage-1 hwpts share the same parent s2_hwpt:

attach device1 to stage-1 hwpt1:
	...
	if (list_empty(s1_hwpt1->devices))		// empty; true
		iopt_table_add_domain(s2_hwpt->domain); // do once
	s1_hwpt1 device list cnt++;
	...

attach device2 to stage-1 hwpt2:
	...
	if (list_empty(s1_hwpt2->devices))		// empty; true
		iopt_table_add_domain(s2_hwpt->domain); // do again
	s1_hwpt2 device list cnt++;
	...

This is because each hwpt has its own device list. To prevent
the duplicated iopt_table_add_domain call, we need to check all
the device list. So this patch adds a shared list among all
relevant hwpts.

I can revise the commit message to make a better sense.

Thanks
Nicolin
