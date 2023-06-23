Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670EA73ADC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjFWAcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFWAcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:32:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB478170E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6lFJGsBZlzl4FiRYFo8Bk+OIoWmgC8yd8bualQ5/iK0lrDZSlHvWBlmLQMXo0O0Zt5VIP1uQqQhOqP0OTBX2Ignwrrv8pElN6CNry9k1uPQJPy1SZpNgarTQ5NIOA27wKBJttOfdEJRHLKnKneSxeDUO/Owd5YA7SPkYPgu7cLWS8f2I0BIQ2jsYE6tX1XcGnDCC0SwUkuMf6NAxH5aihcxDP0FkagbAP8pLVCQbMwUVT9LoTr1D2pGNZkuIZVC/exLzu5S5z5Z4wiusZO2Q/jkF1kRahiv4hJw+mhzaU9NkuxA30b+SMgPwqVLFvS9mXJR+tKRP/8ho0x/dDynnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g4I1EnGnN08rF0MRL4QHgbkSc6ZMYeMVLJlPa8k4Rg=;
 b=IprwPmnFWCyY0zw5d4gebMhWQESGyq5+x1VqlujArA9e4gRlW1NqkeX6xPvwrcwAr/8AcuPYK3ztTNpjhWdOzpJBtURkeu5DMAD0iF88nWRWUD8KcyxquZDCvIRED0DyWZs9usYR7qzyEblDVXULgGa7NmAHvTOxY89ao3iI1sVgd1drbVxsuOI/RDWeKM6Mi6fEG2xU8u2nEi+1i05kYv28uWw5fln5ulRPUWZnyomolJ/PQALZg1d/F+dPGbT2S6Rpkfn9BgZLxO1B+F9y0Syf7QHfbloxaBTqbgnJYOEKiXnlOUSphmBjKdmIpj2KA+l1xmSO7eopiGeQ6NJedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g4I1EnGnN08rF0MRL4QHgbkSc6ZMYeMVLJlPa8k4Rg=;
 b=t4KkYschy/0hXra5UKMABxt9p/IKtCCdWZdq9JyvKbegy7Fuh2S03uxm//KQa0gjk0yzGmL7GsYe/v65br+Nqrxu9lJZYlKkZRorGeWlOHbQ2CnaRtBoaZYYjhkqRQnNnkIgMWho3OnN/xiZsmClP4MQ7QGOM6E7uW+69hzFgCVxc1UTpOutZkV/cCDBGJrBcJX9isiiziCfsan3tF/sq4EWu8JSK1TAKIfnJ1QDE2o/MZP4Jo2Dr5BdKI4jI8rOnSDF/HZvmx526QA3Yl9aQOpkOylNr3GNtwWO0G7telz8M6/NqsjjVXhJq5nxIPyzsJ7/6nMsw3uZWa3usAVHvA==
Received: from BYAPR11CA0073.namprd11.prod.outlook.com (2603:10b6:a03:f4::14)
 by CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 00:32:13 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:f4:cafe::6d) by BYAPR11CA0073.outlook.office365.com
 (2603:10b6:a03:f4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 00:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.42 via Frontend Transport; Fri, 23 Jun 2023 00:32:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 17:32:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 22 Jun 2023 17:32:03 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 22 Jun 2023 17:32:03 -0700
Date:   Thu, 22 Jun 2023 17:32:01 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/13] iommu/arm-smmu-v3: Implement set_dev_pasid
Message-ID: <ZJToAfeKg8FF1sZL@Asurada-Nvidia>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-10-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230621063825.268890-10-mshavit@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|CYYPR12MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d795f26-8be1-4ef4-7555-08db738149ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SE3dLywWCi0OJj93bEVQIOE0+iHak2nYPc1VNhMrMrJzVLXbkIX9LiZ4y+sYV0fw/LHhL4XY97BekvpPvZo0X2sktMoIT0X65BNhCZrfEnZv1kEKd42vX3qU54ZNkk1LUFzjdzSDTCFYl0i1m5dicd5+gNGmrqTHPQMJ/W8Uo804sRfxAfmUabImH0T9FI4gE0q8bD7NnHc4jLAk5PE0TBIeS/7rkcxgT6FmGROPq4t5v8U3VoLUu37HA/xuweb7YbcBG+nLUey1w2TYhO9yOGx6ho2EmzMmj/eyyWRFO5xPY4g6S3clHo0AcrVQDtaRLyOzXgLqDIpIk2nWZe1HOyp6RUxjPy0Rrm0+4Oukq7D0MSN6UdD56Cuf8x33EId6rsja2y9N6laH2EqEmctmdsNGCQl7YxlcWJMipTd3YgQMDpo0Nl5kSWvINcWnT5PMB13lf9el1FwQOpUBxljzVFevlU4UiP4T1ubIglcPyuWWDWWqWtgZkq3pVLrPRffyFqc5zoJQnb9IzO728QF1S9trVymocqXybtNwWpPN+CRFv5ZukDUChNQIWGNvTLvz8Rt9zG8VggE38ZKCrMKZNhjsO1gXIpBzkEP3RsxwITmPVt5J8k+ThfLdpgYKgiBEYy4TcyGgCyKAP8LtDiNZntPs/RFJ06KiZ6rCRAC8chw1VgxC62AdsuwF/5FxgEoBRzwf+hX0q4OQvYvHtCiEhpdSl89vVmAlztwbqP3Ce78Baklo2wv1vjrBc/MrJQPt
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(47076005)(5660300002)(4744005)(2906002)(26005)(8676002)(8936002)(186003)(9686003)(40460700003)(41300700001)(36860700001)(336012)(426003)(356005)(82310400005)(478600001)(82740400003)(7636003)(55016003)(86362001)(70586007)(70206006)(6916009)(316002)(4326008)(54906003)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 00:32:12.5443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d795f26-8be1-4ef4-7555-08db738149ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, Jun 21, 2023 at 02:37:21PM +0800, Michael Shavit wrote:
> 
> This change enables the use of the iommu_attach_dev_pasid API for
> UNMANAGED domains. The primary use-case is to allow in-kernel users of
> the iommu API to manage domains with PASID. This change also allows for
> future support of pasid in the DMA api.

Would you please elaborate a bit more for the use case of
allowing that? And which test configuration do you cover
using smmute? Would you mind sharing your test commands?

I have run a sanity with this series using an SVA domain
with a real master. It seems to be fine.

Thanks
Nicolin
