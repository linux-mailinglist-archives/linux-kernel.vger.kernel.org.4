Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AE55E6999
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiIVRZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiIVRZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:25:51 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7988A8947
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpqZc/qibfKqYSVwS4DhVPhDAya3fPy9u/CanDWP6yY9YFMdKrnkpdgjc3KJEwMi3U6RFgCr5/IM9M8nU1dE8H/gunGI6t54mYrV7ajlHvtPNvsY5OULh3zmCypDdkVbP1kJy94k3DKYhjW+tir7LxmvVOZec8c0HHgKVCkkDWBKWhm0aGGwQWEbNax7m1M706nmGbiGsmgoBXasEdzA4GHeIMhoplj/AmxH+Hjbupq1KsiCYzymwlxpMDUu5rP/1XrhmT5Id4N5QeKbYebNaz2NA9k1cb2HtWJmwCKpGLgnQsa+ECRHcBQjVGadZsMDKHtkZt0voSoND6wo+YhUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANS8MBy3vKE2jIOBtNmIWbiL5IvuYRzaRIBHxxAF1rs=;
 b=cVkXeWa10kjPRZKog7gfYZ9mCdFSzK6CT+Y4HAQkwoPN7+CLDbkmCNApOJ48KGgl4siWGl4KPD/L/y2+/93IUyeW5nHMOfR1fTwpOp3CrX4AQAvfnu65AE37Ka9F+Rcir4ZBgiXfHuoVprC+aZjrbZ/JnCI29a1t7JZv6H97HqSsO25FeXcurvKcXgh1Kv8HeUFl16/E59a4iJiyfGLbANwjd6wDN7u6Xdl3xfySYKDAm2yt8u5/PdgTuV1qS4TIcsS6cy5RrEoQiy+RXInRjYFFeDP72M/W4rXB+VgeJ4TNeK/Ns/C/wMtXgLficMFMjRB5dIDrbSucKWoHE/qh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANS8MBy3vKE2jIOBtNmIWbiL5IvuYRzaRIBHxxAF1rs=;
 b=Wsz4Go/U32nVkKqrIHJd4YeRb5mNx93gCcKaLXxctfCCvTuLf8VgdajPhkFWsHrtn7jmZZUEkWt0Kf9eumfOg8WGVyli1/3nPwMuFKhOYOd4yLxDmLnWZkMuyRMhvXCJUqb/SPDXGnb5+3RcAB8oj/3UXLQ3ISm0OfvAeJx9ix+UiI3nvuAG61CuHyN7lQhVX2sTMFHBb9OYcXOoruof6e7IvX9pcUSXa2USbzw+8kaTkVSxMV9352guxJrMP6QFpTC8HjAWdmZcW+evDDCSThahYdCnLKm7ICcMMPNxO0NiIkV9q8vKWLqogw84x7IcsFb2Fouz0P1hUgLmCbR+kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 17:25:47 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:25:47 +0000
Date:   Thu, 22 Sep 2022 14:25:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        yong.wu@mediatek.com, matthias.bgg@gmail.com, kevin.tian@intel.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 4/6] iommu: Regulate EINVAL in ->attach_dev callback
 functions
