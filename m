Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689495E6995
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiIVRZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIVRZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:25:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1F448E93;
        Thu, 22 Sep 2022 10:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlUWgsIpYuvpKaRnnO5LOqVqgbJU0e5t23Og3ZbjNlQ66gUjIW+Xs4IM4dbrL6+YTsKVJA97ayWqEIzWC64SAfhWStGHJQIzLDsnJWKuMqGSIjPm+953zND5br4mravsDXX7le1LIfmUx77OWd2qYKzIXNN1RzLcFvghL6KZ+WeCVTKOx4j/UaiaE6Z9PxtoG6QnPrXaaAsUD41cM+a0/82qpZRtHU9ptJS647YzaTEOfCkieQPncwQe0k46DFejphYn4J71nW7wxguJ1S6FQDvItfAgLI8OVLdnsULrbpA2Lq4cWMp6CkL9xa+q956TDS7/pblVGRF6KF+jYL7Zbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akYIE5gkINdmKhN1LSX0+SiFBE/YBzuACj4L57unGN0=;
 b=MbMKAugKyjGUMsUQ1pQ4pnNJbrzCZR0Qttf4tDvhSLeBvPbwAl/Sgmle3M+XNVdtyNX2hXeP5NfqCugN5G1T8ZlFNgdyRj2TqB+ooNwzWJYOt6iEelC/NKZ9k25QsKX8m8yhTBv9votTHPznh/94009tEOWGOBFFZ7D4PHrb7L0ovBmrnw0YcYUTLFdn2kTfgw0adFU9BpFy4Nq2hekueWr+5N/Z1/Izbpy6r2ylLYVrIJVyxog3AGLWYo6J79H23cGNfGiKmEy64jNpiaOxHC4w6LjWIlEq0tmOOrRs09JOeWaTwrpWUBswv0EIk/zMNqzpy6rqxyz1OsvOSnM1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akYIE5gkINdmKhN1LSX0+SiFBE/YBzuACj4L57unGN0=;
 b=j4SBQqfqYdEo4WuD9LR79XyQpXZiwmKsFD8LXfqsaK395zFV7cAFtFBintOn5Ekqnh02JNdM7h6t/9SmzJtNdbLHHJWq1jBy0j3tCnskHrpFcLGj9GpvpLtuYLVR2IytYmr6g1AWOuT2eCTPSY0FjTXygU2dEDOeAV7WeZYR7QlbxBvSZYOO3h9j6T/WnWfoH/gZecQ2WAKPTTx2q5oxRaLr5WNtN+niBDbtzbPFceNRiMZ1217g1DCZqEalPFn0eFUUgF0s4CV9xQBfj1zxG6qtQAY8Gab5syCm+wqiZaIvFX9suzVcYFO3Z4jJcSYLfPQf1IRC0kWDsX+yT03oow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 17:25:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:25:00 +0000
Date:   Thu, 22 Sep 2022 14:24:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, robdclark@gmail.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, agross@kernel.org,
        bjorn.andersson@linaro.org, matthias.bgg@gmail.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, jean-philippe@linaro.org,
        sricharan@codeaurora.org, kevin.tian@intel.com,
        quic_jjohnson@quicinc.com, konrad.dybcio@somainline.org,
        yong.wu@mediatek.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jonathanh@nvidia.com, tglx@linutronix.de,
        shameerali.kolothum.thodi@huawei.com,
        christophe.jaillet@wanadoo.fr, thunder.leizhen@huawei.com,
        quic_saipraka@quicinc.com, jon@solid-run.com,
        yangyingliang@huawei.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 3/6] iommu: Add return value rules to attach_dev op
 and APIs
