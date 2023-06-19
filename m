Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B613735784
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjFSNBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjFSNA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176AE119
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687179617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKBMHseotjxiKusjampIv0TaP0HFVwPGsCYt7fffA9Q=;
        b=HZj0rqOkN8mBlJ/6koevTvZZCAHlGz78AOCgdrbfUSJ+biYAH/J9GyesnnbWoWaMjNyQrY
        ohUEtA/LONZJKV5bhot55690jCc97THkjo74zo6QgPdaTmsx2tiyURvd2srN9V49uIVliB
        peBJ9Kwq17OEkTy03/FDLROQKKKyFEY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-FHtngeewPzaIpkaKzPbNlQ-1; Mon, 19 Jun 2023 09:00:16 -0400
X-MC-Unique: FHtngeewPzaIpkaKzPbNlQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4f84a8b00e3so2250806e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179614; x=1689771614;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKBMHseotjxiKusjampIv0TaP0HFVwPGsCYt7fffA9Q=;
        b=gVnBLOpgebMKYRnqDy3moBxdmZ6oJjxw4Y7WBde0urqdTaEBUFIZU5o/awJm7j9Ia4
         BDFs8JKB0GGnmNdTLksKl0faWntQ5Eoot6aJCPvysmf5L5aS+5DIHd48nxSBUWGbyPwN
         LQo7a0+CWqy3pWBe6+qR24pz3mZs8PK03T2Sni+DtUp+w4VtS6ru6A9ymexgCSkztE68
         jno7ElXCipklv/x4pwhpMUlkc6sB1UG3Eh/HYD2KuzPTXicIHWciE5kXSekNGRg2bT9t
         ZpBB6MgpQ6UwNKCwuf+8FkhTBYqZSYr5OLATt1WnYtNoSiy4Ik03Nru8XrA5aGeJus2E
         qClA==
X-Gm-Message-State: AC+VfDyc1IAFocph2S8YPFciZqzbfkoaH8gDA25H7iRtVx5VUFZ6w129
        AWBfbDbAJr2JJZbz0bGVUpmJtjMMMF1qe1lgjl/eEx755vJUIObx3kgLr7EZvZDyNd5Aw/01bkP
        c46DR60b0W3/oBI+82rIUqGVfDMyiddGF
X-Received: by 2002:a19:6d1b:0:b0:4f6:2cd8:5ff4 with SMTP id i27-20020a196d1b000000b004f62cd85ff4mr4649405lfc.2.1687179614314;
        Mon, 19 Jun 2023 06:00:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Qa1d1c/tAFqnOnK6Tb7BXNstNr9Yajz/8+X/50nfQeyGwmKwVC0dI0IBR37Be8JKlraaH9Q==
X-Received: by 2002:a19:6d1b:0:b0:4f6:2cd8:5ff4 with SMTP id i27-20020a196d1b000000b004f62cd85ff4mr4649388lfc.2.1687179613869;
        Mon, 19 Jun 2023 06:00:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:7100:cede:6433:a77b:41e9? (p200300cbc72f7100cede6433a77b41e9.dip0.t-ipconnect.de. [2003:cb:c72f:7100:cede:6433:a77b:41e9])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c469300b003f7f475c3bcsm19951929wmo.1.2023.06.19.06.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:00:13 -0700 (PDT)
Message-ID: <dfb59553-2777-15ed-d523-6a7cc5b68e53@redhat.com>
Date:   Mon, 19 Jun 2023 15:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     linux-mm@kvack.org, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        peterz@infradead.org, tglx@linutronix.de, seanjc@google.com,
        pbonzini@redhat.com, dan.j.williams@intel.com,
        rafael.j.wysocki@intel.com, ying.huang@intel.com,
        reinette.chatre@intel.com, len.brown@intel.com, ak@linux.intel.com,
        isaku.yamahata@intel.com, chao.gao@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, bagasdotme@gmail.com,
        sagis@google.com, imammedo@redhat.com
References: <cover.1685887183.git.kai.huang@intel.com>
 <9b3582c9f3a81ae68b32d9997fcd20baecb63b9b.1685887183.git.kai.huang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v11 06/20] x86/virt/tdx: Handle SEAMCALL running out of
 entropy error
In-Reply-To: <9b3582c9f3a81ae68b32d9997fcd20baecb63b9b.1685887183.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.23 16:27, Kai Huang wrote:
> Certain SEAMCALL leaf functions may return error due to running out of
> entropy, in which case the SEAMCALL should be retried as suggested by
> the TDX spec.
> 
> Handle this case in SEAMCALL common function.  Mimic the existing
> rdrand_long() to retry RDRAND_RETRY_LOOPS times.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
> 
> v10 -> v11:
>   - New patch
> 
> ---
>   arch/x86/virt/vmx/tdx/tdx.c | 15 ++++++++++++++-
>   arch/x86/virt/vmx/tdx/tdx.h | 17 +++++++++++++++++
>   2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index e82713dd5d54..e62e978eba1b 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -15,6 +15,7 @@
>   #include <linux/smp.h>
>   #include <asm/msr-index.h>
>   #include <asm/msr.h>
> +#include <asm/archrandom.h>
>   #include <asm/tdx.h>
>   #include "tdx.h"
>   
> @@ -33,12 +34,24 @@ static int __always_unused seamcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>   				    struct tdx_module_output *out)
>   {
>   	int cpu, ret = 0;
> +	int retry;
>   	u64 sret;
>   
>   	/* Need a stable CPU id for printing error message */
>   	cpu = get_cpu();
>   
> -	sret = __seamcall(fn, rcx, rdx, r8, r9, out);
> +	/*
> +	 * Certain SEAMCALL leaf functions may return error due to
> +	 * running out of entropy, in which case the SEAMCALL should
> +	 * be retried.  Handle this in SEAMCALL common function.
> +	 *
> +	 * Mimic the existing rdrand_long() to retry
> +	 * RDRAND_RETRY_LOOPS times.
> +	 */
> +	retry = RDRAND_RETRY_LOOPS;

Nit: I'd just do a "int retry = RDRAND_RETRY_LOOPS" and simplify this 
comment to "Mimic rdrand_long() retry behavior."

> +	do {
> +		sret = __seamcall(fn, rcx, rdx, r8, r9, out);
> +	} while (sret == TDX_RND_NO_ENTROPY && --retry);
>   
>   	/* Save SEAMCALL return code if the caller wants it */
>   	if (seamcall_ret)
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index 48ad1a1ba737..55dbb1b8c971 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -4,6 +4,23 @@
>   
>   #include <linux/types.h>
>   
> +/*
> + * This file contains both macros and data structures defined by the TDX
> + * architecture and Linux defined software data structures and functions.
> + * The two should not be mixed together for better readability.  The
> + * architectural definitions come first.
> + */
> +
> +/*
> + * TDX SEAMCALL error codes
> + */
> +#define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
> +
> +/*
> + * Do not put any hardware-defined TDX structure representations below
> + * this comment!
> + */
> +
>   struct tdx_module_output;
>   u64 __seamcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>   	       struct tdx_module_output *out);

In general, LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

