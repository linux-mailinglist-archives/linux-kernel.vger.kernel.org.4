Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F25EE209
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiI1QlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiI1QlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383BD4306
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664383266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7yvyDDhwOplvoLz2+l06fL345Nn5UtPbR9Hw95aATs=;
        b=alvt6ZYIsY9C8PdFqakYkMitvWiVn2f9KxXiXQV0JRSkEQhkI86VJhpRcDgwTolcH3rZCD
        b4TjRy0iP103WFIfp3zUL2DGVjJgKA9OAWAErEsqmAD5jOkTC/DzmJlFVZ272T3tpHEv4l
        ZiTtgnV0nEYJcFFd1ddxZM3IqqMo/7M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-380-lZfj6OfbMjuxfsDdo84bcA-1; Wed, 28 Sep 2022 12:41:04 -0400
X-MC-Unique: lZfj6OfbMjuxfsDdo84bcA-1
Received: by mail-ej1-f72.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso5757941ejb.14
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=w7yvyDDhwOplvoLz2+l06fL345Nn5UtPbR9Hw95aATs=;
        b=ANCGxe+xn2X2Nu0ntKxcNOrjVWvpuo7wK4rDkaorzT+LXOvEtfXLnTdz6FhLJyd++T
         FvjG+0oG+ZkulqZuvf29+XGqpleAMTe7n7DjAhd5YvU5HFUjqI4mYHkPMA18BmuyPVhV
         GLlKIvvRzxt5ZLO+LW9ru3danngFclbUKYRnZjMSzemYLFoNUuVdJ0/epAjxvkm1I45r
         25t9yxK0JzaNZSz9lPJVpanWlVk1CT4c0mjNmx/XM9G8YpohHMhA6odd0h975b57+NR2
         NFPl03AaOQeT1nCniFZBDCH4zIgzvATsEBpil+YtWRcvnvlEO401TGlN2+4Ebm0x4R2z
         cLQw==
X-Gm-Message-State: ACrzQf3WY0NAlFLUhPhza33J2UpTj1niZS2tZaMzwq45Ij87ypY2wz6B
        fcD/WScg+8FfLZlPtNVS0L9lz2S1w+Q8K6gZucocibbr3KvKL8GngccmhvNkRmPrjfnZxOjzkQF
        bpLBZorEgTsxeUoJtEjKQO3wU
X-Received: by 2002:a17:907:6d08:b0:787:9027:cb8d with SMTP id sa8-20020a1709076d0800b007879027cb8dmr3401977ejc.396.1664383263306;
        Wed, 28 Sep 2022 09:41:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Jcx7MPqyjKrpHwcNInTTEPHhpMUmanQgJUCBtx3WSFeMZShooq5VirFuKXWAC719U1JKwrg==
X-Received: by 2002:a17:907:6d08:b0:787:9027:cb8d with SMTP id sa8-20020a1709076d0800b007879027cb8dmr3401954ejc.396.1664383263072;
        Wed, 28 Sep 2022 09:41:03 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:2f4b:62da:3159:e077? ([2001:b07:6468:f312:2f4b:62da:3159:e077])
        by smtp.googlemail.com with ESMTPSA id t15-20020a1709067c0f00b00772b5835c12sm2624370ejo.23.2022.09.28.09.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 09:41:02 -0700 (PDT)
Message-ID: <46bc34f2-2a3d-8f38-a9f5-85bb9494285f@redhat.com>
Date:   Wed, 28 Sep 2022 18:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC PATCH 1/9] kvm_main.c: move slot check in
 kvm_set_memory_region
Content-Language: en-US
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20220909104506.738478-1-eesposit@redhat.com>
 <20220909104506.738478-2-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220909104506.738478-2-eesposit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 12:44, Emanuele Giuseppe Esposito wrote:
> And make kvm_set_memory_region static, since it is not used outside
> kvm_main.c
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>   include/linux/kvm_host.h |  2 --
>   virt/kvm/kvm_main.c      | 11 +++++------
>   2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 3b40f8d68fbb..1c5b7b2e35dd 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1108,8 +1108,6 @@ enum kvm_mr_change {
>   	KVM_MR_FLAGS_ONLY,
>   };
>   
> -int kvm_set_memory_region(struct kvm *kvm,
> -			  const struct kvm_userspace_memory_region *mem);
>   int __kvm_set_memory_region(struct kvm *kvm,
>   			    const struct kvm_userspace_memory_region *mem);
>   void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index da263c370d00..339de0ed4557 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2007,24 +2007,23 @@ int __kvm_set_memory_region(struct kvm *kvm,
>   }
>   EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
>   
> -int kvm_set_memory_region(struct kvm *kvm,
> -			  const struct kvm_userspace_memory_region *mem)
> +static int kvm_set_memory_region(struct kvm *kvm,
> +				 const struct kvm_userspace_memory_region *mem)
>   {
>   	int r;
>   
> +	if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
> +		return -EINVAL;
> +
>   	mutex_lock(&kvm->slots_lock);
>   	r = __kvm_set_memory_region(kvm, mem);
>   	mutex_unlock(&kvm->slots_lock);
>   	return r;
>   }
> -EXPORT_SYMBOL_GPL(kvm_set_memory_region);
>   
>   static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
>   					  struct kvm_userspace_memory_region *mem)
>   {
> -	if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
> -		return -EINVAL;
> -
>   	return kvm_set_memory_region(kvm, mem);
>   }
>   

The idea here was that kvm_set_memory_region could be used to set 
private memory slots while not taking kvm->slots_lock.

So, I would instead:

1) rename __kvm_set_memory_region to kvm_set_memory_region;

2) inline the old kvm_set_memory_region into kvm_vm_ioctl_set_memory_region.

3) replace the comment "Must be called holding kvm->slots_lock for 
write." with a proper lockdep_assert_held() now that the function 
doesn't have the __ warning sign in front of it.

Paolo

