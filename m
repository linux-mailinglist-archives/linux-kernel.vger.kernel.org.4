Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA4A6A804D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCBKwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCBKwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:52:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D929D302B0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677754282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/i6gxIWosvIGHKIV9tT99VnPhRuzzCj/xoLbIkHVCg=;
        b=P48HrMVwTQaeAIL+neuV6wEJx8dZnd/XJnJSwRH0Cpf8CLbygkJ99C/QYqm1cvpNvQph0R
        n9H8QqvT2pNx6AXMMoSOpi9QDj04cTLs3t+doQbXS6i4vay5HQEPDMCpbM3EOpqlNEp/45
        IF7rgmNuJ9D70kTqtDwcTOftrPG6sK4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-272-eAbUjDaCPRSdmMS8-R7HKA-1; Thu, 02 Mar 2023 05:51:20 -0500
X-MC-Unique: eAbUjDaCPRSdmMS8-R7HKA-1
Received: by mail-wm1-f69.google.com with SMTP id 4-20020a05600c024400b003eb2e295c05so5616071wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/i6gxIWosvIGHKIV9tT99VnPhRuzzCj/xoLbIkHVCg=;
        b=l1u2yhtR4Mq3aVT18RuI7YRdMEztdzy9gq+kaTHEN/LQ6T3mgdch17l2Hisa6Z27KB
         PClNkiLyHGvYOBbec71QyrAYhFt8D58hW2EhW1xasuvyjQnqLftmcNY2i8JTuX/EGTUu
         6bp7MoLO1Jx8FD+2wf5OItWQw5mA7lodTkW0DuRUBUapRHtRE1c57a4xt0zWdmuW4/8k
         lhkKE4h4IcOQmoRpxTq2ymnbD9udP3ee7MgHFBkhUg1iIxcsg6mpOisB2c5R/LrbUBkI
         LaAAkba1QJb2q8dYYWlb2ADX1i9EDvdIq0t2gUAC5ACIhMBlxlhYOA8nVF3BNaEpqVpK
         SmqA==
X-Gm-Message-State: AO0yUKWT9VXNANmYMjpYCzQvLgMalWtQdO1/FJQ5w3iwP8M8ksKmjc/Q
        7sYHw+752aZs5QnZRh1eIEUOQhUPKYHaTtqZ6rUI6q3IeTk0hgXyfazgn22y6mz1cVMSI4N6kJj
        YRbqQQABqpgXTzEP+AjBcnaAQ
X-Received: by 2002:adf:ea52:0:b0:2cd:cf97:61c9 with SMTP id j18-20020adfea52000000b002cdcf9761c9mr1176807wrn.4.1677754279578;
        Thu, 02 Mar 2023 02:51:19 -0800 (PST)
X-Google-Smtp-Source: AK7set9d3NoWdP2p+73heAEbqclshz4F9tooFLTmi1dsXWlVPSDATuOksmc0KKFANSBrjBII1k/7qQ==
X-Received: by 2002:adf:ea52:0:b0:2cd:cf97:61c9 with SMTP id j18-20020adfea52000000b002cdcf9761c9mr1176791wrn.4.1677754279229;
        Thu, 02 Mar 2023 02:51:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:4f00:87ba:e9e9:3821:677b? (p200300cbc70e4f0087bae9e93821677b.dip0.t-ipconnect.de. [2003:cb:c70e:4f00:87ba:e9e9:3821:677b])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d424b000000b002c55521903bsm14779464wrr.51.2023.03.02.02.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 02:51:18 -0800 (PST)
Message-ID: <ea424a75-c13b-7087-2bfe-a8696b56367d@redhat.com>
Date:   Thu, 2 Mar 2023 11:51:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 02/11] this_cpu_cmpxchg: ARM64: switch this_cpu_cmpxchg
 to locked, add _local function
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230209150150.380060673@redhat.com>
 <20230209153204.683821550@redhat.com>
 <a754561a-1d0a-ebfb-952f-054bae6dc533@redhat.com>
Organization: Red Hat
In-Reply-To: <a754561a-1d0a-ebfb-952f-054bae6dc533@redhat.com>
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

On 02.03.23 11:42, David Hildenbrand wrote:
> On 09.02.23 16:01, Marcelo Tosatti wrote:
>> Goal is to have vmstat_shepherd to transfer from
>> per-CPU counters to global counters remotely. For this,
>> an atomic this_cpu_cmpxchg is necessary.
>>
>> Following the kernel convention for cmpxchg/cmpxchg_local,
>> change ARM's this_cpu_cmpxchg_ helpers to be atomic,
>> and add this_cpu_cmpxchg_local_ helpers which are not atomic.
>>
>> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
>>
>> Index: linux-vmstat-remote/arch/arm64/include/asm/percpu.h
>> ===================================================================
>> --- linux-vmstat-remote.orig/arch/arm64/include/asm/percpu.h
>> +++ linux-vmstat-remote/arch/arm64/include/asm/percpu.h
>> @@ -232,13 +232,23 @@ PERCPU_RET_OP(add, add, ldadd)
>>    	_pcp_protect_return(xchg_relaxed, pcp, val)
>>    
>>    #define this_cpu_cmpxchg_1(pcp, o, n)	\
>> -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>> +	_pcp_protect_return(cmpxchg, pcp, o, n)
>>    #define this_cpu_cmpxchg_2(pcp, o, n)	\
>> -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>> +	_pcp_protect_return(cmpxchg, pcp, o, n)
>>    #define this_cpu_cmpxchg_4(pcp, o, n)	\
>> -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>> +	_pcp_protect_return(cmpxchg, pcp, o, n)
>>    #define this_cpu_cmpxchg_8(pcp, o, n)	\
>> +	_pcp_protect_return(cmpxchg, pcp, o, n)
>> +
>> +#define this_cpu_cmpxchg_local_1(pcp, o, n)	\
>>    	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>> +#define this_cpu_cmpxchg_local_2(pcp, o, n)	\
>> +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>> +#define this_cpu_cmpxchg_local_4(pcp, o, n)	\
>> +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>> +#define this_cpu_cmpxchg_local_8(pcp, o, n)	\
>> +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>> +
> 
> Call me confused (not necessarily your fault :) ).
> 
> We have cmpxchg_local, cmpxchg_relaxed and cmpxchg.
> this_cpu_cmpxchg_local_* now calls ... *drumroll* ... cmpxchg_relaxed.
> 
> IIUC, cmpxchg_local is only guaranteed to be atomic WRO the current CPU
> (especially, protection against interrupts when the operation is
> implemented using multiple instructions). We do have a generic
> implementation that disables/enables interrupts.
> 
> IIUC, cmpxchg_relaxed an atomic update without any memory ordering
> guarantees (in contrast to cmpxchg, cmpxchg_acquire, cmpxchg_acquire).
> We default to arch_cmpxchg if we don't have arch_cmpxchg_relaxed.
> arch_cmpxchg defaults to arch_cmpxchg_local, if not supported.
> 
> 
> Naturally I wonder:
> 
> (a) Should these new variants be rather called
>       this_cpu_cmpxchg_relaxed_* ?
> 
> (b) Should these new variants rather call the "_local" variant?
> 
> 
> Shedding some light on this would be great.

Nevermind, looking at the other patches I realized that this is 
arch-specific. Other archs that have _local variants call the _local 
variants. So I assume we really want the name this_cpu_cmpxchg_local_*, 
and using _relaxed here is just the aarch64 way of implementing _local 
via _relaxed.

Confusing :)

-- 
Thanks,

David / dhildenb

