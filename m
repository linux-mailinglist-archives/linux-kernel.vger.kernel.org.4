Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9F9686F99
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjBAUSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBAURr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:17:47 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D1B63870
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:17:47 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d14so18432943wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 12:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sggLwzyUTSjgBIuaJEzP79mf/yrQdo3fwuaMhlgMyAg=;
        b=Q16VYukoMyBcpYogXwJj7qSzf23Nca0ykWYVVqORa8MWA3cOs7YYNyBEOzmDcgy9V0
         qdcJLZWzIsihJwCHfsdpGEnpyaIoC1ZOu1CECV+FNoBTaKGxKPejBpftRQ/R9EZN3l85
         RBwf6QpFww2dpjrferxAKMyz7gNYR9lKkuVEGKol+k54AwvRl1F8EZPF0RV1p7MeDePO
         zTqE0AbCUDvAvi9jorKLdgtJJfNC0m9ZoWPgfNPLB5z6f+WeW7ChCRQCxOkCUQ/SBmyg
         YvxiZ/gGh3EXJzcrPt4WFa8SMG5WgjJhfUCMAHiDkte8zoD2A5dlFotemvSbVVWqfx0C
         LrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sggLwzyUTSjgBIuaJEzP79mf/yrQdo3fwuaMhlgMyAg=;
        b=P2MuS3p2U8Z884JcHx9fAKYvR9lE8d+z7BOhLEsGfCYqBkzmELR2ORijcfMpzV/qYZ
         YxXxuxAtvw1oQxFu8oEPn5vkH4hwoLvcz67KjBEX4YM5X0E49jbd9Qw4f4pGLQNovNf0
         V3iIGe81ENHrqubJX9zz1Y2hd6AJvQ8r0YA9ZiNYC9X9TPpG+vbCTM6kave5jiy7w2t9
         hJCBhxRhQtMZg6RP4faPCJltLGTYHljTfmBHXtFDrLou5CtoduHKdntoKsKILzvRJVLG
         tqxI6d3BIi9kJiGpNdsSvsbgzCeXyDmCDQtC9dLMWg4ZOUbgfVlf2+JiGYWOH6AKg8kc
         OCNw==
X-Gm-Message-State: AO0yUKUYpB8zXznw8W4CFD6XFf+/6ZGAKp00M/DAPJFyWNBoozObZK+D
        Otop/GhNp8yDp0vdYqh4j8W0nWJmWCQ=
X-Google-Smtp-Source: AK7set+fr6vKb2OMIQX9zZSglbuOws0xM17kZgxoQZ42JzYd5vN+1jVA0zh0yCDQt/vDmbY5kH9ZWg==
X-Received: by 2002:a05:6000:a07:b0:2bf:95c0:6b30 with SMTP id co7-20020a0560000a0700b002bf95c06b30mr88786wrb.31.1675282665475;
        Wed, 01 Feb 2023 12:17:45 -0800 (PST)
Received: from localhost (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.gmail.com with ESMTPSA id r7-20020a5d52c7000000b002bdf5832843sm18021271wrv.66.2023.02.01.12.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:17:44 -0800 (PST)
Date:   Wed, 1 Feb 2023 20:17:43 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, stephen.s.brennan@oracle.com,
        urezki@gmail.com, willy@infradead.org, hch@infradead.org,
        error27@gmail.com
Subject: Re: [PATCH v4 4/7] mm/vmalloc: explicitly identify vm_map_ram area
 when shown in /proc/vmcoreinfo
Message-ID: <Y9rI5zuZIX3WvzSY@lucifer>
References: <20230201091339.61761-1-bhe@redhat.com>
 <20230201091339.61761-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201091339.61761-5-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 05:13:36PM +0800, Baoquan He wrote:
> Now, by marking VMAP_RAM in vmap_area->flags for vm_map_ram area, we can
> clearly differentiate it with other vmalloc areas. So identify
> vm_map_area area by checking VMAP_RAM of vmap_area->flags when shown
> in /proc/vmcoreinfo.
>
> Meanwhile, the code comment above vm_map_ram area checking in s_show()
> is not needed any more, remove it here.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5a3ea6cb7ec2..e515dbacb0cb 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4232,14 +4232,11 @@ static int s_show(struct seq_file *m, void *p)
>
>  	va = list_entry(p, struct vmap_area, list);
>
> -	/*
> -	 * s_show can encounter race with remove_vm_area, !vm on behalf
> -	 * of vmap area is being tear down or vm_map_ram allocation.
> -	 */
>  	if (!va->vm) {
> -		seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
> -			(void *)va->va_start, (void *)va->va_end,
> -			va->va_end - va->va_start);
> +		if (va->flags & VMAP_RAM)
> +			seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
> +				(void *)va->va_start, (void *)va->va_end,
> +				va->va_end - va->va_start);
>
>  		goto final;
>  	}
> --
> 2.34.1
>

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
