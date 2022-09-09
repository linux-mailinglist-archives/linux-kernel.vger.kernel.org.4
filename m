Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D80F5B3CC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiIIQPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIIQPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:15:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDF44599B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:15:04 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289Fg5Kt008607;
        Fri, 9 Sep 2022 16:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HiA9/EshoLMONGQxGC9d36ntpKwVpjf2jBKwwWHfYq0=;
 b=MJPeh9aKk8zX+yATPmsmrj11owUejLoEESfKGoZwNsSbbEiXRsYrKqilUC7MV3bLiNYT
 kHTNmiZe/ugcqVHnbsoJXvq0CB78+mNDBKDnY4cCDRNGfyQj2FmunJP4zlGN7ekVsPrP
 kIuYdpkslswgGPysaspcuzCKPhWRl921QLonEwZFTOm0ntHcXAtd+VRC+mET6+F0gA29
 6zRTzlhNxTdykN7keWy3auk9rtnfTJAAuEXgj/9jElCsLtRFB0LLeIMdFOxL9J+0/FvZ
 J292hHnPWuNJ/4OIfHynFPJ/t/E0ggA8UIkb4HVrfHRu1tlzGZ1N1EGgjIoHRIeX3gCx Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg8bvs06s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 16:14:30 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 289FgF0U009010;
        Fri, 9 Sep 2022 16:14:30 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg8bvs05f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 16:14:30 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 289FoSj9032599;
        Fri, 9 Sep 2022 16:14:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3jbxj907nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 16:14:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 289GEPJO38404386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Sep 2022 16:14:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 196D142045;
        Fri,  9 Sep 2022 16:14:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E56EB4203F;
        Fri,  9 Sep 2022 16:14:23 +0000 (GMT)
Received: from [9.145.83.17] (unknown [9.145.83.17])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Sep 2022 16:14:23 +0000 (GMT)
Message-ID: <e75586a4-7afd-f498-8dc4-02191dea4c3a@linux.ibm.com>
Date:   Fri, 9 Sep 2022 18:14:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [RFC PATCH RESEND 28/28] kernel/fork: throttle call_rcu() calls
 in vm_area_free
Content-Language: fr
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220901173516.702122-1-surenb@google.com>
 <20220901173516.702122-29-surenb@google.com>
 <34dd5656-dc3c-6a20-5390-04d05c619fdc@linux.ibm.com>
 <CAJuCfpGn=Xhc3SnrK2ei1WPoFPaW00xZkS9MebN9Zxfv9joPoA@mail.gmail.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <CAJuCfpGn=Xhc3SnrK2ei1WPoFPaW00xZkS9MebN9Zxfv9joPoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qwuw3hRuJlbQGJ2HSHJdlFKbsPcb7JBI
