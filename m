Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34B169AEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjBQO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjBQO50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:57:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2A36EBB3;
        Fri, 17 Feb 2023 06:57:00 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HEgIJX027606;
        Fri, 17 Feb 2023 14:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=e8xe4P5N3/xfcsU15zARpw5D2BXKecFA5uBFpgNAqII=;
 b=NPOZAI4rcgGtbPqP+Vknc0HK9sc704yKXJm9Rk/sHexqM/zyx6s/1jqUgyJDTQ88HirG
 Xpz51XXN2KcuxxHo27uqUcn5atw1OJVG/2zMh1iiN8D8VagyvHNcQgXVaPpoB04kj1nX
 +/xMsZ2AI56Xdj1CFb2eBGmbSM1grpq+pwNSo1ftgL1k2gYKAbGO0yzXWLtrPIEliQld
 umOvTQ5NqbQVWzijypxevPkyptb8nEJkuwmzctkCuMMF7eIfVM95Ti7BDK9Xudnu+ka0
 2UD4Rno1ZhIRV9SnirQ6UBr6vHeUZ20p4f0jQL+PRpetve1nEyW0vyk4Z6xjMGx6pxNG Jw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ntbjura57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:56:14 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31HCTHc9007447;
        Fri, 17 Feb 2023 14:56:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3np2n7r620-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:56:12 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HEuARL1245844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:56:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C826758066;
        Fri, 17 Feb 2023 14:56:10 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C77858056;
        Fri, 17 Feb 2023 14:56:09 +0000 (GMT)
Received: from [9.77.136.58] (unknown [9.77.136.58])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 14:56:09 +0000 (GMT)
Message-ID: <7dc31552-1b7a-aeaa-eb88-a60d96e28f3c@linux.ibm.com>
Date:   Fri, 17 Feb 2023 09:56:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 4/6] s390/pci: Use dma-iommu layer
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
References: <20230215120327.947336-1-schnelle@linux.ibm.com>
 <20230215120327.947336-5-schnelle@linux.ibm.com>
 <4ad0d2b9-2465-b42d-c0f9-b48caadfd72c@linux.ibm.com>
 <59a61553a81282fed88c03af096b2a0830b94302.camel@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <59a61553a81282fed88c03af096b2a0830b94302.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BUSQb5EkyR9LCL0HNzLyWQRHkR5GSLbG
X-Proofpoint-ORIG-GUID: BUSQb5EkyR9LCL0HNzLyWQRHkR5GSLbG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_09,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=662
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302170132
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/23 3:51 AM, Niklas Schnelle wrote:
> On Wed, 2023-02-15 at 13:00 -0500, Matthew Rosato wrote:
>> On 2/15/23 7:03 AM, Niklas Schnelle wrote:
>>> While s390 already has a standard IOMMU driver and previous changes have
>>> added I/O TLB flushing operations this driver is currently only used for
>>> user-space PCI access such as vfio-pci. For the DMA API s390 instead
>>> utilizes its own implementation in arch/s390/pci/pci_dma.c which drives
>>> the same hardware and shares some code but requires a complex and
>>> fragile hand over between DMA API and IOMMU API use of a device and
>>> despite code sharing still leads to significant duplication and
>>> maintenance effort. Let's utilize the common code DMAP API
>>> implementation from drivers/iommu/dma-iommu.c instead allowing us to
>>> get rid of arch/s390/pci/pci_dma.c.
>>>
>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>> ---
>>
>> FYI, this patch doesn't fit on top of iommu-next, I'd guess at least due to baolu's 'Retire detach_dev callback' series, which removed .detach_dev and added .set_platform_dma_ops for s390-iommu.  That's relevant here, because now that this patch enables dma-iommu for s390 and removes the platform DMA ops it must now remove .set_platform_dma_ops/s390_iommu_set_platform_dma for s390-iommu.
>>
>> Matt
> 
> 
> Ok, yes this series is currently against v6.2-rc8. Should I rebase
> against iommu-next and send a v7 before further review or after?
> 

So, overall I'm fine with the code in this patch (and this series) at this point; however I'd like to do one more pass of testing rebased on top of iommu-next / with the set_platform_dma collision handled, so I'm going to hold off on tagging my review of this one until v7.  That really only impacts this patch so if you want to give others a chance to review the rest of the series before rolling out v7 that's OK by me.  

Thanks,
Matt
