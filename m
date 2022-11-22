Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CBB6340C7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiKVQDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiKVQDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:03:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99158725DD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669132928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D2WgN9uHr4xkqV1mAsY0pHQqDjGcrUIp9oZrUjlU7AA=;
        b=aJWnN66N7r0WfSxDRG8vndJmeaVNPIa09MGk4iml8zWv/NNkYUxnM1Qwmad0EYAuWVMau6
        uigk+SL3+/AhAaiGAO3sMc8yfW3WSv5n3u2w2YWM2XKbVbxjo/hNQ/6ir90rNkDK/KO6dG
        WFa6ZsJAgJjDv+Wsx2KXx3bN0yqa1/A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-261-acM0NbTlPDqfz-6tLP9fYA-1; Tue, 22 Nov 2022 11:02:07 -0500
X-MC-Unique: acM0NbTlPDqfz-6tLP9fYA-1
Received: by mail-ed1-f71.google.com with SMTP id s14-20020a056402520e00b00469a9930c52so3819940edd.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2WgN9uHr4xkqV1mAsY0pHQqDjGcrUIp9oZrUjlU7AA=;
        b=3+qOiSMcaf930qa1wWLPGgK/oLQAicIpSOJZlqrXEY56dRHg9tKzz1msrPG8LXRXyY
         2zpuvYpJCAS28Q6Nrr7cIenUIrLuLX0AbaFgwPz8WMpyJufbUXTh4A420NFeeSC9I9kM
         Lz8U1ppgwia5uWTRV8q5wCLfixPMszqOkKA5ikKp1hmlH6y9DM/1JMhOlmlIsDXF5s0n
         WvdMYmTmvbyL8vMdhnm2xsE+SGqFaROYWqeF6eTDO/fUJqoHq16pHOluTXosg97F84EW
         aHrpRMlvlcyxRMb6utOKucTMOVqSVk3AILx6C03SJQnWjo/ATJsesT/krqq4VPe1aI+X
         8f0w==
X-Gm-Message-State: ANoB5plPMwqgAqE/npczqL4sxCJ+0VKbIHzE8hPwq2xJkwMcFXV7xTbd
        c9NyYNiwRml3kdnHciOqm3vyBZBpwYIHyxuT+bpSc0PbHRYXHsRF6IFTuOvqtZdUNWJocjNsXa2
        Z2j2DmRyNLfcJDl6FDjEy+e8b
X-Received: by 2002:a05:6402:181:b0:461:ea0c:e151 with SMTP id r1-20020a056402018100b00461ea0ce151mr7561105edv.376.1669132925660;
        Tue, 22 Nov 2022 08:02:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6TDMkrWDIXsg+TPevcjHIgzRaABa4hBY5DAEMlRIwo/X5HFFnfDWRG2OY4xwCS3WES306BUA==
X-Received: by 2002:a05:6402:181:b0:461:ea0c:e151 with SMTP id r1-20020a056402018100b00461ea0ce151mr7561077edv.376.1669132925356;
        Tue, 22 Nov 2022 08:02:05 -0800 (PST)
Received: from ovpn-194-185.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r11-20020a056402034b00b004587f9d3ce8sm6535802edw.56.2022.11.22.08.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 08:02:04 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Subject: Re: [PATCH v2 3/6] KVM: selftests: Test Hyper-V extended hypercall
 enablement
In-Reply-To: <20221121234026.3037083-4-vipinsh@google.com>
References: <20221121234026.3037083-1-vipinsh@google.com>
 <20221121234026.3037083-4-vipinsh@google.com>
Date:   Tue, 22 Nov 2022 17:02:03 +0100
Message-ID: <87h6yrou4k.fsf@ovpn-194-185.brq.redhat.com>
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

> Test Hyper-V extended hypercall, HV_EXT_CALL_QUERY_CAPABILITIES
> (0x8001), access denied and invalid parameter
> cases.
>
> Access is denied if CPUID.0x40000003.EBX BIT(20) is not set.
> Invalid parameter if call has fast bit set.
>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>  tools/testing/selftests/kvm/include/x86_64/hyperv.h  | 4 ++++
>  tools/testing/selftests/kvm/x86_64/hyperv_features.c | 9 +++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> index 9218bb5f44bf..8813c1bb74a0 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> @@ -112,6 +112,7 @@
>  #define HV_ACCESS_STATS				BIT(8)
>  #define HV_DEBUGGING				BIT(11)
>  #define HV_CPU_MANAGEMENT			BIT(12)
> +#define HV_ENABLE_EXTENDED_HYPERCALLS		BIT(20)
>  #define HV_ISOLATION				BIT(22)
>  
>  /* HYPERV_CPUID_FEATURES.EDX */
> @@ -166,6 +167,9 @@
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>  
> +/* Extended hypercalls */
> +#define HV_EXT_CALL_QUERY_CAPABILITIES		0x8001
> +
>  #define HV_FLUSH_ALL_PROCESSORS			BIT(0)
>  #define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
>  #define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> index 3163c3e8db0a..a5a3146fc299 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> @@ -583,6 +583,15 @@ static void guest_test_hcalls_access(void)
>  			hcall->expect = HV_STATUS_SUCCESS;
>  			break;
>  		case 19:
> +			hcall->control = HV_EXT_CALL_QUERY_CAPABILITIES;
> +			hcall->expect = HV_STATUS_ACCESS_DENIED;
> +			break;
> +		case 20:
> +			feat->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;

As I've mentioned on another patch, things look significantly better
after https://lore.kernel.org/kvm/20221013095849.705943-6-vkuznets@redhat.com/
cleanup, hope we can have it in soon.

> +			hcall->control = HV_EXT_CALL_QUERY_CAPABILITIES | HV_HYPERCALL_FAST_BIT;
> +			hcall->expect = HV_STATUS_INVALID_PARAMETER;
> +			break;
> +		case 21:
>  			kvm_vm_free(vm);
>  			return;
>  		}

-- 
Vitaly

