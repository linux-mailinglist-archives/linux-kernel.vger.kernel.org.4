Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76705FB718
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJKP2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiJKP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:27:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312CAAC386;
        Tue, 11 Oct 2022 08:18:31 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BF7Kbb024309;
        Tue, 11 Oct 2022 15:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=aX4BDwGXtmjSFLoZblRZbyxfJQsKH9xJCvc0H0bEub0=;
 b=MHmO7yDiT5ElVYY2nc3w3My0jxZiHWk8QnObkUx+I/Sjnw2Sy0N1v3WFsLgUSNVZ70+v
 jqObBpKCSmf61KfBDB0J38BZ0Xh02dl3Gvs9YShxCTe6C5ssVtMEas2dTYQW6i85y4MG
 2bTmkttfWp7MJ+8J14zhCEv8ywzk/G82SmMPreK/LHtipe0xWU2lsYdrwShNzaiQ+Edv
 cR2EiaqfBOeouQa+X+truvMW1taOIQrVnXRaYvza/wKehEOfbLG5HpRSPX0/mCSAWyJC
 87/GkUT1XGQGPGkvkLu9uiIcSyCge3u7/nnhwDi8AlBBnB1i6a2INpnvCEET3eSxvN8Y 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k58t1n6d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 15:17:01 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29BF7qtn027496;
        Tue, 11 Oct 2022 15:17:01 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k58t1n6c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 15:17:01 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29BF6QRj015220;
        Tue, 11 Oct 2022 15:16:58 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3k30fjcnx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 15:16:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29BFGt1Z32768272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 15:16:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 899DFA405C;
        Tue, 11 Oct 2022 15:16:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CBACA405B;
        Tue, 11 Oct 2022 15:16:55 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Oct 2022 15:16:54 +0000 (GMT)
Message-ID: <b6ac5c44917390b9a5cc7ebb87a089568279c459.camel@linux.ibm.com>
Subject: Re: [PATCH v3 09/11] s390: mm: Convert to GENERIC_IOREMAP
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, David.Laight@ACULAB.COM,
        shorne@gmail.com, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Date:   Tue, 11 Oct 2022 17:16:54 +0200
In-Reply-To: <20221009103114.149036-10-bhe@redhat.com>
References: <20221009103114.149036-1-bhe@redhat.com>
         <20221009103114.149036-10-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YJnXTHy0uGOqENjmA5h8EJhYAqEww7ZR
X-Proofpoint-GUID: 4GiiOhBtnJ99UoJEwGzWIrV6d3svBqhI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-10-09 at 18:31 +0800, Baoquan He wrote:
> By taking GENERIC_IOREMAP method, the generic ioremap_prot() and
> iounmap() are visible and available to arch. Arch only needs to
> provide implementation of arch_ioremap() or arch_iounmap() if there's
> arch specific handling needed in its ioremap() or iounmap(). This
> change will simplify implementation by removing duplicated codes with
> generic ioremap() and iounmap(), and has the equivalent functioality
> as before.
> 
> For s390, add hooks arch_ioremap() and arch_iounmap() for s390's special
> operation when ioremap() and iounmap(), then ioremap_[wc|wt]() are
> converted to use ioremap_prot() from GENERIC_IOREMAP.
> 
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
> v2->v3:
> - Add code comment inside arch_ioremap() to help uderstand the
>   obsucre code. Christoph suggested this, Niklas provided the
>   paragraph of text.
> 
>  arch/s390/Kconfig          |  1 +
>  arch/s390/include/asm/io.h | 25 +++++++++------
>  arch/s390/pci/pci.c        | 65 ++++++++------------------------------
>  3 files changed, 30 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 318fce77601d..c59e1b25f59d 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -135,6 +135,7 @@ config S390
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_TIME_VSYSCALL
>  	select GENERIC_VDSO_TIME_NS
> +	select GENERIC_IOREMAP

I think you should add the "if PCI" from the diff in your last mail to
this patch.

