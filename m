Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F2B6B28F5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjCIPkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjCIPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:40:28 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926CCE4874
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:40:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYjHnhFlYbWiV29eEVj3TKARTJBykL3Q1YjzldkoF7boB4+lr2Px36iPn1l4kxwsGfEsXJkpKqp1NbPbAdITpfJejF/Mc+qLVUVJenniIHTM9C0QpQ6eQUlZ8VXDap+FmlKT/cB2HSSrKK8VuYEtUX3omqDCe+f8e5nrwgaQvmm10kPIuo+nmqbLZPNQf783AlNSVewrIb2iwz4ElfWJqfvvUwL3sSZ0oge38k4+7pmvndtOGX1CyFZzO/v0H/SrNkXFSL4sVvKpYKMyt9TdSBjG01/6EImUV6JNOFtk3h4Wp8E+FEHZAi/CjDJhhRntz79J/ZpKOAiYCgxhxbQUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcViJPaSusVWbvaVcwtXlXFhI3X9STxOV0wCfWhLHao=;
 b=WXndV1mNgX8/MrmmU7QKZxWq/7dfzJBBD3eDZi4zal1oK3uWjbkAc4BDuds1L6b4I1uo16ZhQ/YZmYl5qcbFJjflHXczuoROXhrlICil+niRPbg7FjD0wQQa0Uw0qtJD4ROy/xr7u17urp3t6EjPrn8ceZsYZs/hjaBESuf/a1wMR4xIyhLlUIkM/PMVaVeJxgR+SlXrxUosbolWya9eVs3GeGXSbnlz2H0QpXw5A0t190qEntjiyrl0wU80Xmanijq8WFYoFw5xW6LdqCkCraJUFy9Nng+rEh4mPXc52U8MFPVzsbDMa8VmHtwbrxMQzKcp4J8Ok7cRHhnp11Clgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcViJPaSusVWbvaVcwtXlXFhI3X9STxOV0wCfWhLHao=;
 b=CJw/1npTNWJkH8FBy3lh99pRKD7BVIrfD4Rqqi0enzd90QMtDyOYnE46D4Neh82QcFtmlsn8/8DxlMgw+P1KhX6T5xeMif5xkFo6VTTQIan2fSeEGS0tPFhP/tDjcWLRkWC8g6XNjei/+ZZFL0mbnpgK+OnQrxf8fHoiCqekCtPf7b6wtcEedhTg72CZI2XAYLaT+DZsOaep+175LVfaSZQeTf6RQ9zqmRMwX1ct9gKRhu0K5JBUJQ5VSymY4Wi+7Ucu9W3wKVyXwrQodqe2S0xPrdcFs/2VAhC5UT1b+OX80S0526g9izNjkWwrQ5AVZ2YtUIInzXtCmKEJutixPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 15:40:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 15:40:18 +0000
