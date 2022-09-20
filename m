Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1B85BE8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiITOXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiITOWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:22:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97263FA26;
        Tue, 20 Sep 2022 07:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cx/I5jq9U2PJT7Zf7qgXTIpxlpolc0CIs4OztQfwi1x4gvymU66ruIrWvgfEAtBMTTtTjggIVpckpeJvy8AM6OeW7WVaNRjkIcxknezp3rb7H4o2UgLFjSIVECDBL9Z9vMhzUQRlru8PjmccJmRvXysrYTsP5CkWPYr5F4iPNGNi7e1iBz3ilvQfmArWj+/jI+8hXKZ/NHMkAhU0Wx4CSDGWdHqNX7Cq1CSTCtKCLcnNAYTp4hOUXYWQJd/zTLhPLfKaj2gY8Xov70gmbJGT/CZBYBMeC+jUjg1l7MJIa3qp4Eg41OYjFTXI6M7KLNPxyd5QplIVMencAPkXOPZacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oomuqB4KyMOz394cwOVv+YbzFSfrhk6g2tmcnfVscE=;
 b=kCevEI4IQGPd+UKSKTmKmCCinmqPK/YLcbta8WcgCe6FJOTYjKp8+TH5i9dN2bC2VgGU90W5OIqUrEkihrLwE50cUb84B30nH1IUre0JQjd+ED+nb4AKsyl1zwKTzzDI/igmf8rf5Zv5CL4a0//NHq6sDEGQuWafZd0yzjpZEyQJlSaA5jKREZTv6Zv4utofj+yaitQhenCNZVRgXj5iVuPwpTdKBOiIabkw1dfb277wkpCCGy3FjS6t3/Qpc1BRUihO7hEQoBLanVmgSa88/c11bPdc6loK/LEYf8+aDjLVQyiQGieD0IiNr6VfIVh0qEzR58kMMYE7a7gjRQ7eCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oomuqB4KyMOz394cwOVv+YbzFSfrhk6g2tmcnfVscE=;
 b=fhIYGGsp0dKtJZ6a5fKP5HtUjk7/R4YOCOJJUG4LXD7llMGtTkATDxFYQcdybDP2sDF1dTVVNrvjVAF3ZhRtyWOxXydUgLZxn2GYcgMV7XxjJ/d8BIQ1zChFS+5GrbK5TPzpghgNLF0o/Qh0e5VH+ETp+jH9t+RB4Y2HP43LG2NHrI1NK4p30XBL1oXK88l82sRjOm1JDswntfwyU3T5tdcOM3j5MrSR/0NNvvZpeWlADFpNRgDhSh4RnADVxINirynruBGyUQICn//Lwr8heKuqZw7V7aYR6GGdGO9I9LUMptbe7l/EP05v1AxUcrWLkJCAzrh6xc+1ydLZhfmWag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 14:21:06 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 14:21:06 +0000
Date:   Tue, 20 Sep 2022 11:21:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iommu/s390: Fix duplicate domain attachments
Message-ID: <YynMUNCrGCzaFPjI@nvidia.com>
References: <20220915151402.121032-1-schnelle@linux.ibm.com>
 <20220915151402.121032-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915151402.121032-2-schnelle@linux.ibm.com>
