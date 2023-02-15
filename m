Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF02697F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjBOPYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjBOPYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:24:33 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F5186A1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:24:32 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-16e2c22c3baso6774082fac.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TadElbv/yECNyRvG0Pa2vpl29upi4rkpMkJRcewsa7k=;
        b=suGbtRbva9mfsiS7LLNx13Qf0OsA9bc4rRjOkogLlK5PHAndCm/2000O593bVAfNf/
         xhOdda5c+ELAQMSxZTkfuSXJNR2+nRui+95nMQBWRQsz1Pi8XjPRsay1cW7L3ddi0x6N
         nfVr7EjSjgyyL/DdR2HlYEqRWaUGwit3MSkgYIDgXgBf+rb9zYfU5mBxMIVANBS/HjGT
         i9WzCuXmnCEJCv07wvufZUhXrFMu7OUSH9tWTM8KU+ykyrVa8OpBfXEjbEThDtys6Y87
         cli2MqN2J6bAscc++INea8g3hkk2xNtczFkn54zsnIZLswfmJiDuOSOc5QQn9f9Zigqw
         eVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TadElbv/yECNyRvG0Pa2vpl29upi4rkpMkJRcewsa7k=;
        b=pjkqJMWmtNMeqWX6NG05LK/N8YgwI2BS5cyDIfhPE5aSUKQ5ZmrGaU0uY00o5/HSXE
         UTHWd0Weoz6zPoZZJkE5XqZpWNpILjP5YRe5RKOKkOmo1NWuDYKPSdTqDcPeIcQvFmCW
         V63UMm8+NUB/AZ5XBqiUdFc+HZxB0arZKE4kSyLTFhgykzXLtzUwft3u/PEc0gCid5bt
         bwynFELDN0prEQpXvRx57u3Wt0n9PBnBcvxg3G7eCVQDDjmRAbEi1Z1qISjeacRd++pB
         JiTOiH9JomtTzHvnBc3+J4NpmEY/p47gP1wVE2wNrCeQ05MHs5Lmp3nF8NIz+f0TViHu
         EHiw==
X-Gm-Message-State: AO0yUKX4iknQZFX04C4/9nRr6EKorz2IdG6+SUN2V5HGME7KfnCwBWj9
        6GsJtrbxKA6vl+xYICjXfHySsteLDV2vFWxqY5Bxag==
X-Google-Smtp-Source: AK7set89dOBFzBa3roM7yTkRgWk8K9U1srlYYE4cn1E4jBK5Jx6T2MYTeWX22QqOnM8AabgZmdbBdRcqAPmxGXlBDHI=
X-Received: by 2002:a05:6871:9a:b0:16e:44ad:c9fb with SMTP id
 u26-20020a056871009a00b0016e44adc9fbmr362093oaa.82.1676474670678; Wed, 15 Feb
 2023 07:24:30 -0800 (PST)
MIME-Version: 1.0
References: <c2040bf3cfa201fd8890cfab14fa5a701ffeca14.1676466072.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <c2040bf3cfa201fd8890cfab14fa5a701ffeca14.1676466072.git.christophe.jaillet@wanadoo.fr>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Wed, 15 Feb 2023 09:24:19 -0600
Message-ID: <CAJe_Zhf9E49MkySeqoSFsuy7=j8vmjngda60GEUzTTSNMjj0LA@mail.gmail.com>
Subject: Re: [PATCH] spi: synquacer: Fix timeout handling in synquacer_spi_transfer_one()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 07:01, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> wait_for_completion_timeout() never returns a <0 value. It returns either
> on timeout or a positive value (at least 1, or number of jiffies left
> till timeout)
>
> So, fix the error handling path and return -ETIMEDOUT should a timeout
> occur.
>
> Fixes: b0823ee35cf9 ("spi: Add spi driver for Socionext SynQuacer platform")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> ---
>  drivers/spi/spi-synquacer.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
> index 47cbe73137c2..dc188f9202c9 100644
> --- a/drivers/spi/spi-synquacer.c
> +++ b/drivers/spi/spi-synquacer.c
> @@ -472,10 +472,9 @@ static int synquacer_spi_transfer_one(struct spi_master *master,
>                 read_fifo(sspi);
>         }
>
> -       if (status < 0) {
> -               dev_err(sspi->dev, "failed to transfer. status: 0x%x\n",
> -                       status);
> -               return status;
> +       if (status == 0) {
> +               dev_err(sspi->dev, "failed to transfer. Timeout.\n");
> +               return -ETIMEDOUT;
>         }
>
>         return 0;
>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

thanks
