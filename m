Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3099A673F17
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjASQkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjASQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:40:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235AB3D91D;
        Thu, 19 Jan 2023 08:40:42 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JG7DKJ017633;
        Thu, 19 Jan 2023 16:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dIXQyuOOZ/H3pvQtiEYavSez6rN+kpLvatTL5kYH34k=;
 b=l40gJG3TMCXXHRlB2hIKYbqRYd2bee4XKfKenTT+lWVmVZQnG4UIihJdJT57ougoB2j+
 Bly+PH0TwQ1ivUqduFa6HWC+aAfKppVDDoZCt00Vq51kT+ZUVCdyhOpzY9C2nL3a8ce8
 HdRWdsJSD7O7bmLETj6uLksR3JtiMTVABpPnLXceAf5ylx1xPjMSWYh3icJ18az7ViVP
 Q0qDOEtRZxKq2TJT+JwF9+hrCZXWfJrikUw7PgCobIY2iOeiLds4ULzz+l3Z6CUueyeZ
 D/Nh3I941HGUO8j53kAwxTxx9FXs53v6uStDI5LNWJArVFT2z2na63n4d49ktJ0uVN+W vQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n78qs9x0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:40:30 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30JFWa0c014458;
        Thu, 19 Jan 2023 16:40:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3n3m17d8pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:40:29 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JGeRCo28901908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 16:40:27 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FBBA58068;
        Thu, 19 Jan 2023 16:40:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 613CB58059;
        Thu, 19 Jan 2023 16:40:25 +0000 (GMT)
Received: from [9.160.87.67] (unknown [9.160.87.67])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 16:40:25 +0000 (GMT)
Message-ID: <0e9f6597-305d-b08d-e153-13ba9ae46ab2@linux.ibm.com>
Date:   Thu, 19 Jan 2023 11:40:24 -0500
MIME-Version: 1.0
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
 <71b9e85d-960f-7403-0113-135746127f3b@linux.ibm.com>
 <69047c319c6cb2afd7331daeb7fc8459fdd34f80.camel@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <69047c319c6cb2afd7331daeb7fc8459fdd34f80.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MCGFh9H8R5Ex0YgjDidpBNdxwUeRVsZ-
X-Proofpoint-ORIG-GUID: MCGFh9H8R5Ex0YgjDidpBNdxwUeRVsZ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=810
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 11:33 AM, Niklas Schnelle wrote:
> On Tue, 2023-01-17 at 10:09 -0500, Matthew Rosato wrote:
>> On 1/4/23 7:05 AM, Niklas Schnelle wrote:
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
>>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>>> index ef38b1514c77..6b0fe8761509 100644
>>> --- a/arch/s390/pci/pci.c
>>> +++ b/arch/s390/pci/pci.c
>>> @@ -124,7 +124,11 @@ int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
>>>  
>>>  	WARN_ON_ONCE(iota & 0x3fff);
>>>  	fib.pba = base;
>>> -	fib.pal = limit;
>>> +	/* Work around off by one in ISM virt device */
>>> +	if (zdev->pft == 0x5 && limit > base)
>>
>> Nit: maybe a named #define for the ISM pft rather than hard-coding 0x5 here
>>
> 
> Hmm, I agree in principle but not sure where to put this #define. Maybe

I would suggest pci_clp.h since the value is coming from a clp.

> also important to mention that the off-by-one has actually been fixed
> in current firmware but of course we still have to support broken
> devices and the workaround still works with fixed ISM.

+1 




