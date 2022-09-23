Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9567E5E7D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiIWOmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiIWOmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:42:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F2912FF28
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:42:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esK5ksOAei87CueW3P6xvgsPiRCtkfZDNPAsNoRUKb9voceGsRnydUwpdYMnk5u4eY7RDELizjAUNDwFgNgLUd6wvS9JlTmnRlt8W3fgamo8J2HJGQaF6NSx+7iovCgNw0uy4cOziCSXwqka65UCJigsLlYQ/jeTzGnDTIz24lugLMPZ79uTFMS+t3HyUoDhUYz1y58Bv18VfaXkPIMM4prL10jGJq2OZP31BT7M2r4kT6lC+7QnLCwC0hjLnpc2m9w/fhrU+eTJNjrLr7fSEXgIqQxTXL/u1z3mbu0YjPfSV8hEmCxvDwr9xpBM4iGV6CACXtjMsAccG4Ac1ZSCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQKsYD3iLAySdX5l0LtwpO9r9GzEMYE8gKWAN5ovInc=;
 b=PbycCoaCahFO9feCrRdoebbzKIDnjdXw0jzWNAaXV/97R8YjQbcu8rBN8EZjhv1uDFybtqkdDaOx/mW0I/2ziFxu+SdC9qX1vuhgqXA3eij7+wttUOESAEL4pGbI0N7Ty5EkmUrdd4edo0lqEBmlDqCnTpnSCsf+EC/Hb1ERtINInnnmGgrx85QmpkU+W0rB7cwasIb0obYo9Gt/LyE2edsEPWp/a5+GC086/PL1HZgfL6wPJ7Pz0UBFuSvwzuuaSM+ZSlzB+oJLXoBH6++WspQXculG7pv2aVwJWvcUbuyI27XRP87jqRWd9ibyHwca/yfRJDmXYuDSiH1kN7W0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQKsYD3iLAySdX5l0LtwpO9r9GzEMYE8gKWAN5ovInc=;
 b=Wq9lB0l7DSgDIq1RqsrAxiNXyfauXeGA3ZbJ8w+8/6cYSn+kjRCl8KGrVEvQ6/V84vYxCQ01QbxcHVGGWi57ZLeReqslSKhbqRvfMrMupklaX/ilcl6a5MHfqsVyaBA2Zk9VAfhMgWB9W3UcERR0h2eE4HiNYY2NlfNFZ+3cu+ezWcT/eqwBIlXO8hP1BazNsdUtwZOjaV9RalOVBGIsa3A854mi3bhBSuuSpKg1xqIc+IH4ySrsn3mSx9XkWEDOk4yKfX9MN2629E1QDIqJJeqe1TcI/CBnu+1LWCrIgRIT5QQFmNRv4IWw6VdM3qlVwaXAqWRRHPVOs1sawcjtBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Fri, 23 Sep
 2022 14:42:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 14:42:42 +0000
Date:   Fri, 23 Sep 2022 11:42:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <Yy3F3+PA47mzX/2o@nvidia.com>
References: <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
 <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
 <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
 <YytT1hfRZdb9GYQK@nvidia.com>
 <20220923004239.ma2gfrmoezsff4ro@box.shutemov.name>
 <Yy1D0dLdqTr7ya71@a4bf019067fa.jf.intel.com>
 <20220923093826.kjad4qe3clwybeh6@box.shutemov.name>
 <Yy2cfppqkf85hPT7@nvidia.com>
 <fd1f54b5-010d-da65-3989-d8cf727261c7@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd1f54b5-010d-da65-3989-d8cf727261c7@intel.com>
