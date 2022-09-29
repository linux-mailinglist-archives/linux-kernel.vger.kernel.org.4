Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609F65EF9D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiI2QKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbiI2QKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:10:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C073D93511;
        Thu, 29 Sep 2022 09:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGA6KNT/ea4JhHGzfp50/GKb/Nt4XoCUAvVhfqrtRJbKK0HnkBwE1dX7ou8a6blckegMXVpLH2Kp0kt53mmCDThi6fnncnLCHvV1KmhEc+lYX21nHeWYyLZt4NgxMPR/fjz+BklWuHrNZx4vctr6X0AD1J0wOJdtEUE8wQVdx/iZKesIsrD/56T7FHtKzwsWIUJqsrEW1poE2wohniXx9WpDOjc/jupZrNaiD9kcbUMi1VGGMhIwooZAGgKK/tG8GVFSQlcti5XXY9RBPlAwutWQgN2GfRAMt52VEwH3s/0b5b+pGVPMQjyQfxIF1AqnMpfXJtIKc1+F2eYAbDQrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLAz4wcvNHroNsSu9lPavbMJHlgE6f4UlHmV7Nu1dTU=;
 b=YexOt2AHVehITIToUK+J+UJZwKDOSSkL+mDb6CPOuNCKxVjHlGB/bLxsJ3+qw5uObqNyw+Oz4h9+JShHtUGC7NNHPivk3Pe8jPyLvCQIymIiHC8O4bAunJJDxmvrr8VqNvL0Qt4dSfYRyt6x2ywWEkGmvVIMSx0CuE0IEKHROydV9VsTAXUySxTIpMO9NLlJyqQS07MpDvqXsab0swCaigOYis4ACzJlfd9L2BeU8g7CH72zen8TaFJcpslY0ZsFLm9/d1ozPtdJvwvGs7tj+wOP3qRUeuvc2SfyHY6jhEPtTff3npczXUr0yLPq08TGh1lO01SM0j4rh73hFugwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLAz4wcvNHroNsSu9lPavbMJHlgE6f4UlHmV7Nu1dTU=;
 b=YA3hPPa/Ky/stSKCgAVCtW8Zw+U6lRgWpsTjLGLeEO+cxj81K97DgQOFn52FU06Qxo852Cc3H1/ZolivAsrhRE7OQrZQ1+1YAa4nGFgm+shNEdYNkyADLPKr42BlpAajqDAZe67xbJuyg7oymB7m93arOBKfQYdFdvx7Wti1rpG0XcziAv0y1Jf+dTJiGAlL9H2G+M8f4tCrL/J1JhTGTb4l4HGd0cpX+32YzLBBh3ftTIua9z3lhNzu0dw19tkmesq6z0kdeVco3CJvQXb7vSLvlQ56gZF+C5uerR0jwWuCWSywGpqyqDVhBFs0GlvoVoyg/D80VduE4gTfAwmp9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Thu, 29 Sep
 2022 16:10:08 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c%5]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 16:10:07 +0000
