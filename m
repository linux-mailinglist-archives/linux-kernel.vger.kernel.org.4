Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F0274CB2B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGJEWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjGJEWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:22:46 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06F1FF
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 21:22:32 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7672303c831so364818085a.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 21:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1688962952; x=1691554952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KdPVtuGWSeh+e/CBypa8yvniv55q4NGBxX2TleYGOls=;
        b=k/MmSA+GB3nUSHuzTWAKdW+rACKSvV3MdhyKgDGKnyuWIjHUbMCagmypEOkZVV55Io
         iBYxTr0uz75WTg64Y7k3kiOIOZ7IrWbZscHM1Qk1xj3ZLi5QvlB8+n0zze9JPcLVG7YY
         /+1/D8rhY6FVGZDJyIpACRvoYHbU0e1L2lxCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688962952; x=1691554952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdPVtuGWSeh+e/CBypa8yvniv55q4NGBxX2TleYGOls=;
        b=FCHSxceXLFHQcJDUFvVp2Fl510QMLe4U/NaQaGAbXXs7HruKiMxvXdfHmRiQbJIliM
         8XjzLEbGEXdWqTNlmb+8Da7O33FRDHO9LOhthFGJN4yhK6OqvAxXfGzRygcjkxhGF+EO
         H8g1XqjBMKdkGD/kKgfTQaWS+SMFYUkou+Oy9KoEv/nPXezSU7gs7sF5+zv/gq/DuS6e
         UB4radCSvbNz+FMHKP2uFuNTfP1U5Xl/ydEJFX5xAuJOodMlFsn+wXVG3dmdmkQkWOLq
         +gSkAQicbgwBDZDHvEHQXS1dUojCXlXN5jDx+mDQa13Y4+OgMrdoispO1GSM91UE7PU1
         i2PQ==
X-Gm-Message-State: ABy/qLYyAZ1ZwXGF+4WSi5PVOOSdb+eQmzXJyuNkucp0mJDxnUG+GEEA
        Qydwle/A2ZD3tq2IX5sIIRuVtSHkc6JXvlaflRg=
X-Google-Smtp-Source: APBJJlFPmu/OpSM3hi2YqcI2sfhcz7s1RLQ6X0BZQcnNGXKfqOg1DMVVigKZ89Mqohjn+kNP2hZxf+s2peyir5k6h7U=
X-Received: by 2002:a05:622a:1313:b0:3fd:eca6:8aed with SMTP id
 v19-20020a05622a131300b003fdeca68aedmr13615111qtk.44.1688962952027; Sun, 09
 Jul 2023 21:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230628083735.19946-2-zev@bewilderbeest.net>
In-Reply-To: <20230628083735.19946-2-zev@bewilderbeest.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 10 Jul 2023 04:22:18 +0000
Message-ID: <CACPK8Xei-295TNmkjg53qXyQHwSUf3s+Sj87_o7ZEw1G0+NPpw@mail.gmail.com>
Subject: Re: [PATCH] soc: aspeed: uart-routing: Use __sysfs_match_string
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org,
        Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Oskar Senft <osk@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 08:43, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> The existing use of match_string() caused it to reject 'echo foo' due
> to the implicitly appended newline, which was somewhat ergonomically
> awkward and inconsistent with typical sysfs behavior.  Using the
> __sysfs_* variant instead provides more convenient and consistent
> linefeed-agnostic behavior.

Nice.

Fixes: c6807970c3bc ("soc: aspeed: Add UART routing support")
Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/soc/aspeed/aspeed-uart-routing.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/aspeed/aspeed-uart-routing.c b/drivers/soc/aspeed/aspeed-uart-routing.c
> index ef8b24fd1851..59123e1f27ac 100644
> --- a/drivers/soc/aspeed/aspeed-uart-routing.c
> +++ b/drivers/soc/aspeed/aspeed-uart-routing.c
> @@ -524,7 +524,7 @@ static ssize_t aspeed_uart_routing_store(struct device *dev,
>         struct aspeed_uart_routing_selector *sel = to_routing_selector(attr);
>         int val;
>
> -       val = match_string(sel->options, -1, buf);
> +       val = __sysfs_match_string(sel->options, -1, buf);
>         if (val < 0) {
>                 dev_err(dev, "invalid value \"%s\"\n", buf);
>                 return -EINVAL;
> --
> 2.40.0.5.gf6e3b97ba6d2.dirty
>
