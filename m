Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7863264E7DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLPHmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLPHmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:42:40 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCD73E0B5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:42:39 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso1606555pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p11g1cwrNZTNPGZ9JOLQCCww3AgSudE2cVlNLnF16zc=;
        b=ixvI7Ak3I75fySctV1/dd+sdZTABsHg8bu7hFpLuyN8BHKmGfN3z1Aj/0VKzeMjcv3
         Yx2YarpUotQqLooLXd7KrsAYxed3b55Q1KiMlbqTzvob8qcVCsK4zQv+5Jyj4Zzc3r5R
         SHdVgW2Siaz+bwQ8R8ziN5juuRyjNlYJzZHVeLs32oSEmmAh+UXapL/LWJIyI5s0S4fX
         mj0d3kfvEgX5Ts3EP3qykq2Jed42QJgR8LHUdIpi1rK1iaXOOskmnLea0OKLq37aB//X
         jd7hMaXbMb6TNspCjwIS3MoZWBqbBaiX9mtaUuYsEq3QpMKStj/9nSxpeMRa6cW/hSzo
         Ndkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p11g1cwrNZTNPGZ9JOLQCCww3AgSudE2cVlNLnF16zc=;
        b=F0BJE9kw9EqkmaXCDHk5cGA0z0ykuOk5ZFLZdN9qIIjHbGiKBTjETzCz834D18B/Bl
         opKXkE+Tf2xYuE4VGekl47L+qzmGAFn3cdExCHO1Prjv+CbvPKM9zn07dh5WqHYcKSWs
         894tHzAoEWHnEIH53RhLkqZtMBqcM/13SwbX22E6z8PpOoLyPjy9Ltnz5Jk+p9rGEH7u
         TyWaxIyuOQmo08Bj0DjCJV5Xxiw2x6r93MK2/33EibT/uBDPqoeYTT0Km/M6j6OGun0K
         M4/8fLWkZWL3aC2AG9ITZNQOOJJGvm7L0glCQCOPNcca8mj8pdmOErVzzjt/0gtY+dfW
         T0MA==
X-Gm-Message-State: ANoB5pkDM7pKAq6M6TyJ3mzjp30Mx0OP18UuQKPisyn5Y7ycI+pT99kC
        09GKfsmwWb3E88Qvp72lDW0=
X-Google-Smtp-Source: AA0mqf45G+6k9iUrkTKEigJA7PtUlWdNG+akMhT77GtTrdF0p5ErbSlUKD9wC544JLf8+PzblnM7nQ==
X-Received: by 2002:a05:6a20:65a1:b0:aa:7eab:25a5 with SMTP id p33-20020a056a2065a100b000aa7eab25a5mr34541260pzh.34.1671176559146;
        Thu, 15 Dec 2022 23:42:39 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id c9-20020a170903234900b001885041d7b8sm854453plh.293.2022.12.15.23.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 23:42:38 -0800 (PST)
Date:   Fri, 16 Dec 2022 16:42:32 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xuqiang36@huawei.com
Subject: Re: [PATCH] mm, slub: fix uninitialized variable in __slab_free
Message-ID: <Y5whaFO6Z1eaQzeu@hyeyoo>
References: <20221216033119.14159-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216033119.14159-1-chenjun102@huawei.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 03:31:19AM +0000, Chen Jun wrote:
> new.frozen is not initialized before it is used.
> 
> Fixes: 2cfb7455d223 ("slub: Rework allocator fastpaths")
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
>  mm/slub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 13459c69095a..8628c88875b6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3593,6 +3593,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  		return;
>  	}
>  
> +	new.frozen = 0;
>  	do {
>  		if (unlikely(n)) {
>  			spin_unlock_irqrestore(&n->list_lock, flags);
> -- 
> 2.17.1

This is incorrect because new.frozen is initialized when new.counters is
initialized.

See definition of struct slab in mm/slab.h:

struct slab {

	[...]
	union {
		unsigned long counters;
		struct {
			unsigned inuse:16;
			unsigned objects:15;
			unsigned frozen:1;
		};
	};
}

-- 
Thanks,
Hyeonggon
