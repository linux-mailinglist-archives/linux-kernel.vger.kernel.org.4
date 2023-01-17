Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3309866E6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjAQT3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjAQTOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:14:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C7241B7C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sqjn7HH62j6yzN+lPodxIW/463YLLqHM4Pu7i7CuDbA=; b=Ex/AaOWHR37R8oMcEjxCmXcjAo
        nDl0l/c47RCRWjDMBMtrqachAlZciiZA/0GTanIl6Fyg96pj7Avp7L4TJtEo897AVuglFi//8kWFZ
        G3cdIWlxMbSicNc2gX8v4QoN4mQ2MJbFU1ITRQwshhp9m/pF0odZ9BwZvuzuOHGH0KxA6SOdbLDlw
        77JDB0bs9s/5xFIVhQnzaRfHPlo4QMi24vt/dUdnvzKasmg7dmucwTCk6AwZnthMXd895Gi5EVRBS
        v5Kk21a6BdLiTpNvhKZfwGaNi2jYgtUVNzz20Om8tp1C0L1IEk6oy4/A6pFIgGqRRXQdzMTYdOeH3
        ZDl1bUyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHqfl-009uMY-Sl; Tue, 17 Jan 2023 18:27:02 +0000
Date:   Tue, 17 Jan 2023 18:27:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Hillf Danton <hdanton@sina.com>, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        peterz@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
Message-ID: <Y8bodcnhyMox+QjG@casper.infradead.org>
References: <20230109205336.3665937-42-surenb@google.com>
 <20230116140649.2012-1-hdanton@sina.com>
 <CAJuCfpHoHcZxQZgt4Ki1kiBu9O+sANZQambOa+1gSQu2brPoyA@mail.gmail.com>
 <20230117031632.2321-1-hdanton@sina.com>
 <CAJuCfpFq23m-KYKaDoCS2K2aM8rO7j8aPa0nVPs-_xP2Sf6GGg@mail.gmail.com>
 <20230117083355.2374-1-hdanton@sina.com>
 <CAJuCfpGU3c102mLZBY6UzkbW-DtfpYF77wLgzFpRWagBw8XfMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGU3c102mLZBY6UzkbW-DtfpYF77wLgzFpRWagBw8XfMQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:21:28AM -0800, Suren Baghdasaryan wrote:
> static inline bool vma_read_trylock(struct vm_area_struct *vma)
> {
>        int count, new;
> 
>         /* Check before locking. A race might cause false locked result. */
>        if (READ_ONCE(vma->vm_lock->lock_seq) ==
>            READ_ONCE(vma->vm_mm->mm_lock_seq))
>                 return false;
> 
>         count = atomic_read(&vma->vm_lock->count);
>         for (;;) {
>               /*
>                * Is VMA is write-locked? Overflow might produce false
> locked result.
>                * False unlocked result is impossible because we modify and check
>                * vma->vm_lock_seq under vma->vm_lock protection and
> mm->mm_lock_seq
>                * modification invalidates all existing locks.
>                */
>               if (count < 0)
>                         return false;
> 
>              new = count + 1;
>              /* If atomic_t overflows, fail to lock. */
>              if (new < 0)
>                         return false;
> 
>              /*
>               * Atomic RMW will provide implicit mb on success to pair
> with smp_wmb in
>               * vma_write_lock, on failure we retry.
>               */
>               new = atomic_cmpxchg(&vma->vm_lock->count, count, new);
>                 if (new == count)
>                         break;
>                 count = new;
>                 cpu_relax();

The cpu_relax() is exactly the wrong thing to do here.  See this thread:
https://lore.kernel.org/linux-fsdevel/20230113184447.1707316-1-mjguzik@gmail.com/

