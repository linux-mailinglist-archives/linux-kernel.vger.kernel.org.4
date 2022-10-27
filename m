Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C07F60F93D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiJ0NiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbiJ0Nhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:37:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6161814A6;
        Thu, 27 Oct 2022 06:37:49 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RDKUSF027366;
        Thu, 27 Oct 2022 13:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Ejl5T5rkkQKY1oA+EH7MPZdTTOrGhLrVrHhBB8NLPaA=;
 b=PglINzJXYiVe4F0ZW5eltGBfoTy1FGILlDJT/TPmADIpuFVzFG9ory5HMOoQG4G+lflc
 J03o+a2kpPaZ8vmdVokQTiVepwiUU8efaorgPUSHJkFuekCiaLXJFfAh4m3v65er1x7m
 uiwTvURLb8LRpkqVdmeMfK+xST4jgxrc3cqWG0F6jfU4zp/3jxST60KysftUHjrsc1SD
 RufzTTiCAx1EM9NcbPz/TBqjuxzx2iTLR7jUzN6GrlwvGHpJmm6PtbM5kjKqpgz8ULad
 xdR5cxJ+gpaDSxTWo7G2LPzl3L/q6xOyb7VzYFefogUtE3KwpoBUsbHNmUzOhFOAnukx 3A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kftspgj1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 13:37:33 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29RDKJAa015026;
        Thu, 27 Oct 2022 13:36:01 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3kfahd1dcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 13:36:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29RDZwEV64094482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 13:35:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18F0E11C04A;
        Thu, 27 Oct 2022 13:35:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E06911C050;
        Thu, 27 Oct 2022 13:35:57 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Oct 2022 13:35:57 +0000 (GMT)
Message-ID: <c98fa11d4efa86ca676a9d164893db8af8ab3693.camel@linux.ibm.com>
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
Date:   Thu, 27 Oct 2022 15:35:57 +0200
In-Reply-To: <Y1p/7YS338ghykGz@nvidia.com>
References: <Y0/lMCQ8oeXJ2HTg@nvidia.com>
         <f3551bb461b3ef3cfc1a0c644093816be1835b3f.camel@linux.ibm.com>
         <Y1ErcEe82yjJI+ET@nvidia.com>
         <68d91d7a5aadbd46dc34470eccd6b86a84c9e47b.camel@linux.ibm.com>
         <Y1KgX8EwH8T+FgWC@nvidia.com>
         <89a748fb5caee8be5d91806aa5dfd131e92d5d82.camel@linux.ibm.com>
         <Y1K1AqVWEyY0/Uqy@nvidia.com>
         <cef734b9f9b33380c1bbff40b56bb67b3de29341.camel@linux.ibm.com>
         <Y1a8qM4c2ZAM9glJ@nvidia.com>
         <3c2249fc7abf481b15d4988c2bd6456c48154c44.camel@linux.ibm.com>
         <Y1p/7YS338ghykGz@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4UEH8TwDmXoB9rlck4hFIklWCJOZ7Bvu
X-Proofpoint-GUID: 4UEH8TwDmXoB9rlck4hFIklWCJOZ7Bvu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-27 at 09:56 -0300, Jason Gunthorpe wrote:
> On Thu, Oct 27, 2022 at 02:44:49PM +0200, Niklas Schnelle wrote:
> > On Mon, 2022-10-24 at 13:26 -0300, Jason Gunthorpe wrote:
> > > On Mon, Oct 24, 2022 at 05:22:24PM +0200, Niklas Schnelle wrote:
> > > 
> > > > Thanks for the explanation, still would like to grok this a bit more if
> > > > you don't mind. If I do read things correctly synchronize_rcu() should
> > > > run in the conext of the VFIO ioctl in this case and shouldn't block
> > > > anything else in the kernel, correct? At least that's how I understand
> > > > the synchronize_rcu() comments and the fact that e.g.
> > > > net/vmw_vsock/virtio_transport.c:virtio_vsock_remove() also does a
> > > > synchronize_rcu() and can be triggered from user-space too.
> > > 
> > > Yes, but I wouldn't look in the kernel to understand if things are OK
> > >  
> > > > So we're
> > > > more worried about user-space getting slowed down rather than a Denial-
> > > > of-Service against other kernel tasks.
> > > 
> > > Yes, functionally it is OK, but for something like vfio with vIOMMU
> > > you could be looking at several domains that have to be detached
> > > sequentially and with grace periods > 1s you can reach multiple
> > > seconds to complete something like a close() system call. Generally it
> > > should be weighed carefully
> > > 
> > > Jason
> > 
> > Thanks for the detailed explanation. Then let's not put a
> > synchronize_rcu() in detach, as I said as long as the I/O translation
> > tables are there an IOTLB flush after zpci_unregister_ioat() should
> > result in an ignorable error. That said, I think if we don't have the
> > synchronize_rcu() in detach we need it in s390_domain_free() before
> > freeing the I/O translation tables.
> 
> Yes, it would be appropriate to free those using one of the rcu
> free'rs, (eg kfree_rcu) not synchronize_rcu()
> 
> Jason

They are allocated via kmem_cache_alloc() from caches shared by all
IOMMU's so can't use kfree_rcu() directly. Also we're only freeing the
entire I/O translation table of one IOMMU at once after it is not used
anymore. Before that it is only grown. So I think synchronize_rcu() is
the obvious and simple choice since we only need one grace period.

