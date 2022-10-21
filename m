Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2E0607897
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiJUNgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiJUNgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:36:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F02505E5;
        Fri, 21 Oct 2022 06:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIJMnbaDZCUZGxcVm2CIRQBwi0Oa20OuTTrk4YAcMBykL2FViJHezcn3RbPGAaKr4930kxpGRunKSx9iJ3TCjsCO6a2wncO8C8aYd3vN2tgFRjL/eO+0r9WsgVGPebwFGDIk+kTF9qNM0WkEa6tP2TOPFw2BxYb330rWvmY/T8Qyv0egHQzvDpnJkH+tPVcNdnz32Wrdr57uvYGkidp8tJq4rgTMkTx0VI5mYKXkIbzH8kgev8HNHq/vH1npV1Mwly/zuXRpw1AvmZe3hbKdLBjdKwJTl7+teadV01GuCDnQuu2Q2dsvBbrfPMO7WJsiJmku3uaffccGLjmlSc8lFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYqm7KoNpdK8njbyICbUEU76LV8nkPwothhHjF5uuoM=;
 b=dTp/qtygZl+7rMBe5jedlIRBHzFgNlz0+E3GIiFUHbRfB4IajgenTRt6xbI706y/FK6YftguHhI36jVC4WL/lHUbaoKUt6iwdF7WvkhlA3OvcSQPg2D2F91mKEz+tArp82e7jbhzNu56xO6zCCBCCivAzm8lsEh5VI7AxCTg1SunrIxlARCJxfNy8cjetgvAb59vh+ZDNKvdPry9OSkKcU4s29xilB+qBISQSv64KDvFxvpbHBPsfNYzD00RV8iZHL0+3n+cCqj45xEce8wnuiPd4ED2Jm9UojXw1Mbnzf9g31g4f3BfsbgugyLkTvJwmjwKtxbdHqjWPU5YeaNIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYqm7KoNpdK8njbyICbUEU76LV8nkPwothhHjF5uuoM=;
 b=K9LTQVB8xnOfU7thVkL5LD8/RhmvDhoFoFOHKesDF/3sbBZny3bnzQ7piOgc7aRvCGr56yv+AzXIuV9A52r+Zf58g8ZNkD1lIYGnD2bfIh7Uqtm7f1ZUaxJOuu240lOszLfHnC9JwCmWT6taBzKlXTvVydgPLSPdDlGUKTqmzMy19XKSmUvSg6suIkZ4cz340oZB95T4vdOulSXnQkjLQUiXZSz3QQxefQavv8B1Gqhahuq/dukX90woZW6nH/ikG2p4H0LAhNO3xmydGT6P33du2kkTpzI9CQzE+ERxuQAZ4iXXY6dO2qOH7mYugeejUkl/fz5yVN5hdzXieKOBxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 13:36:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 13:36:32 +0000
Date:   Fri, 21 Oct 2022 10:36:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/s390: Use RCU to allow concurrent domain_list
 iteration
