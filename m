Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1756AC223
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCFODk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCFODg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:03:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD345BAB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678111370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YJ33VBWjw2CT0ZZFr8RJg8K/VD7WeNxaY8vu7LGjb0=;
        b=QgX6A6SdtzwVpNdMoIuPuVRFRaUIaFdCudcmqWwcijlIBSgHyhH1ff9zKGROgG8iQvn5Iq
        zRI75CTB931r1RkW4Udwehx7DYk/EBhoOBRJOkeVgesDoNU29uVu4cXCuDl2cqM0tV2jMp
        V4wAcHqGwNX1e1yyk2/XirFyj9iGjfk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-BkvqjibaNs-2FdlYr0KG2A-1; Mon, 06 Mar 2023 09:02:49 -0500
X-MC-Unique: BkvqjibaNs-2FdlYr0KG2A-1
Received: by mail-wm1-f72.google.com with SMTP id az39-20020a05600c602700b003e97eb80524so6789349wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111368;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YJ33VBWjw2CT0ZZFr8RJg8K/VD7WeNxaY8vu7LGjb0=;
        b=I1szqMkfuROcJij5mINF2IQT8xT8mRklduMPbtRGhzz7lHezjKPshLULCpMUfCsqGo
         IGjoDoD+jiMbZn5XEC9vKwZlmuu3ul8X7XfvWBxHzjrcIjM9p3n0ulzfeG5mfvwW7JZw
         bfN1Qq57y6TJpQZ6GqtEzML+/+FSW5kENViN5mCDYu/N74uWqoqYw5ywg2ptnC7Rfd2f
         GZGny43wh01R/HVZ+MGCuh4xWKk2SkdiHWpI42KhP17tiVNX/va+MS53cNjSuua8Ds5Q
         uKOZif8A/bz4T6Rde0toFSpIgCDTAZOrfjF1nT3+iSQ5gjXvRk1Kag+U7YBaXVYETbFK
         XDJQ==
X-Gm-Message-State: AO0yUKVr72E02nN5jtJNQfMRrbSOpZ5lA+JQImLAGBxILfEamiJ0RfsU
        jf7wph/jXZaPZrFnZhXpKZCwFM+gXn6oFfIC8NFlgnRTG29W3mXHaESZvpF1XnjgFFnb9Mj/0Iu
        399Jihh74QBoa2EVbRPnc0ZCv
X-Received: by 2002:a05:600c:4509:b0:3eb:399d:ab28 with SMTP id t9-20020a05600c450900b003eb399dab28mr9282566wmo.37.1678111368201;
        Mon, 06 Mar 2023 06:02:48 -0800 (PST)
X-Google-Smtp-Source: AK7set8UsnDqSBjgdWhLZMOVUCI8XxZWntH6OdOcD4b0pMNiP46MgSM5QIbPtcURKpqK/78/66kQ7g==
X-Received: by 2002:a05:600c:4509:b0:3eb:399d:ab28 with SMTP id t9-20020a05600c450900b003eb399dab28mr9282511wmo.37.1678111367826;
        Mon, 06 Mar 2023 06:02:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:3500:b8a3:191c:eae:cc05? (p200300cbc7043500b8a3191c0eaecc05.dip0.t-ipconnect.de. [2003:cb:c704:3500:b8a3:191c:eae:cc05])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c431500b003daf672a616sm10079911wme.22.2023.03.06.06.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 06:02:47 -0800 (PST)
Message-ID: <b8839e28-1189-bb2d-3afe-d21c2d0182c3@redhat.com>
Date:   Mon, 6 Mar 2023 15:02:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/6] shmem: skip page split if we're not reclaiming
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230302232758.888157-1-mcgrof@kernel.org>
 <20230302232758.888157-5-mcgrof@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230302232758.888157-5-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.23 00:27, Luis Chamberlain wrote:
> In theory when info->flags & VM_LOCKED we should not be getting
> shem_writepage() called so we should be verifying this with a
> WARN_ON_ONCE(). Since we should not be swapping then best to ensure
> we also don't do the folio split earlier too. So just move the check
> early to avoid folio splits in case its a dubious call.
> 
> We also have a similar early bail when !total_swap_pages so just move
> that earlier to avoid the possible folio split in the same situation.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   mm/shmem.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a5a6da51087e..6006dbb7dbcb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1352,6 +1352,12 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>   		goto redirty;
>   	}
>   
> +	if (WARN_ON_ONCE(info->flags & VM_LOCKED))
> +		goto redirty;
> +
> +	if (!total_swap_pages)
> +		goto redirty;
> +
>   	/*
>   	 * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "always" or
>   	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
> @@ -1367,10 +1373,6 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>   	}
>   
>   	index = folio->index;
> -	if (info->flags & VM_LOCKED)
> -		goto redirty;
> -	if (!total_swap_pages)
> -		goto redirty;
>   
>   	/*
>   	 * This is somewhat ridiculous, but without plumbing a SWAP_MAP_FALLOC

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

