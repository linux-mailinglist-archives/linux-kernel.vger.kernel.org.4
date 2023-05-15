Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4A3702D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241984AbjEOMxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241997AbjEOMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:53:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE9119B0;
        Mon, 15 May 2023 05:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf/XDgmeC/c2tjfg+3IepILdkQsPDfo5hE4cjJlwwNCVyTIuFCYgctUKR8QgFYcQ+v3kmgwl6ymugqw2vq4hYekewyWy/CTm3a1B2DVoSTPXGc9a3/V5LeO5p8zZGk13oR1qFZtacgEr8MGXaAPsC5PfJogn94Giqv+kVskAdmUKVKVUCHhZr3PeZQCveGJbXbVsSZ9Ht2gmN1FdcTtEzidvaut7CbZL+LAK3xi/cMPCGQ7BTirkMfMEtd7NEzxTBH5cudqai6NhgNpvCMEZun2/VVwtx0TPVsN4rjoCjyRjVUtA7b/cyq3PpWmeqpeFOmlNw0hMR9TVDIRa9RRKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBxb+LB+UZb57+yoFLgOexFTdYydINGsfsaQzyjFU3g=;
 b=mvbG4r0UGALb+Yr4YNaRQXJDWbIXGwHZG3mEF2ZhCIBXc9rddN4LEZrV6DGuESnbIn0wd+pY39UC6fOw7zV0We/YH1Jc8UBKt0RjICg6EI3Dy4F15OpKT+5twgveU+Rb7UtD15jZdOLkMBBNiarjDtaL2yN4EziEtUmdu+2UpANv3L0nk2U+4eEiNmxpZkTo44M9WzOGjqtFryhWaAlEGFu9K4sDrj1Y6X4X9WAIzwMKsPPGWq0jiQHmVLgdVUgp2qrr0m0oTdOZh1iv5J1pxuvnoKenukQEel4HNYAaKVVZrFIeFCmP3gb13ze5PkRgGG14DX/FkIyyiJRnFL0H3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBxb+LB+UZb57+yoFLgOexFTdYydINGsfsaQzyjFU3g=;
 b=Uj9ZAgfORYoQhEKBL1aFnaizCwhW4t8qCe0QJfXk4KeG23oHz5PLSeKrEK5ZUdFsNoyy7qNI4gpgiFItkrX/wBLcmjkLm//ZFkdQQXddsg0kj9NaKedm7mDCpURZ+3kIJ1tfL6SvWaeLCEE1F1eogX9EvophFTKUNLksPDFoWtoi4baHr9ITfaMzpbCHQFUt+3APUNpHsWKLCUwDGDzdbFdfm8DLFh/YoW9VcygZyLIyb+wzUqNq2D0TzwCDCP/wm4aBpHOavEVb5hae75qpKkYRYAP/fNTHaB+81G1jg9fHbKy95EFFlHP8Mc3994Z0m2PqufIxCg+Znk5pDcINMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 12:53:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 12:53:13 +0000
