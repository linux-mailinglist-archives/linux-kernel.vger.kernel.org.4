Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235F560B744
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiJXTWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiJXTVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B4C14707E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666634178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HoVxKtFvF89CaNRUtz5f12PECGhvT5ZRQ28BXHOJnzw=;
        b=TuGXfP3F6z8ESbvYFJh5+Tt88MGOM1pXennEjhSYfgiUcAZpksIWmdrTW++xB5X/fOL1hi
        wY+PI+I/3qX91f9FnTC71djeLEVeOFX16eIp44ALtzjuO5j6mqpmUL6wx/L5evMYG7aXsF
        OpkFxaSB3jio8WCaQP6KIdLNEyg7gfg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-kOZrAUKINve0duHbzwQxag-1; Mon, 24 Oct 2022 08:33:07 -0400
X-MC-Unique: kOZrAUKINve0duHbzwQxag-1
Received: by mail-qv1-f69.google.com with SMTP id c2-20020a05621401c200b004bb71b13dfcso915141qvt.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HoVxKtFvF89CaNRUtz5f12PECGhvT5ZRQ28BXHOJnzw=;
        b=StOgZd1ZXaNTUCAbG/dJLqpX82TQ7BgY32kS7gBAfKdog2+/anaJtuuU9Zgb2NIuYb
         OuwC5h1B/M87LfMrgSJUcZPPj3l4pKzd9up3bZJqeN7tt+jX4Qjbc/fE+rex0pmbUZUh
         Qdx4JNxymw+DAdAUYMGT2rrhmtjnE36y9Isj+M1ebn+fZZFYH8/s1s3hHFax0w83dziA
         ThEBEGNvbgJ2lhc1vgzD3Oh9DEFvTinzyqTqEqf/drxDafwUvoDYBOf4kdJnBR38byrw
         74c9lO2FzMuc8lbP83RbFvRrumOhgu1Kk4xE0A5wGcLYLEbR32hh4pQmlPHSiBN3KM1F
         iy2w==
X-Gm-Message-State: ACrzQf0c600qsYdEMTCOLKoMB82jktMRxJMrN+2DVx4ODBDHUCOhrncR
        5J1gNvTpyfcexarUoy+F4TWUpVBdByXfzX2Fn+G/pZZg8UpUj7rIFeRwsgC6v4r/YN8Ad3TOl4U
        illY2EzkWaVjjaGI/MFDUFpsK
X-Received: by 2002:a05:620a:2723:b0:6df:b61f:99f6 with SMTP id b35-20020a05620a272300b006dfb61f99f6mr22995674qkp.3.1666614787386;
        Mon, 24 Oct 2022 05:33:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM66WHzUCEHcp9CwKDRSXPKaYZmaykKxDM8kkLSDZdWPINgoekWckeLHTyIwOjSuAt0Dg5Wj9A==
X-Received: by 2002:a05:620a:2723:b0:6df:b61f:99f6 with SMTP id b35-20020a05620a272300b006dfb61f99f6mr22995656qkp.3.1666614787148;
        Mon, 24 Oct 2022 05:33:07 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id o6-20020a05620a2a0600b006ee9d734479sm15156476qkp.33.2022.10.24.05.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 05:33:06 -0700 (PDT)
Message-ID: <7e63bf39643c34deb86645dd9b35bafd3b64bbe3.camel@redhat.com>
Subject: Re: [PATCH v2 7/8] KVM: x86: remove SMRAM address space if SMM is
 not supported
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     seanjc@google.com, maciej.szmigiero@oracle.com
Date:   Mon, 24 Oct 2022 15:33:01 +0300
In-Reply-To: <20220929172016.319443-8-pbonzini@redhat.com>
References: <20220929172016.319443-1-pbonzini@redhat.com>
         <20220929172016.319443-8-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-29 at 13:20 -0400, Paolo Bonzini wrote:
> If CONFIG_KVM_SMM is not defined HF_SMM_MASK will always be zero, and
> we can spare userspace the hassle of setting up the SMRAM address space
> simply by reporting that only one address space is supported.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index cb88da02d965..d11697504471 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1994,11 +1994,14 @@ enum {
>  #define HF_SMM_MASK		(1 << 6)
>  #define HF_SMM_INSIDE_NMI_MASK	(1 << 7)
>  
> -#define __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
> -#define KVM_ADDRESS_SPACE_NUM 2
> -
> -#define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_MASK ? 1 : 0)
> -#define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role).smm)
> +#ifdef CONFIG_KVM_SMM
> +# define __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
> +# define KVM_ADDRESS_SPACE_NUM 2
> +# define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_MASK ? 1 : 0)
> +# define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role).smm)
> +#else
> +# define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
> +#endif
>  
>  #define KVM_ARCH_WANT_MMU_NOTIFIER
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