X-Proofpoint-GUID: wp0areCKBz6NfJIj93C1qkPqh1OyJO6x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090055
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/09/2022 à 18:02, Suren Baghdasaryan a écrit :
> On Fri, Sep 9, 2022 at 8:19 AM Laurent Dufour <ldufour@linux.ibm.com> wrote:
>>
>> Le 01/09/2022 à 19:35, Suren Baghdasaryan a écrit :
>>> call_rcu() can take a long time when callback offloading is enabled.
>>> Its use in the vm_area_free can cause regressions in the exit path when
>>> multiple VMAs are being freed. To minimize that impact, place VMAs into
>>> a list and free them in groups using one call_rcu() call per group.
>>>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---
>>>  include/linux/mm.h       |  1 +
>>>  include/linux/mm_types.h | 11 ++++++-
>>>  kernel/fork.c            | 68 +++++++++++++++++++++++++++++++++++-----
>>>  mm/init-mm.c             |  3 ++
>>>  mm/mmap.c                |  1 +
>>>  5 files changed, 75 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index a3cbaa7b9119..81dff694ac14 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -249,6 +249,7 @@ void setup_initial_init_mm(void *start_code, void *end_code,
>>>  struct vm_area_struct *vm_area_alloc(struct mm_struct *);
>>>  struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
>>>  void vm_area_free(struct vm_area_struct *);
>>> +void drain_free_vmas(struct mm_struct *mm);
>>>
>>>  #ifndef CONFIG_MMU
>>>  extern struct rb_root nommu_region_tree;
>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>> index 36562e702baf..6f3effc493b1 100644
>>> --- a/include/linux/mm_types.h
>>> +++ b/include/linux/mm_types.h
>>> @@ -412,7 +412,11 @@ struct vm_area_struct {
>>>                       struct vm_area_struct *vm_next, *vm_prev;
>>>               };
>>>  #ifdef CONFIG_PER_VMA_LOCK
>>> -             struct rcu_head vm_rcu; /* Used for deferred freeing. */
>>> +             struct {
>>> +                     struct list_head vm_free_list;
>>> +                     /* Used for deferred freeing. */
>>> +                     struct rcu_head vm_rcu;
>>> +             };
>>>  #endif
>>>       };
>>>
>>> @@ -573,6 +577,11 @@ struct mm_struct {
>>>                                         */
>>>  #ifdef CONFIG_PER_VMA_LOCK
>>>               int mm_lock_seq;
>>> +             struct {
>>> +                     struct list_head head;
>>> +                     spinlock_t lock;
>>> +                     int size;
>>> +             } vma_free_list;
>>>  #endif
>>>
>>>
>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>> index b443ba3a247a..7c88710aed72 100644
>>> --- a/kernel/fork.c
>>> +++ b/kernel/fork.c
>>> @@ -483,26 +483,75 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>>>  }
>>>
>>>  #ifdef CONFIG_PER_VMA_LOCK
>>> -static void __vm_area_free(struct rcu_head *head)
>>> +static inline void __vm_area_free(struct vm_area_struct *vma)
>>>  {
>>> -     struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
>>> -                                               vm_rcu);
>>>       /* The vma should either have no lock holders or be write-locked. */
>>>       vma_assert_no_reader(vma);
>>>       kmem_cache_free(vm_area_cachep, vma);
>>>  }
>>> -#endif
>>> +
>>> +static void vma_free_rcu_callback(struct rcu_head *head)
>>> +{
>>> +     struct vm_area_struct *first_vma;
>>> +     struct vm_area_struct *vma, *vma2;
>>> +
>>> +     first_vma = container_of(head, struct vm_area_struct, vm_rcu);
>>> +     list_for_each_entry_safe(vma, vma2, &first_vma->vm_free_list, vm_free_list)
>>
>> Is that safe to walk the list against concurrent calls to
>> list_splice_init(), or list_add()?
> 
> I think it is. drain_free_vmas() moves the to-be-destroyed and already
> isolated VMAs from mm->vma_free_list into to_destroy list and then
> passes that list to vma_free_rcu_callback(). At this point the list of
> VMAs passed to vma_free_rcu_callback() is not accessible either from
> mm (VMAs were isolated before vm_area_free() was called) or from
> drain_free_vmas() since they were already removed from
> mm->vma_free_list. Does that make sense?

Got it!
Thanks for the explanation.

> 
>>
>>> +             __vm_area_free(vma);
>>> +     __vm_area_free(first_vma);
>>> +}
>>> +
>>> +void drain_free_vmas(struct mm_struct *mm)
>>> +{
>>> +     struct vm_area_struct *first_vma;
>>> +     LIST_HEAD(to_destroy);
>>> +
>>> +     spin_lock(&mm->vma_free_list.lock);
>>> +     list_splice_init(&mm->vma_free_list.head, &to_destroy);
>>> +     mm->vma_free_list.size = 0;
>>> +     spin_unlock(&mm->vma_free_list.lock);
>>> +
>>> +     if (list_empty(&to_destroy))
>>> +             return;
>>> +
>>> +     first_vma = list_first_entry(&to_destroy, struct vm_area_struct, vm_free_list);
>>> +     /* Remove the head which is allocated on the stack */
>>> +     list_del(&to_destroy);
>>> +
>>> +     call_rcu(&first_vma->vm_rcu, vma_free_rcu_callback);
>>> +}
>>> +
>>> +#define VM_AREA_FREE_LIST_MAX        32
>>> +
>>> +void vm_area_free(struct vm_area_struct *vma)
>>> +{
>>> +     struct mm_struct *mm = vma->vm_mm;
>>> +     bool drain;
>>> +
>>> +     free_anon_vma_name(vma);
>>> +
>>> +     spin_lock(&mm->vma_free_list.lock);
>>> +     list_add(&vma->vm_free_list, &mm->vma_free_list.head);
>>> +     mm->vma_free_list.size++;
>>> +     drain = mm->vma_free_list.size > VM_AREA_FREE_LIST_MAX;
>>> +     spin_unlock(&mm->vma_free_list.lock);
>>> +
>>> +     if (drain)
>>> +             drain_free_vmas(mm);
>>> +}
>>> +
>>> +#else /* CONFIG_PER_VMA_LOCK */
>>> +
>>> +void drain_free_vmas(struct mm_struct *mm) {}
>>>
>>>  void vm_area_free(struct vm_area_struct *vma)
>>>  {
>>>       free_anon_vma_name(vma);
>>> -#ifdef CONFIG_PER_VMA_LOCK
>>> -     call_rcu(&vma->vm_rcu, __vm_area_free);
>>> -#else
>>>       kmem_cache_free(vm_area_cachep, vma);
>>> -#endif
>>>  }
>>>
>>> +#endif /* CONFIG_PER_VMA_LOCK */
>>> +
>>>  static void account_kernel_stack(struct task_struct *tsk, int account)
>>>  {
>>>       if (IS_ENABLED(CONFIG_VMAP_STACK)) {
>>> @@ -1137,6 +1186,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>>>       INIT_LIST_HEAD(&mm->mmlist);
>>>  #ifdef CONFIG_PER_VMA_LOCK
>>>       WRITE_ONCE(mm->mm_lock_seq, 0);
>>> +     INIT_LIST_HEAD(&mm->vma_free_list.head);
>>> +     spin_lock_init(&mm->vma_free_list.lock);
>>> +     mm->vma_free_list.size = 0;
>>>  #endif
>>>       mm_pgtables_bytes_init(mm);
>>>       mm->map_count = 0;
>>> diff --git a/mm/init-mm.c b/mm/init-mm.c
>>> index 8399f90d631c..7b6d2460545f 100644
>>> --- a/mm/init-mm.c
>>> +++ b/mm/init-mm.c
>>> @@ -39,6 +39,9 @@ struct mm_struct init_mm = {
>>>       .mmlist         = LIST_HEAD_INIT(init_mm.mmlist),
>>>  #ifdef CONFIG_PER_VMA_LOCK
>>>       .mm_lock_seq    = 0,
>>> +     .vma_free_list.head = LIST_HEAD_INIT(init_mm.vma_free_list.head),
>>> +     .vma_free_list.lock =  __SPIN_LOCK_UNLOCKED(init_mm.vma_free_list.lock),
>>> +     .vma_free_list.size = 0,
>>>  #endif
>>>       .user_ns        = &init_user_ns,
>>>       .cpu_bitmap     = CPU_BITS_NONE,
>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>> index 1edfcd384f5e..d61b7ef84ba6 100644
>>> --- a/mm/mmap.c
>>> +++ b/mm/mmap.c
>>> @@ -3149,6 +3149,7 @@ void exit_mmap(struct mm_struct *mm)
>>>       }
>>>       mm->mmap = NULL;
>>>       mmap_write_unlock(mm);
>>> +     drain_free_vmas(mm);
>>>       vm_unacct_memory(nr_accounted);
>>>  }
>>>
>>

