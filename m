Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6455F0624
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiI3IBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiI3IBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:01:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2A129FCE;
        Fri, 30 Sep 2022 01:01:44 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28U7H2ef021657;
        Fri, 30 Sep 2022 08:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=XvKkvCtRGCWdox4k9XJ4eNOaUFUePFB4u7AUf7aqW1M=;
 b=jdj7RmO9krwtDkkxucrkhgmpZrCO9Z+jlAuUU0cLCu1enx6vSqyr3wotCGaaziO6Iz7F
 PgCOH410qRsfYQ/dSvNVMl9CBvimSvsRDkbIQQpH0Uth8ScBrX/NJVcrQrhhAz0roGU0
 sBrDyNs+dKb6G/uFf1lNtV2Ymbfic9R+1xWRbYkHm+sOAd9f+sz/s9BNdp0MXZVogpet
 dHChVBqrT4qKq6NcdEKRVxd6fBy2fzIQ5KDlimNB/AODtwRTi9KLOgfe5ayN33SFrQtc
 MVqQOj15bWikjMDbKELingwCmmp65A2O52MLQpZzMGax9+W8FGy2xaYXaLIhm8v3ZdMc yw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwuxas74a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 08:01:25 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28U7pasV023077;
        Fri, 30 Sep 2022 08:01:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3jssh8wty0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 08:01:24 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28U81KPN4915950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 08:01:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9F3652051;
        Fri, 30 Sep 2022 08:01:20 +0000 (GMT)
Received: from sig-9-145-158-199.de.ibm.com (unknown [9.145.158.199])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 230575204E;
        Fri, 30 Sep 2022 08:01:20 +0000 (GMT)
Message-ID: <094e77fd96696ada25eb1a620b46ef21c0cf6cc0.camel@linux.ibm.com>
Subject: Re: [PATCH v3 4/5] iommu/s390: Fix incorrect aperture check
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Date:   Fri, 30 Sep 2022 10:01:19 +0200
In-Reply-To: <YzXArysnUGFhywQT@nvidia.com>
References: <20220929153302.3195115-1-schnelle@linux.ibm.com>
         <20220929153302.3195115-5-schnelle@linux.ibm.com>
         <YzXArysnUGFhywQT@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zdh27Ld83o7w6gxwY6OSW1TZKLG0UZMz
X-Proofpoint-ORIG-GUID: Zdh27Ld83o7w6gxwY6OSW1TZKLG0UZMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 mlxlogscore=913 suspectscore=0 impostorscore=0 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-29 at 12:58 -0300, Jason Gunthorpe wrote:
> On Thu, Sep 29, 2022 at 05:33:01PM +0200, Niklas Schnelle wrote:
> > The domain->geometry.aperture_end specifies the last valid address treat
> > it as such when checking if a DMA address is valid.
> > 
> > Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> > Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/iommu/s390-iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> > index ed0e64f478cf..6d4a9c7db32c 100644
> > --- a/drivers/iommu/s390-iommu.c
> > +++ b/drivers/iommu/s390-iommu.c
> > @@ -210,7 +210,7 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
> >  	int rc = 0;
> >  
> >  	if (dma_addr < s390_domain->domain.geometry.aperture_start ||
> > -	    dma_addr + size > s390_domain->domain.geometry.aperture_end)
> > +	    dma_addr + size > s390_domain->domain.geometry.aperture_end + 1)
> 
> The reason the iommu layer uses 'last' (= start + size - 1) not 'end'
> is to allow for the very last byte of the range to be used.
> 
> Meaning (start + size) == 0 in some cases due to the overflow.
> 
> Generally when working with lasts's I prefer people write code in a
> way that doesn't trigger the overflow, because there are some
> complicated C rules about integer promotion that can mean the desired
> overflow silently doesn't happen in obscure cases - especially if
> unsigned long != u64
> 
> So, I'd write this as:
> 
>   (dma_addr + size - 1) > s390_domain->domain.geometry.aperture_end
> 
> Jason

Makes sense. Thanks.


