Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFC66A723B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCARnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCARnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:43:04 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D379546086
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 09:43:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGfLJT14VCDL3ZIrSSyb6zWun1bX8dNTd9brhnmyXPqfYCVky9wbqG4m04Awo+DMWMykDvnjkesejBY+dUVcZPlZt/j+MWdhIc3pd/FyTX7wcOl0ONLWi+ET7o9kDcMgNeMGXtvdvtWe7a+Jk12aDB43/7ldkuySNxbWnsg+hWPZXZKelC23yp96IFPDgryW0X+iYMi13GClV+bl+DMx2nx5+hXDbn/3lsfUFFC4LafF9fDbDNSukUH5vg82SwUFq0xJ2J3gQoQDzKZP91fhaaIzHwqgii8Nw73DA4RKkif6xG0ibJDuW2EL87xbvAbXYYmrHpllZybA/XKnZvdRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WfRZvbibHVxuy1tnwP3XQEbOtSnCCt48oJDGfVOh/A=;
 b=h3K8bPK5MElcUGgg3zjFafWaBEeHVRwatZzVQGMMRtkshoH59RL0+1vVBsiciIpVTJg1USa4aF3Onn+Peskx6YE+RH5SLZKOduINt8PayJMzcWlFnvxI517TnCLSDbtzZLA19fgwTW34IhPWfjhu+P7zNoKGqP25qJNve9ryzXgcojkAygqt2kaXRz7A8jL6lI6674nuY5B0ceyxMbNnPVRl/liT7e+zPBSXUKskX5TH0KMlJbIxC3FqpXfCt/Vq/l/gGSXo0Bq3NoC2CVg8dh/i0Rb1tD4Hz2WxY0u8+RvaH4itKcAMt2o/YGxBAM7EmUKuixKalanUtYEd46wMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WfRZvbibHVxuy1tnwP3XQEbOtSnCCt48oJDGfVOh/A=;
 b=Sd5syMEUb2IfhS+2QE+RsWETTZXt3X46HIPq9ZIz9QwxddPyGRwUJ9HzBIpFKYmjeBBw9ioWTPCW81qneSDmOsNpr2MXo/V9OpownH4Lzx5fj1exIIBmlDdzoYjms7BpH0UcqQUIvPK1h1wwr/0zio4vbm7tGLCguDxaPGGLaAYYf5P4e8qKH9i7DJrCorjeHkVHpuN7lCjIYv4WCTNz9aHvzVbIOk/7xDfkDFYs4Up7+Wnj0P1zB6vtE1TlmM3p8Q75MRXuPoaPfK0OemZYqRmw49I1Q0nIgaAqgHKAeVy1Ii2naUU5eUydHaqGvNZPDdd888SsA3TlvJU43BhxXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Wed, 1 Mar 2023 17:43:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 17:43:00 +0000
Date:   Wed, 1 Mar 2023 13:42:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
Message-ID: <Y/+OobufnmGhg/R7@nvidia.com>
References: <20230228023341.973671-1-baolu.lu@linux.intel.com>
 <Y/3yNaQD5Pkvf61k@nvidia.com>
 <3891a9a8-c796-2644-9473-aafc9ecea64e@linux.intel.com>
 <Y/9bWMoAYF10ynO3@nvidia.com>
 <0f162421-479e-6ab3-bbaf-0090b1a2472c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f162421-479e-6ab3-bbaf-0090b1a2472c@arm.com>
