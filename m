Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE5461FF4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiKGUOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiKGUN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:13:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6103240B5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:13:48 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 4so12130929pli.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yBX7bP/gwxEljJXsETpLzrWEKb+h/tZlh4zFSZMZ+JM=;
        b=EaWLlRUfN99T1tpwYDtLn1udAavbXE3Ox/meorFJyzbYEI6uv5Q3iBRCLH4MC0ouvR
         OyuXiU8XhXJrR8VDe6WSoWhMKO3Vudqp2S2gFTV73n6OP3HpAEMwbU7uJftI9fbN3RI3
         1kGihthIWlgyCjVRCFI4W6m2MADND+w66zQAgcUU7caxuSQrI8hfv3fqjkWANZaffiJ4
         ytVdUEpG9TRt7hbTly4BZiTSX3DCheF/VRlZ+T/SXUxF7QnaGFNyL1p+/Bl8e/YT/cp2
         sn/BgMK9ZXQ+OBA8rXPytijbMa2ZGtAVReWOdlni2ivXG2IsP652Q0DbWyLAYEdX0Ais
         W7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBX7bP/gwxEljJXsETpLzrWEKb+h/tZlh4zFSZMZ+JM=;
        b=ZM6B4at8Rl57qgPuU80Moixoxsd1Soq7TjgoB+BxU5wZ8ggjQwQl8OPjnRvWMW9kxK
         3H1hwaqsAv9HIwN97LcH4fMwugcBKTlW5bp6YPGSYAkl8P5Qao05B6eVDYdnPPSVEj19
         C7u3cQJqu3d4dHBtU02ogNwXVa7BBgmh5pXUtPuSKSTpBY0HVRg/1Qz8AFXFSuRKG6gl
         8Ho8Ie8dmyE9PfDw1/x8wuFpIM8tPcs48NrDe7pbTcSRT8+5vXEWropgm2cB6Ocwc+NE
         KFnHrkt3GEkAyMyy32T7bLqaRbrY1rVtMB9v0Dpxh1mOsg+2q8T5VdF4WXJfu4Fh5SsK
         fkFQ==
X-Gm-Message-State: ACrzQf2qsnAlHcLU0S1CJUCSjqwyvtxJW9DSFAIWDBd4FGW6iEGi3nrx
        Y4ZNB87nDOwn5RM/edp6fVPFxvKKE8M65IXT+NbC3w==
X-Google-Smtp-Source: AMsMyM68Scjlv1d33YvplbBEG04Ll6paEM/4IYsDTKIsyW2w8AjsJkizX7m5+A/n3VE4oIgJ+FwK37z0+ldsvRXaRQY=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr53387571plb.148.1667852028404; Mon, 07
 Nov 2022 12:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20221101105242.2019036-1-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20221101105242.2019036-1-matthias.schiffer@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:13:11 +0100
Message-ID: <CAPDyKFoknFVzuF=uuR+NccPa3KjwjeEkkaYM6BA0UQya1BkQFg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: Use dev_err_probe() for mmc_of_parse()
 return code
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 at 11:53, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> Checking phandle references like mmc-pwrseq can result in -EPROBE_DEFER.
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 8f1023480e12..4e17efa8ab97 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -835,7 +835,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(host->mmc);
>         if (ret) {
> -               dev_err(dev, "parsing dt failed (%d)\n", ret);
> +               dev_err_probe(dev, ret, "parsing dt failed\n");
>                 goto pm_runtime_put;
>         }
>
> --
> 2.25.1
>
