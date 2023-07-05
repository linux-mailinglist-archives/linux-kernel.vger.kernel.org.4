Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52473747ABD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 02:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGEAeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 20:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGEAeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 20:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87463E47
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 17:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688517204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sznGK6ZukwvfWp0A8i4mc61vcYJsrjsNcN47/Lw0qI8=;
        b=Z6l26/zlFF+k+R+BzUS3g2OzE9rayT6I5HEhlUu5OLOpfSgqJZ6AN2bDhXxaHErBligXCp
        ionPQBcbXwY20czdpXNZVwPuqA1Ci53PjV7nhZ9ue2M30OpkRcflPOcQRt7CHS8gut0hI+
        9jUGncE4MNPAzmijPeSqyDRvvXk2kqM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-fPqNKWfbNUW0miRPygW3OA-1; Tue, 04 Jul 2023 20:33:23 -0400
X-MC-Unique: fPqNKWfbNUW0miRPygW3OA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-55b0e37e4deso5914642a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 17:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688517203; x=1691109203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sznGK6ZukwvfWp0A8i4mc61vcYJsrjsNcN47/Lw0qI8=;
        b=TtN8wWPUPMhcyU6DYGmA3AM61iN583/GDZmLU0gf9CHUPYiMAJCoAfv4VElQuCiS/p
         4Z+yAakZGGz/ZcH6BgWR8Eyh0DNf4WJ4w7+16itfx9P5aU/Uekmc+6yDAfZINY50RBb1
         195B5EB+58TOf80rfJQo8MepjTp9ZrfeygRuOqFyEi5VW6lhuAPWVDkUdRcyByNneWfe
         Aji/poJ747nrmznYs60T4gkQnW/6wTDAYTC4tTi+TA35fcAiVj99UHykq3B6mndYwwAY
         RYi5eruH8/jCA1x1RQVH4uhB2SM7poxpuCbhKfyR0dgK2FBSSV/aSUb5Vg8U+H0yVtm5
         VsGQ==
X-Gm-Message-State: ABy/qLYx796pJZ5vr+h2dgmQY+9s49ltFn6DudnEDfIIM6gCtDbGhLqE
        zpN+x72NLwqFNSdXYW3nrvAS1PI4p5W5DyibPjHc9V8wWqPRsDXsPzxgGj1ovPbyte3xJ1I3YAi
        CIEHYEEtWql9/Facjr6Ux9nBR
X-Received: by 2002:a05:6a20:1601:b0:12f:4d11:5f74 with SMTP id l1-20020a056a20160100b0012f4d115f74mr2599848pzj.58.1688517202486;
        Tue, 04 Jul 2023 17:33:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFvypcLwb/KPkwH9ar4hG3nsZmNacj2rbML5ruL00tj8y35B6pCwD/DI8RaK0glisLwI/suTQ==
X-Received: by 2002:a05:6a20:1601:b0:12f:4d11:5f74 with SMTP id l1-20020a056a20160100b0012f4d115f74mr2599827pzj.58.1688517202196;
        Tue, 04 Jul 2023 17:33:22 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001ac897026cesm17766726plh.102.2023.07.04.17.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 17:33:21 -0700 (PDT)
Message-ID: <6b8dd9cd-784c-b9e1-73de-6c84deba9426@redhat.com>
Date:   Wed, 5 Jul 2023 10:33:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH v5 08/11] KVM: arm64: Implement
 kvm_arch_flush_remote_tlbs_range()
Content-Language: en-US
To:     Raghavendra Rao Ananta <rananta@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20230621175002.2832640-1-rananta@google.com>
 <20230621175002.2832640-9-rananta@google.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230621175002.2832640-9-rananta@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/23 03:49, Raghavendra Rao Ananta wrote:
> Implement kvm_arch_flush_remote_tlbs_range() for arm64
> to invalidate the given range in the TLB.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>   arch/arm64/include/asm/kvm_host.h | 3 +++
>   arch/arm64/kvm/mmu.c              | 7 +++++++
>   2 files changed, 10 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 81ab41b84f436..343fb530eea9c 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -1081,6 +1081,9 @@ struct kvm *kvm_arch_alloc_vm(void);
>   #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS
>   int kvm_arch_flush_remote_tlbs(struct kvm *kvm);
>   
> +#define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
> +int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn, u64 pages);
> +
>   static inline bool kvm_vm_is_protected(struct kvm *kvm)
>   {
>   	return false;
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index d0a0d3dca9316..c3ec2141c3284 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -92,6 +92,13 @@ int kvm_arch_flush_remote_tlbs(struct kvm *kvm)
>   	return 0;
>   }
>   
> +int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn, u64 pages)
> +{
> +	kvm_tlb_flush_vmid_range(&kvm->arch.mmu,
> +				start_gfn << PAGE_SHIFT, pages << PAGE_SHIFT);
> +	return 0;
> +}
> +
>   static bool kvm_is_device_pfn(unsigned long pfn)
>   {
>   	return !pfn_is_map_memory(pfn);

