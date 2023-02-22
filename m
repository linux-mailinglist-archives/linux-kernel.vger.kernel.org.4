Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83A769F36C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjBVLZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjBVLZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:25:23 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B743346E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:25:22 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso8416961pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hO7PfBRfir+KLtGVIIsYXsFaRSKKrOVmPKpnJ6eH2zA=;
        b=OhuRhu8xoNNQgB+WaFOdA5zJcIxSZ+Iom4AX4wjkvNc+903l3GFDs/VI2vEVABEbXH
         soqezrWLEvgU/PAD0+DMOfaViE7KiNmn9k7WDl2a29Y/f7M8LQRJjk6R7efPZc5GQ71e
         ecIKGah9g35O0TmKzUKqZTpwYoY2V7SJF4aV4IP2Gov3QF2/jmdXLxO6JMCBlFrg9Jl+
         4p1NiQuUQAgYb4f5rG9bTLhnNouHSfZ7C3czL4UOyyF9jFZKucor01o+G9EXLLzXk2Hl
         oTwvLu0JJL90PeqH+tEF/uEdvrVNPccdgGNdpUgW+9KOiOep+0xfMtFXSVQNNsFEnNY4
         qXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hO7PfBRfir+KLtGVIIsYXsFaRSKKrOVmPKpnJ6eH2zA=;
        b=aHKe66XexqdkWq3gSX6pH9YBCELJTgXRDEhN7K0cDH0eGdqNNttn/Bah0w1WL2hmbq
         6qMDkD1LAKTyf5buLxtsnkA7IiETXV1T/RIUhLoqZau9Vl8SnSwq225O91OjjC7k+/Dn
         n/yzykc9Nw9K8ro4DG017Fx6vWz/LsRdzF8YpXklW5NsPuGuh36dthz4msMroR37IhDP
         DSu1AjMHm4jwTkfwjPxjAH/D3JZT+nlVuAT99wtEHywz1cM9CAOH5JBZbMTRBp8xLlKg
         PGkHCtMqCIuaVJSMdxbJDiOTa8D7Z6lk3IexTyKLKr9u+x+VSENiMtf98/tpqefn2zdI
         dw3g==
X-Gm-Message-State: AO0yUKWW3NqfyCdAjZMd/OdSrUag+a4NKHpNtFncbLbQj1xIe8wKpOYP
        rM34gu3lZL+f1zMAJy4jf3Od1Y20lFs=
X-Google-Smtp-Source: AK7set+zhBNyBRgU2wVAGKr0Mpvlz66l+wzqzKarV7qvYBWiudhZ/AYgXgddmX8Xt+M70kTrHrM50A==
X-Received: by 2002:a17:902:c404:b0:199:3524:ee93 with SMTP id k4-20020a170902c40400b001993524ee93mr11048176plk.53.1677065122368;
        Wed, 22 Feb 2023 03:25:22 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b0019aa8149cc9sm5681613plh.35.2023.02.22.03.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 03:25:21 -0800 (PST)
Date:   Wed, 22 Feb 2023 11:25:16 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: slub: make kobj_type structure constant
Message-ID: <Y/X7nOeoORvNlclN@localhost>
References: <20230220-kobj_type-mm-slub-v1-1-5ae49b96d9aa@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230220-kobj_type-mm-slub-v1-1-5ae49b96d9aa@weissschuh.net>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:25:28PM +0000, Thomas Weiﬂschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 13459c69095a..be710dc4dc3e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6058,7 +6058,7 @@ static const struct sysfs_ops slab_sysfs_ops = {
>  	.store = slab_attr_store,
>  };
>  
> -static struct kobj_type slab_ktype = {
> +static const struct kobj_type slab_ktype = {
>  	.sysfs_ops = &slab_sysfs_ops,
>  	.release = kmem_cache_release,
>  };
> 
> ---

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> base-commit: 5b0ed5964928b0aaf0d644c17c886c7f5ea4bb3f
> change-id: 20230220-kobj_type-mm-slub-02d25836de84
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 
