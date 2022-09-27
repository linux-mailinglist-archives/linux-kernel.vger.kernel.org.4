Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2C5EC9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiI0Qpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiI0QpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4B512D37
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664297118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WTa5rbKShIyGoJknw92BfG1x+s2qAF7vnnJsM/DzVR4=;
        b=LpP7nOlxuNbJNFyptJwYymEJT9Q8mYfck6+SypPhex+kCPgxIw7gGDks45ulj581Chv+26
        RnnDjQ/mCx1CF5oMM5EXIfaJGN2xNGbFAomZbYpSaGzLM42Zi2AnYn5RocSQ4qZrIqPBQ5
        F3rnQFTA8LonNS97DHeL08AVnf4SCqc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-191-4PCMQ6sHMEWuYFqqzCrJQA-1; Tue, 27 Sep 2022 12:45:17 -0400
X-MC-Unique: 4PCMQ6sHMEWuYFqqzCrJQA-1
Received: by mail-qk1-f199.google.com with SMTP id bs33-20020a05620a472100b006cef8cfabe2so7701640qkb.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=WTa5rbKShIyGoJknw92BfG1x+s2qAF7vnnJsM/DzVR4=;
        b=PVLzFZAQ2TJYgaNrlqOWhNFx1AIixa+yklhMEtVdJEMgF13NZY6WI9iN4PGVFj1XXT
         8T72QCUNwDstlQKob9eEkO1gzGBWIv1It+2embOw0lNEhtVNNe9ugp0ke9JyWoQiMwtG
         zyrT7glY3GcmmVn8soo6vnm54ZUjx/1ennt/Qk2dfYUx9/XYxEExkAqY8T6lDSNza7qw
         rw1ROBzpABG8PrYYAm5vV8KLxynHBYaj0uw03hF1/xfEHQxWvUyKBhWFXfo4iiwtzGtW
         mgQ0pUBX8+7UhX00ceAH+X2ODuwDU/mFMgLUXx+3w3ELEn6hgWtVG/harFCHT7JRymGj
         Xhmw==
X-Gm-Message-State: ACrzQf1S+lYaiCsuox1AgA/ArKCiqfdi0cvrHovIBsi7pni4MUZ7MF2L
        HHv6iQHoS5MtBwQ5buR0e7g0mvUSDN/36/JV182/HHdHyM73w3xoQYrOnQ13RlzEwMH9uRUjKtR
        +uEXDe/0jXk4Ezx1F1gqFKgQL
X-Received: by 2002:a05:620a:2601:b0:6bc:70bb:c56b with SMTP id z1-20020a05620a260100b006bc70bbc56bmr18970159qko.416.1664297116777;
        Tue, 27 Sep 2022 09:45:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5AgLFJmBdANYEOVOVCK9odrG/eAgjCtDCyK2CtvVPq8D05QAsmkYI+yJDhMCoTJ31v1Bm/4A==
X-Received: by 2002:a05:620a:2601:b0:6bc:70bb:c56b with SMTP id z1-20020a05620a260100b006bc70bbc56bmr18970133qko.416.1664297116560;
        Tue, 27 Sep 2022 09:45:16 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id a19-20020ac84d93000000b00342fc6a8e25sm1082638qtw.50.2022.09.27.09.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:45:16 -0700 (PDT)
Date:   Tue, 27 Sep 2022 12:45:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] general protection fault in PageHeadHuge
Message-ID: <YzMomT+OusJnLOPC@x1n>
References: <0000000000006c300705e95a59db@google.com>
 <Yy4g/BKpnJga1toG@monkey>
 <7693a84-bdc2-27b5-2695-d0fe8566571f@google.com>
 <Yy5WHvioerD2Sev1@x1n>
 <Yy8dBrmvDmqlsRXE@x1n>
 <Yy9T/JmVb4ymf6WM@monkey>
 <YzDuHbuo2x/b2Mbr@x1n>
 <YzMjxY5O6Hf/IPTx@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzMjxY5O6Hf/IPTx@monkey>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 09:24:37AM -0700, Mike Kravetz wrote:
> This should guarantee a read fault independent of what pthread_mutex_lock
> does.  However, it still results in the occasional "ERROR: unexpected write
> fault".  So, something else if happening.  I will continue to experiment
> and think about this.

Thanks for verifying this, Mike.  I didn't yet reply but I did have some
update on my side too.  I plan to look deeper and wanted to reply until
that, because I do think there's something special on hugetlb and I still
don't know. I just keep getting distracted by other things.. but maybe I
should still share out what I have already.

I think I already know what had guaranteed the read faults - the NPTL
pthread lib implemented mutex in different types, and the 1st instruction
of lock() is to fetch the mutex type (at offset 0x10) then we know how we
should move on:

(gdb) disas pthread_mutex_lock
Dump of assembler code for function ___pthread_mutex_lock:
   0x00007ffff7e3b0d0 <+0>:     endbr64 
   0x00007ffff7e3b0d4 <+4>:     mov    0x10(%rdi),%eax       <---- read 0x10 of &mutex
   0x00007ffff7e3b0d7 <+7>:     mov    %eax,%edx
   0x00007ffff7e3b0d9 <+9>:     and    $0x17f,%edx
(gdb) ptype pthread_mutex_t
type = union {
    struct __pthread_mutex_s __data;
    char __size[40];
    long __align;
}
(gdb) ptype struct __pthread_mutex_s
type = struct __pthread_mutex_s {
    int __lock;
    unsigned int __count;
    int __owner;
    unsigned int __nusers;
    int __kind;                                              <--- 0x10 offset here
    short __spins;
    short __elision;
    __pthread_list_t __list;
}

I looked directly at asm dumped from the binary I tested to make sure it's
accurate.  So it means with current uffd selftest logically there should
never be a write missing fault (I still don't think it's good to have the
write check though.. but that's separate question to ask).

It also means hugetlb does something special here.  It smells really like
for some reason the hugetlb pgtable got evicted after UFFDIO_COPY during
locking_thread running, then any further lock() (e.g. cmpxchg) or modifying
the counter could trigger a write fault.

OTOH this also explained why futex code was never tested on userfaultfd
selftest, simply because futex() will always to be after that "read the
type of mutex" thing.. which is something I want to rework a bit, so as to
have uffd selftest to cover gup as you used to rightfully suggest.  But
that'll be nothing urgent, and be something after we know what's special
with hugetlb new code.

I'll also keep update if I figured something more out of it.

-- 
Peter Xu

