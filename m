Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B42C632AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKURXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKURX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:23:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9307FCE4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:23:24 -0800 (PST)
Received: from [192.168.10.9] (unknown [39.45.241.105])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22D6566029A5;
        Mon, 21 Nov 2022 17:23:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669051402;
        bh=XBAUcHQ1kFMN61zpgZfHhNfm+9S8x0kij55HjK06z1c=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=KsvPIRXEdzFiQ+P7VWKyqzKkcJgdQ5WrgoaJj2J7yT1UBdlKrcnILeA+APMnm/M+W
         UzkVehGPQzlKmLTxIqZmzPNg0LD23mc96xspCva1aouFBT/NEYpNxY3GV8ECc0Bpfe
         PX1N5DJf54TAJJFf7+QBrb5T2e50pjGAs/p/oc0MErhwVSNWtDZXjLEmoD/c1sNAVH
         Af1Nl4u8WtGkfAX0oUSGoM4HredV56yo2dju0FpKnQmUcG99xPENBzKoUxq2Rq30lZ
         ctyWQaGWXqJUYsMdeRfNXi8Cs/wNuaQqqoyXjMaxLNrRoGmYn+iPV3M8cqiCrFaAwI
         TErjADL53BWAw==
Message-ID: <5930891f-7fce-35d5-94a8-95c63840b3c6@collabora.com>
Date:   Mon, 21 Nov 2022 22:23:11 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [Bug 67651] Bisected: Lots of fragmented mmaps cause gimp to fail
 in 3.12 after exceeding vm_max_map_count
To:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrei Vagin <avagin@gmail.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Pavel Emelyanov <xemul@parallels.com>, gnome@rvzt.net,
        drawoc@darkrefraction.com, alan@lxorguk.ukuu.org.uk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bugzilla-daemon@bugzilla.kernel.org, kernel@collabora.com,
        Paul Gofman <pgofman@codeweavers.com>
References: <20140122190816.GB4963@suse.de> <52E04A21.3050101@mit.edu>
 <20140123055906.GS1574@moon>
 <20140122220910.198121ee.akpm@linux-foundation.org>
 <20140123062746.GT1574@moon>
Content-Language: en-US
In-Reply-To: <20140123062746.GT1574@moon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for replying to so much older thread. The original thread:
https://lore.kernel.org/all/20140123151445.GX1574@moon/

