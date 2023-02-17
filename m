Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E999169AE32
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBQOkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQOkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:40:18 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9B56BDEE;
        Fri, 17 Feb 2023 06:40:17 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HCRsaS014471;
        Fri, 17 Feb 2023 14:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MF0mf47oC7wCMjcoH3jZ6O3J7JK1lNbHtvcJHy/ABuA=;
 b=VfW8kLcXThihgIm39SQb7MgBydsHGC/tBCIS2LRtAbY+VuHm/sozWOGUF35nrUJ5wbol
 ewa71GrTs6qzt452Em+GypHZUk/ZQ7pqyDpe7w+59bQxfdZUZtI6Bqy4VLIasCbRH5W9
 JdrcuCKettvsD7NMqb7w9vMPN0mfP17eATAdE8kqDvuTfgNJRa21FShQx90h7B5nA4vY
 gT2YPHYsQx+r1Rg8SojrzTkLGDEJHH+SW+PSCCpISlTP/gkG7YtHqqyi4MaNPqKicuat
 IdW3DI6yKcZOpF1cgTYvH0oVUU71eBV78/4hw2qNLckljnXGV4pLWBuBcBjui60UZe81 +A== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nt15wxbmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:40:06 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31HClI3g000986;
        Fri, 17 Feb 2023 14:40:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3np2n802ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:40:05 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HEe3eL2032382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:40:03 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D1A05805A;
        Fri, 17 Feb 2023 14:40:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A03858052;
        Fri, 17 Feb 2023 14:40:02 +0000 (GMT)
Received: from [9.77.136.58] (unknown [9.77.136.58])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 14:40:02 +0000 (GMT)
Message-ID: <d8fdf1a5-3405-d449-bf94-7e2c19da8d15@linux.ibm.com>
Date:   Fri, 17 Feb 2023 09:40:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 5/6] iommu/dma: Allow a single FQ in addition to
 per-CPU FQs
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
 <20230215120327.947336-6-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230215120327.947336-6-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wv5ye4-B8LK3q4CFKfn98TVv7GrtUbwT
X-Proofpoint-GUID: Wv5ye4-B8LK3q4CFKfn98TVv7GrtUbwT
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=713 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170132
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 7:03 AM, Niklas Schnelle wrote:
> In some virtualized environments, including s390 paged memory guests,
> IOTLB flushes are used to update IOMMU shadow tables. Due to this, they
> are much more expensive than in typical bare metal environments or
> non-paged s390 guests. In addition they may parallelize more poorly in
> virtualized environments. This changes the trade off for flushing IOVAs
> such that minimizing the number of IOTLB flushes trumps any benefit of
> cheaper queuing operations or increased paralellism.
> 
> In this scenario per-CPU flush queues pose several problems. Firstly
> per-CPU memory is often quite limited prohibiting larger queues.
> Secondly collecting IOVAs per-CPU but flushing via a global timeout
> reduces the number of IOVAs flushed for each timeout especially on s390
> where PCI interrupts may not be bound to a specific CPU.
> 
> Let's introduce a single flush queue mode that reuses the same queue
> logic but only allocates a single global queue. This mode can be
> selected as a flag bit in a new dma_iommu_options struct which can be
> modified from its defaults by IOMMU drivers implementing a new
> ops.tune_dma_iommu() callback. As a first user the s390 IOMMU driver
> selects the single queue mode if IOTLB flushes are needed on map which
> indicates shadow table use. With the unchanged small FQ size and
> timeouts this setting is worse than per-CPU queues but a follow up patch
> will make the FQ size and timeout variable. Together this allows the
> common IOVA flushing code to more closely resemble the global flush
> behavior used on s390's previous internal DMA API implementation.
> 
> Link: https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde006257b6f@arm.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com> #s390

