Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538E8621DF0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKHUqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiKHUqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:46:24 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FC863E2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:45:34 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z26so14850075pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf4o9zxCY+aatZ9i/w+Q/fA0WrF6Pms+E0XF0raYJnQ=;
        b=kwa5wqAuXI7r4kmm3zy4Sit+Dry36rKlqqRWxPsgpL0ehbgq22ZI1m50P/f3A2YVoJ
         MoNbdSnjRVaoMdBdCMqx+fPs6dGrwqjW3gaMGVXLYeZU3NlReBSGvOKOL+ej5p6c1zyB
         S87AZNkIsIChvsGCs0qjiEthFfxrVg3QTyuwb68BUcg/D8UjXdPRw2Nx9lIPrakfJHSg
         o8xi6y0U1dL5KodqbWzr++WJH41GZt+7sbef1YiWLdTA99Xu3yu1iORH14Yjamx3VpHX
         TKdg5ql1BJb6U5W8t7xqWE5A8F9DVRBHHYV87emmLKH+jyAYG4alCcXA+wWb11rTh+tt
         BApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kf4o9zxCY+aatZ9i/w+Q/fA0WrF6Pms+E0XF0raYJnQ=;
        b=BryN3lRIQl4iWUXe3tNLLByJa1pR6FL63ElW1HYtvs0gOMcWSb8SR7ztB84lIxOcdt
         Wk9FBAlPo8bFe1cVq19xjFfv+6asOCcsm6rYY/Ur0lqV9Ldd+RIqCBn7SNixB+OCpF4B
         KZ28u9oJoyN/7Abfl8mvUzp8ojTHFaOcDX4Z0A/or5mACR6PfvgQVhPMJNI3CAWFRxlY
         xLxsQoJFc4j0OYuEBwXM/rmc3ElLWLm5zGYLWNjhs1lnxvR7N/8mh13rRiPo8aVcD0Sw
         cWIBypf1Pw/xXxnh6+4uISPcC3MSXDVGe7wQf9wq0bNX31iaBmf8OrwevF0fTWUrWsMW
         MBlw==
X-Gm-Message-State: ACrzQf1CrValN5zFDH/iOCre1YKl1CKUVbcVgYBGXzWfjFMrmC4xz5GH
        JjOhNwS1qKcJ7CncjO06ip3Rxg==
X-Google-Smtp-Source: AMsMyM536eaa/9LUK9TsuzG48tmZIFZA+jXjgHBiwm6BYF3iJUyON+3fQvrkQT0Vu0CCwUp2nAv/tw==
X-Received: by 2002:a65:6cc7:0:b0:42a:4d40:8dc1 with SMTP id g7-20020a656cc7000000b0042a4d408dc1mr49447265pgw.321.1667940333883;
        Tue, 08 Nov 2022 12:45:33 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:45ff])
        by smtp.gmail.com with ESMTPSA id d67-20020a621d46000000b00562a237179esm6783830pfd.131.2022.11.08.12.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:45:33 -0800 (PST)
Date:   Tue, 8 Nov 2022 15:45:35 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v3 0/5] Implement writeback for zsmalloc
Message-ID: <Y2q/723tli9PQUBV@cmpxchg.org>
References: <20221108193207.3297327-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108193207.3297327-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 11:32:02AM -0800, Nhat Pham wrote:
> Changelog:
> v3:
>   * Set pool->ops = NULL when pool->zpool_ops is null (patch 4).
>   * Stop holding pool's lock when calling lock_zspage() (patch 5).
>     (suggested by Sergey Senozhatsky)
>   * Stop holding pool's lock when checking pool->ops and retries.
>     (patch 5) (suggested by Sergey Senozhatsky)
>   * Fix formatting issues (.shrink, extra spaces in casting removed).
>     (patch 5) (suggested by Sergey Senozhatsky)
> 
> v2:
>   * Add missing CONFIG_ZPOOL ifdefs (patch 5)
>     (detected by kernel test robot).
> 
> Unlike other zswap's allocators such as zbud or z3fold, zsmalloc
> currently lacks the writeback mechanism. This means that when the zswap
> pool is full, it will simply reject further allocations, and the pages
> will be written directly to swap.
> 
> This series of patches implements writeback for zsmalloc. When the zswap
> pool becomes full, zsmalloc will attempt to evict all the compressed
> objects in the least-recently used zspages.
> 
> There are 5 patches in this series:

For the series:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
