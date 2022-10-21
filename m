Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97176076B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJUMJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJUMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:09:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5B42608E1;
        Fri, 21 Oct 2022 05:09:11 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LBhP7Z020693;
        Fri, 21 Oct 2022 12:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Ix1uBobI9o+Hwx9mkxSgwrjZvrcNBw5GmPYnoSmZC0g=;
 b=P1LKqhyU3TpGsKuM06Gy0Z0lzgC6pwAGAdNNfCkg9SmFoeUHab7+pLaI6WFyLv6yKBg9
 EZ9dyhn1VLPwHykJWwTCk0qmxDeuB+ZQ1bzACK1eqALwXX/Ee3JTwa8eVFdfAW1KOR6I
 6IfcfGVe0LwytkEzn33l8PUx3K1Xli0KjsT9wzX9YxPiQ31/OcWOlNrwObRUtvVIlAjx
 NpC7Ug2OpqZma7HlxrxWdDfMOvJdQeFXhRGdRjuVe+m8UNXX35DSDVAKfUAmjJQYGjV6
 VLmrZFvVvm4eck1RBc/XugjJgj/u23Bb9QxStJvUCea0ULL98OTWPxS6YrwvHmbNdUcM qA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kbtsx0u61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 12:08:54 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29LC5MVa022822;
        Fri, 21 Oct 2022 12:08:06 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3k7mg9ahwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 12:08:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29LC8bXV26673600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 12:08:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FB6BAE045;
        Fri, 21 Oct 2022 12:08:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EE4AAE04D;
        Fri, 21 Oct 2022 12:08:02 +0000 (GMT)
Received: from sig-9-145-0-12.uk.ibm.com (unknown [9.145.0.12])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Oct 2022 12:08:02 +0000 (GMT)
Message-ID: <68d91d7a5aadbd46dc34470eccd6b86a84c9e47b.camel@linux.ibm.com>
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
Date:   Fri, 21 Oct 2022 14:08:02 +0200
In-Reply-To: <Y1ErcEe82yjJI+ET@nvidia.com>
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
         <20221018145132.998866-4-schnelle@linux.ibm.com>
         <Y07Dz/NROAMI0Hku@nvidia.com>
         <8e268ab5e0dadf86be5fd7ffaa9debb76cea67f3.camel@linux.ibm.com>
         <Y0/lMCQ8oeXJ2HTg@nvidia.com>
         <f3551bb461b3ef3cfc1a0c644093816be1835b3f.camel@linux.ibm.com>
         <Y1ErcEe82yjJI+ET@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: klfKJ7beKJOkBDRPKCrx-JPXjTSQ4Qiz
X-Proofpoint-ORIG-GUID: klfKJ7beKJOkBDRPKCrx-JPXjTSQ4Qiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=952
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-20 at 08:05 -0300, Jason Gunthorpe wrote:
> On Thu, Oct 20, 2022 at 10:51:10AM +0200, Niklas Schnelle wrote:
> 
> > Ok that makes sense thanks for the explanation. So yes my assessment is
> > still that in this situation the IOTLB flush is architected to return
> > an error that we can ignore. Not the most elegant I admit but at least
> > it's simple. Alternatively I guess we could use call_rcu() to do the
> > zpci_unregister_ioat() but I'm not sure how to then make sure that a
> > subsequent zpci_register_ioat() only happens after that without adding
> > too much more logic.
> 
> This won't work either as the domain could have been freed before the
> call_rcu() happens, the domain needs to be detached synchronously
> 
> Jason

Yeah right, that is basically the same issue I was thinking of for a
subsequent zpci_register_ioat(). What about the obvious one. Just call
synchronize_rcu() before zpci_unregister_ioat()?

