Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246B05E65BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiIVOd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIVOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:33:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F428F6861;
        Thu, 22 Sep 2022 07:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTPntmyFpsBN/pyWAL8ndowAXpB0wotVJcpE7KL1mkPEArKhqZyoEbWaja2VeIIK6b5KRArvpmbkkueE+lfTmTXiMf9KQKA9vwGAxTOL/vEhrfCL+j60Vp6FG7zJx/9edXBEsvE7S3pQZdaujB/l6AYGZZZuJIf80g7vrHf1C5BdQwXxmG2X/iXObfoLiuewEnREa5lzNzjL0RN5oEzOSDdE2X/TXE+ij2r8lrmDZkF2besdCvRISGL95wGI/mRV0hxRgYAUpXerbcLB3j5TMgBm9z4qCnLRolOjWSVjnJkE7q4mfTTnLi3sWQZazKsbzlgdd1Hqgv/4UXLecXGM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyIozbPkd9TwZAQfn3jxwZQtN3iwYF3S523+UJcNPNo=;
 b=ay7ig2cBpGJGlQRjkOuhnrMaqKYVmoDdi4Sm8sy9LWw1g02zk2MJQ7Z5WIpewxveZgiHwt6qb+rrksDgb7QKUnMhKnqS9TmngJn2p0k9wlQdLed/CBkpSk2S5ZuYX0e17qfDZvCTb3NIIWo/+pVdIaUomIWPrgbaf6bX6lQZYRr9jNT0Ysmm11RSJUvWFgsAAD8JO30uajpye+AYpMduTkqAqC7/RF8ht+bCScLXWzUQRo1TJjtsqJLJqzyibceP6ho2TyV1yzEijQCGmOoeW5apRse1it6UhDmCvR+zc94DEkW54LWeGB1asi/OArRK+pLRSayFZSxt+aFhQ2ILNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyIozbPkd9TwZAQfn3jxwZQtN3iwYF3S523+UJcNPNo=;
 b=UN052K4IWkAbUj6T34H2Onn/5JIzkvPEvwxaj4jhTJYHE+pfq/8/tYhlJxqG12O8g6bFaOPrxWuZz7Omm3ppGtsuAAfZHzZ0BUNnZjxvgOWx04HKPYO2qFOvXBGRbTTzTBq9lSf/qqQWZQh0mLtK3Hd/h7RCiW/DqEoQX3csAV8PG8cQsOlFLHZg7dFb6KkoUCWIO3nV+45AB9bHvrQIiDk3YXUufBiDaPZMibEJrkZCmuFwJt5wJVYPyVfhsWMAnRVxnWQBLvOLgVfdnWBmNWButbVhmsURxcqN9rZsQaKo8ACAh+hYUUXM6PBiJCoGeWDIrJg/6OMnbVREuOV5Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 14:33:23 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 14:33:22 +0000
Date:   Thu, 22 Sep 2022 11:33:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommu/s390: Fix duplicate domain attachments
Message-ID: <YyxyMtKXyvgHt3Kp@nvidia.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
 <20220922095239.2115309-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922095239.2115309-2-schnelle@linux.ibm.com>
