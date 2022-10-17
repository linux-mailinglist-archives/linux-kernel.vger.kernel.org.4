Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A34A601DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJQXzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJQXzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:55:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B51632DB5;
        Mon, 17 Oct 2022 16:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTP06anC3G6ZBX9yDflTvS0SGDYpVMxBMN3CXVgeS0S3hqkk4Zm2+zNl/NDAUNRWsWMKBQL0yY6l/o2YjS0GKXRr3eciyFnO26BnqcbTozK56hNmcgB9JcTI3z77LpROocp03c11FomXUaus+6QkcwcssaiWqgjYXemv32K3kXdqCQbjL44Jrblx3f2SpEpHsM5rn/hY1w78DV/ZgJnjvo58hQGi+Lga5DnqR/gMIaLEcdSRvT3vSaUv5L57i3v07ZZSxxvNmoW7DCAVI8DnE5i0JJuqb/K8yc5e8rMH+7R3PyMxV040RsBo4qwq1PC7D1wnmq9/o6rKll0DLRFd+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w78HN9NtN1pyN6XyWPhF7xj9zg8PBEDB6bzDqNyGQuI=;
 b=Nyy4967s+yzuS/SK9FmWGqO8Y4KHhRywSuKqZyER0YyFeLG74tfBMUEeNrhtq5+b13/Kx9CSSGkfNetMPxJjn4VNUCTDzyXssiTbKEQwP8CFmKosjEii2pXJIATofD8EfJDozIRJfq686sX4GuvWcK/0JEFG7xD+sH/d9sZ8+DSZf3kVQT0xPJpZWQEYb8pfCWJDq+emFjg6HXXwUlWhhSRHYm3EOH5bUcvy6bf/H2UuRFbcepGwVJKhplWekNgcTENmyH77u1zHhcRc/rkd5ZVOqCk4zE3HtKSxHYvXA9HLoK5NhJ1u8pBXhKlqf7qkaFldGVH6BXtEhODCtCn4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w78HN9NtN1pyN6XyWPhF7xj9zg8PBEDB6bzDqNyGQuI=;
 b=l3GRKeBjOuX3vwD5Jri6KICUOoB/O5ApoODOSMG149+vgYEZZB1L3Vdah4MPVZ1S2H3610XxF7hGqE8mzcJBb/+qHqRbYKCsB9H5eeSmiMFLYruGh/pMvxuipGT67PIfgzKGmw7bXZH1BBc19agsN3+X/6V6l42dIJ5/jEavrN6UwLD1A6YcL9lLA1Ts/RtsCh0MPJ+JVlKfY3wjE2oSBcLTTjLR6IS56b8FuXlipzn00tNlVxoSBjAFiaL6fd91bfKS9Ay3mR7k2xezs/x6BPqkqcy548Z/wbmZ7bs+TSpeuMbhg3jYmTdpFbebiYutSYoHpxzAQdotG3lZRUu+fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 23:54:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 23:54:54 +0000
Date:   Mon, 17 Oct 2022 20:54:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org
Cc:     will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        quic_jjohnson@quicinc.com, suravee.suthikulpanit@amd.com,
        robdclark@gmail.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        yong.wu@mediatek.com, matthias.bgg@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        jean-philippe@linaro.org, tglx@linutronix.de,
        shameerali.kolothum.thodi@huawei.com,
        christophe.jaillet@wanadoo.fr, yangyicong@hisilicon.com,
        yangyingliang@huawei.com, quic_saipraka@quicinc.com,
        jon@solid-run.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7 0/5] Define EINVAL as device/domain incompatibility
