Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC75B3AD4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiIIOjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiIIOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:39:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB6A131ED5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:39:00 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289DIbb7018352;
        Fri, 9 Sep 2022 14:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8CTwBYWOdFlP4FwLmxHtfRQS81v6onzfClpL7+y63HE=;
 b=bk0wG4ZLPuUWpg3aQ7l92xo9RfB3B5qwdidqVOXZp8vboS3GzzANaz7m4tpv0rMOikWi
 z+J1rCj6P7QdhAa7Yqj3x9psaPTagmngB02r82PnaW8ezOiaArAsxjK2m9N4fnZL2+g+
 a/X8NThPe4tMRFrWwLzn/a/ZKuVEzYhQkuu0XGn0iiwJNKs8dGf1DdoafnNrSDMKUbXn
 Ixz5Qq7Gl9N/IrJC1wxvWiQoYy6gmkuacVI39CiJXd4ApcBhh2hRqNwKgZPGqAFxXnkv
 LfsUwh7P6OKfDSDA0qUlK86BXOs4EwbOrNNrPyh1hU0O+x+gFM3zpRZ+ykahbCRar9kp /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg5exm0c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 14:38:34 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 289DOmT2020042;
        Fri, 9 Sep 2022 14:38:33 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg5exm0bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 14:38:33 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 289EM0XG006289;
        Fri, 9 Sep 2022 14:38:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3jbxj8x16f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 14:38:31 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 289EcSPV40698192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Sep 2022 14:38:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 818724203F;
        Fri,  9 Sep 2022 14:38:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 733AD42042;
        Fri,  9 Sep 2022 14:38:27 +0000 (GMT)
Received: from [9.145.83.17] (unknown [9.145.83.17])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Sep 2022 14:38:27 +0000 (GMT)
Message-ID: <630714df-dec1-4a41-6af3-380181d11669@linux.ibm.com>
Date:   Fri, 9 Sep 2022 16:38:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [RFC PATCH RESEND 21/28] mm: introduce find_and_lock_anon_vma to
 be used from arch-specific code
Content-Language: fr
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220901173516.702122-1-surenb@google.com>
 <20220901173516.702122-22-surenb@google.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20220901173516.702122-22-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IcRKhDOEa6Ts-ePGWWJKeMBqdv8Loc-W
X-Proofpoint-GUID: 0Yk3VPJJRdSVQygJF41M58APoGFE1EH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=601 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209090051
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/09/2022 à 19:35, Suren Baghdasaryan a écrit :
> Introduce find_and_lock_anon_vma function to lookup and lock an anonymous
> VMA during page fault handling. When VMA is not found, can't be locked
> or changes after being locked, the function returns NULL. The lookup is
> performed under RCU protection to prevent the found VMA from being
> destroyed before the VMA lock is acquired. VMA lock statistics are
> updated according to the results.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm.h |  3 +++
>  mm/memory.c        | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7c3190eaabd7..a3cbaa7b9119 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -684,6 +684,9 @@ static inline void vma_assert_no_reader(struct vm_area_struct *vma)
>  		      vma);
>  }
>  
> +struct vm_area_struct *find_and_lock_anon_vma(struct mm_struct *mm,
> +					      unsigned long address);
> +
>  #else /* CONFIG_PER_VMA_LOCK */
>  
>  static inline void vma_init_lock(struct vm_area_struct *vma) {}
> diff --git a/mm/memory.c b/mm/memory.c
> index 29d2f49f922a..bf557f7056de 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5183,6 +5183,51 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  }
>  EXPORT_SYMBOL_GPL(handle_mm_fault);
>  
> +#ifdef CONFIG_PER_VMA_LOCK
> +static inline struct vm_area_struct *find_vma_under_rcu(struct mm_struct *mm,
> +							unsigned long address)
> +{
> +	struct vm_area_struct *vma = __find_vma(mm, address);
> +
> +	if (!vma || vma->vm_start > address)
> +		return NULL;
> +
> +	if (!vma_is_anonymous(vma))
> +		return NULL;
> +

It looks to me more natural to first check that the VMA is part of the RB
tree before try read locking it.

> +	if (!vma_read_trylock(vma)) {
> +		count_vm_vma_lock_event(VMA_LOCK_ABORT);
> +		return NULL;
> +	}
> +
> +	/* Check if the VMA got isolated after we found it */
> +	if (RB_EMPTY_NODE(&vma->vm_rb)) {
> +		vma_read_unlock(vma);
> +		count_vm_vma_lock_event(VMA_LOCK_MISS);
> +		return NULL;
> +	}
> +
> +	return vma;
> +}
> +
> +/*
> + * Lookup and lock and anonymous VMA. Returned VMA is guaranteed to be stable
> + * and not isolated. If the VMA is not found of is being modified the function
> + * returns NULL.
> + */
> +struct vm_area_struct *find_and_lock_anon_vma(struct mm_struct *mm,
> +					      unsigned long address)
> +{
> +	struct vm_area_struct *vma;
> +
> +	rcu_read_lock();
> +	vma = find_vma_under_rcu(mm, address);
> +	rcu_read_unlock();
> +
> +	return vma;
> +}
> +#endif /* CONFIG_PER_VMA_LOCK */
> +
>  #ifndef __PAGETABLE_P4D_FOLDED
>  /*
>   * Allocate p4d page table.