X-ClientProxiedBy: BL0PR0102CA0016.prod.exchangelabs.com
 (2603:10b6:207:18::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: b66c4488-ad33-40e6-8b52-08da9ca766ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9o/kwDEqkr8kuQ1oW62HNpV2tsOQRr56GOaYtxZX5YnH1OfKgYcisJqdtyqIn2fMFbvt8Z6rPqnPb1u9zT/qMu9ivEiwTgs1KNmN0HRA72C6AZ2b8zzrOSnspoKwqb28wUZ+oUpFK/LvbLRP3f17SJuw06/lcKtFwIVQYprwmbGZts+/JrKwSJDc4e3jUdXZd5vV5L2D2VRkuYxlCOvqtGzN1/o+F8Kt0aJrEdHQ0US2aEJv3PLI11afVTpRcXCSIkThapkweLRrD20NUxlFP76JlWsSnaplsuWBdkpNtpf55Yr8CjmlgcjizDTKjwqvsXQGQMzL/8sMbd9hQPqUj+2o76YTCKy2hYzvlUSMOJfSmEpd/kVy5cJwdmFSMphvX7IXuWZmTUMAizsjFAt73CHQzh2iIvL8nS4HbSMblY5UnrOdvoVov+zV3rlJNP4adXeEb+1lgy/xq1QuzwwXX5n0VVeoTYzFR82QIriw7LgQ6Z57otORpSaEjGPPgWGTOjSGGIYoA2WO53XxX+psLXAFg7//dT60fSiqYvpmGp4tUSixiVwGMwtftT2EGJRui4P93wMzU1cEKIQH4EcmR42+7EzDAV19aNCnbdbsLvT9cQ7RutgIaOmnXsf7kVQw1uQHCB3zALOch3aUhYoixA7kbu7oayOv4XDqs13Cq0pzbnO+BBmvxa8QD+ctJswN8sRxotJmz+6lcA1Zwjydw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(36756003)(66946007)(83380400001)(4326008)(66556008)(2906002)(66476007)(7416002)(5660300002)(86362001)(38100700002)(8936002)(66899012)(478600001)(6486002)(2616005)(186003)(8676002)(54906003)(6916009)(41300700001)(26005)(6512007)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TynLlrR46+MzMUkyzCPdL51OpdybAZQA1D5oyOediYCRac/qxSoBGk2d6HWq?=
 =?us-ascii?Q?vit8zu6zXFvFOYNe8muM7FdGTQTGXK3o6IR97E++hNVGRemWxPbcdqmIr5t8?=
 =?us-ascii?Q?14HXttUtEwfU0FJX5Tq4HVkPycTBa6dMXZTaNbrARES/YwMyQzmXOJcML8sP?=
 =?us-ascii?Q?y1CHiUoDGWJvKnjhC69nND/QWL+N3VDYWkCt4IiB/TMvgZhz9HE01Kmg1/CE?=
 =?us-ascii?Q?XcUVsPFyQueRcp4CfKb2A7dOJ6xAK6r4OD1v9T8CqRxIfNPUbe5eCt9Nwij8?=
 =?us-ascii?Q?yGoYJ4Wpu/p5FJQDsNCCL5WJC8xZapVQGY9YTFejnjv8YRkSz0ObbSJ7Gy0o?=
 =?us-ascii?Q?9yCN26eoPTU4+Ur01clc8iCHCX/nhJB0BL03xf97WTyiXEpwB+B9jOma8qFW?=
 =?us-ascii?Q?I+jmkNk4tJ/1si0PIc2E/mvjc0owp1t5c8mLhP2hGcn5u8P9tcA81RmOSqop?=
 =?us-ascii?Q?9e6xoaWMtOKt2xx4sjCYPpEQLcygLUROyXg19VVr0l9EHCCtgxe9TODtSD72?=
 =?us-ascii?Q?HWiubJlYZP4D0rGjgB9AiGUhqNguBKMqyngSxi5wkMamj4V0qGTbEQs7dIxi?=
 =?us-ascii?Q?J0ebcLyjVssWWQJXp2STWhcHgb44UBoBEoXs2CcGllVY7zXT3/tO4bEHckfE?=
 =?us-ascii?Q?l4P5e/yj0TOuGpE26GPxZ1uQaOuDPi3+1Odq3mFZrcAugz6uiQK5o/hPtD6z?=
 =?us-ascii?Q?vGbdxKGBFyCTt4h9Dh8NpNIxEA1gimuCbxZ5mRjfleUxJ/O4Yyc8kLV+vANx?=
 =?us-ascii?Q?+n7GbxtNMgldfDzafHb0u0B5XF/sntVegUAwbdobdfuhaoB0sOwJ8fzPDy3F?=
 =?us-ascii?Q?SOkpYBxNQyCfrWjmRc9J2CbC+IhZ6bhtHCNL2ljGs1losjegfuXYAnDNoPWu?=
 =?us-ascii?Q?x28VvvLW6G5Z9fxsJJRoR7OoCig0MJk9bvHB4GCSWr0GrGjlnIHxdS72FdGO?=
 =?us-ascii?Q?06+nH7LSSxSOY/NGETY1dJlAVmTEOuAILNcDBOeoA5X95RoLRCd7EIfquNL1?=
 =?us-ascii?Q?cAsXN+2NuWiNvVFL9AvYZAxYlaCaaVS77fyrBG/1Z4zsVPwVp896EMm1Ai2S?=
 =?us-ascii?Q?ncYFD281I7/8nmpAqRjpLSB5mmXZSfaih5H7qNm9n+cPpfFFeY/tbjLS22cB?=
 =?us-ascii?Q?htnwzMXPlmF5FIBje+14LfM1v9U5gNkhgwf2Ynw+PH/Zs9m5jAuIZ5Qe1vR9?=
 =?us-ascii?Q?1JkqBzD5vpWPlzQp/peMD6iK+9nOXBM+t4fxLGr5WdzT8VMRJTkqrw5crgJq?=
 =?us-ascii?Q?czAkdbJI1I2HLHaXsQF2DyrNxEPoTMFzAaAON+1Wyc4XpGBbPc2T5WtH+54E?=
 =?us-ascii?Q?H2h5X3xUl5o+vg6C8Kjf5iwpIltAf++EJw+AZ8BjhFIvIEbhw9qwzNe5xGbu?=
 =?us-ascii?Q?ufpqiHP3DwLnf4NuWayqxDfWwPw5LI/yW0DJZFUyfpWRYJ2t4Kr946xBQcYg?=
 =?us-ascii?Q?0SHAM+hp8hK2qG+fF7U0DfkEcdmL8ec5mnhTxnROPahUGyaFmT6YP/1/SMYO?=
 =?us-ascii?Q?bd2P4Q5G3bdCbE4yXma5TsY6DVlyWb9xUKGKgpWdBsIWfA5gfIjBw+8PDZfl?=
 =?us-ascii?Q?CVbGV+wJXPcT+Rgsi5HLpVK0w5S5w/mgfxNOF6kB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66c4488-ad33-40e6-8b52-08da9ca766ff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 14:33:22.9091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6G3CuXz446wTImafAvoMFyKnE7cj887EEefLE+oXQrZTBN7v2GzInhX08sPEOLG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 11:52:37AM +0200, Niklas Schnelle wrote:
> Since commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> calls") we can end up with duplicates in the list of devices attached to
> a domain. This is inefficient and confusing since only one domain can
> actually be in control of the IOMMU translations for a device. Fix this
> by detaching the device from the previous domain, if any, on attach.
> Add a WARN_ON() in case we still have attached devices on freeing the
> domain.
> 
> Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Changes since v1:
> - WARN_ON() non-empty list in s390_domain_free()
> - Drop the found flag and instead WARN_ON() if we're detaching
>   from a domain that isn't the active domain for the device
> 
>  drivers/iommu/s390-iommu.c | 81 ++++++++++++++++++++++----------------
>  1 file changed, 46 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index c898bcbbce11..187d2c7ba9ff 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -78,19 +78,48 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
>  static void s390_domain_free(struct iommu_domain *domain)
>  {
>  	struct s390_domain *s390_domain = to_s390_domain(domain);
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> +	WARN_ON(!list_empty(&s390_domain->devices));
> +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);

Minor, but, this is about to free the memory holding the lock, we
don't need to take it to do the WARN_ON.. list_empty() is already
lockless safe.

> static int __s390_iommu_detach_device(struct s390_domain *s390_domain,
>                                      struct zpci_dev *zdev)
> {

This doesn't return a failure code anymore, make it void

>  static int s390_iommu_attach_device(struct iommu_domain *domain,
>  				    struct device *dev)
>  {
>  	struct s390_domain *s390_domain = to_s390_domain(domain);
>  	struct zpci_dev *zdev = to_zpci_dev(dev);
>  	struct s390_domain_device *domain_device;
> +	struct s390_domain *prev_domain = NULL;
>  	unsigned long flags;
> -	int cc, rc;
> +	int cc, rc = 0;
>  
>  	if (!zdev)
>  		return -ENODEV;
> @@ -99,16 +128,15 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  	if (!domain_device)
>  		return -ENOMEM;
>  
> -	if (zdev->dma_table && !zdev->s390_domain) {
> -		cc = zpci_dma_exit_device(zdev);
> -		if (cc) {
> +	if (zdev->s390_domain) {
> +		prev_domain = zdev->s390_domain;
> +		rc = __s390_iommu_detach_device(zdev->s390_domain, zdev);
> +	} else if (zdev->dma_table) {
> +		if (zpci_dma_exit_device(zdev))
>  			rc = -EIO;
> -			goto out_free;
> -		}
>  	}
> -
> -	if (zdev->s390_domain)
> -		zpci_unregister_ioat(zdev, 0);
> +	if (rc)
> +		goto out_free;
>  
>  	zdev->dma_table = s390_domain->dma_table;
>  	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> @@ -129,7 +157,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  		   domain->geometry.aperture_end != zdev->end_dma) {
>  		rc = -EINVAL;
>  		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> -		goto out_restore;
> +		goto out_unregister_restore;
>  	}
>  	domain_device->zdev = zdev;
>  	zdev->s390_domain = s390_domain;
> @@ -138,14 +166,15 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  
>  	return 0;
>  
> +out_unregister_restore:
> +	zpci_unregister_ioat(zdev, 0);
>  out_restore:
> -	if (!zdev->s390_domain) {
> +	zdev->dma_table = NULL;
> +	if (prev_domain)
> +		s390_iommu_attach_device(&prev_domain->domain,
> +					 dev);

Huh. That is a surprising thing

I think this function needs some re-ordering to avoid this condition

The checks for aperture should be earlier, and they are not quite
right. The aperture is only allowed to grow. If it starts out as 0 and
then is set to something valid on first attach, a later attach cannot
then shrink it. There could already be mappings in the domain under
the now invalidated aperture and no caller is prepared to deal with
this.

That leaves the only error case as zpci_register_ioat() - which seems
like it is the actual "attach" operation. Since
__s390_iommu_detach_device() is just internal accounting (and can't
fail) it should be moved after

So the logic order should be

1) Attempt to widen the aperture, if this fails the domain is
   incompatible bail immediately

2) zpci_register_ioat() to make the new domain current in the HW
 
3) fixup the internal records to record the now current domain (eg 
   __s390_iommu_detach_device)

And some similar changing to the non-domain path..

No sketchy error unwind attempting to re-attach a domain..

Jason
