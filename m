Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907816983C4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBOSrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBOSrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:47:37 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5C3E619
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:47:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWINMKWDTvKTEJOLP/4qa//u9CQz33t6huRHAD5J3IxqEj/NN7Hfx+eXHtg3N6lr5bIVArIibF3atJUBR/jZ06mXu4uvNu4r9L0Wl8/GvrtJKxMZTI3CUCNXB17cnVhm98/LjP6K9sIe/QRDIcyjeij9W/KtYL7zLXHxgRctwt1QYBr9PcCi6YeJSU/7Pfk+ObIpvUxK0RCTlygMjm2Z4Ebmkj6aIt6fSMjyRbUyB2eCCZe5WcM9+7Wvy8jCKu67J+tTuZHKiVJc6t84eYvNH3p7I0eK7VMOiKbD4HrrBGYOgQVUEnJA2sYBxyHQh+1iaHx5H5PtMMed/RCQ6JqrXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7+ocF1XTodoVj+guL3bqg/vxjxC6BrXYEcec3Dvgs8=;
 b=Fxh4xXOn/hdWwNHObCHrzTbwnS9o14alkuDw7udEad5+G55hUcRu9m2PBXLz7q2GnmJsgKuv1xuWJmo0zY5r0KI9sLryEsvyQ1Q9WhOX80ZjxENimIrek/6uZofi5Jmikx0GNcE+M51NYm+RvmzWmdWyAZFXCzFUKaNl7KXoeYUn5CaaNFPBMkDCvUDXZvhGLsTPeHqNIgskcA2Z68LwJKazMSXLZt8/JYGkNKN4n72zKWuT5kcmhbTYEojAl420QgGgaW055tXHey5f7lRfG/S6ma0N10/XwX5+VyPwAseoTq/eJBNiOSZzqhNLVoQWYerG35iZsuQGPqqxuCzQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7+ocF1XTodoVj+guL3bqg/vxjxC6BrXYEcec3Dvgs8=;
 b=I2zoy3wKIxgmIu012unCjwo0DItaWwRegrP65Y79hwHkEC4XSw8fwODJ0vH2xRGAZ6bUKQJwy3ykM4/EjjqhGtW8EIfkZJP3OC4mQ0dh7crUGOmTqYY7LxyklWoguYaYsGl+JRcvzGwa+Xz6vAmGg+qMLf6fEzpOPtkTM6xcG4uIxu3Q5kLi6hi+r8XA2XfnTfgMO/+ONszb2LDeOCOqTN/xgZ124zeQSDqoi8ZRsUGO8iKq15c2xL+05VlFncWDwlkw/bZn2hkzni+kzJ6SA0aPYE/siDPgCAkeXpvcmbES4Yv/LNyBs+2fWJ2VZWf788eD9aQUYUr7CPhQn68fSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 18:46:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 18:46:44 +0000
Date:   Wed, 15 Feb 2023 14:46:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 2/3] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <Y+0okzkbTh6mw0EM@nvidia.com>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
 <20230214064414.1038058-3-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB527670F77FADCB351E41F8B78CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230215103822.6235ada9@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215103822.6235ada9@jacob-builder>
