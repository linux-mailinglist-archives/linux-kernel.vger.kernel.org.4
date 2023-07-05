Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3F5747F17
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjGEIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjGEIJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFA11715
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 01:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688544513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zykKd6o7uQBadhK+QOJVEiiMMOWwoNrDKmhn2jAEWOk=;
        b=L1dSWwG2zHWFzWkh24G4anl6fmDYJRzK69/p4nGzx1v6Ss5tIBqJq1FBIM++vRsvXrGyN0
        weMR/JRhc7FKDx1H6QftkBIxDVrWzaN/xIi4gsFvvj8tCeL3u/QPJ4te05V5njuRjAlazW
        3Id7y19vLvxr6NAPFUWHd2je0YWbx/Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-Zl9IRoHRMt2TYWoqEyNoGQ-1; Wed, 05 Jul 2023 04:08:29 -0400
X-MC-Unique: Zl9IRoHRMt2TYWoqEyNoGQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30793c16c78so6571855f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 01:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688544506; x=1691136506;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zykKd6o7uQBadhK+QOJVEiiMMOWwoNrDKmhn2jAEWOk=;
        b=Nk3cdm4ZaVESaT8AW7hsbZ12cepnK2CA4g4vum1nBLeEiU47i7GqjYr4oi4tudiuiL
         Le0Xizfy4MbilrgAdGAC79Sddo7aNndnpHRhV8wCq6rm4ECd7XL5Dbw/++cVVKFwzufd
         gM0Sy8ktZbv74Rw8HQGx8My2pyLfG6/7uiP59aKFsEgNXmQzc46hIUrPajhK9jr2DcJT
         91AghUuIQRkrOxk42dt4VxcyJc3bIYARen7e5yG2fmdaYvD3jf0o5aH7pnevBY/mT4F5
         mAipB3va6UG2V1SE1c1s3GzNwDQfoi9G636b2+CLQPBPLBnU8u1+/C88Zr0a3e/qW2c9
         myfQ==
X-Gm-Message-State: ABy/qLbuMJyGCESr9f1gkFthwdUuy54SnAUUeETgqmoMnu6T4vAk4RiN
        MVY1iQ021PjEkX7mjR+6qumj+tz0MUJhlkpYoeUH5i8VOC3OqPSOcpv4kWApe2HUyVNH5Zwy5gT
        JpQ1qTZn7y4yI5NZEKzOJ22GO
X-Received: by 2002:a5d:5691:0:b0:314:46af:e1e7 with SMTP id f17-20020a5d5691000000b0031446afe1e7mr1875290wrv.34.1688544506568;
        Wed, 05 Jul 2023 01:08:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFCmoL+C20ubL9YTlE9vV43mW/bpliGveeEn8UIIwaQ8V9PTsaOY3aTQ+a0f2fYsRMGhFrQ+Q==
X-Received: by 2002:a5d:5691:0:b0:314:46af:e1e7 with SMTP id f17-20020a5d5691000000b0031446afe1e7mr1875229wrv.34.1688544506135;
        Wed, 05 Jul 2023 01:08:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:1c00:e2b1:fc33:379b:a713? (p200300cbc71a1c00e2b1fc33379ba713.dip0.t-ipconnect.de. [2003:cb:c71a:1c00:e2b1:fc33:379b:a713])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d610b000000b00313e2abfb8dsm29649877wrt.92.2023.07.05.01.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 01:08:25 -0700 (PDT)
Message-ID: <970295ab-e85d-7af3-76e6-df53a5c52f8b@redhat.com>
Date:   Wed, 5 Jul 2023 10:08:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230705063711.2670599-1-surenb@google.com>
 <20230705063711.2670599-2-surenb@google.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/2] fork: lock VMAs of the parent process when forking
In-Reply-To: <20230705063711.2670599-2-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.23 08:37, Suren Baghdasaryan wrote:
> When forking a child process, parent write-protects an anonymous page
> and COW-shares it with the child being forked using copy_present_pte().
> Parent's TLB is flushed right before we drop the parent's mmap_lock in
> dup_mmap(). If we get a write-fault before that TLB flush in the parent,
> and we end up replacing that anonymous page in the parent process in
> do_wp_page() (because, COW-shared with the child), this might lead to
> some stale writable TLB entries targeting the wrong (old) page.
> Similar issue happened in the past with userfaultfd (see flush_tlb_page()
> call inside do_wp_page()).
> Lock VMAs of the parent process when forking a child, which prevents
> concurrent page faults during fork operation and avoids this issue.
> This fix can potentially regress some fork-heavy workloads. Kernel build
> time did not show noticeable regression on a 56-core machine while a
> stress test mapping 10000 VMAs and forking 5000 times in a tight loop
> shows ~5% regression. If such fork time regression is unacceptable,
> disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
> optimizations are possible if this regression proves to be problematic.

Out of interest, did you also populate page tables / pages for some of these
VMAs, or is this primarily looping over 10000 VMAs that don't actually copy any
page tables?

> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org/
> Reported-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> Closes: https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a34c@applied-asynchrony.com/
> Reported-by: Jacob Young <jacobly.alt@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217624
> Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling first")
> Cc: stable@vger.kernel.org
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>   kernel/fork.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b85814e614a5..d2e12b6d2b18 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -686,6 +686,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>   	for_each_vma(old_vmi, mpnt) {
>   		struct file *file;
>   
> +		vma_start_write(mpnt);
>   		if (mpnt->vm_flags & VM_DONTCOPY) {
>   			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
>   			continue;

After the mmap_write_lock_killable(), there will still be a period where page
faults can happen. Essentially, page faults can happen for a VMA until we lock that VMA.

I cannot immediately name something that is broken allowing for that, and this change
should fix the issue at hand, but exotic things like

	flush_cache_dup_mm(oldmm);

make me wonder if we really want to allow for that or if there is some other corner case
in fork() handling that really doesn't expect concurrent page faults (and, thereby, page
table modifications) with fork.

For example, documentation/core-api/cachetlb.rst says

2) ``void flush_cache_dup_mm(struct mm_struct *mm)``

	This interface flushes an entire user address space from
	the caches.  That is, after running, there will be no cache
	lines associated with 'mm'.

	This interface is used to handle whole address space
	page table operations such as what happens during fork.

	This option is separate from flush_cache_mm to allow some
	optimizations for VIPT caches.


An alternative that requires another VMA walk would be

diff --git a/kernel/fork.c b/kernel/fork.c
index 41c964104b58..0f182d3f049b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -662,6 +662,13 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
  		retval = -EINTR;
  		goto fail_uprobe_end;
  	}
+
+	/* Disallow any page faults early by locking all VMAs. */
+	if (IS_ENABLED(CONFIG_PER_VMA_LOCK)) {
+		for_each_vma(old_vmi, mpnt)
+			vma_start_write(mpnt);
+		vma_iter_init(old_vmi, old_mm, 0);
+	}
  	flush_cache_dup_mm(oldmm);
  	uprobe_dup_mmap(oldmm, mm);
  	/*
-- 
2.41.0


Unless there are other thoughts, I guess you change is fine regarding the problem
at hand. Not so sure regarding any other corner cases, that's why I'm spelling it out.


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

