Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4061723A8C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbjFFHwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbjFFHu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:50:59 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C68230EA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:47:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-651f2f38634so5348878b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686037635; x=1688629635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GbXc2BX6hpszzsNThewFjRTK+/9Y/wp8P/nG0hXLi4Y=;
        b=V4Qve/5ez6gahndjfvGusthMoAdT7qf9S8UVIX5Af/dQIfQhECy5nVCt/BY+LikRlU
         8qikAzCND39gqt4aE2Vna0XdoVeswfQF5H8aETB3iVgydRuD6DgzaryApR/3jxAsr88y
         KdXfjoZV3HEvVqqsflqjF6sL0zvXpEg+LUvdVS2cFce40iNIsIkFS3Fwh0/+bIVAiLiB
         yNh3Qhzn0+uFm0zt4fCVYh1kdpYKheFsBeGwbtMd8A+NwqCbMoswPB83FG6GFSHp+h0L
         NsswN3gM5X9dJnCCdogL4+NoogyE0ktpj7pyVi6DsmeulDjk+EWcHOR6hhh1fT4S6iQO
         BnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686037635; x=1688629635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbXc2BX6hpszzsNThewFjRTK+/9Y/wp8P/nG0hXLi4Y=;
        b=JE12wSf+XgEyqL+B2+LYasIotxFYSlMkOLlVrkh4B2UNu7xWKAR6isUMGKEnn+Nl/t
         UHq1Nyx2bNTR/o9GTPgvt9CPpQW6p6Ghu7UDmOTltsXqazVa7Q36OhWIsb71GINzNK1X
         RzC/1KSFULQpzLZ7HLyCkD+wwlm4Rfzn/6AxdUwlONPY2M2aYG0DSW1NX+l22H7u+znV
         +5rRTWEF3tochqZDgqQDhACwFHMUmKu7cXlniP+Tc8DwbAVQsAUqQhkOO8WtsKoGPSv0
         KDk30UmZgcuUjenHUKfvV9Q+SGmuCgb2F294Hp7QtR0B0TWDAQrhrC1XJW1m3elfJmeb
         C5Cw==
X-Gm-Message-State: AC+VfDwITvEvtIoA6W8kmjOCw55x+zNQm7UuCv+REuH8UPMhKWQC8DJ/
        ct1a962X1/YP4eZT1qnCWPA=
X-Google-Smtp-Source: ACHHUZ4+E0I+/ySk/qg7t4AoCbf2mf+fvWtkT/4DZ8MsJU2XA53UWXJYbhs4c2lBg5KTA5HgpFKWGA==
X-Received: by 2002:a05:6a20:9381:b0:107:35ed:28b5 with SMTP id x1-20020a056a20938100b0010735ed28b5mr2170016pzh.2.1686037635025;
        Tue, 06 Jun 2023 00:47:15 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 ([118.42.100.119])
        by smtp.gmail.com with ESMTPSA id iw13-20020a170903044d00b001b03213eb7bsm7794927plb.301.2023.06.06.00.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 00:47:14 -0700 (PDT)
Date:   Tue, 6 Jun 2023 16:48:04 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab_common: reduce an if statement in create_cache()
Message-ID: <ZH7ktMtP8ho2/SFT@debian-BULLSEYE-live-builder-AMD64>
References: <20230606065543.1324-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606065543.1324-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 02:55:43PM +0800, Zhen Lei wrote:
> Move the 'out:' statement block out of the successful path to avoid
> redundant check on 'err'. The value of 'err' is always zero on success
> and negative on failure.
> 
> No functional changes, no performance improvements, just a little more
> readability.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  mm/slab_common.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 607249785c077e9..f6fe35105774944 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -236,14 +236,12 @@ static struct kmem_cache *create_cache(const char *name,
>  
>  	s->refcount = 1;
>  	list_add(&s->list, &slab_caches);
> -out:
> -	if (err)
> -		return ERR_PTR(err);
>  	return s;
>  
>  out_free_cache:
>  	kmem_cache_free(kmem_cache, s);
> -	goto out;
> +out:
> +	return ERR_PTR(err);
>  }
>  
>  /**

Hi Zhen,
nice cleanup!

Looks correct to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> -- 
> 2.25.1
> 

-- 
Hyeonggon Yoo

Doing kernel stuff as a hobby
Undergraduate | Chungnam National University
Dept. Computer Science & Engineering