X-ClientProxiedBy: MN2PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:208:e8::43) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b578a73-747b-4529-2029-08da9b135aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnnBtgT0V3sxck7+GhCT783vCCNndy4RC+lO3RaS3mh6VmIoviq1Q1/vDqLWqqegw/dvFDn7n/NsUk2R2VoRuXKDhsHihYVOiqngDuXjAPvv6GWrJ+Fa4rUpa25sSpZrG4RkUDbee99QrcsseX5LvBDOmzS7JuINnktnMekw2Be6VWsCI5S6njySlq0BuEAyWZulVaL4fr7ed4V5ZcnIaUZn5OqJ9ICmohWHl2PzpbmHwZ5GZaDnylnURrJeDRT/AZlTiE1008TyzGHU4RcODbjKBvU4cc4TIeK+yBhJ0oVcRTSQQkkD4FhWbE9L0JuahLG32biAHmN15NUczYYhP0Hp+b6hB2/XXwotgBRcHjJjt9gsPmUir8lF1FhKOcNlNxCG2nV1JI011MvoqAFNpJwXSnSrTiumydkuGb+HX4C5QV5wB90xFmEGTshO0Iwf4wWs1H9DKTSS/+5I3aUmJanV4VitaOYRvYUkZdyqJiwldb3vyHdmIBPDukfEcJbDh8nvyKPPQ+Z6NX/p9CmT7a9a9mEHaH70QKzh27GIaSttn2R+8ued3aI9cGhtpwNiPHNBneHjZHBiTuKCJQPhyITV8GpsvAe0o2N2k+MGR1aAo+dhbX/+uy6NMWpyma0AkIGFtF/KxeHPj4Zo9bh0VzNOtXhCiwo7Gf+feTaPIw2UNIihf+9ycfB8nv116jxYfjsr5fGDfBGUEPbzQoD/Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(2906002)(38100700002)(5660300002)(8936002)(7416002)(6916009)(36756003)(66476007)(66946007)(66556008)(8676002)(4326008)(86362001)(316002)(186003)(478600001)(2616005)(54906003)(6512007)(26005)(83380400001)(41300700001)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o4QYi2jFG6Z7MrF7Ok0uHoYApsF6FEiGRklzBjEeELzpdxrPQRd+RzYlzF5j?=
 =?us-ascii?Q?XH1S2BKzEq/Nb9Mb4kw8ObhLx31XE5QvfOfeNPqxG+tlAbQ7f27y/Ut71Hhc?=
 =?us-ascii?Q?auCJMBTDQPXNmvpAg9YjG8xTKY2cNK1SYpFwm+PKLivCzdmGzqGNbzVwImyV?=
 =?us-ascii?Q?2Lpwv1PVdPLAY6xjZrSLmusKr6EKkH+ZTmICgHcSJirq3anjWfaGV9PPghHP?=
 =?us-ascii?Q?Aok4zX0cw0W/7k0fb89zm04/rbC2Jn/Ed0GiP48F5bwPxs/zM8Nkf81JBqqj?=
 =?us-ascii?Q?EHsvnM9yIn5LfEYStlTW+6746555aSEoO3/BbjsahzM6CNWkihsj946KfoWG?=
 =?us-ascii?Q?aqJhw3T4VewRIIez7QsR4Xj2QP3yVexiiZyNX9ybenunnus2gL4wzwlQtd1e?=
 =?us-ascii?Q?wkh9+p6om8wn8q9CRj7TxlgEgdGalQLllEkdTYzL5oNznvTR1kzPNIwzU7Nt?=
 =?us-ascii?Q?/GAu2btjvvLnlQBhswfWbv4YPDZVLiWNnKkQg6gR7v8HlRw61e19j5IejR79?=
 =?us-ascii?Q?jJoUfTZLHMf/WnVmruzPQnG/uYJRvmXS4KA4XnDW5pPYv3SDXW4nYZDdC+2t?=
 =?us-ascii?Q?5ziPinkiY33okk2Ll6grVMMNSGOPh2Sa3mijOksF/fo08Y4jMpZ2d8mkhknx?=
 =?us-ascii?Q?coZ1vvoumtsoHQ5BzDQq2vD2sYFjOO96gQnh9A2Q6YM+dbJoV8w6Yw8LfpuG?=
 =?us-ascii?Q?kiXQciXAXlcipC6Acj3Oz9w+S06ly9KavtNcsftaiSO9AOXmU13R9dO4dQgu?=
 =?us-ascii?Q?7xvx04cOEgq5uQiSoLd4u9ouWoXIfoHJDQmKqOrvfNxQXhkojmgIDuKy2/2k?=
 =?us-ascii?Q?g03NXiBP+ij3UDWWPhi+BQ6gFUWc4iGaPBB/Xdnij7Gpbk45s59suV/1KIyn?=
 =?us-ascii?Q?MdDSRXydQRY/7ZzWTJxCTeeZec3Y4WpY8R7zplFQRf+EPjpgRFktC7IfVpkP?=
 =?us-ascii?Q?hQgM/Ebp85rW38m9e8rynUP4RDSHIkvoNnXo02GAlSS+Owq2Ce2dBCyQjDkt?=
 =?us-ascii?Q?HBDjIg5IKdyBhwSuKN+A9TG07uwteARwkXF7xG9ud/+PvWLuxRCq5qotsJNb?=
 =?us-ascii?Q?rwaoS8XlGg5bsNHZNHj7v7VfIyQbw3u3qhUV5WN/6+6g3+Ht4FnyRCAly42R?=
 =?us-ascii?Q?Zof+7CTeDFmky5rYqyn0B9sfHic7Y1vmqjTBTT8lUEFmdGXQMgnFjn/Vn4Zq?=
 =?us-ascii?Q?H+KadUDX+vn/FB50Cp//QmOqOmBWlbAcXlGhG5R9CBt2jk6quzQtYv6A3BHX?=
 =?us-ascii?Q?4rh3I/5iXgbnRr2hWObRLMHq750KxG46QFdXT84aCJJxMSaOtYKfutAHg7pp?=
 =?us-ascii?Q?58faGvy3Y2aWdQQl3MP3BaF1yuF98gFJBGg1NxqPZ6Kvyzp1XNkQV5GCTIGf?=
 =?us-ascii?Q?36rW9AwNo5vgUO9VSKeJONLyZE9Sim0zceGDOapP2+UJRDSkD4nbgf9udhnr?=
 =?us-ascii?Q?5wrolavIRRBrr3Vah58jjkqjvUn+ljvzD2tx+G+vIt7T95GpkcTLM8E8D51M?=
 =?us-ascii?Q?lcVVTnbTerfDPzPde9eRUmlQ8fhHaHYEzPvUbJGnOXpUkdPcS3DFDQcirs0Q?=
 =?us-ascii?Q?lvdZViG/4UHtGNQS2LkTdgY4iitOdREsu52zACZV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b578a73-747b-4529-2029-08da9b135aec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 14:21:05.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIHC2H5YBU+anTKE2AH0J+ECXcxtL/YMrcCyLp6mSL3fCm0UByWijvdyOpcKmXaP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 05:14:00PM +0200, Niklas Schnelle wrote:
