Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC06655FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 05:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLZER5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 23:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLZERv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 23:17:51 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3237FC4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 20:17:49 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id d185so9509982vsd.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 20:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ixVfnoBjYbfOKMbrMo78iOagSqVmsOEMtkWXnl7+1Mg=;
        b=YH85DUnZg6aBqH+TGUu5oaDCR6VI6rAKJK+xV/01pTrNDXgjGYawcgKy8hTGpZHF43
         2HRXmwgJItve15LH5T8JZzlJPByTHsOobI/5KjiqnB05YTnuHiK1sZjPWv8Vu92EWBOA
         vMjWKYtB2zdN2kGCLrXlh/HcSONCSBn5POY9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixVfnoBjYbfOKMbrMo78iOagSqVmsOEMtkWXnl7+1Mg=;
        b=Zpeo9aU3mT9ZEekt990av1Yz7ERD2xQn+QdJfUhmPO3GDGGEGqj9nNKJVfOj4ejayz
         9z5p9rDIXGxxJ9JabRojddG4KfKF10FcIWQOh0z4aGdaI0x5kLdKkkCUHhM6GTtiwWYg
         hoZI/JvbFWdE84VCy/mUP1Dd8ZUdzWqHAFsGHTPH2jHOvKga0vckVzLKr6HoJqztfW4J
         LGwhFw0oGUKf/OeV+F4tUnfG1eFPq1if4mmZGPAzzZlFzkHCHfKekz1pyPqL9w+SBrrc
         FqzeIk9PH6+tjsWnzYON38ssl5dRn+ASkKuWqonPv1XBaWIupPrOkBoQWI8AvkBdg4Hw
         ZmEA==
X-Gm-Message-State: AFqh2kohKhmVF38LTllT9uAErdRu/K5xjN1Wxxv3FVXqoW0wGHi+3gPK
        LBu5wAy3jyiGuLP3j/K2EODCe5d+iU7rmS+1suXDVg==
X-Google-Smtp-Source: AMrXdXtOw254JHHtoeUJ7IvvFyAdlF2AawF+OldnipmmrsBWfhK9LpuaPV1U6UUtuS66NMf8+N6xMKoEYThVYvFFfug=
X-Received: by 2002:a05:6102:3e06:b0:3b5:fd8:7948 with SMTP id
 j6-20020a0561023e0600b003b50fd87948mr2139717vsv.85.1672028269104; Sun, 25 Dec
 2022 20:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20221223193807.914935-1-nicolas.dufresne@collabora.com> <20221223193807.914935-4-nicolas.dufresne@collabora.com>
In-Reply-To: <20221223193807.914935-4-nicolas.dufresne@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Dec 2022 12:17:38 +0800
Message-ID: <CAGXv+5GBhZ4U4y_KGrBdvgmy7odcVvH=ZJEMtsfjPvw4tQUV1A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] media: rkvdec: Re-enable H.264 error detection
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 3:39 AM Nicolas Dufresne
<nicolas.dufresne@collabora.com> wrote:
>
> This re-enable H.264 error detection, but using the other error mode.
> In that mode, the decoder will skip over the error macro-block or
> slices and complete the decoding. As a side effect, the error status
> is not set in the interrupt status register, and instead errors are
> detected per format. Using this mode workaround the issue that the
> HW get stuck in error state, and allow reporting that some corruption
> may be present in the buffer to userland.
>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 23 +++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
> index 4fc167b42cf0c..dfe3e235f099a 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -1162,14 +1162,15 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
>
>         schedule_delayed_work(&rkvdec->watchdog_work, msecs_to_jiffies(2000));
>
> -       writel(0, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> -       writel(0, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
> +       writel(0xffffffff, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> +       writel(0xffffffff, rkvdec->regs + RKVDEC_REG_H264_ERR_E);

Use RKVDEC_H264_ERR_EN_HIGHBITS() here? Only lower 30 bits are valid.

>         writel(1, rkvdec->regs + RKVDEC_REG_PREF_LUMA_CACHE_COMMAND);
>         writel(1, rkvdec->regs + RKVDEC_REG_PREF_CHR_CACHE_COMMAND);
>
>         /* Start decoding! */
>         writel(RKVDEC_INTERRUPT_DEC_E | RKVDEC_CONFIG_DEC_CLK_GATE_E |
> -              RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E,
> +              RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E |
> +              RKVDEC_H264ORVP9_ERR_MODE,
>                rkvdec->regs + RKVDEC_REG_INTERRUPT);
>
>         return 0;
> @@ -1183,10 +1184,26 @@ static int rkvdec_h264_try_ctrl(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
>         return 0;
>  }
>
> +static int rkvdec_h264_check_error_info(struct rkvdec_ctx *ctx)
> +{
> +       struct rkvdec_dev *rkvdec = ctx->dev;
> +       int err;

u32?

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> +
> +       err = readl(rkvdec->regs + RKVDEC_REG_H264_ERRINFO_NUM);
> +       if (err & RKVDEC_STRMD_DECT_ERR_FLAG) {
> +               pr_debug("Decoded picture have %i/%i slices with errors.\n",
> +                        RKVDEC_ERR_PKT_NUM(err), RKVDEC_SLICEDEC_NUM(err));
> +               return VB2_BUF_STATE_ERROR;
> +       }
> +
> +       return VB2_BUF_STATE_DONE;
> +}
> +
>  const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops = {
>         .adjust_fmt = rkvdec_h264_adjust_fmt,
>         .start = rkvdec_h264_start,
>         .stop = rkvdec_h264_stop,
>         .run = rkvdec_h264_run,
>         .try_ctrl = rkvdec_h264_try_ctrl,
> +       .check_error_info = rkvdec_h264_check_error_info,
>  };
> --
> 2.38.1
>
