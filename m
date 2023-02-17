Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5B769AE3A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBQOla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBQOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:41:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEB36D276;
        Fri, 17 Feb 2023 06:41:27 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HECLx7017768;
        Fri, 17 Feb 2023 14:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FsBhb0GAKnBWY50PS8fAm6Vk1EbPtPnQOeZ7sTjVH9w=;
 b=HIBgv7HMqSp+x8LQJ2GlXdMvOdyS9NI3a/lqYxcQayUb5lquCQbXgOmfwr0xNxxEVbxS
 y2h11iaErlcDxbrwbwkpmbJ8NdOIekXcAJoxGZGL1w5a9ChUp3b56NpNVeVCzARUI37k
 R34GFltYMbaYNKR6tE8DOdghXHBA6ZxorAz/z3dnjGrzRopB7gvXqIt3eEZ1oB/72Dv8
 JAro5eCalxT92qNfRyLhh5IkZXYpictoRnDml+sfXPqKi6ZWmUG/wxrIsKLZSuienLYZ
 w7lmzm1OwYlZz8Fv883um1ykdF+N4jBUcONvUs6McBVZ/YUrRYmNTlAMcog7zJOTeIwV 8Q== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nt2c5mxgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:41:17 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31HCme3a009847;
        Fri, 17 Feb 2023 14:41:17 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3np2n88486-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:41:17 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HEfEGK36635042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:41:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4A8B58062;
        Fri, 17 Feb 2023 14:41:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E14A25805A;
        Fri, 17 Feb 2023 14:41:12 +0000 (GMT)
Received: from [9.77.136.58] (unknown [9.77.136.58])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 14:41:12 +0000 (GMT)
Message-ID: <bc234db3-f4c9-ff5a-6c19-699c50514fc5@linux.ibm.com>
Date:   Fri, 17 Feb 2023 09:41:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 6/6] iommu/dma: Make flush queue sizes and timeout
 driver configurable
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
 <20230215120327.947336-7-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230215120327.947336-7-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oXto8bV8zvFztWe5qpC2-g12w0nJNxiU
X-Proofpoint-GUID: oXto8bV8zvFztWe5qpC2-g12w0nJNxiU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> Flush queues currently use a fixed compile time size of 256 entries.
> This being a power of 2 allows the compiler to use shift and mask
> instead of more expensive modulo operations. With per-CPU flush queues
> larger queue sizes would hit per-CPU allocation limits, with a single
> flush queue these limits do not apply however. Also with single queues
> being particularly suitable for virtualized environments with expensive
> IOTLB flushes these benefit especially from larger queues and thus fewer
> flushes.
> 
> To this end re-order struct iova_fq so we can use a dynamic array and
> introduce the flush queue size and timeouts as new options in the
> dma_iommu_options struct. So as not to lose the shift and mask
> optimization, check that the variable length is a power of 2 and use
> explicit shift and mask instead of letting the compiler optimize this.
> 
> In the s390 IOMMU driver a large fixed queue size and timeout is then
> set together with single queue mode bringing its performance on s390
> paged memory guests on par with the previous s390 specific DMA API
> implementation.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com> #s390

> +#define S390_IOMMU_SINGLE_FQ_SIZE      32768
> +#define S390_IOMMU_SINGLE_FQ_TIMEOUT   1000
> +

One question about these values however, was there a rationale to choosing these particular numbers (anything worth documenting?) or were they were simply chosen because they showed similar characteristics to the previous DMA approach?  I'm mostly wondering if it's worth experimenting with other values here in the future to see what kind of impact it would have.



