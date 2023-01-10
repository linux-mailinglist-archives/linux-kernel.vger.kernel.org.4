Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAEF663A65
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjAJIE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjAJIEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:04:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40B2B488
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:04:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 558F24E0AD;
        Tue, 10 Jan 2023 08:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673337859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15Ddtu/7qxw5eMSlnsFVGSlfgAQfIR6dNvo68q5wauM=;
        b=bkMGUV5j7WHNqCvCYYj4CfuhyVWMG1FihfQs3FDQvYsD+EUttzsajuOzHDoykPY1FkCUhA
        ciHm28fp9KLmZ4btDVFftnnuynWIkZdOLQ1pAzp6Huh4FtOmdPT6uvqYfutZvH/5z861Y4
        HkRIdagbxSDGdwYn7B+e6o8QuWUIbzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673337859;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15Ddtu/7qxw5eMSlnsFVGSlfgAQfIR6dNvo68q5wauM=;
        b=jMlUUvZiWJb4nWS1WGaBP5M4JOwo6r8wna7GswTb+c08fyvFZeLybZ0CNenHGyH7I/wqJs
        6Y2gcmGussrmGvAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F5251358A;
        Tue, 10 Jan 2023 08:04:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TGk1JgIcvWOEBAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 10 Jan 2023 08:04:18 +0000
Message-ID: <5874fea2-fc3b-5e5d-50ac-e413a11819a5@suse.cz>
Date:   Tue, 10 Jan 2023 09:04:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-42-surenb@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230109205336.3665937-42-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 21:53, Suren Baghdasaryan wrote:
> rw_semaphore is a sizable structure of 40 bytes and consumes
> considerable space for each vm_area_struct. However vma_lock has
> two important specifics which can be used to replace rw_semaphore
> with a simpler structure:
> 1. Readers never wait. They try to take the vma_lock and fall back to
> mmap_lock if that fails.
> 2. Only one writer at a time will ever try to write-lock a vma_lock
> because writers first take mmap_lock in write mode.
> Because of these requirements, full rw_semaphore functionality is not
> needed and we can replace rw_semaphore with an atomic variable.
> When a reader takes read lock, it increments the atomic unless the
> value is negative. If that fails read-locking is aborted and mmap_lock
> is used instead.
> When writer takes write lock, it resets atomic value to -1 if the
> current value is 0 (no readers). Since all writers take mmap_lock in
> write mode first, there can be only one writer at a time. If there
> are readers, writer will place itself into a wait queue using new
> mm_struct.vma_writer_wait waitqueue head. The last reader to release
> the vma_lock will signal the writer to wake up.
> vm_lock_seq is also moved into vma_lock and along with atomic_t they
> are nicely packed and consume 8 bytes, bringing the overhead from
> vma_lock from 44 to 16 bytes:
> 
>     slabinfo before the changes:
>      <name>            ... <objsize> <objperslab> <pagesperslab> : ...
>     vm_area_struct    ...    152   53    2 : ...
> 
>     slabinfo with vma_lock:
>      <name>            ... <objsize> <objperslab> <pagesperslab> : ...
>     rw_semaphore      ...      8  512    1 : ...

I guess the cache is called vma_lock, not rw_semaphore?

>     vm_area_struct    ...    160   51    2 : ...
> 
> Assuming 40000 vm_area_structs, memory consumption would be:
> baseline: 6040kB
> vma_lock (vm_area_structs+vma_lock): 6280kB+316kB=6596kB
> Total increase: 556kB
> 
> atomic_t might overflow if there are many competing readers, therefore
> vma_read_trylock() implements an overflow check and if that occurs it
> restors the previous value and exits with a failure to lock.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

This patch is indeed an interesting addition indeed, but I can't help but
think it obsoletes the previous one :) We allocate an extra 8 bytes slab
object for the lock, and the pointer to it is also 8 bytes, and requires an
indirection. The vma_lock cache is not cacheline aligned (otherwise it would
be a major waste), so we have potential false sharing with up to 7 other
vma_lock's.
I'd expect if the vma_lock was placed with the relatively cold fields of
vm_area_struct, it shouldn't cause much cache ping pong when working with
that vma. Even if we don't cache align the vma to save memory (would be 192
bytes instead of 160 when aligned) and place the vma_lock and the cold
fields at the end of the vma, it may be false sharing the cacheline with the
next vma in the slab. But that's a single vma, not up to 7, so it shouldn't
be worse?