Message-ID: <Yyyami6lI/8lqq3x@nvidia.com>
References: <cover.1663836372.git.nicolinc@nvidia.com>
 <1316cc05c7b62f32a3012957220b87dff3317554.1663836372.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1316cc05c7b62f32a3012957220b87dff3317554.1663836372.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0113.namprd02.prod.outlook.com
 (2603:10b6:208:35::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CO6PR12MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: b2838e34-4b03-4bb1-1bec-08da9cbf7c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6gt5sVrwnwMA/k7ef+vqRIvg3UBM1/eHX4HEmfLjFA0u8BcOSRehMW1t+j1Eiiwue17cdyXfsRNw63AGt5+UuWV6Jt02Xr0IHSpsDjnwTRMjSoJm67B8rudN4CaXk2jwNbflDz6H9fQgAGgECDrbKtiLinLc1FI6KSnmaxGgCxip54I3mE1f6RzKRiqzrzqYc47Zbcex6fVN0O0owjZWPMO+3oXuBREWas9vYo4D7JHGjjDOA3DRTr0oWdEc2xoFieZrdjbXabijX9Qw4w3kSZO63r5sELAs++4u8G0JnzGqX9qs061ZAmhHHe73ZLQn2ZYH7oZPJhKej8Mk1jw9WeWEXyUeAmt1xZA0WW8RYykfy6+YRvfvuuShiaAaoFv91o6h4sjRM9mmdjdz+ugh8OxfAfxspsPr/PYS370ioIVPEDVR37bnCor8W6/U+GeR7XKGu3XE/UgBNYHA//H7OT8rlcCLbXuDljB4Q4S7T18c/DAoFitwAFbSuW9Xk2HrualEuwtZSlnsLPWYR21r4jEr1z1cEG3GngFSKoeI+kEQRgmPvrBAeVyP5axsr4O0TFgcHTiTPawbb7T7iazPGd8aL5CTB14Si149zX9wXu6DiYzBA5V5Gj3sPnBSq3KbNfuhYLQ/65HlQDKmM1T93utncwqM8dEQrYhkImSKr0xQcIjOaLLpUA7kpFljc4IxMDsVhUdL9l9zq5XU1njHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199015)(2906002)(6636002)(36756003)(86362001)(37006003)(6862004)(41300700001)(7416002)(8936002)(5660300002)(316002)(66946007)(8676002)(4326008)(66476007)(66556008)(186003)(2616005)(83380400001)(478600001)(6506007)(6486002)(38100700002)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8uXZ9TJuGdX54WxLdDtu+mNSgVzTrCZ5fSsWAFgyYlVq8Jk8YJjaiHtKKACR?=
 =?us-ascii?Q?gIhFmpj9C36MFUvzRUTiYlEb/TgmTQ7q0VDBHiZpgeqiPxr97pvrTF4yM2Ap?=
 =?us-ascii?Q?78QZlnSQCfhlTE5l5FOLevyk6RRfqor8n4SuNqNjK7RTALjLbwN0MLIZebIE?=
 =?us-ascii?Q?qgRyPSCJ+lfKJogfdvNoUHEqiON/VWQ3U2nSMA5rtBy+NZTtsqWM1RHMGVZn?=
 =?us-ascii?Q?QTwfaaiKpmFIpRMYHlBrsCO1mEhgnNpcXlLeTZEOcQt4gjBsWAPG63Bzj1vJ?=
 =?us-ascii?Q?0LV/q7bsWuUySyjmVJHLfz17I1xYs+6BxFJRPcm9ZjnV/JSGqk/KatASRXBu?=
 =?us-ascii?Q?6J/HGXgWmzGKZ7/nvtjBldQjZVcgCgO9pnYkG6V3IQWhzkZ9nN+sBK4brM6j?=
 =?us-ascii?Q?uTm+bZLVjwZAj2XZgaO+rzSnK4XBwUmSQfMKuwiki0tTGqdqkzcZQ52SjFUG?=
 =?us-ascii?Q?avWNJD3mR3bGUwcpBzXXVN3ssx/PxQAiCj2K+0cHpq3IjJM8uoLbveoUWPjq?=
 =?us-ascii?Q?m81E39zbaxdfoZ/qov3bhS5VK80zQyqVYDeIJxPFq06qdDquOwBqQ5V6l8to?=
 =?us-ascii?Q?LHGhNb/fPfaPfcqqtqu5PSNQGxxr88dSXU2BfJ6fu64eumEktyzzmgPnLiCS?=
 =?us-ascii?Q?tf2T3PYmk3K591oP+RIR5M2HogVK0BXPSPgKG8CuKk+l22LAKmwUSqNKlubg?=
 =?us-ascii?Q?ytuE7Ov0RWlFpyWIdVxdxKAIdR2uXZ0NjmjiYcNtfIb5PIHMSMYJSqK4PlBE?=
 =?us-ascii?Q?g+wejYl3gYal/n7PLJT+uIA1Wuq3TaHdPlOmGy+pR/xGYezy1ImUPxMnRpFv?=
 =?us-ascii?Q?0qH55gCHaIQngY9gavLrH6YJ26oi0TBctXaXi6N7ldHiSpkbpUER2DQYJ/5C?=
 =?us-ascii?Q?K1sl355fDXwDz3e95wPxHIwxDsL6TeomE++Cvk4p3kxpa3mAeCzkPZgFfGDN?=
 =?us-ascii?Q?FEwlNxjvdDOW08/irPuRc4OkgYTc+innjMb8YCW7Dw9Vk84zPmKZejZEqqQm?=
 =?us-ascii?Q?HiBBjI57ygBtAwq8s/ZhCT56C9T/ApNHcey4R1zWiQ4mUIwS1xaSjqrKBoJR?=
 =?us-ascii?Q?NwGr1AfK2cyl3l5duN/Z9zsRf0fyxaazG0GcD/8IANt+auoCMOq8v35ohsSY?=
 =?us-ascii?Q?3NPi1xspDDDHhOnr/bTFEutwM9Qwkvl2okO1/Vyne7FHvJdcVOWhhkTDvUPk?=
 =?us-ascii?Q?2bIwCRH1n2kx7lLStySbD66YR0pbN/zolUV2G40UsUu8imPRIVPMSONEgpr/?=
 =?us-ascii?Q?Tf9z/umA9wlcexao/PH+L0V62IF0eCy4Wmr4/sI2b6jurYFQXPGO+zNAubFb?=
 =?us-ascii?Q?p/xAtoSErQkGsfoC0cAJGrgHcoTyaUz50vTz5gFmC7IcW0r3djiJoULjjf/q?=
 =?us-ascii?Q?oTztcAUQmvCcTxmjytvOQs3zlNdeWti+EUfdA8lWXyhWz4vWQlmyjvh1Wfa/?=
 =?us-ascii?Q?nG8oEXIL4Xao5QKj6+nu6gNAwXCbjNyBWVw3Jqk2lR4ggRdFvd6HYk7kJcCi?=
 =?us-ascii?Q?pE2NNj7C5qoma6ehpwB+n/Emn4trKr/dsy04BBmWW+oXJc/itpA6s0rM4Jqq?=
 =?us-ascii?Q?TWhZl6WMe5svImLl6iESr+ddjh3SRxsP1WdtHmsh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2838e34-4b03-4bb1-1bec-08da9cbf7c93
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:25:47.0767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slDnPGcsYkxu0gR5kyI/hbFNJ7NWap1x6K8q/WCW+RF9kJ3pGeddd4vqjALuYCWI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 01:54:20AM -0700, Nicolin Chen wrote:
> Following the new rules in include/linux/iommu.h kdocs, EINVAL now can be
> used to indicate that domain and device are incompatible by a caller that
> treats it as a soft failure and tries attaching to another domain.
> 
> On the other hand, there are ->attach_dev callback functions returning it
> for obvious device-specific errors. They will result in some inefficiency
> in the caller handling routine.
> 
> Update these places to corresponding errnos following the new rules.
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/fsl_pamu.c        | 2 +-
>  drivers/iommu/fsl_pamu_domain.c | 4 ++--
>  drivers/iommu/intel/pasid.c     | 6 ++++--
>  drivers/iommu/mtk_iommu.c       | 2 +-
>  drivers/iommu/omap-iommu.c      | 4 ++--
>  drivers/iommu/virtio-iommu.c    | 2 +-
>  6 files changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
