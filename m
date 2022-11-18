Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6492362F3D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiKRLhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241586AbiKRLhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:37:07 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF76F97345;
        Fri, 18 Nov 2022 03:36:20 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so4809645pjl.3;
        Fri, 18 Nov 2022 03:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQTkJG6vtTjSw1QDg2CpqnHiBaML0X5nO5Q/zgAHjJs=;
        b=FSxO4upCiy5Qd6ep2BBFisIeyWZ+D5vSLW3Ow/h8K40AVCtOf51KOuZUImxLiPZywH
         koR+wH5GFs4ZrbkVkTgcvC9EI8vkubomItYg6mfbC+XuBII7bJv5oV0Qt15kUn0+INIH
         m48HNO6e7xWoVhfE4d5/jlcAsV5AfFdz773VQuoctfrRLjamSW5qnDRzn/jfxRHseevp
         yOZy7BCzc8O6aT6fI1WSCqVT28CwbH7LU9j/zluH8rEX4PiDbmQ6zxBMHHvH5eezjdky
         dt3Apz3AGnDcrIXiApdjlHyUaR/o8BhH5bEUUFEBec2eBCTHo+ymGbtkXuHmzZuSwc2Z
         G6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQTkJG6vtTjSw1QDg2CpqnHiBaML0X5nO5Q/zgAHjJs=;
        b=jmi/O91lH0vSTPVQ72CPP/e1Ll6J2uLSIUW/d+aeVsTx9B6AVEXRJwMp+WukfZSdgJ
         XK0yoVWMKhLB1UhjZQyI0ZJC9Ttd/0Zh54j2jcUXASuOz4MQDEgCoyDt0pRZo7Kv+1kD
         ViSaBCd6DOiJxz+xl1qaqqoqVqpJ1rW02lHw1v3Bt9s4VxcSfthMtAbrqfo+C4GVygSj
         AWBrExzMHSyqOmW3zNPFON5+mDIkpd3ZnTtxsrCr1XLTXUgjAJUA/jCTTjjesUZzVEUZ
         rPrWx+yWcFY4eh9ct7J3lLtVYBwouPghVxEF1uIVFGu6xBpTgtptqfQqjVNS10Y3PaLW
         Oh8Q==
X-Gm-Message-State: ANoB5plM5zdkN7zKhHh1Vf8I1pAVL/ZbPfqvOSXnFqYOL090Oz2qSqml
        p54O2igFvjtzWbeoZs+11ysDK/HwrxM=
X-Google-Smtp-Source: AA0mqf4SVBbjrGyE3yo/NOKhVg2kU6NEYZMORQuo5dI35UBGFiqlsJO0rf3Du8HYoy3w+pxrXWgr9A==
X-Received: by 2002:a17:90b:2684:b0:218:907c:da24 with SMTP id pl4-20020a17090b268400b00218907cda24mr407705pjb.18.1668771380175;
        Fri, 18 Nov 2022 03:36:20 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id e1-20020a056a0000c100b0056283e2bdbdsm2916623pfj.138.2022.11.18.03.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:36:19 -0800 (PST)
Date:   Fri, 18 Nov 2022 20:36:13 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/2] slab: Remove special-casing of const 0 size
 allocations
Message-ID: <Y3duLdce3Srlewsq@hyeyoo>
References: <20221118034713.gonna.754-kees@kernel.org>
 <20221118035200.1269184-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118035200.1269184-2-keescook@chromium.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:51:59PM -0800, Kees Cook wrote:
> Passing a constant-0 size allocation into kmalloc() or kmalloc_node()
> does not need to be a fast-path operation, so the static return value
> can be removed entirely. This is in preparation for making sure that
> all paths through the inlines result in a full extern function call,
> where __alloc_size() hints will actually be seen[1] by GCC. (A constant
> return value of 0 means the "0" allocation size won't be propagated by
> the inline.)
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503
> 
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/slab.h | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 9033937c758e..84be05208418 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -561,17 +561,13 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
>  #ifndef CONFIG_SLOB
>  static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  {
> -	if (__builtin_constant_p(size)) {
> +	if (__builtin_constant_p(size) && size) {
>  		unsigned int index;
>  
>  		if (size > KMALLOC_MAX_CACHE_SIZE)
>  			return kmalloc_large(size, flags);
>  
>  		index = kmalloc_index(size);
> -
> -		if (!index)
> -			return ZERO_SIZE_PTR;
> -
>  		return kmalloc_trace(
>  				kmalloc_caches[kmalloc_type(flags)][index],
>  				flags, size);
> @@ -591,17 +587,13 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  #ifndef CONFIG_SLOB
>  static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
>  {
> -	if (__builtin_constant_p(size)) {
> +	if (__builtin_constant_p(size) && size) {
>  		unsigned int index;
>  
>  		if (size > KMALLOC_MAX_CACHE_SIZE)
>  			return kmalloc_large_node(size, flags, node);
>  
>  		index = kmalloc_index(size);
> -
> -		if (!index)
> -			return ZERO_SIZE_PTR;
> -
>  		return kmalloc_node_trace(
>  				kmalloc_caches[kmalloc_type(flags)][index],
>  				flags, node, size);
> -- 
> 2.34.1

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
