Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81F25B38FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiIIN2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiIIN23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:28:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A3D1251B5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:28:28 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289DC0J7020496;
        Fri, 9 Sep 2022 13:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xGWZBcP7Vjjt0ne0dV570vSeEqDuHKwNy1/7aKUyKxk=;
 b=Oc2dEpgxnslVIg0nuXQJTu0mYsSNNfCZdEPdgqnf44ZzwNFf5rfyGVSJJ4lfiVOQ+hDb
 r2BwmVUe0lsGbIwUDN5sGlpSA/vfWO85w7P5pIEnJdB6IJE26i1yKWa8u41SG99gEE70
 HhX0foDFQMIYn6ZaPrWI8W4y5LcEz5bQpK60sxw9GhnpCJHsc/HhH1oVFMqnEQbgNhjJ
 N2z8IbFkOoTcR1f8Pa7IbC+o7HekL8a43AwEalRa6TwVuD0BwSoKUlCqWgUheNfB7CaU
 VTVRrsFG9LDLGf9tubkJKlGH5EgtKs/QItlSA8ggvXEteKsKcwkw3FriHYyP6dAFKzAl Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg65j0gfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 13:27:38 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 289DCiY4026580;
        Fri, 9 Sep 2022 13:27:37 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg65j0gec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 13:27:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 289DKFtx009042;
        Fri, 9 Sep 2022 13:27:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3jbxj901mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 13:27:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 289DRW1Z40501602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Sep 2022 13:27:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22BB742045;
        Fri,  9 Sep 2022 13:27:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A234742041;
        Fri,  9 Sep 2022 13:27:30 +0000 (GMT)
Received: from [9.145.83.17] (unknown [9.145.83.17])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Sep 2022 13:27:30 +0000 (GMT)
Message-ID: <fa73db62-560f-87c4-2b0f-bbba57eed8a7@linux.ibm.com>
Date:   Fri, 9 Sep 2022 15:27:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [RFC PATCH RESEND 07/28] kernel/fork: mark VMAs as locked before
 copying pages during fork
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
 <20220901173516.702122-8-surenb@google.com>
 <a072fd10-ee7e-469f-c203-978cd7da566c@linux.ibm.com>
 <CAJuCfpFDFzCB7zuOGyd-gqovyhwvcQaUMOUS0E8+1QxLqD-Gdg@mail.gmail.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <CAJuCfpFDFzCB7zuOGyd-gqovyhwvcQaUMOUS0E8+1QxLqD-Gdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AKENId9QRksp4m3H-lE_THCmMHniIzD8
X-Proofpoint-GUID: CFGeekGWSpIQRCVQ4AE9GyYndL5KhzSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999 spamscore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209090045
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/09/2022 à 01:57, Suren Baghdasaryan a écrit :
> On Tue, Sep 6, 2022 at 7:38 AM Laurent Dufour <ldufour@linux.ibm.com> wrote:
>>
>> Le 01/09/2022 à 19:34, Suren Baghdasaryan a écrit :
>>> Protect VMAs from concurrent page fault handler while performing
>>> copy_page_range for VMAs having VM_WIPEONFORK flag set.
>>
>> I'm wondering why is that necessary.
>> The copied mm is write locked, and the destination one is not reachable.
>> If any other readers are using the VMA, this is only for page fault handling.
> 
> Correct, this is done to prevent page faulting in the VMA being
> duplicated. I assume we want to prevent the pages in that VMA from
> changing when we are calling copy_page_range(). Am I wrong?

If a page is faulted while copy_page_range() is in progress, the page may
not be backed on the child side (PTE lock should protect the copy, isn't it).
Is that a real problem? It will be backed later if accessed on the child side.
Maybe the per process pages accounting could be incorrect...

> 
>> I should have miss something because I can't see any need to mark the lock
>> VMA here.
>>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---
>>>  kernel/fork.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>> index bfab31ecd11e..1872ad549fed 100644
>>> --- a/kernel/fork.c
>>> +++ b/kernel/fork.c
>>> @@ -709,8 +709,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>               rb_parent = &tmp->vm_rb;
>>>
>>>               mm->map_count++;
>>> -             if (!(tmp->vm_flags & VM_WIPEONFORK))
>>> +             if (!(tmp->vm_flags & VM_WIPEONFORK)) {
>>> +                     vma_mark_locked(mpnt);
>>>                       retval = copy_page_range(tmp, mpnt);
>>> +             }
>>>
>>>               if (tmp->vm_ops && tmp->vm_ops->open)
>>>                       tmp->vm_ops->open(tmp);
>>

