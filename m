Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C92710640
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbjEYHZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjEYHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:25:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14841BD;
        Thu, 25 May 2023 00:25:26 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P7MZUR027615;
        Thu, 25 May 2023 07:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=55klH+MHDRtIEEtWGbvAfPxNnN6EmMw4scwT5+fq3XI=;
 b=RCtuVZMVyLY0xGNcOr1uNeKOK8ntfwHROTFHQ4+AHlf2PWmk9UMR5C1PwZzqTymLhX3F
 YS8x9sdj4rnAtSDt7d3OIlvETB4UqOoJw503GtHvkqIIk34L6d4qe/5QAfXKoRiw8KQ3
 q2vN+VSVcbXRkWC9E/KmFqhp4J9Uk1or/sNjytHkFA/FLMsoMkRIv3iKpmsDaSpOHta9
 CUHKBISpNyljOYab0uO1Fpi++beo28ogb584RD8aDiv+J9GeRUJVo/dWdX2F0D18x38T
 iFptJIA55GKyv/jWO+T8QXxUyFt7k1uiwhkDKMXzQji2/r8sTbD6T9TT2CpRLV4sxd42 RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt32yg93r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 07:24:01 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34P7CWdL024922;
        Thu, 25 May 2023 07:24:00 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt32yg92j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 07:24:00 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P4rUxB029511;
        Thu, 25 May 2023 07:23:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qppcuaahq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 07:23:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34P7NrqW22610506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 07:23:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0BFA20043;
        Thu, 25 May 2023 07:23:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0955820040;
        Thu, 25 May 2023 07:23:53 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 07:23:52 +0000 (GMT)
Date:   Thu, 25 May 2023 09:23:51 +0200
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
Message-ID: <20230525092351.7671f2a4@p-imbrenda>
In-Reply-To: <b64cd153-18e8-81a6-b852-c04d8b1381d@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
        <94aec8fe-383f-892-dcbf-d4c14e460a7@google.com>
        <20230517123546.672fb9b0@p-imbrenda>
        <4a15dbaa-1614-ce-ce1f-f73959cef895@google.com>
        <20230523140056.55b664b1@p-imbrenda>
        <b64cd153-18e8-81a6-b852-c04d8b1381d@google.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qRLyp44GLiE9zXh3PageqjkrZmyh07xV
X-Proofpoint-GUID: uXGxTdAMLt8o-nI3lVA1NmtMWFctokRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_03,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 18:49:14 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

> On Tue, 23 May 2023, Claudio Imbrenda wrote:
> > 
> > so if I understand the above correctly, pte_offset_map_lock will only
> > fail if the whole page table has disappeared, and in that case, it will
> > never reappear with zero pages, therefore we can safely skip (in that
> > case just break). if we were to do a continue instead of a break, we
> > would most likely fail again anyway.  
> 
> Yes, that's the most likely; and you hold mmap_write_lock() there,
> and VM_NOHUGEPAGE on all vmas, so I think it's the only foreseeable
> possibility.
> 
> > 
> > in that case I would still like a small change in your patch: please
> > write a short (2~3 lines max) comment about why it's ok to do things
> > that way  
> 
> Sure.
> 
> But I now see that I've disobeyed you, and gone to 4 lines (but in the
> comment above the function, so as not to distract from the code itself):
> is this good wording to you?  I needed to research how they were stopped
> from coming in afterwards, so wanted to put something greppable in there.
> 
> And, unless I'm misunderstanding, that "after THP was enabled" was
> always supposed to say "after THP was disabled" (because splitting a
> huge zero page pmd inserts a a page table full of little zero ptes).

indeed, thanks for noticing and fixing it

> 
> Or would you prefer the comment in the commit message instead,
> or down just above the pte_offset_map_lock() line?
> 
> It would much better if I could find one place at the mm end, to
> enforce its end of the contract; but cannot think how to do that.
> 
> Hugh
> 
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2537,7 +2537,12 @@ static inline void thp_split_mm(struct mm_struct *mm)
>   * Remove all empty zero pages from the mapping for lazy refaulting
>   * - This must be called after mm->context.has_pgste is set, to avoid
>   *   future creation of zero pages
> - * - This must be called after THP was enabled
> + * - This must be called after THP was disabled.
> + *
> + * mm contracts with s390, that even if mm were to remove a page table,
> + * racing with the loop below and so causing pte_offset_map_lock() to fail,
> + * it will never insert a page table containing empty zero pages once
> + * mm_forbids_zeropage(mm) i.e. mm->context.has_pgste is set.
>   */
>  static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
>  			   unsigned long end, struct mm_walk *walk)

looks good, thanks
