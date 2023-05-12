Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9926FFF31
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 05:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbjELDNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 23:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbjELDNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 23:13:07 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557674C09
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 20:13:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f38a9918d1so911071cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 20:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683861184; x=1686453184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIKWTzsbM0dwoaRf64Qu10v5SQhI6q6nuz1uBIsxu94=;
        b=CZiD6dnpXR2oAYhbHpac52YmOtECTL4PrcNlsQXTrgF2GDZzm8ANvYs2rrcpnVd3NV
         5z155HJ/0J06Rei5Cf24HZgOJQYR6st+Tg1/rMoCN4i2+BZeVq1Y7pEj5VJ9Keb1K+Jb
         JHqBKu+QYZ+lC2QrR3oXhm1Gs4phbHkQ2uAX/3530rGSvZ2N4WX7jIEO6pzd79AS+GlZ
         YGeFF/5kyzighKa3ub7MoxKNuec5DobCIwtfDpN/TM0vhhEFvHvFFd1pkkK9WpFpKcD1
         BrRcFZjc/9CUwz4nDXOMezdK3klAbanNXIlr4FMbmXBwrWnJ9baD20PVsxdzkuaJTlCz
         MlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683861184; x=1686453184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIKWTzsbM0dwoaRf64Qu10v5SQhI6q6nuz1uBIsxu94=;
        b=epFuDDOTE2mXA1uDbq1oVqroWAAAcfOVr0676+i6I2NvknNGsJRq4MUUpZFVufj6k9
         J3/ld+Jfj8GRcSKwkNAnnPCQ2SgKeoLKK/KACWHRd9Wr2ozFLbQ0X60vIB3Ks/jK1200
         YQg0EpkKAE13ettibFb0tCkAiwV0V462BlEZGFCB7oZwQ7UV9CpWNG7q/5qLwdtWvDDk
         16jpdGj3QP+OXAvfPrpj6gFQNXpcg1vL8qTXXybYtUDP1CIN1Unlb7TvWfGoDf9VzaZs
         8dPU7wTKG022S+ExcFwNBQ3tSA8mBcIHlkh/0admIXEPqQDQ5k5ko39JrcWcogQTIigS
         rDoA==
X-Gm-Message-State: AC+VfDxsvuylHOgEqviIxQ+ViVUmcLllvSvNZaY4P8gtd0Gad4UfSlIG
        Nh5Kgc/7QyNYDbW25UwAhkzTCx07YJC03wd3tU/p
X-Google-Smtp-Source: ACHHUZ4JnfrZvOycBzMaW0OjiWrBkQofMMdUE1fG68T2dtRqy4yEJncjgOz87BFIaeD5CkHPdJD1YirX5jVhbZddbYY=
X-Received: by 2002:a05:622a:1812:b0:3ef:1c85:5b5e with SMTP id
 t18-20020a05622a181200b003ef1c855b5emr99445qtc.19.1683861184189; Thu, 11 May
 2023 20:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230419074910.10809-1-walter.chang@mediatek.com> <20230419074910.10809-2-walter.chang@mediatek.com>
In-Reply-To: <20230419074910.10809-2-walter.chang@mediatek.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 11 May 2023 20:12:52 -0700
Message-ID: <CANDhNCoNXO7phZj4zjpMWCA2OsK3EgTUenUuX0z-KAejgqu1Dg@mail.gmail.com>
Subject: Re: [PATCH linux-next v3 1/4] time/sched_clock: Export sched_clock_register()
To:     walter.chang@mediatek.com
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 12:49=E2=80=AFAM <walter.chang@mediatek.com> wrote:
>
> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>
> clocksource driver may use sched_clock_register()
> to resigter itself as a sched_clock source.
> Export it to support building such driver
> as module, like timer-mediatek.c
>
> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>

Sorry for the late reply, I was traveling when I got your mail.

Thanks for your iterations on this series.
I'm ok with these, assuming the folks who maintain the timer-mediatek
driver don't have any more objections.

So for the first three patches:
Acked-by: John Stultz <jstultz@google.com>

thanks
-john
