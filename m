Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2AF70BC24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjEVLqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjEVLqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:46:02 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3CFA3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:45:55 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af2696fd1cso37539261fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684755954; x=1687347954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FV8sCT8BFyA8deJYHWz/IM3mCVuJ3I9ttJCLsYuNvvw=;
        b=ncnBE9tQNvkUvX0r4gvHMz688irtuvfbMmzx6VHQYyXOKJkl/kA7MdBVfLDbDJm+rI
         AtB4AsiOidEBoeLiVNHYW0U8mOKjJd48xn/+qCUThICZF0yr0Y/zvo7L/xZjmTNCrp+r
         9a3NmZ9sMUFgg3d4at/mqkLF+eieu6SU1AoNE/RWTYwVjWwok6L7KYceQ87dJTUlBUEw
         XvrzT317ubgjXX2hh7/+6vRlC+Frw79HoyCQ4Z2lK0bMjfytE5+U4N7CtnD96RhgOOJE
         0J0ZYjDR1w4PflsJ1voB+nOO7S3KPofeWVjt0vGGQYdzUUgkCVfAPlksO+tY0IrjZEnm
         KZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684755954; x=1687347954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FV8sCT8BFyA8deJYHWz/IM3mCVuJ3I9ttJCLsYuNvvw=;
        b=lCGYEWk3HTx8NLz4cNpd+tqjFb1Ik880jODXFOLFC5N1OYTh8ZoV7opYWVsbGLCra9
         DzRsbWFUnuleFH/lokqdp0AOKJxMQSpcDdggo+H9rage5SZ78+Z1WtQq4fssgcJJxkma
         jyIqrX01+MYXj40oBeVN6UBUwLjXvIrH9vJux7/HSbG5uRtFufr35ZawnYYMNhAs2+80
         Rd2d5SPagEB2d/HnXNxz9CVvCD6QVXSdqM/bZZqt8G0IdwRM+AbsCHcGqpXr+7XAA04A
         O+86pTVx3onQ5dJHspviUXxvhcREJbG9G7qv21MWekV8q3vT0p2kygbHo+Io0xsW/T8U
         91qA==
X-Gm-Message-State: AC+VfDwGJXM3loUbBkjcrGjuHajXbKlOQQ7PxpmY+Raj+oRIAggjeq4r
        hsn+5R5r4R2Wv/8VV99mfeMd4KBpG7bDgwqAfHFTXQ==
X-Google-Smtp-Source: ACHHUZ6Arb3e86WPLu+kbk3kF3wfmSodwf5+FCkwRV6f1KpcCpFXAAZjz973i1vwCX8k4GFJPOYyd7DyVdEctcGZ77s=
X-Received: by 2002:ac2:4428:0:b0:4f1:3b59:44cc with SMTP id
 w8-20020ac24428000000b004f13b5944ccmr3201723lfl.57.1684755953816; Mon, 22 May
 2023 04:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230522031714.5089-1-linyunsheng@huawei.com> <1fc46094-a72a-f7e4-ef18-15edb0d56233@redhat.com>
In-Reply-To: <1fc46094-a72a-f7e4-ef18-15edb0d56233@redhat.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Mon, 22 May 2023 14:45:17 +0300
Message-ID: <CAC_iWjJaNuDFZuv1Rv4Yr5Kaj1Wq69txAoLGepvnJT=pY1gaRw@mail.gmail.com>
Subject: Re: [PATCH net] page_pool: fix inconsistency for page_pool_ring_[un]lock()
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, brouer@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Yunsheng

On Mon, 22 May 2023 at 14:08, Jesper Dangaard Brouer <jbrouer@redhat.com> wrote:
>
>
>
> On 22/05/2023 05.17, Yunsheng Lin wrote:
> > page_pool_ring_[un]lock() use in_softirq() to decide which
> > spin lock variant to use, and when they are called in the
> > context with in_softirq() being false, spin_lock_bh() is
> > called in page_pool_ring_lock() while spin_unlock() is
> > called in page_pool_ring_unlock(), because spin_lock_bh()
> > has disabled the softirq in page_pool_ring_lock(), which
> > causes inconsistency for spin lock pair calling.
> >
> > This patch fixes it by returning in_softirq state from
> > page_pool_producer_lock(), and use it to decide which
> > spin lock variant to use in page_pool_producer_unlock().
> >
> > As pool->ring has both producer and consumer lock, so
> > rename it to page_pool_producer_[un]lock() to reflect
> > the actual usage. Also move them to page_pool.c as they
> > are only used there, and remove the 'inline' as the
> > compiler may have better idea to do inlining or not.
> >
> > Fixes: 7886244736a4 ("net: page_pool: Add bulk support for ptr_ring")
> > Signed-off-by: Yunsheng Lin<linyunsheng@huawei.com>
>
> Thanks for spotting and fixing this! :-)
>
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
