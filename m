Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD16C4AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCVMgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCVMgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:36:49 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9E75A917
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aB6cHwJyB5rGeiK4KtPWsIQAGMeEk+n4K9knVOSg3EORycIDdpvrR+tayiqpykTr5QLLp3fi7xHRWE/aRlUXs2oiwL30tSblIFsbbfm53qQBQFXR/Z0/oG9uROARjbtPNVSqMZ4MYZNrVb2dZlLzm0SEsPyRpTl9btL5xI/bKglK/unXTCMHIwhdjLqP4QEP+l4LtfRUncNntnAckZfne1MNJmX4fq4+7lNEj+7ZMh5mX+kV8XK9kkgFybNVMYt+0Ue8nrogNmz8Cgsr6Xl8UawO6Cj+WAaV5BjKPRtTGf/6Wg/6x1ikcH7MFt4PF8YwLyhmEqIqs8i6TIwYGg6mQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3d1oJcjypr4KuUtbHXOVSXCM7Y+81bpDuhVaaG40N0U=;
 b=mGIRGJSnpTZI0d/e4G2D/FMZTB1qCnUmpMTkhmzVbF5B5sfX27f+48T8NEUDG5hrlt5SBD+0cCMqD7M9bFJ06buOdlJVRx0I9A3TBul37sO5oXCiu8laPCJq/kltCzWfgqDYLWiPFGvVPRvxu26zj07oHaJebOGS9rTi+fVdI70G4uUrJU/5/dBxUiIcZEyo+MMKkrxDZE1FS+E6s9ITqHq3JGZsfkdH/BOkk6BttpProjIbQE7uKlHoNz5gCwoK0T+M3bqrEa4R0mzJkx6CwmJyMyCsyl/DgkpcH6UiQHguLzq7GMVFiHM+AADo/Bc6nvWZJ9PAdR8LwDvSEoqEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d1oJcjypr4KuUtbHXOVSXCM7Y+81bpDuhVaaG40N0U=;
 b=rXYAvXpEIswrV5t6W4Tu0W+QsZhCGKHCr9mM3bgKg2f9dgcrCUbikyXM2uVDB55NFKGw1zPqW6pgk6Adi4s4qM0nOzZpX5USsTcvCMeRvWGLPlLe9VCAXxzJPEePCKvtab4YoUyqu2wURotvLh+dmjtZrsruSrXo5/GUJTH5fsqizGHp6g1hUzbYH4gbTN6KsJabigmGp34fLprR297yVprTLtFuNLuSXydfHiXyIOM+CwiEt4vrLsP/noUqUQS9LphfjmDcwiwWybjaRRaYsf4OkEc+yG+n5ysRBLcwrRNBo4TDvvLzE+h00VNImVh1jfTRPBMJ7qKy5lR/aXj3uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 12:36:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 12:36:46 +0000
