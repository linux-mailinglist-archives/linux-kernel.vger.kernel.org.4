Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13276A4A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjB0TBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjB0TA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:00:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4591EB6E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677524391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJsvYk7GXp8I4COeJ3t1hMqXzf5hp4/G1Bgw17Xxk70=;
        b=KHmgx5/k7S4VKN7tEqeUtOK4Qui5MajX2/B7QkM1E05Yjs4jAmLDtJ0cgqrkAQN5ktYWP+
        qzsNkItc4CMBP6oxP/w0q56Xawia4q+4jRdrQDisU2LD0wW2c4gek0wq8HzCJHPlnz5lgh
        08ioqtaV1DkJNn3mPOlkIKr6YBOPP20=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-107-G5RKbHsbNiesujeUzjQ71g-1; Mon, 27 Feb 2023 13:59:50 -0500
X-MC-Unique: G5RKbHsbNiesujeUzjQ71g-1
Received: by mail-ed1-f69.google.com with SMTP id g33-20020a056402322100b004b0e54e03acso9254276eda.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:59:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJsvYk7GXp8I4COeJ3t1hMqXzf5hp4/G1Bgw17Xxk70=;
        b=wkxW3O1cNSPQs2CUTa5jaPlXlmFGAu18OW3ZUEe2mUdeaY1kP3DgUvtriZXhhk7f2T
         wFUDlj8OnKS9w8kKKY7Eu1bxuXXSpaP7c0pZtfocJHhMbZ/TSk7JrlBvrONlnjiQimh/
         mktNAxAb0rfjcdT+/mrdYzFbc/MF1mA5jO5RETFr6iGDgrcjMpDpsJZooOqMlKwt5bP0
         2veOI7/gOx7Vh6HLZmj2EFj6RSspRukxuMhNYAQLkQdqjRJTl2GZcemDS5WNB7CbuvpL
         L9KB9i2j7Te9aEmoWa/VWXGtiauDExAPV+niVu3UOpZjEcJAj5y5mFN2QfUc/CXNEzZn
         oxqg==
X-Gm-Message-State: AO0yUKW8bTOZ3bA8pkmC8n97Bt1jRZ8ib2vCMPmjxwbBoHSzVbWzAE3j
        3qntIZuSMWtWRm2cVmXgRYElZNSRgpBtkdcChVTHpJv5FVspgP8m0p91qdnibH4hxD84kiMg6d4
        DkTEggTbeyqIemFX59MbAOc8J
X-Received: by 2002:a17:907:76f3:b0:878:50f7:a35a with SMTP id kg19-20020a17090776f300b0087850f7a35amr31180640ejc.72.1677524389408;
        Mon, 27 Feb 2023 10:59:49 -0800 (PST)
X-Google-Smtp-Source: AK7set/nAXyU6HErE/WKmVJkdOcUhliWwVp6EtClu1WGQ8XxsSLsimgCTlXes6YRi85ETu9ws3e7Hw==
X-Received: by 2002:a17:907:76f3:b0:878:50f7:a35a with SMTP id kg19-20020a17090776f300b0087850f7a35amr31180622ejc.72.1677524389137;
        Mon, 27 Feb 2023 10:59:49 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id i16-20020a17090685d000b008b7a9ff7dfdsm3436723ejy.162.2023.02.27.10.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 10:59:48 -0800 (PST)
Message-ID: <f5b0e10a-d7ab-66cb-95dd-48c8f7aa3a46@redhat.com>
Date:   Mon, 27 Feb 2023 19:59:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH drm-next v2 04/16] maple_tree: add flag MT_FLAGS_LOCK_NONE
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     matthew.brost@intel.com, dri-devel@lists.freedesktop.org,
        corbet@lwn.net, nouveau@lists.freedesktop.org, ogabbay@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, boris.brezillon@collabora.com,
        bskeggs@redhat.com, tzimmermann@suse.de, Liam.Howlett@oracle.com,
        bagasdotme@gmail.com, christian.koenig@amd.com,
        jason@jlekstrand.net
References: <20230217134422.14116-1-dakr@redhat.com>
 <20230217134422.14116-5-dakr@redhat.com>
 <Y+/Xn11dfdn7SfBD@casper.infradead.org>
 <3bb02ec3-4d19-9135-cabc-26ed210f7396@redhat.com>
 <Y/ONYhyDCPEYH1ml@casper.infradead.org>
 <e43f6acc-175d-1031-c4a2-67a6f1741866@redhat.com>
 <Y/PZH/q2Xsr3od9m@casper.infradead.org> <Y/TXPasvkhtGiR+w@pollux>
 <Y/UN50hCaRe+8ZCg@casper.infradead.org>
 <67942a68-2ae7-8883-25d7-c6d595c3587e@redhat.com>
 <Y/z4QMyIkZLi4Ruw@casper.infradead.org>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <Y/z4QMyIkZLi4Ruw@casper.infradead.org>
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

