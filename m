Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9146A801A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCBKnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBKnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:43:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560C1F966
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677753781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwuiHsJbK4HjQfWeCHu6jHFclxSsPty9CQBgqZ7WAqE=;
        b=iys+dBi0wq58SH5JeFeDRKNAuK/Ic2DeNaVMtIwO2HlrBqPwSM7BwPG0V8lWp3XxN0nrHI
        oUMBp4sVDp3ArON/m9OK2ESZCPSs9Z2tiEMBumAjjoSc1/GycOjDfihkqUJ+ufu1+GksnE
        YcuOLnu+OUiGhlCW//fGAq7HzeIe+KU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-DXLpOnGFOsuGopxRaJ5LQg-1; Thu, 02 Mar 2023 05:43:00 -0500
X-MC-Unique: DXLpOnGFOsuGopxRaJ5LQg-1
Received: by mail-wr1-f69.google.com with SMTP id 15-20020a056000156f00b002ca79db6d42so2890649wrz.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwuiHsJbK4HjQfWeCHu6jHFclxSsPty9CQBgqZ7WAqE=;
        b=zwfkykDF6c+XaxPf/MEwT8uKkqWfWKMyGtFb7GbYHwuE7/QAe82LwzzEY4tKqfGOvZ
         x7ELdNm/unrmXiAv+NTVbNtLTE8ZCNI1HJfaGTIIhOZF8TBxxmbrDzUT2wUXwNGQxmnF
         hDOM9vW+F4ZQc3FQifXSwOch0jwIPvBeAE6fRcYDvZ5BWg4IiHSvMBGwhSEzZM0HXJCA
         L+KA9Qq9QPqB5tnvndern9xCWKbt+4aG6DaxCk7nIYlfgU7Lw0oCtzcA8EQ1UM+0Wfb8
         x/tARdztBmCGaoy4S4Rf5UDv6qiu49kB29WhwDo8PMTwscuVGvoXdbjHhubmjRuOjBYZ
         csQg==
X-Gm-Message-State: AO0yUKX+itVjcpVvzGEZ0eiRRMGUdln2J9P0vra0J5XKwEtTCSDxjA0B
        88LEkQxmzoCEI5fgiUNvA/9MhM4PcnP/hDdzfhHPtZvsSfgp5L963/el+RE6KyqOvTJrBy9Uf5Y
        S33nWiB+8BqJluLgCkX8M7sqO
X-Received: by 2002:a05:600c:310e:b0:3eb:3148:a1b7 with SMTP id g14-20020a05600c310e00b003eb3148a1b7mr7520187wmo.12.1677753779066;
        Thu, 02 Mar 2023 02:42:59 -0800 (PST)
X-Google-Smtp-Source: AK7set/fqdVdmgSoTuzweDrtlFiBPO15ZlxWorlkmzaBBGqAUw6q5fq4Fe34ka7WUUel/XXI1jFs8g==
X-Received: by 2002:a05:600c:310e:b0:3eb:3148:a1b7 with SMTP id g14-20020a05600c310e00b003eb3148a1b7mr7520176wmo.12.1677753778701;
        Thu, 02 Mar 2023 02:42:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:4f00:87ba:e9e9:3821:677b? (p200300cbc70e4f0087bae9e93821677b.dip0.t-ipconnect.de. [2003:cb:c70e:4f00:87ba:e9e9:3821:677b])
        by smtp.gmail.com with ESMTPSA id s19-20020a05600c45d300b003df7b40f99fsm2855839wmo.11.2023.03.02.02.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 02:42:58 -0800 (PST)
Message-ID: <a754561a-1d0a-ebfb-952f-054bae6dc533@redhat.com>
Date:   Thu, 2 Mar 2023 11:42:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230209150150.380060673@redhat.com>
 <20230209153204.683821550@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 02/11] this_cpu_cmpxchg: ARM64: switch this_cpu_cmpxchg
 to locked, add _local function
In-Reply-To: <20230209153204.683821550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.23 16:01, Marcelo Tosatti wrote:
> Goal is to have vmstat_shepherd to transfer from
> per-CPU counters to global counters remotely. For this,
> an atomic this_cpu_cmpxchg is necessary.
> 
> Following the kernel convention for cmpxchg/cmpxchg_local,
> change ARM's this_cpu_cmpxchg_ helpers to be atomic,
> and add this_cpu_cmpxchg_local_ helpers which are not atomic.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> Index: linux-vmstat-remote/arch/arm64/include/asm/percpu.h
> ===================================================================
> --- linux-vmstat-remote.orig/arch/arm64/include/asm/percpu.h
> +++ linux-vmstat-remote/arch/arm64/include/asm/percpu.h
> @@ -232,13 +232,23 @@ PERCPU_RET_OP(add, add, ldadd)
>   	_pcp_protect_return(xchg_relaxed, pcp, val)
>   
>   #define this_cpu_cmpxchg_1(pcp, o, n)	\
> -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +	_pcp_protect_return(cmpxchg, pcp, o, n)
>   #define this_cpu_cmpxchg_2(pcp, o, n)	\
> -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +	_pcp_protect_return(cmpxchg, pcp, o, n)
>   #define this_cpu_cmpxchg_4(pcp, o, n)	\
> -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +	_pcp_protect_return(cmpxchg, pcp, o, n)
>   #define this_cpu_cmpxchg_8(pcp, o, n)	\
> +	_pcp_protect_return(cmpxchg, pcp, o, n)
> +
> +#define this_cpu_cmpxchg_local_1(pcp, o, n)	\
>   	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +#define this_cpu_cmpxchg_local_2(pcp, o, n)	\
> +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +#define this_cpu_cmpxchg_local_4(pcp, o, n)	\
> +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +#define this_cpu_cmpxchg_local_8(pcp, o, n)	\
> +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +

Call me confused (not necessarily your fault :) ).

We have cmpxchg_local, cmpxchg_relaxed and cmpxchg. 
this_cpu_cmpxchg_local_* now calls ... *drumroll* ... cmpxchg_relaxed.

IIUC, cmpxchg_local is only guaranteed to be atomic WRO the current CPU 
(especially, protection against interrupts when the operation is 
implemented using multiple instructions). We do have a generic 
implementation that disables/enables interrupts.

IIUC, cmpxchg_relaxed an atomic update without any memory ordering 
guarantees (in contrast to cmpxchg, cmpxchg_acquire, cmpxchg_acquire). 
We default to arch_cmpxchg if we don't have arch_cmpxchg_relaxed. 
arch_cmpxchg defaults to arch_cmpxchg_local, if not supported.


Naturally I wonder:

(a) Should these new variants be rather called
     this_cpu_cmpxchg_relaxed_* ?

(b) Should these new variants rather call the "_local" variant?


Shedding some light on this would be great.

-- 
Thanks,

David / dhildenb

