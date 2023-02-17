Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF4F69AFAF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjBQPlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBQPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:41:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D41853EE0;
        Fri, 17 Feb 2023 07:41:17 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HE0Q8M007416;
        Fri, 17 Feb 2023 15:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=upZd3zYrzgxVerfACG+KEJRFWTNoz6sv548mjj6lHZ4=;
 b=PNF9k8ouRNE4MgUjHfxrjGFD8gOJpEoEdwVBXTWQOBbwac/HtjyUVLMHVIBxVj27NL1r
 D3Wv59kGQzKXdII8YipZslmlz8/jJiW+LPkIJeEH+gdrzTscB/UbwdW+BgUXgF7Kk3pN
 nKyvVGE1uhWPB2IqCEaAsFQgqpt5/LuL5Vq5BVNRqvRkl1+3QeY2BMjAn+rkqd7CtXov
 UsOtjxZQ7ZC2r21rNyDC0fM3CD2QXl/PfBHvZLKvxDSaacsT3tGdwzAnqXjQkm1xA6ln
 cRpBcARAm5azsRVaC2jKNnHJPx8L4maoTwOc0xCVg96J1BAo56jNiOKX9cF4oMpcLFCQ gQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nt0518fey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 15:41:07 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31HCGQu7017665;
        Fri, 17 Feb 2023 15:41:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6r6hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 15:41:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HFf0f146465452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 15:41:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C696C2004B;
        Fri, 17 Feb 2023 15:41:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 897C420043;
        Fri, 17 Feb 2023 15:40:59 +0000 (GMT)
Received: from [9.171.12.102] (unknown [9.171.12.102])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 15:40:59 +0000 (GMT)
Message-ID: <3618028df347d352ca6b3be306c1a21d74899298.camel@linux.ibm.com>
Subject: Re: [PATCH v6 6/6] iommu/dma: Make flush queue sizes and timeout
 driver configurable
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Fri, 17 Feb 2023 16:40:59 +0100
In-Reply-To: <bc234db3-f4c9-ff5a-6c19-699c50514fc5@linux.ibm.com>
References: <20230215120327.947336-1-schnelle@linux.ibm.com>
         <20230215120327.947336-7-schnelle@linux.ibm.com>
         <bc234db3-f4c9-ff5a-6c19-699c50514fc5@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ETGxnrCbnHEfk8L7f11SKxsfCoCKH-2Z
X-Proofpoint-ORIG-GUID: ETGxnrCbnHEfk8L7f11SKxsfCoCKH-2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_10,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-02-17 at 09:41 -0500, Matthew Rosato wrote:
> On 2/15/23 7:03 AM, Niklas Schnelle wrote:
> > Flush queues currently use a fixed compile time size of 256 entries.
> > This being a power of 2 allows the compiler to use shift and mask
> > instead of more expensive modulo operations. With per-CPU flush queues
> > larger queue sizes would hit per-CPU allocation limits, with a single
> > flush queue these limits do not apply however. Also with single queues
> > being particularly suitable for virtualized environments with expensive
> > IOTLB flushes these benefit especially from larger queues and thus fewe=
r
> > flushes.
> >=20
> > To this end re-order struct iova_fq so we can use a dynamic array and
> > introduce the flush queue size and timeouts as new options in the
> > dma_iommu_options struct. So as not to lose the shift and mask
> > optimization, check that the variable length is a power of 2 and use
> > explicit shift and mask instead of letting the compiler optimize this.
> >=20
> > In the s390 IOMMU driver a large fixed queue size and timeout is then
> > set together with single queue mode bringing its performance on s390
> > paged memory guests on par with the previous s390 specific DMA API
> > implementation.
> >=20
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com> #s390
>=20
> > +#define S390_IOMMU_SINGLE_FQ_SIZE      32768
> > +#define S390_IOMMU_SINGLE_FQ_TIMEOUT   1000
> > +
>=20
> One question about these values however, was there a rationale to choosin=
g these particular numbers (anything worth documenting?) or were they were =
simply chosen because they showed similar characteristics to the previous D=
MA approach?  I'm mostly wondering if it's worth experimenting with other v=
alues here in the future to see what kind of impact it would have.
>=20

For the flush queue size, which has to be a power of two, I basically
picked the smallest value that gave me similar performance under z/VM
as prior to the conversion. Somewhat similar for the timeout though I
tried only a dozen "nice" values. Since the timeout basically
determines how long a rogue PCI device could potentially access old
data I found that 1 second is also kind of easy to explain. But yes
these could still be tuned in the future.

Thanks,
Niklas
