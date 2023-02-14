Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBE869635B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjBNMTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBNMT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:19:28 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6342798C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:19:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id kk7-20020a17090b4a0700b00234463de251so172964pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IBjgxxSMab1czGWNNK+OIQim0vtdTdE0VrTQWN06Brw=;
        b=xlOraauYgPr8HlBqw4scGhy01vpznkPYuXR/2a8vIyEPCyNx+JShErgSF5XG0+x3di
         q1rgF6W2dn8JYFC7ZaXSmhjza2rHMeGf3Y7gLXC+VTgsBOh1IS7ZWlLCxDeG++rMlk/T
         LhLl4LwCP55fgriLkKDs7vxlapGUsNTc7BkG88U2pHeMVqCaN1xyUm3v45utBf2EMFNw
         mFEokvIf477GGpBaYGCO1QWJLAyNBV+11Jl38+Z2902/tuvWKEORnM4Ck0+v9HwaEDeJ
         wZMfbSlRt7NnfutGfGwXkYbWsptxNs3xM3atIka6XkWEoZUYh9FuYZWPgvzIv6sfUyFj
         cSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBjgxxSMab1czGWNNK+OIQim0vtdTdE0VrTQWN06Brw=;
        b=jgiq9687hoNl7jh966sGThv5jmM+ipQaSZ26fRTWzlqFrNTApDd62T2Df0g/IaFPxz
         Jpw51o8ieEI0TXeB5wFnyQTeMw15WDphYJveeBhEH4ONNdXsUtKGxYmCV7SofZjXCSdw
         SHvSKLWL3YwxwXBAOFqDuNnYhatDXBCXQ755xGfQXKskraDKKi8T4xrTQlT4JR73aAfS
         2UpQrQRovB71nMgfdxZ7mZnbOqkJlBjb9TyNho78tsVKZfzdfxdwueU/U0doM756L7L9
         OS654XKjDsPcndXrfzgcZ4z1ObIkRuTPmE9S0hlu0ecEx8wYZOmOOhbAW3AFbzjjQA5O
         pEfA==
X-Gm-Message-State: AO0yUKXv3KxQQIGXiL1w/m9C9rGNJXsNWhNtqvdwyx0+GJzcs3srnQob
        9D6+TWTZT0d2AI10cw39onM+C9VKjsP0RWpZxQSQ+A==
X-Google-Smtp-Source: AK7set+t15/AtzHgv8sdlJm6BIiBakbPNhouUcCTrwA4UqbvEzu2sE9I2deQ3v3jCJYuKZDp173VwwHT2OQYGijzHYs=
X-Received: by 2002:a17:90a:c90f:b0:233:ba2c:16a6 with SMTP id
 v15-20020a17090ac90f00b00233ba2c16a6mr2976781pjt.109.1676377151894; Tue, 14
 Feb 2023 04:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20230213133707.27857-1-ulf.hansson@linaro.org>
In-Reply-To: <20230213133707.27857-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 13:18:35 +0100
Message-ID: <CAPDyKFoSpY_yGGu4jmYJm6qVYju2TmdN9DA3yvTLAwF59an_Ww@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Align to common busy polling behaviour for mmc ioctls
To:     linux-mmc@vger.kernel.org, Christian Lohle <cloehle@hyperstone.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 at 14:37, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Let's align to the common busy polling behaviour for mmc ioctls, by
> updating the below two corresponding parts, that comes into play when using
> an R1B response for a command.
>
> *) A command with an R1B response should be prepared by calling
> mmc_prepare_busy_cmd(), which make us respects the host's busy timeout
> constraints.
> **) When an R1B response is being used and the host also supports HW busy
> detection, we should skip to poll for busy completion.
>
> Suggested-by: Christian Loehle <cloehle@hyperstone.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

I have now applied this for next and by adding your reviewed-by tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c   | 25 +++++++++++++++++--------
>  drivers/mmc/core/mmc_ops.c |  1 +
>  2 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 20da7ed43e6d..672ab90c4b2d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -470,6 +470,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         struct mmc_data data = {};
>         struct mmc_request mrq = {};
>         struct scatterlist sg;
> +       bool r1b_resp, use_r1b_resp = false;
> +       unsigned int busy_timeout_ms;
>         int err;
>         unsigned int target_part;
>
> @@ -545,6 +547,13 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>             (cmd.opcode == MMC_SWITCH))
>                 return mmc_sanitize(card, idata->ic.cmd_timeout_ms);
>
> +       /* If it's an R1B response we need some more preparations. */
> +       busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
> +       r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
> +       if (r1b_resp)
> +               use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd,
> +                                                   busy_timeout_ms);
> +
>         mmc_wait_for_req(card->host, &mrq);
>         memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
>
> @@ -596,14 +605,14 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         if (idata->ic.postsleep_min_us)
>                 usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
>
> -       if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
> -               /*
> -                * Ensure RPMB/R1B command has completed by polling CMD13 "Send Status". Here we
> -                * allow to override the default timeout value if a custom timeout is specified.
> -                */
> -               err = mmc_poll_for_busy(card, idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS,
> -                                       false, MMC_BUSY_IO);
> -       }
> +       /* No need to poll when using HW busy detection. */
> +       if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
> +               return 0;
> +
> +       /* Ensure RPMB/R1B command has completed by polling with CMD13. */
> +       if (idata->rpmb || r1b_resp)
> +               err = mmc_poll_for_busy(card, busy_timeout_ms, false,
> +                                       MMC_BUSY_IO);
>
>         return err;
>  }
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 81c55bfd6e0c..3b3adbddf664 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -575,6 +575,7 @@ bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
>         cmd->busy_timeout = timeout_ms;
>         return true;
>  }
> +EXPORT_SYMBOL_GPL(mmc_prepare_busy_cmd);
>
>  /**
>   *     __mmc_switch - modify EXT_CSD register
> --
> 2.34.1
>
