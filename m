Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD44C6817A0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbjA3Rbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237565AbjA3Rbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:31:33 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5CB29406
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:31:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+168t4AXyIB5keZCKsgZxbU0AwjMbokXCvosdpLKfDK6H9lQF60DoxF7mUel0kDthMaWrEOjHBQ5JVY07v89Q6dHOOGPqyg/q8P0BNCWEcb2waTINLtGFOLSF+uZjxm4s9JnHYiQH9Czo4rUmKbPaohYKzRN6NHcvdnjedep+Tw64zg2kmWuj0HAXYWYgyJiHtBN8kOP8vhXAfHZYQ9+9wzxV5WmtdPMkI61XPpYQ66swi3WElOhed65/9vl6kTW2/O0px+/U/f37Veq58xYb1vDqkqj8Ad6JyKYVUZmpbm4mAoFAkOYrRimbYKYJSfWDRmzEDjQ0R36053qFRkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32zd6SOwOp/9NMDTroPFhkYHSWh/Ja9cKeU3ovB+XyA=;
 b=c/KbZ8OJucU9ZGw8VCnYuueaPGJYN0mHyyiS2t7JxUAw4jqwpT5AIhQN6qI88O1bL5AMuwx25CvnW+Q1kJ9iK8Vwj7kD4kF+COWQoyoBkyRvJsL1Uwas2/DfiK3jiFokbZ/FZX95IVRZAmUc/aSxBzag+N4sEkwcazIoRQwiudF68HvVfYldswCJzIJY+KsTYJZ3r8N8Zr+q4ufCIX+sINbrNn14vFfnDCuW9gjV9rgXQMBFmb8XoUan6LlFikGuqq1R2gVqYCFjje6qrSOt9eTVybMCt7Pa4WYGyTedNewlUsRJi+qso0uw7pUA/3nY7dXThj+ReePPem07RJpj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32zd6SOwOp/9NMDTroPFhkYHSWh/Ja9cKeU3ovB+XyA=;
 b=a6k1eFU4EKVg7HLrz2y12FTi5YzL9/76rfbWteilF9NB8Fwn5hGXuVLQVs4A9NUWmFoJ2uP67kQcHukK8N2usBAMJfheOpW/wvXmcFOk7B5ziFLvb9NE8RBXDx7US9U0+tnZAsqFb71IKqEM6DV3ACh1ogwGUEzPOEd65z579DkK/gMZ7/GUwsMurcSrPWFZvzoR4rCVnbepa/SFHIUKRcUXYEu8+3uHMm8Bu2v6bvb+hPrul6mHsgjO5QYH/9cpjgaQTId/rpGS/ZtnWz14cxCRI2tpFLOu9YV1njZVT4UITdy5Wn2ZtgNy1seEifAHbr10vioFv1ISSQuc1B1fNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 17:31:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 17:31:30 +0000
Date:   Mon, 30 Jan 2023 13:31:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 1/8] iommu: Decouple iommu_present() from bus ops
Message-ID: <Y9f+8RkvJUPOrGg9@nvidia.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
 <bf052fb0301eabe8c2831c6d53b9de2bbe000ac6.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf052fb0301eabe8c2831c6d53b9de2bbe000ac6.1674753627.git.robin.murphy@arm.com>
