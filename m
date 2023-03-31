Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07006D16A4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 07:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCaFKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 01:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCaFKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 01:10:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03989C174;
        Thu, 30 Mar 2023 22:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbBOcPBp08Hnw7SEgxCgi0j1p7m0VMqJDMuh9TkfBEj9+ivbyW991kzpmwHODUVPyIuT481n2921sUMdye1m9jJC/IVK6i9Nn4OimEpomqjVDAAl9CoP1VOKVWn7YdQDOnsiCU3UMVoZvOjnWEQWyNolbqbTd5VyqMf+m/tRhV+xXYLoXf30COBrg/HkKwHs7/C2beio+Zcm7jvttsxA3cFtZONKYx7bd1onvOrEDL8D8bBFKrf61qNiVMKrRzzATpI8weChQxwXZGbEpbiUKT8U8laUt5i9/m3ZdoF7u7swOkdycgIHOimu5n+ymv4RsspJ6+8jwVegoU2+pf5c3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQcANJFv8fgZHAZ//E1qVFAOhRGz0KVUhDrWKAEjSx0=;
 b=SlfiCjZ/kej0hcv5uPr+7LzJB3qse2ReJs3LYoXRn17Gs2bL62SMAe2vQwJ9dbjIwLh+CYY7YekK9GQrKCLBbGikNxQNyQ8d9WbxSwHSLXNNOLV6SjCjexPP370sBtk68biDBSEE3s1ekWgUJI1zBHNYnFuaYQwjrSGpSiJYRJW9a5vDPcTnMSGYlmJo0DdNkVDH12kO91+7saAbHGx9enB9T41jKz5W9pYJ/DgUX27yxE8k+4fwx1cEcBp9kfbYkB4tfRVsGMzq7gHl8H2uobH6MpCgAUOrJYlrvWGFTRas0aJzWX42sV0G1yS7NBVfr/avxEuaSPQfijC9IAZppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=canb.auug.org.au smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQcANJFv8fgZHAZ//E1qVFAOhRGz0KVUhDrWKAEjSx0=;
 b=D9XsdIURJpYSHgImllqlfpIFe237Nuf60vPKh7VX7ezQZaRA6ImKoz6r0Zvpm7E/VLWCsID01eJVaWqxRbvQMUtN5cNmC8w5MfQIEKunhemXwbwqOykhDaUWUD+RUf+ZEdUz81PsxZaSdkj3HUq3NfnEIMpdUmE9wN0K+gqgBXaSV+lo+t+VDnggGwyKlfKMvo2JzUE2JHA8k9HrjXGa1QXUWdY5xgT7Wn7bGEW4z1CaF1O1TSx9IOM5h3H18gW0gtdy9zthg1KD8+lpwuAs3UH/lOwbaMErrXDsadz9nTNQEietMvL53vx+1GJWmNgflwDkhTG1cenHW3iBdUGbQA==
Received: from BL0PR0102CA0031.prod.exchangelabs.com (2603:10b6:207:18::44) by
 IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 05:09:57 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:207:18:cafe::bb) by BL0PR0102CA0031.outlook.office365.com
 (2603:10b6:207:18::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 05:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Fri, 31 Mar 2023 05:09:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 22:09:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 22:09:39 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 30 Mar 2023 22:09:39 -0700
Date:   Thu, 30 Mar 2023 22:09:38 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the iommufd tree
Message-ID: <ZCZrEtNH5YjGjRqS@Asurada-Nvidia>
References: <20230331153146.478c4d56@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230331153146.478c4d56@canb.auug.org.au>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 103f5d15-2ad8-4664-bce3-08db31a62ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TnGCWrl56Vrp9+R5rhV6wOyUf8sPtlBOn00q4cKIh+jap7AHbe7dicI/OliN9kLHxwroWfVKyJm2vwzsgPYHQ5C370r3SQoJRTaxTidrIs+qZC7Q/GjypTcKdAkuh/9ibLtF+gnsxAZr6ltyn2jnOwu/l5fDKrGv21x/GWpG2E1RJ1Suv1jt/gwu7zv5O/FuG+tLmbnj/dFm7r2CdJ14G9ZsvE81zqarhrM023a9U98B4O3B9N6u9CXhzOtSc4pHgeMGj1TSqPN+2w6dMIkQ49JROcRtZHeZyzY3VHg6uRrcX1gDvB40wZBjkHH5CLKFxGHua87D+1gY4c419knHQCV4rj4j/jSDnYSa7CsZd19PFc4V0Vj0A+bYoov6hmHz4qGY7WCZpvZyAiKOLfhXkD2mRskJ3GkamxoZE16P5lEg5c8fWTT7zT9UUi86WD/vKZ5H/6dFPmtzq5HSsCvya8SbPK0Jd3A6qzRjkCfthuZoLcvtUMlm6xqnxuHIpbwsKOtyuCq3oXix5eSgrICAveCWkXetLn2xaEXtVJ/mkbOujbx3SjmabBbn6iHBjDpTooVmnaBUNntibQytqv+4DyeWwPOoWdYMYKcsWk7wTM5zSHeSp4fjkgFZNKMnYUeXVJqeLqRs+sbhRQkyJ6wmhKq9sY5g39Ti49CzTMfERLFB90tJOjBV2JZMkP48vj5y2NiTKYND55OvFZUR39ld1Guh2hYKYil/AVlA6pDMx0I5T5mJalxvGViE+XPFmYdZ
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(33716001)(82740400003)(336012)(86362001)(426003)(47076005)(9686003)(4744005)(83380400001)(82310400005)(5660300002)(186003)(26005)(7636003)(356005)(8936002)(2906002)(36860700001)(70586007)(41300700001)(40460700003)(55016003)(40480700001)(4326008)(110136005)(54906003)(316002)(70206006)(478600001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 05:09:56.7443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 103f5d15-2ad8-4664-bce3-08db31a62ba2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reporting.

On Fri, Mar 31, 2023 at 03:31:46PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the iommufd tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> drivers/iommu/iommufd/device.c:674: warning: Excess function parameter 'ioas_id' description in 'iommufd_access_create'
> 
> Introduced by commits
> 
>   7540af571dc7 ("iommufd: Create access in vfio_iommufd_emulated_bind()")

Should have dropped that line from kdoc in this commit.

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index fca09bb4e839..d791ab5830b4 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -795,7 +795,6 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
 /**
  * iommufd_access_create - Create an iommufd_access
  * @ictx: iommufd file descriptor
- * @ioas_id: ID for a IOMMUFD_OBJ_IOAS
  * @ops: Driver's ops to associate with the access
  * @data: Opaque data to pass into ops functions
  *
