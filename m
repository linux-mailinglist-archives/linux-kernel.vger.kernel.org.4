Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787F55B3920
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIINgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiIINgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:36:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA87712894B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:36:22 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289CbeEW003994;
        Fri, 9 Sep 2022 13:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xzhKYU684b2dfu1qPjE8Sin6GXCrrR5aDRD7oDV2Xis=;
 b=MIZOHfGkG81ENiTzgtzdNTkOxu7gtMcXp5ItRULSjhQYA1A1wHQmvJArKj6CTc4YM/ZF
 p8VMM8QHQ71mTwcOx63AXAV6sQWHiE0ycCDFxh/tI2JdLtLcYBkCMyCObhDjYmrYycob
 dX8Afx3eYOj46LHUxk9xv9TOowINu30uYi2Ky8NyeKe087ZbMV9gEIViDEdWE1i4ixlQ
 kKJljtLjmcDMu+DrQPb+x8deALtgnLzwuVaYFBqBrwvvR/il5KqsCa1J/0fVN/+bx0xm
 LeHODLSv1tRdPXp4SzLDa/jKkpAxl7CaJpH6t4p59APgarqxjXHXYIvTe4/POlXX/IEX /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg4d5vvay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 13:35:39 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 289CkGBh023200;
        Fri, 9 Sep 2022 13:35:35 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg4d5vv8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 13:35:35 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 289DKtaB027527;
        Fri, 9 Sep 2022 13:35:32 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3jbxj8nyb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 13:35:31 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 289DZrGm41615782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Sep 2022 13:35:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7093642047;
        Fri,  9 Sep 2022 13:35:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEFF14203F;
        Fri,  9 Sep 2022 13:35:27 +0000 (GMT)
Received: from [9.145.83.17] (unknown [9.145.83.17])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Sep 2022 13:35:27 +0000 (GMT)
Message-ID: <7fcc871c-fcc2-e993-fe88-f0da49ff227a@linux.ibm.com>
Date:   Fri, 9 Sep 2022 15:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [RFC PATCH RESEND 14/28] mm: mark VMAs as locked before isolating
 them
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
 <20220901173516.702122-15-surenb@google.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20220901173516.702122-15-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0KecVJz831Cuz_-X5Ig4InH-HLRsZ-Pd
X-Proofpoint-ORIG-GUID: 9jojeoe4RfU5Q7JxugN35FnBK9tZpSK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=943
 spamscore=0 mlxscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090047
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
> Mark VMAs as locked before isolating them and clear their tree node so
> that isolated VMAs are easily identifiable. In the later patches page
> fault handlers will try locking the found VMA and will check whether
> the VMA was isolated. Locking VMAs before isolating them ensures that
> page fault handlers don't operate on isolated VMAs.

Found another place where the VMA should probably mark locked:
*** drivers/gpu/drm/drm_vma_manager.c:
drm_vma_node_revoke[338]       rb_erase(&entry->vm_rb, &node->vm_files);

There are 2 others entries in nommu.c but I guess this is not supported,
isn't it?


> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/mmap.c  | 2 ++
>  mm/nommu.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 094678b4434b..b0d78bdc0de0 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -421,12 +421,14 @@ static inline void vma_rb_insert(struct vm_area_struct *vma,
>  
>  static void __vma_rb_erase(struct vm_area_struct *vma, struct rb_root *root)
>  {
> +	vma_mark_locked(vma);
>  	/*
>  	 * Note rb_erase_augmented is a fairly large inline function,
>  	 * so make sure we instantiate it only once with our desired
>  	 * augmented rbtree callbacks.
>  	 */
>  	rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
> +	RB_CLEAR_NODE(&vma->vm_rb);
>  }
>  
>  static __always_inline void vma_rb_erase_ignore(struct vm_area_struct *vma,
> diff --git a/mm/nommu.c b/mm/nommu.c
> index e819cbc21b39..ff9933e57501 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -622,6 +622,7 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct task_struct *curr = current;
>  
> +	vma_mark_locked(vma);
>  	mm->map_count--;
>  	for (i = 0; i < VMACACHE_SIZE; i++) {
>  		/* if the vma is cached, invalidate the entire cache */
> @@ -644,6 +645,7 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
>  
>  	/* remove from the MM's tree and list */
>  	rb_erase(&vma->vm_rb, &mm->mm_rb);
> +	RB_CLEAR_NODE(&vma->vm_rb);
>  
>  	__vma_unlink_list(mm, vma);
>  }