X-ClientProxiedBy: BYAPR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:a03:80::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: e00e091d-e2f5-4c21-b18e-08db1a7c66ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gzWb4VLi6oL9JL77rhoeDdRNSnp26S09mPpyLVoahrfqHPLEDNiewPG9AR1Bn8l3RNlBfHbUUuAD8fRLpbi1Gegx0JFKoQ7lVzeOmpEzRasnXDbk4CRSAESGp20sKEYzmibHb3xv8a1RAU8+h0iD12EOGDbDc4aHqEbiT07HamgkzvNrrNjqIzmEnIRfaILcU5wdnERLiPkiVrxbp4t5+2lQ88GxO5kZufAW/wEQB/FSt3ogMsS3kdyusITKk4okAboj3xwzuVwJqX82/Wp/xDRxuLtEVUyiy/ry6663ye1GDGfhGrRon55/wSzhtn3N1lCdk2UF9zK5vVU9xUzkhq3Erw4EwZKQq0HIpr+pguJbIOMYEq4jLcevRnwvNhr+L67oIxnjy5obhAiZPNGanOkejDfhu0r33PJTNr/LaPtMA2jwCQw0AaPicfUlvXq49nDbNDVcr38TASaCKqQIA3tcOBy05hWyqDrn9lyGA40j33JbESKrs6RSsJ+1JlmXj0VJICX0r0jxmcJau0R+v6tDB2j8Tl/ypizWIuLwPxLB7az9W5nLfdbgcsZsNRzYi4ro/r10i9sSG7Ln0M4hfWAuHt8PQovzXrahOz3wls4hBB1GipuuywKZRRD9OYs7JgSp8qYwTG+9W3rClTAT+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199018)(66899018)(36756003)(86362001)(66476007)(66946007)(66556008)(6916009)(41300700001)(2906002)(8676002)(5660300002)(8936002)(38100700002)(4326008)(6666004)(6486002)(478600001)(316002)(54906003)(83380400001)(186003)(53546011)(26005)(2616005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amYzdlJYOERuY0M4SGJHV2JLVjB5SElvalVNYlR2SVVhaXRiM0lrTS9EaVB5?=
 =?utf-8?B?K1hENG02WVlEL1lwUFQ3bllpZDNBVE9RUGZKbGFxeTNOdGZmNjF5T0hsRFRU?=
 =?utf-8?B?TGF0Zjg2WVIrb1I2eXliVXVFbGl1RkJQUjM1Y1htYXE5bSswdFJST2p2dm40?=
 =?utf-8?B?Mk42b2ZDczNQL0RGVDNFTklSbzBydldzeGMzaUR0RjhGd3Z1RFE1Y1Z3N0Nn?=
 =?utf-8?B?SlEvcm8xWHh4aVJYcmZDcElFVFBwZ2I1N3ljRThRa05pK0d5MHJxLy9NZEhB?=
 =?utf-8?B?MmRBb05mMVJqTmJwQWNtZU5iaktDYTdSM1YrdFpabTIwUzBVbTBrb3M2SEZW?=
 =?utf-8?B?MUd3ZTc0OWtJWmQ2UTFuRlNySzNYNnNoVzAwK1hrSHN0alk4K1pqYkRZa09Z?=
 =?utf-8?B?cFRiSytRN29jc2I4WkZsU2F0SDZPYmFwcTZRRWZjU1Q1dDhxZWtFa1JWRnhr?=
 =?utf-8?B?OCsxVDJidFM2M0R2dlQvcE5WN2dCd0ppdFM2R3hNdnhMZnBhVk0xMTVHZjhK?=
 =?utf-8?B?T0N6L01lNVFpbmJ2VlRFd0FvWjRtd0NIQVFhUUJHamlVWnEvYjZxQmZWUXJ6?=
 =?utf-8?B?dGVic3dRcVE3ZXFSellKNk5icTlYb3hsWEluUG5tc0RRNlFuejcxVjgzOVpl?=
 =?utf-8?B?TGVqNGJ5YnU4RUxmVGE1L1RDRGpQUndCcHo4WHJsSkhwMmhySFV2d2t3Skcr?=
 =?utf-8?B?K2FIT0YrZm1YVGIvbWFrL3dmOUlnMnRSam5qaHFKZjY1ZzIxSDhrNlR4clR3?=
 =?utf-8?B?RmdibXRPdmNRVWEvNmhUNmd3NjI1a29VWFZFWXRZUkJJYi9PL2xkbUtmRENE?=
 =?utf-8?B?UEx6L3p4dTBwSk9zOHlqOW9tdGJZdkZZb1JZUktwSW1sbjRyM1ZUSytCU3Nz?=
 =?utf-8?B?YzlzRTlWVlR3UEdBU0pPdE5pU1orRkxaWXoyK29BYmVoMXhwUnVRTEE3VU9y?=
 =?utf-8?B?djVvY0JjRVBMVjFreGVQYVFsSlZmbllhMzI4WmZENDZUS3Nzejh4elZBVmU1?=
 =?utf-8?B?bE9BbE5xMGxIUk5LZ3hxSG5KQWJ2b28rUlFhM3A1aUd5OGNUUktXWUlidmVu?=
 =?utf-8?B?OWY1bGM2Qjg1djBBOGpjZW9acU9hYXZQa0RJNHhKaVNwbnRpS1FiN05zWndN?=
 =?utf-8?B?Z1dMS3lkMzBKSzRJQlYrNlJwME9EVXlmN29xdnpKOGhWZStkWUNMWVY4V3Ji?=
 =?utf-8?B?MVFxYjBid1VvSjAxV0FFVzVJUVpzSTRxVjl2V25DRTJ2alBISThVQk1QdVBS?=
 =?utf-8?B?ZWNKL1d5d3BRMm4wZDAzdkN0UDIvTXd1blFId1MrTjlRcEx2ZEdBY0dJRUly?=
 =?utf-8?B?OUV2bkFsMFNMTDIyOU1NRU4rKzNRQThhRHVuc1daUjJIWGthYURTMWkyb0d3?=
 =?utf-8?B?UlJzaVlVRFBQdk9IZVJzaDBjODV3Y1p3SkNzcW8wQms0L29PbytHV2JGSk90?=
 =?utf-8?B?cmZxeGIvZWJsd1hibmVEdlBnRXVLK3FuaHlPQjhNbmZ1S3Vxd09XTjVUUmVH?=
 =?utf-8?B?MXlKbU5HR293b2hEOWVIVU9yVDRHc1l6WDFndDYwNURIVEV4VjVkWlc5RFpy?=
 =?utf-8?B?aFJOWVV0SmhxQ0xHRFhXTTN4dmJRbmJXVHZza0EvaGhVUWtYNEFkSVZLTmhy?=
 =?utf-8?B?QWNTdC85MUFlblk5U21RYWFvZy9pMnFWbGtxdnllTk9BWFRueldHRm11K2s2?=
 =?utf-8?B?aWREOEZsN1pzdDNFZU40dk81NWZVRURRODNwdmZ1MXN6OUMzY0N5Z2NaL2Yy?=
 =?utf-8?B?RHJSTHBIaG5jdTc2Y2RBK25SVlM4WnlSZ1phK2YxYTBGNzF5R1dacWJUOFdV?=
 =?utf-8?B?dXd3ZG5zUFdkc0dQaTQ3SkcrOG5oTjlwOTlpZDBIcXYwWFA3d3phY1lreGNU?=
 =?utf-8?B?dWM5Vml2REFYZmk3Sno5TXQyY1hLckM5S2NMSm94bTBabkJPL2dOcklpWGp4?=
 =?utf-8?B?UklHcHVJVzhtL1hxNGNUOG55cEorenp6RkxkTjlnT1l3VVJQZGxLaGVjQkpq?=
 =?utf-8?B?WWkvMkNkbERlRWxSK29Dcm85ZTVsYXI4RnE1eHB6dDEwK2kvUURzYmowYnRY?=
 =?utf-8?B?T2NXd2hmZDg2U1ZjL2JleVNVUEkzZ05RYjdFM291U1VIRityWVkwWkJPM2ZP?=
 =?utf-8?Q?wqQy22Fa1vhmqqTLy8BbeErz6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00e091d-e2f5-4c21-b18e-08db1a7c66ba
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:43:00.6553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9DAwfnjkKeJHei5d7axMThG0y7jMhs6MP/qOp856xaPICmCI76dtTcIjfKUtyuz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 05:15:33PM +0000, Robin Murphy wrote:
> On 2023-03-01 14:04, Jason Gunthorpe wrote:
> > On Wed, Mar 01, 2023 at 12:22:23PM +0800, Baolu Lu wrote:
> > > On 2/28/23 8:23 PM, Jason Gunthorpe wrote:
> > > > On Tue, Feb 28, 2023 at 10:33:41AM +0800, Lu Baolu wrote:
> > > > > In normal processing of PCIe ATS requests, the IOMMU performs address
> > > > > translation and returns the device a physical memory address which
> > > > > will be stored in that device's IOTLB. The device may subsequently
> > > > > issue Translated DMA request containing physical memory address. The
> > > > > IOMMU only checks that the device was allowed to issue such requests
> > > > > and does not attempt to validate the physical address.
> > > > > 
> > > > > The Intel IOMMU implementation only allows PCIe ATS on several SOC-
> > > > > integrated devices which are opt-in’ed through the ACPI tables to
> > > > > prevent any compromised device from accessing arbitrary physical
> > > > > memory.
> > > > > 
> > > > > Add a kernel option intel_iommu=relax_ats to allow users to have an
> > > > > opt-in to allow turning on ATS at as wish, especially for CSP-owned
> > > > > vertical devices. In any case, risky devices are not allowed to use
> > > > > ATS.
> > > > Why is this an intel specific option?
> > > 
> > > I only see similar situation on ARM SMMUv3 platforms. The device ATS is
> > > only allowed when the ATS bit is set in RC node of the ACPI/IORT table.
> > 
> > It should be common, all iommus using ATS need this logic.
> 
> The IORT flags are not this kind of policy, they are a necessary description
> of the hardware. The mix-and-match nature of licensable IP means that just
> because an SMMU supports the ATS-relevant features defined by the SMMU
> architecture, that doesn't say that whatever PCIe IP the customer has chosen
> to pair it with also supports ATS. Even when both ends nominally support it,
> it's still possible to integrate them together in ways where ATS wouldn't be
> functional.
> 
> In general, if a feature is marked as unsupported in IORT, the only way to
> "relax" that would be if you have a silicon fab handy. If any system vendor
> *was* to misuse IORT to impose arbitrary and unwelcome usage policy on their
> customers, then those customers should demand a firmware update (or at least
> use their own patched IORT, which is pretty trivial with the kernel's
> existing ACPI table override mechanism).

This makes sense.

I think Intel has confused their version of the IORT.

The ACPI tables read by the iommu driver should be strictly about
IOMMU HW capability, like Robin describes for ARM.

Security policy flows through the ExternalFacingPort ACPI via
pci_acpi_set_external_facing() and triggers pdev->untrusted.

When an iommu driver sees pdev->untrusted it is supposed to ensure
that translated TLPs are blocked. Since nothing does this explicitly
it is presumably happening because ATS being disabled also blocks
translated TLPs and we check untrusted as part of pci_enable_ats()

If Intel BIOS's have populated the "satcu" to say that ATS is not
supported by the HW when the HW supports ATS perfectly fine, then get
the BIOS fixed or patch the ACPI until it is fixed. The BIOS should
not be saying that the HW does not support ATS when it does, it is a
simple BIOS bug.

Alternatively if you have some definitive way to know that the HW
supports ATS then you should route the satcu information to
pdev->untrusted and ignore it at the iommu driver level.

Jason