X-ClientProxiedBy: BLAPR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:208:32e::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4943:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3d33d2-7b52-4fbf-444d-08db02e7d329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eb0zPZxtiCplbyfIuzWmBTDs+J0PXV/KX42E/PBhsXwoaga++NG7FAtqTMEWtstDLi81hLUhz/arxQR+IjrT2NhQPCmBnF58sockIXCf1P0iAeMZ8D0fHKQtSshXyU/3oL4A5xpnCvAHwsSwpAODgdj7LQ1XKJc4IZKWbpn+ag+quzQQ1jjDIxZPex/fkUHDJn40pqLpEVSY6iuokkOXfcqAjcEV8hyYMBWrfRgkWipG2OPs1hedp/2XA7cGu6DFbmW7aJi4kvK0U12hK3flk32z3HafhYeh3sr6ncUkwEop14gLiE7A/n+1DxOsZXIweOajRkVKtj2iOipVQREkIvss//h2NPEhXiKq+4im3dB8cqwBNJuFDqB2pdsBlsCHLwiEEZLrQ/R0cxOGWsuQBHNTADKWuzSkEpBntLUxHUsBEvJL7rO9UFkFahIRrg7hjWiywrmuQTMSzY9fMGuYTldi2bfsUijxIrM2f+Fh6pUJzTvrIu2HL8X/jy+snwRVdCyMrE01hJjx47QAzMnt2yzINCyaFi+gPYVdMhFcmJ4uNVdpYauybxef1dOV3mNivrYNxcSFOZbVGqHb+diyE6nNo6HtrPJecxt7wp4g1Eo3DVquU3jVcN/GsT7jd3bB5YC1T2Yk8JQ2gAI1m4zEs+lkDv4xkSvBaJ0lueUvN3xoePoa8RGzk0HQJTdj+UV1fBNh3v5jp7dZco7ZYsHILes1z0u4/5k6HgDmcsSJS3era+LunQslyeQ5dOD+3y7oY+Rj6M9GtqtVDckKkReokA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199018)(8936002)(41300700001)(66556008)(5660300002)(38100700002)(66476007)(4326008)(6916009)(86362001)(36756003)(6486002)(478600001)(316002)(8676002)(66946007)(2616005)(186003)(6512007)(26005)(6506007)(966005)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9+XRp//G36p3SMfvb/DYqKUtCbwVewMItr1guybTnnyK37KvnLu+bOMswIko?=
 =?us-ascii?Q?X2fvU3rDagNnZmMhw7lpcB7kBQw6KNpk5ymlU08ib85N/cSB0hkbS1gsldij?=
 =?us-ascii?Q?ooYC08Vozd6LSecQ4IeLOPBk6CzwOwj/ptu2JAVYozC5setx2rQK+5y7cOHP?=
 =?us-ascii?Q?DHR+YTphKtA4QgCugH71OgYk9gDK7JNBjvksIMh4qaLDQUxSPZK75yB0KiK9?=
 =?us-ascii?Q?4XPezubv4iFC3nJg7TGAqCP+BeUY1MmHbp1o6HErp54KczmrkmnY5YWzD+Xq?=
 =?us-ascii?Q?H6tohAFvOYRhBI2beaGenlcDKyrDsXvkbiV+ncFAHzSD0LH3XPp1yqsZPvcM?=
 =?us-ascii?Q?0E8RkOsYeswAGYRBWwQL8sREv51BojtXa3Pbyo0n95m8cZvX2ZtH6AYYqMTv?=
 =?us-ascii?Q?GIKKn2FRnm3IHJwD5WaSKOBhuV2pQHeVgCf0Kjlu9AwQDZVZb+AwifSzDiwM?=
 =?us-ascii?Q?md+yn2ZLyvRSxJoLoV8NXglQIfjL/8rre86vnUqLpdSYLcCz2NFoXU0yl7zW?=
 =?us-ascii?Q?mpU1DqJzJQ0wHrMmjRCuAEMcWYd1W/SMVCqSduJhm/2/Ny7QU3gAHEhtcQEu?=
 =?us-ascii?Q?kielk2i5Yf23PjmWsiZYabWCEMNkdfK0j+gzlHrVMehMGTeoIwdGMTGF8/ua?=
 =?us-ascii?Q?Yq4ylr4Q7M2zE/HNk+CWigy2vLlethdiWuHE0y5k5S0GfcjAukc02W6oFpvJ?=
 =?us-ascii?Q?0+z43gg2rNjGJOhiLoTclk5/nUDTTTDi7JEZceVm7FCD6uJJx43PDyiglC85?=
 =?us-ascii?Q?FA9i+cA0NMoE8nO9UX5CL3cuj5lqP5xweFUv6zfHse0CcuwdVnHnuHV52dbg?=
 =?us-ascii?Q?Uzx+pgnua6S9GvLTKy8ILbWgyDIRI6lsHMION53owmjAWd2jB+F5szU+s+id?=
 =?us-ascii?Q?v0Lw0yneSyFIB4Kp707+8X4/0Ar7rBqY+bW4X/6LT9IftI9fobzjcao3zENP?=
 =?us-ascii?Q?W2kji+Ptldyh03JdkGVnu+qbyoRMrbn4lB6ONXvy4TqrqUnA/Ej2i0IvLJjY?=
 =?us-ascii?Q?ODwq6L5zGzMWaN9zlO8R5D3FQCRlCAg+rrBpBQkeuNK4Wofdba1cvU3SOMOj?=
 =?us-ascii?Q?iyFSZmLCOwFgUtwjcMWCnZJfV5VYGsiALuUPbfPzx4ThMQpbDTSHUWLX4ywM?=
 =?us-ascii?Q?UHxVRLidUMjgCY8Mo01RbQIdBgTr64VQ0H1iKIb9DqqkrnHc1Z/RAUmENp8s?=
 =?us-ascii?Q?7zBoizJeDhAVcOrpp/VTSiXrhAs61AFHMA3/1p45Wg9ZOvJQKu/tdLL5k6ym?=
 =?us-ascii?Q?CFmU+eNRUmeMZzYv7NmDA/tQ5L+oXM6QEEdft1OkS/zo7BYYyvtsKiVd9IK/?=
 =?us-ascii?Q?A51ANaoEmt74a0qzt0S3I8QjpaO7T23/9iFWUTeqqnMdNAGgUZTFcdyhwZ8J?=
 =?us-ascii?Q?k+f89Y/AvXuDP1c27Am7apdTdZELoFsS7yV0D0iKUSx4lh6pnYbZILoQMz1t?=
 =?us-ascii?Q?CqvzB0J9lAaDwXYh4wCO7CEsECGFHCk9v93eye8DCKPbxURyDnbil8jrs2up?=
 =?us-ascii?Q?5dn06UUuiD3M30smYmZ+X6Wg/uJTok9E0ircrV01nStcVdf7BzAgp8BIkgRe?=
 =?us-ascii?Q?UzCyztMl9nUeaE+EVvLkJBDvHpt9RKQsU98Xmsbc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3d33d2-7b52-4fbf-444d-08db02e7d329
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 17:31:30.7704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9A0buyGAg6Ac1T7hUp9nR2OLpeA9CWolXYeNgd5w1RO0oIQd73icXxdeechFLC4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 06:26:16PM +0000, Robin Murphy wrote:
> Much as I'd like to remove iommu_present(), the final remaining users
> are proving stubbornly difficult to clean up, so kick that can down
> the road and just rework it to preserve the current behaviour without
> depending on bus ops.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This below might help. You might need to ask Thierry for help on the
problematic stuff in tegra. Really we should finish the series here
and organize things so that the domain allocation is defered until a
client is present.

https://lore.kernel.org/linux-iommu/20220106022053.2406748-1-baolu.lu@linux.intel.com/

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index cd5b18ef79512c..e5c257e41f4933 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -353,9 +353,6 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	if (drm_firmware_drivers_only())
 		return -ENODEV;
 
-	if (!iommu_present(&platform_bus_type))
-		return -EPROBE_DEFER;
-
 	pdev = of_find_device_by_node(private->mutex_node);
 	if (!pdev) {
 		dev_err(drm->dev, "Waiting for disp-mutex device %pOF\n",
@@ -709,6 +706,9 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
+	if (!device_iommu_mapped(dev))
+		return -EPROBE_DEFER;
+
 	private = devm_kzalloc(dev, sizeof(*private), GFP_KERNEL);
 	if (!private)
 		return -ENOMEM;
