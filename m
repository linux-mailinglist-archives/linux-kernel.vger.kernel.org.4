Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557D069E93E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjBUVFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBUVFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:05:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E1A21A24;
        Tue, 21 Feb 2023 13:05:39 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LIi2PQ016966;
        Tue, 21 Feb 2023 21:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=l89w9hTDLGhdANTTPiC9rJMAvvdMVotwgL6kR6zoB54=;
 b=VKlsqfwTzV/QGnxmJ+3NvXb47SUtRmNeu9pS7Pb1mZ4PJNI9AOX8SOCrh079Ha/GsZ3c
 L/mIpKU7R4NjBe7F41EY2bXu1zPMbnxLO1Hc+JaGhqRLgIIaTbkYbFVhRoOoI8VvlBy0
 PGJomREdn41Sd1jw9DsQK7zWAcU4aUtkxuhrjG9m1B4CKAJdAKb+PxC8i7QOF8J9GGKr
 hPvvun0HGi7xz7lx86tpAghwrVwJPvq97eoiBKevhvvLNtzZ5dhCB7qOlH/lLoyRi8ce
 tZ00axE/C5++wupERXKHULpOalXXcn3CSq8nP2i2Ic3MGIvGvAgd5tPNrEbnYv1oHwI9 Uw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nw3amu1mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:05:24 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LIXw5n000579;
        Tue, 21 Feb 2023 21:05:23 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ntpa79uxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:05:23 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31LL5MST4129402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 21:05:22 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2908D58063;
        Tue, 21 Feb 2023 21:05:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1C405805D;
        Tue, 21 Feb 2023 21:05:20 +0000 (GMT)
Received: from [9.60.89.243] (unknown [9.60.89.243])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 21:05:20 +0000 (GMT)
Message-ID: <ace6750d-c2ff-dffa-ef0a-3face3f17f28@linux.ibm.com>
Date:   Tue, 21 Feb 2023 16:05:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 4/6] s390/pci: Use dma-iommu layer
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
References: <20230220152222.1818344-1-schnelle@linux.ibm.com>
 <20230220152222.1818344-5-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230220152222.1818344-5-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N_92_8Yv43Xoo772wijkO5u1DJuRd871
X-Proofpoint-ORIG-GUID: N_92_8Yv43Xoo772wijkO5u1DJuRd871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxlogscore=595
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 10:22 AM, Niklas Schnelle wrote:
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

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

