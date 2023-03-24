Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6556C83CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjCXRwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjCXRwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:52:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1A91737
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjeukJUWG5pefBjIjirRt6dz6tGR7Wtz652IPQdGFFWs7a/uFjc1q3CjR3nC3CEepMp7wZ90sV1z/MkKR46e0YHMjCjsSD8tY5AWahNEqTkuOP6BeaaOXPPpQl2DkxoLQp2z8kO9iebVDMNuM8XSjuotlaoPj7ayuI0j+thZuE/hvh/G2ehnoDEYDaofJ3bQ0OEOydtSwOIbtR9V9qS5WUQFb9Hyy7o2x7PfIM2Z94W47/ivsF/HRr+uaEsZgPVg0cVS+3fppNh1aEHoC1/PsePQS2WACK3StqPZRTh4ZMIHsfG115a3xNgcpagmwBR4t2En2bcQdDrdGa3O2QYQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HbpYWy6I8qo/xBl0j5PHV1ClThBkSMzlq115UVDgNQ=;
 b=RoFbQ6QPHq7BrBXF/R/RDBLFLVLFuoreFU2LxlsLXiUOyEo4KGnsM4odiF7k4HFtp2EJewLPHvd2iuG7A8uurg/Y2sMfPfw+NKmCIQjvXQp8sF/LkjqH60LobVewi+8EzH62dGY2oeLNkDD/hc5ZYksaXo4nogCaeItufXmuc4a6Lv1WjxfYkkYtNCpanhq1VdyxYtrbxVA7mnOGKEpCSf+zclVTI1hVNQvNnEUekMVj5IOsDCmCPyt7p/289jpuFivwPGpq0HO6kqoiLfNGNcEQZAYTE1E+ASjxo1la/7GEllUVLq+WxU9X+STzor2YBDs3XtikgGjNXsJL6GlMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HbpYWy6I8qo/xBl0j5PHV1ClThBkSMzlq115UVDgNQ=;
 b=gdxBznC6Ioj2UTgA6GSLzl/aArlT8Q0rL9MShFnApzTCxn5cbjQf2cywyFW9HO8ZyW5sOGLI+QFSZuyCD44WFqi3ewpmbl58/4ehfE0hUaQkMZeDfB8/feesah7xiPIibkqPpz+Brp2THwbAmvf2R/33qjzN1KXtwRA20j/bfuGkOWMKEVt4tYe16NiQ+LXRUr7P8/iGEDrpsqepoVwISW6ieZDVeVp1fN64zG4p8f7QE0vHxl08MzUHwO5zU3Hjm+ODCCvT8JdfhpEUfZwQ+70x6H31P9NL+/SWRA8XNNz3deMEvsmoQHeYaLMAEgA+rNSJg6+aRxIQhldVIFwysw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 17:51:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 17:51:47 +0000
Date:   Fri, 24 Mar 2023 14:51:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Eric Auger <eric.auger@redhat.com>, robin.murphy@arm.com,
        will@kernel.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
        joro@8bytes.org, shameerali.kolothum.thodi@huawei.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/14] iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
 type of allocations
