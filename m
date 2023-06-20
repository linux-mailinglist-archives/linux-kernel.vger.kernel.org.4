Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474FA73642D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjFTHOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFTHOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639FB1731
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687245179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sl2grgufuGzfS3XSwpjzJA7IILsYC/N9nHuDHXJPqDQ=;
        b=SigvpLy+rag5CKU0cQoGIMUtvQ+bCtN5UCsVPBumC49ST/8RT6kaezKyv8TTsBNrfPrJvn
        69o/dVKgUrIlcg6wrKrNlEQ7BvJLj7moLOVNFj4WrR0pO3+56Atll3SiQ6sUCMDgafIJCS
        ltqixuNfvLVJgCJDQFXBc1OqEu5jU6o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-oq8bGElqMTmFEkY5oJ0-4A-1; Tue, 20 Jun 2023 03:12:57 -0400
X-MC-Unique: oq8bGElqMTmFEkY5oJ0-4A-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b45e987207so27536051fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687245173; x=1689837173;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sl2grgufuGzfS3XSwpjzJA7IILsYC/N9nHuDHXJPqDQ=;
        b=kd+2l9/n0NG1Y6qLPZajJwMCb40s856eLZkpFTCohhC1aRSefe5YVARFZCW3S59S8L
         qwHAnUHLf2eXbgvtBQmsXLzWmiZ2VJrdSwwJi9DM0XzPhn0BxpyfKQfUTP8zBKAwnDH5
         9mkTpSGmAWHqXbCIT5btJ+NHFTM3S/6wNo9QIACNg9KPsyJEMC03QbT9cJ7ICVnbne7v
         hR2g6dUMGkOWZxTDU1sd/5ISLRu9dREDi5N6QpEcHNiZMKEqQPnUebJNn/l4DArlAsBw
         SXwKCCuJD/5Gss5w8odUwwbqx2vakkKaZ7Z7z2W9FTRDFNXbQ6yyxixmTE5vhLKtg0+j
         mRYw==
X-Gm-Message-State: AC+VfDxwPf8/C17ff35XHa65Y+DYtzOWHW/mv4vhKaUXGwGATmsuynsM
        WoptNa6EMwtEa3OUVOKhIM3Kt2lFwoC9BKFwDU80rdewptIUK6DHRwDKJzLaZWa1N1FfWpwKMzA
        Cmh31O6BqjbQ04leCDc+j5oLxq8RUSvhS
X-Received: by 2002:a2e:8443:0:b0:2b1:bb66:7b69 with SMTP id u3-20020a2e8443000000b002b1bb667b69mr6470913ljh.32.1687245173361;
        Tue, 20 Jun 2023 00:12:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UwtHUVNvptYW894cJKPC9dIxSY6AG/GHv9dPoLT1wlZUuP8uibPLIVZY2HwDYi22XCLmmEw==
X-Received: by 2002:a2e:8443:0:b0:2b1:bb66:7b69 with SMTP id u3-20020a2e8443000000b002b1bb667b69mr6470893ljh.32.1687245172825;
        Tue, 20 Jun 2023 00:12:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:d200:8745:c520:8bf6:b587? (p200300cbc739d2008745c5208bf6b587.dip0.t-ipconnect.de. [2003:cb:c739:d200:8745:c520:8bf6:b587])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bce07000000b003f9b155b148sm4455052wmc.34.2023.06.20.00.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 00:12:52 -0700 (PDT)
Message-ID: <ed83df65-f785-7077-ddd0-4e53d6fa6056@redhat.com>
Date:   Tue, 20 Jun 2023 09:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20230620011719.155379-1-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/memory_hotplug.c: don't fail hot unplug quite so
 eagerly
In-Reply-To: <20230620011719.155379-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.23 03:17, John Hubbard wrote:
> mm/memory_hotplug.c: don't fail hot unplug quite so eagerly
> 
> Some device drivers add memory to the system via memory hotplug. When
> the driver is unloaded, that memory is hot-unplugged.

Which interfaces are they using to add/remove memory?

> 
> However, memory hot unplug can fail. And these days, it fails a little
> too easily, with respect to the above case. Specifically, if a signal is
> pending on the process, hot unplug fails. This leads directly to: the
> user must reboot the machine in order to unload the driver, and
> therefore the device is unusable until the machine is rebooted.

Why can't they retry in user space when offlining fails with -EINTR, or 
re-trigger driver unloading?

> 
> During teardown paths in the kernel, a higher tolerance for failures or
> imperfections is often best. That is, it is often better to continue
> with the teardown, than to error out too early.
> 
> So in this case, other things (unmovable pages, un-splittable huge
> pages) can also cause the above problem. However, those are demonstrably
> less common than simply having a pending signal. I've got bug reports
> from users who can trivially reproduce this by killing their process
> with a "kill -9", for example.
> 
> Fix this by soldering on with memory hot plug, even in the presence of
> pending signals.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   mm/memory_hotplug.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8e0fa209d533..57a46620a667 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1879,12 +1879,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>   	do {
>   		pfn = start_pfn;
>   		do {
> -			if (signal_pending(current)) {
> -				ret = -EINTR;
> -				reason = "signal backoff";
> -				goto failed_removal_isolated;
> -			}
> -
>   			cond_resched();
>   
>   			ret = scan_movable_pages(pfn, end_pfn, &pfn);

No, we can't remove that. It's documented behavior that exists precisely 
for that reason:

https://docs.kernel.org/admin-guide/mm/memory-hotplug.html#id21

"
When offlining is triggered from user space, the offlining context can 
be terminated by sending a fatal signal. A timeout based offlining can 
easily be implemented via:

% timeout $TIMEOUT offline_block | failure_handling
"

Otherwise, there is no way to stop an userspace-triggered offline 
operation that loops forever in the kernel.

I guess switching to fatal_signal_pending() might help to some degree, 
it should keep the timeout trick working.

But it wouldn't help in your case because where root kills arbitrary 
processes. I'm not sure if that is something we should be paying 
attention to.


-- 
Cheers,

David / dhildenb