Date:   Mon, 15 May 2023 09:53:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [PATCH v3 07/11] irqchip/riscv-imsic: Improve IOMMU DMA support
Message-ID: <ZGIrOKIT8uHcNqbQ@nvidia.com>
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-8-apatel@ventanamicro.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508142842.854564-8-apatel@ventanamicro.com>
X-ClientProxiedBy: BL1PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 00550ee1-165b-45c4-cb4b-08db55435801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1WI5U1KBM8oG4ucyLDOtrAjtWFQ/oGQlQ7QP0qp7jbf+XASD5tmcDIET6DGt3KYJ+18fKVX/XoKcIYbhGBZn4LRXfbTlg1NQzcmPqBSOxGFVbyFelwhpwselgkFbOESGriZKSLxU1dObBs0TUh5pUqmNNwpIIpKh1cP+shRjpve2JvP6gl3W4ydBMg8yc8/LguwbOtkoaJXcxvuM5Ci4shyez5H7jcqcaHnrDT9ShAEh1Hky2Y3dzqzvjF7yzlo9l580CAvSQI5+JwGq7oETFABmYcM71kvYusD+qlk5PGo7pUWO7LyHJY+FeOoOfVZ1RDxggPuVgmJJvkaAFM2hX5LNVtTzr0OkvAT0m5ozJXCZu6thB9Vr80WjBLPfhrCR6OX3ehckzYp67LcDFYSyW78hoQk7JJY7/Olx9KgaBpqqtARs1CNHAukICh9zjltxMu4E26kaDCp0EQx82f3hXc+08rKP7Pp9g8YiYBoyQvpHgHR8fTlQpcgY6aJmWdZhJJ88b1rgG/Zansk6t1pcKBk2fNSw9OdsatD35dEk19rbfObP5mHuwqJlG7K9qaX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(66946007)(66476007)(4326008)(6916009)(66556008)(478600001)(6486002)(86362001)(316002)(54906003)(36756003)(83380400001)(186003)(26005)(6512007)(2616005)(6506007)(41300700001)(2906002)(8676002)(5660300002)(7416002)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ad5uCHhRgXiE4Y9Fm1eueDCMKoaDDB08Ktg0Y77lPmbJ6Il0sUvjgXUM6Xum?=
 =?us-ascii?Q?ZS7TagOGghAoIuqB1O7Xh84tpUUbc2DMe28bIP9qjzXa4eZNaxHIknek67Z7?=
 =?us-ascii?Q?SiuRrYGU4du0R9CEq+wwi+j3CKDqR6vR4iQkWOMKt5oha8BbRn+3yL7vKS62?=
 =?us-ascii?Q?8ovrt6+CvdJVuYXXyIg2dxdXSmLh1lqwQehd/7CPXx1VZpRsyBK1SntIV4gb?=
 =?us-ascii?Q?vplZwhXbd6XY8vxlb5mcCCTbLkaG0cnIdVANii94UPRZgrUvDakkCrB8Fzi9?=
 =?us-ascii?Q?9AgoWn1pgEojutlrX6cOg0Z51uJxZ1IFiVaQtZ3hdEw2pHfEURYhKPqFnERz?=
 =?us-ascii?Q?r+zoGmeW5FOYlEW+9+zqUQif7gq3Fq3LLyOJULucgxS21EfK6kSwjx+UpPkl?=
 =?us-ascii?Q?H1uJAYZx1BH5unT1wpKDGSNU+O6jHdewfWt0a+DFlLBNtQ62BVMrdfIk4tLg?=
 =?us-ascii?Q?Sq6oqIsVt4AEJ/R+9GVbl6yKru2byZYM8NmsuOC0eJxJPWeEZK7SIBCdP0OZ?=
 =?us-ascii?Q?IXLpOohrCjS41/1qR5xVt2UzfbwbvYvRbdW0/xLS6r00y662BXESKP/rwdS3?=
 =?us-ascii?Q?4/6RXleTy7kDfWPDGsVrhVXB30axjv4METstic+sR+n1qLGG4MMY5HVsBqNk?=
 =?us-ascii?Q?dVeXuFoBDOIYBJiWbpjJjvSqH5gzVtgojVhDLVnlIWlz1nE1hGGjvSX7uvzn?=
 =?us-ascii?Q?kp9lc+yweUOab6XHGvPlncep7ulk4Anamug3psCnzwfjU3X4vAflLHTufqIT?=
 =?us-ascii?Q?CjV5edQ/g5VHo6xSSmN2CIAFmPm67FKLj8NvFlm3h88vUDRiJ67INNeOQD0X?=
 =?us-ascii?Q?QmHVMHvd4Qo8jkwTXREotOuon+uJvgwEhCMV8qqz76txjBFCXkTX5rV6ePWT?=
 =?us-ascii?Q?Bhqp9gw+2otV0faa+J+JVeUcHMw/AOuJ8j+7BPKhNvWxXHqv+S+LZo6pjgVt?=
 =?us-ascii?Q?+AkCtc3iHc6NOVrKolZPi0czD9+sV2FBZqBW5W4t7QyDHEtVOoIN4BtwZFHY?=
 =?us-ascii?Q?MroQC5EZRygZkrsG+IFmfbv67FF8fcyWBQ+3LB70aIrVz0KlNKKJfopq8YYj?=
 =?us-ascii?Q?3koPEjn+eQyJ8jEd8lR55xuIrLEPWxZvymiuFzD2r/Ii8NdAFgdHetzSHeng?=
 =?us-ascii?Q?GHzdJd1GsM2pEyQM7YKXTaf8M43hV5O9SqpjMmsDd+2T8LF/cPUV0K2rnoQg?=
 =?us-ascii?Q?bIRCY2JchpKlMAnkuJW/Uwfbyux4VT7Xdn2PgjninLVMjQfzZZEuIheQr7db?=
 =?us-ascii?Q?eSg6KxlwgxB/l7t+DgY5PwktEzHay8pOM6o5dQuLIP5DvMMYQvFWvyEatkSE?=
 =?us-ascii?Q?IG77XnO07+vT5aixktajFGFEDKqMYKLgHc4ISzavnem6tYg+XNGJcJXYFA2A?=
 =?us-ascii?Q?er5KK94keWuy+xvtI243TE/2n3MUXXvUhrALeGK5RwHB74fDDJe4S47STwZS?=
 =?us-ascii?Q?Qcqx6yUKKcfN7oJ7OHIDdFc+cXPZT/2Wx44ylRwixQF/u936M+XHiTHlC8Yc?=
 =?us-ascii?Q?s7q3keeKI6WDnll9PB/F1C3gPVIk65N/R2p4l5m0RrtU/OBsa7YjkA5onVIu?=
 =?us-ascii?Q?+PW/6ZidljErvJnK/2AbMiqhbEnyqvmQ3P2kDxxW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00550ee1-165b-45c4-cb4b-08db55435801
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 12:53:13.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvPVKgamZdQmgcuRhRmESfaDtjX4sAF0PMO+amZjLgZdOyvIwXCZ0YVyO/jIrrbq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 07:58:38PM +0530, Anup Patel wrote:
> We have a separate RISC-V IMSIC MSI address for each CPU so changing
> MSI (or IRQ) affinity results in re-programming of MSI address in
> the PCIe (or platform) device.
> 
> Currently, the iommu_dma_prepare_msi() is called only once at the
> time of IRQ allocation so IOMMU DMA domain will only have mapping
> for one MSI page. This means iommu_dma_compose_msi_msg() called
> by imsic_irq_compose_msi_msg() will always use the same MSI page
> irrespective to target CPU MSI address. In other words, changing
> MSI (or IRQ) affinity for device using IOMMU DMA domain will not
> work.
> 
> To address above issue, we do the following:
> 1) Map MSI pages for all CPUs in imsic_irq_domain_alloc()
>    using iommu_dma_prepare_msi().
> 2) Add a new iommu_dma_select_msi() API to select a specific
>    MSI page from a set of already mapped MSI pages.
> 3) Use iommu_dma_select_msi() to select a specific MSI page
>    before calling iommu_dma_compose_msi_msg() in
>    imsic_irq_compose_msi_msg().

Is there an iommu driver somewhere in all this? I don't obviously see
one?

There should be no reason to use the dma-iommu.c stuff just to make
interrupts work, that is only necessary if there is an iommu, and the
platform architecture requires the iommu to have the MSI region
programmed into IOPTEs.

And I'd be much happier if we could clean this design up before risc-v
starts using it too :\

Jason
