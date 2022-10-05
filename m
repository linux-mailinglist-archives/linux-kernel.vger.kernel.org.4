Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D722F5F5319
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJELEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJELD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:03:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE9E77E9B;
        Wed,  5 Oct 2022 04:03:50 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2958qPcR020832;
        Wed, 5 Oct 2022 11:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+mYGFIRKQdUCBWFR+Fyy7VoH7jwpQQOKiTdQo2jNTxI=;
 b=FvH87cl2h0l5HLCRhoMnsat267RpZim8om4EXdEFTiTr9BO0Lb0Gii3Pb3GTl+S+/jCM
 QGlA/IqXhJAQ4/pwVe+oB3aGjad+8z610kTQ8DY7bWtZHfg3swJFFzJgJx8A+TwILbtx
 g4HifRZ+lI2oq7WtNXWMZmthmQ6EloOAkFjU+lxHj6C3jZILLBjJzIvLzmLEAMiz8P6Z
 puqTksSsPtpWtH0mY4XRlRytt6m7cNQ0e97akEiewx63Vte96ZtGKjH3h9ZgHKoUrkQT
 Vi+Xur1OyPdvevjg8x+CvqkjGnaMQ/dV3hc24FowQZvT70MeRrDZbKQ3gXaESxGCeRcD /Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k14et6sj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 11:03:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 295AoFZF024397;
        Wed, 5 Oct 2022 11:03:35 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3jxd695f8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 11:03:35 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 295B42cM52101496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Oct 2022 11:04:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ADF1A405B;
        Wed,  5 Oct 2022 11:03:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E7B1A4059;
        Wed,  5 Oct 2022 11:03:32 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Oct 2022 11:03:32 +0000 (GMT)
Message-ID: <a9994ee0e97457965a2dd2b5e9795f0fde5bc466.camel@linux.ibm.com>
Subject: Re: [PATCH v4 5/5] iommu/s390: Fix incorrect pgsize_bitmap
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        jgg@nvidia.com, linux-kernel@vger.kernel.org
Date:   Wed, 05 Oct 2022 13:03:31 +0200
In-Reply-To: <ce73a798-c2e4-7d2f-1c2e-854170ea0b59@arm.com>
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
         <20221004120706.2957492-6-schnelle@linux.ibm.com>
         <eb1955e4-a618-ebf0-562d-17f9dd58b0da@arm.com>
         <b3c6fd2b-74d4-91d7-dc53-ba526c41b067@linux.ibm.com>
         <a02a3cee-773a-da00-616f-04652c0905ce@arm.com>
         <0da03411190c004e85cc856965b0aca901fd78fb.camel@linux.ibm.com>
         <ce73a798-c2e4-7d2f-1c2e-854170ea0b59@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zsg0W-JMzeP-X056nGTdArOUhGxjiy43
X-Proofpoint-ORIG-GUID: zsg0W-JMzeP-X056nGTdArOUhGxjiy43
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_01,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210050070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-05 at 10:53 +0100, Robin Murphy wrote:
> On 2022-10-04 17:13, Niklas Schnelle wrote:
> > On Tue, 2022-10-04 at 16:31 +0100, Robin Murphy wrote:
> > > On 2022-10-04 16:12, Matthew Rosato wrote:
> > > > On 10/4/22 11:02 AM, Robin Murphy wrote:
> > > > > On 2022-10-04 13:07, Niklas Schnelle wrote:
> > > > > > The .pgsize_bitmap property of struct iommu_ops is not a page mask but
> > > > > > rather has a bit set for each size of pages the IOMMU supports. As the
> > > > > > comment correctly pointed out at this moment the code only support 4K
> > > > > > pages so simply use SZ_4K here.
> > > > > 
> > > > > Unless it's already been done somewhere else, you'll want to switch over to the {map,unmap}_pages() interfaces as well to avoid taking a hit on efficiency here. The "page mask" thing was an old hack to trick the core API into making fewer map/unmap calls where the driver could map arbitrary numbers of pages at once anyway. The multi-page interfaces now do that more honestly and generally better (since they work for non-power-of-two sizes as well).
> > > > 
> > > > Thanks for the heads up -- Niklas has some additional series coming soon as described here:
> > > > 
> > > > https://lore.kernel.org/linux-iommu/a10424adbe01a0fd40372cbd0736d11e517951a1.camel@linux.ibm.com/
> > > > 
> > > > So implementing the _pages() interfaces is soon up on the roadmap.  But given what you say I wonder if this patch should just wait until the series that implements {map,unmap}_pages().
> > > 
> > > Perhaps, although the full change should be trivial enough that there's
> > > probably just as much argument for doing the whole thing in its own
> > > right for the sake of this cleanup. The main point is that
> > > S390_IOMMU_PGSIZES is not incorrect as such, it's just not spelling out
> > > the deliberate trick that it's achieving - everyone copied it from
> > > intel-iommu, but since that got converted to the new interfaces the
> > > original explanation is now gone. The only effect of "fixing" it in
> > > isolation right now will be to make large VFIO mappings slower.
> > > 
> > > Robin.
> > 
> > The patch changing to map_pages()/unmap_pages() is currently part of a
> > larger series of improvements, some of which are less trivial. So I'm
> > planning to send those as RFC first. Those include changing the
> > spin_lock protected list to RCU so the map/unmap can paralellize
> > better. Another one is atomic updates to the IOMMU tables to do away
> > with locks in map/unmap. So I think pulling that whole
> > series into this one isn't ideal. I could pull just the
> > map_pages()/unmap_pages() change though.
> 
> Yeah, literally just updating the s390_iommu_{map,unmap} function 
> prototypes and replacing "size" with "pgsize * count" within is all 
> that's needed to clean up this hack properly. That can (and probably 
> should) be completely independent of other improvements deeper down.
> 
> Thanks,
> Robin.
> 

Pretty much, it's a bit cleaner to slightly change
s390_iommu_update_trans() to take pgcount as argument since that
currently calculates the pgcount from the size anyway which is
redundant if we have a pgcount already but that's redudant if we have
the pgcount already. But yes it's all pretty simple and I reordered
things for v5 already.

Speaking of v5, if that were the final form, what do you think would be
the best tree to take it? Except for patch 1 they depend on the removal
of the bus_next field in struct zpci_dev. That commit is not yet in
Linus' tree but already in the s390 feature branch on git.kernel.org so
if these changes were to go via the s390 tree that would be taken care
of. Otherwise one would have to merge that tree first. Or as an
alternative I also have a kernel.org account and can provide this
series as a GPG signed branch based on the s390 tree.

