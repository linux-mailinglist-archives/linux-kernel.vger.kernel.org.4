Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1550D69F643
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjBVOQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjBVOQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:16:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EBD3773F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677075315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sQsLqX1OjjYuAZxQpRIQQNFoZetiCPqyoN+kLuymI3Q=;
        b=gMhjyn/IOWsqPHA9k/jJcD/dd3lJAfjgsCpKVn2eZdrr8GkmkEx8hLiFDq2+J9O+M/+aSN
        rWvf/9afZvXzcJaZtzMWDMSyF6RsAikMwdfxybnbEd/j+RGntEDEf41RwxNdMSqe15KYWl
        o7QQFPDUse9ftCFc7XHAkZK1qvCfLA8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-175-2U--RYZcOuO_IRjgF1CL5A-1; Wed, 22 Feb 2023 09:15:12 -0500
X-MC-Unique: 2U--RYZcOuO_IRjgF1CL5A-1
Received: by mail-wr1-f71.google.com with SMTP id r3-20020a5d6c63000000b002bff57fc7fcso1833684wrz.19
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQsLqX1OjjYuAZxQpRIQQNFoZetiCPqyoN+kLuymI3Q=;
        b=Z8x6Kh7YSCx5msRa/in9/+xgcye0XkVtPcJ09zzriuXPbCRVwfvf4bPJXnJoNvKTi9
         ZUMCLtnkkH1jk5DYpfWGcwBS+M1fISj3ZMNzvuWzxF9XT90+5HRv7bGcTMPAqvtymXai
         y4N+W6Q6waLf8RD2m0SQxgPo09wZn1kltB/1V9O7DawiL2UERDSIYHytOufbrQKFTo6H
         dlfk6mInOn7R4LDG4uZF4ixy56Is5tHX+3BVzsryPM+m0ai96L7Fxb4lO6JdSkEqeaNh
         KeK0XblF9mxzWD8dgYKXHhPL0T1yPT4w7SRp8iLZuo599ddWbGQ3LvIharsXpJSnqERH
         bIdw==
X-Gm-Message-State: AO0yUKVPosuyc8ifYJVf0ln+SDMbAOvRK6HPMZEblRPQZSzXMudP0ayh
        J/9n0LwPldenpxIL4HG1FzCj0m3r1O1vx6Z+qMsM/qD7ddYmiHclYGUOZq88OzU5G4rmRBRyRVX
        OiDSle3Asv0lsWzqvV7JdFsM4
X-Received: by 2002:a1c:6a12:0:b0:3dd:1c46:b92 with SMTP id f18-20020a1c6a12000000b003dd1c460b92mr7372584wmc.16.1677075311439;
        Wed, 22 Feb 2023 06:15:11 -0800 (PST)
X-Google-Smtp-Source: AK7set/S3zSWR7FXEvK09uraAeYBi21Ba0z7ojWTKmJJzanv6OVLXKGEETksizHsfOLf29IRFrXFiA==
X-Received: by 2002:a1c:6a12:0:b0:3dd:1c46:b92 with SMTP id f18-20020a1c6a12000000b003dd1c460b92mr7372563wmc.16.1677075311148;
        Wed, 22 Feb 2023 06:15:11 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ja14-20020a05600c556e00b003dfefe115b9sm5509683wmb.0.2023.02.22.06.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 06:15:09 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: SVM: hyper-v: placate modpost section mismatch error
In-Reply-To: <20230222073315.9081-1-rdunlap@infradead.org>
References: <20230222073315.9081-1-rdunlap@infradead.org>
Date:   Wed, 22 Feb 2023 15:15:08 +0100
Message-ID: <87k0094wib.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
>  arch/x86/kvm/svm/svm_onhyperv.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
>

There's a second empty svm_hv_hardware_setup() implementation 50 lines
below in the same file for !if IS_ENABLED(CONFIG_HYPERV) case and I
think it needs to be marked as '__init' as well.

-- 
Vitaly