Message-ID: <Yyyaar/DpXSboA2q@nvidia.com>
References: <cover.1663836372.git.nicolinc@nvidia.com>
 <6da77154f1a49c9c2dc2dc4674b3b91cd19862d0.1663836372.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da77154f1a49c9c2dc2dc4674b3b91cd19862d0.1663836372.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:208:2be::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|DM4PR12MB5245:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ade3cd-f95f-4e88-2c90-08da9cbf609a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fV/CILP7MFjyIeDwg2rqDUYJpvnyeJdcadVJq+Fsx4ZC7Tv7sRv4M357f+rnHrXE14PC9UVGTgt9jd1hfAcv0CPUNg4sH2FQazBSyRio7e2oLou+ZHWqa7/pMBmtfhDL8HB+aMAF8mx/WdviJC1MMTwcCBddr6Ei4K6WGvX2G1X3Azv19TsvtySaVpX2kGrM9s9ffXI8ccayMxMsyDn2b2CY39UDOv8MSl5Kl9q7ncXzVRaYC0g4FIyuntccazEoSFZxmalPxnJZhj7KYzZdBqEULA6Y+8jP+V3+AZzXfooLndHUg/a//nB7fMlIsSJV5Ej2+V+E5Or2TlbDixdHqiyJooSUDP/uIXvv/gWYDSLYzaCRSmdLEOCUI33cRF0pWrRxDb2jDruxAHmDub1MqoEFEtpHPrkDnEczB1S5eh/14/nOrz2XydJW1k5K8bZ045b750okr+nhgbDLhi07rJW2TI+qVLBGtjivIX8TxQTy/o8DBdVzCZpVI2qgQ76ZqBYPceXhOZrWRwxObdxG33avENU/abmugmBusREznk7JHch21ptPW5oYEfRwD7d1N6cRZWKAqg+c1yKa71ovdGbJCGp/dxL+82jDP04QuslWqmnwt3SZYn4nzs13FpqbrYBhQYaPHHJt1h0XZ+Aso65nUc5VDHLFK79hEpP+hT6bQO7sbCLOIPBYGqPWUhwSXMgrDuMzK2r4qmMHq9W98A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199015)(37006003)(6636002)(316002)(7416002)(7406005)(5660300002)(6862004)(2906002)(36756003)(66946007)(66556008)(66476007)(4326008)(86362001)(8676002)(8936002)(41300700001)(186003)(2616005)(83380400001)(6506007)(478600001)(6486002)(38100700002)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Esklfltb0kD/aCuskOFIqONppMlGnE0Imif9ZsyKRWwf1fU0rzL2K/EcZD3x?=
 =?us-ascii?Q?kWu+wiuXifGSM7z198rP8olrrb0gwBcV5L8s0IxbV4kqVqTYD2xcT0hECHWh?=
 =?us-ascii?Q?9kZKSH3GvQk7qygxCrpIQDLvHFm7xLoXiCsM7uCBG7GbwfW9DeN6RBMrAcVd?=
 =?us-ascii?Q?VoFUloWedMGgI29E6RWMpRQGQ4Xu0BQWR2j6WuIAHH0ANjimRgW+cdvVO/ni?=
 =?us-ascii?Q?GRqDTSZRLJpaV6Q4EQ2PFWr5MoqR7nr2EIftG9Q3gnppelMaozpA6wWzpxgu?=
 =?us-ascii?Q?dDi2Jt88KMbPPcC2brVkqB0FPkHuEv7GAGY/kso/rysOl4JggJES8KwcfQJe?=
 =?us-ascii?Q?uStZvoY39aCGomw8T1NmeQD/U55/Q9HEYmSIlIDP9CU4diWhg68hzAp4VQ/g?=
 =?us-ascii?Q?vIzvVbNf+m9ICEeLWaTQUHpcbHsgl4u7/7c5UdzpzwqSH7QADgD3KVchLL2m?=
 =?us-ascii?Q?fyGzuaMv9V6059g/c+Ta1/vR6o6ibPHTWBvCmYI6AuYZeRlxnMBRG9PlzPD0?=
 =?us-ascii?Q?KFW98lzLVbM4cpsJhnMJT07doUh/u86kVmFLdnKmBlJIKAvg++ZngVW4mlMp?=
 =?us-ascii?Q?Vq1Z8NExHv1BrxXyrniT8X5j6jJ/1Fq0x27cavKOndn1GyJpUST5uYUpFrth?=
 =?us-ascii?Q?mF9Wa/UpZQ356dmxm7sfwmlQKNpUEPva+FMu/UaPNPX+wMxO8OTbUYmRyBtY?=
 =?us-ascii?Q?SR/BvjtVwisA9zApbTqLmstrxVVlyE7TVeIRu9paLJOVulOQ5aavgLy4zEmL?=
 =?us-ascii?Q?s6hLIqfv9j7mvtyf96gYCX31RGT+tKrNy/i7vr7J5/fUofIsrdYkvSmw/ScB?=
 =?us-ascii?Q?PdUXh070SgWEziGOqX32RD+pwY/LLmlvN3xpMoXlW9t89mlglMenGeqx79Fu?=
 =?us-ascii?Q?CQj8IkZ4F00PxuoJ0okYUY1we+5Ez9W3QhZoCGtSedfUJixO2OjobudW3MfV?=
 =?us-ascii?Q?msD28a63CxCG+svwwC5hOK4GR/z77AfSYMek+zR2nJmAqPczF7nVMH0r46T7?=
 =?us-ascii?Q?PgLx+clPKh5qh3TR55OJuULuZOqdVOPsZolE40eITZbmWAOXT26IgUJyaYix?=
 =?us-ascii?Q?qp0e9yIzrCZu60NGNsv1qzzbQRJlMk/yTETV+tJHe6vrokZ2Wgc20rMiE9os?=
 =?us-ascii?Q?4q1Ke08jyuEy4oIQzAJBR4kf1BvDeH0a7HNomAgRhDL9QEN398WE/plGIHGC?=
 =?us-ascii?Q?MjztVBaxCCbsB/mgDmMFDGEI2sJRAueyZe4/c8jA7O47NwwSUPntHUgMDQrb?=
 =?us-ascii?Q?VDsAqN+NAUUHKYl8Cv1/wlw9Mto4OYFIWY1z+/Ga3NwgDI6keI9hXVd1s04p?=
 =?us-ascii?Q?bP4oHAqLY2OEMtb7iabftpDSaKG4YYRHVlGcvqbDjunewl7LWAlWpsrz+60X?=
 =?us-ascii?Q?WL6tWg0hfPVPFrmXsCs8xF94YLvNdNsrdzKYKi+KxnpZTfjacPibLq3wIKGb?=
 =?us-ascii?Q?oez7+Hj5ZNELctcAmDIJ59MFBMR6ITAA3N1/Wpi+liIFX479QZ5jLarCQvSm?=
 =?us-ascii?Q?S0BqB+gFiXfqruWLqnZWah3yKlhOO8ZGSCD4IEy+0dr63RdE3Q9NHqlhkOa3?=
 =?us-ascii?Q?GOf77vCXhxsr/3QWHMuygDurSYsoxivbkmS8gBRi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ade3cd-f95f-4e88-2c90-08da9cbf609a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:25:00.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iWwhmr5iEIT9v3p720uii1RHPujHDQcqRCEa8SeB2i7VcF9Oi4imhgwM5hy/0oW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5245
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 01:54:08AM -0700, Nicolin Chen wrote:
> Cases like VFIO wish to attach a device to an existing domain that was
> not allocated specifically from the device. This raises a condition
> where the IOMMU driver can fail the domain attach because the domain and
> device are incompatible with each other.
> 
> This is a soft failure that can be resolved by using a different domain.
> 
> Provide a dedicated errno EINVAL from the IOMMU driver during attach that
> the reason why the attach failed is because of domain incompatibility.
> 
> VFIO can use this to know that the attach is a soft failure and it should
> continue searching. Otherwise, the attach will be a hard failure and VFIO
> will return the code to userspace.
> 
> Update kdocs to add rules of return value to the attach_dev op and APIs.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 24 ++++++++++++++++++++++++
>  include/linux/iommu.h | 12 ++++++++++++
>  2 files changed, 36 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
