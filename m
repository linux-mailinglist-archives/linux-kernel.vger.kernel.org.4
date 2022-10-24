Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB6160B5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiJXSju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiJXSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:38:57 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26402A52C7;
        Mon, 24 Oct 2022 10:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASS+lP0ZNA4sTkJSSpgVF/41brgtmkaKmmoukVmuPUYBSTcLWrMgCeXZDSHjUwG5nKbXpqXohRDNz7C6v3czmnZ817qNTJSVjLMBdWSV88SD7vBYM+qKCeOj66kewcGmQm8hMyvcdQHWm7rThxpkAfLQqMxzjk7MIuNtxWIjr/knQXCtR0wbJB9EmI2jl8Zh+N4fvKbnOtxYLAq48TOsemSgbf/QBUq0krJwa+twFpZHLcPjDDtrIR7rrnZtZvS7VKX9XCg6ffI/1bB32tIVIr5lpdshA0PIQCrcG7QTCc2O7/mBBN+z5TMEwjoiU7y42TtzXSXOYwfXAvxdjG/sNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PN3kiWM64xDPmHJmjJOVlzUt+SLhcdDgikgYfg9qto=;
 b=Hf/DphvoMwkbBQFBSDW8a+Pil992eK/WFnVM6/AsooeBI9C2M9bdpi6H5B20VXJeGZYC4WfJ+jnJTK2bKpPiicg2O2GuIe6R13s9iBm6Zhqi0EGXQyTsLQEP0qeQ3PxXvkbU91NM1PXy7YjsTeeuS3lPE6Kb1hFRt+VP4dqE4wyRWEP0wjknbX606BKyKp5nM8bDdBigoZlwGQCDZljCpVKTIvhArvxm2xkOL8j/ooo2kpWEVCfxSDYYi8A9MYoHZMFoKM5UpxmjqmAFMgZ1MNmUu+672wxzZAAhZGvoGCwmknnav1xLqv7XTGxeF1TA/CrhfadyYA1oy5GdPLD+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PN3kiWM64xDPmHJmjJOVlzUt+SLhcdDgikgYfg9qto=;
 b=r4OQWisz7FH7gXg2qgXa+LYQ9ztc5Zr2H1owtXC2ztPDOh+QUk0mbxG2vI1PThI9jTfc8dfow4hehG6m9XCRogIRCA9XLhTHY2lmW/a2GwS+ZUBhRsUcjKyi6AyGzYuVE4vHfYwrr4Evwp/GSiDVIPSL9zJVQEb7dOPacOFa6SHkG5RuozOa2StzV0guGav5UGlHcluW6HaZh6Ag30fwYyhohEQgNmZCWfwNixKk+qj4aNyxR0h6L1UFSRi6K70DZMbx5QbFvkXWF6JxkmpxvysH+r+dNX9GSkwGYeG6HdbyF58sGc0Sh6I3u1a1h2TPV73jl2jzXesKO3l23RjbZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 24 Oct
 2022 16:52:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 16:52:17 +0000
Date:   Mon, 24 Oct 2022 13:52:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/6] iommu/s390: Fix duplicate domain attachments
Message-ID: <Y1bCwY5eAmZ72MgX@nvidia.com>
References: <20221017124558.1386337-1-schnelle@linux.ibm.com>
 <20221017124558.1386337-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017124558.1386337-2-schnelle@linux.ibm.com>
