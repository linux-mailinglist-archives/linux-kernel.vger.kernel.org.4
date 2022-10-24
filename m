Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D613960B4E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiJXSGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiJXSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:05:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B467207536;
        Mon, 24 Oct 2022 09:46:26 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OEil0V002495;
        Mon, 24 Oct 2022 15:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ywjlx7En7hrOI9jtp8swXThSGQ7BEBtIXpHsTRDCUho=;
 b=bYAj6xGM4ZHkEhI8eVYt/TRNlnXGJgs1ptRDMugHjtDxNZkllU8IPkeZHzVtFYUSHeRW
 jCQWnUc5jGSnehWKEQG1SgmoBXf2vdt2apTvb7n+b8Ul48CQ1gKFSNVg7NencYYzT3+P
 PDNjA1eocGFRf9eMhiuy18Q16ZiC/PgtcpJMa7qPaO3MlRju/mYQNBiPwyTxRjAMGeXg
 OEZvikTcxNlhdCLPzQtEmweaePyyaaHlRuW1Mr7CFaoWAoCjz56tz4rkJiqwxg/dT4Uj
 DaEQkBcMhInz28tEJDQ9u40zIjZzJhcwXychRaRfK8zsUwygnlNVzh6JayNWglwBdNbp ng== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kdvqy1n3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 15:22:31 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29OFK0JD017125;
        Mon, 24 Oct 2022 15:22:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3kc8592ng1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 15:22:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29OFMPa53932822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 15:22:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8675A4040;
        Mon, 24 Oct 2022 15:22:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E339DA404D;
        Mon, 24 Oct 2022 15:22:24 +0000 (GMT)
Received: from sig-9-145-54-55.uk.ibm.com (unknown [9.145.54.55])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Oct 2022 15:22:24 +0000 (GMT)
Message-ID: <cef734b9f9b33380c1bbff40b56bb67b3de29341.camel@linux.ibm.com>
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
Date:   Mon, 24 Oct 2022 17:22:24 +0200
In-Reply-To: <Y1K1AqVWEyY0/Uqy@nvidia.com>
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
         <20221018145132.998866-4-schnelle@linux.ibm.com>
         <Y07Dz/NROAMI0Hku@nvidia.com>
         <8e268ab5e0dadf86be5fd7ffaa9debb76cea67f3.camel@linux.ibm.com>
         <Y0/lMCQ8oeXJ2HTg@nvidia.com>
         <f3551bb461b3ef3cfc1a0c644093816be1835b3f.camel@linux.ibm.com>
         <Y1ErcEe82yjJI+ET@nvidia.com>
         <68d91d7a5aadbd46dc34470eccd6b86a84c9e47b.camel@linux.ibm.com>
         <Y1KgX8EwH8T+FgWC@nvidia.com>
         <89a748fb5caee8be5d91806aa5dfd131e92d5d82.camel@linux.ibm.com>
         <Y1K1AqVWEyY0/Uqy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lw1Hu8Aw0zgdGtMDBxJc8w4O9v6C398v
X-Proofpoint-GUID: Lw1Hu8Aw0zgdGtMDBxJc8w4O9v6C398v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=943 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-21 at 12:04 -0300, Jason Gunthorpe wrote:
> On Fri, Oct 21, 2022 at 05:01:32PM +0200, Niklas Schnelle wrote:
> > On Fri, 2022-10-21 at 10:36 -0300, Jason Gunthorpe wrote:
> > > On Fri, Oct 21, 2022 at 02:08:02PM +0200, Niklas Schnelle wrote:
> > > > On Thu, 2022-10-20 at 08:05 -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Oct 20, 2022 at 10:51:10AM +0200, Niklas Schnelle wrote:
> > > > > 
> > > > > > Ok that makes sense thanks for the explanation. So yes my assessment is
> > > > > > still that in this situation the IOTLB flush is architected to return
> > > > > > an error that we can ignore. Not the most elegant I admit but at least
> > > > > > it's simple. Alternatively I guess we could use call_rcu() to do the
> > > > > > zpci_unregister_ioat() but I'm not sure how to then make sure that a
> > > > > > subsequent zpci_register_ioat() only happens after that without adding
> > > > > > too much more logic.
> > > > > 
> > > > > This won't work either as the domain could have been freed before the
> > > > > call_rcu() happens, the domain needs to be detached synchronously
> > > > > 
> > > > > Jason
> > > > 
> > > > Yeah right, that is basically the same issue I was thinking of for a
> > > > subsequent zpci_register_ioat(). What about the obvious one. Just call
> > > > synchronize_rcu() before zpci_unregister_ioat()?
> > > 
> > > Ah, it can be done, but be prepared to wait >> 1s for synchronize_rcu
> > > to complete in some cases.
> > > 
> > > What you have seems like it could be OK, just deal with the ugly racy
> > > failure
> > > 
> > > Jason
> > 
> > I'd tend to go with synchronize_rcu(). It won't leave us with spurious
> > error logs for the failed IOTLB flushes and as you said one expects
> > detach to be synchronous. I don't think waiting in it will be a
> > problem. But this is definitely something you're more of an expert on
> > so I'll trust your judgement. Looking at other callers of
> > synchronize_rcu() quite a few of them look to be in similar
> > detach/release kind of situations though not sure how frequent and
> > performance critical IOMMU domain detaching is in comparison.
> 
> I would not do it on domain detaching, that is something triggered by
> userspace through VFIO and it could theoritically happen alot, eg in
> vIOMMU scenarios.
> 
> Jason

Thanks for the explanation, still would like to grok this a bit more if
you don't mind. If I do read things correctly synchronize_rcu() should
run in the conext of the VFIO ioctl in this case and shouldn't block
anything else in the kernel, correct? At least that's how I understand
the synchronize_rcu() comments and the fact that e.g.
net/vmw_vsock/virtio_transport.c:virtio_vsock_remove() also does a
synchronize_rcu() and can be triggered from user-space too.

So we're
more worried about user-space getting slowed down rather than a Denial-
of-Service against other kernel tasks.

