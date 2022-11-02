Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F240615AF0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiKBDoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiKBDoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:44:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3430C26D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:44:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id io19so15387020plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 20:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuDhCs/uN/Jh8YtacbftAAQuLE1EzgHWJYodom4FpBg=;
        b=L832lV6gy8GwQ7EizdFm30fABkOF6M7+bcGz9Dtad7YavJluIno2A1T1cUcQh1Lv43
         r3VTQaXWTxQ9CY9Md+pBFUy1QuewIbwW7BsdsCauHwOkp1SfNA6hGvFnjMCuzseIlaF6
         HAdo1IPrYARu4v7Vn/8IPlP6aNX8uhMPuWqQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuDhCs/uN/Jh8YtacbftAAQuLE1EzgHWJYodom4FpBg=;
        b=mwHUWMnzJLNwCmnFDnyRntmf5vPF+KZXvBq1K9F7kscBlkRu76+Z8f0tmCPoVuiu8r
         VMjqnlgI9wpmVFUenARw8QIMF5sVulPjnKyDaTpGBYoAKb4NFANFd06pkWTXgnRWWD2I
         t2XLJkWplHfT++LFdWDvyp14jzRHrSz4kvoKiZqd5wNbw4eKzMmYTL5UNikoEyojOOJY
         c9hoIKKXfxfWChuuL2asCMNiH/0NQjMH/n+t5XrFVM9+mZ9gJinmZtgpYHdsSScoRCcq
         5M2MwPioQBhJwhQTyFN3FtevzV3Q2kxnDNrStADxmbfgVeo7L2poP8v4h+eTpf7kAwai
         Zhtg==
X-Gm-Message-State: ACrzQf3lc80CfGxnJ5kVEozMNH23bpJ0pEKr/V3lFYD/3Ba6Geq7OEuq
        yYqSBVsMEQ7qd1AvgGAqRS02+B3tOkLNFQ==
X-Google-Smtp-Source: AMsMyM6P0xtQ3chlVxS/o5oJDRkd2Vw7NeSDqVzZj/NsDFNGuR8Ipp3Q5hJSGUIQkbeEejPA4OO6Wg==
X-Received: by 2002:a17:90b:2248:b0:210:10dc:a314 with SMTP id hk8-20020a17090b224800b0021010dca314mr39574351pjb.15.1667360654765;
        Tue, 01 Nov 2022 20:44:14 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f558:dfb0:7cb7:44d9])
        by smtp.gmail.com with ESMTPSA id d81-20020a621d54000000b0056bc5ad4862sm7239890pfd.28.2022.11.01.20.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 20:44:14 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:44:09 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v2 5/5] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y2HniaEe1QjzSzCh@google.com>
References: <202210272158.7swYwd23-lkp@intel.com>
 <20221027182736.513530-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027182736.513530-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/27 11:27), Nhat Pham wrote:
[..]
> @@ -482,6 +504,7 @@ static struct zpool_driver zs_zpool_driver = {
>  	.malloc_support_movable = true,
>  	.malloc =		  zs_zpool_malloc,
>  	.free =			  zs_zpool_free,
> +	.shrink =     zs_zpool_shrink,

This should use tabs, just like the rest of fields.

>  	.map =			  zs_zpool_map,
>  	.unmap =		  zs_zpool_unmap,
>  	.total_size =		  zs_zpool_total_size,
> @@ -955,6 +978,21 @@ static int trylock_zspage(struct zspage *zspage)
>  	return 0;
>  }
> 
> +/*
> + * Free all the deferred handles whose objects are freed in zs_free.
> + */
> +static void free_handles(struct zs_pool *pool, struct zspage *zspage)
> +{
> +	unsigned long handle = (unsigned long) zspage->deferred_handles;

A nit: we don't put a white space in cases like this.
IOW (unsigned long)zspage->.... here in everywhere else in this series.
