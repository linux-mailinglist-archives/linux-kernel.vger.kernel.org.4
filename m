Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA1A5FC154
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJLHi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJLHiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:38:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DE42642;
        Wed, 12 Oct 2022 00:38:23 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C6gY90007048;
        Wed, 12 Oct 2022 07:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+E3WNqbZSjRYc1ZlLiUkCIoqj0aLrerAjucEDmI+m2Q=;
 b=IOx5PnHAY2IeYxoRwFjF5+JkKBsDNC9/zIgTKiCAuFpnFXAdqFrZtKWKrl8Xj0C4CodF
 uaDJK+gOTqSlKBVzN/y4lv+5mQEd/LwekibJIRNRpCW4eEbD+5PxBH385kIg0zk7g0zj
 tJ5wGQSwnBOGLnMJ+KTCpp2J8Vt8108DItwJwIhcmi6lPO2fo9hgsbiz98S05Da7E8cI
 x4YfSHsLEr6nIF+ZZvlZ47WqVDwLDK7b8X2mcQFVYGlJyzkPsg1kzKfoF+3tw349LOoF
 SLVX/LezlSKopf1bGr/Gr0IJDoDIXk8qp5v3FaEROV+/rAW/W6s5JLNWL6gj/AzHdOZU EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k5rhthhhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 07:37:56 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29C6nIhb034809;
        Wed, 12 Oct 2022 07:37:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k5rhthhgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 07:37:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29C7b0cC027637;
        Wed, 12 Oct 2022 07:37:53 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3k30u9dkq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 07:37:52 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29C7bnpH3146384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 07:37:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBE72AE055;
        Wed, 12 Oct 2022 07:37:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55C72AE04D;
        Wed, 12 Oct 2022 07:37:49 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Oct 2022 07:37:49 +0000 (GMT)
Message-ID: <d78edb587ecda0aa09ba80446d0f1883e391996d.camel@linux.ibm.com>
Subject: Re: [PATCH v3 09/11] s390: mm: Convert to GENERIC_IOREMAP
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, David.Laight@aculab.com,
        shorne@gmail.com, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Date:   Wed, 12 Oct 2022 09:37:49 +0200
In-Reply-To: <Y0ZWBMKKIuf5Q+qk@MiWiFi-R3L-srv>
References: <20221009103114.149036-1-bhe@redhat.com>
         <20221009103114.149036-10-bhe@redhat.com>
         <b6ac5c44917390b9a5cc7ebb87a089568279c459.camel@linux.ibm.com>
         <Y0ZWBMKKIuf5Q+qk@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tGd_NHM3wT8CGpgEF7oA0GaNhf8Dt6TG
X-Proofpoint-ORIG-GUID: PNzw5jxkI3PV-j1vBDPFqdCoo73CaWp7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_03,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210120049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-12 at 13:52 +0800, Baoquan He wrote:
> On 10/11/22 at 05:16pm, Niklas Schnelle wrote:
> > On Sun, 2022-10-09 at 18:31 +0800, Baoquan He wrote:
> > > By taking GENERIC_IOREMAP method, the generic ioremap_prot() and
> > > iounmap() are visible and available to arch. Arch only needs to
> > > provide implementation of arch_ioremap() or arch_iounmap() if there's
> > > arch specific handling needed in its ioremap() or iounmap(). This
> > > change will simplify implementation by removing duplicated codes with
> > > generic ioremap() and iounmap(), and has the equivalent functioality
> > > as before.
> > > 
> > > For s390, add hooks arch_ioremap() and arch_iounmap() for s390's special
> > > operation when ioremap() and iounmap(), then ioremap_[wc|wt]() are
> > > converted to use ioremap_prot() from GENERIC_IOREMAP.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> > > Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > > Cc: Heiko Carstens <hca@linux.ibm.com>
> > > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > > Cc: Sven Schnelle <svens@linux.ibm.com>
> > > Cc: linux-s390@vger.kernel.org
> > > ---
> > > v2->v3:
> > > - Add code comment inside arch_ioremap() to help uderstand the
> > >   obsucre code. Christoph suggested this, Niklas provided the
> > >   paragraph of text.
> > > 
> > >  arch/s390/Kconfig          |  1 +
> > >  arch/s390/include/asm/io.h | 25 +++++++++------
> > >  arch/s390/pci/pci.c        | 65 ++++++++------------------------------
> > >  3 files changed, 30 insertions(+), 61 deletions(-)
> > > 
> > > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > > index 318fce77601d..c59e1b25f59d 100644
> > > --- a/arch/s390/Kconfig
> > > +++ b/arch/s390/Kconfig
> > > @@ -135,6 +135,7 @@ config S390
> > >  	select GENERIC_SMP_IDLE_THREAD
> > >  	select GENERIC_TIME_VSYSCALL
> > >  	select GENERIC_VDSO_TIME_NS
> > > +	select GENERIC_IOREMAP
> > 
> > I think you should add the "if PCI" from the diff in your last mail to
> > this patch.
> 
> That's reasonable, will do.
> 
> The code change in driver should be posted separately to get reviewing
> from the relevant drvier maintainers. I may wrap it into this series in
> next post so that people know its background.

I agree about doing the driver change separately. Since the problem
already exists one could send it separately. If you want I can take of
that too.

> 
> > >  	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
> > >  	select HAVE_ARCH_AUDITSYSCALL
> > >  	select HAVE_ARCH_JUMP_LABEL
> ......
> > > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > > index 73cdc5539384..3c00dc7d79bc 100644
> > > --- a/arch/s390/pci/pci.c
> > > +++ b/arch/s390/pci/pci.c
> > > @@ -244,64 +244,25 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
> > >         zpci_memcpy_toio(to, from, count);
> > >  }
> > >  
> > > -static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
> > > +void __iomem *
> > > +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
> > >  {
> > > -	unsigned long offset, vaddr;
> > > -	struct vm_struct *area;
> > > -	phys_addr_t last_addr;
> > > -
> > > -	last_addr = addr + size - 1;
> > > -	if (!size || last_addr < addr)
> > > -		return NULL;
> > > -
> > > +	/*
> > > +	 * When PCI MIO instructions are unavailable the "physical" address
> > > +	 * encodes a hint for accessing the PCI memory space it represents.
> > > +	 * Just pass it unchanged such that ioread/iowrite can decode it.
> > > +	 */
> > >  	if (!static_branch_unlikely(&have_mio))
> > > -		return (void __iomem *) addr;
> > > -
> > > -	offset = addr & ~PAGE_MASK;
> > > -	addr &= PAGE_MASK;
> > > -	size = PAGE_ALIGN(size + offset);
> > > -	area = get_vm_area(size, VM_IOREMAP);
> > > -	if (!area)
> > > -		return NULL;
> > > -
> > > -	vaddr = (unsigned long) area->addr;
> > > -	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
> > > -		free_vm_area(area);
> > > -		return NULL;
> > > -	}
> > > -	return (void __iomem *) ((unsigned long) area->addr + offset);
> > > +		return (void __iomem *) *paddr;
> > 
> > nit: no space after the cast
> 
> Sorry, remember you pointed this out in v2, while I didn't get what
> it is. Could you be more specific or give the right line of code?
> 
> Are you suggesting below line? 
> 
> -	return (void __iomem *) ((unsigned long) area->addr + offset);
> +		return (void __iomem *)*paddr;

Yes, though I did just check and somehow checkpatch doesn't complain,
maybe because of the dereference. I do think I remember it complaining
but I guess if it doesn't you might as well keep it this way.

> 
> > > +	return NULL;
> > >  }
> > > 
---8<---


