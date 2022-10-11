Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208F05FB4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJKOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJKOlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:41:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805D05141C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:41:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id b2so13372374plc.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VPSVqJz387vGX+lndeFLaz7/WMZ4XtC2ycr+jawg9P8=;
        b=mQnj4MjlGH8JCAAKVdx0ZM4mg4T+VBUJRL1PF6iiHzJBxFr7gaFI1MpVEsVgPsuw/P
         hkjU5CuHkatbpL/GBc7u4h2oboAuZ/HnHZOgB0SsRZdd4w+s8fidpVdRbpcdLfBajMGv
         MdeQkF2mLL055Eu+mvcH58OX4RUeW0WeqJwjGUVTUufON/NUkj2HIzXDve9c2A+3iXZE
         w93AH+to+qUjIxZ7+DszdS5Imwhd24yyIZsHl7qpm66gZ7KRn/sGzg/cuYiUc9IH7zY/
         +WlPZ1rRezDZVP1y/gpY2mUALMUCzCYUd4/8JwnOQ5yBgcLfBv0Uo6qhXcp+7GKttqC3
         LR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPSVqJz387vGX+lndeFLaz7/WMZ4XtC2ycr+jawg9P8=;
        b=ZkdNt3zXXOKNs+xszpXqX/P4/DjrXP0CpWNa6NaamrAwUZlBa2aGMb7n5iZXFNFnbY
         b0J4b0glQcotagVJtKu9rynmEpqx+BvUuOFQ9DnkD3LMHDFV+VLZHrDuMB9xtn3M36f7
         EtSxp3xGOPu87kx3YGTeAOy5iu+gsUh4EueMyr++HYws4pB7pdiUkCljUgErbJG3XKVB
         zO0CuLIFfbxQKpmX0GfwuzOLUrJhMObeKosZzL8DO3/1/Q9cxpxUBjWtIA202lTvPfwQ
         7/+seC6HTUxZbZ3L7O0OX5caGMXBGWf2yXBc4WAU5X2G59qITrR/QBXwoMOQaOJuCM0k
         +fsQ==
X-Gm-Message-State: ACrzQf28wr6m7OR+LdlICVfP2u97r6jUjMEHbeJM4n7CHDYwmsFSCRbI
        OWbnLUTdrvlXrgbZWM8JD+LD38uApX0K/M3mbFTGTA==
X-Google-Smtp-Source: AMsMyM4iNccU33s454RSlugRql+oKFO3lYmpS0Trlj7q84EoU85aKPx1FToEHnR68k8DGSjMQQESeTqT3eI/n20M4f0=
X-Received: by 2002:a17:902:d714:b0:17f:5813:1df4 with SMTP id
 w20-20020a170902d71400b0017f58131df4mr25485853ply.148.1665499292988; Tue, 11
 Oct 2022 07:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220927020158.1218469-1-ouyangweizhao@zeku.com>
In-Reply-To: <20220927020158.1218469-1-ouyangweizhao@zeku.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Oct 2022 16:40:56 +0200
Message-ID: <CAPDyKFrmg+Q-+-dgOrHFYFf0JKB08pXB-b4MEkYmzE_8zW4s3Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: fix kernel panic when remove non-standard SDIO card
To:     Weizhao Ouyang <ouyangweizhao@zeku.com>
Cc:     John Wang <wangdayu@zeku.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Matthew Ma <mahongwei@zeku.com>,
        Pierre Ossman <drzeus@drzeus.cx>, linux-mmc@vger.kernel.org,
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

On Tue, 27 Sept 2022 at 04:04, Weizhao Ouyang <ouyangweizhao@zeku.com> wrote:
>
> From: Matthew Ma <mahongwei@zeku.com>
>
> SDIO tuple is only allocated for standard SDIO card, especially it
> causes memory corruption issues when the non-standard SDIO card has
> removed since the card device's reference counter does not increase for
> it at sdio_init_func(), but all SDIO card device reference counter has
> decreased at sdio_release_func().
>
> Fixes: 1a632f8cdc33 ("sdio: split up common and function CIS parsing")
> Signed-off-by: Matthew Ma <mahongwei@zeku.com>
> Reviewed-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
> Reviewed-by: John Wang <wangdayu@zeku.com>

Apologize for the delay!

Wow, that's a very old bug you fixed! However, it looks like the fixed
commit should be changed to 6f51be3d37df ("sdio: allow non-standard
SDIO cards").

I tried to apply the patch, but the patch format seems to be corrupt.
Did you use git format-patch and did run ./scripts/checkpatch.pl on
it?

Kind regards
Uffe

> ---
>  drivers/mmc/core/sdio_bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index c6268c38c69e..babf21a0adeb 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -291,7 +291,8 @@ static void sdio_release_func(struct device *dev)
>  {
>         struct sdio_func *func = dev_to_sdio_func(dev);
>
> -       sdio_free_func_cis(func);
> +       if (!(func->card->quirks & MMC_QUIRK_NONSTD_SDIO))
> +               sdio_free_func_cis(func);
>
>         kfree(func->info);
>         kfree(func->tmpbuf);
> --
> 2.25.1
>
