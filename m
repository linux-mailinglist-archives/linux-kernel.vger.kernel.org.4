Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC1B63D86E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiK3Ooi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiK3Oog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:44:36 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5D118B15
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:44:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so2148496pjs.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYuSJquVwIjmwCCxFA89hvpczZS6iAqYsFgIeQbQyk4=;
        b=P6upJZHw3kEQqixVBF1l9xDXgWhHnFvJpaIkF91K7oFHU3IHlsrI87+u0LNjxkVsPD
         lt8jjxM8uscBVyemK5Pp5TDhtcX2z3kVNe3CxuynX+0DzHSYdqsWjWvXakgGcvQJPgdS
         hW5xC3C1C+wXWnVTWpfaynTevi5nLzjQOvD8kt0UIxki0elwTYOA1wL1XT1bM6RKZr0L
         tl0fP1lje1l2Htl/DjdqBpX79JiLdJqro7onW3CHpR0rSrSbXPzPyRNrGl4HxJQoZszJ
         wMnrdffqzR7yMeUGxyyrbZARMamR1qWAEeTPOl+aC2qiK+HT+86KWviq4tLncED6X/uq
         Si5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYuSJquVwIjmwCCxFA89hvpczZS6iAqYsFgIeQbQyk4=;
        b=6cgh8250wybm4sG6ojgdN3BaZffFS5ddDuHMZTTGArQxMPneGtGm457FbN4rg6JPlT
         3Wn4kmA6n2UeMi1orZ3520iaJLxOCd8sotTqfOsbIUO17dMqpAzgrhbRLOahStpAXgSD
         K2lIdgtHKhwm+oOeXvcrNBoqmrnjONX0pkCDgkEUNpynD8u1Yscp1r7pVd3xuyXTBrsj
         OAqhpky6IwdEGEFtV5hcyx3Zyi8MDJ4DvjNbWJJAQx05SerQ8DThEPwTfFSU+3MJxyqY
         NlHbhBt1a1oNqkgLdyRie6XqSedxYt7tS876hEumCB6i7izIobe44ikqrLR6VGYB3j73
         h9iw==
X-Gm-Message-State: ANoB5pl1mpQTvdB0n0Dn7t10I/TNOVueqzoZLZKFGkte34ZBodsx5AXK
        WV8u7Fg+U8Rvar2ej9afK7Ze62rFVSaRbA86gBTz5g==
X-Google-Smtp-Source: AA0mqf4Fjnax4NQ1M1G8Yb/5mHMz2XBgnPQYbujS17h4jc8RF/kNSGd8x2Ve0ssQGzTrweZfOPpQBV5va67gO3iTNM4=
X-Received: by 2002:a17:902:d68b:b0:188:cca8:df29 with SMTP id
 v11-20020a170902d68b00b00188cca8df29mr49431583ply.148.1669819475327; Wed, 30
 Nov 2022 06:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20221130134920.2109-1-thunder.leizhen@huawei.com>
In-Reply-To: <20221130134920.2109-1-thunder.leizhen@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Nov 2022 15:43:59 +0100
Message-ID: <CAPDyKFq+poiVobaaCAYx_AD9Z6M_+r89AE6pViPFZMzVSZc92A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Normalize the error handling branch in sd_read_ext_regs()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 at 14:49, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> 1. Use pr_err() to output the error message.
> 2. Add the description of why success 0 is returned in case
>    "non-supported SD ext reg layout".
>
> Fixes: c784f92769ae ("mmc: core: Read the SD function extension registers for power management")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sd.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 3662bf5320ce56d..93ee53f74427c38 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1259,7 +1259,7 @@ static int sd_read_ext_regs(struct mmc_card *card)
>          */
>         err = sd_read_ext_reg(card, 0, 0, 0, 512, gen_info_buf);
>         if (err) {
> -               pr_warn("%s: error %d reading general info of SD ext reg\n",
> +               pr_err("%s: error %d reading general info of SD ext reg\n",
>                         mmc_hostname(card->host), err);
>                 goto out;
>         }
> @@ -1273,7 +1273,12 @@ static int sd_read_ext_regs(struct mmc_card *card)
>         /* Number of extensions to be find. */
>         num_ext = gen_info_buf[4];
>
> -       /* We support revision 0, but limit it to 512 bytes for simplicity. */
> +       /*
> +        * We only support revision 0, and limit it to 512 bytes for simplicity.
> +        * In other cases, success 0 is returned, because the card remains
> +        * functional and all but the new features from the SD function
> +        * extensions registers can still be used.
> +        */
>         if (rev != 0 || len > 512) {
>                 pr_warn("%s: non-supported SD ext reg layout\n",
>                         mmc_hostname(card->host));
> @@ -1288,7 +1293,7 @@ static int sd_read_ext_regs(struct mmc_card *card)
>         for (i = 0; i < num_ext; i++) {
>                 err = sd_parse_ext_reg(card, gen_info_buf, &next_ext_addr);
>                 if (err) {
> -                       pr_warn("%s: error %d parsing SD ext reg\n",
> +                       pr_err("%s: error %d parsing SD ext reg\n",
>                                 mmc_hostname(card->host), err);
>                         goto out;
>                 }
> --
> 2.25.1
>