X-ClientProxiedBy: MN2PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:23a::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a602b8-fa05-41c2-81d3-08da9d71decc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tv+y6Nho6a0vyLOpGJcQN8AAnJa7tKEKGGhJKIsN6FVXvVXGou8pX4mqI3bt3l7QuHh+Dhk7ELY3wzRlmaAk95F4oJnx07gOVDRh6q9JkW11KtkMnPoRubdD61e6NJh/902Ypyt/15TMvHuxCM4JS/nMBnw+rkfwDPemRfz0b7hPz1bdS/IXAvcle4JcRyMvH0zFkzM8ETk8Hc47SNx97XPMWq1XGFOtzegV3lnJu+C/FWDdYGy0YBJn6aY7R/7JvmOaR1zXys0dRa9n7hKTp6QLl01ZAeL8bBPxUS+uz9ZelJk3iEw+43hG7No/IURCqQoDdLssVvsYfwuVbvsrYx/6uIHNv8dFXe2z+SWdKDVslSDaTJlnDe/OvrZC8hYIM3oRA66b9YIYhIqYYnM7NkaBNIGMtdjanhwIUehqFqBkkdNxwYdgAnUFgjEi5CLW3ASds40UE4IcIBkbJ6vdzg0zEZu+MU/+SB7F/XNEkBZX7X52zbPsutyomRQsu8vJu06T44OvW0bWBomfLj5iniqK0hDZzl9r9HeuTiD09QF3R3Ubu8SnBBx1DPJhHpKg2QZhX2ssP4fDGRfO2ML8sxfszhskELaowI9q/eL5WCrt/4XXVvl8ErU2UDQKD4eJbRFVHdA3atgqY1AVnuRsOsUTmF3hgYWQwmFEMm5bXLfR003x7egKrFhJwIJJ6VBfC4348dI4sxCV3wihPuTc8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(2906002)(66899012)(83380400001)(38100700002)(6486002)(478600001)(4326008)(6506007)(186003)(36756003)(53546011)(86362001)(6666004)(41300700001)(8676002)(2616005)(6916009)(66946007)(54906003)(66476007)(7416002)(5660300002)(26005)(8936002)(66556008)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YUyx7eRMfOQ2pPtAjfGp0je50xox2b3FAx85qZdkwaFtgy5vnc/4bLmaJcbh?=
 =?us-ascii?Q?bXvSXb7k5ABWSKK+1hzt/JW/abH1TU3dhzLr4E5/P1dVvEtmhhU9zSpVM7J3?=
 =?us-ascii?Q?KGD/I7ttje9OleqCxkj9+zVV5v7iQ8DHQh9aRuIm4clP7IeXjvORXMxCAVkM?=
 =?us-ascii?Q?ENxTBC/1MCndSdFPNNIvazxU0UVF+byana1sTG04ZIzKf8VcQqCrBrHbvUzv?=
 =?us-ascii?Q?mkPsoDENYmeZ9IqaBtBZ2TbAQj2njMgNFpA08cI99LowB0gJjlA4aCxhrnww?=
 =?us-ascii?Q?jiO078bpp3GFzhD9gwlb+uqLXkmHCvdYUzLIwBpmaGVG1VxMEXn2ECaMpLQT?=
 =?us-ascii?Q?LU3YSdsdFRP+n8EZ84j4iG9J6zQtwVV7e0R+rePr6MfryWalN2nWBCXS5oce?=
 =?us-ascii?Q?7SGpNmoq1Yroy8QFggsyuITYXkm2QAXmuMYTEussEOONbG6q69qS9XlKSMtF?=
 =?us-ascii?Q?ArqMhlewavNRbNU6pR5TfzS+q5V5ACqjyYnMhJmj6Nu0ik5re0nOfnuFxEEX?=
 =?us-ascii?Q?NxSjl/B/Fqmm/D+0kgbzbIAIMoqpFJIGoNgnTLRd2zu+gCb0aOfaqrtth1u0?=
 =?us-ascii?Q?8d1hjN6E6InbephhMFma5YmQGsgw8nbAc1t+spCWtt+PwBnYRJHBY1XaOgtS?=
 =?us-ascii?Q?uI8fNv/0e6Go5ngyJbivs3KnkpuPTrZZSntt/Dhk2QFMLze2tTglK0kVOwkC?=
 =?us-ascii?Q?Osg8/n5DTSlfmo5BhavCjNG27fW7LpeINawtHRXHZT4dHjQjac2DaAWlCmgd?=
 =?us-ascii?Q?Am+aNYyixhp5yd+YvxsBQPbRlVg1jh1q12LHMpQam8UArqa3mjubWK09gPGV?=
 =?us-ascii?Q?8Nh4izs2flM6Io6Ijy8+4gLVbljXF8DKKHxkiQVorjVzhevuy3+1V3uvz5k/?=
 =?us-ascii?Q?Gb8WgaYFsMBtyz4kW2uw2NlRg9Q6jyzlbyf/tfO52AR3V7EKKzSLOeRvn6P1?=
 =?us-ascii?Q?RLcD53286hijazynIlCgH2e110T+KypLMpMAziTktNxElhKAdH+/+N87O2BB?=
 =?us-ascii?Q?mYlbEsCOS10RQsK6/bMj73RACzqwvQr6Lz/6bPAteWoQc9/C6081UTT+oPno?=
 =?us-ascii?Q?ik2CZYUj34GxbAJTbXyfVjKX9HuI63LfOSQScOQbVh+v19l7ytjFaKFdeN/q?=
 =?us-ascii?Q?nYf4CyVUPGjiISWJxCJmV6z2/+RHixQwrS0YGuDPeO6jBTaUMTyVjy7e3Luy?=
 =?us-ascii?Q?ZlHVJQDJEQ2JVx6fDMvxE9z4Mgc85SfELG4ht36si/vh+i4M+psz4oTPUVhb?=
 =?us-ascii?Q?zWW/CG3SU0inItzCIlS33AsDCCPYkGVqg/lDxq8NVGQl8YIeFUHHGJgfy0EF?=
 =?us-ascii?Q?Rl766a2ZFtHCrGIpYIvKcrroyXQihoAo2Nx+9QmUAyw7rrksgWY3KddFMh4t?=
 =?us-ascii?Q?g8/vaZaiJ9OOXvKQU/YbpFV2sRuaHnchyFryGl+KuejCg7kUW0AkoQP9Ag5m?=
 =?us-ascii?Q?ugHeUkhp+CgfqtclUP6lNieSjDtGm2U+VnzSoZ/yONMQFQSpwNvc5G9LWZo2?=
 =?us-ascii?Q?O7Y9m/KhTioo1NSF28ohe3RYWObl8P9c5oBvMJaAmt9SpiFUg1aawsYFhZbD?=
 =?us-ascii?Q?ATjFSPj00pPBvgBSoXlD23iSMwdeYJN6oONb6IWv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a602b8-fa05-41c2-81d3-08da9d71decc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:42:42.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TkeDg0ZGQjqehIVs0fqkZYIzigiiS88ud8A24U2o4R16eEk/VHdzp97HB4M5tWC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 07:18:42AM -0700, Dave Hansen wrote:
