Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7486999D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBPQV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBPQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:21:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB24A5DD;
        Thu, 16 Feb 2023 08:21:55 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GEMwAY033903;
        Thu, 16 Feb 2023 16:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vhvQd1wNetEKT30I30i5O1b+GpLLHgl74WlgyXtRCtg=;
 b=Tzj5Z6Vl2KE1duDgOzsrtmdSpM3WGFtU4CnwHhqYtCdNaHOybbFdQqDaNsVNRbSBUWUa
 VPDQqSmKKraImAF1j9Cl+A6G2q0GTX0dCGlFUVkdQLb6Ni1U/iaZb7u3a6R6YuMohxmG
 OdeI3I+eSUHbIhzD1sEHBrsytLSDYbaGzG/+qiWPLVwt+eQJGf4sIsMhksammW4zIlI1
 V25aH+ws0lnlOBZz8jdx2QBwivdW0OjEyjLQz2MtCdFJblWWCvQLRI+QnLbwxchs3f+L
 iXlny4DU+RvY75arv0zBi5uzwSY7cPKbqm6qunzoZL5XllzM31flltr1lmVXILz3ceme Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsp6v377p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 16:21:29 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31GG7bJd036992;
        Thu, 16 Feb 2023 16:21:29 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsp6v376j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 16:21:28 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31GFRm5B002747;
        Thu, 16 Feb 2023 16:21:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3np2n6d2vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 16:21:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31GGLMSS46596382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 16:21:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AC2220040;
        Thu, 16 Feb 2023 16:21:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBE642004D;
        Thu, 16 Feb 2023 16:21:21 +0000 (GMT)
Received: from [9.179.9.244] (unknown [9.179.9.244])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Feb 2023 16:21:21 +0000 (GMT)
Message-ID: <9bb1154b07dc21e5d3dda8cc5238c5385f32c2e0.camel@linux.ibm.com>
Subject: Re: [PATCH v4 09/16] s390: mm: Convert to GENERIC_IOREMAP
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        christophe.leroy@csgroup.eu, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, arnd@arndb.de,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Date:   Thu, 16 Feb 2023 17:21:21 +0100
In-Reply-To: <20230216123419.461016-10-bhe@redhat.com>
References: <20230216123419.461016-1-bhe@redhat.com>
         <20230216123419.461016-10-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9xO_MywEeQpNO1MwfUJY1z_LUXf6-KBN
X-Proofpoint-ORIG-GUID: J6qgyDyHBYSAhlv6qk0SA4JUog3pF7Uk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_12,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxlogscore=811
 clxscore=1011 lowpriorityscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-16 at 20:34 +0800, Baoquan He wrote:
> By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> and iounmap() are all visible and available to arch. Arch needs to
> provide wrapper functions to override the generic versions if there's
> arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> This change will simplify implementation by removing duplicated codes
> with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> functioality as before.
>=20
> Here, add wrapper functions ioremap_prot() and iounmap() for s390's
> special operation when ioremap() and iounmap().
>=20
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/Kconfig          |  1 +
>  arch/s390/include/asm/io.h | 21 ++++++++------
>  arch/s390/pci/pci.c        | 57 +++++++-------------------------------
>  3 files changed, 23 insertions(+), 56 deletions(-)

Thanks for the patch. This is a very clear improvement for us! I tested
this series with s390 systems with and without the PCI memory-I/O (MIO)
support and everything works as expected.

One thing I did stumble upon but which is independent from this patch
is that I think memremap(=E2=80=A6, MEMREMAP_WB) on system RAM outside the
direct map is broken for us. At least on systems without PCI memory-I/O
support. I think with this series it would be much easier to fix
though. Basically I think we would have to define arch_memremap_wb() to
generic_ioremap_prot(=E2=80=A6, PAGE_KERNEL) and then have iounmap() check
is_ioremap_addr() to see if it is an actual mapping or an address
cookie. But again this is independent of this patch which doesn't
change the behavior in this area.

So feel free to add my:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>


