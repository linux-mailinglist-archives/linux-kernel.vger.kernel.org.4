Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08D166BDC4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjAPMYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjAPMYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:24:10 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC26B1E1C6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:24:03 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t5so22901576wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3vLKemaUaWA2M71p2ZRoCgzBORvg7EAfdOMqyeO6w0s=;
        b=TmbuMuF05vpgltiucUluFh+Y6gDWwdnY5Tm4iaGqOVliEZzgROT2LyX6ObzXmdqgKg
         hL+Z7HPembSdWEozpDQapOj1nSdd8adDSKSq2JC9xmwoV+9Y0nzSxIHDOyqMdY9nPYz+
         TSsxEMoK2ozlLZ9W8WwC4FwewYNVqM/ohxDRQgzFK57C/h9V/lrGAg3Z6rm9PjAdnWFS
         tQMoRyp/OEK8MAgHRxxQqzbaOM4EnJ9wFQY2Uj95a90N8MlEDuZJiUFpNWhIJIYafAex
         pcWRf1xnojjABMVUV8KMiWc6uhYxNxgSu+FHPfv6hBTcV73lMxH4JUfaQry8YuJzye4B
         P+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vLKemaUaWA2M71p2ZRoCgzBORvg7EAfdOMqyeO6w0s=;
        b=DGhnU8fk+JGeGqUdvuUsCzrbjEg8pQUadMnDyoBLCA+vlQEySGoHWXHdaoTLxavD/x
         H6lOYag7Ggd3aM1OK21WIw1zpSQhD56pXN8nBS9qDUbrhx8MB43ULad1rGZFE3zqhDog
         BI/zN+22kocE4pImYQyBfWEt8wT+Yjc+BZPG8QVqcC8VJHj5RQ4b7dVwL3/RSE/AYk1G
         qeqYtaek4mDdOJqmYnzOjsdxrer5NXc5OffTm7yevyJwgSacC6oLjItU394HQJdXAiSK
         h27j7jnMFII+SJOotkDjnQEaGxw3lEhrbRZqsrb8my0CwI1lcPvnk7krodg8ln/BCfFX
         Ap6Q==
X-Gm-Message-State: AFqh2kq2z+WXGYgOclcKv6FwGIul7fkFEOQ98S7gk1wVb0h30e9F6E9P
        JKqazTcz4sWtYQ78U0NPH8c=
X-Google-Smtp-Source: AMrXdXtTVrb9gX3/l3rkA6X80ajTCz5+pUjgZESkh6QTGnxtB+LLVHe1QNkw01HfblRXq1S/1WabqA==
X-Received: by 2002:a05:6000:256:b0:2ba:f555:613e with SMTP id m22-20020a056000025600b002baf555613emr6077447wrz.65.1673871842245;
        Mon, 16 Jan 2023 04:24:02 -0800 (PST)
Received: from localhost (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.gmail.com with ESMTPSA id z12-20020adfd0cc000000b002bdff778d87sm3408782wrh.34.2023.01.16.04.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:24:01 -0800 (PST)
Date:   Mon, 16 Jan 2023 12:24:00 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 4/7] mm/vmalloc: explicitly identify vm_map_ram area
 when shown in /proc/vmcoreinfo
Message-ID: <Y8VB4GQ1UnTCD2UW@lucifer>
References: <20230113031921.64716-1-bhe@redhat.com>
 <20230113031921.64716-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113031921.64716-5-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:19:18AM +0800, Baoquan He wrote:
> Now, by marking VMAP_RAM in vmap_area->flags for vm_map_ram, we can
> clearly differentiate it with other vmalloc areas. So identify
> vm_map_area area by checking VMAP_RAM of vmap_area->flags when shown
> in /proc/vmcoreinfo.
>
> Meanwhile, the code comment above vm_map_ram area checking in s_show()
> is not needed any more, remove it here.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 13875bc41e27..4a10b3b692fa 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4225,11 +4225,7 @@ static int s_show(struct seq_file *m, void *p)
>
>  	va = list_entry(p, struct vmap_area, list);
>
> -	/*
> -	 * s_show can encounter race with remove_vm_area, !vm on behalf
> -	 * of vmap area is being tear down or vm_map_ram allocation.
> -	 */
> -	if (!va->vm) {
> +	if (!va->vm && (va->flags & VMAP_RAM)) {
>  		seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
>  			(void *)va->va_start, (void *)va->va_end,
>  			va->va_end - va->va_start);
> --
> 2.34.1
>

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
