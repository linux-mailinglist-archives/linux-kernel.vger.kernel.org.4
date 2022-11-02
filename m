Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F89615B4C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 05:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKBEKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 00:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBEKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:10:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74A522B1B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 21:10:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u6so15415797plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 21:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMJn7jimJNcA0G1Sq5Hqirc0aLfOad24t/l8klU9DOY=;
        b=TvlCXQ8NjdJp1yLfUtUk2P/Qs8V2AtrOrI2xgiu3Ccl70bvVqtB1OiixpaYrdGLg0b
         F1CM+HwzOpl4kdctIFecwM/pulSZLLzbns9c9n53I4HtSSSASGT5k3r8MResxKdwvEth
         RN1WckQyiTKybASLNAzoTuNYjiaXkY6lw8UB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMJn7jimJNcA0G1Sq5Hqirc0aLfOad24t/l8klU9DOY=;
        b=7Di+3qCVe4Lemm+toe4yRU2NsvVcXIJG4wqqBUGq9TfjWFKA+atMECu/PQzcFfezIH
         Yhn2TiHZ3WpsRnt8ZUF0SHKCkXAyT9I0Hm0OwmMfrltD8Az85VpLlABM3fsrrH1kG/0c
         rOEIbIFBtnKZt8xsh+Mph4tKJVoe06GrNELUcOPzZhEvTY5YkyQjzzQA8ou9QjgexyD8
         OgTFUi2QH3Zq4ao/dxETiAjmLoO3xlykz0oCobsscwYHtLLT3WvLOkquHJN/H2qloE5s
         ceveiU2uzE9oEEdscoBn9rrKZKVDBy0AxQ+F39t31euzsldGBECquqatwRhl++jHlMMt
         1I6g==
X-Gm-Message-State: ACrzQf0CjOieAvbY1iA6TMWQxe2/nT0rSfkz89w0Uqihqa5fcj3AmfNU
        ZYhRol92LkUD+ar2zPldG0nei88WHH4e1g==
X-Google-Smtp-Source: AMsMyM5wKzcOggf4qugrRG89F4qvas5Pi2MV67GcuUOuz1fGu56ehuRTQ6Ld+rIcRABfBKeuftEePg==
X-Received: by 2002:a17:902:d4ce:b0:187:17bd:44d7 with SMTP id o14-20020a170902d4ce00b0018717bd44d7mr16559179plg.84.1667362206240;
        Tue, 01 Nov 2022 21:10:06 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f558:dfb0:7cb7:44d9])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm7119248plb.26.2022.11.01.21.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 21:10:05 -0700 (PDT)
Date:   Wed, 2 Nov 2022 13:10:01 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH 4/5] zsmalloc: Add ops fields to zs_pool to store evict
 handlers
Message-ID: <Y2Htmak6+7b+6pBv@google.com>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
 <20221026200613.1031261-5-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026200613.1031261-5-nphamcs@gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/26 13:06), Nhat Pham wrote:
> +struct zs_pool;
> +
> +struct zs_ops {
> +	int (*evict)(struct zs_pool *pool, unsigned long handle);
> +};
> +
>  struct zs_pool {
>  	const char *name;
>  
> @@ -242,6 +248,12 @@ struct zs_pool {
>  	/* List tracking the zspages in LRU order by most recently added object */
>  	struct list_head lru;
>  
> +#ifdef CONFIG_ZPOOL
> +	const struct zs_ops *ops;
> +	struct zpool *zpool;
> +	const struct zpool_ops *zpool_ops;
> +#endif

I really don't think I follow this zpoll_ops and zs_ops things.
Why do we have zs_ops?
