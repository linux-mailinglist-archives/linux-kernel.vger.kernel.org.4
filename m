Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1389A69FA26
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjBVR2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBVR2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:28:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C181D2FCC7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677086843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3hjthbpnOytnzdDsquz7EOnh3xJTlIr5J5MzFX7ZsE=;
        b=WTE+AGlJg2xsxh1w2nKyfWAcm+IEEzDKxh6Uji4xu5vrJkCzyfQI6drgtNs7iAs8yonBf/
        BQ9hM8orRscV8hoV+U2JFRWkqszVRqgJapMKGoF+9uWMs1WwC5MqppdERT1OPYbq3OAB+p
        kYzNzu//PCHCIlOqgjDmSECnOJt4ZNs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-v5Ri-ElLOKqTib9dkWpubw-1; Wed, 22 Feb 2023 12:27:18 -0500
X-MC-Unique: v5Ri-ElLOKqTib9dkWpubw-1
Received: by mail-qk1-f200.google.com with SMTP id q12-20020a05620a0c8c00b0072fcbe20069so5021697qki.22
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3hjthbpnOytnzdDsquz7EOnh3xJTlIr5J5MzFX7ZsE=;
        b=D+Icshlat0wH1S7ROaHhy3/Mz0sYSBQjSx1KY1zsjUf2Y0GzamYTE+3ju1rASRPpye
         JEd5XLHOsHssxlC0kDsVb9Q+OKaRXtYmzAC0URHrUZQTISVX4xecyncLH3IELDxfNdGo
         jh4PRCZpJjJ3ixOiGtKXJXwhywOuvuiCjT233gW5SislWNXhLVON9WNLQxcI/RairMAH
         bwxwUPthvk8D5H8uqpe9VJI7UsOsaUzy5vyu7GXv9JbHat32y4F/Rr3+elRDS9tixIo5
         KyMeYdTJlyWBdrtwNARFKoRLYAgwEzx3Yx5MT2ynqWYsBoqNc53yj8mHuHAeiv4zbJ/4
         ViCg==
X-Gm-Message-State: AO0yUKX2HFo7lxQ3y7LhJPsmKu0CSVtALBjohmBhalmSTh6yPmZQMcyh
        8aKr2s6DwGS89AkJpr9bXQQ6Y07tWL9aJCTLFZx7ZyTPj6iNYwnYPgK2JpBpjhsqIuIqU02R8Ct
        VM/GESRs5JWWuGB4pfBohDJHq
X-Received: by 2002:ac8:7d89:0:b0:3b8:682d:cebf with SMTP id c9-20020ac87d89000000b003b8682dcebfmr14866169qtd.66.1677086838384;
        Wed, 22 Feb 2023 09:27:18 -0800 (PST)
X-Google-Smtp-Source: AK7set+d4d5FJqnfbvKfxeC1bGLDNd4C8QlotcmipZ4m9xE+sgAZLxryVvT5ew8R/ylau0iFM30W6w==
X-Received: by 2002:ac8:7d89:0:b0:3b8:682d:cebf with SMTP id c9-20020ac87d89000000b003b8682dcebfmr14866141qtd.66.1677086838114;
        Wed, 22 Feb 2023 09:27:18 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n123-20020a37bd81000000b006ee8874f5fasm2096783qkf.53.2023.02.22.09.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 09:27:17 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2] KVM: SVM: hyper-v: placate modpost section mismatch
 error
In-Reply-To: <20230222162511.7964-1-rdunlap@infradead.org>
References: <20230222162511.7964-1-rdunlap@infradead.org>
Date:   Wed, 22 Feb 2023 18:27:14 +0100
Message-ID: <87h6vd4nm5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> modpost reports section mismatch errors/warnings:
> WARNING: modpost: vmlinux.o: section mismatch in reference: svm_hv_hardware_setup (section: .text) -> (unknown) (section: .init.data)
> WARNING: modpost: vmlinux.o: section mismatch in reference: svm_hv_hardware_setup (section: .text) -> (unknown) (section: .init.data)
> WARNING: modpost: vmlinux.o: section mismatch in reference: svm_hv_hardware_setup (section: .text) -> (unknown) (section: .init.data)
>
> Marking svm_hv_hardware_setup() as __init fixes the warnings.
>
> I don't know why this should be needed -- it seems like a compiler
> problem to me since the calling function is marked as __init.
>
> This "(unknown) (section: .init.data)" all refer to svm_x86_ops.
>
> Fixes: 1e0c7d40758b ("KVM: SVM: hyper-v: Remote TLB flush for SVM")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vineeth Pillai <viremana@linux.microsoft.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: kvm@vger.kernel.org
> ---
> v2: also make the empty stub function be __init (Vitaly)

Thanks!

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

>
>  arch/x86/kvm/svm/svm_onhyperv.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff -- a/arch/x86/kvm/svm/svm_onhyperv.h b/arch/x86/kvm/svm/svm_onhyperv.h
> --- a/arch/x86/kvm/svm/svm_onhyperv.h
> +++ b/arch/x86/kvm/svm/svm_onhyperv.h
> @@ -30,7 +30,7 @@ static inline void svm_hv_init_vmcb(stru
>  		hve->hv_enlightenments_control.msr_bitmap = 1;
>  }
>  
> -static inline void svm_hv_hardware_setup(void)
> +static inline __init void svm_hv_hardware_setup(void)
>  {
>  	if (npt_enabled &&
>  	    ms_hyperv.nested_features & HV_X64_NESTED_ENLIGHTENED_TLB) {
> @@ -84,7 +84,7 @@ static inline void svm_hv_init_vmcb(stru
>  {
>  }
>  
> -static inline void svm_hv_hardware_setup(void)
> +static inline __init void svm_hv_hardware_setup(void)
>  {
>  }
>  
>

-- 
Vitaly

