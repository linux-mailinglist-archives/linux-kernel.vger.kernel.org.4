Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9360F62837C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiKNPFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbiKNPFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:05:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F6EC76F;
        Mon, 14 Nov 2022 07:05:36 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEEUWf9029835;
        Mon, 14 Nov 2022 15:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+zyGdkQWdcyIjzp89HFMXe6CybXo50kxaaLaVakCuI0=;
 b=Sv6UiOOJxVYJOu+m8/owsBZs7YFY78HiXnfADCWy5sRPgzrZPkUxlC+lu84W3VbO0kiA
 SSR4b9kzrAzldMX1L0aMYayhSI0u/MeAgw3WjgzsmkLIB9LPCS2tubud1xztcrRW0fsL
 MNrNafVv//cV35xPKVmOvIcb/jEmOAUS5Sw1STaEDH0J2yBLkRMbDDiBEhoPwn7CTXwX
 xL28L9GFyWrarUtuK7P3bd1lLxHirEb5sYGNba/e/bz/3mJGdfsIY/ECLbcrjZSsen24
 4dx9kr5FwnVFIQDM93+URcR4dmNnrhc3yPRxY6bG/d/AxbbUlibtHIk2FfcIqBg7uQ3o hw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kuqghgyyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 15:05:24 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEEpkPE020586;
        Mon, 14 Nov 2022 15:05:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3kt348tr59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 15:05:21 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AEF5I5C721446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 15:05:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1F3F52050;
        Mon, 14 Nov 2022 15:05:17 +0000 (GMT)
Received: from dilbert4 (unknown [9.171.35.254])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4079952052;
        Mon, 14 Nov 2022 15:05:17 +0000 (GMT)
Message-ID: <ac2dcfd820fafd19bab1c910c57044e28951b226.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/5] iommu/s390: Make attach succeed even if the
 device is in error state
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Date:   Mon, 14 Nov 2022 16:05:16 +0100
In-Reply-To: <20221109142903.4080275-2-schnelle@linux.ibm.com>
References: <20221109142903.4080275-1-schnelle@linux.ibm.com>
         <20221109142903.4080275-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xJfY_mkfbpynnxDzAnVw4AvibllUb-N6
X-Proofpoint-ORIG-GUID: xJfY_mkfbpynnxDzAnVw4AvibllUb-N6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxlogscore=538 lowpriorityscore=0 clxscore=1011 mlxscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

really just a nit...

On Wed, 2022-11-09 at 15:28 +0100, Niklas Schnelle wrote:
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 7fb512bece9a..e2c886bc4376 100644
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
Operator precedence does "the right thing", but would a more explicit parenthesis 
around (status != ZPCI_PCI_ST_FUNC_NOT_AVAIL) help or hurt here?

>  		return -EIO;
>  	zdev->dma_table = s390_domain->dma_table;

Thank you,
Gerd

