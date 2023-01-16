Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6DD66BDCA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjAPMZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjAPMZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:25:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54751CF7C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:25:37 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so18662412wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=78CL3LWL83HHKF6wLYJClbi8NT0HkDMD/Ek4ymXzJIg=;
        b=IqYM1jiTUL5AnFVQlIpoojz22xgayX9CtUsl0KVhhouiydPda1UwSROGQeC98oVqmN
         xp96SXIRxjDYDBm29PvpwJv4YL6ngjmUQw9A1gAgadI4kj5B5iJoSseqm9dR7i5eoN7z
         jgqyvW6QuUGrBNCx/HfyoAXT6cQpOWjHT8nwXfqbcJugnCFJlBwkL6niR3RG9lYPTw4n
         J39teE7Gb2MMZFGv23sDVuw5MguHj212cKdnILd7XoeibLcDOb3SoBU2HnlFO1DOvWg0
         Ixx3cBn7YCdTt9mZ1UN5/HB1Rm4KcX1shkKLO0UywAfzVZ7ZiBTj4gbvzQlpazcSUONK
         ty/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78CL3LWL83HHKF6wLYJClbi8NT0HkDMD/Ek4ymXzJIg=;
        b=IwDvmBC8bb4JZRiMmc3EjtPFSh6seI6pkwTGp4j8utEm8hd6LKeCFsIsH9cEG3pUXL
         ys1gnv8sIEkNZYiIvMg0WC2kQdlbSfOLUcWGp3fsRXIZtGWb3VD3+QlW7Ij2qIQfppVh
         vU31kOFl4oCKO3mGxdaks7kAho+nSFSJ1eafdF0E94fD5EIkgsPt3c1juaMqbUg97jBu
         hIwZHpnmsx33lsHEDdrc/5ASvwzkdSPmlUXl+KEj6njaxDAKD260OLcmxk6tpPFen1m/
         ewwR9F7cf1/RcgM+ZHKLoMgJmD/xWvrHUVNV6zy7Cu6ZEA2QeX5hfpSqjhTbYMK3/TDE
         /h7g==
X-Gm-Message-State: AFqh2kqfo76VLhpjbbFzBQnaUTF4IblVQ1bZLUnhp9DdpN0d4cszZT68
        M8vFkaTp46OK676yBqKOrCB3ek4ib9c=
X-Google-Smtp-Source: AMrXdXuhQCHMybxA7IaNtXAkTkJClREo5tX/oNRXgoytBfYOC+1mCZy2Sug8ZKxjud/VDk1YQYPKHg==
X-Received: by 2002:a05:600c:3d0e:b0:3d3:4aa6:4fd0 with SMTP id bh14-20020a05600c3d0e00b003d34aa64fd0mr67703880wmb.6.1673871936407;
        Mon, 16 Jan 2023 04:25:36 -0800 (PST)
Received: from localhost (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003c70191f267sm41602277wmo.39.2023.01.16.04.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:25:35 -0800 (PST)
Date:   Mon, 16 Jan 2023 12:25:35 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 7/7] sh: mm: set VM_IOREMAP flag to the vmalloc area
Message-ID: <Y8VCPwoNENBUyWEd@lucifer>
References: <20230113031921.64716-1-bhe@redhat.com>
 <20230113031921.64716-8-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113031921.64716-8-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:19:21AM +0800, Baoquan He wrote:
> Currently, for vmalloc areas with flag VM_IOREMAP set, except of the
> specific alignment clamping in __get_vm_area_node(), they will be
> 1) Shown as ioremap in /proc/vmallocinfo;
> 2) Ignored by /proc/kcore reading via vread()
>
> So for the ioremap in __sq_remap() of sh, we should set VM_IOREMAP
> in flag to make it handled correctly as above.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/sh/kernel/cpu/sh4/sq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
> index a76b94e41e91..27f2e3da5aa2 100644
> --- a/arch/sh/kernel/cpu/sh4/sq.c
> +++ b/arch/sh/kernel/cpu/sh4/sq.c
> @@ -103,7 +103,7 @@ static int __sq_remap(struct sq_mapping *map, pgprot_t prot)
>  #if defined(CONFIG_MMU)
>  	struct vm_struct *vma;
>
> -	vma = __get_vm_area_caller(map->size, VM_ALLOC, map->sq_addr,
> +	vma = __get_vm_area_caller(map->size, VM_IOREMAP, map->sq_addr,
>  			SQ_ADDRMAX, __builtin_return_address(0));
>  	if (!vma)
>  		return -ENOMEM;
> --
> 2.34.1
>

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
