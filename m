Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65AB68279D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjAaIxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjAaIxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:53:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5485C442CF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675154826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJbeBzcV4TWL0jebm/OUMAc1K3T5Nk9LlHTe0trXExM=;
        b=V8tCZWy9YDPcu+yGOErI0AIpMQgD0wEJcQteNOZuRxtPHNolmbR4qXRiFIa7bgnU77EfJD
        7XtqatR++U3DhR/fFpk43vlGNDal7iFyxzEA5OfyGobXum59I28s+T393c8TmeRQsQeqgP
        9zOKumqm0ZPXJC1ZBn9M6DOOVoX9siE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-5-ffmjEN5iOdKjlHdFtdQRSA-1; Tue, 31 Jan 2023 03:47:04 -0500
X-MC-Unique: ffmjEN5iOdKjlHdFtdQRSA-1
Received: by mail-wm1-f71.google.com with SMTP id d14-20020a05600c34ce00b003dd07ce79c8so1607841wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJbeBzcV4TWL0jebm/OUMAc1K3T5Nk9LlHTe0trXExM=;
        b=nj9TNUCHskOs9JjT6vYa9wCu33KTHjUqqzGmW/RBRlzPe95A5vcZ+GN7UF6sAEm3D/
         02L5CWHiztaf/wO/LVvZ38wP+qbw0AozXxuJ5xNSazw4jNUjp9CnYg8+UQGLe5/UAyYt
         liVEkArxoq6WnyTGPul8ygWm31ytuXbrvF+xkgnwJnwySOWxcjQeIYHVKYIhrovUSBOV
         MpDievRpDYlp+5+mBqPAN5WTa7bsEnnAY/bxJHfUOvzv7F8efOxx4n/BVSVT0VkOk9Kr
         +La6tG0x8o0Vva/ET0rRI2MpEf8lUP/PErgp4fcy90VYXmn7bno1uji4pa2hF2mXgrnp
         5//A==
X-Gm-Message-State: AFqh2kptuToTmpaEiB+Q0NMZP0nN/MfPVncY3WBQE3EqHZSSc5IrBECo
        IrvZAyCICZf+/jPNmnr5vnbtccczo4cu/rLXEiw5u0EoTKbV/k/ffgirwaYlEXfUsjHQk0hzRGg
        3ZvD0BHDk4vL2HxjMTXwRYSl1Ik0nGCy/iw3nBHj7n0UXwI3cceUDkq/n6B7/u1gaqa9aQq9N
X-Received: by 2002:a05:600c:5488:b0:3da:1e3e:1ce8 with SMTP id iv8-20020a05600c548800b003da1e3e1ce8mr53630075wmb.13.1675154823628;
        Tue, 31 Jan 2023 00:47:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvh7lQeNQsyIFm/SR9ZDxGOpNWOdkerlKVXtNt1BuLbAz5uHp0GAPBMu/t5psiwCY3rWQKS6A==
X-Received: by 2002:a05:600c:5488:b0:3da:1e3e:1ce8 with SMTP id iv8-20020a05600c548800b003da1e3e1ce8mr53630039wmb.13.1675154823235;
        Tue, 31 Jan 2023 00:47:03 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id z24-20020a1cf418000000b003dc36981727sm13025688wma.14.2023.01.31.00.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 00:47:02 -0800 (PST)
Message-ID: <671d9bbb-0f19-2710-00ef-47734085dddc@redhat.com>
Date:   Tue, 31 Jan 2023 09:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1] sparc/mm: don't unconditionally set HW writable bit
 when setting PTE dirty on 64bit
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Xu <peterx@redhat.com>, Hev <r@hev.cc>,
        Anatoly Pugachev <matorola@gmail.com>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
