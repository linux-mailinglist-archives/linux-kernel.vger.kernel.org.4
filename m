Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6E55F672E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJFNDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiJFNCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:02:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED1A6C01;
        Thu,  6 Oct 2022 06:02:22 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296BnjqG017904;
        Thu, 6 Oct 2022 13:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UFR2sdDt/j5+oNNRSvNCI8h05wltbRPFBwZm3eBdysw=;
 b=rFTK86QFVYK7fbq5pbsQpwe1aZQOScpwqdUtO9+7PPJWJ2k7WmbCa5LT7dJzEu0zNaRe
 fD1UESoIMaP7aZadsb6AG3IyaHdwPcgoDt6WOVg834weRrtv6k/Q3iL2axBs0hlDcqcC
 g6tuh+NfsxL6eR4LiKTeblwEWeWnPlrCC11VlAXxJWYzg1YIuylATFqg7YTFiEcGKBBo
 KQgQBO42ewwJPKKYXYSxhV8/RI62gKhfbSc5pdxGene27mkDo4k7D5CB2xhEwwp/Azai
 +1q49R1kVNQzmrAyIpt/I/ieSaUzTgyOzGo90elvNp2pRX/k4+vQazcq0RJhC5k1Ou0v 8Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1xg5t484-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 13:02:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296CqF5q023424;
        Thu, 6 Oct 2022 13:02:03 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3jxd6972qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 13:02:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 296D20cx11534842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 13:02:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36722AE045;
        Thu,  6 Oct 2022 13:02:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 705DBAE053;
        Thu,  6 Oct 2022 13:01:59 +0000 (GMT)
Received: from sig-9-145-19-232.uk.ibm.com (unknown [9.145.19.232])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Oct 2022 13:01:59 +0000 (GMT)
Message-ID: <2488828cfdd54cd15b2fecbbc021aaf69228f0c3.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/5] iommu/s390: Fix duplicate domain attachments
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Date:   Thu, 06 Oct 2022 15:01:59 +0200
In-Reply-To: <Yz7Dzayee74Mu4NH@nvidia.com>
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
         <20221004120706.2957492-2-schnelle@linux.ibm.com>
         <2a56d7bc-3beb-51fe-fc65-f2f3bd192e34@linux.ibm.com>
         <dd92817a13601a4a449096b7ae94caa66a113853.camel@linux.ibm.com>
         <Yz1vF7B0FLvLVvE0@nvidia.com>
         <8c01ad419e91c0ce06bec8700d960c57f1a7c436.camel@linux.ibm.com>
         <Yz7Dzayee74Mu4NH@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ARk-GIeNEsZJI0f2eY1Myl3PrhzRB67D
X-Proofpoint-GUID: ARk-GIeNEsZJI0f2eY1Myl3PrhzRB67D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_02,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=433
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-06 at 09:02 -0300, Jason Gunthorpe wrote:
> On Thu, Oct 06, 2022 at 01:52:44PM +0200, Niklas Schnelle wrote:
> 
> > One option I see would be to ignore the error return from
> > zpci_register_ioat() if it indicates case 2b. Then we would still add
> > the device to the IOMMU's devices list and return success despite
> > knowing that the device is inaccessible (DMA and MMIO blocked).
> > 
> > Then the recovery/reset code will register the new domain once the
> > device comes out of the error state. At least from an IOMMU API point
> > of view that would make the attachment always succeed for all
> > zpci_register_ioat() error cases that aren't programming bugs and can
> > conceivably be recovered from.
> 
> This is what I was thinking..
> 
> > If you agree I would propose adding this as a robustness improvement as
> > part of my upcoming series of IOMMU improvements needed for the DMA API
> > conversion. As stated above before the DMA API conversion any error
> > that would cause zpci_register_ioat() to fail while the IOMMU API is
> > being used will need a "power cycle" anyway so postponing this doesn't
> > hurt.
> 
> Yes, I think this series is fine as is
> 
> Patch 4 mostly deletes all these error cases, and the one hunk that is left:
> 
> +	if (domain->geometry.aperture_start > zdev->end_dma ||
> +	    domain->geometry.aperture_end < zdev->start_dma)
> +		return -EINVAL;
> 
> Is misplaced. If a device cannot be supported by the IOMMU, which is
> what that is really saying since it only s390 creates one aperture
> size, then it should fail to probe, not fail at attach.
> 
> So I'd change the above to a WARN_ON() for future safety and add a
> similar test to probe and then all that is left is the
> zpci_register_ioat() which you have a plan for.
> 
> Jason
>  

Sounds good will do a v5 anyway to add the map_pages()/unmap_pages().

