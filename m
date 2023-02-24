Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8111E6A19FE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjBXKUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjBXKUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:20:18 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9091F196B9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:20:14 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id k14so16317136lfj.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hEwsz4UUnsL1QET78UClGRYs4m/AnPiP7Yj0wQq8Jxw=;
        b=K8tTsNNp5D8tUYAWhc2GO1NhLYzTyEV34gBYen+1QJKaxzkqjRa3AWMJcSOfNHlHJG
         XYwRthsOp4fXPgJi9/Mok2mlb6tP6wljqhtbZ20etjStPicx6oN4TqcMBH0Hwc9blRTr
         NWV9SWr1QYDFgjJbwMQszkQrv9s3KTRVPzH3hfvyMb3y7whA43mEA6/ctqwWRcqKa/3G
         2wTDP4FdqEOHvihpJXRSVxqIGbcE+Xr4Vqeg6jkSQMYukPKi/ioMjlbVl+nsRLuF3qI4
         guw35siVBLvOJuR1jtPE55mgdNMfzSWXsmYF6bqpfNddGkvDf9C3+HCSIfN66WxqRxaB
         nz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEwsz4UUnsL1QET78UClGRYs4m/AnPiP7Yj0wQq8Jxw=;
        b=QfhOw82PzXV51IHxGUEVVrD+y83G0TggQx3jQar3a4S/wCQNjHDfNCIxdODerv+Avq
         kLR5YdQar3okD0d2Old2MDF4hQ1Tmupbxh4oJBkjFE2/xUocKIV2oSQFz3L9Hw70Zrq+
         hEjG5L5e1l5LAXPIni8WJBR04jasy8URqMIKrDUfJRnm1S6ojace0ww+7ORoPTmsAqCY
         qON5Q52vqqT5vkBWn/6viQPIPVERIbRoVx5PDZnkjdfDaXAcjWuJpVDk8SSfclG6tBpC
         wn1mYblUdYYidpdcIfoZUTua1p+y1BTegkSBuivMoNE7VIUVRAAvTUqF6qa5Lp688KdU
         xOmw==
X-Gm-Message-State: AO0yUKU4ApofG7MHMU8z2tFaQmSzpVtooTCdpekyrG1Y5GJW9gILy/Ka
        95KV+Iv6aIvI6S8pSZX2vxFWVcqDPcbCPpaIXzmYIg==
X-Google-Smtp-Source: AK7set8pSd+vhBCeJWziASLZGOpsuRNu5oEjKmnP1K9G95zIvZq4Seu4EvlZk0HiUCIBWV2b7rOFhPfETP1R7DZhKa4=
X-Received: by 2002:a05:6512:516:b0:4dc:807a:d148 with SMTP id
 o22-20020a056512051600b004dc807ad148mr4755043lfb.7.1677234012621; Fri, 24 Feb
 2023 02:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20230214211229.3239350-1-quic_eberman@quicinc.com> <20230214212417.3315422-1-quic_eberman@quicinc.com>
In-Reply-To: <20230214212417.3315422-1-quic_eberman@quicinc.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 24 Feb 2023 10:19:36 +0000
Message-ID: <CA+EHjTxEeiBWXJMCnv0V+5n=jB8w=m0EFdgK=FKtSqKOkiaChg@mail.gmail.com>
Subject: Re: [PATCH v10 12/26] gunyah: vm_mgr: Add/remove user memory regions
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 14, 2023 at 9:26 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
>
> When launching a virtual machine, Gunyah userspace allocates memory for
> the guest and informs Gunyah about these memory regions through
> SET_USER_MEMORY_REGION ioctl.

I'm working on pKVM [1], and regarding the problem of donating private
memory to a guest, we and others working on confidential computing
have faced a similar issue that this patch is trying to address. In
pKVM, we've initially taken an approach similar to the one here by
pinning the pages being donated to prevent swapping or migration [2].
However, we've encountered issues with this approach since the memory
is still mapped by the host, which could cause the system to crash on
an errant access.

Instead, we've been working on adopting an fd-based restricted memory
approach that was initially proposed for TDX [3] and is now being
considered by others in the confidential computing space as well
(e.g., Arm CCA [4]). The basic idea is that the host manages the guest
memory via a file descriptor instead of a userspace address. It cannot
map that memory (unless explicitly shared by the guest [5]),
eliminating the possibility of the host trying to access private
memory accidentally or being tricked by a malicious actor. This is
based on memfd with some restrictions. It handles swapping and
migration by disallowing them (for now [6]), and adds a new type of
memory region to KVM to accommodate having an fd representing guest
memory.

Although the fd-based restricted memory isn't upstream yet, we've
ported the latest patches to arm64 and made changes and additions to
make it work with pKVM, to test it and see if the solution is feasible
for us (it is). I wanted to mention this work in case you find it
useful, and in the hopes that we can all work on confidential
computing using the same interfaces as much as possible.

