Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E12E5F6A70
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiJFPUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJFPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:20:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A532E680;
        Thu,  6 Oct 2022 08:20:06 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296FBflA027896;
        Thu, 6 Oct 2022 15:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=eZiA54aRlMbtpv8H5Z5wcgdJ2SL/z+gGK6ArGLwXWt4=;
 b=JAXGUNOQZlIOC+wm8afsn4zTRut2LyptMaNYFvtja9Q2urElyyIA2IgsLnJBRLuZdhrh
 C4OU2vEsIY0fFaETI2wqCTtp/jLaqj1TFlCWtes6mzRWD9ASzlzTZa1Su7qGZMQtuEex
 /GABzmWGVJdRPtW4fvpF2c7SkTrkPdvu9VkqfZLFqpUJfXAcTGTDqqdC5v2cmbeQo0mZ
 N/x8S/f362AjcLwMTDv4swQLGaz17Fhft80dwZ/8LLUozFct/4+VRriBrDb8no4n7Ntu
 R1MYvI/JFkUjM3s/cgA/R4IPRdTO4DgcV4h2m0MobyFE2UNWoBR4oLFcN5DjJ8zWkDVK cQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k20p8210x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 15:19:51 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296FBZ84016601;
        Thu, 6 Oct 2022 15:19:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3jxd68wcfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 15:19:49 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 296FJkeu36241828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 15:19:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F4B2AE051;
        Thu,  6 Oct 2022 15:19:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AFBBAE055;
        Thu,  6 Oct 2022 15:19:45 +0000 (GMT)
Received: from sig-9-145-19-232.uk.ibm.com (unknown [9.145.19.232])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Oct 2022 15:19:45 +0000 (GMT)
Message-ID: <77295c8fea08907d82363dedc9ba01b79ac702a2.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/6] iommu/s390: Get rid of s390_domain_device
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Date:   Thu, 06 Oct 2022 17:19:44 +0200
In-Reply-To: <20221006144700.3380098-3-schnelle@linux.ibm.com>
References: <20221006144700.3380098-1-schnelle@linux.ibm.com>
         <20221006144700.3380098-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oiOoXyHRlWU-P_NOGXLM3Q9pbpXGHmIo
X-Proofpoint-ORIG-GUID: oiOoXyHRlWU-P_NOGXLM3Q9pbpXGHmIo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_02,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=698 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-06 at 16:46 +0200, Niklas Schnelle wrote:
> The struct s390_domain_device serves the sole purpose as list entry for
> the devices list of a struct s390_domain. As it contains no additional
> information besides a list_head and a pointer to the struct zpci_dev we
> can simplify things and just thread the device list through struct
> zpci_dev directly. This removes the need to allocate during domain
> attach and gets rid of one level of indirection during mapping
> operations.
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

@Jason, on second thought not sure if your R-b still holds as you only
implied that the zpci_unregister_ioat(), zdev->dma_table = NULL is okay
with the plan of ignoring zpci_register_ioat() fail on error in the
future (already have the patch).

> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h |  1 +
>  drivers/iommu/s390-iommu.c  | 37 +++++++------------------------------
>  2 files changed, 8 insertions(+), 30 deletions(-)
---8<---