X-ClientProxiedBy: MN2PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:208:d4::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 297b4b5d-ced2-4d31-8ee6-08dab5e01c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvd3pXlri7EO28cH+HlMZOvX9IKK1FnT+8DkeuoFG/O1qMkU02AnvEIRLDRytSarZjekSqa+w5rreDZ9NY47M2kExFMmmJX5g5qIDaOCHsfP9qDIIfLs46rGK0ZaWTo30LzD13lc31CxZagXPyg88sOC87g8mdAWMXgPAzVvDwf45afj/6wMswE+/zJFNsfTndlj1k+xhvf71gGyi7esKpBa3fkQ1/5RbXe5ZYoogU6k0HimIQ0r06m6RD+MtpXqOEXtsQzp2l7fQQFZwf4MZawoiTIRK6DYmm8grMHuSrjTEt5pmKQ4DGTTI28lnelkAzzt4fHmzSBIaL39Ssyjck5ppLBBRXwzCSrou/86kxUo0xpjKYYjUDjH5wkSydoKlBOBHe91dXmujN2vUK7eEq1xle+SwYDpdY+YY0Ga3vLfUz35+FlRDO0+P24XdGRoN3qstsxWQAC2gFscPMjGB5ZBaWQg7XUFIERZbO81PoZD0+/d1FHig/UV2ENRyLM0S9YSq5mLMpMLoPiBsuRaK6/WO/MszlD6XkeD64Z/ObKC/HL087XbAvYBbmY3P9oyJ+7nOvqa0l+Xw8WD2tTCpH79kiCN5QGeCGXoA8wYCKaGRZb7cx6xWuq/TXlVe6YGtwz2HNEoVKXBW5PIaBK+AUu9ls9fPuTv2P9wvPvduMwVjgUc16LJlhmecRLkbM8vJ7SY5tn4pHozxUq5XvDsiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(41300700001)(26005)(6512007)(8936002)(7416002)(2906002)(5660300002)(6506007)(6486002)(54906003)(4326008)(6916009)(66946007)(8676002)(66556008)(66476007)(316002)(83380400001)(186003)(478600001)(38100700002)(2616005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zGYD01tWmKeHSxuQIe0WJozgCfWCsC8jgxjnL1RIYED1NICYBRmIlEIVQlFH?=
 =?us-ascii?Q?xV9SNMLIManJxfBFKVGWU8x2BI6Nd1uM/jSDhpzJ66qKhJEX/CrB+t7h2Ym4?=
 =?us-ascii?Q?TRE4zFFfAbOC+MNOoDVXmB0QkbnU0dnS+o3UNxI/aA6MsnJ2RZvIJW2PlnNA?=
 =?us-ascii?Q?rjez1eyVXN/s/kh730G4VCfGhCYzXkgJF/h+xaUDwhJ5N3J752gWFnQxmD3H?=
 =?us-ascii?Q?hbOezDJqCp6mrOPPm3e5Crn4ztOdErIPxTsyehTyYr/OT0C5K4Q4F+PlqXy+?=
 =?us-ascii?Q?JLnfGAuYeUkHybM85l4NPI80ZBNrJM87ET2ffEfumfwbwFUncTnWPEnoGGOf?=
 =?us-ascii?Q?l3VB9d1Dpl59Z2AxKEJDfVnX3hue54VxiW9re3X/P8tN1+qf8QYfHDUgGR/a?=
 =?us-ascii?Q?ecH03iGDK2SVOBbkFg3bWtcNL4Z6P0Gq9v4oq50NGcBHvmUxfT1LXZU8mcFo?=
 =?us-ascii?Q?uMfLMLJwBh7sSOtL0qC22r8/kf5C0abz8HEMuE/XZGEkZd7GyM4N3jt0Nfty?=
 =?us-ascii?Q?1ael6wP9P863ENkaQqYkPRzB2ZpgCrlICZrzdUTrUnBsSiw/08hlb+8Fm0yw?=
 =?us-ascii?Q?Fbo2Q4nFpS++E8/V7+XLQpcJejxeoYxFo9nxl3vo63FFGb4GfYbO2EV9kOWD?=
 =?us-ascii?Q?HHBweGL3kk23lNb7xH7+sL2hYIHtpVO65exV/YIZNVrtEBT/HM9FgToJSSZd?=
 =?us-ascii?Q?74M+Ee2xNV/Zufgn8m4LZx/z/wFkU7d7AEfNwJNvf4cVs41cpRWUovGutYDu?=
 =?us-ascii?Q?sWQrwJiVMABOGh971shpdS/QW0SSgaUyAuQuO80SWYs1nfseVjLEF2hBZmTn?=
 =?us-ascii?Q?59RhkClhMNvCOCntCg7DlMR3WtNY35vfwETJSaVgvpIERfJ5QPFoVX6W5Wnh?=
 =?us-ascii?Q?toWDPwFgbnax2ZJHPpi9HyDCzRBV8/Be0gmRsq54q/2/oTVU5/cYenlTL5Za?=
 =?us-ascii?Q?vQg4wewZ9cfucT9kSap1TNZ3/RMHcNxiwwaCssCPttRcw6uI7IlF+RteKVDY?=
 =?us-ascii?Q?BGkY6xAxg0powRoVIZLttOVunHi0Docsm0kb3etKuABWGYoAIiw9nPEXuk3y?=
 =?us-ascii?Q?wWnhdoRX8ZQQjzxzCF3Ep4O13YVG5vxsUqfpT1QdTgmJXvk0RUHYhauPBMsD?=
 =?us-ascii?Q?OlVhQ6DsewaB8Cm8YheQmLsDc/3zAAERJENKoJIuGxGH726E6IsBpaavwX7m?=
 =?us-ascii?Q?fu9uL2RCiDDgYpRPxKQVDtvDzZfO6rG4weL/I9mL3YWQJFUQ/iAxcMvn53Zh?=
 =?us-ascii?Q?vmkBaiOjbO0fzgwUFHDFNJfoVlEUvksh8kiqjf+c4KGjUmQ+wg5UVMj4g/+/?=
 =?us-ascii?Q?RcS2sAls3EUHD1N+V6L3zyIj0DeX/sw3F+3aPIWiOchpJefy4tuVbl8+OrdI?=
 =?us-ascii?Q?UTOHgRF8UOFghFEtQOKOVUlFws7M1g19zZ7hxrE2qSJKec4zaxo6KTVrKioC?=
 =?us-ascii?Q?KMKUbJGfMPwKadVVM+YxUddTLRkk122t0T17Zil4nlP/Y3ir6H28tihQszjP?=
 =?us-ascii?Q?S2x81qxnBFZwevvUGZIBRNHLjcqVB7BEGGiaGz978Y+4IF1kRIPggRmmPJvh?=
 =?us-ascii?Q?4nCeUFCgQKLFwykBdrI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297b4b5d-ced2-4d31-8ee6-08dab5e01c2a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 16:52:17.7761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3+sayfes9m8B+UzWPYfUYujCTbdYSsujm3XbRw1ypHUzjGh7oLMQuQ2bIm4HbMD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 02:45:53PM +0200, Niklas Schnelle wrote:
> Since commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> calls") we can end up with duplicates in the list of devices attached to
> a domain. This is inefficient and confusing since only one domain can
> actually be in control of the IOMMU translations for a device. Fix this
> by detaching the device from the previous domain, if any, on attach.
> Add a WARN_ON() in case we still have attached devices on freeing the
> domain. While here remove the re-attach on failure dance as it was
> determined to be unlikely to help and may confuse debug and recovery.
> 
> Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> v6->v7:
> - Added Matt's R-b
> v5->v6:
> - Only set zdev->dma_table once zpci_register_ioat() succeeded (Matt)
> v4->v5:
> - Unregister IOAT and set zdev->dma_table on error (Matt)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
