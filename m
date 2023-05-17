Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9C1706A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjEQNus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjEQNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594B230C2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684331374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0e/SUf5A48wwb3JWMFE3HoGFxkqjXULKhzRKlOy/0Pk=;
        b=D+cUMwKcoCvT3kPxSGKhpNNP//1GVnxHNoG6XMQlocc0QdylKZtAZFa8QixJLjLGlZBvja
        3/b5DadzdjnNrn8dvh71qxh9hUWcUXcEbG2zH+anBNozzl6ugjvldl0gXciTf1Mu/ykwhG
        DBfSv8HJ/9FyGPzxEU2+GVpM9YXdSVM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-9LkkrXLiMWuhOyde5-ORew-1; Wed, 17 May 2023 09:49:31 -0400
X-MC-Unique: 9LkkrXLiMWuhOyde5-ORew-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f509037a45so46384845e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684331369; x=1686923369;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0e/SUf5A48wwb3JWMFE3HoGFxkqjXULKhzRKlOy/0Pk=;
        b=DrtrZ3pfDowRchTcUyFPxYb3i9RgkYv/c0SxvuwpH+Ed2RpAel1Up+57Mjf8d//7SS
         mGWhYXmGdkyVFS21sM5Ip4iLj/DXCNk+f1mnVLJj0dojIawRA6EVs77P6dfnihFsF/dM
         TzdNaLnLlN7ET6pPyexSOf0/2n4JujN5bYM07RPhHNEqPT2Oj9iIBD+jkAHnSzuPwXAQ
         W7TjVCST0ttBwOTj1VUXsOObXJZmawK6VOet+/KaYyRIT72xyg/xLjiBmdXqhBgUBsCD
         j89IkQk/PTgdusaY+Qm4kgL9k83HFL/ghP/6qJbErU59QhWOl6K4SvgCLf6iPREyaIYp
         NrJg==
X-Gm-Message-State: AC+VfDzHPx5snsmVYCxGWUxMmrx3vtEt8eDiU0XjrUkYFH1mQwdJBG0l
        XsFtmk+vnbAF0uGSajfylBGsX0TftYp58v6ucPkAxfXlyTNNKVWoL1+iwp+nrkreO2CL7crz7TB
        qDY9In7KShpNo9Kuoq2XNLHHo
X-Received: by 2002:adf:e74f:0:b0:2f7:cfe2:6507 with SMTP id c15-20020adfe74f000000b002f7cfe26507mr675508wrn.20.1684331369591;
        Wed, 17 May 2023 06:49:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5a5arMtnNTOv8xW4922VW8BZeZ7wJoPt5cnWb7Q96XDpQAvRopJCLeAn9BjbsFKP1k1Lhf+w==
X-Received: by 2002:adf:e74f:0:b0:2f7:cfe2:6507 with SMTP id c15-20020adfe74f000000b002f7cfe26507mr675476wrn.20.1684331369155;
        Wed, 17 May 2023 06:49:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:757e:83f8:a99d:41ae? (p200300cbc7073900757e83f8a99d41ae.dip0.t-ipconnect.de. [2003:cb:c707:3900:757e:83f8:a99d:41ae])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003f17848673fsm2323496wmm.27.2023.05.17.06.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 06:49:28 -0700 (PDT)
Message-ID: <9aa7d030-19b5-01df-70c0-86d8d6ab86a6@redhat.com>
Date:   Wed, 17 May 2023 15:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/7] riscv: Memory Hot(Un)Plug support
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        virtualization@lists.linux-foundation.org, linux@rivosinc.com,
        Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20230512145737.985671-1-bjorn@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230512145737.985671-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.05.23 16:57, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Memory Hot(Un)Plug support for the RISC-V port
