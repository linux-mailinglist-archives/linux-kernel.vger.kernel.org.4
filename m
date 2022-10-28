Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB84610D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJ1J3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJ1J3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:29:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BE319DD95;
        Fri, 28 Oct 2022 02:29:19 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S9D9dM004186;
        Fri, 28 Oct 2022 09:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uLFhNBsoYwHR3Eq8nBH5VOZ2zu8ZTme63QKaYCM+QLY=;
 b=liY+pHKioyatRCYaB1bxSdbP2syCd81k/L/dGl2aYSjz4vWsW7xHclgjSum/Cx9naeVT
 LGR0GCAK/9Ia/bYjWkGGuzL7siylXX8y8PRm2SgCIAWwe23qTB5yT/gVS1HdKF6gRJNP
 CCN8l7d0qrm0l4WRGOKDDTXyWkHc5ALUJm/6I/wRTVfm/tnHrlDEIwlmZGyMBKuALngk
 p/7bXC2N6/qkbfgJg5ym+cw+byjram8HZN6Jr0nANlsdZ0M60pACJ2XisX3AHDgMyKOo
 hYlLjcv27qICpwu2llGA9P8d+CH0Gx02jWMgCUmrfe0zC0o1fiUWbIqennt7LWVxXPue Rw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgc8p8gkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 09:29:06 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29S9KYKM023857;
        Fri, 28 Oct 2022 09:29:04 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3kfahd2fb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 09:29:04 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29S9T1Sp30933362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 09:29:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 663D74C04E;
        Fri, 28 Oct 2022 09:29:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 868C24C046;
        Fri, 28 Oct 2022 09:29:00 +0000 (GMT)
Received: from sig-9-145-187-50.de.ibm.com (unknown [9.145.187.50])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 09:29:00 +0000 (GMT)
Message-ID: <1e10c0605e65f43acf6d2b5e71c7c74d6ff980b5.camel@linux.ibm.com>
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
Date:   Fri, 28 Oct 2022 11:29:00 +0200
In-Reply-To: <Y1qPvg+g6EEaayF6@nvidia.com>
References: <Y1ErcEe82yjJI+ET@nvidia.com>
         <68d91d7a5aadbd46dc34470eccd6b86a84c9e47b.camel@linux.ibm.com>
         <Y1KgX8EwH8T+FgWC@nvidia.com>
         <89a748fb5caee8be5d91806aa5dfd131e92d5d82.camel@linux.ibm.com>
         <Y1K1AqVWEyY0/Uqy@nvidia.com>
         <cef734b9f9b33380c1bbff40b56bb67b3de29341.camel@linux.ibm.com>
         <Y1a8qM4c2ZAM9glJ@nvidia.com>
         <3c2249fc7abf481b15d4988c2bd6456c48154c44.camel@linux.ibm.com>
         <Y1p/7YS338ghykGz@nvidia.com>
         <c98fa11d4efa86ca676a9d164893db8af8ab3693.camel@linux.ibm.com>
         <Y1qPvg+g6EEaayF6@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c5DXM0sJle-tqorYLEZmLXgC8wtcrONS
