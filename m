Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F44739DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjFVJw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjFVJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:52:37 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A039269E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:46:08 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso6737082276.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687427167; x=1690019167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UlnbDp30fbsCZunDNViKkSr3RUZrIcXF5g+Y8OUYLQ4=;
        b=j8dpGPN7O5knjDGolUGT3QuiKvRDqIRaEUMUMY3zfDbnm9LL61MKivqdx0riyQ46ur
         Mi9d5OJKP4CzqgSffA9jH921irZfps+y8tD67zN9E5wyXAbNmRCjYN/3K7j4J56n1M2A
         /l0rorEq1BTTqhU2kIGmC/enbRReu9Wm2y+V5BL4aOJtz0C/AcGlI9AHIjzgkWROjsmA
         hvjaMezHQHRAgFnkOzmQchyJk4LfkdoOaUaCYVOfgV3A7N4JC57+6SXoAuhh/IrPrFOa
         J0CE/5rlc6RTX1IlZVbG6IbehlJg5q1xiubA2+eMfpNj8p9DWonHYw2zUItK0VNpiC45
         rSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687427167; x=1690019167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlnbDp30fbsCZunDNViKkSr3RUZrIcXF5g+Y8OUYLQ4=;
        b=kEXsSyikcQ6hOiJ6cWoVt5iCsF2d+Wa4Nr2aSTUxO+/MGdxGqC7nKDNB9Kfb7iMpW+
         Hw5DLOUOrJ4vUCJAaE834jDtkl4F7ElQK0kebqw/K4ADHTZ5VvfXQj7QbqMKwng4cHV6
         SKhx2Rkz6WivXdD2/ffC0dD2Pg7WQ12pt2R/E8gVYNR1PTiomw0Sh6GbOjpT1PwXE/3o
         BIHAQSEfPScvRuNnchAKli0+p6zlZaNE26bXCLTarw3IsIJtfpRHgIubtX214MTyeUuu
         5Pz/UOyajQhxhrKkUTeFdnuLHXwWlE+CVcSzqy1/2PKUCOvfPwqJ8gyMzSPXQ5kW5Gvg
         eBzw==
X-Gm-Message-State: AC+VfDzaNETFRt/eCo9VFX5xouKOLj0GAEdAdkLqZihHP6H9LKQ0E4kn
        rOMi9kabqm/+ASSpE/4l5tvMe07DXOJGSTNrPmFNiX7/JcWx67e+VKw=
X-Google-Smtp-Source: ACHHUZ5ti/HPvYEAMyru3gz1BtwbdTceWYGO5J0/rNr+3mdOrwxuIT+Ux5kzCuuFeZWKbi+zI/H1fLdmTUILeuW5d1s=
X-Received: by 2002:a25:d897:0:b0:c00:737e:9387 with SMTP id
 p145-20020a25d897000000b00c00737e9387mr2887026ybg.13.1687427167209; Thu, 22
 Jun 2023 02:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <26d178dcfc2f4b7d9010145d0c051394@hyperstone.com>
In-Reply-To: <26d178dcfc2f4b7d9010145d0c051394@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Jun 2023 11:45:31 +0200
Message-ID: <CAPDyKFrvE6Ur3ASXOmq-2QQxRF37XK+6GzRAJZ-1mGh5hWQE3w@mail.gmail.com>
Subject: Re: [PATCHv3 1/1] mmc: block: ioctl: Add PROG-error aggregation
To:     Christian Loehle <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023 at 14:44, Christian Loehle <CLoehle@hyperstone.com> wrote:
>
> Userspace currently has no way of checking for error bits of
> detection mode X. These are error bits that are only detected by
> the card when executing the command. For e.g. a sanitize operation
> this may be minutes after the RSP was seen by the host.
>
> Currently userspace programs cannot see these error bits reliably.
> They could issue a multi ioctl cmd with a CMD13 immediately following
> it, but since errors of detection mode X are automatically cleared
> (they are all clear condition B).
> mmc_poll_for_busy of the first ioctl may have already hidden such an
> error flag.
>
> In case of the security operations: sanitize, secure erases and
> RPMB writes, this could lead to the operation not being performed
> successfully by the card with the user not knowing.
> If the user trusts that this operation is completed
> (e.g. their data is sanitized), this could be a security issue.
> An attacker could e.g. provoke a eMMC (VCC) flash fail, where a
> successful sanitize of a card is not possible. A card may move out
> of PROG state but issue a bit 19 R1 error.
>
> This patch therefore will also have the consequence of a mmc-utils
> patch, which enables the bit for the security-sensitive operations.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c   | 26 +++++++++++++++-----------
>  drivers/mmc/core/mmc_ops.c | 14 +++++++-------
>  drivers/mmc/core/mmc_ops.h |  9 +++++++++
>  3 files changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index e46330815484..c7e2b8ae58a9 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -470,7 +470,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         struct mmc_data data = {};
>         struct mmc_request mrq = {};
>         struct scatterlist sg;
> -       bool r1b_resp, use_r1b_resp = false;
> +       bool r1b_resp;
>         unsigned int busy_timeout_ms;
>         int err;
>         unsigned int target_part;
> @@ -551,8 +551,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
>         r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
>         if (r1b_resp)
> -               use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd,
> -                                                   busy_timeout_ms);
> +               mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout_ms);
>
>         mmc_wait_for_req(card->host, &mrq);
>         memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
> @@ -605,19 +604,24 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         if (idata->ic.postsleep_min_us)
>                 usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
>
> -       /* No need to poll when using HW busy detection. */
> -       if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
> -               return 0;
> -
>         if (mmc_host_is_spi(card->host)) {
>                 if (idata->ic.write_flag || r1b_resp || cmd.flags & MMC_RSP_SPI_BUSY)
>                         return mmc_spi_err_check(card);
>                 return err;
>         }
> -       /* Ensure RPMB/R1B command has completed by polling with CMD13. */
> -       if (idata->rpmb || r1b_resp)
> -               err = mmc_poll_for_busy(card, busy_timeout_ms, false,
> -                                       MMC_BUSY_IO);
> +       /* Poll for RPMB/write/R1B execution errors */

Except for the other comments that I had on v2 (which isn't addressed
in v3), I would like this comment to be extended a bit.

More precisely, we somehow need to state that even if the host
supports HW busy signaling (MMC_CAP_WAIT_WHILE_BUSY) we need to send a
CMD13 to get the internal error status of the card.

> +       if (idata->rpmb || idata->ic.write_flag || r1b_resp) {
> +               struct mmc_busy_data cb_data;
> +
> +               cb_data.card = card;
> +               cb_data.retry_crc_err = false;
> +               cb_data.aggregate_err_flags = true;
> +               cb_data.busy_cmd = MMC_BUSY_IO;
> +               cb_data.status = &idata->ic.response[0];
> +               err = __mmc_poll_for_busy(card->host, 0, busy_timeout_ms,
> +                               &mmc_busy_cb, &cb_data);
> +
> +       }
>
>         return err;
>  }

[...]

Kind regards
Uffe
