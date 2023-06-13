Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E713A72E5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjFMO0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242908AbjFMO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:26:27 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A232EE7D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:26:24 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bc4651e3838so3805991276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686666384; x=1689258384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7YsOURhyh/Tjgm6K44C4j1/BOMFErPA6rkAL2pqMH/M=;
        b=dO0jZ8gXTo3yU8ybfY7BIiWEeernqFV8gOIXG3ZOxjQ1er0RIEpHc3LsnEPgowgnS5
         ZQ7n/TqSP83laRH1ib2ddCSl+1L6MiGjKzz65UZw3rgSK92kMQpprHmW80AhNmy1vXrF
         bwRwMc8sWyrbocp1FypKwm+w6TaSPAL8TPu7Wmpg/cbC1qePDjNIpqaDD5+UUt10Ja1O
         s8vRYbGo1Q/joUhvxd9R1Q6QOURnUHDDxFHQvTWqBw9x5tRaxr5BXOl14MRGouVerl/D
         f6ImA7glXvoaimnPCrII9WSbykE2vU6wOLFq/eRW6RDckbqyybYfFrvgj/NJH5yNIK7g
         M8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686666384; x=1689258384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YsOURhyh/Tjgm6K44C4j1/BOMFErPA6rkAL2pqMH/M=;
        b=bleWzQWCaQGslu1RU9cz/CYOCdJB6v44eR//NYa63HMPHm8Ka1jhLPm+Al5xfuvdqM
         O6QqadNaj7rnQrdtERkDSqzLZ4WXeqq/mHUuQ7CBiR/zczRQs8K4hfHKFQhu1HseRhSQ
         C0OL7NtzoIgSPOVXLEI/N580uwidLSqT7UBgfszrPmpuY1rfK0vDXagOOALsPiKMgq9+
         zM/i08iFRv3ztlIWf8fZU1Sb+UISb4KpB8VJc06+68lsTUCRjL8WHCaYJ06QAnlMGjNM
         O1wlw8lVbsfy2Wa+otthcpPL04u9rXgqCiNCGnWNscinQ0ksG1plRQywbv+ZLu9JFFu2
         22UA==
X-Gm-Message-State: AC+VfDwPFtoJ47eOa2ru+Fd1TlNMjb7qSIJIR3Vj9S9TE5MoSSr8pooo
        WUOZe/A7i0ha2mKyHsL8oCuRDAbhdz9mpn9fFe/YjQ==
X-Google-Smtp-Source: ACHHUZ4vISjM1jMiXDK60ZMB4vg3NrX7dHb5fNlJxtHrs7GejYR8ouJM9RCwhrzX4G4YpWdS5t3nffqYf7mk1SLWA9k=
X-Received: by 2002:a25:9085:0:b0:bcd:ba93:55b1 with SMTP id
 t5-20020a259085000000b00bcdba9355b1mr1658122ybl.43.1686666383783; Tue, 13 Jun
 2023 07:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230613134146.418016-1-yann.gautier@foss.st.com>
In-Reply-To: <20230613134146.418016-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 13 Jun 2023 16:25:47 +0200
Message-ID: <CAPDyKFrN1Dau5eCjhK9h193ZtKrzTHFndG4WR9jCheEVhdfa8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: fix max busy timeout calculation
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dennis Zhou <dennis@kernel.org>
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

On Tue, 13 Jun 2023 at 15:42, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> From: Christophe Kerello <christophe.kerello@foss.st.com>
>
> The way that the timeout is currently calculated could lead to a u64
> timeout value in mmci_start_command(). This value is then cast in a u32
> register that leads to mmc erase failed issue with some SD cards.
>
> Fixes: 8266c585f489 ("mmc: mmci: add hardware busy timeout feature")
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index f2b2e8b0574e8..696cbef3ff7de 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1735,7 +1735,8 @@ static void mmci_set_max_busy_timeout(struct mmc_host *mmc)
>                 return;
>
>         if (host->variant->busy_timeout && mmc->actual_clock)
> -               max_busy_timeout = ~0UL / (mmc->actual_clock / MSEC_PER_SEC);
> +               max_busy_timeout = U32_MAX / DIV_ROUND_UP(mmc->actual_clock,
> +                                                         MSEC_PER_SEC);
>
>         mmc->max_busy_timeout = max_busy_timeout;
>  }
> --
> 2.25.1
>
