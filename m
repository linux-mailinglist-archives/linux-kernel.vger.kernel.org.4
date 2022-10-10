Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CC35FA092
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJJOy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJJOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:54:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDB947B9A;
        Mon, 10 Oct 2022 07:54:25 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AEdjPo031877;
        Mon, 10 Oct 2022 14:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=L7vbpjL0TMLWywl16FAWOBgRkWnzBIh7e3GJcuFmRn8=;
 b=T9N6pCRMuobg2WQBxUXWEBUhsp0LilMAJ7OQeV4nNEqSXaTEJzCOeo+aIuQfS37TxGIb
 Ag8q36ZcNDmklebYbABr4qcV6ym+ssmCcNpz3lSh+Rat4Jef49XiNrYWFULhPejJkHx9
 Hjuwq2WcO1nL+i5q6f7iRlC43W5Q0doWuadiIGVMSoQvu9iBtSXPvHn7VVdTxEjC7PPM
 IWL6WLgzXCx8bvtQeSelrsDHsJUrdX9NMVC+EKeDioaBP583DwINYknGttZd7qIsA2xD
 jM94sg+9BGCgMOYIOuZo7i/1fYweJUyjgm9E5cHqowZ3KN6DrxzcHYcuZrI82UPpobms 9g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k3k7vg5bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 14:54:13 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29AEoU25006762;
        Mon, 10 Oct 2022 14:54:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3k30u9ay09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 14:54:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29AEsdAM26345970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 14:54:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B570811C04C;
        Mon, 10 Oct 2022 14:54:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D83FD11C04A;
        Mon, 10 Oct 2022 14:54:07 +0000 (GMT)
Received: from sig-9-145-29-39.uk.ibm.com (unknown [9.145.29.39])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Oct 2022 14:54:07 +0000 (GMT)
Message-ID: <838e7df1128e52ac5229307dde6690c2e26b830c.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/6] iommu/s390: Fixes related to attach and aperture
 handling
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Date:   Mon, 10 Oct 2022 16:54:07 +0200
In-Reply-To: <20221007095005.2017126-1-schnelle@linux.ibm.com>
References: <20221007095005.2017126-1-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ynFaxQ0lwP8Ij8EpCgTLJPNZqCLUVEoP
X-Proofpoint-GUID: ynFaxQ0lwP8Ij8EpCgTLJPNZqCLUVEoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_08,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=871
 mlxscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-07 at 11:49 +0200, Niklas Schnelle wrote:
> Hi All,
> 
> This is v5 of a follow up to Matt's recent series[0] where he tackled
> a race that turned out to be outside of the s390 IOMMU driver itself as
> well as duplicate device attachments. After an internal discussion we came
> up with what I believe is a cleaner fix. Instead of actively checking for
> duplicates we instead detach from any previous domain on attach. From my
> cursory reading of the code this seems to be what the Intel IOMMU driver is
> doing as well.
> 
> Moreover we drop the attempt to re-attach the device to its previous IOMMU
> domain on failure. This was fragile, unlikely to help and unexpected for
> calling code. Thanks Jason for the suggestion.
> 
> We can also get rid of struct s390_domain_device entirely if we instead
> thread the list through the attached struct zpci_devs. This saves us from
> having to allocate during attach and gets rid of one level of indirection
> during IOMMU operations.
> 
> Additionally 3 more fixes have been added in v3 that weren't in v2 of this
> series. One is for a potential situation where the aperture of a domain
> could shrink and leave invalid translations. The next one fixes an off by
> one in checking validity of an IOVA and the last one fixes a wrong value
> for pgsize_bitmap.
> 
> In v4 we also add a patch changing to the map_pages()/unmap_pages()
> interface in order to prevent a performance regression due to the
> pgsize_bitmap change.
> 
> *Note*:
> This series is against the s390 features branch[1] which already contains
> the bus_next field removal that was part of v2.
> 
> It is also available as branch iommu_fixes_v6 with the GPG signed tag
> s390_iommu_fixes_v5 on my niks/linux.git on git.kernel.org[2].
> 
> *Open Question*:
> Which tree should this go via?

The conflicting commit that removed the bus_next field from struct
zpci_dev has now made it into Linus' tree via the s390 pull. So this
series now applies cleanly on mainline master. Still not sure though
which tree this would best go into.

> 
> Best regards,
> Niklas
> 
> 
---8<---


