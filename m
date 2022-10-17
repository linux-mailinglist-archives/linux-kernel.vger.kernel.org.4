Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0E76007B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJQH1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJQH1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCDF5A3EE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665991617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGoMgeRGXw4hi/WWoISGPQpcxM3VtVgZ48E6ULq6kLw=;
        b=h+P4YYwW65ytO8KWxuF+nNEWb+trknJDrZdPZ3OgZmfqxEG3DCcxJg4HEEjUQnce8g8Oim
        Gl0uKNzxXzektlF0fLUn0qcoV3GSqtPVYY+L9pQOMHoMjBp35apPiu8NA5xmhJHB22cncC
        I++9YVCmE2NfCK98B/+PIHhSFKkRZ38=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-Hhxduc0MPA-ESK7wwEF1Rw-1; Mon, 17 Oct 2022 03:26:56 -0400
X-MC-Unique: Hhxduc0MPA-ESK7wwEF1Rw-1
Received: by mail-wr1-f71.google.com with SMTP id p7-20020adfba87000000b0022cc6f805b1so3416032wrg.21
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGoMgeRGXw4hi/WWoISGPQpcxM3VtVgZ48E6ULq6kLw=;
        b=wjcksQXM9UHbHwca5de29PYiNfUttX7nDwUS+lwtLG+vGRQ9zNC2YUiAlSi5FxTY7a
         KWBJfSE1YbtNJZsKexLVTGvoh+YoGK1ScfM+2mVjB5kJhVRTFirKROYuxAlr/ZWJ2XBJ
         A0mkvkaxJc88Wz6WHE2PlmcJXtOzCX66ADBnH1Pm6+Oin4sz9gT8MRHr/iMJyHZgWafW
         K+0u8GQLsI0IxR9VAgnb7a4oP4ait5q/AupMb078VMisp/j0bnxkQFRPr7qXdEAiC+cf
         3M3xzpMZ7HiNTjHGU1wtHQNixKSgih+4aNDlFEQAHFWNP30FvtTvSuVo0EhJXVw4a+w1
         FsGg==
X-Gm-Message-State: ACrzQf0GV7fm5o1RLCAz56jWzpPTbL7FVs4eim9RZoYoG3PbvNGAqVwy
        B7Re+QBdjrsa3yNIC4DGsneSD/jP3eqKaQ7FBSlxaGCuWHftegMxBwDf8mY1RmahnEK2Cnck/8R
        kt62Y/zLUTUQRXzg/+ftQBJ+e
X-Received: by 2002:a05:600c:5486:b0:3b4:7e47:e19 with SMTP id iv6-20020a05600c548600b003b47e470e19mr6278801wmb.12.1665991615347;
        Mon, 17 Oct 2022 00:26:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ZwAJialK4CYQyhU1mwCtOe1ur1tfEFWuhI00xSBfQZtTEfMUKCemLgq49pQIrLmQymOvsZw==
X-Received: by 2002:a05:600c:5486:b0:3b4:7e47:e19 with SMTP id iv6-20020a05600c548600b003b47e470e19mr6278782wmb.12.1665991615026;
        Mon, 17 Oct 2022 00:26:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2300:e5ce:21ba:1d93:4323? (p200300cbc7072300e5ce21ba1d934323.dip0.t-ipconnect.de. [2003:cb:c707:2300:e5ce:21ba:1d93:4323])
        by smtp.gmail.com with ESMTPSA id r3-20020a05600c158300b003c21ba7d7d6sm8997969wmf.44.2022.10.17.00.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 00:26:54 -0700 (PDT)
Message-ID: <4856f28f-3da5-bf3e-161c-495aa837ae03@redhat.com>
Date:   Mon, 17 Oct 2022 09:26:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 1/4] module: Correct wake up of module_wq
Content-Language: en-US
To:     Petr Pavlu <petr.pavlu@suse.com>, mcgrof@kernel.org
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221016123031.3963-1-petr.pavlu@suse.com>
 <20221016123031.3963-2-petr.pavlu@suse.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221016123031.3963-2-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.22 14:30, Petr Pavlu wrote:
> The module_wq wait queue has only non-exclusive waiters and all waits
> are interruptible, therefore for consistency use wake_up_interruptible()
> to wake its waiters.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>   kernel/module/main.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d02d39c7174e..a12e177ea81f 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -764,7 +764,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>   
>   	free_module(mod);
>   	/* someone could wait for the module in add_unformed_module() */
> -	wake_up_all(&module_wq);
> +	wake_up_interruptible(&module_wq);
>   	return 0;
>   out:
>   	mutex_unlock(&module_mutex);
> @@ -2522,7 +2522,7 @@ static noinline int do_init_module(struct module *mod)
>   		schedule_work(&init_free_wq);
>   
>   	mutex_unlock(&module_mutex);
> -	wake_up_all(&module_wq);
> +	wake_up_interruptible(&module_wq);
>   
>   	return 0;
>   
> @@ -2538,7 +2538,7 @@ static noinline int do_init_module(struct module *mod)
>   	klp_module_going(mod);
>   	ftrace_release_mod(mod);
>   	free_module(mod);
> -	wake_up_all(&module_wq);
> +	wake_up_interruptible(&module_wq);
>   	return ret;
>   }
>   
> @@ -2879,7 +2879,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>   	/* Unlink carefully: kallsyms could be walking list. */
>   	list_del_rcu(&mod->list);
>   	mod_tree_remove(mod);
> -	wake_up_all(&module_wq);
> +	wake_up_interruptible(&module_wq);
>   	/* Wait for RCU-sched synchronizing before releasing mod->list. */
>   	synchronize_rcu();
>   	mutex_unlock(&module_mutex);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

