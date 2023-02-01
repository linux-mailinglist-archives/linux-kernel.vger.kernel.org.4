Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B7A685C8D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjBABQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBABQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:16:11 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A8F4743E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:16:10 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q9so11365971pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2wnrYUzee19FSJlLCQb56qXFqePNff3HtjyVB4nLqz8=;
        b=V116rHBjqqaEqJgSC6ebGrH1ErdpkZTppM1AS4ZYyYvj2KI5XwmhCVnQ14ikX2Z9ir
         ARmWzFuLN0y6vuwM6nPJiQ8rteZBowECPeYyCoNNiUZvbldcqMos7POL12gw9FvlxIBS
         84m/oAW0lL4OxvnkngKjSFTEXs2eZNA5CaTaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wnrYUzee19FSJlLCQb56qXFqePNff3HtjyVB4nLqz8=;
        b=msCLbN7gqMupBANl0oPEwIUx+zFgd5euyL+mIL1dwW3h5pDMP3Fp7UP17lCCrt4Bun
         gNyVQ7OtnKX74pmxM5wzQaWXJSIuT7bfe88WPttCaPDD61oG+9DK4YL+SFJf4frHtB1X
         20ErdI5gfnXvSi+iIAFF0vwcc6GVcvVygl69+OOXAlRScslAR9E1mEOfxoO++w5lPaY7
         8Ai70vjmFi1vLLpbwIBbEx7lzYXRrs0XtNZFUWCh9Y+tZa4Eq1b3kXo3xkQv7FMwMy6g
         Zd4hkh4aEY63nRTkG6MwyYWDx9M8X/1R9vT8+DirEqbal3lNqHO3QcV38TKRil8DqsYV
         QEAA==
X-Gm-Message-State: AO0yUKUtqAI8GCMcrYVLjFxOZKah2lFZs6r+cysG9UpNJlG0wV7fkCFN
        GlSlpgbPZbwIOdVP/fYcEQHusw==
X-Google-Smtp-Source: AK7set8dfks2z1Q5YFWDvWwLI4WY12awPuiNWnsxvHA17MweK66ldjVjNfW8b3MfDQjzbWtlMVMXIg==
X-Received: by 2002:a05:6a00:2911:b0:58b:c1a1:4006 with SMTP id cg17-20020a056a00291100b0058bc1a14006mr350156pfb.18.1675214170063;
        Tue, 31 Jan 2023 17:16:10 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id w79-20020a627b52000000b0058193135f6bsm10042297pfc.84.2023.01.31.17.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 17:16:09 -0800 (PST)
Date:   Wed, 1 Feb 2023 10:16:04 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zsmalloc: fix a race with deferred_handles storing
Message-ID: <Y9m9VKzkBn41YLQI@google.com>
References: <20230110231701.326724-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110231701.326724-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/10 15:17), Nhat Pham wrote:
> +#ifdef CONFIG_ZPOOL
> +/*
> + * The second least-significant bit in the object's header identifies if the
> + * value stored at the header is a deferred handle from the last reclaim
> + * attempt.
> + *
> + * As noted above, this is valid because we have room for two bits.
> + */
> +#define OBJ_DEFERRED_HANDLE_TAG	2
> +#define OBJ_TAG_BITS	2
> +#define OBJ_TAG_MASK	(OBJ_ALLOCATED_TAG | OBJ_DEFERRED_HANDLE_TAG)
> +#else
> +#define OBJ_TAG_BITS	1
> +#define OBJ_TAG_MASK	OBJ_ALLOCATED_TAG
> +#endif /* CONFIG_ZPOOL */
> +
>  #define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
>  #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
>  
> @@ -222,6 +238,12 @@ struct link_free {
>  		 * Handle of allocated object.
>  		 */
>  		unsigned long handle;
> +#ifdef CONFIG_ZPOOL
> +		/*
> +		 * Deferred handle of a reclaimed object.
> +		 */
> +		unsigned long deferred_handle;
> +#endif

A nit:
Do we really need to have that #ifdef and add a member to anon uion?
I see that we use ->deferred_handle only in one place, so I'm not sure
if it makes code any simpler.
