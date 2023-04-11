Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679B36DD2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjDKGiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjDKGh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B60FF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681195032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olF5mjepmtklFbFK7hKHFfEdos+6jxWkuuqywTknkRQ=;
        b=EZnm+0IJHwd3OQmtHw9/Vrz9Eu4SCNl4jKnQ/+KjGv14BCFnWNk5mwLYevz9U+HRiU/XhH
        zxc6xr5YKukhnLKmPg4XvweKf04bOBZfPhjNR2qf55l9QBzlc9nk0elWngqspU2mWLuvj+
        swtiDNA0VzR3hGWK5olteNpgTKixJi4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-aJVM3PhiPY-YRwtXe-suOw-1; Tue, 11 Apr 2023 02:37:11 -0400
X-MC-Unique: aJVM3PhiPY-YRwtXe-suOw-1
Received: by mail-wm1-f70.google.com with SMTP id q19-20020a05600c46d300b003ef69894934so1900550wmo.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681195030; x=1683787030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olF5mjepmtklFbFK7hKHFfEdos+6jxWkuuqywTknkRQ=;
        b=lT+WYSHR2Zn6OKCF9DklhFTtC+uY4coT4dI3SOond08zLj1Yf7Gj2YcCtDhQJLbsiG
         pXHdr+v4XTMhGUVVtiV/rpuVsflx0m2CKa4sy0R3RfJyG6fdR1qqLign5VgyYej1W1sz
         0ny4+iouCAynpOiWXlZUAHHfheGOLky11oEy+VXwhrm/if2vkgFuk2VP4OAPUGnh3PMc
         TANbzvUW8KGP+sWbhGqsiBsWR4jBgvm0/7ktuAevNkMM8u/TyDrKSvzxm8V4qhYJxAim
         spr9adtw13vfzKfOigxSlpJmSv6fTSx2pG6rBdp32W5Gif268yn3V8svQPpqqLX4r9YE
         jO/A==
X-Gm-Message-State: AAQBX9fwU+5oI3rON4LVEo+fRVXRTxRSjZVUgs/yZaLRVPtj52vawW61
        OzfxJGikAK45gw+LEdgZZkWq9A7qXpKjOUSo2srEcNFJtHIoD+soSnVTMa0HG8uIheeClRHAcoJ
        5bRZ7rUji5TNAmUnNtq/qXki/
X-Received: by 2002:a5d:48d2:0:b0:2ee:e42e:e8b7 with SMTP id p18-20020a5d48d2000000b002eee42ee8b7mr5945615wrs.33.1681195030470;
        Mon, 10 Apr 2023 23:37:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350bi7wOckY7Uos6LLY1S0H/CZrnhoKLnlhxa4G7i+9nqN5zOvtaIWdafQtZ1IKvo+jBX7RcldQ==
X-Received: by 2002:a5d:48d2:0:b0:2ee:e42e:e8b7 with SMTP id p18-20020a5d48d2000000b002eee42ee8b7mr5945602wrs.33.1681195030107;
        Mon, 10 Apr 2023 23:37:10 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id b16-20020adfe310000000b002f27a6a49d0sm2524355wrj.10.2023.04.10.23.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 23:37:09 -0700 (PDT)
Message-ID: <431136bf-2e49-fbef-457d-1145c1a59fac@redhat.com>
Date:   Tue, 11 Apr 2023 08:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not
 intercepted
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathias Krause <minipli@grsecurity.net>
References: <20230405002359.418138-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230405002359.418138-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 02:23, Sean Christopherson wrote:
> Extend VMX's nested intercept logic for emulated instructions to handle
> "pause" interception, in quotes because KVM's emulator doesn't filter out
> NOPs when checking for nested intercepts.  Failure to allow emulation of
> NOPs results in KVM injecting a #UD into L2 on any NOP that collides with
> the emulator's definition of PAUSE, i.e. on all single-byte NOPs.
> 
> For PAUSE itself, honor L1's PAUSE-exiting control, but ignore PLE to
> avoid unnecessarily injecting a #UD into L2.  Per the SDM, the first
> execution of PAUSE after VM-Entry is treated as the beginning of a new
> loop, i.e. will never trigger a PLE VM-Exit, and so L1 can't expect any
> given execution of PAUSE to deterministically exit.
> 
>    ... the processor considers this execution to be the first execution of
>    PAUSE in a loop. (It also does so for the first execution of PAUSE at
>    CPL 0 after VM entry.)
> 
> All that said, the PLE side of things is currently a moot point, as KVM
> doesn't expose PLE to L1.
> 
> Note, vmx_check_intercept() is still wildly broken when L1 wants to
> intercept an instruction, as KVM injects a #UD instead of synthesizing a
> nested VM-Exit.  That issue extends far beyond NOP/PAUSE and needs far
> more effort to fix, i.e. is a problem for the future.
> 
> Fixes: 07721feee46b ("KVM: nVMX: Don't emulate instructions in guest mode")
> Cc: Mathias Krause <minipli@grsecurity.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/vmx/vmx.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9ae4044f076f..1e560457bf9a 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7898,6 +7898,21 @@ static int vmx_check_intercept(struct kvm_vcpu *vcpu,
>   		/* FIXME: produce nested vmexit and return X86EMUL_INTERCEPTED.  */
>   		break;
>   
> +	case x86_intercept_pause:
> +		/*
> +		 * PAUSE is a single-byte NOP with a REPE prefix, i.e. collides
> +		 * with vanilla NOPs in the emulator.  Apply the interception
> +		 * check only to actual PAUSE instructions.  Don't check
> +		 * PAUSE-loop-exiting, software can't expect a given PAUSE to
> +		 * exit, i.e. KVM is within its rights to allow L2 to execute
> +		 * the PAUSE.
> +		 */
> +		if ((info->rep_prefix != REPE_PREFIX) ||
> +		    !nested_cpu_has2(vmcs12, CPU_BASED_PAUSE_EXITING))
> +			return X86EMUL_CONTINUE;
> +
> +		break;
> +
>   	/* TODO: check more intercepts... */
>   	default:
>   		break;
> 
> base-commit: 27d6845d258b67f4eb3debe062b7dacc67e0c393

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Would you like me to apply this for 6.3?

Paolo