Date:   Thu, 29 Sep 2022 13:10:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iommu/s390: Fix duplicate domain attachments
Message-ID: <YzXDXocEarCgJDSn@nvidia.com>
References: <20220929153302.3195115-1-schnelle@linux.ibm.com>
 <20220929153302.3195115-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929153302.3195115-2-schnelle@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0355.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 46bc6158-79dc-4f60-5337-08daa2351366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJYV4J2Z1yR53wpEopEpS+BdeXP3+r089hCzbfYBJOORtJKvYAk0Nir1r57U2EwATksXuOdcaCSsPQg6TgB1hW+eIPilIhRfJ8Qagh2JOrimgyHyKsX2LnMskrFSDKHg3hyLQNl7wqnVlNcvhfSE+yZTTGvj8a1piNSrGwpRJQl3PULONK9ojhx1TrbSGNfGkQVEvVtQnJ6KNe0ESNl4vBeYwEHH53GRw9AfOZlJAg6KFfcDSrRLF6T2SCJMORvvLvyEIWOlqHE2MYva1/jGhrvU5d/XeTCif6IRFX8e+AG+PNbBqCMDtSJt3wom0HNrf3lwEicgD18xZkkXQjus6Nf/uYIDJKaR9in/6rhCd9muUKbtSjzG5AEE2S2YiTJJD8Mj6Eq3/mm8x+DAoKZea18pApNhDzysaz0FPPOWmLTEVot/pl8GULFvlSzmwV8JCWpsYSgfdVN/oJ/95FEaVqEG/+ow6AxY73ODZtHkMoUb0S0lPj6F6cK9pK8z0yzl4MFMx8WGCOiCqGF/DrbbP93bMxUzIdo7PIFycCM/+JZDlEgLprn7nRK0555R8vOAQj9U+WpVUQ/YdOb4U03nfo6q7VDMGhUhZ5bJ/fVbcxePl4IAwgKQY+qSGE/mGjJbP87HXzljGbFqhSnaxXrbWVCla0X1Kjj2AI11Cvi5tMrM6IACzrVk57VAk5xk1hVj2C7eYQs9oqtVHtsb24gxrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(38100700002)(86362001)(4326008)(66476007)(66556008)(54906003)(8676002)(186003)(41300700001)(6916009)(2616005)(2906002)(316002)(8936002)(66946007)(7416002)(5660300002)(6512007)(36756003)(6486002)(26005)(83380400001)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zPxD4QT5wfxnEWhkhQs4RmHte4Ds1o3rBfbJvPwvVArOL0ebXK0fPHrIFbHe?=
 =?us-ascii?Q?RXr1TLvENlsO/trOlhBykSJRc2TwdkWicmRoaH0b1SReCcB8MfQ2eRmtrWJ0?=
 =?us-ascii?Q?M3bJpUc7Htzk1NBtGVB0jdl8QJk97q7kDquHaRobUEGOg1kcG42me2i7tOF8?=
 =?us-ascii?Q?CEcRdxYsR6Hr+B23ajEjNkeHUJqAr9Je/eXXVsbEHf8ICWyMlcdmjlM8G7s4?=
 =?us-ascii?Q?LG+vomYot7ivIJHIcBiEdH049qBSnsCIVfrRzTe+33AwQ9PIhxoFauBtpMU+?=
 =?us-ascii?Q?oEBZOTBiyF6hXZ2TKPCxYanjH8qmQPX4UKNX7ZRfwC49zobXyBcfML5B0OOO?=
 =?us-ascii?Q?IfQWf8CzEL1V5RJ5YpYox4xVtM+epx7wbJTBa2dUpyHjpgr9Qva7PpbA2z2k?=
 =?us-ascii?Q?tcRjLht2nCvM670k1MsJ2elSgmlAfOKKYEBPEGtroE1/qKPjexlraDtr2ZHY?=
 =?us-ascii?Q?+b1cCvw9/qERfiShThRsOZUn22fAUSgwkrI4LoHVLX5Lk/Egl13qdhNtDgDp?=
 =?us-ascii?Q?8LfJD5l7tq4ectck8m4BvY1Jw/6AkmilDuvuToiuS++E6KOMUkrolFVlsDgi?=
 =?us-ascii?Q?e44/EAdNkpJh/oUp5fYUtIRjGk7IJrbrbwjeb6UT1/4CN5v4mZn9eNFMPp+h?=
 =?us-ascii?Q?FfW0oKKNfUnQ0651R/qKU8cQz9ND7MQR2W6zvrzf5IxEOG+u4yxgRH1hIww/?=
 =?us-ascii?Q?s/vGfnHAanNxcDalcSPOVRHVcCHdMF9xCrdQ/rGu+tR1b70u/TWr32Ky9ixB?=
 =?us-ascii?Q?qS77jbLaOcwbHud2pU45HF3E7XmqGBNDdpP0uKzgiuShELkEmJCO3zIpgX0Y?=
 =?us-ascii?Q?gyVGJF+6WaeXee7vWK4yypUNn4oDIbV3/1D3CuFhfXJ8ae8Q/WtFqE12lrX8?=
 =?us-ascii?Q?v3KT8GPS1gLBdXoLT/XJFVDwz2PEoExL0LlyTtAZUK5JF/sfsJe3dELgkngy?=
 =?us-ascii?Q?QDkFhIbqDeVKz29C1MgYsSFWotx52l84DIfgyqPOVnvLZNM4oeufLavYG4Wl?=
 =?us-ascii?Q?bVjp1ITWk/slepAng3xWyvoLHUEnhVvUjIXSXRbI/iRHoQpSSYWuE5J0aK1A?=
 =?us-ascii?Q?QVzCUybRuo+A+USeNSGuFWRfbQoRvCz80NXLAAwrbCrXL2b471Yt7fAmE8JA?=
 =?us-ascii?Q?Dxp3zYOWC6P45OX15GY5JG7rKLZzkyWa32nd5PxtI5WWT1R0kk/vsxjEOUcj?=
 =?us-ascii?Q?JCqKpMPOsh3aa7Xfc+AIZgki4aDnB/6gzvU4AUpXVkPIwBevgUtEeFYCVbR3?=
 =?us-ascii?Q?47LIR0i81644AbSeaRZt/DLblRm6YLa3fzGMAfY2nvHF/ay9FiB56qTpA/xa?=
 =?us-ascii?Q?97wpL5Us6VZ/QE2n7osiDBZcKfsBjOeX/5EMfGXmlS+kxM89pJz/rRDkQnPL?=
 =?us-ascii?Q?NTTSXCrqyX/ojV30J4z5mUPmF1O8BzsGjLTi6/pAWn3Gm65nv3E9PU4FABNW?=
 =?us-ascii?Q?CIY1MLIohf5uE/W7lUmZUCDAEvNbALzIjBU/CZGkee9h6oLvVu3a3nhv3J+u?=
 =?us-ascii?Q?8ErhIZaQbnO40uYlxSJT8HiBCY2T4tJr4qXQxF6et5hAbaNwzuO3GYA5KTyK?=
 =?us-ascii?Q?Wc4crrwBaml/GtSTEdw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bc6158-79dc-4f60-5337-08daa2351366
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 16:10:07.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwsnHvJMCVeoVjUSgvDO1qZDDVfYma7oeKyvkK0lw809ZwsTfFLDD8lvRYbPERaC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 05:32:58PM +0200, Niklas Schnelle wrote:
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
> ---
> Changes since v2:
> - Make __s390_iommu_detach_device() return void (Jason)
> - Remove superfluous locking when we're freeing anyway (Jason)
> - Remove the re-attach on failure dance as it is unlikely to help
>   and complicates debug and recovery (Jason)
> - Ignore attempts to detach from domain that the device is no longer
>   attached to.
> 
>  drivers/iommu/s390-iommu.c | 77 +++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index c898bcbbce11..6fcb64e4b5e6 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -79,10 +79,36 @@ static void s390_domain_free(struct iommu_domain *domain)
>  {
>  	struct s390_domain *s390_domain = to_s390_domain(domain);
>  
> +	WARN_ON(!list_empty(&s390_domain->devices));
>  	dma_cleanup_tables(s390_domain->dma_table);
>  	kfree(s390_domain);
>  }
>  
> +static void __s390_iommu_detach_device(struct s390_domain *s390_domain,
> +				       struct zpci_dev *zdev)
> +{
> +	struct s390_domain_device *domain_device, *tmp;
> +	unsigned long flags;
> +
> +	if (!zdev || zdev->s390_domain != s390_domain)

Please drop the s390_domain from this function, it is pointless..

Calling detach_device with a mismatched domain argument is a WARN_ON
offense, the correct recovery is still to remove the domain.

And zdev can already never be null due to the call chain

Also, s390_iommu_release_device() should call this new function since
we don't want to return back to the platform DMA when releasing.

So, like this:

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 2bad24d6cfef59..e8333a9301ec95 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -75,12 +75,12 @@ static void s390_domain_free(struct iommu_domain *domain)
 	kfree(s390_domain);
 }
 
