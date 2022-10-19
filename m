Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61268603B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJSIbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJSIbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:31:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADF97C31C;
        Wed, 19 Oct 2022 01:31:44 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J8RBsG006443;
        Wed, 19 Oct 2022 08:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GkThrXMhcVDf0soxdmZqBZ79wsxuVGBVvjI63NnIKLo=;
 b=lX9qao3nuwm7S0yhNyr9I11dtyvyPttO0Frvz3J7Z4Dt1/27CpRrSy63ZV68ExeqQEnO
 aGK8RSjwpxbXXsEA3DRJOCgaCdr4Pq4vM5INoFLH+s4y4vAiXvYx3xAwP95giDGEG2dL
 7p0argnMwIgsKXUxp9xP90WcK0yy7fGexcDg+CmdF6p2zhiCN7IGXZGskshHjbKR4n4Y
 d4i+Xaog3mwCOE2SBjATOAmOjuZuqJwkb8yIKxjcGkik+udrJBWe8sO3OhNyfNyaqqXX
 uLLgGOG2KfVlroVO5+ED1DEcsH535vHmSx6nNMUPddH1t8A1mwtMT1jt5j9hBbIG1QeB DA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kadr604b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 08:31:28 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29J8LXkB018650;
        Wed, 19 Oct 2022 08:31:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3k7mg96pwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 08:31:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29J8VMwr2753072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 08:31:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51A9D52052;
        Wed, 19 Oct 2022 08:31:22 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D5BB152050;
        Wed, 19 Oct 2022 08:31:21 +0000 (GMT)
Message-ID: <8e268ab5e0dadf86be5fd7ffaa9debb76cea67f3.camel@linux.ibm.com>
Subject: Re: [PATCH 3/5] iommu/s390: Use RCU to allow concurrent domain_list
 iteration
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Date:   Wed, 19 Oct 2022 10:31:21 +0200
In-Reply-To: <Y07Dz/NROAMI0Hku@nvidia.com>
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
         <20221018145132.998866-4-schnelle@linux.ibm.com>
         <Y07Dz/NROAMI0Hku@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dOLl7YUUbiqvlhbqaIV1KetfKUo3JKZM
X-Proofpoint-GUID: dOLl7YUUbiqvlhbqaIV1KetfKUo3JKZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_04,2022-10-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 mlxlogscore=862 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-18 at 12:18 -0300, Jason Gunthorpe wrote:
> On Tue, Oct 18, 2022 at 04:51:30PM +0200, Niklas Schnelle wrote:
> 
> > @@ -84,7 +88,7 @@ static void __s390_iommu_detach_device(struct zpci_dev *zdev)
> >  		return;
> >  
> >  	spin_lock_irqsave(&s390_domain->list_lock, flags);
> > -	list_del_init(&zdev->iommu_list);
> > +	list_del_rcu(&zdev->iommu_list);
> >  	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> 
> This doesn't seem obviously OK, the next steps remove the translation
> while we can still have concurrent RCU protected flushes going on.
> 
> Is it OK to call the flushes when after the zpci_dma_exit_device()/etc?
> 
> Jason

Interesting point. So for the flushes themselves this should be fine,
once the zpci_unregister_ioat() is executed all subsequent and ongoing
IOTLB flushes should return an error code without further adverse
effects. Though I think we do still have an issue in the IOTLB ops for
this case as that error would skip the IOTLB flushes of other attached
devices.

The bigger question and that seems independent from RCU is how/if
detach is supposed to work if there are still DMAs ongoing. Once we do
the zpci_unregister_ioat() any DMA request coming from the PCI device
will be blocked and will lead to the PCI device being isolated (put
into an error state) for attempting an invalid DMA. So I had expected
that calls of detach/attach would happen without expected ongoing DMAs
and thus IOTLB flushes? Of course we should be robust against
violations of that and unexpected DMAs for which I think isolating the
PCI device is the correct response. What am I missing?

