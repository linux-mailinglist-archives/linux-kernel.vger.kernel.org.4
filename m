Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E2560FA0B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbiJ0ODz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiJ0ODr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:03:47 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E55C1870B0;
        Thu, 27 Oct 2022 07:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hu0Hozp6l6+RyzUMPKzOI3l+pXKCFffWXcl3LoO0PWKws83LN4zxBrgmkANimyhN5exGP/HxwxKropg6w9izfQjgzsonuYG/URjsfuF/Oqdufsf130lTGHhgM17vQymCId3gJYcoP6MnuHYc7S00lDs4Md1+qKCdrCRVdaoegTQC4jP9WZLnL/0bWhbi9V9YYvOoBNJ9Y0V95+0TrmeFRdEA9+na+Fp+EuiNdaB5/5wAzxi6jqaMC8HpfSwkboxr1O17qO7LL/t/AqKe2i+SdWQXxpNR1cwCK87tZA4A9LvlqyLzOg46W6IZCWyyhYdqkLZf/N8NiuPB2GyBjtaOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+uUfk8OoXDfRa00uFeKtRKWtx0gPK/pNMB5zV+JsBw=;
 b=Wa/jRlG2vKVnaMnI63EK6JcnzEDn4Jkp1dg5ImixjbgwOEcAXVeFSdDwEtoim3OeJFItGOaYPvPPKO5SPxhNCEb5GmNW3jdC6twbpfcuwQnye7WqI26g1jNpsFCpmPC5mp0gTgpS+IfeXsKZmjEqE4mIFXWoXVUqqUiffE0QH8k0yyb/6s1EYEly03YMXMHnrIJHdUT+DuIiB3n2D8erAiaADDph+2cdWidfXIc/MnTttLaSPSjjGsnwI661cKydoNmeImMZ4YS7r3inLg/0u1Gjzu/sunlQVlySS8l6P1uP4YX/rJMF8WUJ3jbLfDyQNPyU4kWxKzE1EDSm314pNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+uUfk8OoXDfRa00uFeKtRKWtx0gPK/pNMB5zV+JsBw=;
 b=ZEmvUUmiOoZJOzvIFxUtzkD86sd6nG2mCL3GCe71VPPKvDr9QfYc3bqd+xBFY+Q3pYlDfU4EtvP4zitVG7MdfIDpwDAHRo1lns6xeyT5Dn8L4j1QaKJN7Zg00XA4WNbcZ5/+88Rrhny8UwdHgVpn493SvkI6c5FWHE9HCQONl48DbtcFEiMeZld6Q+DZ6dHRrw2f8KUQ0oIPZ64xLkeYIHKlfHK+HCdmwwGQFZXmwehBx3pwoVnyr7koQkIcI71UbWUqOlG8tbX2ntEmsF2OfCzgGbHqeNr1FngIgQn6UzmAr5NgkHii7epxwV7rdzDr1de7zDiOUT/oIsnId9G9bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 14:03:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 14:03:43 +0000
