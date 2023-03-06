Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC76AC2AE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjCFOMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjCFOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:11:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FFD32CF3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678111695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nO3R9JigNCHMlqWS1p9K0Fb3M5vUza+J8/tkd1LfBR8=;
        b=IMiULH4IwV+1qXdm5Wk0iEFva4jpu4+lFH+SDh2lN12GWTp1e8CEp/C5iHfCwkR0/vXjCQ
        BneBafE5850qVJx6GEGgeVs0ZKusDxRMasGGcnJ1/SCXapYecgknoIEGdkQkpEx2I7NSJm
        tC/zzjCeO1IIGwl9W9DhSJzpNPsLq6A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-xYDZ4vPxMkCHVyoWerlTVA-1; Mon, 06 Mar 2023 09:02:09 -0500
X-MC-Unique: xYDZ4vPxMkCHVyoWerlTVA-1
Received: by mail-wm1-f69.google.com with SMTP id r7-20020a05600c35c700b003eb3f2c4fb4so3775172wmq.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111314;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nO3R9JigNCHMlqWS1p9K0Fb3M5vUza+J8/tkd1LfBR8=;
        b=h5NCvYYXbTjMQgx9kweIU5qyxmM7G5Jc4CjuCTPyiXnnHJvX6r4ZCpeW42wHN8xCxp
         yotWcQe/lpjYdX/78jPFm89sxFOCMoQg/Ouf63Q5z6rM3RBj88pdTboSZ36xeFVCZnh4
         3kON0xsFrSAgsC17+thC+jkuTQCgmNlqVCDdEwKsxi3AUwsslKSXvqkcTlcq7fRIq2YB
         p+AH1e4bKWSrl6To3xtDCvRvP8nVOU90Hrn7/RO9211H2xaOjkzsrhH5j5cOOs+LfsV6
         ogbcTsot9gd38NASiePkTwiw24LwRro0nSiKS9Ce6zOBjsCUTw1kR5N50guNhvMtz9rz
         W41g==
X-Gm-Message-State: AO0yUKU2bjba8D1BaZA5GzL/dHlailbtTsMO152YOXty8bv3IY/WxAn9
        YNrBfNLNHX+sh5XLUKIFCqW6bQDfj4ha+RoRwfXr8qqOcp40XNTOzOQqkzgFpMX0iigB3adWC8H
        xLwBW/lSqxvAXMJZ5eys79wgMIJKLlBU1
X-Received: by 2002:a05:600c:4f50:b0:3eb:2b88:a69a with SMTP id m16-20020a05600c4f5000b003eb2b88a69amr9473186wmq.14.1678111314264;
        Mon, 06 Mar 2023 06:01:54 -0800 (PST)
X-Google-Smtp-Source: AK7set8XuEHIVOaesg76pe7hbbkGNdsq5dTAXQ/i2sABGlubrU8h/rag1QBDgZ3/C2I2SKHPly0img==
X-Received: by 2002:a05:600c:4f50:b0:3eb:2b88:a69a with SMTP id m16-20020a05600c4f5000b003eb2b88a69amr9473141wmq.14.1678111313841;
        Mon, 06 Mar 2023 06:01:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:3500:b8a3:191c:eae:cc05? (p200300cbc7043500b8a3191c0eaecc05.dip0.t-ipconnect.de. [2003:cb:c704:3500:b8a3:191c:eae:cc05])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003eb0d6f48f3sm15048551wmn.27.2023.03.06.06.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 06:01:53 -0800 (PST)
Message-ID: <2a3386e7-9b09-f22e-ee39-a37a046d54ec@redhat.com>
Date:   Mon, 6 Mar 2023 15:01:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/6] shmem: move reclaim check early on writepages()
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230302232758.888157-1-mcgrof@kernel.org>
 <20230302232758.888157-4-mcgrof@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230302232758.888157-4-mcgrof@kernel.org>
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
> i915_gem requires huge folios to be split when swapping.
> However we have  check for usage of writepages() to ensure
> it used only for swap purposes later. Avoid the splits if
> we're not being called for reclaim, even if they should in
> theory not happen.
> 
> This makes the conditions easier to follow on shem_writepage().
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   mm/shmem.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 2b9ff585a553..a5a6da51087e 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1340,6 +1340,18 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>   	swp_entry_t swap;
>   	pgoff_t index;
>   
> +	/*
> +	 * Our capabilities prevent regular writeback or sync from ever calling
> +	 * shmem_writepage; but a stacking filesystem might use ->writepage of
> +	 * its underlying filesystem, in which case tmpfs should write out to
> +	 * swap only in response to memory pressure, and not for the writeback
> +	 * threads or sync.
> +	 */
> +	if (!wbc->for_reclaim) {

if (WARN_ON_ONCE(!wbc->for_reclaim))

> +		WARN_ON_ONCE(1);	/* Still happens? Tell us about it! */

And drop the comment :) That's what WARN_ON_ONCE is all about.

> +		goto redirty;
> +	}
> +
>   	/*
>   	 * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "always" or
>   	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
> @@ -1360,18 +1372,6 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>   	if (!total_swap_pages)
>   		goto redirty;
>   
> -	/*
> -	 * Our capabilities prevent regular writeback or sync from ever calling
> -	 * shmem_writepage; but a stacking filesystem might use ->writepage of
> -	 * its underlying filesystem, in which case tmpfs should write out to
> -	 * swap only in response to memory pressure, and not for the writeback
> -	 * threads or sync.
> -	 */
> -	if (!wbc->for_reclaim) {
> -		WARN_ON_ONCE(1);	/* Still happens? Tell us about it! */
> -		goto redirty;
> -	}
> -
>   	/*
>   	 * This is somewhat ridiculous, but without plumbing a SWAP_MAP_FALLOC
>   	 * value into swapfile.c, the only way we can correctly account for a

LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

