Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937BA6138CB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiJaOOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJaOO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B8EB89
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667225613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TN1WuiGmPpk9MolU7GTSPQhkCNCkfR+YTWS4lzKVmXk=;
        b=fs8eq9H225E2Oxj5Gg8E9HWVlj8YgxpSc29vb9Ez/ZYpK3g9DQaOPlFcPTV++V+8bGNBRk
        Z/xejH/Ehz7VBIxXVIVmu/Bwqz/vcLkCgh+NgBcrsrMm47Csv3cu5sUj6JmFxnSHP67GNQ
        lV5HjBhJ3oBtSyii3vGLZl8Mxn/JfU8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-201-YVQIKRi-PMuWqR04eR6Ncg-1; Mon, 31 Oct 2022 10:13:31 -0400
X-MC-Unique: YVQIKRi-PMuWqR04eR6Ncg-1
Received: by mail-wm1-f72.google.com with SMTP id bg21-20020a05600c3c9500b003c2acbff422so5779994wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TN1WuiGmPpk9MolU7GTSPQhkCNCkfR+YTWS4lzKVmXk=;
        b=hAIxCAAcSrAjWekOAj9peHPIQOUPqWH8lek+P40YXVGEEjDv4kmhorBroa1GX4DhTv
         oSXZyZVXxV2wYveso7hxedu6ByywioTF5xoZBDmXouSN+NITc+c0KdQvqe1gDUTrJy7K
         nPutmxdKDUwXLyH5O4wGqvmy7rGje3prGLdMzg8NVdxvyKY5puXul7yI6mBYyHwk9qXi
         mmfuBIldmNDPGtA10aofrrqUeFrtpIABphteqC62wUvqwtb8tJPGPoNnjeUaoWRBhOW8
         kjb6r+fxwsNuOWZvIZSm4Wn/ORS3/2nkZGNsbvaP0dGN15qs9VqZQiOqgvuxnndqmOyJ
         Erzw==
X-Gm-Message-State: ACrzQf3u59fQcRanTw2ctnhUYfA+dKSULG9FjcVwbAvkILYydLHPG2g7
        CF5xpLUN7Ce/qLmm66qN17y+Fl3W2MP9QckK24VePbFX0wNj8hFQxIqwL8c2np4wj32npwZTN5d
        8tnEUOBckwc78HOidMSXgMHwj
X-Received: by 2002:a5d:5009:0:b0:236:c907:76fc with SMTP id e9-20020a5d5009000000b00236c90776fcmr4318427wrt.274.1667225608618;
        Mon, 31 Oct 2022 07:13:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7W7jbAENY1xk4Aez6Wv1vsoS4IbvcoV2Piv1Diwc+GekZJDmWiFtrZgQ3xDxfm2t6XEZLbXw==
X-Received: by 2002:a5d:5009:0:b0:236:c907:76fc with SMTP id e9-20020a5d5009000000b00236c90776fcmr4318409wrt.274.1667225608295;
        Mon, 31 Oct 2022 07:13:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:b300:ab9a:1f1f:ddaf:3b1d? (p200300cbc705b300ab9a1f1fddaf3b1d.dip0.t-ipconnect.de. [2003:cb:c705:b300:ab9a:1f1f:ddaf:3b1d])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c182bef9sm8126014wmz.36.2022.10.31.07.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 07:13:27 -0700 (PDT)
Message-ID: <29813e1d-cc08-8805-00e3-34f472260b69@redhat.com>
Date:   Mon, 31 Oct 2022 15:13:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [syzbot] WARNING in hugetlb_wp
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        syzbot <syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
References: <000000000000ed009f05ec257623@google.com>
 <Y13GwSF8e6vMyYyY@monkey> <5a434798-9083-c806-4d3c-f0cb4f27e559@redhat.com>
