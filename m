Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A34C6B0F25
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCHQrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCHQre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:47:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA70B3297
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678294005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BqlOctcBkSsETU46mMOTJLxPqHzRv7Rfk4a3LKIccfQ=;
        b=gOM/S6Ah3UVQrhVYnI3QgSWsC61gg3YKwKVuqi0vkFrmLx+fW31Bzj/+4Pp6Ii0CGOg3Rr
        LsGeZhu5gSdS/ClB9jY2ZGmhlNMMY+mENn/TOQ4Tvj3DpFf0JGX0syObDyJknnRcFiJsi6
        z2aoEebKWungPHqreUKb2lORgBQ3SYg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-jC_MykGjO6iS8hz_eivogg-1; Wed, 08 Mar 2023 11:46:43 -0500
X-MC-Unique: jC_MykGjO6iS8hz_eivogg-1
Received: by mail-wm1-f69.google.com with SMTP id e17-20020a05600c219100b003e21fa60ec1so1025017wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 08:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678294002;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqlOctcBkSsETU46mMOTJLxPqHzRv7Rfk4a3LKIccfQ=;
        b=doIGNZ/eCrYD9rnCQfnOozzmtK0orSclHlX/H/tQvzS9G2+ohnfl+SM7tNNBIwVskU
         kNKFGh5PaY+/66m81yYT5p0XLksUEobHW+cXpfm13iCYhvNDm15nibOHwZTx4jL0CKtj
         w3yxgWsPrCAvb15OAbuI5kCtWdgymJHzGe1h5MHlIoq23pRMJZw5PNmBljocQWwQK/aw
         sN510I0hoJB6K/UK+EmxvvJL3/4Ox6N/v96pKdN6YpGdVsbgrCn8DqfsbTgal6RA9nbd
         QiDTM476HeHpeM6wLBrMjRg1Eo6yYdCgR9RcbRyqm/XXzAnqzsjdyjD1oAx3OvnmbDHK
         FolQ==
X-Gm-Message-State: AO0yUKXKZhxlcWOdPx7olLUUIATILpYcrSt5p2H82unNJVoNUGbV/fFg
        cOFhwK6JIkwHJh8KJSTKpcufDPTL1BNAZ7+4VyOKxzIU3rHZu8KKYhrbJLWZtGerXTzSIn+SHyi
        l+GQDjJCvvOIN1Czm5Hjiua4G
X-Received: by 2002:a5d:4e8d:0:b0:2c7:e21:4e49 with SMTP id e13-20020a5d4e8d000000b002c70e214e49mr12620200wru.10.1678294002431;
        Wed, 08 Mar 2023 08:46:42 -0800 (PST)
X-Google-Smtp-Source: AK7set8Ki82VVhY+c3Ht1Z8SmQfv1BJICr8iRDn0bQN79OnBGsjA/CXZDi10fUSejgJT/UGzIt8gZw==
X-Received: by 2002:a5d:4e8d:0:b0:2c7:e21:4e49 with SMTP id e13-20020a5d4e8d000000b002c70e214e49mr12620185wru.10.1678294002023;
        Wed, 08 Mar 2023 08:46:42 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:cb00:d372:1da8:9e9e:422d? (p200300cbc71bcb00d3721da89e9e422d.dip0.t-ipconnect.de. [2003:cb:c71b:cb00:d372:1da8:9e9e:422d])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b002ce72cff2ecsm6096995wrr.72.2023.03.08.08.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 08:46:41 -0800 (PST)
Message-ID: <9c995453-8e18-4be1-9e9d-7464f3678301@redhat.com>
Date:   Wed, 8 Mar 2023 17:46:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        syzbot+2ee18845e89ae76342c5@syzkaller.appspotmail.com,
        Matthew Wilcox <willy@infradead.org>, heng.su@intel.com,
        lkp@intel.com, Stable@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
References: <20230307205951.2465275-1-Liam.Howlett@oracle.com>
 <d6670aa7-37ee-85aa-1053-96284a2f6720@redhat.com>
 <20230308161927.lb4npblk2q4vkxmg@revolver>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/ksm: Fix race with ksm_exit() in VMA iteration
In-Reply-To: <20230308161927.lb4npblk2q4vkxmg@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.23 17:19, Liam R. Howlett wrote:
> * David Hildenbrand <david@redhat.com> [230308 04:41]:
>> On 07.03.23 21:59, Liam R. Howlett wrote:
>>> ksm_exit() may remove the mm from the ksm_scan between the unlocking of
>>> the ksm_mmlist and the start of the VMA iteration.  This results in the
>>> mmap_read_lock() not being taken and a report from lockdep that the mm
>>> isn't locked in the maple tree code.
>>
>> I'm confused.
> 
> Thanks for looking at this.  My explanation is incorrect.
> 

Heh, so that explains my confusion :)

