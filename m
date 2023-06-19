Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69FA73560B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFSLnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjFSLnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:43:49 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB3810B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:43:46 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-57015b368c3so27897547b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687175026; x=1689767026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uwqSLWLLuuaB54tU6yiU6JkxvK/2yq0oXCsUMbHlXp4=;
        b=G5OHxQ4sW1J5s3tk1R7PXJ6CvdRkOVyGoz0PKVttD11vxNxmi7QNip0BjmzmYr0RdW
         8ddei/agPzjOeLE9yDn/k+b25zbB9BEpwVrOsQNeukDZzlGgIEnrmPaUu37wNQc/CFEg
         PIc4t+uvosfNRTAn2XyHwf+MeYDQQ1Cb8YuI1UIjaTpcgnu3cnYWER7602vzbJzii1M1
         GFx829bZcSRKR2DDIGJtEjUsh7rQC8TlvsjQlbx1RLp0PUa0XsNOfZL3TSZyQ0yORyqW
         09X4owXQsOs2rkdI9OHHxi9fVC7kPVkquV/TfUQ+y1rxqVgM4WxIXRJ5dzZlqCfNQfjD
         cwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687175026; x=1689767026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwqSLWLLuuaB54tU6yiU6JkxvK/2yq0oXCsUMbHlXp4=;
        b=d9cUq3mBDoGYw1qdXa1rE4ePZVF7u4ssNwEzFI0syyXrt6JYwjr3EedSlt9u7AmGGl
         eKfuECevj6FdgDhvKZPPKTd5EliirzUhcc26Xa/zEXo3UaTFTXf2tCD/TX303FvEeZtH
         iGSmhkOgwtp6yU5nSPZ+W77bZYOq/Py7KEHfaUk+yYTBO5sZ2BN0gOmBtLPpUV+0xt2W
         rN1670YyJbkY8NHcUajrodI6uQCqgI1/joZW2O+XqnBRhtSfMPB8YJ40W8WJmilbBhSH
         Z+XCqLDy05l3ERp/OWLwMVN6jn55EOvgxUosc2msccFC3IR1L3aMHQxQiOz46/GGPPtZ
         Q4bw==
X-Gm-Message-State: AC+VfDzRR4UUFH2mVmy++B/tuAGfVhnK/b/ioszz2ZuZCstygNW1ZQLT
        hQ1y6NayDyf0/aUy5iemONAUBNB53fldIanggv/uoQ==
X-Google-Smtp-Source: ACHHUZ4C1cZpDLmjQnJKl7Od5wdTkYCNUxLNqqNA3XGgU02eEX+6vc1XjZsU4XFV8ETNsGRiodR7BEhVvhmumKdrewI=
X-Received: by 2002:a81:91c1:0:b0:56d:3327:825 with SMTP id
 i184-20020a8191c1000000b0056d33270825mr7274557ywg.48.1687175025972; Mon, 19
 Jun 2023 04:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230617085319.2139-1-jszhang@kernel.org>
In-Reply-To: <20230617085319.2139-1-jszhang@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Jun 2023 13:43:10 +0200
Message-ID: <CAPDyKFr+CW4SU2Q3h16cT52Y=WNa-0VHZXGHObTFmWPBrf8YxQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: litex_mmc: set PROBE_PREFER_ASYNCHRONOUS
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, 17 Jun 2023 at 11:04, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> mmc host drivers should have enabled the asynchronous probe option, but
> it seems like we didn't set it for litex_mmc when introducing litex mmc
> support, so let's set it now.
>
> Tested with linux-on-litex-vexriscv on sipeed tang nano 20K fpga.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Applied for fixes, by adding both a fixes and a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/litex_mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> index 39c6707fdfdb..9af6b0902efe 100644
> --- a/drivers/mmc/host/litex_mmc.c
> +++ b/drivers/mmc/host/litex_mmc.c
> @@ -649,6 +649,7 @@ static struct platform_driver litex_mmc_driver = {
>         .driver = {
>                 .name = "litex-mmc",
>                 .of_match_table = litex_match,
> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>         },
>  };
>  module_platform_driver(litex_mmc_driver);
> --
> 2.40.1
>
