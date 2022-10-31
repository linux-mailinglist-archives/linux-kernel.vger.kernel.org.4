Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE898613431
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJaLK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaLK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:10:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD87B847;
        Mon, 31 Oct 2022 04:10:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id b62so22288pgc.0;
        Mon, 31 Oct 2022 04:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mWOQo3IJMa6w4l4DyN4HDxOpIlWrRJ/XZKR3C/nOGs=;
        b=lSn9Onz4PxN1cJWKkcid5fopQHGtPF7Xutp9xqdwSl58r0Hv/ReabwAK0DyQMaEvxP
         9HbIo4HSlNM5p5zVgStKBUt1r6a9Hzni0hHIACHf4JczMhHixIFn/SeseOTMpR0u+iKs
         K6yqUKlsmfa5jGVGnymLJ5GcuYpl1KJ9zOvAp+0JxctY7t47W5tkX/i6XFrjS8THCxzK
         Ql/6Cqtj99XDesgAhgvb6/vShowJ16njwUndk8kwFxGrUmQRn513lmAmK+ir//078wLy
         hhDSPx08amePjr0bzM50X5Nk+5AuSyOI60N76pnIpHyas+RwY3tS8vVFZByZBNmND6YM
         LtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mWOQo3IJMa6w4l4DyN4HDxOpIlWrRJ/XZKR3C/nOGs=;
        b=xIUjZGOcGP7HF0Zu9aJnFOyWy3m3e90VtXhlJzr79YKWuqlchsqBwcYo3zroiOvN1i
         KzpzA98PqEqCNl43cxNoLR7Pt811d9BR+3OmHneqDih2D0O/hKQB0RKISP7fjIlaWKp6
         oH3YWaeyA2Uu4mspig+nAkF0cy5zGaIU+PGdwDSq4LvPhXpL7P4C8cYahBgoESyysoJj
         GjJl4RiBWo3ZTj5oYHoYuV5JnyeHUkRGgymB9rqWpWSu3NgUJbhBfg1SCHosF7lFCT7x
         +5DFOfQ0SfEU9d6zAKduGY0TWK7LgwoEEE1jUb9LMjwi2dmM/gAV2Lpi3x6YbndtyHct
         YbyQ==
X-Gm-Message-State: ACrzQf2lcXWJvVFO6VYXnumd+JoCsiP3PRqQD7DKw3MMSzoFv5XxtCbH
        C9VcCbBjaaxNbLbIIYq2qQE0tqwnhoY=
X-Google-Smtp-Source: AMsMyM4qv86X/fOjd4pkWRvVfl5ojF09gKgeEQU8i3SCMhXgN7pSWnN+bFX5KJHGkGtnMwdtk+pPWw==
X-Received: by 2002:a05:6a00:2446:b0:528:5f22:5b6f with SMTP id d6-20020a056a00244600b005285f225b6fmr13893404pfj.73.1667214655397;
        Mon, 31 Oct 2022 04:10:55 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e5d000b001767f6f04efsm4234538plf.242.2022.10.31.04.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 04:10:54 -0700 (PDT)
Date:   Mon, 31 Oct 2022 20:10:48 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab_common: repair kernel-doc for __ksize()
Message-ID: <Y1+tOByatY9w8MKc@hyeyoo>
References: <20221031092920.976-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031092920.976-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:29:20AM +0100, Lukas Bulwahn wrote:
> Commit 445d41d7a7c1 ("Merge branch 'slab/for-6.1/kmalloc_size_roundup' into
> slab/for-next") resolved a conflict of two concurrent changes to __ksize().
> 
> However, it did not adjust the kernel-doc comment of __ksize(), while the
> name of the argument to __ksize() was renamed.
> 
> Hence, ./scripts/ kernel-doc -none mm/slab_common.c warns about it.
> 
> Adjust the kernel-doc comment for __ksize() for make W=1 happiness.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  mm/slab_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 33b1886b06eb..74a991fd9d31 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1010,7 +1010,7 @@ EXPORT_SYMBOL(kfree);
>  
>  /**
>   * __ksize -- Report full size of underlying allocation
> - * @objp: pointer to the object
> + * @object: pointer to the object
>   *
>   * This should only be used internally to query the true size of allocations.
>   * It is not meant to be a way to discover the usable size of an allocation
> @@ -1018,7 +1018,7 @@ EXPORT_SYMBOL(kfree);
>   * the originally requested allocation size may trigger KASAN, UBSAN_BOUNDS,
>   * and/or FORTIFY_SOURCE.
>   *
> - * Return: size of the actual memory used by @objp in bytes
> + * Return: size of the actual memory used by @object in bytes
>   */
>  size_t __ksize(const void *object)
>  {
> -- 
> 2.17.1

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

-- 
Thanks,
Hyeonggon
