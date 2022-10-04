Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409925F463F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJDPNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJDPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:13:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7668C5C9DA;
        Tue,  4 Oct 2022 08:13:10 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294DvmQM031944;
        Tue, 4 Oct 2022 15:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=SWi0qHo2YwtSuXgjGoHT2zxbPaZGlLdxwkC+Sl8l6Mk=;
 b=VdYHtaIaCJTI5bo3XESVhlncvgi5qg7seVMVJjvRvvsrR22tvfAOco8V+fCM1zMPF54j
 /wpEt084JGqUeRMSV+xezofs8aVUOrv6zXSpqjma4MuEB6zynzP0lal5bN/e19PsZRfX
 MbQQTDYpDL1BH5yHvyeThSWO+xPNSNmv8XtRe9AuMjNTh6SQgHuWMfuqQBQHd7AqNF/q
 dVifKa4tuqYpJJJAHLclnTUl5meVxG+qhl8dQe5+/C1JnIpEPtgZqENhRP14yTYXgOWv
 YqEN5COfIDeLriMEgchBy/cgU9em+z/WBY87MWD35M2mZkFtq+CVbDU63UDN2QKwEgU5 Vg== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0hbyudjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 15:12:57 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 294F59MI009919;
        Tue, 4 Oct 2022 15:12:56 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 3jxd69dmtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 15:12:56 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 294FCtMB16909022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Oct 2022 15:12:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE61658070;
        Tue,  4 Oct 2022 15:12:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C68AE58072;
        Tue,  4 Oct 2022 15:12:52 +0000 (GMT)
Received: from [9.77.144.104] (unknown [9.77.144.104])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  4 Oct 2022 15:12:52 +0000 (GMT)
Message-ID: <b3c6fd2b-74d4-91d7-dc53-ba526c41b067@linux.ibm.com>
Date:   Tue, 4 Oct 2022 11:12:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 5/5] iommu/s390: Fix incorrect pgsize_bitmap
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
 <20221004120706.2957492-6-schnelle@linux.ibm.com>
 <eb1955e4-a618-ebf0-562d-17f9dd58b0da@arm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <eb1955e4-a618-ebf0-562d-17f9dd58b0da@arm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QfCsKaHcAEwgEyTcV_GeddQf5rlspQEQ
X-Proofpoint-ORIG-GUID: QfCsKaHcAEwgEyTcV_GeddQf5rlspQEQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210040097
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 11:02 AM, Robin Murphy wrote:
> On 2022-10-04 13:07, Niklas Schnelle wrote:
>> The .pgsize_bitmap property of struct iommu_ops is not a page mask but
>> rather has a bit set for each size of pages the IOMMU supports. As the
>> comment correctly pointed out at this moment the code only support 4K
>> pages so simply use SZ_4K here.
> 
> Unless it's already been done somewhere else, you'll want to switch over to the {map,unmap}_pages() interfaces as well to avoid taking a hit on efficiency here. The "page mask" thing was an old hack to trick the core API into making fewer map/unmap calls where the driver could map arbitrary numbers of pages at once anyway. The multi-page interfaces now do that more honestly and generally better (since they work for non-power-of-two sizes as well).

Thanks for the heads up -- Niklas has some additional series coming soon as described here:

https://lore.kernel.org/linux-iommu/a10424adbe01a0fd40372cbd0736d11e517951a1.camel@linux.ibm.com/

So implementing the _pages() interfaces is soon up on the roadmap.  But given what you say I wonder if this patch should just wait until the series that implements {map,unmap}_pages().
> 
> Robin.
> 
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>>   drivers/iommu/s390-iommu.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
>> index 94c444b909bd..6bf23e7830a2 100644
>> --- a/drivers/iommu/s390-iommu.c
>> +++ b/drivers/iommu/s390-iommu.c
>> @@ -12,13 +12,6 @@
>>   #include <linux/sizes.h>
>>   #include <asm/pci_dma.h>
>>   -/*
>> - * Physically contiguous memory regions can be mapped with 4 KiB alignment,
>> - * we allow all page sizes that are an order of 4KiB (no special large page
>> - * support so far).
>> - */
>> -#define S390_IOMMU_PGSIZES    (~0xFFFUL)
>> -
>>   static const struct iommu_ops s390_iommu_ops;
>>     struct s390_domain {
>> @@ -350,7 +343,7 @@ static const struct iommu_ops s390_iommu_ops = {
>>       .probe_device = s390_iommu_probe_device,
>>       .release_device = s390_iommu_release_device,
>>       .device_group = generic_device_group,
>> -    .pgsize_bitmap = S390_IOMMU_PGSIZES,
>> +    .pgsize_bitmap = SZ_4K,
>>       .get_resv_regions = s390_iommu_get_resv_regions,
>>       .default_domain_ops = &(const struct iommu_domain_ops) {
>>           .attach_dev    = s390_iommu_attach_device,