X-Proofpoint-ORIG-GUID: c5DXM0sJle-tqorYLEZmLXgC8wtcrONS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_04,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-27 at 11:03 -0300, Jason Gunthorpe wrote:
> On Thu, Oct 27, 2022 at 03:35:57PM +0200, Niklas Schnelle wrote:
> > On Thu, 2022-10-27 at 09:56 -0300, Jason Gunthorpe wrote:
> > > On Thu, Oct 27, 2022 at 02:44:49PM +0200, Niklas Schnelle wrote:
> > > > On Mon, 2022-10-24 at 13:26 -0300, Jason Gunthorpe wrote:
> > > > > On Mon, Oct 24, 2022 at 05:22:24PM +0200, Niklas Schnelle wrote:
> > > > > 
> > > > > > Thanks for the explanation, still would like to grok this a bit more if
> > > > > > you don't mind. If I do read things correctly synchronize_rcu() should
> > > > > > run in the conext of the VFIO ioctl in this case and shouldn't block
> > > > > > anything else in the kernel, correct? At least that's how I understand
> > > > > > the synchronize_rcu() comments and the fact that e.g.
> > > > > > net/vmw_vsock/virtio_transport.c:virtio_vsock_remove() also does a
> > > > > > synchronize_rcu() and can be triggered from user-space too.
> > > > > 
> > > > > Yes, but I wouldn't look in the kernel to understand if things are OK
> > > > >  
> > > > > > So we're
> > > > > > more worried about user-space getting slowed down rather than a Denial-
> > > > > > of-Service against other kernel tasks.
> > > > > 
> > > > > Yes, functionally it is OK, but for something like vfio with vIOMMU
> > > > > you could be looking at several domains that have to be detached
> > > > > sequentially and with grace periods > 1s you can reach multiple
> > > > > seconds to complete something like a close() system call. Generally it
> > > > > should be weighed carefully
> > > > > 
> > > > > Jason
> > > > 
> > > > Thanks for the detailed explanation. Then let's not put a
> > > > synchronize_rcu() in detach, as I said as long as the I/O translation
> > > > tables are there an IOTLB flush after zpci_unregister_ioat() should
> > > > result in an ignorable error. That said, I think if we don't have the
> > > > synchronize_rcu() in detach we need it in s390_domain_free() before
> > > > freeing the I/O translation tables.
> > > 
> > > Yes, it would be appropriate to free those using one of the rcu
> > > free'rs, (eg kfree_rcu) not synchronize_rcu()
> > > 
> > > Jason
> > 
> > They are allocated via kmem_cache_alloc() from caches shared by all
> > IOMMU's so can't use kfree_rcu() directly. Also we're only freeing the
> > entire I/O translation table of one IOMMU at once after it is not used
> > anymore. Before that it is only grown. So I think synchronize_rcu() is
> > the obvious and simple choice since we only need one grace period.
> 
> It has the same issue as doing it for the other reason, adding
> synchronize_rcu() to the domain free path is undesirable.
> 
> The best thing is to do as kfree_rcu() does now, basically:
> 
> rcu_head = kzalloc(rcu_head, GFP_NOWAIT, GFP_NOWARN)
> if (!rcu_head)
>    synchronize_rcu()
> else
>    call_rcu(rcu_head)
> 
> And then call kmem_cache_free() from the rcu callback

Hmm, maybe a stupid question but why can't I just put the rcu_head in
struct s390_domain and then do a call_rcu() on that with a callback
that does:

	dma_cleanup_tables(s390_domain->dma_table);
	kfree(s390_domain);

I.e. the rest of the current s390_domain_free().
Then I don't have to worry about failing to allocate the rcu_head and
it's simple enough. Basically just do the actual freeing of the
s390_domain via call_rcu().

> 
> But this is getting very complicated, you might be better to refcount
> the domain itself and acquire the refcount under RCU. This turns the
> locking problem into a per-domain-object lock instead of a global lock
> which is usually good enough and simpler to understand.
> 
> Jason

Sorry I might be a bit slow as I'm new to RCU but I don't understand
this yet, especially the last part. Before this patch we do have a per-
domain lock but I'm sure that's not the kind of "per-domain-object
lock" you're talking about or else we wouldn't need RCU at all. Is this
maybe a different way of expressing the above idea using the analogy
with reference counting from whatisRCU.rst? Meaning we treat the fact
that there may still be RCU readers as "there are still references to
s390_domain"? 

Or do you mean to use a kref that is taken by RCU readers together with
rcu_read_lock() and dropped at rcu_read_unlock() such that during the
RCU read critical sections the refcount can't fall below 1 and the
domain is actually freed once we have a) put the initial reference
during s390_domain_free() and b) put all temporary references on
exiting the RCU read critical sections?

