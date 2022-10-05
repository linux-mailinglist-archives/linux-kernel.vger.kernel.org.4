Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0683C5F5D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJEXuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJEXui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:50:38 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9241F7333E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:50:37 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id l127so493731vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 16:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kx6Wx0sJJqPpK7EB8zBcafQgWESIq3D1YHYnV5vi9x0=;
        b=io90ztoSpWXGa/05vz6ORJe05OOi3DmM8vp/dS83rcWW5B/NGjl2WcvuYsrJLoTmev
         yKK1yYlbhgLpe09k623rUOkoNJ1SPCaFL/udfsA/B71y+b1TtUU35l/jYj473jB99OU4
         xtPje/p9kNXw26pyTG4xsgOz1woFVzkrsGfIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kx6Wx0sJJqPpK7EB8zBcafQgWESIq3D1YHYnV5vi9x0=;
        b=Z102ZFWLv3anQvoia3Px58Y233REKEYAw68MSPltOtJ7EuoU5oRHUGK7HP3jiexSiD
         Vbr5GYS8Ljhq1MyAX+nFExIGl6jAeLY9LYMwHF+yBQDr100cMHNK+5PmxHvm5A+gmWej
         tYNsFkO29nWVdTGPb3xwtKC7U0FTzBrzqSCfoa8hEGYL7otekbNHM/BA0mi6dSbNHfGj
         qsV1J/Qyl961dIRwW1DsVKTzN5Ai+swzX1lid6dZRe+77YZcmBqN7ZyU4NtCDf6Vqmh8
         4vPee7zVs6kJrNFMILAR1c1Z+XmCQKHJXjYvH2Jd/4I4Qig5dlICvMfG1VWiMJdbZTl4
         yA4g==
X-Gm-Message-State: ACrzQf2nkHTSkJz4MrlBrgyxY1jCu6QOGATK902fH53+yS5Xkezn/Ia7
        qe2sKI70rx1U0bMOVBMfejRw1XuQT9eQUK3pACw=
X-Google-Smtp-Source: AMsMyM6WWdu+CA2L45dPSLzn51m5FH4S206qrxUtWl7qkLJM4GqsLMX6Y1pSTYkWsq2xKn7c0rz2sYFnqeU/hnvdGTM=
X-Received: by 2002:a05:6102:3d05:b0:398:7dce:8492 with SMTP id
 i5-20020a0561023d0500b003987dce8492mr1008369vsv.43.1665013836642; Wed, 05 Oct
 2022 16:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220812144741.240315-1-andrew@aj.id.au>
In-Reply-To: <20220812144741.240315-1-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 5 Oct 2022 23:50:23 +0000
Message-ID: <CACPK8XdnFPXZuzAaSMOUnV6ng9y2_ZMcAff12q8Zxvr2HJZy-w@mail.gmail.com>
Subject: Re: [PATCH] ipmi: kcs: Poll OBF briefly to reduce OBE latency
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     openipmi-developer@lists.sourceforge.net, minyard@acm.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022 at 14:48, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The ASPEED KCS devices don't provide a BMC-side interrupt for the host
> reading the output data register (ODR). The act of the host reading ODR
> clears the output buffer full (OBF) flag in the status register (STR),
> informing the BMC it can transmit a subsequent byte.
>
> On the BMC side the KCS client must enable the OBE event *and* perform a
> subsequent read of STR anyway to avoid races - the polling provides a
> window for the host to read ODR if data was freshly written while
> minimising BMC-side latency.
>

Fixes...?

> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/char/ipmi/kcs_bmc_aspeed.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> index cdc88cde1e9a..417e5a3ccfae 100644
> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> @@ -399,13 +399,31 @@ static void aspeed_kcs_check_obe(struct timer_list *timer)
>  static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask, u8 state)
>  {
>         struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
> +       int rc;
> +       u8 str;

str is status, it would be good to spell that out in full.

>
>         /* We don't have an OBE IRQ, emulate it */
>         if (mask & KCS_BMC_EVENT_TYPE_OBE) {
> -               if (KCS_BMC_EVENT_TYPE_OBE & state)
> -                       mod_timer(&priv->obe.timer, jiffies + OBE_POLL_PERIOD);
> -               else
> +               if (KCS_BMC_EVENT_TYPE_OBE & state) {
> +                       /*
> +                        * Given we don't have an OBE IRQ, delay by polling briefly to see if we can
> +                        * observe such an event before returning to the caller. This is not
> +                        * incorrect because OBF may have already become clear before enabling the
> +                        * IRQ if we had one, under which circumstance no event will be propagated
> +                        * anyway.
> +                        *
> +                        * The onus is on the client to perform a race-free check that it hasn't
> +                        * missed the event.
> +                        */
> +                       rc = read_poll_timeout_atomic(aspeed_kcs_inb, str,
> +                                                     !(str & KCS_BMC_STR_OBF), 1, 100, false,
> +                                                     &priv->kcs_bmc, priv->kcs_bmc.ioreg.str);
> +                       /* Time for the slow path? */

The mod_timer is the slow path? The question mark threw me.

> +                       if (rc == -ETIMEDOUT)
> +                               mod_timer(&priv->obe.timer, jiffies + OBE_POLL_PERIOD);
> +               } else {
>                         del_timer(&priv->obe.timer);
> +               }
>         }
>
>         if (mask & KCS_BMC_EVENT_TYPE_IBF) {
> --
> 2.34.1
>
