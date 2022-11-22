Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4281F63326B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiKVBxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiKVBxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:53:04 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E12A14089
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:53:04 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 6so12794974pgm.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ef/dYlQV746zV7HsmZzIsfpA9DBWh47fHQKVjHWsG88=;
        b=V6nNGPcFRhv76hz2oLZ/b6dKT4Xqgd4inWcYruCRq3jx5s2Q/qdoUPWg4Z3DMoqEP0
         i2/lXnAb1xVNy1Nv2WPPVqzHUNlWWj2RymrXHzL5TBvkz92yBFZAS6ryH7HDMOgBLQDD
         5HvnRK8rznhlMEmONhLUbPz5bpTONhZVe1JRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ef/dYlQV746zV7HsmZzIsfpA9DBWh47fHQKVjHWsG88=;
        b=QaRdm5dM9zX+nhTHXOmU+ih1mE3E6sxs8wC0AgfqmNyoh+K4YunF5K4Bit3O+uS7F1
         lHM27SNz4vhAFE0IH49vgpv3ud4aqQ0lOrzC8rP/56U3TyB/zsGnjaCAwqFJ/VmOMFsh
         aZYFjF71ig/V4HliOy/AiPXtRgWkyuE/59Ss1T0KrwRaWwZx2/UWOKYfFjlUdlWxYtM/
         my825YMHOzuuh7Y/yCRfxFbSYLB6DvWfSV5/ZW4xfi+NRRWnlXeZ+ECAri7vBWsFvI6s
         q9PkBOzlwmAqybJACgzmsmyT8aawAXJTR6a9piGaGMtC98XUw9ALLSbvWB802hpqUDAE
         V9IA==
X-Gm-Message-State: ANoB5pkfLB1oQJaZPeXII+lBXXaf3/vOpC26cHAnHumSMBl8IRj1k4Oj
        eO9V5KWUN6PcAkiGL6WNkDgjUU70TQ0zCA==
X-Google-Smtp-Source: AA0mqf5GK8otzLcc9t67L1TQtul/q99BZTHqxni4KNOyckphWFo+Ssx3RHdXJ/yWR5TT6Ni6gKblbg==
X-Received: by 2002:a65:6d95:0:b0:46f:f482:6920 with SMTP id bc21-20020a656d95000000b0046ff4826920mr1372675pgb.327.1669081983563;
        Mon, 21 Nov 2022 17:53:03 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id z29-20020aa7991d000000b0056da63c8515sm9620767pff.91.2022.11.21.17.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:53:03 -0800 (PST)
Date:   Tue, 22 Nov 2022 10:52:58 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3wreqR1IRWFtSUz@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-5-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119001536.2086599-5-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/18 16:15), Nhat Pham wrote:
[..]
> @@ -1249,6 +1267,15 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
>  	obj_to_location(obj, &page, &obj_idx);
>  	zspage = get_zspage(page);
> 
> +#ifdef CONFIG_ZPOOL
> +	/* Move the zspage to front of pool's LRU */
> +	if (mm == ZS_MM_WO) {
> +		if (!list_empty(&zspage->lru))
> +			list_del(&zspage->lru);
> +		list_add(&zspage->lru, &pool->lru);
> +	}
> +#endif

Do we consider pages that were mapped for MM_RO/MM_RW as cold?
I wonder why, we use them, so technically they are not exactly
"least recently used".