Date:   Thu, 27 Oct 2022 11:03:42 -0300
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
Message-ID: <Y1qPvg+g6EEaayF6@nvidia.com>
References: <Y1ErcEe82yjJI+ET@nvidia.com>
 <68d91d7a5aadbd46dc34470eccd6b86a84c9e47b.camel@linux.ibm.com>
 <Y1KgX8EwH8T+FgWC@nvidia.com>
 <89a748fb5caee8be5d91806aa5dfd131e92d5d82.camel@linux.ibm.com>
 <Y1K1AqVWEyY0/Uqy@nvidia.com>
 <cef734b9f9b33380c1bbff40b56bb67b3de29341.camel@linux.ibm.com>
 <Y1a8qM4c2ZAM9glJ@nvidia.com>
 <3c2249fc7abf481b15d4988c2bd6456c48154c44.camel@linux.ibm.com>
 <Y1p/7YS338ghykGz@nvidia.com>
 <c98fa11d4efa86ca676a9d164893db8af8ab3693.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98fa11d4efa86ca676a9d164893db8af8ab3693.camel@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:208:2be::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 973947d8-d104-44d1-a4ce-08dab8240e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuV8rJmsoyZpkrsPM6ifxkefuZPgOQMvFUDyJlhYr48+LKWrjfPD8GfrF5HfVQ+HvSUD+tO4Sh7tzomw9nZoRy/haHZaxQZEsQ58+4pG6X/p8HsX3GOfzkXdIEsyfVL7TfSiNwtlYXKkQFnWG3+EU47Nc4PQS5DlLSLHgCeSWTAA6Zpzbs0RB8HLvhe4Og6LwmR6WYfvzjX/isZYCAmPLLeEbSGqHSosfTA8mICKnvH8/roudrASrwFaZ55dVZ1Eh4CWHEh4FfXHH6+ZcugRxrZ8Hyq/4atqKwUVgH77TSed1MF7/ErFrVAl3DE4dpXGezA57mKrwpLM7Ofd51sBGvA8vRjG4jkv8HZU6zokuLAnoAh2CWYyS75rQ9RPmgPh4xn9fzkQvuSbvb53VwD4XelBe7Yqvmr7/TVKQVGmas2PkBJ+Hi1Bt5Qv/x3nQiBcwFGbD90On+hvXOzyG9pU4md681LMZXBn5uQyIqmWGRB6wuncI6SX6diaZHv22mdpltUrJqtlhbGQiLF0eU+Kib1tsUAYd7Bw0n9DYW+pBlWyOoTRfxWMJdqcwUVVa14nOWblFpAS5Yz95dVMz7keTzVnEJyHdgAjLJWe+paD3CbDLjXezNKJLTb7OV3tlONvP5+QA2XQ5ej4FxPUXlCrnUnXLXWfOLsB49WzCIB1f9o9tYrbL+C+E00dIg5rBrBeoYUD5aUNVEguFgohckAr3zTAkxcOKzfLkd0bGwT7iL8TcZcRn7YBe8m1R8QLo2W9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199015)(6486002)(478600001)(6512007)(86362001)(6916009)(83380400001)(316002)(38100700002)(54906003)(8676002)(66556008)(4326008)(66946007)(2906002)(36756003)(6506007)(66476007)(26005)(41300700001)(7416002)(2616005)(8936002)(186003)(5660300002)(4001150100001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RTL09ZOtvt1JifpY7IpS7qll7mtg+vy0Y7VP1SR3xD/xOU+6xl+8S53K1ssR?=
 =?us-ascii?Q?Zz1OG6fCszWflCZVCG/zSg6louKLEqjBcRy0SJF/WGr5oQAP1WrHqBp9rnKh?=
 =?us-ascii?Q?q0piVTyeOuly8u5BMmK3MVGili5YDkG8OYd5zyx2BfO99wIhDEUwPqQMoYZj?=
 =?us-ascii?Q?qptZdsTlYlOrlMIvI/E2o67Ywb3aBZQD1KSryv2sjEiU4VL6ZT+HkdEnVssU?=
 =?us-ascii?Q?t2OXUMPxrR9450B4IyxsQh40RBdJLrLsrQv61fhO7MnmqmapagEBoI0Rfw9q?=
 =?us-ascii?Q?6pJR9HRHq6pMI7cVQiw8qVQLlacSstus5OSex7uxWkmexbd0BiGPHux24YgF?=
 =?us-ascii?Q?42sKrxRXdJZg9dcP4Dtry61A//EsktNo2+AFVM8+44jrC0oziNLV+/9v9SOr?=
 =?us-ascii?Q?yi4irMbcWyzFmPnwVOeqi1S58lrZt1pvcRx93hL5hOaY3l0ZZxynxGJO1e5g?=
 =?us-ascii?Q?QqOaIuo1HVN53rlevSQjDIlDpxGSYwSm61qny43RcCDKu1gc8HhvWpLzRyU1?=
 =?us-ascii?Q?s6/5bjuyE/Y+7ywil90Gf+OSzDSnu71lms2ow463Og2CPUqqGhg6K5zjfU3T?=
 =?us-ascii?Q?SfBRVjLWBV6kHM8B/5R2xaF5Ch9j/EnDFTa9YW91rc+JiC6yIzGMnPMT9ho4?=
 =?us-ascii?Q?4kTBi5mUDf3lRKoY+6CE6wKJHOsQqQvxu1iOjNDSe6DPkoSL80Iorm5RBpC3?=
 =?us-ascii?Q?wawp1V6ajd1U64yYTuNvb0/+OiCnMKBJRbQ2i7x2nsBSBQhmE9BSbqQxG8Ec?=
 =?us-ascii?Q?Tam0+i+v7CNb2J2hXoJBozYVhSlYHBMQhin7KA1JsxHS5u2ixsJDoXAFmoV1?=
 =?us-ascii?Q?27EJ1xda+5YPBWiEz6zd8Mf2KjagMPIExFzgVRbCO5HbR5qYxjR9h6bfbeXa?=
 =?us-ascii?Q?gLcBV+dnALSfv9m1b+8x68G+2QbVEoGYN9Cs/vjVLHA3GdstoXn69QUgHR49?=
 =?us-ascii?Q?uvDPhFy9QiEZnnsaCVODvaT9QLoQoPTSBiDACevcH0uekP2FTL1yCP7EJwIz?=
 =?us-ascii?Q?hjFgvsQYDYLddD2SmlHhIejuN2xbjucvAq3AAW2cOyTGmB4qM8ASpZ+sijfy?=
 =?us-ascii?Q?Y9ToyJIhv0zL4yLSw5y8tFRAPCX2UTqnNESapX6LJNxvm6kdoIm+PyIS+ZoN?=
 =?us-ascii?Q?jOqnXLKzHgsgi++QrwdSzvGmb8wwSWk/SKpq+PDAQ8e/HfmCqIOqYJGWHUT8?=
 =?us-ascii?Q?DmB6oJo+/KZ5KlT+lyDFX+hiIGSOJxmsRmHPFipmNowUlt8R4amZ/Plb1dSf?=
 =?us-ascii?Q?mzHuJH4bzmlFTkER3Fi/Xda9kS/ee4QtSkMVTj39jZF6F6tsFjzE96kZ50hE?=
 =?us-ascii?Q?slJgaMZQ3R05AiZnEuO6aL8kDvt0HrWOUOEaoABAkymk9kTur/P8xjbqMYeQ?=
 =?us-ascii?Q?OseRO7UarZbvf0dGL9LBGcuFrs2xiOHcSQDBfq9zwRNUmxe6nvXCRli82yVB?=
 =?us-ascii?Q?sXnrbjNzSczzHZR0ue5tRNhON19WVj9GLfiMrC7o91Kp8ohWsbLiXQp4/Jea?=
 =?us-ascii?Q?9t377ZDh6Azm3EMIGHJfofNDiQLV/XfY1WNKsRje+wC/3BBeZesCAf8qGsDa?=
 =?us-ascii?Q?ArVzRPUWFQvlzY1K7WM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973947d8-d104-44d1-a4ce-08dab8240e81
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 14:03:42.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oJxaQcYyYPRFgMotwB2LV9R8EZ0T7NzjhMheyvPGDe4zrXfXR4KRFr2HUXo89qC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 03:35:57PM +0200, Niklas Schnelle wrote:
> On Thu, 2022-10-27 at 09:56 -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 27, 2022 at 02:44:49PM +0200, Niklas Schnelle wrote:
> > > On Mon, 2022-10-24 at 13:26 -0300, Jason Gunthorpe wrote:
> > > > On Mon, Oct 24, 2022 at 05:22:24PM +0200, Niklas Schnelle wrote:
> > > > 
> > > > > Thanks for the explanation, still would like to grok this a bit more if
> > > > > you don't mind. If I do read things correctly synchronize_rcu() should
> > > > > run in the conext of the VFIO ioctl in this case and shouldn't block
> > > > > anything else in the kernel, correct? At least that's how I understand
> > > > > the synchronize_rcu() comments and the fact that e.g.
> > > > > net/vmw_vsock/virtio_transport.c:virtio_vsock_remove() also does a
> > > > > synchronize_rcu() and can be triggered from user-space too.
> > > > 
> > > > Yes, but I wouldn't look in the kernel to understand if things are OK
> > > >  
> > > > > So we're
> > > > > more worried about user-space getting slowed down rather than a Denial-
> > > > > of-Service against other kernel tasks.
> > > > 
> > > > Yes, functionally it is OK, but for something like vfio with vIOMMU
> > > > you could be looking at several domains that have to be detached
> > > > sequentially and with grace periods > 1s you can reach multiple
> > > > seconds to complete something like a close() system call. Generally it
> > > > should be weighed carefully
> > > > 
> > > > Jason
> > > 
> > > Thanks for the detailed explanation. Then let's not put a
> > > synchronize_rcu() in detach, as I said as long as the I/O translation
> > > tables are there an IOTLB flush after zpci_unregister_ioat() should
> > > result in an ignorable error. That said, I think if we don't have the
> > > synchronize_rcu() in detach we need it in s390_domain_free() before
> > > freeing the I/O translation tables.
> > 
> > Yes, it would be appropriate to free those using one of the rcu
> > free'rs, (eg kfree_rcu) not synchronize_rcu()
> > 
> > Jason
> 
> They are allocated via kmem_cache_alloc() from caches shared by all
> IOMMU's so can't use kfree_rcu() directly. Also we're only freeing the
> entire I/O translation table of one IOMMU at once after it is not used
> anymore. Before that it is only grown. So I think synchronize_rcu() is
> the obvious and simple choice since we only need one grace period.

It has the same issue as doing it for the other reason, adding
synchronize_rcu() to the domain free path is undesirable.

The best thing is to do as kfree_rcu() does now, basically:

rcu_head = kzalloc(rcu_head, GFP_NOWAIT, GFP_NOWARN)
if (!rcu_head)
   synchronize_rcu()
else
   call_rcu(rcu_head)

And then call kmem_cache_free() from the rcu callback

But this is getting very complicated, you might be better to refcount
the domain itself and acquire the refcount under RCU. This turns the
locking problem into a per-domain-object lock instead of a global lock
which is usually good enough and simpler to understand.

Jason
