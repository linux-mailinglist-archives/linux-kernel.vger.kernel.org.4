Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D17B6E3D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDQCE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDQCEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:04:25 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F852713;
        Sun, 16 Apr 2023 19:04:20 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id bh10so15796409oib.1;
        Sun, 16 Apr 2023 19:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681697060; x=1684289060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhlRw2flRMu975A3JbCU7a2y9nFvCns8mnW/r0SkONU=;
        b=hcwWFzki0bum/erFGL6+bD180673sovTpBFmYV+eq2MeaPJjxQToPv4LgGt79PFpc5
         LC8ZyFcen/ebQJ1dqMb+yqDVhIoroOUpgzwR6RTeTM/KnDQnxy9gAt3y/sTRlCR51Yqi
         5wVQpJtNmne+BkolUZaPVpUJRfbgqtEvMBSviiWfse7Ikcjaa6TWRFsB2c/uycjAECDA
         Bb1WyzeG8/3oKaw10bODc3cqvTN7qzFws5E5g7Pj1XdB4j1ksmEN7fly1yApQi05hkT4
         fIXNla2PRBoExL+XlMIRvyCmSPVDcFQQJUP4SByEBGyI6gGRYkbBCf6w5alugFzqJIvg
         tKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681697060; x=1684289060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhlRw2flRMu975A3JbCU7a2y9nFvCns8mnW/r0SkONU=;
        b=EcC4UvEjQgbu/HUe2SET/qNeXNrnlW29nA+LF1jnBQ/avmS4aoiICVojkKCndCzOwg
         htVpGX7ChYsyzVuDQ+DfutWsadRSZtEwqCGC7xDd+e5MZt0XCMw0T9LCcWTj5vF5wTDu
         bbXaoEAXzxbaLhXYJll43VGchF8YcimfEJqZDJpEzfC91C8NxpZMGOav8NXSm4qxatc0
         +irWoGAlAwZfU6uDfYwOTIZ6TduOxPi74JWpdWfBkaVWtp1QmLpDSO4lUwryKuC9+pgM
         ms5CTTq9ez87h5BK9DyGYryO4rAadQ/lo0LYNCZaVYZI+TcyZBjyBjaN3w0YMcxn03F1
         34Lw==
X-Gm-Message-State: AAQBX9e3LaPM9xbmROYNDaHgbiostmwD3sKU2VABrk22ynOD8GvWYTb3
        zyUV4Be79hh6Qt7NObR7J3p6FtvdqJEY9UR6bP4=
X-Google-Smtp-Source: AKy350YRoH9pqwtU8HlnWfAXisZPaKLNAL7FCEdMRNHgTBFAiyMNhLihCtCjCKEx9NMH2xPoTr2fB8dMV1zQNdp8sEo=
X-Received: by 2002:a05:6808:110:b0:378:74af:45ef with SMTP id
 b16-20020a056808011000b0037874af45efmr2276143oie.11.1681697060100; Sun, 16
 Apr 2023 19:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230412055852.971991-1-dddddd@hust.edu.cn>
In-Reply-To: <20230412055852.971991-1-dddddd@hust.edu.cn>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Mon, 17 Apr 2023 10:04:08 +0800
Message-ID: <CAL411-qGHzMPopY_5u3r5Nu8NHYVaqU6JNKaGryqFjNPtoFUvQ@mail.gmail.com>
Subject: Re: [PATCH] usb: chipidea: fix missing goto in `ci_hdrc_probe`
To:     Yinhao Hu <dddddd@hust.edu.cn>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Peter Chen <peter.chen@freescale.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 2:01=E2=80=AFPM Yinhao Hu <dddddd@hust.edu.cn> wrot=
e:
>
> From the comment of ci_usb_phy_init, it returns an error code if
> usb_phy_init has failed, and it should do some clean up, not just
> return directly.
>
> Fix this by goto the error handling.
>
> Fixes: 74475ede784d ("usb: chipidea: move PHY operation to core")
> Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  drivers/usb/chipidea/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 281fc51720ce..25084ce7c297 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -1108,7 +1108,7 @@ static int ci_hdrc_probe(struct platform_device *pd=
ev)
>         ret =3D ci_usb_phy_init(ci);
>         if (ret) {
>                 dev_err(dev, "unable to init phy: %d\n", ret);
> -               return ret;
> +               goto ulpi_exit;
>         }
>
>         ci->hw_bank.phys =3D res->start;
> --
> 2.34.1
>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
