Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF13063324C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiKVBoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiKVBoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:44:04 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE40C6068
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:44:04 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q1so12764164pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJbRPk6em82xpoccntmsblKFY8v2T94xxvkFkQhcZEs=;
        b=O8Mq/nJzHTkSiTNcqCAE7zet+qYcGjd5GfVz8p46cpg03BFaLbll7Zn8ndMJRWCciU
         vmNTs07H5Uw6thSVA1Gdk1Q0qKvePGPC7DO49xFKtGIVIk6PA/Fm3KWF2danUv4BsRgq
         GDQJWPVNQtcLs7g9bc17T3kJYG5lEJLY9YZvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJbRPk6em82xpoccntmsblKFY8v2T94xxvkFkQhcZEs=;
        b=mVpzA+RAayqeBYOplcrdrtGe+OWbqZYk0Y+OG0UN5Fnun2FvHqhJBbx41sEC+pbTXi
         tYCQSb6ZQMARryJfYsZv7YbhsSNuZv28qXFj/Xz/LrU/R45SwHWeVYiSJ8QIKsXgbK09
         5v1tqJkQJ17I3sib+CAlQ4r7MGsdARHNqdLNEZ0Vrgetyh044kY5VvShBv99F8F6auRJ
         RauXzSp3VmzlMH6gQufGylrxnW4928D6+u4+qKJKlF7wYC2iQYh59CvkKrK0Yw+w8LEt
         1DZJnzX6unZJlJAxfBSNnu5oXsHoNbrSSC1xZ6O0vMK5LmHa1o1V1vcZSZUGX6GebZ7N
         vb7w==
X-Gm-Message-State: ANoB5pmvp6D1D3tly013a1HPXAoPE949qIowhZbS9Z/4zZUm5gInbzDX
        +4sKLtpF8YRkwLYs5j1vx9C3VC2IJbd5UQ==
X-Google-Smtp-Source: AA0mqf6YrmZSCLzPEKBpexm0WvkR5s8YCvxWTWz2gToQR9TO81EVkxcQin1l0xlBSgvl/gaRJmXZOQ==
X-Received: by 2002:a63:1466:0:b0:476:cac7:16ad with SMTP id 38-20020a631466000000b00476cac716admr3423961pgu.128.1669081443573;
        Mon, 21 Nov 2022 17:44:03 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b00188a23098aasm10632174plh.69.2022.11.21.17.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:44:03 -0800 (PST)
Date:   Tue, 22 Nov 2022 10:43:58 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 1/6] zswap: fix writeback lock ordering for zsmalloc
Message-ID: <Y3wpXpn0AAw8Xl1s@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-2-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119001536.2086599-2-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/18 16:15), Nhat Pham wrote:
> @@ -958,7 +958,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
>  	};
> 
>  	if (!zpool_can_sleep_mapped(pool)) {
> -		tmp = kmalloc(PAGE_SIZE, GFP_ATOMIC);
> +		tmp = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  		if (!tmp)
>  			return -ENOMEM;
>  	}

I guess this chunk is not realted to zsmalloc lock oredering fix.
Should it be a separate patch? And feel free to squash my patch,
that does the similar thing:

https://lore.kernel.org/all/20221122013338.3696079-1-senozhatsky@chromium.org/
