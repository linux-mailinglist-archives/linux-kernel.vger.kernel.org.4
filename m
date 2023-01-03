Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE0365C1E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjACOZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjACOZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:25:18 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABC12AF8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:25:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBpM2XEVDw11EIkC+A76c3JUZxO4Bo0OsZbahA6OpZZhuAAOLVhAbQ7TF39ivaFLwB0fRvcNChbZQmPgunzAL0qYYKNwIXmrAKV2zVIvw5waRPjpvNMIXFRKWT25XCmcdtP5tU2xYnGTH4BrxGanwQi6RpnSRWHMx4Jnxv74YkfAvwNnR+MMcoFnkvwa+MMtn8WMiH23+XLBl8TYH4VT+rIhhmBqLxU/AkNuNgC408+CrWOSl/PsJHi4ZFBXoTZskdV1POHU/5/OBp9k0aG4rEWY+quhBvWC7RhZeGljSS523AbDqw0kUrIpmNXUfLDleKA35S+pFibbinNnYiw7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcI9YMLyOvSLD6GgrJKXzYlDqDwDHG/9XR+ILq1SBQI=;
 b=fm+qffHGtVAu5hnzoWUSmxA6VEhz727KWbZJhGT/hrYDOMWR9pmtoa45xsthRwzZEggsmr3t/r2Z6J00B7Jqljfh+EU9K6LrYKi942Ruv5AUwgZkzgxuRvrvgzOYdrUAfGZe+TBcLFs+Krt1Spd61yZc9WsDgg6iRouYaJ2Uw4pxUWcWo24HSYgUkfLT7cxfEWCG9rVvwkapZVtmczo0Y5xwVYpTjEYjX/8xjcUm4vKSMx4eMiabAlGMRFZEOpqobKSrXrtivLsBe/R+W8WMScvf9rtZRgh6TtTk4KVV0u8Mt8v1WyNKUx34jny5Wm3PnZOF0hJl7UEy1WTwvxjT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcI9YMLyOvSLD6GgrJKXzYlDqDwDHG/9XR+ILq1SBQI=;
 b=fkD0L5J/LGwxCdM8GHrtnOLlXEKxv/otJT/Sz7SyZx44yT2+s23eM8dP4Y4y+4Vn4kJcQvJ9hXAuYaMjC2St1wS1SEZ2zXKqWAHrVsmbwJIc0btP6pHWDepgcYbm6KsjOdxEL7j5pvM9F4ouCdezacV4Zi1CPJyb1xd3EpO5BokPh0+fFm6KzcDUJ+atUslX0gK1ggmFw7HOcnXIm3RPf5p9xAOii5lBJbhZTw3uUaT1tFY2VD7Px7GEsUFVm62hP/i3bE8RaY97x7adbjefZcWW76T3q60eEYGs0AG0evkMilifGf6E47EFWGaWT7okfiOom5G2wVWBf/k2jeALnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 3 Jan
 2023 14:25:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 14:25:15 +0000
Date:   Tue, 3 Jan 2023 10:25:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/20] iommu: Call set_platform_dma if default domain
 is unavailable