Organization: Red Hat
In-Reply-To: <5a434798-9083-c806-4d3c-f0cb4f27e559@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.22 09:53, David Hildenbrand wrote:
> On 30.10.22 02:35, Mike Kravetz wrote:
>> On 10/28/22 22:15, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    247f34f7b803 Linux 6.1-rc2
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14a9efd2880000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=f0b97304ef90f0d0b1dc
>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112217b4880000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105f4616880000
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/de212436b09b/disk-247f34f7.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/63c4feda220f/vmlinux-247f34f7.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
>>>
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 1 PID: 3612 at mm/hugetlb.c:5313 hugetlb_wp+0x20a/0x1af0 mm/hugetlb.c:5313
>>
>> This warning was added with commit 1d8d14641fd94 ("mm/hugetlb: support write-faults
>> in shared mappings").  It is there 'by design' as this this specific
>> type of write fault is not supported.
>>
>> 	/*
>> 	 * hugetlb does not support FOLL_FORCE-style write faults that keep the
>> 	 * PTE mapped R/O such as maybe_mkwrite() would do.
>> 	 */
>> 	if (WARN_ON_ONCE(!unshare && !(vma->vm_flags & VM_WRITE)))
>> 		return VM_FAULT_SIGSEGV;
>>
>> If there is an actual use case for this support, we can look at adding it.
> 
> Right, it's by design and in retrospective it was the right approach to add this
> check there. We seem to have a way to trigger a hugetlb write
> fault without VM_WRITE set from GUP. We have to fence that.
> 
> 
> Interestingly, I thought I tried to trigger that exact scenario.
> 
> a) Have a MAP_PRIVATE, PROT_READ hugetlb mapping
> b) Try writing to it via /proc/self/mem, triggering debug access with FOLL_FORCE
> 
> The expectation is that this will fail with -EFAULT on hugetlb. I could have
> sworn that it did the right thing when I tried :)
> 
> 
> But staring at follow_hugetlb_page(), I think we will end up triggering a
> write fault (FAULT_FLAG_WRITE) on hugetlb.
> 
> 
> The easiest fix might be to special-case hugetlb VMA in check_vma_flags():
> 
> 
>   From 39d2a525cae62e7d2766ecfc4337ed4d59555d9d Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Sun, 30 Oct 2022 09:45:50 +0100
> Subject: [PATCH] mm/gup: disallow FOLL_FORCE on hugetlb mappings
> 
> TODO
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>    mm/gup.c | 3 +++
>    1 file changed, 3 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index fe195d47de74..b934687efdec 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1076,6 +1076,9 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>    			 */
>    			if (!is_cow_mapping(vm_flags))
>    				return -EFAULT;
> +			/* hugetlb does not support FOLL_FORCE. */
> +			if (is_vm_hugetlb_page(vma))
> +				return -EFAULT;
>    		}
>    	} else if (!(vm_flags & VM_READ)) {
>    		if (!(gup_flags & FOLL_FORCE))


A simple reproducer:


#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <stdint.h>
#include <sys/mman.h>
#include <linux/mman.h>

int main(int argc, char **argv)
{
         char *map;
         int mem_fd;

         map = mmap(NULL, 2 * 1024 * 1024u, PROT_READ,
                    MAP_PRIVATE|MAP_ANON|MAP_HUGETLB|MAP_HUGE_2MB, -1, 0);
         if (map == MAP_FAILED) {
                 fprintf(stderr, "mmap() failed: %d\n", errno);
                 return 1;
         }

         mem_fd = open("/proc/self/mem", O_RDWR);
         if (mem_fd < 0) {
                 fprintf(stderr, "open(/proc/self/mem) failed: %d\n", errno);
                 return 1;
         }

         if (pwrite(mem_fd, "0", 1, (uintptr_t) map) == 1) {
                 fprintf(stderr, "write() succeeded, which is unexpected\n");
                 return 1;
         }

         printf("write() failed as expected: %d\n", errno);
         return 0;
}



I started looking at the follow_hugetlb_page() call in __get_user_pages() and
my head seriously started to hurt.

Why are we storing to "i" and error from follow_hugetlb_page()->hugetlb_fault()
and then eventually happily continuing?

I'm afraid of touching that code, it looks too fragile.

Hopefully I am missing something important and it's all perfectly
fine code.


-- 
Thanks,

David / dhildenb