X-ClientProxiedBy: MN2PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:208:e8::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: a9696bfe-20c2-4faa-d896-08db0f84fc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvX2NmEGh//zVzM087ye2s/m5Y/mjE3kL6OyfBr2T+CoLGcgHAIzXADzu+Z3jmaJln+lH1xddG65BBOQUKAj/83fX92Pgl8HpDW02oqI32oIYKvgKwoGMwgytsJEuJcAwHGKJy+XMqQitaavrLV8sE/5Ax4c4Z+t56++PPBvWJj/iZNydYI2pE0mKWGVLk70NkpEG7d+o7yptynDFTDZIO648FyOHNnnbp6t2dAkxzGuIZnP6uMg4Kg/VnAtktpnPH4Vxh8C3LGlhQI/Lp1IliBpBjC5An7KErAkSb31EydFy870zLFnuTYfernue7pJxWM6jawXKY0Xz/PwY51GyO0qiJgvLJ8KodBVQXNhvjKz1wqtc6eGte43WRbkk8LMiKf0f/4sDcyTfFiS4/eicyBlCFEIDVLS2cKExgtMye4siJZ0VkJ4+PY/NS9T+uRlKGQRLfwQw/D6HvXW7jPKAV+rMBRzcYdt7N2ul0WMDG242w0Zi/84w/5AFfeI4cdClAjppDt/4kuRIrhvP3TzWelz77iXEBhdatPCJBCDspsCAIo6pEwIiZH2JBHjh3fUi1U1KR55G03VDscsCBGJAWWX+xNKT2aPNCSezjATilGzOmCJXLM81R97KX9yr/LEvppUcVWmFh9/MlzKkG3Z9NzAMgYuu0jdlm4m1UqbXly8sR0EWAJWG9yZxQe93mEc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199018)(7416002)(41300700001)(5660300002)(8936002)(2906002)(54906003)(66476007)(66556008)(6916009)(316002)(36756003)(8676002)(66946007)(4326008)(2616005)(38100700002)(83380400001)(86362001)(26005)(186003)(6512007)(478600001)(6506007)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q12mA/+eZuhICir0Y2NrIAFtIvn7XYnAfHNslEGs6PvzqhtNv9t6UMHV0YSs?=
 =?us-ascii?Q?ZEyV7Q8blhIBr8BwmlGPY2Q+H/GQG8JA7fOW9HgLIELR5HTYvbCT2i/CNoiM?=
 =?us-ascii?Q?/d1MtUd4yJnw0gVD5uR71iktmvHXktxBg4cKhcx458nhLlhJsyNUseAYqfqo?=
 =?us-ascii?Q?8IPk8Rx3od8bJUXeIdKVU0NR9mXLMXIaGNpA9gmhmihGejHhdGk3QJ/2MfZk?=
 =?us-ascii?Q?xUItk2SxUx6kCVPJA28q/Rkzgk3Tom3qY5nPf6iqKhomjIetgJB9xKz4mq2e?=
 =?us-ascii?Q?FebGrIyPHhaZ7w4joZdiwZd/+jEFJ2o0T9dyGUOwrB598cn6sh2U9J8eqxPB?=
 =?us-ascii?Q?ULdVb33jDvqQkLzfq0pMvDD2X614xHZBk3MvJY6oIbZ4QLzWX7OZAlWrLgfk?=
 =?us-ascii?Q?tz4/l3o8hKZxbJ4RpM4D4gNw/RowkbwvItCrnTq3AFutNkZHw+RFiYUZPy8o?=
 =?us-ascii?Q?1suX5I1JhwiQ8VVgc0xGILSKTJv3T8xqxC1tP/6jq3hVUjwWPtmVr7zbVqgN?=
 =?us-ascii?Q?UGl5TJED2aHQ3V663Xel2erprj2CzfcJxGctdN9yRVi0SbyvTuCgeS3trNNr?=
 =?us-ascii?Q?lwPiCWzNBMmE3Bhq29YP0lSO7MmIQdF+JzYSaVBbPE1JS9runl4CnHGwZjdk?=
 =?us-ascii?Q?aIO2ZvK3GBZFFrOoeZEyUHQt+5M4ssTJZ8NKmOaWXEz0ZgC0xOLqahAr+vDp?=
 =?us-ascii?Q?+qIu2RIRT7t+B7CivwykQxb6odpC9OU2/0QATnJRFQpgJkEOEdTakrxBnY0f?=
 =?us-ascii?Q?hTzkjncFhGNPTC0zfnDLRo/HQd9pKafkT2x2xyID33QUzqk/9dbyitCdBuQB?=
 =?us-ascii?Q?nqL1iWSHZgkrvGI3lXyAn1Z7joTKS2JDke4Raho+A6O3UjI8+Ifk4nHf3dUw?=
 =?us-ascii?Q?GP45UL1m1a1VQK+ZzxtdHQonAyebQf+MY/BhYWi19vgZex4vupZ4kULI4ceN?=
 =?us-ascii?Q?Q5yeDSZrJJuDa/q+SeJ5nWA7n3lWAunV2K3yjtJGnwH7ozSEpdl+1l875Hb5?=
 =?us-ascii?Q?x0ytZytn1lMHwxbE0F+kYl7H7t71LoNRgKqYvFfm9OOEthp7jFFOeSDtg27W?=
 =?us-ascii?Q?KM6Lzk25UjOPSxnpPcaUwhFHz3qwNVyhzw9OAZPGbXn1py0k3fFEcPZ555MS?=
 =?us-ascii?Q?xbDhxvSIxhdMwhOb3bf4VRUrwk4K5F8p4R1N6dd/NQr2H0shtnPEWu+ZgdfN?=
 =?us-ascii?Q?JWQESDHl+MD8oU4E8xjf1rDwKMSGySlTHM2nY+7Rshpb1SiuCu9hK5MHFWP8?=
 =?us-ascii?Q?+3/XjpVEG4dJr02FhAYo6JauhC/72EeU2y65KCK6JvpayYTGGv0Q6tHc0d0h?=
 =?us-ascii?Q?ATNIJ2yj/qaOx51OxTAXNoDJYowbfTEeYNFlgvtoP1Xaf18PllWkpXdw7o6M?=
 =?us-ascii?Q?wzAYTHP/HLNs7C/gXgRgcXlN9cr7B/6wALf5NADaY/TDwpVMDRKRW8xfVA4l?=
 =?us-ascii?Q?40d1AQmXvVk+zMPJLiCQQ7S6toUyT5GaaXdolOuYFUmHvq9NXdXJ3wWyegiB?=
 =?us-ascii?Q?16vCk54mhbBzsTuc5xynhJUIS1rfb5BDLYzbEu/ml23OyT8yRsYxvNMK3EZt?=
 =?us-ascii?Q?C88gDGhbyujxRbkpRZ8qpPaQhiJ6q9l151mOts/Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9696bfe-20c2-4faa-d896-08db0f84fc46
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 18:46:44.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQF0SXo4RSpm3edxpqINQ12zAYa9jgcpeksfo9V9TcOqBKnlk+fufVF+RHaaaFKV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 10:38:22AM -0800, Jacob Pan wrote:
> Hi Kevin,
> 
> On Wed, 15 Feb 2023 03:24:18 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> wrote:
> 
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Tuesday, February 14, 2023 2:44 PM
> > > 
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > 
> > > Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> > > each mm_struct.
> > > 
> > > Future work would be to allow drivers using the SVA APIs to reserve
> > > global PASIDs from this IDA for their internal use, eg with the DMA API
> > > PASID support.  
> > 
> > I think DMA API PASID will need new API around this IDA. SVA APIs should
> > be just for SVA.
> > 
> > > +void mm_pasid_drop(struct mm_struct *mm)
> > >  {
> > > -	return mmget_not_zero(mm);
> > > -}
> > > +	pr_alert("%s %d", __func__, mm->pasid);
> > > +	if (likely(!pasid_valid(mm->pasid)))
> > > +		return;
> > > 
> > > -/**
> > > - * iommu_sva_find() - Find mm associated to the given PASID
> > > - * @pasid: Process Address Space ID assigned to the mm
> > > - *
> > > - * On success a reference to the mm is taken, and must be released with
> > > mmput().
> > > - *
> > > - * Returns the mm corresponding to this PASID, or an error if not
> > > found.
> > > - */
> > > -struct mm_struct *iommu_sva_find(ioasid_t pasid)
> > > -{
> > > -	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
> > > +	ida_free(&iommu_global_pasid_ida, mm->pasid);
> > >  }  
> > 
> > when moving this function following line is missed:
> > 
> > 	mm->pasid = INVALID_IOASID;
> > 
> not needed, mm is gone by now.
> 
> > btw the current placement looks asymmetric. We now have
> > mm_pasid_init() and mm_pasid_set() in mm.h while mm_pasid_drop()
> > in iommu-sva.c.
> > Is it cleaner to introduce a iommu_sva_free_pasid() helper and then
> > call it from mm_pasid_drop() in mm.h?
> That is what we had before, it seems logical to me. Jason?

I don't much like a maze of functions calling each other.

Renaming the helper might help, especially if it comes from iommu.h

Jason