Message-ID: <Y7Q6yqeuq5goz3LP@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-19-baolu.lu@linux.intel.com>
 <Y4TMQ7HazPWMdsNj@nvidia.com>
 <e51496f4-2874-04ad-818f-e4579cf3a1d3@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e51496f4-2874-04ad-818f-e4579cf3a1d3@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:208:32f::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: f184174e-7aa7-4f9f-1eb9-08daed9654f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ViasxAvTPuMd0+1F6GvxlglOGbEqY+pIuIci1/XY7bLjFkaA8mbknxmy5KbdfjMe52dc6egX+68v25ihX2jJ0Xe73YXut9PW0M8+rErHJLFESjwUMgjmKxrMxl9DcrEN6b7Bl/E4Epu5H8mFkNTNNyJunVWrqMikHI4EjAomntoqdai6KNwyufUU3HDP8X8rWkEwhmT4UDyjuDOVNloyaDQH1OMR7qexBWgwL1g+zocbD5VX4+SaHMEqgL/B3xKoa25Q9DOihJglum8DRXYGadLPioyflvWxLoS2qNtJxTdgnGfV0/dUrJU7VsxjpzNW/okDllFFuFliF2m0ZaNkvvKFngTM8vrsimRVpCoGCRsfOwUDNLJn9OvNv/xZgrT6T7IByJKHQaz8ZJP0HSvvkYZnWMnqeqYEi4uk8aT/0xXPeeXq9mgLQZPa0ojbAgZL/STGsbcLnf8VsEWvCccn9vLMRrvs2ORfo5ON0/hQ6LV27MM3GFTiGKj69t00H0TMxMizMnWnHuBBzj+1urEz6nu2o/p3rzzSCAADms2aXl5szvLFttrgah94iMgPI7cr7/8yB4ARPmiqVcMTqB7lNEdL+LeNBw8qPtqpt44OyfNkJ/noiVExmuZWZOTbCypRILjZkb3ucEPOPnqqGV4nRohBu6KQFpbMSMJgrIdFE1JlG1N24Q/NmGrxsDw2UnJp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199015)(41300700001)(38100700002)(7416002)(66476007)(8936002)(4326008)(8676002)(66556008)(5660300002)(4744005)(66946007)(6512007)(186003)(26005)(6486002)(478600001)(2616005)(6506007)(36756003)(54906003)(316002)(6916009)(86362001)(2906002)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6ueta7JG0jV2CEmvU6pMqj4Fgy+CBdOXLrp/0oK0HzuzIhK8PdFvHvKvx72?=
 =?us-ascii?Q?DgizXdAfPVKcDj3SLKaGV7cowqW2/FMHivX4c2dHfYj4KHgz/8xsenvvxqMZ?=
 =?us-ascii?Q?HqT7QaxvjbgG55OQzh8HOGN0RF3wX1Yw43JEj1+oURnrWcZQ5SiZgUXxcex7?=
 =?us-ascii?Q?4wXHvA0jbkUoegVMNwLOMPd0xMA/tHlXGPobbWxe3FlGuePp/95Z0xsx/xHy?=
 =?us-ascii?Q?Ixd1V4jK2UEQI6uDZ0qFOZks1gzvmiNX9D4pBSpd1fwgSSViF0qIlNP+rtI2?=
 =?us-ascii?Q?N5hh/9/pLw3Vsas+XZ3BdKUBUVfslagVZpz6XQiqfuT0Yrr74MDHyzY1WBfd?=
 =?us-ascii?Q?owE+8WFZDbh0KKmwtrIOazOqfcBLOCGWbPDRt7eJYhZnHjVbhBhN2fwf7z7b?=
 =?us-ascii?Q?mDYR5VOSCf9um6xReQo0OLJ5NhuAWIEGrgdQE6GToYtERTxfpVTdW8cfkwdw?=
 =?us-ascii?Q?cPybt5kMotWTNtHUaoSpxzbu/3DQ7/wdqHiAODc6u8IjCgYY3e4csSLEMXTL?=
 =?us-ascii?Q?gAlogqBtDcDaIZtl3knm+zHtffL4f168rtMR3ocPXzcAS02pM9RQgRSLuJgz?=
 =?us-ascii?Q?etErfamBRBctCFkvqTO5gEPLxWWodaM5HhXJjEl0T5YOfSoJt48fx4CvGw0N?=
 =?us-ascii?Q?lYYmm/QjaBeJxHqSMsaXLdd71xukAcxia0c+nV5a1sxbBXbg4BpWsgjIEnkf?=
 =?us-ascii?Q?WqabXN0lDbmb3Ka/JucqY/8p9sS2kXfr7AO5oG9KuqvH4zlRjgWEuIep5jt3?=
 =?us-ascii?Q?We1kT1Wcs9Rq1uc5U1j1SFjUtFuCWiaUBREY0WlSrRh53RQnm30jQvEujvHI?=
 =?us-ascii?Q?sEOSKEydg+Jw83yxIdraOXpcU5niBnOHVzDEfDnUbzx4CPYU3M1F5vS6AQv8?=
 =?us-ascii?Q?JySC41b2BLfzb3ZOQoMNs3JwGd6YbaDAfROto8kPit9k8o4vUSP7HnOYnJne?=
 =?us-ascii?Q?ZFd3mDEFeutNjg1f8ITXqBBCHDYRxVJmI293kITLN/Wr27rE22xLw9A+3DXS?=
 =?us-ascii?Q?tz5af+YbvtUybpuTe4u5zaVGCJMs9vQx+fcjuZJnSIhP2LkuoLI4xTp2othd?=
 =?us-ascii?Q?2ewbTVyQtGa8k8dYoZPFleMRglAPfrbKJPsy0IzvoyKPbDi1M5C1emUDFfrl?=
 =?us-ascii?Q?qZleykzFOKruGuSJ+obQy6Y/GwTbPL8iVUjvUjIho227BmqNX0JV8GYNoqGp?=
 =?us-ascii?Q?ZM5DeP0UfscYsYKimJpedpF+GCUKZPYYFyb7QlRuVg5uThMVc27Z0E5nZHYc?=
 =?us-ascii?Q?0LsIOOHueblPZ30HWGGseXOQrR4kfYJ4acEGQvuKUCmIXtbkZIMxiDRJi6mw?=
 =?us-ascii?Q?JJE806kgO4SjIHK0L2Gup65IT59jmtEOBzN1dlpvWBPuEXM8vsnXaHSXpbuT?=
 =?us-ascii?Q?bFX3Cpda1DJ0mBzj3jmt9b6rmEQ0rflVz/VU1Qxh4bstcDWR6v12XQAeuy/x?=
 =?us-ascii?Q?lSRzsUfPSQtrF3IcSyCaGV3LZV2I6/2NakghB0hFt2BZiDWHE6fYUnLaSTpL?=
 =?us-ascii?Q?JEJQNQYfBc1yVWkfdaRn5DCPWGGUTtm5XPdfnjG+LaXWI4g2N3hLLhyv2Z1l?=
 =?us-ascii?Q?A2rXY8dcUy8MgxaoJsMcjY07mrw/OsNPNtXJDu22?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f184174e-7aa7-4f9f-1eb9-08daed9654f9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 14:25:15.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K69x+DlFy+JXI/bDVKX5cuL4lwooyyJmr2933uT+08Qj2/3J3aipTkyKclUncsRs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 10:45:24AM +0800, Baolu Lu wrote:

> Thanks for the patch! It seems that we also need to call
> iommu_group_do_dma_first_attach() in the iommu_probe_device() path?

Yes

> By the way, I'd like to put above code in a separated patch of the next
> version, can I add your signed-off-by?

Yes

Jason
