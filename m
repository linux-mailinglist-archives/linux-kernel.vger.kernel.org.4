Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802C36340DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiKVQFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiKVQFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:05:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2222EF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669133069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ex5aAmkYWdXhcvqwK9J+B9+pLZO8eR1z7ZNRkzKKtGU=;
        b=f8Keew045Jo9EnauNE8Zb1nOHciSQgQ0JjTVenJRenzFjCBeYVJ1FEu8IPuP5cNCxN9U+W
        TkhIRXDzAqsZJuv9oUzrj+ZGk6+xbeXaAoTSsf04/MTaeSxXpvYNhkqhvMt5O9mMLtMVgR
        Rp+MRO/0mhYrRP8WXKI1IOoazXJ486w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-503-zy7UrvrlMva3hkLEUPuaLA-1; Tue, 22 Nov 2022 11:04:27 -0500
X-MC-Unique: zy7UrvrlMva3hkLEUPuaLA-1
Received: by mail-ed1-f71.google.com with SMTP id w17-20020a056402269100b00461e28a75ccso8999579edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ex5aAmkYWdXhcvqwK9J+B9+pLZO8eR1z7ZNRkzKKtGU=;
        b=AjjoIM0Fh8FBTu4eowYBSbHj0oEUOW0TiRH2su+VVvqf1HnHRW4Rg7TU95Gr4qOj39
         U+ZOUKOlFo28Cctzynjv+o95ZR+9W1KmvU+CnqPR4X0F4J4p2J6QDG6YQ5Ik5LYx6gqD
         JxslD4A/Pbk0DW8p9vdQhK8X8kLhrav0HMRncB/4bLecqGQPayRwB6AilcaD6mJwOTyS
         fsEiDrcZKY3zcC6FiCqXwlSCbmxMc1Vkcs6gXHO/os343nRWr645Hme7b1xyXzvnonHw
         Tzlp5gFiQMTrRz/AgGwMdED1dhJYYjykDvb6YrafaQluA2xw5xGcLpP07Jty2+7OUegL
         Fl6g==
X-Gm-Message-State: ANoB5pnrHQ6GC9BhmrYXKHLlq6BhEC5Li33cEU1taU7iK/JuhXHWGsir
        mt58eeUAorA456FfCx+OxHvRas55TV/BQckR0VC98+C3+b9l8rVM1iuM9k1YQDecZV54X1lliST
        WnTjrf+zH7Ty1Xho7AXjZGiEe
X-Received: by 2002:a17:906:2d49:b0:7ae:16a9:e4d7 with SMTP id e9-20020a1709062d4900b007ae16a9e4d7mr19977074eji.574.1669133066289;
        Tue, 22 Nov 2022 08:04:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6NfJfbfBssy5H5hJkYlPqp+XhG5mueCLLcFmgHVT5HpbCNMGTWZf9upo2bZUmrFMOYOvgaKA==
X-Received: by 2002:a17:906:2d49:b0:7ae:16a9:e4d7 with SMTP id e9-20020a1709062d4900b007ae16a9e4d7mr19977061eji.574.1669133066078;
        Tue, 22 Nov 2022 08:04:26 -0800 (PST)
Received: from ovpn-194-185.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id et8-20020a056402378800b00463bc1ddc76sm6468737edb.28.2022.11.22.08.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 08:04:25 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Subject: Re: [PATCH v2 1/6] KVM: x86: hyper-v: Use common code for hypercall
 userspace exit
In-Reply-To: <20221121234026.3037083-2-vipinsh@google.com>
References: <20221121234026.3037083-1-vipinsh@google.com>
 <20221121234026.3037083-2-vipinsh@google.com>
Date:   Tue, 22 Nov 2022 17:04:24 +0100
Message-ID: <87edtvou0n.fsf@ovpn-194-185.brq.redhat.com>
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

Vipin Sharma <vipinsh@google.com> writes:

> Remove duplicate code to exit to userspace for hyper-v hypercalls and
> use a common place to exit.
>

"No functional change intended." as it was suggested by Sean :-)

> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/hyperv.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 2c7f2a26421e..0b6964ed2e66 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2503,14 +2503,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			break;
>  		}
> -		vcpu->run->exit_reason = KVM_EXIT_HYPERV;
> -		vcpu->run->hyperv.type = KVM_EXIT_HYPERV_HCALL;
> -		vcpu->run->hyperv.u.hcall.input = hc.param;
> -		vcpu->run->hyperv.u.hcall.params[0] = hc.ingpa;
> -		vcpu->run->hyperv.u.hcall.params[1] = hc.outgpa;
> -		vcpu->arch.complete_userspace_io =
> -				kvm_hv_hypercall_complete_userspace;
> -		return 0;
> +		goto hypercall_userspace_exit;
>  	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST:
>  		if (unlikely(hc.var_cnt)) {
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
> @@ -2569,14 +2562,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  			ret = HV_STATUS_OPERATION_DENIED;
>  			break;
>  		}
> -		vcpu->run->exit_reason = KVM_EXIT_HYPERV;
> -		vcpu->run->hyperv.type = KVM_EXIT_HYPERV_HCALL;
> -		vcpu->run->hyperv.u.hcall.input = hc.param;
> -		vcpu->run->hyperv.u.hcall.params[0] = hc.ingpa;
> -		vcpu->run->hyperv.u.hcall.params[1] = hc.outgpa;
> -		vcpu->arch.complete_userspace_io =
> -				kvm_hv_hypercall_complete_userspace;
> -		return 0;
> +		goto hypercall_userspace_exit;
>  	}
>  	default:
>  		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
> @@ -2585,6 +2571,15 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  
>  hypercall_complete:
>  	return kvm_hv_hypercall_complete(vcpu, ret);
> +
> +hypercall_userspace_exit:
> +	vcpu->run->exit_reason = KVM_EXIT_HYPERV;
> +	vcpu->run->hyperv.type = KVM_EXIT_HYPERV_HCALL;
> +	vcpu->run->hyperv.u.hcall.input = hc.param;
> +	vcpu->run->hyperv.u.hcall.params[0] = hc.ingpa;
> +	vcpu->run->hyperv.u.hcall.params[1] = hc.outgpa;
> +	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
> +	return 0;
>  }
>  
>  void kvm_hv_init_vm(struct kvm *kvm)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

