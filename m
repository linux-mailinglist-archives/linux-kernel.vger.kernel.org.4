Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB87738597
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjFUNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjFUNpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:45:13 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD88C19B1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:44:51 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-570282233ceso52245097b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687355091; x=1689947091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B6Y+4x5cfJFeIyV3JmtXZ9y2zrl5ML3C/rCwWA5caOA=;
        b=egdBV8LQg30eFKc8nDXoPtkM8vpl5u/HOezAyIlTH8Kgdw6eIF9bb+XX7B1l+KMkw5
         66PfVhRzyg2JqQTxfJ4sj3wZ+rM1Ge3ff0Br2EQ5dumFuqfdG0bJpO581spXvyquFOsa
         pgLjpKGUDhjXTJSY03B9uki8EdQSZxGJD8A/fyxo0kgb46FBJ/VG1I/K3sGtNWA8atMA
         knPZUXgzarYZ6e/eBb6bbbPohJk1W7BJydabVjYWhFQzxQ5PBfDenqfQdjzH/xaIfsPk
         tdntz2GI38GREB+mWQzG2O2s7Y1ZlIdpj9XjEruZ1Q2EZV7VMqqg8pzKoDQFBaPVUfWH
         yB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687355091; x=1689947091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6Y+4x5cfJFeIyV3JmtXZ9y2zrl5ML3C/rCwWA5caOA=;
        b=AVDH7sGQ+A9DY24OxSPkNLiDtABTjZEhPSi74sIWOfqOIVLsytCw3b2OMRZmtDOrY3
         tLKgpsw85EKic8fl1gcaLe0xTkOpSzlPSfb7sNVTrt38CbaMjAHYh1rAXx04hHVQHt13
         Jc78Aw1ehsw3sJvC7MKVo24M5WlUHLYUUBRkskyEr8JmxV261bQSo8ZPQWGi3x24hCfp
         zwKh7ViEBfWEpeCx/xWKwvEMSa/V1obZBL4jj7dCcxKyiGvNsn2f8dZdUBpGPJjpJkz0
         SvcK5k1icLAfWjq8ijO2R/xrEip6bgKCeVlsRNNoDyC4P6JTSVbH8f3BQYn1noCkNC6p
         PVjQ==
X-Gm-Message-State: AC+VfDyMUumCjy8Dx7oR8ZbQ2jvpL5GBOXD0NxKYvKOHZhMam/lvcXFt
        iWGzxBxjkah292i8Hoz9JkGZMnOjgroAgeEyPGtzf93/GQFhK/3u
X-Google-Smtp-Source: ACHHUZ7eXgV2xsNLYgHzVckH9o2+oO+AFIWHMnFeLSgvSgMwWGHhRSVEfq8l+dVXwrRUx/EinzNi2nm33U55N8+Cm7c=
X-Received: by 2002:a81:4e11:0:b0:56c:f38a:163d with SMTP id
 c17-20020a814e11000000b0056cf38a163dmr13751743ywb.8.1687355090812; Wed, 21
 Jun 2023 06:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230621100151.6329-1-victorshihgli@gmail.com> <20230621100151.6329-2-victorshihgli@gmail.com>
In-Reply-To: <20230621100151.6329-2-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Jun 2023 15:44:14 +0200
Message-ID: <CAPDyKFq5YzwAGGKi_4=MVrQad9kM-i0xoQ5XhijDNuWDPOVFFA@mail.gmail.com>
Subject: Re: [PATCH V8 01/23] mmc: core: Cleanup printing of speed mode at
 card insertion
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 at 12:02, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>

Please do not claim authorship of patches that haven't been authored
by you. Of course, there is a balance, if you need to make bigger
modifications, then you deserve to claim the authorship, but that
isn't the case here I think.

This applies to a couple of more patches in the series, I will not
comment on them in this regard, but leave that to you to look over at
the next submission.

>
> The current print of the bus speed mode in mmc_add_card() has grown over
> the years and is now difficult to parse. Let's clean up the code and also
> take the opportunity to properly announce "DDR" for eMMCs as
> "high speed DDR", which is according to the eMMC spec.
>
> Updates in V8:
>  - Modify commit message.
>
> Updates in V7:
>  - Remove unnecessary parentheses.
>
> Updates in V6:
>  - Adjust the position of matching brackets.

I appreciate the version history per patch. However, this doesn't
belong in the commit message.

Instead you have to manually edit each formatted patch to add this,
exactly where see below.

>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---

After this line you can add comments and version history for the
patch. In this way, it will not be a part of the commit message when
applying.

Complete the section by adding three new dashes and a newline - this
keeps the patch format correct.

---

>  drivers/mmc/core/bus.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 2c3074a605fc..cf32cf135781 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -299,6 +299,7 @@ int mmc_add_card(struct mmc_card *card)
>  {
>         int ret;
>         const char *type;
> +       const char *speed_mode = "";
>         const char *uhs_bus_speed_mode = "";
>         static const char *const uhs_speeds[] = {
>                 [UHS_SDR12_BUS_SPEED] = "SDR12 ",
> @@ -337,27 +338,30 @@ int mmc_add_card(struct mmc_card *card)
>                 break;
>         }
>
> +       if (mmc_card_hs(card))
> +               speed_mode = "high speed ";
> +       else if (mmc_card_uhs(card))
> +               speed_mode = "ultra high speed ";
> +       else if (mmc_card_ddr52(card))
> +               speed_mode = "high speed DDR ";
> +       else if (mmc_card_hs200(card))
> +               speed_mode = "HS200 ";
> +       else if (mmc_card_hs400es(card))
> +               speed_mode = "HS400 Enhanced strobe ";
> +       else if (mmc_card_hs400(card))
> +               speed_mode = "HS400 ";
> +
>         if (mmc_card_uhs(card) &&
>                 (card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
>                 uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
>
> -       if (mmc_host_is_spi(card->host)) {
> -               pr_info("%s: new %s%s%s card on SPI\n",
> -                       mmc_hostname(card->host),
> -                       mmc_card_hs(card) ? "high speed " : "",
> -                       mmc_card_ddr52(card) ? "DDR " : "",
> -                       type);
> -       } else {
> -               pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
> -                       mmc_hostname(card->host),
> -                       mmc_card_uhs(card) ? "ultra high speed " :
> -                       (mmc_card_hs(card) ? "high speed " : ""),
> -                       mmc_card_hs400(card) ? "HS400 " :
> -                       (mmc_card_hs200(card) ? "HS200 " : ""),
> -                       mmc_card_hs400es(card) ? "Enhanced strobe " : "",
> -                       mmc_card_ddr52(card) ? "DDR " : "",
> +       if (mmc_host_is_spi(card->host))
> +               pr_info("%s: new %s%s card on SPI\n",
> +                       mmc_hostname(card->host), speed_mode, type);
> +       else
> +               pr_info("%s: new %s%s%s card at address %04x\n",
> +                       mmc_hostname(card->host), speed_mode,
>                         uhs_bus_speed_mode, type, card->rca);
> -       }
>
>         mmc_add_card_debugfs(card);
>         card->dev.of_node = mmc_of_find_child_device(card->host, 0);
> --
> 2.25.1
>
