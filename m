Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B70572B94D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbjFLH4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjFLH4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A43B115
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686556392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKMBSH67N5nwF8dvLnk58o69SrrghR5lWZu+UnhiuP4=;
        b=Q8nrxc8MyAWXVie9BaGKk78inv65oHwAk08Nar7GvyiVUZ9TI9SUNnGUMTnMuz4+RNZNVd
        9bMBLBKiLQTmqtqt5W4GhYFSUOzJt1maAUd9hDb1R8f/7f7VACA3BYUpjmiEzWRn32ZL+D
        YRoO9zpsyQM+SQz0vXbPjWobckU/P0U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-kBxmZ-9WNcK_UAAHtxwC8w-1; Mon, 12 Jun 2023 03:11:19 -0400
X-MC-Unique: kBxmZ-9WNcK_UAAHtxwC8w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7ef2456dfso15869235e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686553878; x=1689145878;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKMBSH67N5nwF8dvLnk58o69SrrghR5lWZu+UnhiuP4=;
        b=hSwTeuRsq2heR5eOn0i/8QZncHGHkBnXrZNyJj6u8keDjHhG1flqgrHW9lbS2lG+QS
         IpWkMu1+Ylvlhu8aKiabyxoFNxcGpqBeg84SxB2sKc5mOliI1DAYP/DL0ICBjNn86dQj
         GEbDtoRukPDiSGT8jmyU+rH4k+uM4s2AjiOJQBQbdutBCQ3J6DH8p3XjpIJqAd4z7Rzt
         N1z7CoknaPMemjicYusRde2uvgnOFe+Rvts5NXhH/RK3ao+NckSzen8TG0EJKQrsFEmJ
         oBalwOrZ0xtKOFu9z37q8uwi67cPuprl8bkjctzryZolFfFlfRUQcdri5EvkehB1eXy0
         14gg==
X-Gm-Message-State: AC+VfDw/6oQmvR+7HB6grzjhQklnN24sJqNR6XSwT3DzVnmz/XoneaHw
        g+hb01EcaVHtCSceO050yNcZPtne2EJ6giCa6g/mzEJqpwhlBO+azrR0NLJu38Xe+GulGFTSF5e
        Vhk/7MM8SQs6d2GerfKsaQ6rL
X-Received: by 2002:a7b:c347:0:b0:3f7:e7d5:6123 with SMTP id l7-20020a7bc347000000b003f7e7d56123mr5568179wmj.41.1686553878259;
        Mon, 12 Jun 2023 00:11:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7BPeYfMTdMXJlr39jBPXTAxqY1TcRxt8GNzF1y3FLQS/h17pJgr+hsbhDCBxa27Wi7VdEMhA==
X-Received: by 2002:a7b:c347:0:b0:3f7:e7d5:6123 with SMTP id l7-20020a7bc347000000b003f7e7d56123mr5568167wmj.41.1686553877878;
        Mon, 12 Jun 2023 00:11:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003f42a75ac2asm10411399wmc.23.2023.06.12.00.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 00:11:17 -0700 (PDT)
Message-ID: <338e88e6-bbed-f3bb-ead7-f15399f44285@redhat.com>
Date:   Mon, 12 Jun 2023 09:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] KVM: Avoid illegal stage2 mapping on invalid memory
 slot
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.linux.dev
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, maz@kernel.org, seanjc@google.com,
        oliver.upton@linux.dev, aarcange@redhat.com, peterx@redhat.com,
        hshuai@redhat.com, zhenyzha@redhat.com, shan.gavin@gmail.com
References: <20230609100420.521351-1-gshan@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230609100420.521351-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.06.23 12:04, Gavin Shan wrote:
> We run into guest hang in edk2 firmware when KSM is kept as running on
> the host. The edk2 firmware is waiting for status 0x80 from QEMU's pflash
> device (TYPE_PFLASH_CFI01) during the operation of sector erasing or
> buffered write. The status is returned by reading the memory region of
> the pflash device and the read request should have been forwarded to QEMU
> and emulated by it. Unfortunately, the read request is covered by an
> illegal stage2 mapping when the guest hang issue occurs. The read request
> is completed with QEMU bypassed and wrong status is fetched. The edk2
> firmware runs into an infinite loop with the wrong status.
> 
> The illegal stage2 mapping is populated due to same page sharing by KSM
> at (C) even the associated memory slot has been marked as invalid at (B)
> when the memory slot is requested to be deleted. It's notable that the
> active and inactive memory slots can't be swapped when we're in the middle
> of kvm_mmu_notifier_change_pte() because kvm->mn_active_invalidate_count
> is elevated, and kvm_swap_active_memslots() will busy loop until it reaches
> to zero again. Besides, the swapping from the active to the inactive memory
> slots is also avoided by holding &kvm->srcu in __kvm_handle_hva_range(),
> corresponding to synchronize_srcu_expedited() in kvm_swap_active_memslots().
> 
>    CPU-A                    CPU-B
>    -----                    -----
>                             ioctl(kvm_fd, KVM_SET_USER_MEMORY_REGION)
>                             kvm_vm_ioctl_set_memory_region
>                             kvm_set_memory_region
>                             __kvm_set_memory_region
>                             kvm_set_memslot(kvm, old, NULL, KVM_MR_DELETE)
>                               kvm_invalidate_memslot
>                                 kvm_copy_memslot
>                                 kvm_replace_memslot
>                                 kvm_swap_active_memslots        (A)
>                                 kvm_arch_flush_shadow_memslot   (B)
>    same page sharing by KSM
>    kvm_mmu_notifier_invalidate_range_start
>          :
>    kvm_mmu_notifier_change_pte
>      kvm_handle_hva_range
>      __kvm_handle_hva_range       (C)
>          :
>    kvm_mmu_notifier_invalidate_range_end
> 
> Fix the issue by skipping the invalid memory slot at (C) to avoid the
> illegal stage2 mapping so that the read request for the pflash's status
> is forwarded to QEMU and emulated by it. In this way, the correct pflash's
> status can be returned from QEMU to break the infinite loop in the edk2
> firmware.
> 
> Cc: stable@vger.kernel.org # v5.13+
> Fixes: 3039bcc74498 ("KVM: Move x86's MMU notifier memslot walkers to generic code")
> Reported-by: Shuai Hu <hshuai@redhat.com>
> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v2: Improved changelog suggested by Marc
> ---
>   virt/kvm/kvm_main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 479802a892d4..7f81a3a209b6 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -598,6 +598,9 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
>   			unsigned long hva_start, hva_end;
>   
>   			slot = container_of(node, struct kvm_memory_slot, hva_node[slots->node_idx]);
> +			if (slot->flags & KVM_MEMSLOT_INVALID)
> +				continue;
> +
>   			hva_start = max(range->start, slot->userspace_addr);
>   			hva_end = min(range->end, slot->userspace_addr +
>   						  (slot->npages << PAGE_SHIFT));

Nice debugging!

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