Date:   Thu, 9 Mar 2023 11:40:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <ZAn94BXkjiJKQ66O@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <213a05ef06944a55a148995053b187f8@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213a05ef06944a55a148995053b187f8@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 154702dd-1ea5-41dd-dcfb-08db20b49607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FY5396hgjVrp4PKv4WZl9us00q6ZyPpWgY7IvtvPy8KvSiIn3qAn0gZBVW7pP7oSKn8I/6guJMPBqGnreA4Hm7NulrlGqFAAnlJLE+xka0UuFK64JdXkk/DnblUE11XlsoRjqCuzL4QYyFG8tO/0ldrp+QTW8Wl6QHd5Xf3TC9NbTNOlt1c585CwuEnU70ZvbgQAabP8SL34hpuUmIH3+iwfTsU6xOgiL9hOMm6ADqzUU/6blZlauZ8T9vVSHlIOk5evK5cNQUSRMRFpWS9ZSspz1GhHkn7LR93eKyzuuI/L3BF/A37P80Wjr+UI7J4ckChnN07Wo9MqXkCe+IC9/l7UZ6r0+2W5iwcKe76H03ug9oMsqTC42FBEs44hbeZwCSWhh3OKxxrHUTJLRUOSbXnFtfUgvmDwNZlWYE9bMkeIJds5RcKTuzOriNIwbL7r17RHDINuqyhlJZcD3lTjgIiPtbZtszTnveVWd0dJmJK/D//dibqTN6ZbvqBoNzT2tJQLpluCi0X4wB0y8AKLGbknfsW7zG1YXlmt4aWyOPXUdnV9Zkn87c0vOLvQQCQhTuSbYARh02cspbBLvO+7TX2QN6P8s3KaPwpwUIeQ6ENoTYZvBsLoXEM6GP1aJ9vgOOWqeiCg8dZvkQEY5+kDkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199018)(2906002)(7416002)(5660300002)(26005)(8936002)(36756003)(41300700001)(66476007)(66556008)(66946007)(4326008)(8676002)(6916009)(316002)(86362001)(54906003)(478600001)(6486002)(38100700002)(6506007)(6512007)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xCrpAjvriR2ILp+kxw/7Zc8zvtw89k5F6h/8Qx8Qwo+DP+g4isQFOfoUC+M6?=
 =?us-ascii?Q?oYnv95uTqkVswk85JvBZAtRy+LW5WttAkN2H9CvOKpo+UuWS/9xKvcj5Ia9t?=
 =?us-ascii?Q?4aKGN8jXKqDbgRzOgQ2MpIdWoCDATSqSWAa9j+63GmBfGrUSpUC4RQSorvLm?=
 =?us-ascii?Q?91ypuKeIcEsMUtKSDoc19Wv+MWOQQSRtarDtD+9Y9crP5ITgUxhrG94BoJpl?=
 =?us-ascii?Q?hq5P7Q5fp0NXjhyw4/GHjKPW+XNaYTIaH31IyrhV8FosI+gsipIoFKt3vMJA?=
 =?us-ascii?Q?6fzMzsUwZDa3GIWZ/kovBvqJYrp/zTKgyMiKZtEeRsHDQaua6yuLuARlXAH5?=
 =?us-ascii?Q?0pl9LRIhNf1dmSIW8j5iv1zZrz8PjBZi6Z8VvWAQDBaMZMhoB+edeVylDSJU?=
 =?us-ascii?Q?U7jc/y/eR7WpxBxT36OwCDXFCDSyVVlYUswjDg7x/aPnkGFSuEePYBx0o/Ci?=
 =?us-ascii?Q?D7N+sRAM1ZpIxN7spKW/M9UHYnCU8O5atDoG/xjN2wuZUVRE1HcZ8vH8YhJ3?=
 =?us-ascii?Q?C4QkPp9AgZmVskGAGT0qda7JtHGV5AeekEerXvLTjEN4yzk8Cbjqqene18o1?=
 =?us-ascii?Q?aR/s0DMKd/HzoKDWA55t6TUFvqHgUR++X4ixMdJySmaqEjXe4uKzbl5RVwhR?=
 =?us-ascii?Q?6qdAqCmhGLQ0y8aJ+nL75ajqXMrKgebrmbvVotMA4oI7B26q6Pk3n8qHYwvT?=
 =?us-ascii?Q?QEusLRX7psfEHj7rQNUTlew6noHcqm7NU4vdF1S8e6I0ijsWRhw3G6GbIDLj?=
 =?us-ascii?Q?YXujUKXxuW0cZJV65ocJAL1mUu8/LYouRKc2m58W2Qa+G8oDjzhzDxldytL/?=
 =?us-ascii?Q?HRiEJrZIddkXSyYGxDF73YE5X1aHJt7qoAPZhga5RMBrfGQL/zYcpvC8P5Vw?=
 =?us-ascii?Q?CH/xshE7gbvQkU9ekP8vfBDphAEkVqkdqHL5PU83ZxQ+s7O/Mi05lPJpKl1y?=
 =?us-ascii?Q?iAwfV/jDW0vUbY3AtFbMvoZWpMFfoLOfQ81L1hyuW51OAPLhOwhSbPAlDdwV?=
 =?us-ascii?Q?Ex44nbprV9vRHOY9iurfWnhlAeOnbtUUW4C3QrS9h9M199qVLdaFW2aU5qRh?=
 =?us-ascii?Q?Mhns2TOqV/ZFOqyjG/WOXdq7fKLX3hYy36ucH+ksNSuGWRUQePtrGF/oBpnP?=
 =?us-ascii?Q?5WkGAQkCchCiw56k80oy3eZFOI1oOv7tEtD4li2QK3omM4yN3aJfGi5Egqcf?=
 =?us-ascii?Q?LVo2IIgin1dz5R1UwM4zzh8fjT6udfQUaohpRM47DGOZD3PJISjq+srOjU2Z?=
 =?us-ascii?Q?R8DKbyuFSHeZ8QRm7yLmfJ1PBhu8e5mmCv+8BtFuBaPltnNbMI/E8UCfKraZ?=
 =?us-ascii?Q?24SnoqdAMnewCgz3viaohUczcVMBeO3Q44DNm29pry465qwCjeSgr2/omU1R?=
 =?us-ascii?Q?psWOz5+iNIvVffiDaclX6xSVlY6xaKcItKGNxaYycFu+aGlmnlXXH0qn3ZFM?=
 =?us-ascii?Q?G1UBNJwJLlZ+8bFXnGlhLg4/GxsJC+fJoKtBEp5L4q250OgwXO6g0KIBIX73?=
 =?us-ascii?Q?/jVrznryz8Z+zuZL1ciUxHwA8zDHogeqsG4d3HM+RmZjE6oeb6Ed0Xpm/lFm?=
 =?us-ascii?Q?ybgNhyLA4phP7AxFAtrXuckm7aw/biX48VWuZFbO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154702dd-1ea5-41dd-dcfb-08db20b49607
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 15:40:18.7606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZBX3gkI+QAkkzKzdIR9GlU4FXDvJraToofRQp4Q7vg/eQervXP1n4Wfd7uRhJBT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 03:26:12PM +0000, Shameerali Kolothum Thodi wrote:

> On platforms that supports BTM [1], we may need the VMID allocated by KVM.
> But again getting that from user pace doesn't look safe. I have attempted to revise
> the earlier RFC to pin and use the KVM VMID from SMMUv3 here[2].

Gurk

> " In the new design we can require from the start that creating a nesting IOMMU
> container through /dev/iommu *must* come with a KVM context, that way
> we're sure to reuse the existing VMID. "

I've been dreading this but yes I execpt we will eventually need to
connect kvm and iommufd together. The iommu driver can receive a kvm
pointer as part of the alloc domain operation to do any setups like
this.

If there is no KVM it should either fail to setup the domain or setup
a domain disconnected from KVM.

If IOMMU HW and KVM HW are using the same ID number space then
arguably the two kernel drivers need to use a shared ID allocator in
the arch, regardless of what iommufd/etc does. Using KVM should not be
mandatory for iommufd.

For ARM cases where there is no shared VMID space with KVM, the ARM
VMID should be somehow assigned to the iommfd_ctx itself and the alloc
domain op should receive it from there.

Nicolin, that seems to be missing in this series? I'm not entirely
sure how to elegantly code it :\

Jason
