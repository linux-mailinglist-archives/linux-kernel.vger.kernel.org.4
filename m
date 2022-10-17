Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F1A6007B8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJQH1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiJQH1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036C75A3DC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665991644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cjWUtxQLwEV8jEI6Zuh3YSz4Df1i1QcpeTHLe3Byoa8=;
        b=T23Qo/G26iKTBlUpfB6S09H8LPniPfw/Gzb6MthRJNw4CifDw9QgpASIsAyHnzawd30wuM
        VdqrPk6pX3MLIxU2QnUER316yHFBMuqFEgAFSFo1oDo3LoiLJphumn5PT96ati+tDoCpui
        ELRNSfplEuULwoTQvUB7pgBcjSnKkIk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-249-98YR5I4cPE6etIh_EVy6iQ-1; Mon, 17 Oct 2022 03:27:22 -0400
X-MC-Unique: 98YR5I4cPE6etIh_EVy6iQ-1
Received: by mail-wm1-f72.google.com with SMTP id n19-20020a7bcbd3000000b003c4a72334e7so5155236wmi.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjWUtxQLwEV8jEI6Zuh3YSz4Df1i1QcpeTHLe3Byoa8=;
        b=533nyvFM2oUPY+z8OrS39d2wlKA8fb2ubd3dXShT73ParcGKQGa598uZvY6o1axLdJ
         yTyFS4f3nh27rPXjy4N6Y1VRWYGQlWIo9+aZH5V8UGaBZ7ybDhQbUqWqzrE7/4LGHOGv
         BCKa+3md+zh9H1G0Fvpy2rfFHHdkXpDQs2Q3dG8emZZJvRAUN0uc2VQio+vIqbZTpp2T
         8euPw2fSNkZihj/gw/DB+DkvmHzFYMqLnf5WoVW2z6wV2r7eh/DlRXCsdVfXzpGkeUJi
         FvuSe8EbAcl/sW9Ia8kctoLq00kt8F4SqRAr0QkHE8mTPki1re74kpug7GBQjvO5Cx8l
         CFgw==
X-Gm-Message-State: ACrzQf0i5kZHFBZ/+0daGLTK3t6tPYY67KjXxPOXcHAGZjNeJ1vtvnoW
        UQUBXdsF7ocIxJGvs2+P2Uj34GSkRc/4CfF8DWybeHcDccV7E+Q05Kpupdeu11lIcWqzBGPCuRk
        woHCyBV5f/6liACZBe62svqC6
X-Received: by 2002:a05:600c:255:b0:3c6:e58d:354e with SMTP id 21-20020a05600c025500b003c6e58d354emr6243021wmj.168.1665991641220;
        Mon, 17 Oct 2022 00:27:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5SwYLNo8rpwflySjZODiH6m0DdIanJn9se9sxjS30MEcWLnqg9kzlxEUK4f8asHCYjKCJq5w==
X-Received: by 2002:a05:600c:255:b0:3c6:e58d:354e with SMTP id 21-20020a05600c025500b003c6e58d354emr6243008wmj.168.1665991640975;
        Mon, 17 Oct 2022 00:27:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2300:e5ce:21ba:1d93:4323? (p200300cbc7072300e5ce21ba1d934323.dip0.t-ipconnect.de. [2003:cb:c707:2300:e5ce:21ba:1d93:4323])
        by smtp.gmail.com with ESMTPSA id w3-20020adfee43000000b0022add5a6fb1sm7702303wro.30.2022.10.17.00.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 00:27:20 -0700 (PDT)
Message-ID: <4cc17c82-4f80-d0cc-acb9-c83f8ccf729c@redhat.com>
Date:   Mon, 17 Oct 2022 09:27:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 2/4] module: Update a comment describing what is
 protected by module_mutex
Content-Language: en-US
To:     Petr Pavlu <petr.pavlu@suse.com>, mcgrof@kernel.org
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221016123031.3963-1-petr.pavlu@suse.com>
 <20221016123031.3963-3-petr.pavlu@suse.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221016123031.3963-3-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.22 14:30, Petr Pavlu wrote:
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>   kernel/module/main.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index a12e177ea81f..5288843ca40f 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -62,10 +62,11 @@
>   
>   /*
>    * Mutex protects:
> - * 1) List of modules (also safely readable with preempt_disable),
> + * 1) list of modules (also safely readable with preempt_disable, delete and add
> + *    uses RCU list operations).
>    * 2) module_use links,
> - * 3) mod_tree.addr_min/mod_tree.addr_max.
> - * (delete and add uses RCU list operations).
> + * 3) mod_tree.addr_min/mod_tree.addr_max,
> + * 4) list of unloaded_tainted_modules.
>    */
>   DEFINE_MUTEX(module_mutex);
>   LIST_HEAD(modules);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

