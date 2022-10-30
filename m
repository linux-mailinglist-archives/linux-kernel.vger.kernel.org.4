Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D499E612937
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 09:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJ3IyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ3IyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 04:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE83282
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667119994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ug3pxX4HPcbNDxJWRXky7y5LLTOMNoC//3Zjo+CrCY=;
        b=Pm8TsOCjjFyytVt95fdy2Tvhv2KVo4kO1dkFuHyjCRJhUlYISOmDFN5f9aTnQlV3kn+Uf+
        LEKxkKWrj9RQTStAgUxfUXFA7eHYHKhnUZc5bP9ZW79FyNjQAPYIIh1n6YfnebkoN7zUc0
        M+HOgHeckrRoQLqEk2aFW5l9OYr5+Dg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-88-u-5gKjEMMaKS1bglWca-ig-1; Sun, 30 Oct 2022 04:53:13 -0400
X-MC-Unique: u-5gKjEMMaKS1bglWca-ig-1
Received: by mail-wr1-f69.google.com with SMTP id r22-20020adfa156000000b0023660e969ddso1897646wrr.19
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 01:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ug3pxX4HPcbNDxJWRXky7y5LLTOMNoC//3Zjo+CrCY=;
        b=2rdYYhHIgF8Ucr09rx6NgE+6VyR4osvZ2nlwYwnAzP3oFkYUncx8q8xZMIdwYtV0eO
         OTEdgqftEsz5ViGRBX28Kzq86fmvVwDNxYv8kgG19so+gptdKM0Y1RnEFtxK7DnFdxE0
         k7EDto8U4O/QtL2JEBe8iGyADXD5ujbyxbHN497m8md9oXRuaE/BlqyVcw5UsC+OEj3/
         p2RfYj7+nieDQYDXYGtlQst2vhGPh0E9abJB+IvQE7Ekh28DPq1xBhiJQNvHpIOOrraD
         /BJ85RUdsoLvx+pERzOqp46Xa9+B7Y5VVwA7TJYa+EnP0KSRrcKAchl7rxsBbAEfDPm3
         uCeg==
X-Gm-Message-State: ACrzQf3o3lhRJKOMUh8L6k1hLwlpDerCl8WZ1lAsBl9OKzv0LBhoR2rW
        kuEjRyx+3K1mNxhhYswAw22ZYayGQDpF6TnMhNzH3771EByHSVSUrdv3+ybHd2GrlFWi0JHqda+
        efYkaWuativMP1nxEinMl2Xo9
X-Received: by 2002:a05:600c:1c1e:b0:3c6:fa3c:32a9 with SMTP id j30-20020a05600c1c1e00b003c6fa3c32a9mr14441640wms.203.1667119991858;
        Sun, 30 Oct 2022 01:53:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6lZDMsSed4FBRL/Hmhwu+Bl/MfjZMGqk9SKCEp2LGFbK6UB8TlHAzXk7aWZHqw19d4RXP8OA==
X-Received: by 2002:a05:600c:1c1e:b0:3c6:fa3c:32a9 with SMTP id j30-20020a05600c1c1e00b003c6fa3c32a9mr14441626wms.203.1667119991534;
        Sun, 30 Oct 2022 01:53:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72e:3a00:ac1c:31e7:ee53:498d? (p200300cbc72e3a00ac1c31e7ee53498d.dip0.t-ipconnect.de. [2003:cb:c72e:3a00:ac1c:31e7:ee53:498d])
        by smtp.gmail.com with ESMTPSA id bi22-20020a05600c3d9600b003b31c560a0csm3849232wmb.12.2022.10.30.01.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 01:53:11 -0700 (PDT)
Message-ID: <5a434798-9083-c806-4d3c-f0cb4f27e559@redhat.com>
Date:   Sun, 30 Oct 2022 09:53:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        syzbot <syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
References: <000000000000ed009f05ec257623@google.com>
 <Y13GwSF8e6vMyYyY@monkey>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [syzbot] WARNING in hugetlb_wp
In-Reply-To: <Y13GwSF8e6vMyYyY@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.22 02:35, Mike Kravetz wrote:
> On 10/28/22 22:15, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    247f34f7b803 Linux 6.1-rc2
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14a9efd2880000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
>> dashboard link: https://syzkaller.appspot.com/bug?extid=f0b97304ef90f0d0b1dc
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112217b4880000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105f4616880000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/de212436b09b/disk-247f34f7.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/63c4feda220f/vmlinux-247f34f7.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 3612 at mm/hugetlb.c:5313 hugetlb_wp+0x20a/0x1af0 mm/hugetlb.c:5313
> 
> This warning was added with commit 1d8d14641fd94 ("mm/hugetlb: support write-faults
> in shared mappings").  It is there 'by design' as this this specific
> type of write fault is not supported.
> 
> 	/*
> 	 * hugetlb does not support FOLL_FORCE-style write faults that keep the
> 	 * PTE mapped R/O such as maybe_mkwrite() would do.
> 	 */
> 	if (WARN_ON_ONCE(!unshare && !(vma->vm_flags & VM_WRITE)))
> 		return VM_FAULT_SIGSEGV;
> 
> If there is an actual use case for this support, we can look at adding it.

Right, it's by design and in retrospective it was the right approach to add this
check there. We seem to have a way to trigger a hugetlb write
fault without VM_WRITE set from GUP. We have to fence that.


Interestingly, I thought I tried to trigger that exact scenario.

a) Have a MAP_PRIVATE, PROT_READ hugetlb mapping
b) Try writing to it via /proc/self/mem, triggering debug access with FOLL_FORCE

The expectation is that this will fail with -EFAULT on hugetlb. I could have
sworn that it did the right thing when I tried :)


But staring at follow_hugetlb_page(), I think we will end up triggering a
write fault (FAULT_FLAG_WRITE) on hugetlb.


The easiest fix might be to special-case hugetlb VMA in check_vma_flags():


 From 39d2a525cae62e7d2766ecfc4337ed4d59555d9d Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Sun, 30 Oct 2022 09:45:50 +0100
Subject: [PATCH] mm/gup: disallow FOLL_FORCE on hugetlb mappings

TODO

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/gup.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index fe195d47de74..b934687efdec 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1076,6 +1076,9 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
  			 */
  			if (!is_cow_mapping(vm_flags))
  				return -EFAULT;
+			/* hugetlb does not support FOLL_FORCE. */
+			if (is_vm_hugetlb_page(vma))
+				return -EFAULT;
  		}
  	} else if (!(vm_flags & VM_READ)) {
  		if (!(gup_flags & FOLL_FORCE))
-- 
2.37.3



-- 
Thanks,

David / dhildenb