On 2/27/23 19:36, Matthew Wilcox wrote:
> On Mon, Feb 27, 2023 at 06:39:33PM +0100, Danilo Krummrich wrote:
>> On 2/21/23 19:31, Matthew Wilcox wrote:
>>> Lockdep will shout at you if you get it wrong ;-)  But you can safely
>>> take the spinlock before calling mas_store_gfp(GFP_KERNEL) because
>>> mas_nomem() knows to drop the lock before doing a sleeping allocation.
>>> Essentially you're open-coding mtree_store_range() but doing your own
>>> thing in addition to the store.
>>
>> As already mentioned, I went with your advice to just take the maple tree's
>> internal spinlock within the GPUVA manager and leave all the other locking
>> to the drivers as intended.
>>
>> However, I run into the case that lockdep shouts at me for not taking the
>> spinlock before calling mas_find() in the iterator macros.
>>
>> Now, I definitely don't want to let the drivers take the maple tree's
>> spinlock before they use the iterator macro. Of course, drivers shouldn't
>> even know about the underlying maple tree of the GPUVA manager.
>>
>> One way to make lockdep happy in this case seems to be taking the spinlock
>> right before mas_find() and drop it right after for each iteration.
> 
> While we don't have any lockdep checking of this, you really shouldn't be
> using an iterator if you're going to drop the lock between invocations.
> The iterator points into the tree, so you need to invalidate the iterator
> any time you drop the lock.

The tree can't change either way in my case. Changes to the DRM GPUVA 
manager (and hence the tree) are protected by drivers, either by 
serializing tree accesses or by having another external lock ensuring 
mutual exclusion. Just as a reminder, in the latter case drivers usually 
lock multiple transactions to the manager (and hence the tree) to ensure 
they appear atomic.

So, really the only purpose for me taking the internal lock is to ensure 
I satisfy lockdep and the maple tree's internal requirements on locking 
for future use cases you mentioned (e.g. slab cache defragmentation).

It's the rcu_dereference_check() in mas_root() that triggers in my case:

[   28.745706] lib/maple_tree.c:851 suspicious rcu_dereference_check() 
usage!

                stack backtrace:
[   28.746057] CPU: 8 PID: 1518 Comm: nouveau_dma_cop Not tainted 
6.2.0-rc6-vmbind-0.2+ #104
[   28.746061] Hardware name: ASUS System Product Name/PRIME Z690-A, 
BIOS 2103 09/30/2022
[   28.746064] Call Trace:
[   28.746067]  <TASK>
[   28.746070]  dump_stack_lvl+0x5b/0x77
[   28.746077]  mas_walk+0x16d/0x1b0
[   28.746082]  mas_find+0xf7/0x300
[   28.746088]  drm_gpuva_in_region+0x63/0xa0
[   28.746099]  __drm_gpuva_sm_map.isra.0+0x465/0x9f0
[   28.746103]  ? lock_acquire+0xbf/0x2b0
[   28.746111]  ? __pfx_drm_gpuva_sm_step+0x10/0x10
[   28.746114]  ? lock_is_held_type+0xe3/0x140
[   28.746121]  ? mark_held_locks+0x49/0x80
[   28.746125]  ? _raw_spin_unlock_irqrestore+0x30/0x60
[   28.746138]  drm_gpuva_sm_map_ops_create+0x80/0xc0
[   28.746145]  uvmm_bind_job_submit+0x3c2/0x470 [nouveau]
[   28.746272]  nouveau_job_submit+0x60/0x450 [nouveau]
[   28.746393]  nouveau_uvmm_ioctl_vm_bind+0x179/0x1e0 [nouveau]
[   28.746510]  ? __pfx_nouveau_uvmm_ioctl_vm_bind+0x10/0x10 [nouveau]
[   28.746622]  drm_ioctl_kernel+0xa9/0x160
[   28.746629]  drm_ioctl+0x1f7/0x4b0

> 
> You don't have to use a spinlock to do a read iteration.  You can just
> take the rcu_read_lock() around your iteration, as long as you can
> tolerate the mild inconsistencies that RCU permits.
>

Doing that would mean that the driver needs to do it. However, the 
driver either needs to serialize accesses or use it's own mutex for 
protection for the above reasons. Hence, that should not be needed.


