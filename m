Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B98F7283AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbjFHPX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbjFHPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:23:53 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6297E2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:23:50 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1a28e087cf1so581064fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686237830; x=1688829830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7eGKNpEtS/LUHv9klt9Aj7lracb6KVmSgEsfdVlHAJM=;
        b=pEqgsbZOYOIluO5fkSnfT4mHgsIy7URbBhqLKSJNCbfyLlxc4wqySsqRq/FQIAVlld
         7niiHbqG8ABK+qg0QayJyfqS+hnEy1ZdLA1cpZcuZ2/Wh4l2+FgenjLCNS1j+9/823tX
         KzqrCe2Xezxggq3zqU9PQJHr8JRErxf47ZfzdTOTwb1hbU3rJ6FoLvKNy2A7oCXOBc0F
         CwNQJA9zvxuzf7Gqs6d2QIaZlxx8bQrLrnn1Ne1QrGaZNzj7Qw+hIypUS8oEe7vXsqNa
         1kepINzbjWpkh4KfWT4iYK29Xb+H0UWWXw+gzHbejUVEGXRkr3L7uD70c5pF42rUvT3/
         k+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686237830; x=1688829830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eGKNpEtS/LUHv9klt9Aj7lracb6KVmSgEsfdVlHAJM=;
        b=i1lwnJ9WE2Emu3ZHCa2WhAiKUGLUvjhJAmXxL9TbMXPcvExhh1gg96JU+ihpHswfeN
         gbuzflwN9ytRMn08EkN2UYzKYiuyBjTOYrsT+a030u00TsOncSenIPPHTrSkvtI1jLAy
         CeAFYWOvJc54xarudYa3WbgyqqHLIznmQuGZxoTMCusj0kBRknHcDKvxDu8QNtp1fr5g
         teAQupdpjHejBopYcurbOULE5WMTcGa4AHIwYECAVt4MC1racVfJq4llq/s8fDZcAYcL
         CgK4NER5o67dvQ3r6+lVdIHpzzt3TXDephoXLt8/1+q9jhXeEaWNmdLN4CRDJ5H7ft8X
         5TFw==
X-Gm-Message-State: AC+VfDyVaw/LHf8cpubpF7+UpppuzlqyWoQpEvewt5LqwO5o0nrVkMUk
        +7Q6I2DeXk89Fgnct6JNWT5yjZj4H/ntjMPZzpB7tw==
X-Google-Smtp-Source: ACHHUZ6MRhIzgEshXbjiyw+TzgveWuN0oAAyfd+2WEGwxKcq9vh32aSGd6ZMUobJ+47wbPkRfTMCHLTd+ZQm+tiXSVw=
X-Received: by 2002:a05:6870:346:b0:192:ba3b:a18 with SMTP id
 n6-20020a056870034600b00192ba3b0a18mr7681443oaf.51.1686237829805; Thu, 08 Jun
 2023 08:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <461dba105f644867a6687858d51324e8@hyperstone.com>
In-Reply-To: <461dba105f644867a6687858d51324e8@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jun 2023 17:23:13 +0200
Message-ID: <CAPDyKFr7=z5RyeOOBiSaGrtHRxCrTHqwYvMsUjgGmn7cvLa3ZA@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] mmc: block: ioctl: Add PROG-error aggregation
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

On Thu, 25 May 2023 at 11:56, Christian Loehle <CLoehle@hyperstone.com> wrote:
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
>  drivers/mmc/core/block.c   | 17 ++++++-----------
>  drivers/mmc/core/mmc_ops.c | 25 ++++++++++++++++++++++++-
>  drivers/mmc/core/mmc_ops.h |  3 +++
>  3 files changed, 33 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index e46330815484..44c1b2825032 100644
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
> @@ -605,19 +604,15 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
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
> +       /* Poll for write/R1B execution errors */
> +       if (idata->ic.write_flag || r1b_resp)

Earlier we polled for requests that were targeted to rpmb, no matter
if they were write or reads. Are you intentionally changing this? If
so, can you explain why?

> +               err = mmc_poll_for_busy_err_flags(card, busy_timeout_ms, false,
> +                                       MMC_BUSY_IO, &idata->ic.response[0]);

I think it's better to extend the mmc_blk_busy_cb, rather than
introducing an entirely new polling function.

Then you can call __mmc_poll_for_busy() here instead.

>
>         return err;
>  }
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 3b3adbddf664..11e566ab719c 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -57,7 +57,9 @@ static const u8 tuning_blk_pattern_8bit[] = {
>  struct mmc_busy_data {
>         struct mmc_card *card;
>         bool retry_crc_err;
> +       bool aggregate_err_flags;
>         enum mmc_busy_cmd busy_cmd;
> +       u32 *status;
>  };
>
>  struct mmc_op_cond_busy_data {
> @@ -464,7 +466,8 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
>         u32 status = 0;
>         int err;
>
> -       if (data->busy_cmd != MMC_BUSY_IO && host->ops->card_busy) {
> +       if (data->busy_cmd != MMC_BUSY_IO && host->ops->card_busy &&
> +                       !data->aggregate_err_flags) {
>                 *busy = host->ops->card_busy(host);
>                 return 0;
>         }
> @@ -477,6 +480,9 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
>         if (err)
>                 return err;
>
> +       if (data->aggregate_err_flags)
> +               *data->status = R1_STATUS(*data->status) | status;
> +
>         switch (data->busy_cmd) {
>         case MMC_BUSY_CMD6:
>                 err = mmc_switch_status_error(host, status);
> @@ -549,12 +555,29 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>
>         cb_data.card = card;
>         cb_data.retry_crc_err = retry_crc_err;
> +       cb_data.aggregate_err_flags = false;
>         cb_data.busy_cmd = busy_cmd;
>
>         return __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_busy_cb, &cb_data);
>  }
>  EXPORT_SYMBOL_GPL(mmc_poll_for_busy);
>
> +int mmc_poll_for_busy_err_flags(struct mmc_card *card, unsigned int timeout_ms,
> +                     bool retry_crc_err, enum mmc_busy_cmd busy_cmd, u32 *status)
> +{
> +       struct mmc_host *host = card->host;
> +       struct mmc_busy_data cb_data;
> +
> +       cb_data.card = card;
> +       cb_data.retry_crc_err = retry_crc_err;
> +       cb_data.aggregate_err_flags = true;
> +       cb_data.busy_cmd = busy_cmd;
> +       cb_data.status = status;
> +
> +       return __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_busy_cb, &cb_data);
> +}
> +EXPORT_SYMBOL_GPL(mmc_poll_for_busy_err_flags);
> +
>  bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
>                           unsigned int timeout_ms)
>  {
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 09ffbc00908b..fc7ec43a78dc 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -47,6 +47,9 @@ int __mmc_poll_for_busy(struct mmc_host *host, unsigned int period_us,
>                         void *cb_data);
>  int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>                       bool retry_crc_err, enum mmc_busy_cmd busy_cmd);
> +int mmc_poll_for_busy_err_flags(struct mmc_card *card, unsigned int timeout_ms,
> +                     bool retry_crc_err, enum mmc_busy_cmd busy_cmd,
> +                     u32 *status);
>  int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>                 unsigned int timeout_ms, unsigned char timing,
>                 bool send_status, bool retry_crc_err, unsigned int retries);
> --

Kind regards
Uffe
