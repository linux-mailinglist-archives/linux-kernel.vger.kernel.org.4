Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F1D70657E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjEQKlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEQKlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:41:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61BC46BC;
        Wed, 17 May 2023 03:41:02 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HAWh8p030125;
        Wed, 17 May 2023 10:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=6o4UB5d8iRIZZq7T331T96/YmtIoyPZJVO895cK7BU4=;
 b=Qlb1r1C79y4iKHdQAqanT8rbJmqF8hpDVpHADvfmHgcOzINGCqecTLs6lklqCmaeUKZi
 LNo2SCVe642Qo5fhaxr/ou+1QQFdZf6fudSYdsYn1zj0/qda6lUKaL4wNzWc8ZwCpOGB
 u1jr8Jeldv7dhRYFAZce4H8UEXUhr2sOKWsFIUzuyQCAdsrgpetZ/OvfYv7ko7U4WoTl
 WIlXuWOUiMllj0buN4FxHg1xFrqq9szJZkHJpe+PgAPCqpQU+mAWYxRNQNulh9twB9sp
 7Sk1CAWsYA8brwf7ADoH4AMfmPk6bkEJB+etoy2gytNtvsvI4B1v7NCryfl9JlR+J5XJ Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmvpm9ncq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 10:39:33 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HAWq5Q030869;
        Wed, 17 May 2023 10:37:18 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmvpm9fk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 10:37:18 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34H5hGdl019589;
        Wed, 17 May 2023 10:35:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qj1tdt3s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 10:35:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34HAZmug51773938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 10:35:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B38752004B;
        Wed, 17 May 2023 10:35:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C636820043;
        Wed, 17 May 2023 10:35:47 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 17 May 2023 10:35:47 +0000 (GMT)
Date:   Wed, 17 May 2023 12:35:46 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 15/23] s390: allow pte_offset_map_lock() to fail
Message-ID: <20230517123546.672fb9b0@p-imbrenda>
In-Reply-To: <94aec8fe-383f-892-dcbf-d4c14e460a7@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
        <94aec8fe-383f-892-dcbf-d4c14e460a7@google.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8y_E68kURQ0ih8Y_-pXj5N6bPDOiuEZv
X-Proofpoint-ORIG-GUID: ot2a0roI6HKgv_SkGdPLAhcx7gRQDDOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 clxscore=1011 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=972
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 22:01:16 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

> In rare transient cases, not yet made possible, pte_offset_map() and
> pte_offset_map_lock() may not find a page table: handle appropriately.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  arch/s390/kernel/uv.c  |  2 ++
>  arch/s390/mm/gmap.c    |  2 ++
>  arch/s390/mm/pgtable.c | 12 +++++++++---
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index cb2ee06df286..3c62d1b218b1 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -294,6 +294,8 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
>  
>  	rc = -ENXIO;
>  	ptep = get_locked_pte(gmap->mm, uaddr, &ptelock);
> +	if (!ptep)
> +		goto out;
>  	if (pte_present(*ptep) && !(pte_val(*ptep) & _PAGE_INVALID) && pte_write(*ptep)) {
>  		page = pte_page(*ptep);
>  		rc = -EAGAIN;
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index dc90d1eb0d55..d198fc9475a2 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2549,6 +2549,8 @@ static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
>  		spinlock_t *ptl;
>  
>  		ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +		if (!ptep)
> +			break;

so if pte_offset_map_lock fails, we abort and skip both the failed
entry and the rest of the entries?

can pte_offset_map_lock be retried immediately if it fails? (consider
that we currently don't allow THP with KVM guests)

Would something like this:

do {
	ptep = pte_offset_map_lock(...);
	mb();	/* maybe? */
} while (!ptep);

make sense?


otherwise maybe it's better to return an error and retry the whole
walk_page_range() in s390_enable_sie() ? it's a slow path anyway.

>  		if (is_zero_pfn(pte_pfn(*ptep)))
>  			ptep_xchg_direct(walk->mm, addr, ptep, __pte(_PAGE_INVALID));
>  		pte_unmap_unlock(ptep, ptl);

[...]
