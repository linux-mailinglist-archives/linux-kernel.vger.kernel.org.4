Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF47865B685
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjABSTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjABSTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:19:00 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05AE55BB;
        Mon,  2 Jan 2023 10:18:59 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302HgSIQ017358;
        Mon, 2 Jan 2023 18:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2z05DTzHOpLFw6IuTCQkPT7RUluh0jzgEGXbXpVeEEs=;
 b=SvtOu2MSlCcEkdjwLX0Y3gir3Ej+8A76ygY8ENxIiQ0dpnaCfRqJEBYAwglz8jqveQ/K
 vQDfgnUQ/pKWlStRh3dMPDzWJWPepyd8ARCnZ9ZV9VonW/n3mzCi2MDFPMdLHQXUWq8A
 nh4Z/ZV5DRiw0k4D0YzTTtSmhR2m8/7w4wL0sbYT4GAJgEkmz7wtdLz8uU9UWFqJyAVo
 GD78Q3eMfK+2tkOizaN1rUw4v98QJytv3S7U3ptmtNQsOTMfqYWvEP0Jxsbnhx/Uq9zy
 BEIrrkk0MZIyQ5cuq6gAiHk+YtYJBooK9Ug5tvuJV7J/3v5gdqVkTfST8zlGuLB9IIL0 FQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mv3w40fxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 18:18:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 302AnnS8001864;
        Mon, 2 Jan 2023 18:18:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mtcbfarru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 18:18:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 302IIMpS39256432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 18:18:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1115820043;
        Mon,  2 Jan 2023 18:18:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 182FC20040;
        Mon,  2 Jan 2023 18:18:21 +0000 (GMT)
Received: from [9.179.24.9] (unknown [9.179.24.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jan 2023 18:18:21 +0000 (GMT)
Message-ID: <c735459b-ba25-d1e5-b20f-4205fab67060@linux.ibm.com>
Date:   Mon, 2 Jan 2023 19:18:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/7] s390/ism: Set DMA coherent mask
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
 <20230102115619.2088685-2-schnelle@linux.ibm.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20230102115619.2088685-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Oh-ja7qq8HR7pI-VfiU-hLrZ5Id4osJl
X-Proofpoint-ORIG-GUID: Oh-ja7qq8HR7pI-VfiU-hLrZ5Id4osJl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_11,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=932
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020162
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.01.23 12:56, Niklas Schnelle wrote:
> A future change will convert the DMA API implementation from the
> architecture specific arch/s390/pci/pci_dma.c to using the common code
> drivers/iommu/dma-iommu.c which the utilizes the same IOMMU hardware
> through the s390-iommu driver. Unlike the s390 specific DMA API this
> requires devices to correctly call set the coherent mask to be allowed
			^^^correctly set ^^^	
> to use IOVAs >2^32 in dma_alloc_coherent(). This was however not done
> for ISM devices. ISM requires such addresses since currently the DMA
> aperture for PCI devices starts at 2^32 and all calls to
> dma_alloc_coherent() would thus fail.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> v1 -> v2:
> - Use dma_set_mask_and_coherent() (Christoph Hellwig)
> 
>  drivers/s390/net/ism_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index dfd401d9e362..aba03b613296 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -557,7 +557,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (ret)
>  		goto err_disable;
>  
> -	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  	if (ret)
>  		goto err_resource;
>  

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