Message-ID: <ZB3jMSOL5A+E5D82@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <b01b2bad6d0d34908812d964eba118a9cc1e89ab.1678348754.git.nicolinc@nvidia.com>
 <b870ec68-623c-df0c-3ea5-7fe6a95e2ef6@redhat.com>
 <ZB3i6r7QD4NVBXkK@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB3i6r7QD4NVBXkK@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6078d2-48d8-4e86-2732-08db2c907025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FC54dy5tCcBrSoh7cD7MHIkblDb4ADLVANdY+jP3cMNNaDHvAIJ6vpBWZFQVVmLPvSU2l6eDOuZzvu1tk5WfWlxgMBrO/UT+N4ODmmEO0UgsCzXuaqyolTxa8+qKVY7lCaqC6LnVN0NMlIZR2vXJ/1tCKbZ2D1SZcLqGvtG+sLrNWfMM6PTq/87XMQ8WdQnngB7YM1pxhvPmF0YZTcuhElPVobWmHEgpKbyO/dbL9eJDjuPUpB6XnL9FhIbm3JKIAPtL56Zz0r/vV+dhjWowstl9jdt0KAsyieINwQRwJYohdsJ4fmlBXIY6zAAAe65D0PvjZskK0raWdwdF0ZfRwg1UfIsD/3soyj4vUlzB0H7yC/Zphog/81rLLcGGSnGrrE4hm/9s/J0hjEAXunCyJtu/qp/+S/g2Ly5JBmrE79auXrn2IbkfzT94tipDBifUNqTKekz0/3m7PKvWkKdlCV7xVa86ZHrk0PrrPlceCLT4AwusqYxMlqu6zi44exQtHmptySALEGBQ2Cr8GYJLE4qtc4+EncQTmk9/2SIpyo+E4D5+qCBIWYazKymg8+0kKh1doncLHj2PgiSAvRDDNptg5t1Y7RRsOJMQifH5AM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(6506007)(6512007)(7416002)(6486002)(26005)(66946007)(2906002)(38100700002)(86362001)(316002)(2616005)(36756003)(4326008)(8676002)(186003)(66476007)(8936002)(37006003)(41300700001)(66556008)(6636002)(478600001)(5660300002)(6862004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?drj0jT2D1zXQjRlUW1qsvfqZMtUOX4bKcT1G7R4hjQ6SYqommSjAtk9iFe5Z?=
 =?us-ascii?Q?7RL1U02ytiVrFxXFzpQMqfbRkyCRFSmLus0t2tLtKG767IS92pD/e2R8lsVT?=
 =?us-ascii?Q?4kWt0sbAI1xxetpJejgYipVbLws43CMpkrYK6JtTRbCJrDQVPLjIFtyHxQuD?=
 =?us-ascii?Q?oX6zz3cxotN5exkNx//N/VylCiBhcBle17QMst1+IP2lLpbjAJVlnndFj5fA?=
 =?us-ascii?Q?p9ASsqjco0UZAxRFcUdCoDbaLTRjcyFxm83+1cMU/y7ou6bZOBG74189XOJq?=
 =?us-ascii?Q?QN4Ecjhacn9vqMeyYxvacKwEFmmzFKJMpGcQ8ZqKlvu56h6KXSlb0iQRWbae?=
 =?us-ascii?Q?F6qGhaIyjk4a37X0WvT6YI29utiYhaRRhcWF9h7XI9vsymeXwA3JVAyBLklW?=
 =?us-ascii?Q?8kdoNfTrKldWeh4jn+nB4cbAdM43OnIqOqpA/yzPfsPPF8Ldd7abGaMJjrIg?=
 =?us-ascii?Q?0ej+H3WKqoQKXTmwQAQetKDfjnLhF47C6nfYuDwZKbc/NcelhRbFWG36BjkS?=
 =?us-ascii?Q?SyIB2h4kkw2uZg3zo5I/pCT15oFuCAvuuvMfK5vCdV3/6F06pzC9gD+harEQ?=
 =?us-ascii?Q?c5oDb8zJ9vjN2mVXyTUbSqITyNiSNnsJ4IoQBrhY9Y2nqdYIf93ldh2OxtpQ?=
 =?us-ascii?Q?rADBRW/mAsmNo/QCS7I17wKO8nBRkQu6P7Bxlkd2UUhmDt8cQ+4zFuP1A1va?=
 =?us-ascii?Q?rG0p4XXfwU0J92p81fxOG7voGHtlUjW5DWgmyiG7NDbke6kPsIRhGxNdBoZV?=
 =?us-ascii?Q?9wmxdzTbDTwyUWHYPSYP70BUgkuSecDSwzYsZsIPjesLKSbSxb54C1H6Bolk?=
 =?us-ascii?Q?yNgPLToDY6zXtbwdfB21bRUx4rPTko2IZsL7k2OEFDu6IeOAsJR8nAeKmlV9?=
 =?us-ascii?Q?RCqslbTI254B7M0sQoJLmEVt14lTJ0WElyXAR9vQJvSu1k2LG++jz8xyip6V?=
 =?us-ascii?Q?xWpJfUMcfsbYyLh8QrTZNje2Mj2wjGQq8oYUd/16NxDPjm/5Xceb2Dmjh4gk?=
 =?us-ascii?Q?/GE47GVDAdZIxXP4q/SSEg/55cQlKPm+r5sfh0Ej6DHp1dchOcgLn9ENamX9?=
 =?us-ascii?Q?lgAyhW2iLe5o6ynxzhRX+uRsEcMgyS220RBhej60Zb3XO5kCdR4/4XcLKLq8?=
 =?us-ascii?Q?EhcFOnqKfdfR3UicFydAkOfGG4eb3NH1yRgV+8wWq4runhPnUGthtGxd+15/?=
 =?us-ascii?Q?nnZNJun1iatIqlyD9k7HEHMWKSvVKdZ8FMsOGVVxobagThfYGoi/NVM/iGmk?=
 =?us-ascii?Q?bBrkJaGiJftnLBkRQo0t2oxddeLk0lUipUeFIQr4ULl4yP4MT/t2O/SOqtTI?=
 =?us-ascii?Q?c1bgqBfMzGiDyp/HTMHcKmB9IS2RSI19cVm7AOuMuGCrJny6hZTot6LeBFNE?=
 =?us-ascii?Q?+efqlbqt7mFUd/8kNjxlq+EjD1CGBD2jHqgahgYw2I3KwuIsKh6hsjCkFvCe?=
 =?us-ascii?Q?kJQ6Qudh6wo7GrTFig3rOMPOs7hgC0ltrLp9HgqBu0BDDGraoq8kcfLltRc0?=
 =?us-ascii?Q?qmQd1OS60C3i9zDVsmxpEF+VmRK0EH8WR1gFRnVX2ywPJJdHtUajvQtA0LtG?=
 =?us-ascii?Q?mEWADL5T+++dXRgZho11fS+rMypD2U9skwzWKrLm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6078d2-48d8-4e86-2732-08db2c907025
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 17:51:47.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SM56BcXBdU8DuaQo4QXcd6S3k72oqIn80KCsiaF+FWk6Nfj1HRfUuqKFa2kWOoPW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:50:34AM -0700, Nicolin Chen wrote:
> On Fri, Mar 24, 2023 at 04:44:58PM +0100, Eric Auger wrote:
> > > @@ -2923,8 +2949,16 @@ arm_smmu_domain_alloc_user(struct device *dev, struct iommu_domain *parent,
> > >       const struct iommu_hwpt_arm_smmuv3 *user_cfg = user_data;
> > >       struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > >       unsigned type = IOMMU_DOMAIN_UNMANAGED;
> > > +     struct arm_smmu_domain *s2 = NULL;
> > > +
> > > +     if (parent) {
> > > +             if (parent->ops != arm_smmu_ops.default_domain_ops)
> > > +                     return NULL;
> > > +             type = IOMMU_DOMAIN_NESTED;
> > > +             s2 = to_smmu_domain(parent);
> > > +     }
> > Please can you explain the (use) case where !parent. This creates an
> > unmanaged S1?
> 
> It creates an unmanaged type of a domain. The decision to mark
> it as an unmanaged S1 or an unmanaged S2 domain, is done in the
> finalise() function that it checks the S2 flag and set a stage
> accordingly.

This also needs to be fixed up, the alloc_user should not return
incompletely initialized domains.

Jason
