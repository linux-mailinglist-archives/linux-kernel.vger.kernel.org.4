Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44488689B96
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjBCO11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjBCO1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:27:25 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487476EAC7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:27:16 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id pj3so5185191pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 06:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEgiwTWMCSb815VHLQtY9D/HoJH3frsmJPGVuEacYKI=;
        b=lSbSTWn845JsNyAe6dUAVZv7lZaQUih3CW2g44N1jFn8xmwjq0eCfXTKuQM5kfTuMo
         fSvaC+V57+wWkW5LiG4tXJi7oPQXvIWmOxFx7b0haU+VrNpvbJW1m71cU6i4TVQJixTK
         RvVTE9j8youlX/CS5GmeTOH26EcaA71B5thpd7ROdz4Yw8qlqbto6XiyU4pwCxKtmPxV
         6/zE3I8ric6Mg21bh54mIUzhksLH3xUkYb997Id1U48cjBSekIHZERq3W1SrYXTkt90+
         Gh+0OeVCvNxbtnnqZuCeL2+N/NzNQZkSAa7zDUQ3pTs95edsgd9jXuIyTXOvkRuUD44J
         QgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEgiwTWMCSb815VHLQtY9D/HoJH3frsmJPGVuEacYKI=;
        b=tlHnXNTa8Pv5141mbL/YWJWCajmFDLV2BUkb7itiU3WkbhbdlE0HEU2zBny3ifL9/2
         JtgbRQKShZ86goxQ9BZZ8lnezAf2qF5tMdEzumboPwfrrThWsB3aOtzvjMBFX+dDDzHk
         kGkChPYoEnS9OAeY3Ig/GN76W0S9EMqQgX7gqsfeoB5IWkRV7k8KYX3BcEEtwZDDafDC
         Q+lTQA0rLB95Bx4SVCRNQ2SEWHTsLCFhmWRaTps/aIYQ1TZKK65WWma+k+fJx9Po/T9z
         fK3hPGr2g/1cxFEMPPus34zRtG0KremZmgcJGkLMyZ00l1iIMg2E5HLJf3q3CcxHNJpq
         1KVw==
X-Gm-Message-State: AO0yUKUFpS2/mF3pGt9X7SLkfoH6ASOIQPV4GQbkmy9NAwruUZDtml3W
        aoxCoDbaWAF4SciKTt/kZB0=
X-Google-Smtp-Source: AK7set/2Op1qymn+qULtmrslzvEyZLmBIKcEfD+qr/qxx/9Ff8oJr0hb2Cl+ooPh9/H1bfrj2iEuUA==
X-Received: by 2002:a17:902:ca8d:b0:198:ec2c:d4d9 with SMTP id v13-20020a170902ca8d00b00198ec2cd4d9mr1088pld.53.1675434435671;
        Fri, 03 Feb 2023 06:27:15 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id jj15-20020a170903048f00b0019300c89011sm1674474plb.63.2023.02.03.06.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 06:27:14 -0800 (PST)
Date:   Fri, 3 Feb 2023 14:27:09 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: fix memory leak with using debugfs_lookup()
Message-ID: <Y90ZvSSkhAiDpmeB@localhost>
References: <20230202142022.2300096-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202142022.2300096-1-gregkh@linuxfoundation.org>
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

On Thu, Feb 02, 2023 at 03:20:22PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at once.
> 
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 13459c69095a..4880e461fcc5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6449,7 +6449,7 @@ static void debugfs_slab_add(struct kmem_cache *s)
>  
>  void debugfs_slab_release(struct kmem_cache *s)
>  {
> -	debugfs_remove_recursive(debugfs_lookup(s->name, slab_debugfs_root));
> +	debugfs_lookup_and_remove(s->name, slab_debugfs_root);
>  }

Looks good to me.
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thank you for fixing this.

>  static int __init slab_debugfs_init(void)
> -- 
> 2.39.1
> 
