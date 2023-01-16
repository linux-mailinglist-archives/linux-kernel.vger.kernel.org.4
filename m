Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC3E66BDC7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjAPMYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjAPMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:24:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4321C320
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:24:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t5so22903383wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKTyGhr5JmgZRBNZqt+rjhrZa6A3qTkj64hOZc3GxsU=;
        b=kuxSNSdGkO43VAT6j74zd5xdCxE/3m5V8FnfXho8FbeGfpyJqCySa+wep5gvpKmXxw
         yciHP4/gGI59CtxOtQMdahsyXutvSH2jlMoi24mKyJgZ9IcSSxXhRDOlOE7zUiFL1v9J
         J0BWACi3higPxeMUI4B2jmhTqWlDcClJgyqrAkFvAoioPLxp3EZyq0Su2u34eE8nE00g
         e0SrgJKZkpv0KohDepUd93Iy4aqYTo/o8rglA/I9JPBGqHs2ClZD8RxUejkAeaws+NKl
         i+TFaDm2Fs76MQOKHt3n2Tngwr6CK8Io6AjnK5rc7joJAddmceJWKAzsUrsyOnRjS/7+
         8kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKTyGhr5JmgZRBNZqt+rjhrZa6A3qTkj64hOZc3GxsU=;
        b=rBZlJIRsPyDGJnXl7sgfhha5g+q7hz3A2Q9z5XepB0EKfRDkJNsmh2agKJECXPYH2w
         TQ+njcbMV1ZsoMEh33vTqcjmbFZeHTsImkeXqF1kLFs75MaXZbgsSavruq3yMuoB+a08
         srU6KTWvWQJVZIXCZitDtKr/QxZAJXS3doZr3+MRcNepE6Mssu1y4f/0AwY+MWfr5j6n
         6QD18AP/3B+cwdeydFuZqVpqX0N0i7gWvK69OndufoBJ0uiYQfBMGXXv1xyZDyHnXdHu
         6Vj6Fwx/rtR7UTfr8zyBlqlidP4jTKH6LcI77YIuJQB/Cp1GmEudfU8NEPzIc143/wQK
         18+w==
X-Gm-Message-State: AFqh2kqENgShERj77FEu8Llkzk7USb9OWvjHBWbfMC771mHsqgjTwPKc
        WWTT7jo1BcNLvTIa41KAGK0=
X-Google-Smtp-Source: AMrXdXskP1vIMY285an4+fdT7dLABggFQWKCJhFefwTSU9xEEDdBHDYe8jNn4wnnFF1qMiurwwspyQ==
X-Received: by 2002:adf:f70b:0:b0:2be:34f:4fc4 with SMTP id r11-20020adff70b000000b002be034f4fc4mr3470601wrp.13.1673871885840;
        Mon, 16 Jan 2023 04:24:45 -0800 (PST)
Received: from localhost (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b0024274a5db0asm26335772wrj.2.2023.01.16.04.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:24:45 -0800 (PST)
Date:   Mon, 16 Jan 2023 12:24:44 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 5/7] mm/vmalloc: skip the uninitilized vmalloc areas
Message-ID: <Y8VCDD+UVjryP49u@lucifer>
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

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