Message-ID: <Y1KgX8EwH8T+FgWC@nvidia.com>
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
 <20221018145132.998866-4-schnelle@linux.ibm.com>
 <Y07Dz/NROAMI0Hku@nvidia.com>
 <8e268ab5e0dadf86be5fd7ffaa9debb76cea67f3.camel@linux.ibm.com>
 <Y0/lMCQ8oeXJ2HTg@nvidia.com>
 <f3551bb461b3ef3cfc1a0c644093816be1835b3f.camel@linux.ibm.com>
 <Y1ErcEe82yjJI+ET@nvidia.com>
 <68d91d7a5aadbd46dc34470eccd6b86a84c9e47b.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d91d7a5aadbd46dc34470eccd6b86a84c9e47b.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:208:239::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5507:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f64f4b1-61e5-4dab-d04e-08dab369440b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +JxjmD3nDBvk592/kesTsTtONwAvzIZ8ovWG8KBMwQua9m4Vq4xL/BKpdDwi7aPN+sxqCmxd0myuJIZH6+Bb/wKxcGBD2yKZnm/GA7Q+h6tHOEys6cKUwgofqORuFM9U1SO7dLUS/icVCSnl3bwi89c6ceIKQAYEbGkXjmoZvCSHdbYlTW2CAKPhM6zbl15XkwRRlroZJkx8gzjRKuUvgUtvdhco+pwPUGbq7d7lGENO378cZED3LDUzdGr4WxGejd9FIcNottSVe/0QA5lm+jpkJTAtc0Mi+KBN+hNHnj0gmbmTyLnelPXccG7RZDSjFTEyXItw7VgqAFnSYvK+k1WUAspvjCM0Keo/Yewv8xVFK6UAn0unb30VrDDPmJxvy/PbLBtjAyfaHyuJK8fNC5souO6Hl6D8AgFSQNj8m6BDKIgWxv4TqaY28z6JJQl8k7PaXmORFLNCKkCqJJc6onUWf7UYGWl7hccyHYXbcOLRIJqtOYUmcGp8CifFuemur7EXlYAfD0s33ov3HH5R/pkLefp9Km0j/Ap5Cvmlr+h2qADkdWWrVdenQSwi2Fr+YaOHorQ9y6xXkfmBM5mjBuyfTDKAXp3dUWCt1py6BlLtleItC1+iOKOf4tDa8ueRNE8fFtmY2pRj8xDVIyzV5kaeBvN6kvC2HBwJbY1ePTSVj4FW2Yp/O/XQ49+uppDoEJNkwh1AQxVaY0s/61FJzRsnqt1xxO8FMLqqxzNhla955yeUQMYXQVtErjf0nyiz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(38100700002)(36756003)(7416002)(5660300002)(66946007)(8936002)(2616005)(6506007)(86362001)(66476007)(4001150100001)(8676002)(66556008)(4326008)(6512007)(41300700001)(26005)(186003)(2906002)(478600001)(54906003)(66899015)(6486002)(83380400001)(6916009)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?phgGFgHXAikTxmYVSV5qH+OvHTn8iDSt1Rfnn6Z6usTfngadE1xyI/HGD0cm?=
 =?us-ascii?Q?0zgB0da3TxLzr4A2yURAbdxc41fnZ1dFdMmXt1rRtlGM/4YuqSybeDPKUJFd?=
 =?us-ascii?Q?DXWJfwLSSeMYxBTNuLHl+746wipq6TzeOi32RMdjL/pXtfx/AfyxAvR9hTKG?=
 =?us-ascii?Q?C8zib9fcfyfhbCJnCk1cglnUIps2MwL1fMrBZ5Gsx6SgZSFGyGYij6ox1FA2?=
 =?us-ascii?Q?/+Ln7s1yWBBo5dYaMHy48PHpTiZG4ZyJ3i+fMdazFAZNL5Lea4oa7blrdHt6?=
 =?us-ascii?Q?RvODbuO3sqtnAzi6uFdmmYV10bcePFHRQnVGTLuXKDyiympD2IK3lKRWvmrV?=
 =?us-ascii?Q?iqGU/i4LoOSihAjiWEOsOt2ol4kaaomBcCQWNf0erulbnLnr6JjgW/6QUIIB?=
 =?us-ascii?Q?RrVWHcuBz432dq1tmbYi+oeIR4HPi1VeQeySKm0NiWnoOT1unvsfVk4v4byk?=
 =?us-ascii?Q?b+3oEZlH0Z0bsPj9Ad0JcBXyK6dXlAKFVC1JVSvwNN3olvhYACsEVVluk2Z8?=
 =?us-ascii?Q?mwvARGHp7pdwlJ1kV1VmG6U3PoiiK+r/X1uoW5W7LpbXiTm4dngmuY1AQsSf?=
 =?us-ascii?Q?35vUWN7QymmCMXve7Gix+yz0REb5Xso4FNYET/0fXLP+6H4p6wzaj3wk/jIe?=
 =?us-ascii?Q?ULLWmpPWUWxx0mqqXknLk49cmU9R7mr9YahMxo4YqBLh4im1IZsLydRDe/QU?=
 =?us-ascii?Q?fBIhmXLCzItKmVNy7psRbkdjTP6bfY7OSQeXLeULYWqJODDLrIuZmdfI0gEs?=
 =?us-ascii?Q?LvSuwcJZenChyxbutwKeMutjR8M16hGUbK8vifJfj5Yt4nSDw4BM9ERhVgH9?=
 =?us-ascii?Q?GaQ32PjOHWFp9lm7/rjVyQgf/fGz6lXX9DpoFP/TMph2WJR+Z0D5Gt5VhSbF?=
 =?us-ascii?Q?+594qrBSknBS7Vb9palA0RnRr0ueG7zBPKLEnzotb56CoWcWm/6oVhdXLB+6?=
 =?us-ascii?Q?VW60mO6l08/Z/0Q3pCjeibYJQu9NQjux/wl/xApmCSIgSCeM2fde8hs8YqkE?=
 =?us-ascii?Q?Wzc1rLeCgqBidtEDD7BpFhOQnsqDfgQA7/43mZ2OH2iCmTBqwtlaMLn4pS6H?=
 =?us-ascii?Q?jZYkhYTNZaF290Jmkca1fNeMuQ/iuqucipoQHGqnYpnY51S6/AUThekGfk9G?=
 =?us-ascii?Q?ImPVwPXzxLz0YXjqh/EAXZW6YQAI6s0XTf/I1tOL98ex+XPENK4Nh1c6TQxY?=
 =?us-ascii?Q?3axiB+80ndCxvbGd1ibhiUMtHfm1CO7b9F6TR1fVsCGnmfXQeScwlZO8wsg4?=
 =?us-ascii?Q?UMb6YfjaVLzPk3LT2fRi1+FlXhL2p7h4LD4Uq55RszJNNcy+gdNJfC7py+DE?=
 =?us-ascii?Q?/I9QyC30CpIlly+BGVrRbWdn0dRmZNah/hP6o3ABDkEe10MEm4juEGH+Hhr5?=
 =?us-ascii?Q?s9oWch/f7ZhpxeQJNY2KdM1K2AZzf37o457Jcvie1D9P40UbdivI5hqRelIu?=
 =?us-ascii?Q?ZqWtygGtT66TkRXG3TE4TxYGlqZXQkGvPRmYHVJ9sccI9n6UNctCItKhCuZW?=
 =?us-ascii?Q?9+va3HsENPV+AkeLZ1CEvoTyRiombFmQ6cKSPE3RXkmHXbrpJkcdYCDd9Xcm?=
 =?us-ascii?Q?Pju4R5iVm5Xchhb7gCs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f64f4b1-61e5-4dab-d04e-08dab369440b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 13:36:32.2471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2TVtWNjPrBmvb6Lk9OUBMb4BgKHvF4NOvvaB02Yit0I3IB7vwpm3qJjWXD7c88y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 02:08:02PM +0200, Niklas Schnelle wrote:
> On Thu, 2022-10-20 at 08:05 -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 20, 2022 at 10:51:10AM +0200, Niklas Schnelle wrote:
> > 
> > > Ok that makes sense thanks for the explanation. So yes my assessment is
> > > still that in this situation the IOTLB flush is architected to return
> > > an error that we can ignore. Not the most elegant I admit but at least
> > > it's simple. Alternatively I guess we could use call_rcu() to do the
> > > zpci_unregister_ioat() but I'm not sure how to then make sure that a
> > > subsequent zpci_register_ioat() only happens after that without adding
> > > too much more logic.
> > 
> > This won't work either as the domain could have been freed before the
> > call_rcu() happens, the domain needs to be detached synchronously
> > 
> > Jason
> 
> Yeah right, that is basically the same issue I was thinking of for a
> subsequent zpci_register_ioat(). What about the obvious one. Just call
> synchronize_rcu() before zpci_unregister_ioat()?

Ah, it can be done, but be prepared to wait >> 1s for synchronize_rcu
to complete in some cases.

What you have seems like it could be OK, just deal with the ugly racy
failure

Jason