On 1/23/14 11:27 AM, Cyrill Gorcunov wrote:
> On Wed, Jan 22, 2014 at 10:09:10PM -0800, Andrew Morton wrote:
>>>>
>>>> That being said, this could cause vma blowups for programs that are
>>>> actually using this thing.
>>>
>>> Hi Andy, indeed, this could happen. The easiest way is to ignore softdirty bit
>>> when we're trying to merge vmas and set it one new merged. I think this should
>>> be correct. Once I finish I'll send the patch.
>>
>> Hang on.  We think the problem is that gimp is generating vmas which
>> *should* be merged, but for unknown reasons they differ in
>> VM_SOFTDIRTY, yes?
> 
> Yes. One place where I forgot to set softdirty bit is setup_arg_pages. But
> it called once on elf load, so it can't cause such effect (but should be
> fixed too). Also there is do_brk where vmasoftdirty is missed too :/
> 
> Another problem is the potential scenario when we have a bunch of vmas
> and clear vma-softdirty bit on them, then we try to map new one, flags
> won't match and instead of extending old vma the new one will be created.
> I think (if only I'm not missing something) that vma-softdirty should
> be ignored in such case (ie inside is_mergeable_vma) and once vma extended
> it should be marked as dirty one. Again, I need to think and test more.
> 
>> Shouldn't we work out where we're forgetting to set VM_SOFTDIRTY? 
>> Putting bandaids over this error when we come to trying to merge the
>> vmas sounds very wrong?
> 
> I'm looking into this as well.
I've looked at it while working on adding an IOCTL to get and/or clear the
soft dirty bit for a particular region only [1]. The VM_SOFTDIRTY should be
set in the vm_flags to be tested if new allocation should be merged in
previous vma or not. With the following patch, the new allocations are
merged in the previous VMAs.

I've tested it by reverting the 34228d473efe ("mm: ignore VM_SOFTDIRTY on
VMA merging") commit and after adding the following patch, I'm seeing that
all the new allocations done through mmap() (in my testing) are merged in
the previous VMAs. The number of VMAs doesn't increase drastically which
had contributed to the crash of gimp. If I run the same test after
reverting and not including the following, the number of VMAs keep on
increasing with every mmap() syscall which proves this patch.

diff --git a/mm/mmap.c b/mm/mmap.c
index f9b96b387a6f..b132d52f6fe1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1708,6 +1708,15 @@ unsigned long mmap_region(struct file *file,
unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}

+	/*
+	 * New (or expanded) vma always get soft dirty status.
+	 * Otherwise user-space soft-dirty page tracker won't
+	 * be able to distinguish situation when vma area unmapped,
+	 * then new mapped in-place (which must be aimed as
+	 * a completely new data area).
+	 */
+	vm_flags |= VM_SOFTDIRTY;
+
 	/*
 	 * Can we just expand an old mapping?
 	 */
@@ -1823,15 +1832,6 @@ unsigned long mmap_region(struct file *file,
unsigned long addr,
 	if (file)
 		uprobe_mmap(vma);

-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vma->vm_flags |= VM_SOFTDIRTY;
-
 	vma_set_page_prot(vma);

 	return addr;
@@ -2998,6 +2998,8 @@ static int do_brk_flags(unsigned long addr, unsigned
long len, unsigned long fla
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;

+	flags |= VM_SOFTDIRTY;
+
 	/* Can we just expand an old private anonymous mapping? */
 	vma = vma_merge(mm, prev, addr, addr + len, flags,
 			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
@@ -3026,7 +3028,7 @@ static int do_brk_flags(unsigned long addr, unsigned
long len, unsigned long fla
 	mm->data_vm += len >> PAGE_SHIFT;
 	if (flags & VM_LOCKED)
 		mm->locked_vm += (len >> PAGE_SHIFT);
-	vma->vm_flags |= VM_SOFTDIRTY;
+
 	return 0;
 }

This patch should be included in the kernel regardless if we revert
34228d473efe or not. Thoughts?


Cyrill is correct about the following:
> Another problem is the potential scenario when we have a bunch of vmas
> and clear vma-softdirty bit on them, then we try to map new one, flags
> won't match and instead of extending old vma the new one will be created.
> I think (if only I'm not missing something) that vma-softdirty should
> be ignored in such case (ie inside is_mergeable_vma) and once vma
> extended
> it should be marked as dirty one. Again, I need to think and test more.
While implementing clear soft-dirty bit for a range of address space, I'm
facing an issue. The non-soft dirty VMA gets merged sometimes with the soft
dirty VMA. Thus the non-soft dirty VMA become dirty which is undesirable.
When discussed with the some other developers they consider it the
regression. Why the non-soft dirty page should appear as soft dirty when it
isn't soft dirty in reality? I agree with them. Should we revert
34228d473efe or find a workaround in the IOCTL?

* Revert may cause the VMAs to expand in uncontrollable situation where the
soft dirty bit of a lot of memory regions or the whole address space is
being cleared again and again. AFAIK normal process must either be only
clearing a few memory regions. So the applications should be okay. There is
still chance of regressions if some applications are already using the
soft-dirty bit. I'm not sure how to test it.

* Add a flag in the IOCTL to ignore the dirtiness of VMA. The user will
surely lose the functionality to detect reused memory regions. But the
extraneous soft-dirty pages would not appear. I'm trying to do this in the
patch series [1]. Some discussion is going on that this fails with some
mprotect use case [2]. I still need to have a look at the mprotect selftest
to see how and why this fails. I think this can be implemented after some
more work.

What are your thoughts?

> 
> 	Cyrill
> 

[1]
https://lore.kernel.org/all/20221109102303.851281-1-usama.anjum@collabora.com/
[2]
https://lore.kernel.org/all/bfcae708-db21-04b4-0bbe-712badd03071@redhat.com/

-- 
BR,
Muhammad Usama Anjum