> ==============================================
> 
> Introduction
> ------------
> 
> To quote "Documentation/admin-guide/mm/memory-hotplug.rst": "Memory
> hot(un)plug allows for increasing and decreasing the size of physical
> memory available to a machine at runtime."
> 
> This series attempts to add memory hot(un)plug support for the RISC-V
> Linux port.
> 
> I'm sending the series as a v1, but it's borderline RFC. It definitely
> needs more testing time, but it would be nice with some early input.
> 
> Implementation
> --------------
> 
>  From an arch perspective, a couple of callbacks needs to be
> implemented to support hot plugging:
> 
> arch_add_memory()
> This callback is responsible for updating the linear/direct map, and
> call into the memory hot plugging generic code via __add_pages().
> 
> arch_remove_memory()
> In this callback the linear/direct map is tore down.
> 
> vmemmap_free()
> The function tears down the vmemmap mappings (if
> CONFIG_SPARSEMEM_VMEMMAP is in-use), and also deallocates the backing
> vmemmap pages. Note that for persistent memory, an alternative
> allocator for the backing pages can be used -- the vmem_altmap. This
> means that when the backing pages are cleared, extra care is needed so
> that the correct deallocation method is used. Note that RISC-V
> populates the vmemmap using vmemmap_populate_basepages(), so currently
> no hugepages are used for the backing store.
> 
> The page table unmap/teardown functions are heavily based (copied!)
> from the x86 tree. The same remove_pgd_mapping() is used in both
> vmemmap_free() and arch_remove_memory(), but in the latter function
> the backing pages are not removed.
> 
> On RISC-V, the PGD level kernel mappings needs to synchronized with
> all page-tables (e.g. via sync_kernel_mappings()). Synchronization
> involves special care, like locking. Instead, this patch series takes
> a different approach (introduced by Jörg Rödel in the x86-tree);
> Pre-allocate the PGD-leaves (P4D, PUD, or PMD depending on the paging
> setup) at mem_init(), for vmemmap and the direct map.
> 
> Pre-allocating the PGD-leaves waste some memory, but is only enabled
> for CONFIG_MEMORY_HOTPLUG. The number pages, potentially unused, are
> ~128 * 4K.
> 
> Patch 1: Preparation for hotplugging support, by pre-allocating the
>           PGD leaves.
> 
> Patch 2: Changes the __init attribute to __meminit, to avoid that the
>           functions are removed after init. __meminit keeps the
>           functions after init, if memory hotplugging is enabled for
>           the build.
>           
> Patch 3: Refactor the direct map setup, so it can be used for hot add.
> 
> Patch 4: The actual add/remove code. Mostly a page-table-walk
>           exercise.
> 
> Patch 5: Turn on the arch support in Kconfig
> 
> Patch 6: Now that memory hotplugging is enabled, make virtio-mem
>           usable for RISC-V
>           
> Patch 7: Pre-allocate vmalloc PGD-leaves as well, which removes the
>           need for vmalloc faulting.
>           
> RFC
> ---
> 
>   * TLB flushes. The current series uses Big Hammer flush-it-all.
>   * Pre-allocation vs explicit syncs
> 
> Testing
> -------
> 
> ACPI support is still in the making for RISC-V, so tests that involve
> CXL and similar fanciness is currently not possible. Virtio-mem,
> however, works without proper ACPI support. In order to try this out
> in Qemu, some additional patches for Qemu are needed:
> 
>   * Enable virtio-mem for RISC-V
>   * Add proper hotplug support for virtio-mem
>   
> The patch for Qemu can be found is commit 5d90a7ef1bc0
> ("hw/riscv/virt: Support for virtio-mem-pci"), and can be found here
> 
>    https://github.com/bjoto/qemu/tree/riscv-virtio-mem
> 
> I will try to upstream that work in parallel with this.
>    
> Thanks to David Hildenbrand for valuable input for the Qemu side of
> things.
> 
> The series is based on the RISC-V fixes tree
>    https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?h=fixes
> 

Cool stuff! I'm fairly busy right now, so some high-level questions upfront:

What is the memory section size (which implies the memory block size 
and)? This implies the minimum DIMM granularity and the high-level 
granularity in which virtio-mem adds memory.

What is the pageblock size, implying the minimum granularity that 
virtio-mem can operate on?

On x86-64 and arm64 we currently use the ACPI SRAT to expose the maximum 
physical address where we can see memory getting hotplugged. [1] From 
that, we can derive the "max_possible_pfn" and prepare the kernel 
virtual memory layourt (especially, direct map).

Is something similar required on RISC-V? On s390x, I'm planning on 
adding a paravirtualized mechanism to detect where memory devices might 
be located. (I had a running RFC, but was distracted by all other kinds 
of stuff)


[1] https://virtio-mem.gitlab.io/developer-guide.html

-- 
Thanks,

David / dhildenb