>  	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_JUMP_LABEL
> diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
> index e3882b012bfa..db201563baa6 100644
> --- a/arch/s390/include/asm/io.h
> +++ b/arch/s390/include/asm/io.h
> @@ -22,11 +22,22 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
>  
>  #define IO_SPACE_LIMIT 0
>  
> -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
> -void __iomem *ioremap(phys_addr_t addr, size_t size);
> -void __iomem *ioremap_wc(phys_addr_t addr, size_t size);
> -void __iomem *ioremap_wt(phys_addr_t addr, size_t size);
> -void iounmap(volatile void __iomem *addr);
> +/*
> + * I/O memory mapping functions.
> + */
> +void __iomem *
> +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
> +#define arch_ioremap arch_ioremap
> +
> +bool arch_iounmap(void __iomem *addr);
> +#define arch_iounmap arch_iounmap
> +
> +#define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL)
> +
> +#define ioremap_wc(addr, size)  \
> +	ioremap_prot((addr), (size), pgprot_val(pgprot_writecombine(PAGE_KERNEL)))
> +#define ioremap_wt(addr, size)  \
> +	ioremap_prot((addr), (size), pgprot_val(pgprot_writethrough(PAGE_KERNEL)))
>  
>  static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
>  {
> @@ -51,10 +62,6 @@ static inline void ioport_unmap(void __iomem *p)
>  #define pci_iomap_wc pci_iomap_wc
>  #define pci_iomap_wc_range pci_iomap_wc_range
>  
> -#define ioremap ioremap
> -#define ioremap_wt ioremap_wt
> -#define ioremap_wc ioremap_wc
> -
>  #define memcpy_fromio(dst, src, count)	zpci_memcpy_fromio(dst, src, count)
>  #define memcpy_toio(dst, src, count)	zpci_memcpy_toio(dst, src, count)
>  #define memset_io(dst, val, count)	zpci_memset_io(dst, val, count)
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 73cdc5539384..3c00dc7d79bc 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -244,64 +244,25 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
>         zpci_memcpy_toio(to, from, count);
>  }
>  
> -static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
> +void __iomem *
> +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
>  {
> -	unsigned long offset, vaddr;
> -	struct vm_struct *area;
> -	phys_addr_t last_addr;
> -
> -	last_addr = addr + size - 1;
> -	if (!size || last_addr < addr)
> -		return NULL;
> -
> +	/*
> +	 * When PCI MIO instructions are unavailable the "physical" address
> +	 * encodes a hint for accessing the PCI memory space it represents.
> +	 * Just pass it unchanged such that ioread/iowrite can decode it.
> +	 */
>  	if (!static_branch_unlikely(&have_mio))
> -		return (void __iomem *) addr;
> -
> -	offset = addr & ~PAGE_MASK;
> -	addr &= PAGE_MASK;
> -	size = PAGE_ALIGN(size + offset);
> -	area = get_vm_area(size, VM_IOREMAP);
> -	if (!area)
> -		return NULL;
> -
> -	vaddr = (unsigned long) area->addr;
> -	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
> -		free_vm_area(area);
> -		return NULL;
> -	}
> -	return (void __iomem *) ((unsigned long) area->addr + offset);
> +		return (void __iomem *) *paddr;

nit: no space after the cast

> +	return NULL;
>  }
>  
> -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
> +bool arch_iounmap(void __iomem *addr)
>  {
> -	return __ioremap(addr, size, __pgprot(prot));
> -}
> -EXPORT_SYMBOL(ioremap_prot);
> -
> -void __iomem *ioremap(phys_addr_t addr, size_t size)
> -{
> -	return __ioremap(addr, size, PAGE_KERNEL);
> -}
> -EXPORT_SYMBOL(ioremap);
> -
> -void __iomem *ioremap_wc(phys_addr_t addr, size_t size)
> -{
> -	return __ioremap(addr, size, pgprot_writecombine(PAGE_KERNEL));
> -}
> -EXPORT_SYMBOL(ioremap_wc);
> -
> -void __iomem *ioremap_wt(phys_addr_t addr, size_t size)
> -{
> -	return __ioremap(addr, size, pgprot_writethrough(PAGE_KERNEL));
> -}
> -EXPORT_SYMBOL(ioremap_wt);
> -
> -void iounmap(volatile void __iomem *addr)
> -{
> -	if (static_branch_likely(&have_mio))
> -		vunmap((__force void *) ((unsigned long) addr & PAGE_MASK));
> +	if (!static_branch_likely(&have_mio))
> +		return false;
> +	return true;
>  }
> -EXPORT_SYMBOL(iounmap);
>  
>  /* Create a virtual mapping cookie for a PCI BAR */
>  static void __iomem *pci_iomap_range_fh(struct pci_dev *pdev, int bar,

Gave this a round of testing on s390 with both the MIO and non-MIO
cases. I also see you addressed my previous comments and it looks good
to me. As you showed in the other mail the compile error is a pre
existing problem so shouldn't influence this change. So assuming you
add the "if PCI" and the nit above you can add my:

Tested-by: Niklas
Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Niklas Schnelle
<schnelle@linux.ibm.com>


