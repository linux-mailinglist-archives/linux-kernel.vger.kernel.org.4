Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8314966BD1D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjAPLpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjAPLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:44:53 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973611F4B7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:44:46 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id y18so26148099ljk.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Sj8t7w90/b4YfbubGLhW8jse4BDSgEBS6GznI1fgYs=;
        b=n6YvyCy3rYblvixVSzS5lObopYA/91DnkkB77eze+zE1jeTE1e3i75EUhbc0biSVZP
         HZHd7fHPuMMnBoGSSK0O8ln+QpdS8vmpGUl6KDpfPh3J14uYrvbmVqyGVFs6M4w1Gijw
         78UVPWkVeg8Do6ghRmiEJL+pXCGqCOXSpI8uFUEIPrybLJ+uZmTDSmSSdbLuJ8mepKJZ
         chPE/FhJCju3yBor4q8E0BgnEmk7ok8G9nR90gvl9uoD8cx2brcoXIWSloEGPHioUsFS
         yI9fwV1oAflY+FDOgg4X12gIuJk0l38dUsd28O+5i4kwDD1EOe8h5mIGvNDUpWQcU0ei
         Wtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Sj8t7w90/b4YfbubGLhW8jse4BDSgEBS6GznI1fgYs=;
        b=SGkAnfgZFn8oLm6cUWY6GHxdy6L/xY9bXZGU6fqSahG7oAHvKvJIXIO0HFb1DLPpyY
         t0T5oYs/msez9NDlNgDVa0y5Q+FQ5/8M29I5Yvjme0tGJSNLEH2f8BMYh1Szb+vY5f18
         qnHC8x7o/3p+ogaVlQXTLfYqExPqQ3OuNqiYQFfd57/5z/dtqk/U1Ein+WG7JSUQ914t
         64MPCVGdvIy2/GGEEzp7nIGGXnbTyT/EoHz2AeIxFb2wI/FRqWWwF22ftMJlAQdct9Bh
         ENhOITDIv+g75nRfsqGfpPfKd85JxJaD3uBnx+24fwXpTKhX6EfNl+94h0a+iLNJk8bl
         OrkA==
X-Gm-Message-State: AFqh2koTqntsQZSSesGJ4kmpjYwfUBFqyjveeQnaMSOhqHXKwIP0bIIh
        HQ7fV9OOvU74TMkb6x2dUY4=
X-Google-Smtp-Source: AMrXdXugYckFR5zuwXZ4nj4hn5Lzy79WsRw0BBu8l4Tp8lQpK6eAufF1o1yGqjaZnfsI+IvzkU6c7Q==
X-Received: by 2002:a2e:9c85:0:b0:284:819:1f85 with SMTP id x5-20020a2e9c85000000b0028408191f85mr10871890lji.40.1673869484830;
        Mon, 16 Jan 2023 03:44:44 -0800 (PST)
Received: from pc636 (host-90-235-24-7.mobileonline.telia.com. [90.235.24.7])
        by smtp.gmail.com with ESMTPSA id f17-20020a2e6a11000000b00282cffdfe6asm3326139ljc.61.2023.01.16.03.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:44:44 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 16 Jan 2023 12:44:42 +0100
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, urezki@gmail.com,
        lstoakes@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 5/7] mm/vmalloc: skip the uninitilized vmalloc areas
Message-ID: <Y8U4qnFScPZjJGBm@pc636>
References: <20230113031921.64716-1-bhe@redhat.com>
 <20230113031921.64716-6-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113031921.64716-6-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:19:19AM +0800, Baoquan He wrote:
> For areas allocated via vmalloc_xxx() APIs, it searches for unmapped area
> to reserve and allocates new pages to map into, please see function
> __vmalloc_node_range(). During the process, flag VM_UNINITIALIZED is set
> in vm->flags to indicate that the pages allocation and mapping haven't
> been done, until clear_vm_uninitialized_flag() is called to clear it.
> 
> For this kind of area, if VM_UNINITIALIZED is still set, let's ignore
> it in vread() because pages newly allocated and being mapped in that
> area only contains zero data. reading them out by aligned_vread() is
> wasting time.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 4a10b3b692fa..dbcdcad2276b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3660,6 +3660,11 @@ long vread(char *buf, char *addr, unsigned long count)
>  		if (!vm && !flags)
>  			continue;
>  
> +		if (vm && (vm->flags & VM_UNINITIALIZED))
> +			continue;
> +		/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
> +		smp_rmb();
> +
>  		vaddr = (char *) va->va_start;
>  		size = vm ? get_vm_area_size(vm) : va_size(va);
>  
> -- 
> 2.34.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
