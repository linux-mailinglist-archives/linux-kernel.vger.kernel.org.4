Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4120261FB19
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiKGRTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiKGRT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:19:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C2A14D16
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667841508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=25F0RsFD4mqDqAUGeX5SQy6BXG8Wv/fUaLilwYLMjok=;
        b=hft8mv7ffG6p86lsu0PGGBk2BmnHwghtvYPuN5kXMc5OiwUH+j3qDi6L1PQ5ANi8iHm6eG
        t2OOAmkUaiUYWfxRxZFO9cJx1QslgbFrSYczKopxQYUAGRhJsIu43v0yg3WVv/fBpkwzc8
        +w2BfGIyFk6ws58W6+y3Av+2a4h6EEc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-284-lxRsZzD8OhK-mf-07-js6g-1; Mon, 07 Nov 2022 12:18:26 -0500
X-MC-Unique: lxRsZzD8OhK-mf-07-js6g-1
Received: by mail-wr1-f72.google.com with SMTP id r4-20020adfbb04000000b00236639438e9so3075479wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25F0RsFD4mqDqAUGeX5SQy6BXG8Wv/fUaLilwYLMjok=;
        b=TWfuuhPafUZ7vjlvRTWACEBp5+t346cVOHq1DDrvo6NiMctsLMuCQp2rwSUmwdvWik
         ZzQN9KiUgC7tvpR3B51hS0SxMMfwFqbJmWqK67WKtNF8tztg1PVo7KAgsNXoIBX//tVH
         BaWTfcQWfZEqm4KkAS/AmQi2BkQV3LYd6iqGQPk3baxwcJsTPKDrtHdY9RjVwRsZI2GU
         kUgXKQ/K19+QmuPqCwGfmxEIgtKvszES0XhDVnefzD6FGHM5M3Q9f0wGxQwLRRW25pqA
         f/eOnOmaBHEBV/MbiPBXVeZN1lZ49Fz+F4TtVdxUHqK1ktB1xLhOOZApRy12DkVH8CyA
         5b7A==
X-Gm-Message-State: ACrzQf2xQx13yco8zzChGxBZj0b0DfdnKBH4w9SK0VY9pPv9380HyD5J
        KPMMTOpuFCXMgGt44OmUhLks8FSvscHG77ziPG5Ih8ttkIf3dmIt0tfnTmQOvANnN5f36x9Yg95
        x+kGJe1q9JZuRJpxxFEWEUhi5
X-Received: by 2002:a05:6000:684:b0:236:839f:9276 with SMTP id bo4-20020a056000068400b00236839f9276mr31416581wrb.586.1667841503921;
        Mon, 07 Nov 2022 09:18:23 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5Mt76JkHtenwSt6wdcL6YXqzVxEu6N9UN61xT9azVxfn/F/fR35Ax6I65hpIPIyLb+Dr2JAA==
X-Received: by 2002:a05:6000:684:b0:236:839f:9276 with SMTP id bo4-20020a056000068400b00236839f9276mr31416568wrb.586.1667841503688;
        Mon, 07 Nov 2022 09:18:23 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id v2-20020adfedc2000000b00228daaa84aesm7862025wro.25.2022.11.07.09.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 09:18:22 -0800 (PST)
Message-ID: <e13afbf9-f4ed-10c1-cf78-bd634c554d4d@redhat.com>
Date:   Mon, 7 Nov 2022 18:18:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH V2] KVM: SVM: Only dump VSMA to klog for debugging
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>, jarkko@kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Harald Hoyer <harald@profian.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20221104142220.469452-1-pgonda@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221104142220.469452-1-pgonda@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 15:22, Peter Gonda wrote:
> Explicitly print the VMSA dump at KERN_DEBUG log level, KERN_CONT uses
> KERNEL_DEFAULT if the previous log line has a newline, i.e. if there's
> nothing to continuing, and as a result the VMSA gets dumped when it
> shouldn't.
> 
> The KERN_CONT documentation says it defaults back to KERNL_DEFAULT if the
> previous log line has a newline. So switch from KERN_CONT to
> print_hex_dump_debug().
> 
> Jarkko pointed this out in reference to the original patch. See:
> https://lore.kernel.org/all/YuPMeWX4uuR1Tz3M@kernel.org/
> print_hex_dump(KERN_DEBUG, ...) was pointed out there, but
> print_hex_dump_debug() should similar.
> 
> Fixes: 6fac42f127b8 ("KVM: SVM: Dump Virtual Machine Save Area (VMSA) to klog")
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Harald Hoyer <harald@profian.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>   arch/x86/kvm/svm/sev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index c0c9ed5e279cb..9b8db157cf773 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -605,7 +605,7 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
>   	save->dr6  = svm->vcpu.arch.dr6;
>   
>   	pr_debug("Virtual Machine Save Area (VMSA):\n");
> -	print_hex_dump(KERN_CONT, "", DUMP_PREFIX_NONE, 16, 1, save, sizeof(*save), false);
> +	print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1, save, sizeof(*save), false);
>   
>   	return 0;
>   }

Queued, thanks.

Paolo

