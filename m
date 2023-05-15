Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCAA702E07
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242146AbjEONZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242058AbjEONZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:25:03 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C03D10A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:25:02 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ba6fffc5524so5502703276.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684157101; x=1686749101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5z8+RvAh9MbIWKx+MZ7oODVRpLOf3nPKNQkMXhxKVg=;
        b=SC2+fwy7pcEOe7G/SmtpOuOoaUI5idaKJbY2GyzIeLqfNt7AO+fzErJojzm96U2CbH
         e8X53TXz2+eiJFVgXZcs3qz5PyxLGXTehlY5xMvuaVf4dmf1CVne+Mvufhtl6LCQ31Cy
         r1skH7JrX+mS63EedA19ewg8DAC6GYkYoxYMaxeu3vusjsqL6QfFlNHUaeDggyB1A1/W
         2A4+qwnVeDdO1DzlMj0us3ab5J8xaUvvl12kAHaI82Bo13GFmR/5/+QPiDAAu+bAfPqt
         l9RJDknyf5kVtA+M+YuD5rbAYzOYkmJptW3XVRv9kReDTtSxcnE0a4oibh+Qgbzba6Zs
         PvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684157101; x=1686749101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5z8+RvAh9MbIWKx+MZ7oODVRpLOf3nPKNQkMXhxKVg=;
        b=KXyu36zHkBHnNqnHSol1SSNK0Kjjnc/KSizgqmy77YIO4UYbuTSMCk7Uc5ZS746vha
         ojI4tYirmwPkWeXQJt0Qm/rUoqBuJxKudy1A2tAz00aMoEkwP5v2bfTNCakYY7J5QMGJ
         w5f20WEynwt+SQ7b9zmR58VEaIaBWbPQZ4UDbqnRexQ84ivbVcZ+X2TaB4Ni3VzD9n6U
         iP6O29xs9VbZu6r5dZHNgCYJhkSlkaVEKR98PZFjAC+8WlGxlqi52ME3hu1R7+Bd4JuO
         0JEaK9kJE38jIv+8jtsOu+xzeZe63cNOhR+HbmytGh3PhONXcQv2KsB8zRER9IzRGlzh
         aq9A==
X-Gm-Message-State: AC+VfDx61lXv3JYDO1BHnIillZY50cjf0FZ4qQKJc1CmxIvd+4BpcY4O
        BwKPuGNfvxUG4E5o32YQSTqSTaQxmH505tHDFyZgBQ==
X-Google-Smtp-Source: ACHHUZ6cohEwG9ks1tFJon2zPAGHVvwapQ+Dah7ASTDxpCFHFQeG5D/07juNsllJbG69v3ST4QkHVtEAzq+EKpDV1xY=
X-Received: by 2002:a25:aa74:0:b0:ba7:7f43:4f3f with SMTP id
 s107-20020a25aa74000000b00ba77f434f3fmr5531057ybi.50.1684157101364; Mon, 15
 May 2023 06:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <4bdab00c5b6f4f8f95b53e586552acfa@hyperstone.com>
In-Reply-To: <4bdab00c5b6f4f8f95b53e586552acfa@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 May 2023 15:24:25 +0200
Message-ID: <CAPDyKFp-uqMYpbpCsrw5mdWyhao2rH7nhYuuq3R_eCUnQfEUDw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: block: ioctl: do write error check for spi
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 at 13:57, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> SPI doesn't have the usual PROG path we can check for error bits
> after moving back to TRAN. Instead it holds the line LOW until
> completion. We can then check if the card shows any errors or
> is in IDLE state, indicating the line is no longer LOW because
> the card was reset.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 16e262ddc954..35ff7101cbb1 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -182,6 +182,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *=
mqrq,
>                                int recovery_mode,
>                                struct mmc_queue *mq);
>  static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
> +static int mmc_spi_err_check(struct mmc_card *card);
>
>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>  {
> @@ -553,7 +554,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card,=
 struct mmc_blk_data *md,
>         /* If it's an R1B response we need some more preparations. */
>         busy_timeout_ms =3D idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_=
MS;
>         r1b_resp =3D (cmd.flags & MMC_RSP_R1B) =3D=3D MMC_RSP_R1B;
> -       if (r1b_resp)
> +       if (r1b_resp && !mmc_host_is_spi(card->host))
>                 use_r1b_resp =3D mmc_prepare_busy_cmd(card->host, &cmd,
>                                                     busy_timeout_ms);
>
> @@ -612,8 +613,12 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card=
, struct mmc_blk_data *md,
>         if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
>                 return 0;
>
> +       if (mmc_host_is_spi(card->host)) {
> +               if (idata->ic.write_flag)
> +                       err =3D mmc_spi_err_check(card);
> +       }

Nitpick: I would prefer to use an "early return" rather than an
else-if here. Would you mind changing that?

>         /* Ensure RPMB/R1B command has completed by polling with CMD13. *=
/
> -       if (idata->rpmb || r1b_resp)
> +       else if (idata->rpmb || r1b_resp)
>                 err =3D mmc_poll_for_busy(card, busy_timeout_ms, false,
>                                         MMC_BUSY_IO);
>

Other than the nitpick, this looks good to me!

Kind regards
Uffe
