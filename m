Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78FA72A1CA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjFISFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjFISFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA92A30F6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686333852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zAp0pJ+sm+Y3KQgNoeZPqvSvGD8UdvXtUGa2VdIgLpc=;
        b=aJNKGZOw8YPM477A4bxP/3Z7lEVAexYT3oVpOkm2Pj4usItY/12xiin7zZwsntmKIUkpeq
        a3Krw6WSv1ATdSkxztu1sHGMtnSuGlDlepV6K7chuyGFUcrnf6UioevWPhjNmwXmpIjfsj
        wx+lRMI1MVEAAfGu6FxUGqQUQpjDOyk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-FnenP1cqPmuqVcV9rHF8wg-1; Fri, 09 Jun 2023 14:04:04 -0400
X-MC-Unique: FnenP1cqPmuqVcV9rHF8wg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75b337f2504so45960085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686333843; x=1688925843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAp0pJ+sm+Y3KQgNoeZPqvSvGD8UdvXtUGa2VdIgLpc=;
        b=h9vJHzh2p+u7j+7863yG/nUB7u2X6SxQ2oleat3aGorU7nVLKRYxvrbH3Y2AglJ/Ep
         nM5cIGUDa/lSi8WnJ+w6Yf77nUW0bKGKMPXYItClGRdA4XnSKpNyZcgR/C//Ece3t3WQ
         EWs2Kp1z0EhKHLfgrWeTYDqfevL+2/hEMAeEURUq2UGyCCTXXFL9ryXr4toUqxk8zYrX
         aKcvtYp4Fb5TXqPc0dIl04IqzRun8iRJpTxOzCqjfGPeug+7GXEcC6b/c/ZU4uV7653G
         cm0rfQmyaZUSeOobh6VM88LdhOL5k3fd1TPCtmAs+RFcBRiKV6BzV1wGHLsDgjFuuwKr
         NLOA==
X-Gm-Message-State: AC+VfDywWOPPaqFimqIenGcNnicyyyMuafeK76B89gNswV0C94GKDESK
        UCvdvNjgR8t+synS2uZgfhg2Tp8JZIXLs0rYz58AUxZKucgPpu9fLQAZAQ6DWuEJNta75guFEnt
        8wb/kE10fzft9fkO296COGLAT
X-Received: by 2002:a05:620a:2541:b0:75b:23a1:69e2 with SMTP id s1-20020a05620a254100b0075b23a169e2mr2352403qko.2.1686333843404;
        Fri, 09 Jun 2023 11:04:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RtNMoxDtjGYkQZW5n83BGYz2gukU3kZCJd9ZjCOGjHFFrwfCXZgSNY8VDEKzXausmue5/Hg==
X-Received: by 2002:a05:620a:2541:b0:75b:23a1:69e2 with SMTP id s1-20020a05620a254100b0075b23a169e2mr2352373qko.2.1686333843126;
        Fri, 09 Jun 2023 11:04:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id o12-20020a05620a15cc00b0075b17afcc1esm1177922qkm.115.2023.06.09.11.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:04:02 -0700 (PDT)
Date:   Fri, 9 Jun 2023 14:04:00 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        seanjc@google.com, oliver.upton@linux.dev, aarcange@redhat.com,
        david@redhat.com, hshuai@redhat.com, zhenyzha@redhat.com,
        shan.gavin@gmail.com
Subject: Re: [PATCH v2] KVM: Avoid illegal stage2 mapping on invalid memory
 slot
Message-ID: <ZINpkOCYoDBQYhdq@x1n>
References: <20230609100420.521351-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230609100420.521351-1-gshan@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 08:04:20PM +1000, Gavin Shan wrote:
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
>   CPU-A                    CPU-B
>   -----                    -----
>                            ioctl(kvm_fd, KVM_SET_USER_MEMORY_REGION)
>                            kvm_vm_ioctl_set_memory_region
>                            kvm_set_memory_region
>                            __kvm_set_memory_region
>                            kvm_set_memslot(kvm, old, NULL, KVM_MR_DELETE)
>                              kvm_invalidate_memslot
>                                kvm_copy_memslot
>                                kvm_replace_memslot
>                                kvm_swap_active_memslots        (A)
>                                kvm_arch_flush_shadow_memslot   (B)
>   same page sharing by KSM
>   kvm_mmu_notifier_invalidate_range_start
>         :
>   kvm_mmu_notifier_change_pte
>     kvm_handle_hva_range
>     __kvm_handle_hva_range       (C)
>         :
>   kvm_mmu_notifier_invalidate_range_end
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

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

