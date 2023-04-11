Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79376DD5CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDKInQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDKInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73774121
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681202547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0G40HMMtqNusZREMWnmDmOZTULsZQjdvFBX6d0j6nM=;
        b=ObBOH/fGlAUO6NQSk42MpU7rJiZ5bRMHscB7sYHunkJl6MvvD1M+OQOg2Z4CkqiHcN3k1S
        adxi4DoGJqISJUJjvg5EOPk4cw2bRxU0Z77UzwEy4Q/ZPj1BFl7xonOswB0WA6pRifi6LG
        AecxrsLzm5oL9VkQG0JN0KVz/miPNQE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-rb7ZVuphMTq6c_brDin0xg-1; Tue, 11 Apr 2023 04:42:26 -0400
X-MC-Unique: rb7ZVuphMTq6c_brDin0xg-1
Received: by mail-wr1-f72.google.com with SMTP id s30-20020adf979e000000b002eeddf27e71so1735487wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681202545; x=1683794545;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0G40HMMtqNusZREMWnmDmOZTULsZQjdvFBX6d0j6nM=;
        b=pc11tgmFJFkI6WZRWtQZzlNMIENQr6WgfvWOpD2fod6Es6m1kBpZ5r+NGnKglaLipv
         B6Y9pnRzfEvVTnl+CtWKfD0fN6fGkWIPlOXfVoo3WduJp1QwfhGqrdp6Cux9s9Ow75x9
         0mK/nE500UTcls64LNLd9FgdpGcQnHG5x/XlzW5i04L15Luwt8gOygNGeScgKOOIP/Jg
         sCJJbN0cbZCwoGGXDDINRvvv/bkr1+SItdoqB94bfrUzuM3QLqmWyIzwh01nn2rdbR0O
         9EhXu9yOhseAJGjh4XM+2GZu0YQ/ZM6fDKAsHhX0vU2BrXHxu4Rk4XYJBveEmJF7p4Rf
         0pSw==
X-Gm-Message-State: AAQBX9dY6k1ebG9idFovOIw2JeLX8lgnXiodJp0EtdtTiTIXQNq1rSqV
        ncppgFZyTgUhG+fOtNVG/jdUqdtagQ8v1k80puvkQ6kHB8hnhGVAI1g/6m0IRngco1bxBt4DPpY
        +9TxAxdJ+xT85rZu2ENH2cp5D
X-Received: by 2002:a7b:cb81:0:b0:3ee:1acd:b039 with SMTP id m1-20020a7bcb81000000b003ee1acdb039mr9362634wmi.34.1681202545156;
        Tue, 11 Apr 2023 01:42:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y0ozkUapL4MwnXUftzJoDwFRIUNHeFl1HSv1T0LtFvCqpcIZ1xQSSekp/uyzdWD3ViMfmTvg==
X-Received: by 2002:a7b:cb81:0:b0:3ee:1acd:b039 with SMTP id m1-20020a7bcb81000000b003ee1acdb039mr9362604wmi.34.1681202544706;
        Tue, 11 Apr 2023 01:42:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:1300:6f08:1748:eba7:b2a9? (p200300cbc70613006f081748eba7b2a9.dip0.t-ipconnect.de. [2003:cb:c706:1300:6f08:1748:eba7:b2a9])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c021600b003dc522dd25esm16326602wmi.30.2023.04.11.01.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 01:42:24 -0700 (PDT)
Message-ID: <3132a8ca-49a3-3d6a-09fe-984293116d76@redhat.com>
Date:   Tue, 11 Apr 2023 10:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] modules/kmod: replace implementation with a
 sempahore
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
References: <20230405203505.1343562-1-mcgrof@kernel.org>
 <20230405203505.1343562-3-mcgrof@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230405203505.1343562-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.23 22:35, Luis Chamberlain wrote:
> Simplfy the concurrency delimiter we user for kmod with the semaphore.
> I had used the kmod strategy to try to implement a similar concurrency
> delimiter for the kernel_read*() calls from the finit_module() path
> so to reduce vmalloc() memory pressure. That effort didn't provid yet
> conclusive results, but one thing that did became clear is we can use
> the suggested alternative solution with semaphores which Linus hinted
> at instead of using the atomic / wait strategy.
> 
> I've stress tested this with kmod test 0008:
> 
> time /data/linux-next/tools/testing/selftests/kmod/kmod.sh -t 0008
> 
> And I get only a *slight* delay. That delay however is small, a few
> seconds for a full test loop run that runs 150 times, for about ~30-40
> seconds. The small delay is worth the simplfication IMHO.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   kernel/module/kmod.c | 26 +++++++-------------------
>   1 file changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
> index b717134ebe17..925eb85b8346 100644
> --- a/kernel/module/kmod.c
> +++ b/kernel/module/kmod.c
> @@ -40,8 +40,7 @@
>    * effect. Systems like these are very unlikely if modules are enabled.
>    */
>   #define MAX_KMOD_CONCURRENT 50
> -static atomic_t kmod_concurrent_max = ATOMIC_INIT(MAX_KMOD_CONCURRENT);
> -static DECLARE_WAIT_QUEUE_HEAD(kmod_wq);
> +static DEFINE_SEMAPHORE(kmod_concurrent_max, MAX_KMOD_CONCURRENT);
>   
>   /*
>    * This is a restriction on having *all* MAX_KMOD_CONCURRENT threads
> @@ -148,29 +147,18 @@ int __request_module(bool wait, const char *fmt, ...)
>   	if (ret)
>   		return ret;
>   
> -	if (atomic_dec_if_positive(&kmod_concurrent_max) < 0) {
> -		pr_warn_ratelimited("request_module: kmod_concurrent_max (%u) close to 0 (max_modprobes: %u), for module %s, throttling...",
> -				    atomic_read(&kmod_concurrent_max),
> -				    MAX_KMOD_CONCURRENT, module_name);
> -		ret = wait_event_killable_timeout(kmod_wq,
> -						  atomic_dec_if_positive(&kmod_concurrent_max) >= 0,
> -						  MAX_KMOD_ALL_BUSY_TIMEOUT * HZ);
> -		if (!ret) {
> -			pr_warn_ratelimited("request_module: modprobe %s cannot be processed, kmod busy with %d threads for more than %d seconds now",
> -					    module_name, MAX_KMOD_CONCURRENT, MAX_KMOD_ALL_BUSY_TIMEOUT);
> -			return -ETIME;
> -		} else if (ret == -ERESTARTSYS) {
> -			pr_warn_ratelimited("request_module: sigkill sent for modprobe %s, giving up", module_name);
> -			return ret;
> -		}
> +	ret = down_timeout(&kmod_concurrent_max, MAX_KMOD_ALL_BUSY_TIMEOUT);
> +	if (ret) {
> +		pr_warn_ratelimited("request_module: modprobe %s cannot be processed, kmod busy with %d threads for more than %d seconds now",
> +				    module_name, MAX_KMOD_CONCURRENT, MAX_KMOD_ALL_BUSY_TIMEOUT);
> +		return ret;
>   	}
>   
>   	trace_module_request(module_name, wait, _RET_IP_);
>   
>   	ret = call_modprobe(module_name, wait ? UMH_WAIT_PROC : UMH_WAIT_EXEC);
>   
> -	atomic_inc(&kmod_concurrent_max);
> -	wake_up(&kmod_wq);
> +	up(&kmod_concurrent_max);
>   
>   	return ret;
>   }

Much cleaner

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