Message-ID: <Y03rTb542P37J+EN@nvidia.com>
References: <cover.1666042872.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666042872.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:32b::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: b2dfa47f-3e3c-4c80-7f1c-08dab09afd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CB4rjSg8+KFF6DsDRiuKGMAPG9b6ZKWKTgqH+2uFuWjvjsYGMidt9fgyIHiYZu2E8QcBj7VoKLc0C1Oe04INEF/rq1xQRTl0ojFQmlThwDRlTtfOEASgNfVVVveY0nxa6ZPfXBSuF//kleD3Rf+9MF0GcvpLwN6b5xQq/4h0CzXKw1S1s3VbnOOVokF345a4zTC5HwHeXMVBOInt5dQZDU0vDzff7YMQbXdPx/3VIXjL2I3tru7HxNmaVaw7w0zqde1Qk0nYWjPTalsBTGYOIMmRSnCTDC+oCxXy2SKfK7biCWpynZB8sL3toHwl2UIDZWvUP2zHPXGoUc/O4tk+RpbMw4oVCUIIlt2pV33foMC+VlV+N1CuR6464koSncf3vavjtXMz59CtssgSnBYch7+xvaa1rU72NHlnbnZOTg3dZf2fPkA/Z2aJ5jSY21/fjWVdrHTp3b8TPE3FOKTCO+SQWimcGtknjgpVRzLhzCj5beqapCnLuVIABh/mAn+n1SMO+ML6H21R75PF/SqZgdoAUTHjzbg0yp9h+4uO4LK8F90KQZ5Jo1Xnquz975cWobL6LW0rxtR1LUMNVTt5ENzo21gngxS7KX4LOBIICi7ew6j17Ep1hBp4SNV3bmyUaCsAQlAFF6ii/DanQbgLDTRvwMJzYuCjDXFSZFa+Dp2Zgj9nRwPuJ2rwZdyVmC94Yq/W7dfiC6oveVbv8QlTl7HmRzsSurkRpLXHeurgMJKS3bZjNSx/jxbQfn/E/Of1yUH9oU9iYemWbYlMYvpENgRzTcTGwHILp4sWWEIm6LMdYjcztl3BN+IdIEN7l0V6GQpj35TMU0q9l81S2teFPXyOffavccQ3dscMGx7+DKJr+Ts0ZCsb25owIH+ht+Z1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199015)(66899015)(186003)(2616005)(2906002)(6506007)(316002)(5660300002)(86362001)(38100700002)(6512007)(41300700001)(26005)(8676002)(66476007)(66556008)(66946007)(7416002)(83380400001)(4326008)(966005)(8936002)(6486002)(478600001)(36756003)(7406005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BIM8VC1eKhRRCxwqoeoRVPgruN1CjsrDOXQ/YntJRCJUNQXxHlRHAwdmcc54?=
 =?us-ascii?Q?XCJhMF6gfUXaziQrXg/QZ9br3f9dwS2wRdnq27crqMMsp6KA/dzold/O90e8?=
 =?us-ascii?Q?masUAZW9LvDMz9BjfWODv/e5U4t9rzq4XV6X97w/0kx62fU5jPm9MmY+b43y?=
 =?us-ascii?Q?BdI8jaj7fF+iK7MgKaBWj2mONafpFpCNMw8rR8HOEdD3gtuESBkqolLrk0u3?=
 =?us-ascii?Q?B2gyM7hgknjvcZPtSY4+TVMWtWE6OiWit0aC9wxbP2PKuvk5Y0dASpZNqp+n?=
 =?us-ascii?Q?99AoRsbiQ0Wh69NIrjI1u39tV/4mOpzDNy6JzVTDWyNNAfnYpDlSMqZehwrT?=
 =?us-ascii?Q?s6rAWI1H0jzBlIcC7SF1tL7B6SLADz1kjRgAbnAsDZSwyHs1Nj4UXkgb/7KO?=
 =?us-ascii?Q?NKTPVvw9Mqx85V0OLjHOJT2iblEKlI4iidu2j2XXHtMg+ouVEzOAuB2EtT26?=
 =?us-ascii?Q?N8CPosFBRdjJUX/2lx96YRdlqdpsdfP5Ru6Z9OSy0CEmQr2D2G5hvl+6IYVv?=
 =?us-ascii?Q?mBuCqGmLInUNINN0DBo0/LNtsFSOeD1hzvUzNNsnhlsqcUtFvErg+h0cG4ix?=
 =?us-ascii?Q?pNhiZ7gHu+866tSZKNX1MwIjsHJloSHEPzOM6eZBKTp9dpAyJHcupD/d5zcY?=
 =?us-ascii?Q?WaLhlxTPpWPBBa+DUvSDzeffcLSbOqlyXnQW6k/2T9IvlOFXdspfRdCnVGEv?=
 =?us-ascii?Q?Zjki9uAIY2oe62Hay9l0FpoBp9XoSJ6eZj0f5/Sp975JaCPyBomcUyVmrleL?=
 =?us-ascii?Q?U9f5f2f6wlPg8t2KgK7jK24Gr4GmijSEZQeFXnEHJQhXvqniwzNnbnkbfo07?=
 =?us-ascii?Q?Z6T0J6jMr+1L/X0VQiu2mG1Le9xIFK9jrFgvFr09VwLvlvZgE7qvUvStpg1z?=
 =?us-ascii?Q?21gl0Fdy18b91hpUtu7KaXt9eWCWQJJRzBvKzyxmjRPLJDybgWsf2us5/0X/?=
 =?us-ascii?Q?fFoFB56HYIwSxRzZzJMC3oOVLCXXFJMzOv8C0lAYxw4D2E/wE8CJveWge/IR?=
 =?us-ascii?Q?AfueoVKrKm/3p3ccnh8GcLgTao5O9JCuCAUa9m/62iGbdEYBQMmoaSST9RtA?=
 =?us-ascii?Q?bGtlbBt7w5DEfAXR9QQfk+AN6BEgHBclhy+qFMH4IZeG2WCf42Dqj4M9hfnI?=
 =?us-ascii?Q?9h3qb//mBAY2Yki09C93Pb1Lyj72p1CACf3WFpbF/z+o55mM/Rnp/zW1DqmH?=
 =?us-ascii?Q?Pn11Ww0Q/i++8GnGToNqGr/8n0InUiBk6QrzuaBjSsYR5veJrHpbbL0M3RVM?=
 =?us-ascii?Q?VXV4DNnMGFCc5V7rMlDJz5FMQCJparV7w1pZL+eGkfxRDKmdfPmus4zpotCw?=
 =?us-ascii?Q?4Exz6gbWmKaBf467YM0tHxPGgz74WpWHzRRDuPy/A2S9Vj+mSFo37z5hUJVv?=
 =?us-ascii?Q?wsTmks/LQ5suNyY+dkjJic5lMgr5y2+UQyDx4hTAaT/OgnWPfNKdIPkHuRag?=
 =?us-ascii?Q?L8t496Du3Ugk2puqdZf/rBjfC+Wj8nXPIyrsoJsV7Gagk/bFHX4z/xO4f+pe?=
 =?us-ascii?Q?biHd0SXUBPJoxJ46L7A/MK/nMDYbeH9dRtZ3S+DNRgNTWBTa7t6KyrJgsnu3?=
 =?us-ascii?Q?qhpuxQJ98wxdJM1XnnA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dfa47f-3e3c-4c80-7f1c-08dab09afd0a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 23:54:54.5399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvnuN4VTiYtNhPEhV7ueXmToS165rNBS7TU0QTiykD+k6DVqBsli9av7ah/pmf9v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 04:00:29PM -0700, Nicolin Chen wrote:
