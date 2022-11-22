Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59CD6332D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiKVCP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiKVCP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:15:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFADE0CB0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:15:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id mv18so4372152pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHM45P9CjRvHsVijXk9ZVHXwEbtAPy50ILNl92/joDY=;
        b=jxYZOik4RLpujktsjOabVQGOR90STmbik2Sw3PmAzG7UrmIsIbshf5YKYMkRELIVPi
         Lf5zywjY+WSlWInhXMYMRaf/FEytVnWz8iWVRPykEmxnnXEA9JgDdROrp4gzcmSV3OqT
         jQWw8koyVaYSEvJUYMeKmxztQI0gHA5bWZP6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHM45P9CjRvHsVijXk9ZVHXwEbtAPy50ILNl92/joDY=;
        b=eAP5QBbM3QfUIMfWYEWvaZ54jPloIZsrM5uPIigiNdb/uS4wK91WgvlV0jUzM5gGfV
         ccLMOJ3tTBrHas8Tdb91GxzcGqQnjKDidnAjIs3LpDrrAHZkVbPoJE1caK7/2MRIRSGi
         ldFqrYCmyGpROpM08QNXrRQ9fAXcQnL/3/vE61gm+ww+8ko+9cS0qRL6CDa2q+ebnLgh
         PTeVaJSf2pxBiULKHGWf0PDIYezE9t6+UkpmEwMh1+YSvSSirDDiZ1sATCcH1e1Af6Rn
         lFEq74opyZSJy1QCoZG9XGbXyTRBKlJ/+CkuiRAbfQ1RSgtEFx/+beUDwCoXpCvilIT/
         HCjA==
X-Gm-Message-State: ANoB5pm1QrIxn3g06wUbdWhgE3yVlw18CZUrYq5LqdhhcFAlKfisfZ6x
        XjAAY5K/7V754fXp8aDjbbhJ4A==
X-Google-Smtp-Source: AA0mqf4p4DPJ6pgUFsOKYSOfHBjYEjyAnzdS6CSrXvbaB71OjqhgxtMGeyfws+s/bd/s6BKaQ7eKFA==
X-Received: by 2002:a17:90a:4ece:b0:218:7c55:47de with SMTP id v14-20020a17090a4ece00b002187c5547demr20774326pjl.172.1669083326192;
        Mon, 21 Nov 2022 18:15:26 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902f60100b00186ac4b21cfsm10475812plg.230.2022.11.21.18.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 18:15:25 -0800 (PST)
Date:   Tue, 22 Nov 2022 11:15:20 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3wwuMSy8YC86QAi@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-7-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119001536.2086599-7-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/18 16:15), Nhat Pham wrote:
> +
> +static int zs_zpool_shrink(void *pool, unsigned int pages,
> +			unsigned int *reclaimed)
> +{
> +	unsigned int total = 0;
> +	int ret = -EINVAL;
> +
> +	while (total < pages) {
> +		ret = zs_reclaim_page(pool, 8);
> +		if (ret < 0)
> +			break;
> +		total++;
> +	}
> +
> +	if (reclaimed)
> +		*reclaimed = total;
> +
> +	return ret;
> +}

A silly question: why do we need a retry loop in zs_reclaim_page()?
