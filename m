Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9126361166D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJ1Pzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJ1Pzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:55:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F517C745;
        Fri, 28 Oct 2022 08:55:38 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SFi8n7021281;
        Fri, 28 Oct 2022 15:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VqsgxdMwkIPa9+iWKlPgBX7Z8ySLveUSiVZa0Y47KpI=;
 b=hgm+Xc1DmxQoEw2ghrdiGuriAPFGfbW+vR+KCmTIKvLEIYeIgnVqqrwl+s1x86pWVgCS
 xXOa8957el3hSLXX9kf2vbu+frCibM5SD2za64enDSCVg1d+O1p/G3dKzN+sS1YhxtPz
 mH6EVyQerGsRd+hh6w2pX/PU7hQdBhHhx0Ryc7v4jqmGYsIJgHLNGPkPPJGRuTOKsnIq
 Rj3JMRQZV+hg6GI7hxJ06hxinxAkgi0vkQ3qD+lqoFyqwZdFwIeH0SwTrFnEYqDff5qe
 SK0ohZXIchbN9W6uG6l+tv3Ad3snFYw+s8fQPK+4/O3uIzAYhAU32WwRMwl8VoIHbdaU QQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kghyxrcjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 15:55:15 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29SFoZLN030211;
        Fri, 28 Oct 2022 15:55:15 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3kfahhqje2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 15:55:15 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29SFtDer3080782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 15:55:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A0445805F;
        Fri, 28 Oct 2022 15:55:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4405158062;
        Fri, 28 Oct 2022 15:55:11 +0000 (GMT)
Received: from [9.160.93.208] (unknown [9.160.93.208])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 15:55:11 +0000 (GMT)
Message-ID: <d057e158-b6c1-884a-3002-e1292a317779@linux.ibm.com>
Date:   Fri, 28 Oct 2022 11:55:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/5] iommu/s390: Make attach succeed even if the device is
 in error state
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
 <20221018145132.998866-2-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20221018145132.998866-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m_629yHpJwRp4WCbiwrFYxPvmWSVJiSJ
