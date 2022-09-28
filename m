Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFBD5EE211
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiI1QmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiI1QmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB091D4DF3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664383328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnuxJM/ZwkodECcGRXyyBt7TlcJVtOiq1PshYO6uCqs=;
        b=blTNi5scQUYwPnRaN6uO6VIn2tTgsA2TECEYWHHq4Rxf5XPoT5DyVDmPW51IJoJ7NOZpER
        KDogZVMXxV4/G2kKCOJ89ZS3BRG4Nln95A5GTOUzT08y3im/YLPHU1Pa9hL1dE4yqhAmf9
        Fu1ebKredeYUOfbVRVHjBh9z0UAcSWk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-244-mFFpbHNSO369Fa4xjNjyJw-1; Wed, 28 Sep 2022 12:42:05 -0400
X-MC-Unique: mFFpbHNSO369Fa4xjNjyJw-1
Received: by mail-ed1-f72.google.com with SMTP id f18-20020a056402355200b0045115517911so10694060edd.14
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TnuxJM/ZwkodECcGRXyyBt7TlcJVtOiq1PshYO6uCqs=;
        b=ckFf5XENgCxd92ZQX6e4eLEd9aa4Zwf9JvB8/htApm2wDmA6uZDCdzSUTG4/78tWTI
         jreJxLyM8mpsOiUfxtf2XdfqZXjN2UqP/rXZ0x31Y7Zw+2Orl1Phb5Pl5F6HbgcjX3dT
         7q8i28d4a6EV4xtoj6tvj+C5R7TaOhhBcpBvJk/eIQiZGGJml0/CxlgXuO0W8RWiVYFK
         b76Y6siCIxwxxJJcwhEk0clVelmvv7aWTwwHrRKd5s2sLZtoV5qcwBHysweeasOyvWqi
         bBNkCuLIW4xDMgT0acCcgyRvkaEwpgmZ5PFL9l2S4sYGN5sk13KJGLJ4DKbs58apU6Nt
         wO4Q==
X-Gm-Message-State: ACrzQf2nAw564EmfNK7Ce2lphv8DVBK2knfvQDnIQlscJJosCD/ZoSI/
        SV2HQU2tJE9YtyPgPS58jKXhocuwq5mi+cHAeYKfEkIefkJJju4Wk9DTHVafEy0ngbGs/OBzbcA
        1NZg6QLvYq5AHtDBlqlhmXih7
X-Received: by 2002:a17:907:7204:b0:783:e152:f1f1 with SMTP id dr4-20020a170907720400b00783e152f1f1mr10654457ejc.119.1664383324534;
        Wed, 28 Sep 2022 09:42:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5eGcM6h9HE/CoQ6FfSmpE7Agb6ytD+BQYcT0Uc4nG4qcPwaw7CMsOy3vHVNR0VwzTi267SAQ==
X-Received: by 2002:a17:907:7204:b0:783:e152:f1f1 with SMTP id dr4-20020a170907720400b00783e152f1f1mr10654427ejc.119.1664383324304;
        Wed, 28 Sep 2022 09:42:04 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:2f4b:62da:3159:e077? ([2001:b07:6468:f312:2f4b:62da:3159:e077])
        by smtp.googlemail.com with ESMTPSA id d21-20020a170906305500b00773c60c2129sm2653030ejd.141.2022.09.28.09.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 09:42:02 -0700 (PDT)
Message-ID: <bb82895c-31bc-67af-d82d-c9342c665755@redhat.com>
Date:   Wed, 28 Sep 2022 18:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC PATCH 2/9] kvm.h: introduce KVM_SET_USER_MEMORY_REGION_LIST
 ioctl
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
 <20220909104506.738478-3-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220909104506.738478-3-eesposit@redhat.com>
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
> This IOCTL enables atomic update of multiple memslots.
> The userspace application provides a kvm_userspace_memory_region_list
> containing a list of entries, each representing a modification to be
> performed to a memslot.
> 
> Requests with invalidate_slot == 1 are pre-processed, because they
> are ther DELETE or MOVE, and therefore the memslot must be first
> replaced with a copy marked as KVM_MEMSLOT_INVALID, and then replaced.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>   include/uapi/linux/kvm.h | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index a36e78710382..673496b91a25 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -103,6 +103,24 @@ struct kvm_userspace_memory_region {
>   	__u64 userspace_addr; /* start of the userspace allocated memory */
>   };
>   
> +/* for KVM_SET_USER_MEMORY_REGION_LIST */
> +struct kvm_userspace_memory_region_entry {
> +	__u32 slot;
> +	__u32 flags;
> +	__u64 guest_phys_addr;
> +	__u64 memory_size; /* bytes */
> +	__u64 userspace_addr; /* start of the userspace allocated memory */
> +	__u8 invalidate_slot;
> +	__u8 padding[31];
> +};
> +
> +/* for KVM_SET_USER_MEMORY_REGION_LIST */
> +struct kvm_userspace_memory_region_list {
> +	__u32 nent;
> +	__u32 flags;
> +	struct kvm_userspace_memory_region_entry entries[0];
> +};
> +
>   /*
>    * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
>    * other bits are reserved for kvm internal use which are defined in
> @@ -1444,7 +1462,8 @@ struct kvm_vfio_spapr_tce {
>   					struct kvm_userspace_memory_region)
>   #define KVM_SET_TSS_ADDR          _IO(KVMIO,   0x47)
>   #define KVM_SET_IDENTITY_MAP_ADDR _IOW(KVMIO,  0x48, __u64)
> -
> +#define KVM_SET_USER_MEMORY_REGION_LIST _IOW(KVMIO, 0x49, \
> +					struct kvm_userspace_memory_region_list)
>   /* enable ucontrol for s390 */
>   struct kvm_s390_ucas_mapping {
>   	__u64 user_addr;

Looks good; however, in the non-RFC I suggest adding documentation in 
this patch already (so no Reviewed-by yet).

Paolo

