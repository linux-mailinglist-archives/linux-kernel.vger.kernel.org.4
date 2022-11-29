Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4451563C175
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiK2NwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiK2NwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:52:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9908303ED;
        Tue, 29 Nov 2022 05:52:14 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATDgTLZ004179;
        Tue, 29 Nov 2022 13:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6QamOlBxwf8aERyTMvj6oT7s7/nhNFkpZpteMjXFw5Y=;
 b=MZ8zHta/Euri9J9ybpGDC2zJH6VduWBAbYl1KudKA+1a0uOltf2jKptTZiEo8B7EOixc
 2PS0qnUZpxmmE7MRtqx74+cWaLNxVcMw28gWtZWgiBM7oxtJjiSdVEYKCs1dSyeEsWrK
 5hrvJe+8cOCmqbJfWbS9wcJnktkQpmrw0gdJ5wEe1y4xLOVEODpRlY+vsCfU3A33FoDt
 hU/wnGeq9qYXRteh64DpVYokdFNERtn1xQUmNJr/k+EJYxjVVKT6JMU5BvJ9aZhnmA1w
 WTPRZwqCY6LakzjOneNUwe+mKlCY540QLsoMGYtOQbcaQClwHuKaLA1z8nXV8nTR3vSe tA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5k6q088c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 13:52:00 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ATDppHJ007877;
        Tue, 29 Nov 2022 13:51:59 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3m3ae9hye3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 13:51:59 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ATDpxrR63111812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 13:52:00 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDFA65805C;
        Tue, 29 Nov 2022 13:51:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 602E45805F;
        Tue, 29 Nov 2022 13:51:56 +0000 (GMT)
Received: from [9.160.4.194] (unknown [9.160.4.194])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Nov 2022 13:51:56 +0000 (GMT)
Message-ID: <b72234f9-bc65-2032-7d1a-91028e12ea74@linux.ibm.com>
Date:   Tue, 29 Nov 2022 08:51:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 7/7] iommu/s390: flush queued IOVAs on RPCIT out of
 resource indication
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
 <20221116171656.4128212-8-schnelle@linux.ibm.com>
 <cf0fed35-2d9d-3d19-3538-1ddcbfd563b0@arm.com>
 <8ae4c9b196aec34df4644ffecb66cfa4ce953244.camel@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <8ae4c9b196aec34df4644ffecb66cfa4ce953244.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XvtNPxnxOgINUuIfHdiplClwOkfNwyv6
X-Proofpoint-GUID: XvtNPxnxOgINUuIfHdiplClwOkfNwyv6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_08,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290078
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 7:00 AM, Niklas Schnelle wrote:
> On Mon, 2022-11-28 at 14:52 +0000, Robin Murphy wrote:
>> On 2022-11-16 17:16, Niklas Schnelle wrote:
>>> When RPCIT indicates that the underlying hypervisor has run out of
>>> resources it often means that its IOVA space is exhausted and IOVAs need
>>> to be freed before new ones can be created. By triggering a flush of the
>>> IOVA queue we can get the queued IOVAs freed and also get the new
>>> mapping established during the global flush.
>>
>> Shouldn't iommu_dma_alloc_iova() already see that the IOVA space is 
>> exhausted and fail the DMA API call before even getting as far as 
>> iommu_map(), though? Or is there some less obvious limitation like a 
>> maximum total number of distinct IOVA regions regardless of size?
> 
> Well, yes and no. Your thinking is of course correct if the advertised
> available IOVA space can be fully utilized without exhausting
> hypervisor resources we won't trigger this case. However sadly there
> are complications. The most obvious being that in QEMU/KVM the
> restriction of the IOVA space to what QEMU can actually have mapped at
> once was just added recently[0] prior to that we would regularly go
> through this "I'm out of resources free me some IOVAs" dance with our
> existing DMA API implementation where this just triggers an early cycle
> of freeing all unused IOVAs followed by a global flush. On z/VM I know
> of no situations where this is triggered. That said this signalling is

While the QEMU case made for an easily-reproducible scenario, the indication was really provided to handle a scenario where you have multiple pageable guests whose sum of total memory is overcommitted as compared to the hypervisor's resources.  The intent is for the entire advertised guest aperture to be usable and generally-speaking it is, but it's possible to find yourself in a (poorly tuned) scenario where the hypervisor is unable to pin additional pages (basically an OOM condition) -- the hypervisor (qemu/kvm or z/VM) can use this as a cry for help to say "stop what you're doing and flush your queues immediately so I can unpin as much as possible", and then after that the guest(s) can continue using their aperture.  

This is unnecessary for the no-paging bare metal hypervisor because there you aren't over-committing memory.
