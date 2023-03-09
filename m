Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FD56B269E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjCIOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjCIOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:19:49 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F0B9F058
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:19:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsDerb2SGCzbmjssQpPCGepgkz5XOty7/63n3IYYaIkEV+TB51e3IcSqNcrgIEI2ovvPK1CvVqfGQhvT6pp6hVxTp1iXammBoC7670ePO6rQJAebwpV5JbKbD8d5gPlAxAOU9D+zrGFekw17jCp3k5ZgMPa3NMyjPrqarfNVKc2nYt6+zHeSPsCZWkDZvFZ+KvjBylb3wgqOxP/+WPX8XR/XtTqt6Oj28Vb8by4uXHg8ITVbwr+eN7WAIeZ9ksLAPEyefZYeUyJbJQ6o49mhB6cR3G+H+WxNKia/bFaKk3tysnyoRvpFOevrT9IPu8sWuvUmPhJNI/fc+cdb2BIx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSdPgdrKF1NrxMnK4bw1y/lS4JUj0mU1v0FKWRyGwT0=;
 b=NuA7oO1au2IC23sA4CpapNrj200DcQoj4/zlAH+TSaUZH8n5yYQOnVWb322t44FNZfFVtzbIj4hYOGM5/ZVB56VSjW0q3IH/WZsTwpyoHpZHTEwpANDakTBk2d5SuIk/m/cRgDwLyJIlgI6YfA2mKxRDHTonLNdAlqlGqQL9EfBRHB1iX9mGOLVr6OUCLnYEXhP5X6MOu5xckkBYG9D2y3Fh3dGZn0CDhDNSTa+ATrVPs6i0CqiT6T4/Wdn9/5rrORQnHfAfBi/4M3re3pPlmj5rAQOUVL8p0nQFKInkeYYgQAa5CDDefOYuq9XGpt8qDEBhaPv2hYYohLi2jTWWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSdPgdrKF1NrxMnK4bw1y/lS4JUj0mU1v0FKWRyGwT0=;
 b=KvUwp5bXQtKSV7biA2XxWTc2Av45/HiSoE3US/vgx8aTu2PVezXmA0z0DGUpvaAb+GtJwhhiAy1AcfOjkTIisZqvVn9LSh9p+UCbTNaXGki/2Syt+37DY6Pn0CE1Z+z78LPWHnLL9tfYJ7+YgtPp47MH1ooHSerJlM7DzFrJQnpNVOoPp+g+OLZnzC0ITMVADq5djPnTI8BGGcERAHiQWtMnmahvndR+9Iacv9wMKS3ARGZPIMIxhxIacaD80w0ZNuI/b8zMULctxdVIqqSO4bk3MEP7/w0lRu9twD/Ug55gM01eP7EeLh9sfIaePQqEq2pXmC6BGbPT5fbX1MA9NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 14:19:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 14:19:45 +0000