> Since commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> calls") we can end up with duplicates in the list of devices attached to
> a domain. This is inefficient and confusing since only one domain can
> actually be in control of the IOMMU translations for a device. Fix this
> by detaching the device from the previous domain, if any, on attach.
> This also makes the restore behavior analogous between IOMMU and DMA API
> control.
> 
> Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 82 ++++++++++++++++++++++----------------
>  1 file changed, 47 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index c898bcbbce11..de8f76775240 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -83,14 +83,41 @@ static void s390_domain_free(struct iommu_domain *domain)
>  	kfree(s390_domain);
>  }
>  
> +static bool __s390_iommu_detach_device(struct s390_domain *s390_domain,
> +				     struct zpci_dev *zdev)
> +{
> +	struct s390_domain_device *domain_device, *tmp;
> +	unsigned long flags;
> +	bool found = false;
> +
> +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> +	list_for_each_entry_safe(domain_device, tmp, &s390_domain->devices,
> +				 list) {
> +		if (domain_device->zdev == zdev) {

Why all this searching? The domain argument is only being provided to
help drivers find their data structures, in most cases I would expect
it to be mostly unused.

After patch 3 the struct is gone, so isn't this just

 spin_lock_irqsave(&s390_domain->list_lock, flags);
 list_del_init(&zdev->iommu_list)
 spin_unlock_irqsave(&s390_domain->list_lock, flags);

?

Jason