X-Proofpoint-ORIG-GUID: m_629yHpJwRp4WCbiwrFYxPvmWSVJiSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 phishscore=0 mlxscore=0 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 10:51 AM, Niklas Schnelle wrote:
> If a zPCI device is in the error state while switching IOMMU domains
> zpci_register_ioat() will fail and we would end up with the device not
> attached to any domain. In this state since zdev->dma_table == NULL
> a reset via zpci_hot_reset_device() would wrongfully re-initialize the
> device for DMA API usage using zpci_dma_init_device(). As automatic
> recovery is currently disabled while attached to an IOMMU domain this
> only affects slot resets triggered through other means but will affect
> automatic recovery once we switch to using dma-iommu.
> 
> Additionally with that switch common code expects attaching to the
> default domain to always work so zpci_register_ioat() should only fail
> if there is no chance to recover anyway, e.g. if the device has been
> unplugged.
> 
> Improve the robustness of attach by specifically looking at the status
> returned by zpci_mod_fc() to determine if the device is unavailable and
> in this case simply ignore the error. Once the device is reset
> zpci_hot_reset_device() will then correctly set the domain's DMA
> translation tables.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Seems reasonable to me.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  arch/s390/include/asm/pci.h |  2 +-
>  arch/s390/kvm/pci.c         |  6 ++++--
>  arch/s390/pci/pci.c         | 11 ++++++-----
>  arch/s390/pci/pci_dma.c     |  3 ++-
>  drivers/iommu/s390-iommu.c  |  9 +++++++--
>  5 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 15f8714ca9b7..07361e2fd8c5 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -221,7 +221,7 @@ void zpci_device_reserved(struct zpci_dev *zdev);
>  bool zpci_is_device_configured(struct zpci_dev *zdev);
>  
>  int zpci_hot_reset_device(struct zpci_dev *zdev);
> -int zpci_register_ioat(struct zpci_dev *, u8, u64, u64, u64);
> +int zpci_register_ioat(struct zpci_dev *, u8, u64, u64, u64, u8 *);
>  int zpci_unregister_ioat(struct zpci_dev *, u8);
>  void zpci_remove_reserved_devices(void);
>  void zpci_update_fh(struct zpci_dev *zdev, u32 fh);
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index c50c1645c0ae..03964c0e1fdf 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -434,6 +434,7 @@ static void kvm_s390_pci_dev_release(struct zpci_dev *zdev)
>  static int kvm_s390_pci_register_kvm(void *opaque, struct kvm *kvm)
>  {
>  	struct zpci_dev *zdev = opaque;
> +	u8 status;
>  	int rc;
>  
>  	if (!zdev)
> @@ -486,7 +487,7 @@ static int kvm_s390_pci_register_kvm(void *opaque, struct kvm *kvm)
>  
>  	/* Re-register the IOMMU that was already created */
>  	rc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> -				virt_to_phys(zdev->dma_table));
> +				virt_to_phys(zdev->dma_table), &status);
>  	if (rc)
>  		goto clear_gisa;
>  
> @@ -516,6 +517,7 @@ static void kvm_s390_pci_unregister_kvm(void *opaque)
>  {
>  	struct zpci_dev *zdev = opaque;
>  	struct kvm *kvm;
> +	u8 status;
>  
>  	if (!zdev)
>  		return;
> @@ -554,7 +556,7 @@ static void kvm_s390_pci_unregister_kvm(void *opaque)
>  
>  	/* Re-register the IOMMU that was already created */
>  	zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> -			   virt_to_phys(zdev->dma_table));
> +			   virt_to_phys(zdev->dma_table), &status);
>  
>  out:
>  	spin_lock(&kvm->arch.kzdev_list_lock);
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 73cdc5539384..a703dcd94a68 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -116,20 +116,20 @@ EXPORT_SYMBOL_GPL(pci_proc_domain);
>  
>  /* Modify PCI: Register I/O address translation parameters */
>  int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
> -		       u64 base, u64 limit, u64 iota)
> +		       u64 base, u64 limit, u64 iota, u8 *status)
>  {
>  	u64 req = ZPCI_CREATE_REQ(zdev->fh, dmaas, ZPCI_MOD_FC_REG_IOAT);
>  	struct zpci_fib fib = {0};
> -	u8 cc, status;
> +	u8 cc;
>  
>  	WARN_ON_ONCE(iota & 0x3fff);
>  	fib.pba = base;
>  	fib.pal = limit;
>  	fib.iota = iota | ZPCI_IOTA_RTTO_FLAG;
>  	fib.gd = zdev->gisa;
> -	cc = zpci_mod_fc(req, &fib, &status);
> +	cc = zpci_mod_fc(req, &fib, status);
>  	if (cc)
> -		zpci_dbg(3, "reg ioat fid:%x, cc:%d, status:%d\n", zdev->fid, cc, status);
> +		zpci_dbg(3, "reg ioat fid:%x, cc:%d, status:%d\n", zdev->fid, cc, *status);
>  	return cc;
>  }
>  EXPORT_SYMBOL_GPL(zpci_register_ioat);
> @@ -764,6 +764,7 @@ EXPORT_SYMBOL_GPL(zpci_disable_device);
>   */
>  int zpci_hot_reset_device(struct zpci_dev *zdev)
>  {
> +	u8 status;
>  	int rc;
>  
>  	zpci_dbg(3, "rst fid:%x, fh:%x\n", zdev->fid, zdev->fh);
> @@ -787,7 +788,7 @@ int zpci_hot_reset_device(struct zpci_dev *zdev)
>  
>  	if (zdev->dma_table)
>  		rc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> -					virt_to_phys(zdev->dma_table));
> +					virt_to_phys(zdev->dma_table), &status);
>  	else
>  		rc = zpci_dma_init_device(zdev);
>  	if (rc) {
> diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
> index 227cf0a62800..dee825ee7305 100644
> --- a/arch/s390/pci/pci_dma.c
> +++ b/arch/s390/pci/pci_dma.c
> @@ -547,6 +547,7 @@ static void s390_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>  	
>  int zpci_dma_init_device(struct zpci_dev *zdev)
>  {
> +	u8 status;
>  	int rc;
>  
>  	/*
> @@ -598,7 +599,7 @@ int zpci_dma_init_device(struct zpci_dev *zdev)
>  
>  	}
>  	if (zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> -			       virt_to_phys(zdev->dma_table))) {
> +			       virt_to_phys(zdev->dma_table), &status)) {
>  		rc = -EIO;
>  		goto free_bitmap;
>  	}
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 6c407b61b25a..ee88e717254b 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -98,6 +98,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  	struct s390_domain *s390_domain = to_s390_domain(domain);
>  	struct zpci_dev *zdev = to_zpci_dev(dev);
>  	unsigned long flags;
> +	u8 status;
>  	int cc;
>  
>  	if (!zdev)
> @@ -113,8 +114,12 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  		zpci_dma_exit_device(zdev);
>  
>  	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> -				virt_to_phys(s390_domain->dma_table));
> -	if (cc)
> +				virt_to_phys(s390_domain->dma_table), &status);
> +	/*
> +	 * If the device is undergoing error recovery the reset code
> +	 * will re-establish the new domain.
> +	 */
> +	if (cc && status != ZPCI_PCI_ST_FUNC_NOT_AVAIL)
>  		return -EIO;
>  	zdev->dma_table = s390_domain->dma_table;
>  