Some comments inline below...

Cheers,
/fuad

[1] https://lore.kernel.org/kvmarm/20220519134204.5379-1-will@kernel.org/
[2] https://lore.kernel.org/kvmarm/20220519134204.5379-34-will@kernel.org/
[3] https://lore.kernel.org/all/20221202061347.1070246-1-chao.p.peng@linux.intel.com/
[4] https://lore.kernel.org/lkml/20230127112932.38045-1-steven.price@arm.com/
[5] This is a modification we've done for the arm64 port, after
discussing it with the original authors.
[6] Nothing inherent in the proposal to stop migration and swapping.
There are some technical issues that need to be resolved.

<snip>

> +int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region)
> +{
> +       struct gh_vm_mem *mapping, *tmp_mapping;
> +       struct gh_rm_mem_entry *mem_entries;
> +       phys_addr_t curr_page, prev_page;
> +       struct gh_rm_mem_parcel *parcel;
> +       int i, j, pinned, ret = 0;
> +       size_t entry_size;
> +       u16 vmid;
> +
> +       if (!gh_api_has_feature(GH_API_FEATURE_MEMEXTENT))
> +               return -EOPNOTSUPP;
> +
> +       if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
> +               !PAGE_ALIGNED(region->userspace_addr) || !PAGE_ALIGNED(region->guest_phys_addr))
> +               return -EINVAL;
> +
> +       ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +       if (ret)
> +               return ret;
> +       mapping = __gh_vm_mem_find(ghvm, region->label);
> +       if (mapping) {
> +               mutex_unlock(&ghvm->mm_lock);
> +               return -EEXIST;
> +       }
> +
> +       mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
> +       if (!mapping) {
> +               ret = -ENOMEM;
> +               goto free_mapping;
> +       }
> +
> +       mapping->parcel.label = region->label;
> +       mapping->guest_phys_addr = region->guest_phys_addr;
> +       mapping->npages = region->memory_size >> PAGE_SHIFT;
> +       parcel = &mapping->parcel;
> +       parcel->mem_handle = GH_MEM_HANDLE_INVAL; /* to be filled later by mem_share/mem_lend */
> +       parcel->mem_type = GH_RM_MEM_TYPE_NORMAL;
> +
> +       /* Check for overlap */
> +       list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
> +               if (!((mapping->guest_phys_addr + (mapping->npages << PAGE_SHIFT) <=
> +                       tmp_mapping->guest_phys_addr) ||
> +                       (mapping->guest_phys_addr >=
> +                       tmp_mapping->guest_phys_addr + (tmp_mapping->npages << PAGE_SHIFT)))) {
> +                       ret = -EEXIST;
> +                       goto free_mapping;
> +               }
> +       }
> +
> +       list_add(&mapping->list, &ghvm->memory_mappings);
> +
> +       mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL);
> +       if (!mapping->pages) {
> +               ret = -ENOMEM;
> +               mapping->npages = 0; /* update npages for reclaim */
> +               goto reclaim;
> +       }

These pages should be accounted for as locked pages, e.g.,
account_locked_vm(), which would also ensure that the process hasn't
reached its limit.

> +       pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
> +                                       FOLL_WRITE | FOLL_LONGTERM, mapping->pages);

It might be good to check and avoid donating pages with pre-faulted
file mappings since it might trigger a writeback of a page after
losing access to it. Ideally, you want to only accept anonymous or
shmem pages. In pKVM, we check that the pages are SwapBacked and
reject the pinning/donation otherwise [2].

