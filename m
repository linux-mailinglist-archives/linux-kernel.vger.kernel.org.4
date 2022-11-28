Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFAE63A6D5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiK1LLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiK1LLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:11:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE901B1F3;
        Mon, 28 Nov 2022 03:11:10 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASAYfW8024017;
        Mon, 28 Nov 2022 11:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GZxdR9uOa7Jfqv5qjaWw+OASw4kW7TdlBzs0BV9Y63I=;
 b=NnLEKwp6jhgEH9iAgFVxC6c5Yoq3vpWGUJdy7ZRnn/KMNhZeRVUh6niyFpyzwOkrhkht
 JBbumZr1oVtjBT3DJHu36CbZkjSoUA3J2bVTK9VoeV7k0cxqfo9dJeBSQ3joXDEJoB2K
 qzrBMvuTM94UHsIe9B0omtanwu7g3bwg7/JgYhJqQNsUbSn+YvqmitLkI78VHBY5PNyG
 wO6kzEtSc4DU7nQFQh1+LSQDUYQQaKIWmKp+zqCwiyra24vK2aAvbfC+0/uwmJ1+f9qT
 ZFeKfWQTxqLRCcM8ZU+ZvpRYDRvseKnSAC/0aTf1kjSrsmfhk5QrQ8WDB+2HTV1ZQY9I Pw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m3v8je1vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 11:10:46 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ASB5fK7032001;
        Mon, 28 Nov 2022 11:10:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3m3ae9acrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 11:10:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ASBBNCG4522680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 11:11:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F0F042045;
        Mon, 28 Nov 2022 11:10:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 295854203F;
        Mon, 28 Nov 2022 11:10:40 +0000 (GMT)
Received: from sig-9-145-47-38.uk.ibm.com (unknown [9.145.47.38])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Nov 2022 11:10:40 +0000 (GMT)
Message-ID: <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Mon, 28 Nov 2022 12:10:39 +0100
In-Reply-To: <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
         <20221116171656.4128212-5-schnelle@linux.ibm.com>
         <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CyGuCoWUou6f4zl4TQXWvmAEwOC89LIy
X-Proofpoint-ORIG-GUID: CyGuCoWUou6f4zl4TQXWvmAEwOC89LIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_09,2022-11-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=793 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-11-17 at 09:55 +0800, Baolu Lu wrote:
> On 2022/11/17 1:16, Niklas Schnelle wrote:
> > When iommu.strict=1 is set or iommu_set_dma_strict() was called we
> > should use IOMMU_DOMAIN_DMA irrespective of ops->def_domain_type.
> > 
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >   drivers/iommu/iommu.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 65a3b3d886dc..d9bf94d198df 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1562,6 +1562,9 @@ static int iommu_get_def_domain_type(struct device *dev)
> >   {
> >   	const struct iommu_ops *ops = dev_iommu_ops(dev);
> >   
> > +	if (iommu_dma_strict)
> > +		return IOMMU_DOMAIN_DMA;
> 
> If any quirky device must work in IOMMU identity mapping mode, this
> might introduce functional regression. At least for VT-d platforms, some
> devices do require IOMMU identity mapping mode for functionality.

That's a good point. How about instead of unconditionally returning
IOMMU_DOMAIN_DMA we just do so if the domain type returned by ops-
>def_domain_type uses a flush queue (i.e. the __IOMMU_DOMAIN_DMA_FQ bit
is set). That way a device that only supports identity mapping gets to
set that but iommu_dma_strict at least always prevents use of an IOVA
flush queue.

> 
> > +
> >   	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> >   		return IOMMU_DOMAIN_DMA;
> >   
> 
> Best regards,
> baolu