References: <20221212130213.136267-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221212130213.136267-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.22 14:02, David Hildenbrand wrote:
> On sparc64, there is no HW modified bit, therefore, SW tracks via a SW
> bit if the PTE is dirty via pte_mkdirty(). However, pte_mkdirty()
> currently also unconditionally sets the HW writable bit, which is wrong.
> 
> pte_mkdirty() is not supposed to make a PTE actually writable, unless the
> SW writable bit (pte_write()) indicates that the PTE is not
> write-protected. Fortunately, sparc64 also defines a SW writable bit.
> 
> For example, this already turned into a problem in the context of
> THP splitting as documented in commit 624a2c94f5b7 ("Partly revert "mm/thp:
> carry over dirty bit when thp splits on pmd") and might be an issue during
> page migration in mm/migrate.c:remove_migration_pte() as well where we:
> 	if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
> 		pte = pte_mkdirty(pte);
> 
> But more general, anything like:
> 	maybe_mkwrite(pte_mkdirty(pte), vma)
> code is broken on sparc64, because it will unconditionally set the HW
> writable bit even if the SW writable bit is not set.
> 
> Simple reproducer that will result in a writable PTE after ptrace
> access, to highlight the problem and as an easy way to verify if it has
> been fixed:
> 
> --------------------------------------------------------------------------
>   #include <fcntl.h>
>   #include <signal.h>
>   #include <unistd.h>
>   #include <string.h>
>   #include <errno.h>
>   #include <stdlib.h>
>   #include <sys/mman.h>
> 
>   static void signal_handler(int sig)
>   {
>           if (sig == SIGSEGV)
>                   printf("[PASS] SIGSEGV generated\n");
>           else
>                   printf("[FAIL] wrong signal generated\n");
>           exit(0);
>   }
> 
>   int main(void)
>   {
>           size_t pagesize = getpagesize();
>           char data = 1;
>           off_t offs;
>           int mem_fd;
>           char *map;
>           int ret;
> 
>           mem_fd = open("/proc/self/mem", O_RDWR);
>           if (mem_fd < 0) {
>                   fprintf(stderr, "open(/proc/self/mem) failed: %d\n", errno);
>                   return 1;
>           }
> 
>           map = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE|MAP_ANON, -1 ,0);
>           if (map == MAP_FAILED) {
>                   fprintf(stderr, "mmap() failed: %d\n", errno);
>                   return 1;
>           }
> 
>           printf("original: %x\n", *map);
> 
>           /* debug access */
>           offs = lseek(mem_fd, (uintptr_t) map, SEEK_SET);
>           ret = write(mem_fd, &data, 1);
>           if (ret != 1) {
>                   fprintf(stderr, "pwrite(/proc/self/mem) failed with %d: %d\n", ret, errno);
>                   return 1;
>           }
>           if (*map != data) {
>                   fprintf(stderr, "pwrite(/proc/self/mem) not visible\n");
>                   return 1;
>           }
> 
>           printf("ptrace: %x\n", *map);
> 
>           /* Install signal handler. */
>           if (signal(SIGSEGV, signal_handler) == SIG_ERR) {
>                   fprintf(stderr, "signal() failed\n");
>                   return 1;
>           }
> 
>           /* Ordinary access. */
>           *map = 2;
> 
>           printf("access: %x\n", *map);
> 
>           printf("[FAIL] SIGSEGV not generated\n");
> 
>           return 0;
>   }
> --------------------------------------------------------------------------
> 
> Without this commit (sun4u in QEMU):
> 	# ./reproducer
> 	original: 0
> 	ptrace: 1
> 	access: 2
> 	[FAIL] SIGSEGV not generated
> 
> Let's fix this by setting the HW writable bit only if both, the SW dirty
> bit and the SW writable bit are set. This matches, for example, how
> s390x handles pte_mkwrite() and pte_mkdirty() -- except, that they have
> to clear the _PAGE_PROTECT bit.
> 
> We have to move pte_dirty() and pte_dirty() up. The code patching
> mechanism and handling constants > 22bit is a bit special on sparc64.
> 
> With this commit (sun4u in QEMU):
> 	# ./reproducer
> 	original: 0
> 	ptrace: 1
> 	[PASS] SIGSEGV generated
> 
> This handling seems to have been in place forever.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Hev <r@hev.cc>
> Cc: Anatoly Pugachev <matorola@gmail.com>
> Cc: Raghavendra K T <raghavendra.kt@amd.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Ping

-- 
Thanks,

David / dhildenb