Date:   Thu, 9 Mar 2023 10:19:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Message-ID: <ZAnq/8Ak75Dr7JM0@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <2118a147-ac95-d846-ad6f-85d7cebca46a@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2118a147-ac95-d846-ad6f-85d7cebca46a@arm.com>
X-ClientProxiedBy: CH2PR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:610:4d::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa418cb-4517-4e3a-d3e0-08db20a95518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/OgO2uoJVXmAO7Mkj/G+FQV/51MZsJHa9MGxprBcrmotNH6fQC7Q83It9jxZlI5DSpHGZ050yat2g86pyPzZW1H0WBHO8Te+KrLaY8GgGOkemVcTZqpnkXVXpOpl2P0y2ey/j+RgSgLVfajVKGUwF4RbLM37aAOeVDHQ0o2DjLleYV+WXyS79jhd0ib/e0h17g6hbUtkYXRBd0FsPvw3Y0Xsbd1t6Unnqha21fYuwmIkOSHjdbMHBXBEhll/Xh4c1CSwwS6lQzl3zVumscllOECNHkgcnkOmzOHLW/aoXlf9OGrxaoEDy2+pp9NSikxG02XEa52bL1jdW8uUrrSof6d1L6mLlulnWc1GamfN3sYN7rExtAAUS2P68oBF42gPxFoFefyDrICbplJTJwv36HmHuH5BIja7BWRIKjIGrVeuLnYoAv8zUqKcecBFFIK9xenJUtwWpDqUhLgqoapQX0fdiqJXfADCZytOSIdM1tYojFiPMep7ZUfYY/uEoc9QI5N0wOLe3wQh8mLPTqpmtBiSNj/iBk1fB4cVU2CCXKOA44vBuOPgBGGsSc+Eq3SXq7FGD6DipqE7NOxHMlBAuP8GncF9Q8n8SiVbL3Qq/0dTn+5R28lnJGApKXsBN0g35Qb5cjx1XAues3jO2yzDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(186003)(6486002)(36756003)(478600001)(38100700002)(86362001)(316002)(26005)(6506007)(6512007)(83380400001)(41300700001)(2616005)(7416002)(5660300002)(66556008)(66476007)(8936002)(2906002)(66946007)(4326008)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CKhUdBXBRW+4HwdfcqpOHpDvHi8LDaFpXALXuiL/WPXiLFSmN6hJZdFXFuI5?=
 =?us-ascii?Q?BF0miscTNm8Z7bwEkeiHASBeaAKtyU3jiBvJXP7+ig4gRYKRh+WHSoeCSgZQ?=
 =?us-ascii?Q?hxwNYipFChSsIwxvMA+nsX0H3p79F86m1I62YDmJGczV3/XkyPpRrDy2Nq7f?=
 =?us-ascii?Q?ldnyheT1v+bd8E238o6dEDeEwNzzWZ2VdvbeNlJgi3FQgIuMpCBDoXc5x7e0?=
 =?us-ascii?Q?z0ay7rjeIOa3K50vpVCygqRIRHxTMpC1HWn3v9wA7ibTOGO2/fnMThGK50EI?=
 =?us-ascii?Q?yLAY6k70pKDasWkgGJfcg4UTWu1qxyXUp4oCTusLPjz9mUe/ucbVunreEeZf?=
 =?us-ascii?Q?YXDSvcBTymRwlfexSZTKVf0/+GFn77D+PWL9JjT0Exk0raq55PlavyDtY34e?=
 =?us-ascii?Q?kW3Nib0tUjM3GwJmaJbMwcXHw+nI+Z9k7YYvcZaG56Xwxs7Ff5uTMQoegRBz?=
 =?us-ascii?Q?0r9t9piJlpiqS/0KScWGXx+iqKnKf21EbFNPc8aXl5mfB86drVeyrNSVyP51?=
 =?us-ascii?Q?OPr4MeA3HoOHUumN7LHp/NwiGiVYMT5865nS5LmOylFEzWyTLcdKoZxVRJo8?=
 =?us-ascii?Q?2Sr6+HUP+l7USqIoMiLRa5DTVcUZAdHhwkD7TdQzHo/xpuKevY2VSxtE978a?=
 =?us-ascii?Q?mUEWhnPZmV6KKHYgbQ489C+yCgw6/rRdv9jgUq74GsrkuJ8/IR4yOzzzfHQv?=
 =?us-ascii?Q?IGvHVc7FfYlVauWC/r2N62xdpPwRDh6/myDEkYULtGgFRfZvBSPkbdiPwNia?=
 =?us-ascii?Q?csvCpLBRasqADqiLZPvBsjq0JV1G4Fh771JpygL2865pwLJNA8kekjkCQQhg?=
 =?us-ascii?Q?M+SFi6DfPrzCMw+XT7oPayeiRN6Bd8g2XOd5W1Gs2diHQ0MSpCtkbAc8GPAV?=
 =?us-ascii?Q?ehrOyRY5nP0oQazZFJzsZEro4hKFcKbPSioJW4Ltj+GvT66M5BgjWZ4xcu2g?=
 =?us-ascii?Q?mVhpeTJ4UrC03Zr02Apyrqww6yP9dvELFUxdgB/1IzaSOBgE42VLgU6iLutW?=
 =?us-ascii?Q?SdjBkSCbBa2HKG4TetWCJtEZdK+0Etd3nXlHPN4E1mo8FVrZMXBN8dyNB167?=
 =?us-ascii?Q?6rfkC8eZ+fhN+kHA+mqoGeTMXbT79Kvypc50gYuNtGEO4uPDpuUkAa+luwKu?=
 =?us-ascii?Q?ZaRsP5l/zDkh/KYDR2y98Fao4b05B9ag9VPgK1Aa7sN0iGTQS2qVCONwiWQ5?=
 =?us-ascii?Q?Bgf3cSgCqv3F6oeitE2gLF/YxoDxLVqA4AEKaKOCckMMArNER2Bp3NfRMw9B?=
 =?us-ascii?Q?HEhiOB6spbPfgephSQEJ2Lg7/lsVuJEzqIhD4ano1g8dP2r/8XXcw7aZ3Zz4?=
 =?us-ascii?Q?GcOLFIugzz/kO1wLlD9TAqMzUkAivaki9rQv/sHKT4oGEsYRD5HF1eJV1pvs?=
 =?us-ascii?Q?Ob1Ll5zl0w1njIidIMPdUyxT7bDNVIAoT5+xeDEamSZygswood4g5/mJSsZw?=
 =?us-ascii?Q?I4ouTqHJgBTSvuLHjSH+8G0Bby8nBf+Lz3M3JWTGg4uhfESuJLiMJh3rMP2z?=
 =?us-ascii?Q?Cu1DqHs9IOe7yTSW/T7+NTWZxn3h3Srd0B1ZszuGKvysE0UOheXo9lbCNeV7?=
 =?us-ascii?Q?JXU7LgvEqoP/WTn6ygbuVTNOtyiW8h1u5mE06e+d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa418cb-4517-4e3a-d3e0-08db20a95518
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 14:19:45.4027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyAsZj1wgKqsN/hEfSepIm2TASZuSxbE3ZWn6f51h/eHdSIo2fQe294Me1ESPxJL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 12:51:20PM +0000, Robin Murphy wrote:

> Please note I stress "valid" since I'm not buying arbitrarily made-up
> conceptual purity arguments. A nested domain cannot be the "one true domain"
> that is an opaque combination of S1+S2; the IOMMU API view has to be more
> like the device is attached to both the nested domain and the parent stage 2
> domain somewhat in parallel.

I strongly disagree with this.

The design we have from the core perspective is an opaque domain that
is a hidden combination of S1/S2 inside the driver. We do not want to
change the basic design of the iommu core: there is only one domain
attached to a device/group at a time.

This patch should be seen as a temporary hack to allow the ARM ITS
stuff to hobble on a little longer. We already know that iommufd use
cases are incompatible with the design and we need to fix it. The
fixed solution must have iommufd install the ITS pages at domain
allocation time and so it will not need these APIs at all. This
tempoary code should not dictate the overall design of the iommu core.

If we belive exposing the S1/S2 relationships through the iommu core
is necessary for another legitimate purpose I would like to hear about
it. In my opinion using APIs to peek into these details is far more
likely to be buggy and long term I prefer to block the ability to
learn the S2 externally from iommufd completely.

Thus the overall design of the iommu core APIs is not being changed.
The core API design follows this logic with and without nesting:
   iommu_attach_device(domin);
   WARN_ON(domain != iommu_get_domain_for_dev());

The hack in this patch gets its own special single-use APIs so we can
purge them once they are not needed and do not confusingly contaminate
the whole design. For this reason the ops call back should only be
implemented by SMMUv3.

> Even when nesting is active, the S2 domain still exists as a domain
> in its own right, and still needs to be visible and operated on as
> such, for instance if memory is hotplugged in or out of the VM.

It exists in iommufd and iommufd will operate it. This is not a
problem.

iommufd is not using a dual attach model.

The S2 is provided to the S1's domain allocation function as creation
data. The returned S1 domain opaquely embeds the S2. The embedded S2
cannot be changed once the S1 domain is allocated.

Attaching the S1 always causes the embedded S2 to be used too - they
are not separable so we don't have APIs talking about about
"attaching" the S2.

Regards,
Jason
