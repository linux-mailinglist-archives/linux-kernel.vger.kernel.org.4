Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6065BB4C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbjACHfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjACHfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:35:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F083DEC5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 23:35:35 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t15so19731463wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 23:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=olkDH2t4VBXvPJ9F7B1IDdQPQzTSq2Hh4INNuTPeN5E=;
        b=B9LailS7DOn04LvBk+Z6cnNw6YKoWpOJyfjAnQuyaz4724rUCP68vBMv47yxbgN0x9
         uwWqfnOhWPm4sPyY6LgnIyOhRadnYQWsJWnLlPcpTOA4aCi1sOmwIMFtfZ7gBQYl8ktS
         PwZHSAThncQmrsrLtnXvSDqbv6rrFV5VVFZwSDv0VwbvrNrpF8sJZ7KB6tAgkkTw2jcS
         mFQtOGIU/DP3ExpzVMVANgLVzfB4PYX7g/Y7TpnpxJ12xKOTR/6UkSZqM05hXT/9f4bN
         bpnpgt3gkHmJoZat8baIf1t2PSEVgw9M4gWkFouNPMeGiImP004tDVahH5t7vQWjQeH3
         lWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olkDH2t4VBXvPJ9F7B1IDdQPQzTSq2Hh4INNuTPeN5E=;
        b=rJMd3A9NmPtjt6ygrjkJnEzJ9r4og51oqw7ZTqOcF4RGVUPXcWB6QmvTTd1tuJ+WyE
         gp4dLBqx30DL0ocWNj5tT1kPf3Xq25EaKTPOAEQA7LV5mIqVsirVDpwEEuB6nI7QkxXr
         Diro/XxwcOe/gHp1z42fElN7VtSGnAVHeB0MjI0C6qTeXonpmHZZDBu3M9vPpHuEa6M2
         W1c2P+qAx8QP8NdteA13ztQMNkTMs93VReZoDbgwwRXHgMtmQRfPHZN0Jt8PdzUGlbkr
         RrXfjaUnJt0arBvHCXWMpFnfRAZpx936NYpkUsC7yJ9V53oPKlN56KYylaSxpCzHAkBd
         0pdg==
X-Gm-Message-State: AFqh2koXQj8mZEknWo7fE1NyKZX87u9lWe6xdOgFEKMT/DbvGHg7k0iI
        exKT1YNpxlMTvGpOIu7s5pI=
X-Google-Smtp-Source: AMrXdXuFc1E2j2e3nZY27VMCBHgDBhos9D1XGeor32FdaLtS+/7kCaB/3b23d2wYDAKJqdAy+Tay3w==
X-Received: by 2002:adf:dfc3:0:b0:294:c208:c921 with SMTP id q3-20020adfdfc3000000b00294c208c921mr5660944wrn.42.1672731333897;
        Mon, 02 Jan 2023 23:35:33 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id o15-20020adfe80f000000b0028965dc7c6bsm16217396wrm.73.2023.01.02.23.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 23:35:33 -0800 (PST)
Date:   Tue, 3 Jan 2023 07:35:32 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     riel@redhat.com, redkoi@virtuozzo.com, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
Subject: Re: [PATCH] page_alloc: avoid the negative free for meminfo available
Message-ID: <Y7PaxPV3Ln7AXVSc@lucifer>
References: <CGME20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e@epcas1p3.samsung.com>
 <20230103072807.19578-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103072807.19578-1-jaewon31.kim@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 04:28:07PM +0900, Jaewon Kim wrote:
> The totalreserve_pages could be higher than the free because of
> watermark high or watermark boost. Handle this situation and fix it to 0
> free size.
>
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 218b28ee49ed..e510ae83d5f3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5948,6 +5948,8 @@ long si_mem_available(void)
>  	 * without causing swapping or OOM.
>  	 */
>  	available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
> +	if (available < 0)
> +		available = 0;
>
>  	/*
>  	 * Not all the page cache can be freed, otherwise the system will
> --
> 2.17.1
>

We already reset to zero at the end of the function, wouldn't resetting to zero
here potentially skew the result?