Date:   Wed, 22 Mar 2023 09:36:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Use sysfs_emit() for sysfs show
Message-ID: <ZBr2XZr25jwAp3kO@nvidia.com>
References: <20230322123421.278852-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322123421.278852-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:208:32a::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: 64654f78-e480-4f20-a156-08db2ad2193e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xMM1EBVrBmDr2kYml8IBtO0deAYED9++71j5n7/oObZulKFGQtavYGCN7QI8rmN3pJOBM9p/3A8yl5jn8Wv5vfF+zuCGBdNq7DVglgSi9prMkuvDF8AjoOdAhgs+ECdeB+eRSBCtC186VmGnWqjNoOz9fGbtUp3v/vp7B5uoqwIQqJX19amgz2iE0BHaK/jDzhaDR+1Pbk8s84ljSGbUV1qehZgDEy6nsLS1GUH9mRxoatAvaSYFIyREbsF4AVZRSAC6vWlpuBZXnBFohTd44eK8ujQrX4fAzKyc2kOOyPG/tUM42RqDzSTKJMX1slOX18Xo3AMIzrRKDdAvqpnXE0vNAQnvzpEwrglRF/UJDBCr70FlNbryfVMKpkOnuMFXQkXcb2dzD7hgQKY4J1VPZd6uvmHENRc8pXyzyOyqS//yYnBvhbSzFQ80gjt8nZLbwJe4VFG8a+j0LN7optZL021hFKjUIWij4yLcYMM9TntP3Tw0JLkm5sJJjwIzT40Lt4GDwHuelPn9CrHHdT7M+9H7SJgrd6rD6x5fKM0xXw7Z21oCbj0b7CxhsL8pGwssJ6hAsw+Kq5GnL+aXyk1z0YrOATWGBrSlt3oUHUctNnWdhqeo00QBqREPmvXUL94stG5DBXFs+8cdwIPY+lyoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199018)(5660300002)(41300700001)(8936002)(38100700002)(36756003)(86362001)(2906002)(4326008)(83380400001)(6506007)(6512007)(8676002)(478600001)(186003)(26005)(6486002)(66476007)(66556008)(6916009)(66946007)(54906003)(2616005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AghIFUg0SJJkBShgCiFypbu8NkM+3+mnrggfDo13DSRMddlEAF8v+JUpMtfV?=
 =?us-ascii?Q?Mm+ie+GzN37r3FZTcOQ7AqOrT9HJXpQpNqYhAb2TDYPYlVHrcBjBwPclkqbI?=
 =?us-ascii?Q?Jbnz7vUWbL+TA0o6mo8Q80EuS0dTpsL7NELWqaC7WBQ3CGUSGFNuLcak8lwl?=
 =?us-ascii?Q?4BmRnKyMsNyfvmtpuPzAnAvMOovcWXENRbOERVGVyTRMZPq5OXg5u4Pi0xQx?=
 =?us-ascii?Q?OTk2TTu1odrgNziBS1IQ/VEsR/IbSrkIIDcrJasmI3uzWygVNs2b1aH8vDtU?=
 =?us-ascii?Q?LRt2C93UZUlFWl822gpu+IXcNbu3xv6uZcgKpVnjHY6EybmeVwtWmgoRk5x6?=
 =?us-ascii?Q?mUjUNSk/zWfBog7iqOas/LPiQQKpOBEnY7/K8oDMVcPQOnxWIkCpJIl79X+G?=
 =?us-ascii?Q?MGn2CyV8gA4zZX7JA4hAiKm6L+5/JHXD0ecmXh/wlM9qrSRSZgHsXfy27/wj?=
 =?us-ascii?Q?WtqwDY259OCRtFv6eEt4P32xM0dgZSVAlOzfLq+DTRCW57YNpSwUlZXStdqq?=
 =?us-ascii?Q?BB2e435FHpSSKADKHERkKMfE1iec+hO4YPLmt0F/rlb87hPY5+elwX13H11K?=
 =?us-ascii?Q?205MoTE3kk4DbpEp2WWeYlMqm4wnhFp532aWX7sCp9Rt16pM6K5uPSqZHdxc?=
 =?us-ascii?Q?rNW41HlldKqSpz5gUXwcudV3UDvh1SGFplWYpSXmnXHyWLN+OVD1x4Ltkw5K?=
 =?us-ascii?Q?GDYmbDygVsPgWtEq9kAVWVIndok4l5D3zicYmrVQUsIl3eu4lGRUZPRqWxrL?=
 =?us-ascii?Q?DBRjM4LlVzRce2nkPHqxuaf6GeKUrx8YUOjccBomoNl4YelIID4c5FS1yVUc?=
 =?us-ascii?Q?9kiVjnOmj1dut6M3zFuGUmdkAMAtTJmp/x6g1LQipoOfliUMUO9QMlxWM6ls?=
 =?us-ascii?Q?Bp0mWGxTAPUDo/fYmebrN2m6c67rZihjKwv5z8GzSseP5rLsRMbzZBxVbriX?=
 =?us-ascii?Q?VVbET6wrdtr3rOUExz8KD0I7cZcjPck2gAhlhdJyFNw08CXH+cNueXWQxN+0?=
 =?us-ascii?Q?hqwRx9J0UrXvHrIC3wjwgUI6p7vIZX68baP6VJt73v1TfASL8gsPd+MAVic8?=
 =?us-ascii?Q?g5FXI2CmuzMmgR/nkm3FCwBs/o+3QmvymeaUzYkAu/LAeKLS4fhSFqpbvAne?=
 =?us-ascii?Q?LuK8pzK5V74qrcfvv009pbpDzLh6jZmlxsMqW/9Du9uWkhAFdwty0A7lw6xn?=
 =?us-ascii?Q?IhyNR7PajIoflfV5pATK6YeDowm8bp/V0aqbpL1j67LUyQ2VHzzQCwflq+eh?=
 =?us-ascii?Q?oeMeVGQh+xaCDHTZhO/z8qcss45u/KILOiQ3LVMyDpquau/1RqinyabwMMuw?=
 =?us-ascii?Q?70MkuHyUWKPzsbD4yt1wpsmSMBGrhCYb87Ztjo2il5R2iAVIk7tq3E4M3pMO?=
 =?us-ascii?Q?h/Ag+j6ZyNfRbCgsM4M0aUMuyleCkIhj5yvQcvqcMuuBScQ4IyUYbtAaUo6V?=
 =?us-ascii?Q?owT0/IBwKXav9uPmlvRHJ9R78cZZeWRxcfBaYwPqwwfWLG+iny7EiF/5ximO?=
 =?us-ascii?Q?g4lh3yxMGnwVRBmW5IDkpyO0OkQMaCN++5LdSs9JuXGVzU6edpgCazSgV/oL?=
 =?us-ascii?Q?gxD6aFOVHesGw7G2r4TA+s21mAcx3mMtjdgxt6sS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64654f78-e480-4f20-a156-08db2ad2193e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 12:36:45.9496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tumHJChtBee3tShv6Sk/Vf7cbqyuAevWJbdZme8V9lBqtQsmgeKhT1VtJVE+xvr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:34:21PM +0800, Lu Baolu wrote:
> Use sysfs_emit() instead of the sprintf() for sysfs entries. sysfs_emit()
> knows the maximum of the temporary buffer used for outputting sysfs
> content and avoids overrunning the buffer length.
> 
> Prefer 'long long' over 'long long int' as suggested by checkpatch.pl.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/amd/init.c    |  4 ++--
>  drivers/iommu/intel/iommu.c | 17 +++++++++--------
>  drivers/iommu/iommu.c       | 31 +++++++++++++++----------------
>  3 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 19a46b9f7357..a98202018140 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1941,7 +1941,7 @@ static ssize_t amd_iommu_show_cap(struct device *dev,
>  				  char *buf)
>  {
>  	struct amd_iommu *iommu = dev_to_amd_iommu(dev);
> -	return sprintf(buf, "%x\n", iommu->cap);
> +	return sysfs_emit(buf, "%x\n", iommu->cap);
>  }

It would be nice to add the missing whitespace after declarations here
and other places to follow the coding convention

The conversions look OK though

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
