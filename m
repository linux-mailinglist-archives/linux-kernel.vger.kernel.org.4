Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A167E605A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiJTIwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJTIvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:51:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30021911F7;
        Thu, 20 Oct 2022 01:51:28 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K8hIaY010866;
        Thu, 20 Oct 2022 08:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rOo0Rw7hdoHqY3knTVoyqP0bdVcOO8+ZPUEIoL/qJt4=;
 b=EZV2LjwT6BPmwEIW4TFD+1ZOF2sCHdGiZY2pqseyP7gGMTJIIh9ZhcIT3IwJarDBZqnD
 Rx1UjXKLdZkKgkv+lEWzYkmB7ycZhjBeBNQbq5zFJp2npMnfb7cL9IAxq3TBJPMyzMYo
 n7BrbOsp3ZaHtHo36WQzwe1kIp3zAnMo/KrxfoFoJUDF4B93nJ11NSODKAQ5QeRhfQl8
 KiiM6OKWOnU+E6XozBtfm6kNZhsTfHnCnFz6eOKWb9rljzj5erTlTAXq/Ysup1twhEUx
 jbjVmrIBhPXqDtBEJZJF2FmB7QWYgJrHSySD78Xz4t+5TfjZHSJdLS6JF2MD7TAWR0wE jA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kb32hr6jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 08:51:16 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29K8pEuk005033;
        Thu, 20 Oct 2022 08:51:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3k7mg98m0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 08:51:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29K8pBnD42402256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 08:51:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5699242045;
        Thu, 20 Oct 2022 08:51:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D461442041;
        Thu, 20 Oct 2022 08:51:10 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Oct 2022 08:51:10 +0000 (GMT)
Message-ID: <f3551bb461b3ef3cfc1a0c644093816be1835b3f.camel@linux.ibm.com>
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
Date:   Thu, 20 Oct 2022 10:51:10 +0200
In-Reply-To: <Y0/lMCQ8oeXJ2HTg@nvidia.com>
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
         <20221018145132.998866-4-schnelle@linux.ibm.com>
         <Y07Dz/NROAMI0Hku@nvidia.com>
         <8e268ab5e0dadf86be5fd7ffaa9debb76cea67f3.camel@linux.ibm.com>
         <Y0/lMCQ8oeXJ2HTg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8wWJRvvydOu6sIg9_UYBhgDAfptnNEhD
X-Proofpoint-ORIG-GUID: 8wWJRvvydOu6sIg9_UYBhgDAfptnNEhD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_02,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-19 at 08:53 -0300, Jason Gunthorpe wrote:
> On Wed, Oct 19, 2022 at 10:31:21AM +0200, Niklas Schnelle wrote:
> > On Tue, 2022-10-18 at 12:18 -0300, Jason Gunthorpe wrote:
> > > On Tue, Oct 18, 2022 at 04:51:30PM +0200, Niklas Schnelle wrote:
> > > 
> > > > @@ -84,7 +88,7 @@ static void __s390_iommu_detach_device(struct zpci_dev *zdev)
> > > >  		return;
> > > >  
> > > >  	spin_lock_irqsave(&s390_domain->list_lock, flags);
> > > > -	list_del_init(&zdev->iommu_list);
> > > > +	list_del_rcu(&zdev->iommu_list);
> > > >  	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> > > 
> > > This doesn't seem obviously OK, the next steps remove the translation
> > > while we can still have concurrent RCU protected flushes going on.
> > > 
> > > Is it OK to call the flushes when after the zpci_dma_exit_device()/etc?
> > > 
> > > Jason
> > 
> > Interesting point. So for the flushes themselves this should be fine,
> > once the zpci_unregister_ioat() is executed all subsequent and ongoing
> > IOTLB flushes should return an error code without further adverse
> > effects. Though I think we do still have an issue in the IOTLB ops for
> > this case as that error would skip the IOTLB flushes of other attached
> > devices.
> 
> That sounds bad

Thankfully it's very easy to fix since our IOTLB flushes are per PCI
function, I just need to continue the loop in the IOTLB ops on error
instead of breaking out of it and skipping the other devices. Makes no
sense anyway to skip  devices just because there is an error on another
device.

> 
> 
> > The bigger question and that seems independent from RCU is how/if
> > detach is supposed to work if there are still DMAs ongoing. Once we do
> > the zpci_unregister_ioat() any DMA request coming from the PCI device
> > will be blocked and will lead to the PCI device being isolated (put
> > into an error state) for attempting an invalid DMA. So I had expected
> > that calls of detach/attach would happen without expected ongoing DMAs
> > and thus IOTLB flushes? 
> 
> "ongoing DMA" from this device shouuld be stopped, it doesn't mean
> that the other devices attached to the same domain are not also still
> operating and also still having flushes. So now that it is RCU a flush
> triggered by a different device will continue to see this now disabled
> device and try to flush it until the grace period.
> 
> Jason

Ok that makes sense thanks for the explanation. So yes my assessment is
still that in this situation the IOTLB flush is architected to return
an error that we can ignore. Not the most elegant I admit but at least
it's simple. Alternatively I guess we could use call_rcu() to do the
zpci_unregister_ioat() but I'm not sure how to then make sure that a
subsequent zpci_register_ioat() only happens after that without adding
too much more logic.

