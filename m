Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDED65B692
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjABS0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjABSZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:25:57 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25360C8;
        Mon,  2 Jan 2023 10:25:55 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302IIprG022715;
        Mon, 2 Jan 2023 18:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xyRjw0Wo2CFFlkXuVTCQ/L+itXir78Z0mpr1AfKePgI=;
 b=sufAtXimIAEFNLzc/5eha0sn19ZL+xovWPFUWo+KXy1LC4eARpfyEothkhg4xW79+uHc
 6ng0VzqIl1wSbJdVQDAim9VJqqXj4H+rxJ35roW1d65j6c6LHMZDmGx5V235hUfUz2px
 jLd2ODwMIzXh5wGzpMAT8jXySlmN6xUd/AkELfH9kUATQuMstYdb14hxSPeYUo0lfuS3
 4BJpujcq4YKsiTircEdBWu2QvxaOzmALP17QO1QfHmmkZqymg77aM2+PRjvsMI2yu4Mh
 5PCGhU5Mx1jm6uLinrFF+bP5CK1yF0EUn8DAE/34rMEqQcaQwm2/bUVjK8Ic5i5w9F1w GQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mv44u88bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 18:25:29 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 302GHPNb021827;
        Mon, 2 Jan 2023 18:25:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6as7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 18:25:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 302IPOpR47448336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 18:25:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3992C20043;
        Mon,  2 Jan 2023 18:25:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F3F720040;
        Mon,  2 Jan 2023 18:25:23 +0000 (GMT)
Received: from [9.179.24.9] (unknown [9.179.24.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jan 2023 18:25:23 +0000 (GMT)
Message-ID: <2f1beb15-e9e4-d8ab-1b68-c83f1a53c5c5@linux.ibm.com>
Date:   Mon, 2 Jan 2023 19:25:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/7] iommu: Allow .iotlb_sync_map to fail and handle
 s390's -ENOMEM return
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
References: <20230102115619.2088685-1-schnelle@linux.ibm.com>
 <20230102115619.2088685-3-schnelle@linux.ibm.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20230102115619.2088685-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tZGRnBv8dcmi0mWG7BD-VJl5yDQrg3lA
X-Proofpoint-GUID: tZGRnBv8dcmi0mWG7BD-VJl5yDQrg3lA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_11,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301020159
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.01.23 12:56, Niklas Schnelle wrote:
> On s390 .iotlb_sync_map is used to sync mappings to an underlying
> hypervisor by letting the hypervisor inspect the synced IOVA range and
> updating its shadow table. This however means that it can fail as the
> hypervisor may run out of resources. This can be due to the hypervisor
> being unable to pin guest pages, due to a limit on concurrently mapped
> addresses such as vfio_iommu_type1.dma_entry_limit or other resources.
> Either way such a failure to sync a mapping should result in
> a DMA_MAPPING_EROR.
> 
> Now especially when running with batched IOTLB flushes for unmap it may
> be that some IOVAs have already been invalidated but not yet synced via
> .iotlb_sync_map. Thus if the hypervisor indicates running out of
> resources, first do a global flush allowing the hypervisor to free
> resources associated with these mappings and only if that also fails
> report this error to callers.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
Just a small typo, I noticed
[...]
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index ed33c6cce083..6ba38b4f5b37 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -210,6 +210,14 @@ static void s390_iommu_release_device(struct device *dev)
>  		__s390_iommu_detach_device(zdev);
>  }
>  
> +
> +static int zpci_refresh_all(struct zpci_dev *zdev)
> +{
> +	return zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
> +				  zdev->end_dma - zdev->start_dma + 1);
> +
> +}
> +
>  static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
>  {
>  	struct s390_domain *s390_domain = to_s390_domain(domain);
> @@ -217,8 +225,7 @@ static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
> -		zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
> -				   zdev->end_dma - zdev->start_dma + 1);
> +		zpci_refresh_all(zdev);
>  	}
>  	rcu_read_unlock();
>  }
> @@ -242,20 +249,32 @@ static void s390_iommu_iotlb_sync(struct iommu_domain *domain,
>  	rcu_read_unlock();
>  }
>  
> -static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
> +static int s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
>  				      unsigned long iova, size_t size)
>  {
>  	struct s390_domain *s390_domain = to_s390_domain(domain);
>  	struct zpci_dev *zdev;
> +	int ret = 0;
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
>  		if (!zdev->tlb_refresh)
>  			continue;
> -		zpci_refresh_trans((u64)zdev->fh << 32,
> -				   iova, size);
> +		ret = zpci_refresh_trans((u64)zdev->fh << 32,
> +					 iova, size);
> +		/*
> +		 * let the hypervisor disover invalidated entries
			typo: s/disover/discover/g
> +		 * allowing it to free IOVAs and unpin pages
> +		 */
> +		if (ret == -ENOMEM) {
> +			ret = zpci_refresh_all(zdev);
> +			if (ret)
> +				break;
> +		}
>  	}
>  	rcu_read_unlock();
> +
> +	return ret;
>  }
>  
>  static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
[...]
