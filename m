Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6475FEFD2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJNOIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiJNOIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:08:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E27173C0C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:08:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 70so5003476pjo.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3R5dZLIo4FZkTYpLjxbbNDjYi6YbMj7MKY/V8/eX5Pc=;
        b=NGaWWewgPhLVumxT7+imkHQ1InfD7YmrIgHGQQHYZWx1cYcTiiHbRxVMeTO72p6ZcP
         KKYos0MEVpao57aY4Nw5FSh3aNbEMgEevHPsoa0+V+JYeqJDCAIUQbKVLKefeahdpfGX
         qvpYj9ynfczsC23c5utXVJJzvRjhyPfSyh1XZO1vN0weS4Wo0unRsirIaK1FnOIBqwny
         QNl/jWx1SpnQfn0yj/ndZzgiTIFezB5Psw2zr1h/Oo8ty/phx9ixF4BRuAeVS9F6ifso
         USANTEq30z48XLsr7dh4Bugjz6hOYMapWsqU/tUhdI7CZwLAt6HyYKcauS2t0O3tusf0
         YXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3R5dZLIo4FZkTYpLjxbbNDjYi6YbMj7MKY/V8/eX5Pc=;
        b=v8rLOq28P1ipG9HFMpmlmm84FIk5P6g80tfdm0RqnJWqgZXlnbO7JfaImuS/D77h4N
         RcJMehBsr5m4FiSkUF4QsY3HGqHvpyZdlNnHsicU5BekQEUTjsRfldu/xgtCwaiE2aWe
         qVrDFpl6byiTZw4pY95ATW7KweKB5N52etbTU1gjQSVfdjnMnknaJmcxbz/dBQCFMvYz
         v0i7SgZjQYLMco8e3qYMO/kQpnyTyE8GseyAO5oeg4wNFzMhhaR1cSswJ3Du0qCqBnaY
         8iX/M+vKqQUhnG9jd9Kf4GEjYRqeVkUJBLHiVKQf/rGmnObJFMwlFn0SWDXI1TdGKjRd
         xpcg==
X-Gm-Message-State: ACrzQf0fMGyC/XAtLTBdnhOsFE2kz/Z+pT9qmsgbgT1PJPxYy56+stEq
        kOhDFfYW+JOWRY8InNHu/s98J2lnGCWA7Y77QyDVEw==
X-Google-Smtp-Source: AMsMyM44/hdR/I8oru0k3pWfv4CbyDISykFuqObi2fS9Dsp6LPDkmBLNviItjwbMeOP+zDxkuH+WWz2Pul5jcOIK5cM=
X-Received: by 2002:a17:902:d714:b0:17f:5813:1df4 with SMTP id
 w20-20020a170902d71400b0017f58131df4mr5506815ply.148.1665756486078; Fri, 14
 Oct 2022 07:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221014034951.2300386-1-ouyangweizhao@zeku.com>
In-Reply-To: <20221014034951.2300386-1-ouyangweizhao@zeku.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Oct 2022 16:07:28 +0200
Message-ID: <CAPDyKFrpCGzOcRpHANt4cjJuELn2EVStQM15a2=ofYus=Jn_oA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdio: fix kernel panic when remove non-standard
 SDIO card
To:     Weizhao Ouyang <ouyangweizhao@zeku.com>
Cc:     Weizhao Ouyang <o451686892@gmail.com>,
        Matthew Ma <mahongwei@zeku.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Wang <wangdayu@zeku.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Grazvydas Ignotas <notasas@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 at 05:50, Weizhao Ouyang <ouyangweizhao@zeku.com> wrote:
>
> From: Weizhao Ouyang <o451686892@gmail.com>
>
> From: Matthew Ma <mahongwei@zeku.com>
>
> SDIO tuple is only allocated for standard SDIO card, especially it
> causes memory corruption issues when the non-standard SDIO card has
> removed since the card device's reference counter does not increase for
> it at sdio_init_func(), but all SDIO card device reference counter has
> decreased at sdio_release_func().
>
> Fixes: 6f51be3d37df ("sdio: allow non-standard SDIO cards")
> Signed-off-by: Matthew Ma <mahongwei@zeku.com>
> Reviewed-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
> Reviewed-by: John Wang <wangdayu@zeku.com>

If I understand correctly, Matthew Ma <mahongwei@zeku.com> should be
the author of the patch?

Assuming I am correct, I have amended the patch and changed that,
please tell me if I should change that.

So, I applied this for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> -- update Fixes tag
>
>  drivers/mmc/core/sdio_bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index c6268c38c69e..babf21a0adeb 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -291,7 +291,8 @@ static void sdio_release_func(struct device *dev)
>  {
>         struct sdio_func *func = dev_to_sdio_func(dev);
>
> -       sdio_free_func_cis(func);
> +       if (!(func->card->quirks & MMC_QUIRK_NONSTD_SDIO))
> +               sdio_free_func_cis(func);
>
>         kfree(func->info);
>         kfree(func->tmpbuf);
> --
> 2.25.1
>
