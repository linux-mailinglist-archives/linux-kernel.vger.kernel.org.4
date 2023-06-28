Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD6D7413E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjF1Og2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:36:28 -0400
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com ([40.107.223.82]:18529
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229982AbjF1Og0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:36:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIJ3DZ1K6bjfmG5nVDsCQwFmapiYo27wsObqr/jF7/XRoA/E2YLmWVupT0K8nHpxPmW3n12QI49krUDJm9IIANWZQKWgsWg/lKhtCNF+W4TKKYFQB5+VzvEa5pB8JRRYRtxo12m7+i1SJntKf62K34M0kvGtRi6mh1K8eOXas0BFanwhArdEfASuqmnv8mS7eWw5gkBNxcJ1N5hVtHTxhc3ZvDaIwye0fQ7kvnySYCZKfn7w/xhWK/1yoq+gRCdkmfcj4aV/nBahIMykCVXSKz2wOhlsWOSfcU8nfY9mXF+K5plVakMfGchLN7H/7zxVwL+XXMEfwQyamkm32G+8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFfjemtMirrQRE5ivZ91TRSFNdM287fw150rYEYiYcc=;
 b=guzphXtnqoz+ZgFq3iRgtgTOZw3pKwIpoNt5S9eKvdasMEYRiGmKn3TQbYIf8tXf+DV5mNXMO3wi5jKcPjQrSC5ZZ0Z2Y+nTlj9ugFvh5zSb3eAbLUS6c3wEodeMk5Yq2llkTNhJ2zqC9XE+SOXNpOV71yXaM83/Pvsz5cqc32E+kBWa3ioKQDbCHc0uLVTm2r9NS7dbTYtkrD99UQwlLCYFc8/q6qj5FDqcWaMNdPkJy4GsHxfcaOz+UYwHLlARY+jWIKs8TnP8EH5b6az699zhkIK7S7Ck8kDdqnX8NsYfEjgHOvmcHh38U/4xNlWDGjOk3qgNbpvljSGUeL7Iyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFfjemtMirrQRE5ivZ91TRSFNdM287fw150rYEYiYcc=;
 b=oz8hIBpFK+mcIJBbPSjlk/Y2uNsWpv3bLg2Kmqa6teO+cFmasksmz83q1Uwu8hzB2sp9v5O+eY8Pzl7Br53vrJPwvaimg4aDw/HlOAAWqlhF9lSeV1JZjsHjGg9IcRqXXqGO4jSqMWUfZA9mAWyhhD3Cn/KuQCD2lCC6zCfCc0BghURUvK9U9Q4Sm3Or/MXvtgAAnXhYBolyi8SzWkVSZtfu7glpsds4sxy5pt1QfJiY5pgC8d+vaRlklRYesfEP0jdqcNQ85J8slHC2PD042ZQRJ2Fi5OZ0cGatHnalqFOeN9St2EoEyKsSVMttl8QJU8WZrr4lJq/4Fz6R70toPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 14:36:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 14:36:24 +0000
Date:   Wed, 28 Jun 2023 11:36:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RESEND PATCH v8 04/11] bus: platform, amba, fsl-mc, PCI: Add
 device DMA ownership management
Message-ID: <ZJxFZkxvPNj74uQe@nvidia.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220418005000.897664-5-baolu.lu@linux.intel.com>
 <6472f254-c3c4-8610-4a37-8d9dfdd54ce8@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6472f254-c3c4-8610-4a37-8d9dfdd54ce8@huawei.com>