> This series is to replace the previous EMEDIUMTYPE patch in a VFIO series:
> https://lore.kernel.org/kvm/Yxnt9uQTmbqul5lf@8bytes.org/
> 
> The purpose is to regulate all existing ->attach_dev callback functions to
> use EINVAL exclusively for an incompatibility error between a device and a
> domain. This allows VFIO and IOMMUFD to detect such a soft error, and then
> try a different domain with the same device.
> 
> Among all the patches, the first two are preparatory changes. And then one
> patch to update kdocs and another three patches for the enforcement effort.
> 
> Although it might be ideal to merge the previous VFIO series together with
> this series, given the number of new changes, the review in the IOMMU list
> might need a couple of rounds to finalize. Also, considering that v6.0 is
> at rc5 now, perhaps we could merge this IOMMU series and the VFIO one in
> different cycles to avoid merge conflicts. If there's less concern for it,
> I can respin the finalized version of this series with the previous VFIO
> one to merge together into the VFIO tree.
> 
> This series is also available on Github:
> https://github.com/nicolinc/iommufd/commits/iommu_attach_dev-v7

Since it didn't make v6.1-rc1, I'd like this on a PR as we have two
trees that will need it now.

Joerg I can make this into a formal signed PR if that is how you'd
like things?

Thanks,
Jason
