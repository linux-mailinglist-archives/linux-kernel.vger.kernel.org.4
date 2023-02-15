Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0145E697C33
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjBOMtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBOMtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:49:21 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F8234C10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:49:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvIy+2/fM3j1A24TK7KFqkWHeSjr7IxGU/TzTrmnfwh2qGZcqBWXZlD+4Lir3wFE0tReq4vaST6GT0BbCak5tuVZgcTQCwmvmZeGejtJ93HiApNQUmX41NXJyu2c+4yULaB4j4FmqDhJmeDIYKHc71H6QpUGlrUhyx6LWbGT2xrFVMLlAidmbgQW6M1uSWFef3mV6nSGo5jUJ77GWovfNq6SY/TTuGA2q3ISjCECxyWFCAb+DTnLdb9SmoKlBgqNE9rhmg/C3dT6FrDDygvlgDBLZBMcqyty4iVEm8bW7xO7/CW/wXzE6PZ411p6ROUWqXhd2SDCwuyFKe2SRFnTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYPGksnHAUoOq1mwEH3OIh5kLBdI9gNac4XK1yomxuM=;
 b=Z8iA+aYgMEd3L3WKVuF9JKLrQ8F6N6zzNRcyTRErxCKoii2a9VZa9+qw+uzPPl9s7XCFUOXRduhM9oikJZWC57rzoq1jlNBIH07BLh31peKdkX64cLrYUth+TLkvpY/0H62NQfqIxf9EmYdFcPt8JXhCTi4Xevx+v7yLZZh2Tmo3abm4AKQkMjc9b3aWxcf9oWVq7CCUxv2wcdZ4JPhFhiQ5fKjse0uFczITZRyjxpK4Vj1q7HsaRzCgR75gP9EHBF95p2EsZ8EUxRxnUOD6c9sHXn/8+8DtHzk1k89nC6O6w/1y1i9xzXZBP8LzeKhIH5iLym6eAlnz/7MtdtAHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYPGksnHAUoOq1mwEH3OIh5kLBdI9gNac4XK1yomxuM=;
 b=NpY6OHsDhDIKMhNxonoYyRiOUIFRCt9LfXBRfLV2WP6ZnEDJ2aZFdjbwuC921zaxMPyZ8c3ByBm0XSBg3xabcIx30B1JeaFSJp68KD1+6p0/QMfC4sPT0WHhJemmY1GWXWEgS/qrQKbHiMam74d3P6ynz9CHvqyKyTcYyhhAaloFf32Z58UMfiqKIw8wICAkjxVzNJ3mZJiLFW2e4awjuuDIVQBLfTM/BTTerDMlupleWqwUTaV+qo6tHd5DRgSd4OvddfQ5BZYfE/yvyNPIKXbrl8/sN/4wx6hTQkzk2i+iyOi40fk8P/1Do2/Z+JSVtvI+7QqG+ck1Cnqnkuiqjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 12:49:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 12:49:18 +0000
Date:   Wed, 15 Feb 2023 08:49:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 3/3] iommu: Remove ioasid infrastructure
Message-ID: <Y+zUzQqRE4LfarZJ@nvidia.com>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
 <20230214064414.1038058-4-jacob.jun.pan@linux.intel.com>
 <Y+tVMRzRQbcc7Guz@myrica>
 <Y+uHSry/tpgGNr/b@nvidia.com>
 <20230214093107.323d7e76@jacob-builder>
 <Y+vLiWS3+Rp+If6U@nvidia.com>
 <20230214133352.1f69b624@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214133352.1f69b624@jacob-builder>