X-ClientProxiedBy: MN2PR01CA0002.prod.exchangelabs.com (2603:10b6:208:10c::15)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6800b6-633e-44da-1ab7-08db77e50c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugUl60xV67A0eSszonH8ZbbdZW7OHYeEC60iDXZEzEfz6DDec7NaGKJSqIQm6jr6lQWqBsYhAUMrquqmmBTIJONbPGS05wI4i4TlGItHqn9wISzgkGBUJJwbcQRt018P265fDuIlHKpf69qNonX0zZ8R98s7r757FoS4givMNUZKvC9H8vQuaWZHTuVkM/WNPleDj6v7SuzNxk4ZyxPPD0Wbq/b4rTvRTuR7ngeJKqMOfdm8xC4wPn8GIiPwCcwMP12xPJWKCiP4HXnRCQ95g0/Xv2Rgw2uDfJWROMxNXFw7xftjeF3n3dVaycLt4YrsswwDwSR79KMU92PC+8kZj8eHaAHk36bEjU5khP0Jcmi/WMCBcw0jvi9XVoy38YuU7/e+6waHeCMTdGaxEQ0LqCr/I7o8F+BOcXj3sXPoPsgHZJxwPxTfrSG0K5v/qSOQuFZ1P5Y2AIEsbx81QZZptbwmqc1D6suxcCwAvqm5fyEE9At3Nam9QXZnp/mtF23npWZIT0jsJa3KZ1Lu5DMt6mGMaJuELIaRGlbhe3M1Fv5rJfDubaQZYRsn9Fc3zPIZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(36756003)(6506007)(66476007)(5660300002)(86362001)(316002)(6916009)(4326008)(66556008)(41300700001)(8936002)(38100700002)(66946007)(8676002)(6486002)(6512007)(2906002)(4744005)(186003)(26005)(478600001)(54906003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3PQO15JMjgbxpAUDoVPs1Ljg/dpFHJtH/ej1xGTI3MDfHdO0X93viKRh1AIH?=
 =?us-ascii?Q?GOi0ALfV+SnjZpO4xJ0daVrR+J+eu0icMOMoxato6vt7E9qxH4LrNrIqfG+J?=
 =?us-ascii?Q?IPntQlA7rtMoflOU2zA+wdti7ai5ub5LmSFJL/esYhzcCQOUEm7azM+a57xS?=
 =?us-ascii?Q?9pTGwemWeCpPQvkFUZpiR/PieWaG6oNsDo7uZSMn5n/ib4cCHHv1P9enti4z?=
 =?us-ascii?Q?Jzp0C54+k0nnQSCwdijLDgQw2dVszdorPGF4/x7D7O6nsPrMS3+lSnS8eou+?=
 =?us-ascii?Q?v9P8ebzxT6SvD6WmZeYoCGSC+dH7keu5g63bTrcfN3Zt5xy5Y6gcz3xe/oq4?=
 =?us-ascii?Q?lT1AYLjdlqbqQUHpixzoBSy6ZLk07SNK5mpMHMwcwLz2vWl9LvtCN5+Ui5Vt?=
 =?us-ascii?Q?sAe5CTNS5Cw3k5FXz9dIh+n8laZb+KlcKADM5SXcO4VdkLABCajtGH6tmEbD?=
 =?us-ascii?Q?+ecmN8e/DxR6HCwBKKb1b1xL8IUZ0yWGaM4L55Y2oiWgX6X7bwikYXGeTolw?=
 =?us-ascii?Q?WdlTrypBsd8R2ChcuFLLe6Md6tOaZ/XiLs2hBx+qvAe8axYmNHqtD0nGP760?=
 =?us-ascii?Q?Fw/9lEXWdurbv4i7bdQ3QOCP+rEPyLuJiWsEIpjxJLRvPEiMaO2/x8FkpgMr?=
 =?us-ascii?Q?K7iNJG9jpjIpW36oGidnXQVW6FNdKv9AmZxspX7ur1L7oV7brdH2DUIJ7iGF?=
 =?us-ascii?Q?GmBUchyf4qvHZyWrMCJNuN2x2/M/uvm/jIJomJPiJ89332uh+kPizf40IPSu?=
 =?us-ascii?Q?CqKjxdGNKcr6pdYpsQIoXNvE86XbulVNjyyURpKkmA6x9NXj67UG6okNkVgw?=
 =?us-ascii?Q?OimGBMBBVe5h8FQHgXs/xa9YYi/eDEBUERJ8w+pf+siqg8MWnK7cdEQrbHGy?=
 =?us-ascii?Q?btiYZsUvh4czFzEYthhWCgBuGtPrV9g1upPATXsEd7UFXrFeA5Uo3pZUbR+H?=
 =?us-ascii?Q?h2Ji7EDMXpfgh9HB7DuJVaXPF1WBEfnQmmHRai9pUVQ1Sf4FrfbNLl3Acuif?=
 =?us-ascii?Q?ifxb3pYShxm2c0Hhzgm5clBO49au1jeBI7gvJswdQJ1y9paP+iIr95qSKYzS?=
 =?us-ascii?Q?hR4pU88XlX3SR33Vy/meEpyvF+ISZakr81p4n4adeEcrHDD+SqFOnhA4sABy?=
 =?us-ascii?Q?MZf84tBq2tOukmpZi0a34hWwCqlOHjgmqNp/xP9BviL+mHADhDoXraPFp40Q?=
 =?us-ascii?Q?5X0aZMWw/cFxykFOjx1GkoLFzMxAd0EUuPbMe5lRmD2OcbW6BkA5YlvpwTmB?=
 =?us-ascii?Q?voLfxHSHmJqmTyJ2ipnS9S+oi65xPc+IWbb31YRNW89CJAW1jFQR8WfO2OYy?=
 =?us-ascii?Q?vVsP+qm/X7BdUVD74mMhGJ4w5DX+OKI9NxNa6WQPk4qem4peKMKr4oa9LhSQ?=
 =?us-ascii?Q?71SbX1SJQHzia5euNK+0h50xZ2Nocfybh5tlr+AHzU5mn8UfF1+Cagt0npho?=
 =?us-ascii?Q?d6vywSeNyH6pwfZL61NTtafdxILr9hZX1JGU/NZ77YHBxjWGf2wbK1Qr3/Bi?=
 =?us-ascii?Q?aA4r2K5NIzFNamfGwsBqkTFtvAzJx4AeuHSlaDNMtuHX6zENrviunVMO2es4?=
 =?us-ascii?Q?27hWCekp0y5ktZ/rR1Z4psdTKeSVvFhZG9aWftqG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6800b6-633e-44da-1ab7-08db77e50c3a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 14:36:24.0821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stNyoPnhbXiVQiH8y3YRI2qctvAA6W5Xw0/wHMgL+rO+L3FVuZrBHrQQfBsrrgIP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:02:40PM +0800, Zenghui Yu wrote:

> It looks like on device probe, with DEBUG_TEST_DRIVER_REMOVE,
> .dma_configure() will be executed *twice* via the
> really_probe()/re_probe path, and *no* .dma_cleanup() will be executed.
> The resulting dev::iommu_group::owner_cnt is 2, which will confuse the
> later iommu_group_dma_owner_claimed() call from VFIO on guest startup.

Does this work for you?

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9c09ca5c4ab68e..7145d9b940b14b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -693,6 +693,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 
 		device_remove(dev);
 		driver_sysfs_remove(dev);
+		if (dev->bus && dev->bus->dma_cleanup)
+			dev->bus->dma_cleanup(dev);
 		device_unbind_cleanup(dev);
 
 		goto re_probe;
 
