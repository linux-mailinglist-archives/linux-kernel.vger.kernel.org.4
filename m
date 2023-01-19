Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0F673E50
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjASQMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjASQMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:12:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980A193E3;
        Thu, 19 Jan 2023 08:12:30 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JG76j7024282;
        Thu, 19 Jan 2023 16:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SUJFjDPwUC6+nNdCF9RovTnzhq/mVGT86gYrLoVlLhQ=;
 b=CPGwoaR+Vv5Bgxg4iv2GasoYXpGnswMC6q21pqFUByCfYF02u6gA5EZT4gxvjO3tIQpv
 hZAJLww2aSJSRj5SgZtYjJp82kk3Jb1oqcKm4jac1Epqmuy8DSWLXMoZs6qLJfVYLGab
 46UzbtexD0mczDwxIO6CP4u55dnCq9QZ6V1/P2tN7nFdYmk1u3/4XS09gM3Z2yO0yZVo
 IU4oIF3IeloLJQIMEa2tfNk8Eb1u8iOCR85LGKMugaxV/jZfE9+MK8ry0lSvPEXw/S19
 3DTSJvqH01cnGX9GqXdzgL6cDifeZx2G6luL4Rx6f/fqhT6obMnSA4B1xFjLmbCbCjj5 Lw== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n78aqhsdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:12:16 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30JFWapf014458;
        Thu, 19 Jan 2023 16:12:15 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3n3m17d4hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:12:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JGCE6E64946642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 16:12:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45D9958055;
        Thu, 19 Jan 2023 16:12:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C7745804B;
        Thu, 19 Jan 2023 16:12:12 +0000 (GMT)
Received: from [9.160.87.67] (unknown [9.160.87.67])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 16:12:12 +0000 (GMT)
Message-ID: <5d0b26b1-ffc5-94dd-ced2-52cfef3842a4@linux.ibm.com>
Date:   Thu, 19 Jan 2023 11:12:11 -0500
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
 <a623049fb595480ffdf1130bbe800d79705cef03.camel@linux.ibm.com>
 <50c22529-e0f4-9124-fdc0-c8da49300b18@linux.ibm.com>
 <0ce7d96b8447a293b147976e5993cb053feb9c52.camel@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <0ce7d96b8447a293b147976e5993cb053feb9c52.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K3LxXT5TPOTNVukUayjbtyihCNrB2pbR
X-Proofpoint-GUID: K3LxXT5TPOTNVukUayjbtyihCNrB2pbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=671 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 11:04 AM, Niklas Schnelle wrote:
> On Thu, 2023-01-19 at 10:59 -0500, Matthew Rosato wrote:
>> On 1/19/23 6:03 AM, Niklas Schnelle wrote:
>>>>>>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>  static char *pci_sw_names[] = {
>>>>>>>>>>>>>>>>>>> - "Allocated pages",
>>>>>>>>>>>>>>>>>>> +/* TODO "Allocated pages", */
>>>>>>>>>>>
>>>>>>>>>>> ? Forgot to finish this?
>>>
>>> Definitely forgot to remove the TODO. I think my latest plan was to
>>> just remove this counter. With the DMA API conversion the
>>> dma_map_ops.alloc and dma_map_ops.free move to common code and I don't
>>> see how we could differentiate these from map/unmap on our side. I'm
>>> not sure how helpful this counter really is either. If you're
>>> interested in how many pages are mapped long term I think it makes more
>>> sense to look at the difference between mapped and unmapped pages. What
>>> do you think?
>>>>>>>>>>
>>
>> Sounds reasonable to me, but I also note that without this series, when viewing statistics for a device, mapped - unmapped != allocated.  Maybe allocated pages was already broken, or is it taking into account something else that mapped - unmapped would not (maybe mapping the same page multiple times)?
>>
>>
> 
> Allocated Pages only counts the memory allocated via dma_map_ops.alloc
> so it would not count long term mappings of memory the driver allocated
> differently and then mapped for long term use.

Oh, right, I see it now.

Seems to me then that mapped-unmapped is more indicative of the actual footprint anyway so in the absence of an obvious analogue I'm fine with just getting rid of it.