X-ClientProxiedBy: BLAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:32b::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: bcabf702-9329-4d29-7898-08db0f530d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8s8SFAQTRW8NVYpA4cMWPabEbQSsQIqlU/UnY68j6yLvZ4o2+9XjMvSeAdKUbBPgMSoZrSRcnj4QY3o5UDqTBR01wNt69YTE7aZB2pTFTBDm9N8rp969pDwNUFI99nd4D2vpie4lKBEsiTDkzzYSjMyjHNwTVWAZVnvvKzYZMtL8Hw4rgmffP+/CI7oU1fvuWV8guboHNt0Tod2zv6ly6WW58R4KyUCBXiAq637pjzJBzsa5zG5skOL/a729wiSBCF6HjxTM9BASfJ86xbiwT+F2r7ehMpUzb3hRvl6Rvy0CI/aH0/a7Hv+KqmaamRPyVLAvN6Yd6X3L1xf+6oQnMCUrxQ6y1pjK6dqJRo9RnNE4ehoHIjls4lS9B25CPcDWVOwzZvrCDtmICN3wiOGMlcrN8xnbxze2YdU05WC0xl0240Vk+58ZUoNs1BoxfYG2olG96iPZOd86VcsQk7zGedNk0rKWz81RSSSNW/pUythtC3Gl3keU64MpNmKdzsWlwnWN83UU5YQke9dYZqW+SaVadhJd+Fuw3hqo7xJHVeZl3fNQzdbyfK8Ttv6Aqc5uA6mqn+q4Sp7k8bv160hmrWNTikwjKnvvMEVr78RiHErlLLfn0dzpI1I6ciPBDSVhqOhM0twOf8rooIGqNCZN3jl5HXCJdpbruzs3MHdXH4WaxnD2FVVVctcHW27V5N/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199018)(5660300002)(2616005)(66476007)(36756003)(66556008)(478600001)(86362001)(6916009)(316002)(4326008)(66946007)(54906003)(6486002)(8676002)(26005)(8936002)(6512007)(186003)(41300700001)(6506007)(2906002)(38100700002)(83380400001)(7416002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZCWDDR5SYOdCJC0v6LIQIetJQyzQHhdORz49FaJXwqsA0akU/IpGFsxAsKhf?=
 =?us-ascii?Q?8Die0dFs5yd4K5Cp2+ZOAmY5I5ITX946P/wUmmH/sa+xCKw47kKaWbLkJnmF?=
 =?us-ascii?Q?Zmt/e3ACKBV/PQ7vSFsTECpbqi0AYuBGDdK5uu1IN1+9UDnhahflMF8aedAQ?=
 =?us-ascii?Q?PlRgtRfBP+Vsff3IwDP43CqQRVsHF1r3/7qqVrhzVGdksNjevkhEFxJjdPvt?=
 =?us-ascii?Q?6kwOpAJINQbPWI0HHM4fnmfxmWTS9SjoeuiWyyQURJmJq/0qh6TtdWYxvm7/?=
 =?us-ascii?Q?poZJQUvlfZXLmoWBSzen4rXz0Kag0+Ax5KioxVXwQyYsqjss/KHg28lYvBr0?=
 =?us-ascii?Q?sxAYtagYn3oj58lVB7BUpqbc2B+LiBNKBUQ17AhpHh0rRoS+ihyVuqIw43Dm?=
 =?us-ascii?Q?txiCtqIHL7W7ea/e5LdVIK6TnYAivc5Rt8nBXxzBOfXu63j2hIUB8Kqej1SF?=
 =?us-ascii?Q?txjeHL79LwrZ/gxr3u+nKxjwtEMaN7JeF/Fo7BKj2IrLYsvAlDbIWeEfVicF?=
 =?us-ascii?Q?7g2XhVoHmBx49foIZPRAWC6ZXVXlf9i969CtfSJfAUD2Hd+K09pkoiN0FjzV?=
 =?us-ascii?Q?48O8xdDqm2gR+YqTljN4O5yd7dassjpilVMRS3EGGqBQddJsYQRFuRatyzHF?=
 =?us-ascii?Q?e2Wl3esU+26o2hv066bEwij9wDB5le6y5Z1Bq2CTXm9ktiJPQb5NDQOqHc+s?=
 =?us-ascii?Q?jlMXQ8nWAzxYlAugfabOlunnNTmkH7jjLHtQEb48yRtPqDpDFAvlOfce2mVQ?=
 =?us-ascii?Q?MezVXq3J2kg0BCGg9u/ERhjG9J/sLSwX1eTMnzS61HhWs5IBWYcxVV7/ZmUu?=
 =?us-ascii?Q?NbPWT9GD2ZEpTXuizuhQAQ6gblvPckMiyow2ZwsAPna+RmvUnHxNZVqxJki7?=
 =?us-ascii?Q?bFdYA/tdPgrPfBOn5haFoOvy7n+++oxQldYuHwDF62Hbnrt60XfxWq5sX6mo?=
 =?us-ascii?Q?oAQpEchBsrHdAfHdeZHi72/0O82610o69CX6LJQtVJBU1vm1Fcp2S/6BGunJ?=
 =?us-ascii?Q?UlLrCmNoNaKS3rcfpCgGhj+8wibnLsxzHdwIIRfGSE10Mvf3Bq5zt/A+082D?=
 =?us-ascii?Q?qCwBOCoPH9QF1tNKE0ydJSACK00NIkfmV5pVlt6ZngN/zSDp4uNyYqj0zNm9?=
 =?us-ascii?Q?tejzKJcxqyqK+ukD1j72dXUBMHbMp3ZPs1VRtvJWXJGBZbCdbbGDzfq9FmOj?=
 =?us-ascii?Q?q+JyfzRnsKNyiMoHVAY3ylALC8tU+a4dP3oexKWbzIX6RrPhMLGpuiBs3cvx?=
 =?us-ascii?Q?T5wbZ2XILCfLbC9jur7p5HpWpJgT75xyemJk2mYXMF8mHyWPAEnRbr0ge/1q?=
 =?us-ascii?Q?A7iN6EfRKHoQGzFmmhiCjF2jJ9To+YHOyrKDm6PzbQJBw14K4/JmcM8oIQM0?=
 =?us-ascii?Q?MTzquYGVjEKy1wnQ0CO4Sh+FFhULetIabwXVwPO4cM51DSnYkvTPtxFmnTTq?=
 =?us-ascii?Q?EgK6SwRV2xgZs9gKugyXC9EtLqU/Gfv6934RbnmmUmLRaLF1qmmmZc4laR7n?=
 =?us-ascii?Q?cnV+ASKjtBuCLqH3fLy6BEe9pNd3z2JavKnoGuANLqd1eRvTmvzM41tDBykh?=
 =?us-ascii?Q?t2o7ARBHwozIAyrMPlTycZZe2uCVFhxm6XNy2fBP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcabf702-9329-4d29-7898-08db0f530d1a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 12:49:18.1003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5frLFZx+42B9Yty3llmb3YZsLWW1cIjKNQ2uC1mnsA2+hTnFCV+y8Y0pjv9rzGXo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4576
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:33:52PM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> On Tue, 14 Feb 2023 13:57:29 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Tue, Feb 14, 2023 at 09:31:07AM -0800, Jacob Pan wrote:
> > > Hi Jason,
> > > 
> > > On Tue, 14 Feb 2023 09:06:18 -0400, Jason Gunthorpe <jgg@nvidia.com>
> > > wrote: 
> > > > On Tue, Feb 14, 2023 at 09:32:33AM +0000, Jean-Philippe Brucker
> > > > wrote:  
> > > > > > diff --git a/include/uapi/linux/iommu.h
> > > > > > b/include/uapi/linux/iommu.h index 65d8b0234f69..a95f07f0c98c
> > > > > > 100644 --- a/include/uapi/linux/iommu.h
> > > > > > +++ b/include/uapi/linux/iommu.h
> > > > > > @@ -157,5 +157,6 @@ struct iommu_page_response {
> > > > > >  	__u32	grpid;
> > > > > >  	__u32	code;
> > > > > >  };
> > > > > > +#define IOMMU_PASID_INVALID	(-1U)    
> > > > > 
> > > > > Why change UAPI?    
> > > > 
> > > > There is no uapi, this whole file needs to be deleted too
> > > >   
> > > ok. another clean up.
> > > 
> > > As I also replied to Jean, I ran into a circular #include problem if
> > > mm.h #include iommu.h, I guess I could also create another header, e.g.
> > > iommu_defs.h to avoid it. any other suggestions?  
> > 
> > Given this header is not used, just delete things from it to resolve
> > the problem?
> no, sorry i didn't make it clear. I meant if we do #include <linux/iommu.h>
> in sched/mm.h, then I got circular include problem.

You shouldn't do that at all, mm.h is included everywhere.

Try to make it smaller not larger.

You are better to include iommu.h in the few .c files that need these
shims than put them in mm.h

Jason