> +       if (pinned < 0) {
> +               ret = pinned;
> +               mapping->npages = 0; /* update npages for reclaim */
> +               goto reclaim;
> +       } else if (pinned != mapping->npages) {
> +               ret = -EFAULT;
> +               mapping->npages = pinned; /* update npages for reclaim */
> +               goto reclaim;
> +       }
> +
> +       if (region->flags & GH_MEM_LENT) {
> +               parcel->n_acl_entries = 1;
> +               mapping->share_type = VM_MEM_LEND;
> +       } else {
> +               parcel->n_acl_entries = 2;
> +               mapping->share_type = VM_MEM_SHARE;
> +       }
> +       parcel->acl_entries = kcalloc(parcel->n_acl_entries, sizeof(*parcel->acl_entries),
> +                                       GFP_KERNEL);
> +       if (!parcel->acl_entries) {
> +               ret = -ENOMEM;
> +               goto reclaim;
> +       }
> +
> +       parcel->acl_entries[0].vmid = cpu_to_le16(ghvm->vmid);
> +       if (region->flags & GH_MEM_ALLOW_READ)
> +               parcel->acl_entries[0].perms |= GH_RM_ACL_R;
> +       if (region->flags & GH_MEM_ALLOW_WRITE)
> +               parcel->acl_entries[0].perms |= GH_RM_ACL_W;
> +       if (region->flags & GH_MEM_ALLOW_EXEC)
> +               parcel->acl_entries[0].perms |= GH_RM_ACL_X;
> +
> +       if (mapping->share_type == VM_MEM_SHARE) {
> +               ret = gh_rm_get_vmid(ghvm->rm, &vmid);
> +               if (ret)
> +                       goto reclaim;
> +
> +               parcel->acl_entries[1].vmid = cpu_to_le16(vmid);
> +               /* Host assumed to have all these permissions. Gunyah will not
> +                * grant new permissions if host actually had less than RWX
> +                */
> +               parcel->acl_entries[1].perms |= GH_RM_ACL_R | GH_RM_ACL_W | GH_RM_ACL_X;
> +       }
> +
> +       mem_entries = kcalloc(mapping->npages, sizeof(*mem_entries), GFP_KERNEL);
> +       if (!mem_entries) {
> +               ret = -ENOMEM;
> +               goto reclaim;
> +       }
> +
> +       /* reduce number of entries by combining contiguous pages into single memory entry */
> +       prev_page = page_to_phys(mapping->pages[0]);
> +       mem_entries[0].ipa_base = cpu_to_le64(prev_page);
> +       entry_size = PAGE_SIZE;
> +       for (i = 1, j = 0; i < mapping->npages; i++) {
> +               curr_page = page_to_phys(mapping->pages[i]);
> +               if (page_contiguous(prev_page, curr_page)) {
> +                       entry_size += PAGE_SIZE;
> +               } else {
> +                       mem_entries[j].size = cpu_to_le64(entry_size);
> +                       j++;
> +                       mem_entries[j].ipa_base = cpu_to_le64(curr_page);
> +                       entry_size = PAGE_SIZE;
> +               }
> +
> +               prev_page = curr_page;
> +       }
> +       mem_entries[j].size = cpu_to_le64(entry_size);
> +
> +       parcel->n_mem_entries = j + 1;
> +       parcel->mem_entries = kmemdup(mem_entries, sizeof(*mem_entries) * parcel->n_mem_entries,
> +                                       GFP_KERNEL);
> +       kfree(mem_entries);
> +       if (!parcel->mem_entries) {
> +               ret = -ENOMEM;
> +               goto reclaim;
> +       }
> +
> +       mutex_unlock(&ghvm->mm_lock);
> +       return 0;
> +reclaim:
> +       gh_vm_mem_reclaim(ghvm, mapping);
> +free_mapping:
> +       kfree(mapping);
> +       mutex_unlock(&ghvm->mm_lock);
> +       return ret;
> +}
> +
> +int gh_vm_mem_free(struct gh_vm *ghvm, u32 label)
> +{
> +       struct gh_vm_mem *mapping;
> +       int ret;
> +
> +       ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +       if (ret)
> +               return ret;
> +
> +       mapping = __gh_vm_mem_find(ghvm, label);
> +       if (!mapping)
> +               goto out;
> +
> +       gh_vm_mem_reclaim(ghvm, mapping);
> +       kfree(mapping);
> +out:
> +       mutex_unlock(&ghvm->mm_lock);
> +       return ret;
> +}
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index 10ba32d2b0a6..d85d12119a48 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -20,4 +20,37 @@
>   */
>  #define GH_CREATE_VM                   _IO(GH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
>
> +/*
> + * ioctls for VM fds
> + */
> +
> +/**
> + * struct gh_userspace_memory_region - Userspace memory descripion for GH_VM_SET_USER_MEM_REGION

nit: s/descripion/description

> + * @label: Unique identifer to the region.

nit: s/identifer/identifier




> + * @flags: Flags for memory parcel behavior
> + * @guest_phys_addr: Location of the memory region in guest's memory space (page-aligned)
> + * @memory_size: Size of the region (page-aligned)
> + * @userspace_addr: Location of the memory region in caller (userspace)'s memory
> + *
> + * See Documentation/virt/gunyah/vm-manager.rst for further details.
> + */
> +struct gh_userspace_memory_region {
> +       __u32 label;
> +#define GH_MEM_ALLOW_READ      (1UL << 0)
> +#define GH_MEM_ALLOW_WRITE     (1UL << 1)
> +#define GH_MEM_ALLOW_EXEC      (1UL << 2)
> +/*
> + * The guest will be lent the memory instead of shared.
> + * In other words, the guest has exclusive access to the memory region and the host loses access.
> + */
> +#define GH_MEM_LENT            (1UL << 3)
> +       __u32 flags;
> +       __u64 guest_phys_addr;
> +       __u64 memory_size;
> +       __u64 userspace_addr;
> +};
> +
> +#define GH_VM_SET_USER_MEM_REGION      _IOW(GH_IOCTL_TYPE, 0x1, \
> +                                               struct gh_userspace_memory_region)
> +
>  #endif
> --
> 2.39.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