-static void __s390_iommu_detach_device(struct s390_domain *s390_domain,
-				       struct zpci_dev *zdev)
+static void __s390_iommu_detach_device(struct zpci_dev *zdev)
 {
+	struct s390_domain *s390_domain = zdev->s390_domain;
 	unsigned long flags;
 
-	if (!zdev || zdev->s390_domain != s390_domain)
+	if (!s390_domain)
 		return;
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
@@ -108,7 +108,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 		return -EINVAL;
 
 	if (zdev->s390_domain)
-		__s390_iommu_detach_device(zdev->s390_domain, zdev);
+		__s390_iommu_detach_device(zdev);
 	else if (zdev->dma_table)
 		zpci_dma_exit_device(zdev);
 
@@ -130,10 +130,11 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 static void s390_iommu_detach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
-	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 
-	__s390_iommu_detach_device(s390_domain, zdev);
+	WARN_ON(zdev->s390_domain != to_s390_domain(domain));
+
+	__s390_iommu_detach_device(zdev);
 	zpci_dma_init_device(zdev);
 }
 
@@ -174,21 +175,11 @@ static void s390_iommu_release_device(struct device *dev)
 	struct iommu_domain *domain;
 
 	/*
-	 * This is a workaround for a scenario where the IOMMU API common code
-	 * "forgets" to call the detach_dev callback: After binding a device
-	 * to vfio-pci and completing the VFIO_SET_IOMMU ioctl (which triggers
-	 * the attach_dev), removing the device via
-	 * "echo 1 > /sys/bus/pci/devices/.../remove" won't trigger detach_dev,
-	 * only release_device will be called via the BUS_NOTIFY_REMOVED_DEVICE
-	 * notifier.
-	 *
-	 * So let's call detach_dev from here if it hasn't been called before.
+	 * release_device is expected to detach any domain currently attached
+	 * to the device, but keep it attached to other devices in the group.
 	 */
-	if (zdev && zdev->s390_domain) {
-		domain = iommu_get_domain_for_dev(dev);
-		if (domain)
-			s390_iommu_detach_device(domain, dev);
-	}
+	if (zdev)
+		__s390_iommu_detach_device(zdev);
 }
 
 static int s390_iommu_update_trans(struct s390_domain *s390_domain,
