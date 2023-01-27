Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4EF67E263
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjA0K5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjA0K5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:57:38 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4F03A5A0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:57:37 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 78so2981333pgb.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NRNxC7t9AaAGI/XYMONVgmLZnSBjQemSUmZVeQIyo2w=;
        b=syw4ai7K3pU3EOeNBmBDGNaQXP7UWQZaegLh1mKdYcM+eSWNJBYxKcq4dDxWxvSb/A
         G74WzN4GGC5D8zEY45aJb4XSCxYXij+2O8R6aYopCKnQTqdLpxcf0Q2QwbnNTf8NzatJ
         VmCREB+yGiPGwI47ETI+dFi5Dsrk+sVEkqPrDDYTi4uEudqg7zfb1KySnGGoaxQsPWeX
         14Ho6CCUckrSanx5EBcaWokSoGKwaoIkgTlDhkrdg9d1R5e8Un5crqIJvuINkvCJ6RwY
         3G772zDEzVO/4AbcZZxenFnWsA54gZEHLoWbRfUOPsPOxMVDndtwmt81vI23PwLl2oeF
         hzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRNxC7t9AaAGI/XYMONVgmLZnSBjQemSUmZVeQIyo2w=;
        b=wTz3U/KznEeVWia3acjGHHlIgkCIzKu6Ad0HIIi5Xk9GS1rXf79x/DpEsvqCmaRV5M
         42SdeUBWeH6M4ImpzQVHcfqEnG0R52yO3wios0mu9f26DVxkSb4pnCtYFg151pjT5UB/
         wafrGwIB1ZP88U1IjVVKacjSC4rI1crvn+nzaH1X5cHmVq79fORpq0mtph81I758XRaU
         o6x08ghkZw5CURJ1l1IrGUYx/xsw1hZGBiLm1uXxxTWQD3O3+LLW76irYmM/Rr1R/D5D
         0zRnti2mGXvcrGQqAPeT8Jquwp9gZhyweF5lpIieLewW7Vajf8hfY/dbvWxPIBr4Sd+m
         bnGw==
X-Gm-Message-State: AO0yUKXGFtNP64eAl8VC9jpvtIibrLR2Q/Gua5C/WcfWqK5rB4DlNCH+
        5DT0fCu/In2gZGx8X9EhgYd3Cu6xJggShhPfQL+tVQ==
X-Google-Smtp-Source: AK7set8OklhYkTPyqrhcVOZGeyesQoR2GAMjPTL1p0zZ+I/x4vQQ2k5hpuv6igjSA4ImWtFLC/E0gNwWk1i3kvXs1sU=
X-Received: by 2002:a63:e612:0:b0:4da:6c3c:74cf with SMTP id
 g18-20020a63e612000000b004da6c3c74cfmr1050269pgh.10.1674817057044; Fri, 27
 Jan 2023 02:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20221230194315.809903-1-t.schramm@manjaro.org>
 <20221230194315.809903-2-t.schramm@manjaro.org> <54b0dcc0-5083-3ee9-6536-e58b8c01e96c@microchip.com>
In-Reply-To: <54b0dcc0-5083-3ee9-6536-e58b8c01e96c@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Jan 2023 11:57:00 +0100
Message-ID: <CAPDyKFpEuMnfrwCZ74P_zW-Bh3ZB3175aDbVAY1nL=SxWSud-w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: atmel-mci: fix race between stop command and
 start of next command
To:     Ludovic.Desroches@microchip.com, t.schramm@manjaro.org
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, linux-mmc@vger.kernel.org,
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

On Thu, 26 Jan 2023 at 15:44, <Ludovic.Desroches@microchip.com> wrote:
>
> On 30/12/2022 20:43, Tobias Schramm wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > This commit fixes a race between completion of stop command and start of a
> > new command.
> > Previously the command ready interrupt was enabled before stop command
> > was written to the command register. This caused the command ready
> > interrupt to fire immediately since the CMDRDY flag is asserted constantly
> > while there is no command in progress.
> > Consequently the command state machine will immediately advance to the
> > next state when the tasklet function is executed again, no matter
> > actual completion state of the stop command.
> > Thus a new command can then be dispatched immediately, interrupting and
> > corrupting the stop command on the CMD line.
> > Fix that by dropping the command ready interrupt enable before calling
> > atmci_send_stop_cmd. atmci_send_stop_cmd does already enable the
> > command ready interrupt, no further writes to ATMCI_IER are necessary.
> >
> > Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
>
> Hi,
>
> In theory this changes make sense. I'm always afraid when something is
> changed in this driver which handles many version of the IP...
>
> As we never encountered this issue until now, I can't really test this
> fix. I checked on an old board at91sam9m10g45-ek that mmc is still
> working and it's okay.
>
> So
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
>
> Regards,
> Ludovic

Thanks for your ack and thoughts!

It's not clear to me whether the problem is hypothetical or in fact a
real problem. Tobias can you help to fill in here?

Nevertheless I have applied this for next, to allow more testing to be
done. In the meantime, we can discuss whether we should add a stable
tag or leave that to later as manual backports.

[...]

Kind regards
Uffe
