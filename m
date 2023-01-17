Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB4366E1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjAQPJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjAQPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:09:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D1F3FF32;
        Tue, 17 Jan 2023 07:09:31 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HDVuOO032412;
        Tue, 17 Jan 2023 15:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EIbj3wLxTFJd1qTVNpbyFlVRke2y8l8BaCHddVopCdQ=;
 b=UL1ZIPFJJ9egHphdweC8N0T51g3kMQdTTm2JwbCukx1RH/OzZ/zkWFdqdQKbxGpUF5o8
 rV/PdNjUYaAd/5whW5J6s/WRMfIqT86hozmjiE38uTdhTSOODP0CcVZy/gttoCn3LyNX
 dGM9A1evymdJwrG6DTKU/F3IRio23LCMrlQYbFf86xJZ6MBNpmIQYLaNSZMR8UN5OrMe
 mls07KnPQgZzG0JB0cWDg9lx3kOHZ3UkqMm73AtpDTmq5QQlXiSBTwG+LAbhRvFNHngX
 bqbuxJOxJef/GtzpHkBexG2lRK4wbJeuSguAHJXeZn77hNbUDL5zJI5mUTEKur27P81c nw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5egnvpt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 15:09:18 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HEtA1f005665;
        Tue, 17 Jan 2023 15:09:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3n3m17dwrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 15:09:17 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30HF9FkG59900220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 15:09:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5FFB58059;
        Tue, 17 Jan 2023 15:09:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3549658058;
        Tue, 17 Jan 2023 15:09:14 +0000 (GMT)
Received: from [9.160.180.199] (unknown [9.160.180.199])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jan 2023 15:09:14 +0000 (GMT)
Message-ID: <71b9e85d-960f-7403-0113-135746127f3b@linux.ibm.com>
Date:   Tue, 17 Jan 2023 10:09:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 4/7] s390/pci: Use dma-iommu layer
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
References: <20230104120543.308933-1-schnelle@linux.ibm.com>
 <20230104120543.308933-5-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230104120543.308933-5-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ktKUf8aJ46_K8vbDf3JISy_lCmFa9ZYG
X-Proofpoint-ORIG-GUID: ktKUf8aJ46_K8vbDf3JISy_lCmFa9ZYG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxlogscore=849 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301170122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 7:05 AM, Niklas Schnelle wrote:
> While s390 already has a standard IOMMU driver and previous changes have
> added I/O TLB flushing operations this driver is currently only used for
> user-space PCI access such as vfio-pci. For the DMA API s390 instead
> utilizes its own implementation in arch/s390/pci/pci_dma.c which drives
> the same hardware and shares some code but requires a complex and
> fragile hand over between DMA API and IOMMU API use of a device and
> despite code sharing still leads to significant duplication and
> maintenance effort. Let's utilize the common code DMAP API
> implementation from drivers/iommu/dma-iommu.c instead allowing us to
> get rid of arch/s390/pci/pci_dma.c.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index ef38b1514c77..6b0fe8761509 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -124,7 +124,11 @@ int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
>  
>  	WARN_ON_ONCE(iota & 0x3fff);
>  	fib.pba = base;
> -	fib.pal = limit;
> +	/* Work around off by one in ISM virt device */
> +	if (zdev->pft == 0x5 && limit > base)

Nit: maybe a named #define for the ISM pft rather than hard-coding 0x5 here

[...]

> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index 6a8da1b742ae..b15ad15999f8 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -49,11 +49,6 @@ static int zpci_bus_prepare_device(struct zpci_dev *zdev)
>  		rc = zpci_enable_device(zdev);
>  		if (rc)
>  			return rc;
> -		rc = zpci_dma_init_device(zdev);
> -		if (rc) {
> -			zpci_disable_device(zdev);
> -			return rc;
> -		}
>  	}
>  
>  	if (!zdev->has_resources) {
> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> index ca6bd98eec13..60cec57a3907 100644
> --- a/arch/s390/pci/pci_debug.c
> +++ b/arch/s390/pci/pci_debug.c
> @@ -53,9 +53,12 @@ static char *pci_fmt3_names[] = {
>  };
>  
>  static char *pci_sw_names[] = {
> -	"Allocated pages",
> +/* TODO "Allocated pages", */

? Forgot to finish this?

>  	"Mapped pages",
>  	"Unmapped pages",
> +	"Global RPCITs",
> +	"Sync Map RPCITs",
> +	"Sync RPCITs",
>  };

[...]

> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 4dfa557270f4..73144ea0adfc 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -14,16 +14,300 @@

> -static void __s390_iommu_detach_device(struct zpci_dev *zdev)
> +static void s390_iommu_detach_device(struct iommu_domain *domain,
> +				     struct device *dev)
>  {
> -	struct s390_domain *s390_domain = zdev->s390_domain;
> +	struct s390_domain *s390_domain = to_s390_domain(domain);
> +	struct zpci_dev *zdev = to_zpci_dev(dev);
>  	unsigned long flags;
>  
> +	WARN_ON(zdev->s390_domain != to_s390_domain(domain));
>  	if (!s390_domain)
>  		return;
>  
> @@ -120,9 +412,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  		return -EINVAL;
>  
>  	if (zdev->s390_domain)
> -		__s390_iommu_detach_device(zdev);
> -	else if (zdev->dma_table)
> -		zpci_dma_exit_device(zdev);
> +		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
>  
>  	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
>  				virt_to_phys(s390_domain->dma_table), &status);
> @@ -144,17 +434,6 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  	return 0;
>  }
>  
> -static void s390_iommu_detach_device(struct iommu_domain *domain,
> -				     struct device *dev)
> -{
> -	struct zpci_dev *zdev = to_zpci_dev(dev);
> -
> -	WARN_ON(zdev->s390_domain != to_s390_domain(domain));
> -
> -	__s390_iommu_detach_device(zdev);
> -	zpci_dma_init_device(zdev);
> -}
> ->  static void s390_iommu_get_resv_regions(struct device *dev,
>  					struct list_head *list)
>  {
> @@ -207,7 +486,7 @@ static void s390_iommu_release_device(struct device *dev)
>  	 * to the device, but keep it attached to other devices in the group.
>  	 */
>  	if (zdev)
> -		__s390_iommu_detach_device(zdev);
> +		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
>  }
>  
Looks good overall, but I think these hits above collide with Baolu's series that recently went into -next:

https://lore.kernel.org/linux-iommu/20230110025408.667767-1-baolu.lu@linux.intel.com/


