Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7208669A2CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBPX76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 18:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBPX74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:59:56 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EE755B7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvSvYNaoLwsKCs8Ebg089eyXGxiRpxdENe3WURoP9reOzGcM776izKfgpWUOIGm3f6MqdqfJPD/sRILJxAg0Uy7ouy8FbRZhdmHW9AdjXShlfC+/dpTNuQ7WabMRm5GGdcLlBmtkkJKeWHw0TuB/5SlKbuEkRgC1gEqnrdDbXHrJHIHGi5gqxAUaXud5azj7uiGkWnDo5uZqkCoajObw0KnHnO0XTbOhq8E98fYeudxsIERTG8J3yUOjsuGYp19/hT34hqlJWg24pYlaw3j+fYul9d6hgru6y4x+a+9pzSarAR5UzGLUvqW/rgqIyIAYX+XPXUmTx6J2TpCaD4OTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVrMF1h9nfTMxqh0O8Q2Qxe0UoZuR/4i12mSRi5zqao=;
 b=Zv/EMBdcjhkTsasoKazudDBkkVFfD9z/7OzOiawkRQvyeW2eCGg3zaU3jWhlaCWpgGFX86z2pkRXIbtALyzaLJKv3CG65blP38Z6+d7udJd9Nqe7JhjsvLMiJqOKC3iHAiOJhtrQEc0CiGE95SyKLCsUfmGvtSNuQDxsUtzPoALDNW0x25dtZkLcaNnQll9sbIPg+7BS99/LaKkXN+Qd9ZSCIjySz7qyk6QY8h8Zqnz6Um4L0DZa/mnjzlJk8Fk7XEjoWqMnIXAwETj/qVI4wMYe3TIOumf2k5BUWOgqzMRk0vby27NvxLkvfISarZbuciSE4pagSFxdglaNJHfs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVrMF1h9nfTMxqh0O8Q2Qxe0UoZuR/4i12mSRi5zqao=;
 b=mF8uY+xOTswQNp9BtxuXR3KYgi63i2mj+l5LB0ng7mBI0WjDK4We7bObJgjloGeWyZB6uhS8V9yY8bVjY+qCxA+4QVbEvfSLEP7VsDpyv45zrWz6HGGVa2vz9DekKrMA/za2dyoxPXbwE1Kof8TjdgJsxFPE6JfKEkdEvzCwcv55lpPGXXpWkLc+duj9a5pQ63PKoAU+FMVaiaIHMoO1DEeteKxDPWov+AKzVfB5AlgfEU8Mb04clp4C1UkU/VuFbHIIMWZdwTMO5W+BpyH27JGWQvYt6fIC49+cBz0L8aiO1NcoLw0Ud+3nW+23V+6cn8miWcJM+XVTh5Gv3hSSdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5345.namprd12.prod.outlook.com (2603:10b6:610:d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 23:59:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 23:59:43 +0000
Date:   Thu, 16 Feb 2023 19:59:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 4/5] iommu/ioasid: Rename INVALID_IOASID
Message-ID: <Y+7DbuqKRFFCLAms@nvidia.com>
References: <20230216235951.3573059-1-jacob.jun.pan@linux.intel.com>
 <20230216235951.3573059-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216235951.3573059-5-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:208:32d::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5345:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a6577f-eba6-4adb-fe12-08db1079dfd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOZP1Xzy0AWjpsK/kZEH9AxUc2WTgv6t0UrIrIKFcUpUtyEJiCPzrCB9atyjrs+u0e9WgqM+eCawOm7C3PxeOKmV29FG1IEgSMEESDTKocknFDtufy3NPIRC5wgvJLnKdbGRgvvgNWk7fWSIvia7hb3Z5nQHhIiEXH7Ollhr6wfNUdO6avCRFXm4jTkhGZ/2uwkBVjSPpVG1MY1mD30NUNtmVuL5pC25TTIT1hW7VALsFX2yrKQzZQqFJDlLq0uRXI/Wr2T9P3SgF7ZOE+Ey/7GIz5gBLeySSQZheYyFMxeUkH8S1gcGGPuU4528alcf6Cexj/6vtKsBQ574DxbjKFO3FAT8eALAxxbm84bY/5uK7TEM39mm7QdHe9vi2RhGDi6B5h16cKHoN321sdsj71++0gH1aweWyJgYfMAwPvJSOTsFEhevc+gjvkV/pxQgwelfj0++uCfn6WoE/GdC3hTePl+Egoz6qOyGJ3d92vzo3duO4gO5773Qr9Q4P/n8U6xg4K7OMYvDpb19VYGgU36pnDjk/l08IiVe5T5F9t6pobiMm6dis2gFs1EjZxU4I2Vp80qD2QS8dT3ICUKNLlqjOjBTDhQYSIdIOcCNMpfO08crLEC8GHY/EH5fgVqlxffgJZ33I5JJ9F6C408MBp2rXU53AU8ywmyq7qurzrBGx/ZfeYDyrrzjkLJBRB/e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(6916009)(86362001)(38100700002)(6512007)(4326008)(36756003)(66476007)(83380400001)(6486002)(2616005)(478600001)(6506007)(26005)(186003)(54906003)(66946007)(316002)(8676002)(5660300002)(7416002)(66556008)(2906002)(41300700001)(8936002)(4744005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TZhHBAMybHRYkOOjCJqfUoEDiBRSyVDeN/DHXcOuBoENp1KC5QIpp+IK2DK8?=
 =?us-ascii?Q?cc0YvH7JiX79U+0XO/LHS9SSuWbwgdHZgTJXk0XyVSMs1ewDkO5QWbIa42iv?=
 =?us-ascii?Q?OWxPEHFzF2591lewBoNRKOZS5uYwW4EwRLcJ+tr7bShypo+yuCPyx9FKN2fT?=
 =?us-ascii?Q?FdlvtUUusE/AxKWelZDupyzrgrkiiDlgMgRI+iLyMvTKBxmRC2tNjG5EKt1n?=
 =?us-ascii?Q?yD/UIbYLU4oo4g9ExG0zojadDxxFuP88krqkvbte6E6jfsdhwuDMajFaAtPa?=
 =?us-ascii?Q?pMunDq3TPAy4HSUDSNAAbmnnCoSeoZdfrHYy10rf4F3yFkuqOSoyb1F8A9m6?=
 =?us-ascii?Q?EW0DWucJcPBpBJjrT6C30IGEP8iHpU023JU+vJGZQVFPogwouBGyxwwHlQYV?=
 =?us-ascii?Q?200afPtGL81+6JQrdGWjnaJ1MyxrgCqpcF9VUDOwExFs70Nyok1AyK74SX5u?=
 =?us-ascii?Q?+CwKFEWCWPKCKTN+rlg6uo++HIQkH4SMfjaibnTMm+7U2RihRT5MwTyA+TRr?=
 =?us-ascii?Q?MUebuAwhYFvt+XM1EpjkEHG2xUhiT+mYRuhcjcLuV9JhJBDyKqLUQYBTNdAt?=
 =?us-ascii?Q?h9v508fHpvW4bFVqdjIZZLN3HGNobsMToyVYFfnwA4hWz4rN7g64pCyYqJYn?=
 =?us-ascii?Q?cRrbP0pqkgz8Klgur4q3X2HAp7a1D5pN5qdP13qtCRAS15TjX55su7XNCvPI?=
 =?us-ascii?Q?KUqN9v7P+OeBc6hYumouFlQCvE0EoLGiji8pFGonno1+BNHz1esbuPdUN95g?=
 =?us-ascii?Q?ydgI/lpsG8f/z0oBz7c8WBI3A8f0N6NDJ9tDeaAiJq0QXPj/i6pnji9T7wlN?=
 =?us-ascii?Q?yibDI+GlowjJuO8D4QlvNNqnAkFhY8cUJx4NpPvaLtFrfGgKbYg71t/hHNG0?=
 =?us-ascii?Q?pOCep+brKeIxjNOfye8EpaVG9gNOSy4DPUYRQAz52ogrrIs0dvNanMU+o5W6?=
 =?us-ascii?Q?C6l0fPdDhtF7ltKkjBfI99siHvmwlz2oebwtXPn5dyJ1tT/tOA2sPmqap3sr?=
 =?us-ascii?Q?t1NrAQk1E0s2DYS0tI38QDW8D0q1ni2AJtTRPmRmVoAw0lHzonE63Dt+vrQ2?=
 =?us-ascii?Q?zqTMArx8KwNNP+MNYQnmIcwQC6U7sqAS9PJ4ah7QXAhw0zfLTfZrnBXkWspg?=
 =?us-ascii?Q?f/cofjii/OYUwFUAZSdZyQfbm+6PMQG5JYkqgBfm739buQH1qpIMP92+MCsu?=
 =?us-ascii?Q?KPPBBRwUSFXK+dbMx1MMMwxP9kjltd2SNZo6AvhUuqgkdvZSF4+jkMyimcQ6?=
 =?us-ascii?Q?He5nIWeVoIhXWD5xIgrv9mXusvmrnb5l10+GiuNfzOWCrTGWg85rMmQMHr4Y?=
 =?us-ascii?Q?56zJZrV8Sok930hHeExg80R+JzdRwsUfRE2T2QraqnhgI4QIlFQKNbmUMayc?=
 =?us-ascii?Q?4R2q3C6w4/izVbrieJ7PpSkveKvnYX6nJb9RJD5qtRim4MbGamNi3bh+D95B?=
 =?us-ascii?Q?xKldheylJ0RhuDQFGziy3/JsB9YTpDtQ0y+ufPqU6k+HnqnqTj6Q3tCBZY/Y?=
 =?us-ascii?Q?iek25WG0lTNoVVLsVSEIu9N4EO2M3Sm/hHiQEqM4OXc7edst6PRam3LhRZyW?=
 =?us-ascii?Q?E/G3Paflte8/ebdTD3Mmt35oA/44TfyLZolh4trQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a6577f-eba6-4adb-fe12-08db1079dfd1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 23:59:43.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8LXAI9q4KF5bz8ZD1MQ/FAHTmzPWSvgcS2oe8IY5dLhaFAzSn2WopCKWBWm1Ksv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5345
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 03:59:50PM -0800, Jacob Pan wrote:
> INVALID_IOASID and IOMMU_PASID_INVALID are duplicated. Rename
> INVALID_IOASID and consolidate since we are moving away from IOASID
> infrastructure.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  Documentation/x86/sva.rst   | 2 +-
>  arch/x86/kernel/traps.c     | 5 ++++-
>  drivers/dma/idxd/device.c   | 8 ++++----
>  drivers/dma/idxd/idxd.h     | 1 +
>  drivers/dma/idxd/init.c     | 2 +-
>  drivers/dma/idxd/irq.c      | 2 +-
>  drivers/iommu/intel/dmar.c  | 4 ++--
>  drivers/iommu/intel/iommu.c | 2 +-
>  drivers/iommu/intel/svm.c   | 2 +-
>  drivers/iommu/iommu-sva.c   | 2 +-
>  include/linux/ioasid.h      | 4 ----
>  include/linux/iommu.h       | 6 +++++-
>  mm/init-mm.c                | 4 ++--
>  13 files changed, 24 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
