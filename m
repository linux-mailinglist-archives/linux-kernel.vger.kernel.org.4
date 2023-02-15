Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D300A6982CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjBOSAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjBOSAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:00:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231923C7BA;
        Wed, 15 Feb 2023 10:00:30 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FHXO71032265;
        Wed, 15 Feb 2023 18:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=huAOFH+wzio3JWWNZAJliW4HDetlKh7gD65mTH90JEQ=;
 b=nPlfi5S53WxIYoN5+jrdA4QKNTFdIfOOj93boCV1PZFydolejYSLM0Tot8BSbPuoJp3G
 zgmXvludDiEUFHOcA2zhAT317D6cp3vb2H3VXCerM9X1AjyQ0FEopaTFlxadi2EsbEIl
 2RTk7DOQPy+WPlH30omOLkZoMJMDGWtXalb40KHoFNu+zh+O8h/U+KjpQHCcsuNiSzEX
 464S9fA6LLbmsxVMf+SlECofKS/eCU/QTNOGfQGoxPWjAdKQBxEggf/KCNUi0+JGEwCs
 Z2Z5bjH2PPzquEhW72rQQWtYVJXI9V1VI8zENK7woAnyngkL/34IS1PDeAmfH/oAd0s+ sQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns3a3hw1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 18:00:13 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31FG51HH009847;
        Wed, 15 Feb 2023 18:00:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3np2n7uyk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 18:00:12 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31FI0AxT28770970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 18:00:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 181F058076;
        Wed, 15 Feb 2023 18:00:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB21058070;
        Wed, 15 Feb 2023 18:00:08 +0000 (GMT)
Received: from [9.60.89.243] (unknown [9.60.89.243])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 18:00:08 +0000 (GMT)
Message-ID: <4ad0d2b9-2465-b42d-c0f9-b48caadfd72c@linux.ibm.com>
Date:   Wed, 15 Feb 2023 13:00:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 4/6] s390/pci: Use dma-iommu layer
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
References: <20230215120327.947336-1-schnelle@linux.ibm.com>
 <20230215120327.947336-5-schnelle@linux.ibm.com>
Content-Language: en-US
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230215120327.947336-5-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ir9BlGa-9OeRYihge9S9OWDaTu0bi6j4
X-Proofpoint-GUID: ir9BlGa-9OeRYihge9S9OWDaTu0bi6j4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_07,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=675 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150157
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 7:03 AM, Niklas Schnelle wrote:
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
> ---

FYI, this patch doesn't fit on top of iommu-next, I'd guess at least due to baolu's 'Retire detach_dev callback' series, which removed .detach_dev and added .set_platform_dma_ops for s390-iommu.  That's relevant here, because now that this patch enables dma-iommu for s390 and removes the platform DMA ops it must now remove .set_platform_dma_ops/s390_iommu_set_platform_dma for s390-iommu.

Matt
