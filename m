Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4B74A5BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjGFVMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjGFVMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:12:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402C7B2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:12:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so1815504e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688677932; x=1691269932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qR0sM2hjfRkNS+kcQpmfcfZeAyiRf9lyyLVHf0bxWKk=;
        b=fCRsEJ9y2USgZ5j7Lf6j1r8NLjt0SRZhHHg9LOjeMrRrdmm2YWNiJa4IDQ6Ct4YIl/
         /dya8xef2jpuf03uN1pv4+uYBtVZ+eWO50lB5FfyN+9V21JWrn4iqSi2xKfcZptsl2hp
         tlpkcugGapCAAGO6UofODBLUNuL4K/eWzxE4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688677932; x=1691269932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qR0sM2hjfRkNS+kcQpmfcfZeAyiRf9lyyLVHf0bxWKk=;
        b=cL+Fd9WzHgyrcSo0VOAKuPtk0G4hM7L+uYM+bPhg1MmxeRyKuFEcvyVMZG2LWU8bCu
         07i400kTXTEGlDCx9iWAtnFeln6HPEj29TK4md01yE8Qx3/kwjeDWzlETja3mlyWOSvz
         sA3XqEiTm3NTS3uoJvdMHNURa0Skxdg0Vsme6Ca19/HJutt72myZ3VwsmzG+m4nJ5gIZ
         jOaBULzu+YnbPZAMjtTYquu3Hl97kdcQzWE98+PoccMojI4pRQghIsVAYPxgk+zsAmoI
         QVkN+OVPjm4pZJ+yF4MHQNoBKcWcYc2ciAupi3krIYF4QMkAzj2HirP66dxFX9f1TS91
         du7g==
X-Gm-Message-State: ABy/qLaXgZ/AZTJ+szBOrH4g0L0GM55X1lI0ZZpGwMpDJ5a+2ThKEtvx
        BeecVZ3tS1Olb9Q7aieeZEgrvQoQXveDmfgp2upyq77r
X-Google-Smtp-Source: APBJJlFBdV89DJT40dX4+Y+YPoPnFxnRsB3bsnHiUbYNgWwMu1jvlvGB9PHbOdUR7Z65il3GvFJSMA==
X-Received: by 2002:a05:6512:114b:b0:4f9:ec5e:d624 with SMTP id m11-20020a056512114b00b004f9ec5ed624mr2844838lfg.38.1688677931864;
        Thu, 06 Jul 2023 14:12:11 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7df85000000b0051bed60f333sm1177118edy.48.2023.07.06.14.12.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 14:12:11 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so1038a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:12:11 -0700 (PDT)
X-Received: by 2002:a50:bac6:0:b0:50b:c48c:8a25 with SMTP id
 x64-20020a50bac6000000b0050bc48c8a25mr26008ede.6.1688677930844; Thu, 06 Jul
 2023 14:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org> <20230703-fix-boe-tv101wum-nl6-v3-2-bd6e9432c755@linaro.org>
In-Reply-To: <20230703-fix-boe-tv101wum-nl6-v3-2-bd6e9432c755@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Jul 2023 14:11:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V=f-AMrzoOseYFbYQjcwE9_m5SDeeAtg6JVmgw+c8ejA@mail.gmail.com>
Message-ID: <CAD=FV=V=f-AMrzoOseYFbYQjcwE9_m5SDeeAtg6JVmgw+c8ejA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/panel: boe-tv101wum-nl6: Drop surplus prepare tracking
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 3, 2023 at 6:22=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> The DRM panel core already keeps track of if the panel is already
> prepared so do not reimplement this.
>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 12 ------------
>  1 file changed, 12 deletions(-)

It does? Can you please point to where/when the DRM panel core keeps
track of this? I know I've posted a patch for this at:

https://lore.kernel.org/r/20230607144931.v2.2.I59b417d4c29151cc2eff053369ec=
4822b606f375@changeid

...but I haven't landed it because I'm still trying to get consensus
on the rest of the series and a later patch in the series depends on
it.

If you have some evidence that my patch isn't needed, can you please
point at it in the commit message? I would say at least that someone
else seemed to agree that the core wasn't checking this [1], though I
guess it's possible that person was running old code or was just as
confused as I was.

[1] https://lore.kernel.org/r/646e391f.810a0220.214ce.d680@mx.google.com

-Doug