>> The code does
>>
>> mmap_read_lock(mm);
>> ...
>> for_each_vma(vmi, vma) {
>> mmap_read_unlock(mm);
>>
>> How can we not take the mmap_read_lock() ? Or am I staring at the wrong
>> mmap_read_lock() ?
> 
> That's the right one.  The mmap lock is taken, but the one we are
> checking is not the correct one.  Let me try again.
> 
> Checking the mm struct against the one in the vmi confirms they are the
> same, so lockdep is telling us the lock we took doesn't match what it
> expected.  I verified that the lock is the same before the
> 'for_each_vma()' call by inserting a BUG_ON() which is never triggered
> with the reproducer.
> 
> ksm_test_exit() uses the mm->mm_users atomic to detect an mm exit.  This
> is usually done in mmget(), mmput(), and friends.
> 
> __ksm_exit() and unmerge_and_remove_all_rmap_items() handle freeing by
> use of the mm->mm_count atomic. This is usually via mmgrab() and mmdrop().
> 
> mmput() will call __mmput() if mm_users is decremented to zero.
> __mmput() calls mmdrop() after the ksm_exit() and then continue with
> teardown.
> 
> So, I believe what is happening is that the external lock flag is being
> cleared from the maple tree (the one lockdep checks) before we call the
> iterator.
> 

Thanks for the explanation.

So, IIUC, we are really only fixing  a lockdep issue, assuming that the 
maple tree cleanup code leaves the maple tree in a state where an 
iterator essentially exits right away. Further, I assume this wasn't a 
problem before the maple tree: there would simply be no VMAs to iterate.

> task 1					task 2
> unmerge_and_remove_all_rmap_items()
>   spin_lock(&ksm_mmlist_lock);
>   ksm_scan.mm_slot is set
>   spin_unlock(&ksm_mmlist_lock);
> 
> =======================================================================
> 	At this point mm->mm_users is 0, but mm_count is not as it will
> 	be decremented at the end of __mmput().
> =======================================================================
> 
> 					__mmput()
>   					 ksm_exit()
> 					  __ksm_exit()
> 					   spin_lock(&ksm_mmlist_lock);
> 					   mm_slot is set
> 					   spin_unlock(&ksm_mmlist_lock)
> 					   mm_slot == ksm_scan.mm_slot
> 					   mmap_write_lock();
> 					   mmap_write_unlock();
> 					   return
> 					 exit_mmap()
> 					   ...
> 					   mmap_write_lock();
> 					   __mt_destory()
> 					     Free all maple tree nodes
> 					     mt->flags = 0;
> 					   mmap_write_unlock();
> 					   ...
> 
>   mmap_read_lock()
>   for_each_vma()
>     lockdep checks *internal* spinlock
> 
> 
> This was fine before the change as the previous for loop would not have
> checked the locking and would have hit the ksm_test_exit() test before
> any problem arose.
> 
> Now we are getting a lockdep warning because the maple tree flag for the
> external lock is cleared.
> 
> How about this as the start to the commit message:
> 
> The VMA iterator may trigger a lockdep warning if the mm is in the
> process of being cleaned up before obtaining the mmap_read_lock().

Maybe something like the following (matches my understanding, as an 
inspiration):

"
exit_mmap() will tear down the VMAs (maple tree) with the mmap_lock held 
in write mode. Once we take the mmap_lock in read mode in 
unmerge_and_remove_all_rmap_items(), we are protected against such 
concurrent teardown, however, the teardown might already have happened 
just the way KSM slot registration machinery works.

Without the VMA iterator, we didn't care. But with the VMA iterator, 
lockdep will now complain when stumbling over a the destroyed maple tree.

Let's check for the teardown by relying on ksm_test_exit() earlier, 
before working on a torn down maple tree.
"

> 
>>
>>>
>>> Fix the race by checking if this mm has been removed before iterating
>>> the VMAs. __ksm_exit() uses the mmap lock to synchronize the freeing of
>>> an mm, so it is safe to keep iterating over the VMAs when it is going to
>>> be freed.
>>>
>>> This change will slow down the mm exit during the race condition, but
>>> will speed up the non-race scenarios iteration over the VMA list, which
>>> should be much more common.
>>
>> Would leaving the existing check in help to just stop scanning faster in
>> that case?
> 
> Yes.  But why?  We would stop the scanning faster in the race condition
> case, but slow the normal case down.
> 
> This check was here to ensure that the mm isn't being torn down while
> it's iterating over the loop.  Hugh (Cc'ed) added this in 2009, but the
> fundamental problem he specifies in his commit message in 9ba692948008
> ("ksm: fix oom deadlock") is that exit_mmap() does not take the
> mmap_lock() - which is no longer the case.  We are safe to iterate the
> VMAs with the mmap_read_lock() as the mmap_write_lock() is taken during
> tear down of the VMA tree today.
> 

Right. I just spotted that we have a ksm_test_exit() already in 
unmerge_ksm_pages(), so that should be sufficient to make us stop 
scanning in case ksm_exit() is waiting for the mmap lock.


Adding a comment summarizing why that's required before iterating would 
be nice. Like

/* Exit right away if the maple tree might have been torn down. */


With a better description, feel free to add

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