> On 9/23/22 04:46, Jason Gunthorpe wrote:
> > On Fri, Sep 23, 2022 at 12:38:26PM +0300, Kirill A. Shutemov wrote:
> >>> So I would assume an untagged pointer should just be fine for the IOMMU
> >>> to walk. IOMMU currently wants canonical addresses for VA.
> >> Right. But it means that LAM compatibility can be block on two layers:
> >> IOMMU and device. IOMMU is not the only HW entity that has to be aware of
> >> tagged pointers.
> > Why does a device need to care about this? What do you imagine a
> > device doing with it?
> > 
> > The userspace should program the device with the tagged address, the
> > device should present the tagged address on the bus, the IOMMU should
> > translate the tagged address the same as the CPU by ignoring the upper
> > bits.
> 
> Is this how *every* access works?  Every single device access to the
> address space goes through the IOMMU?
> 
> I thought devices also cached address translation responses from the
> IOMMU and stashed them in their own device-local TLB.  

Ah, you are worried about invalidation.

There is an optional PCI feature called ATS that is this caching, and
it is mandatory if the IOMMU will use the CPU page table.

In ATS the invalidation is triggered by the iommu driver in a device
agnostic way.

The PCI spec has no provision to invalidate with a mask, only linear
chunks of address space can be invalidated.

Presumably when someone wants to teach the iommu to process LAM they
will also have to teach the the PCI spec how to do LAM too.

I would not like to see a world where drivers have to deal with this.
ATS is completely transparent to the driver, it should stay that
way. Devices should handle LAM through some PCI SIG agnostic approach
and that will be contained entirely in the iommu driver.

Jason
