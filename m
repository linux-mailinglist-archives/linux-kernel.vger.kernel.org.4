Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D10715880
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjE3I3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjE3I3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:29:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F85AD
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:29:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-973f8dbcc02so398840766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685435344; x=1688027344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrXV2pSkwAI+QAXUpRLRnlNnNfkWLFknVTLvl7bQmX8=;
        b=lD3LAqKUXnALaMMaXaoS9HvK65/b60q5KOMPNJKXq4x/yjBc62HmKwf3o9Ek9/zvHQ
         nSej9wJvmbV3bfAgAXlJTPbSihgkBsaVaLZWW84ogmPbszEAkkyRAsbDxX7QkaaR05wm
         Atu6SSxV+a1M+hAEsIrb1SZCYFf9sbuljS8M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685435344; x=1688027344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrXV2pSkwAI+QAXUpRLRnlNnNfkWLFknVTLvl7bQmX8=;
        b=VrCecsaFmu4DaIwl3TgvGQBSbuXxHefvpoRA1xoPcnQBXQDgqSP3UGxNYNezQCVUA2
         XbxBPI5lGgC4esbQdc2tcY1NeveNGUU8kduyScr+jPaEf1MhRXKmCxlsKhu3mYeH2TJm
         GvpC2Jjyz5gbrMaDhgcLyKoNMgx2Vn8B4lGQ2Zg329z/xN0GWnKcsTQV+Iig4hmnH5/k
         CPDTLJSQhtlCmOL3nN7PuLIAdMgPAO3MzFBfnkfR6pQ8VnXAvciZdFQcg/kZYVFJnW9/
         D4ocwGqrQTCDyD3o5af+ln9Aj/9DWHilEZO6N7dnl37fC5GVRdhhLmzmqsJLweysacsF
         kyVw==
X-Gm-Message-State: AC+VfDwVS8q81huD8q4wQQjsW8Mbyx2P2+QkUpCAG3ohky0wKHtXNQIa
        zbt93xF73tHunWceuEysFqfPXDq17KKulYNND3U=
X-Google-Smtp-Source: ACHHUZ6dBoG7RUsMBLeCTA54Fxttru0Iqu97x2yCPZaReH3pj7c5I6evEdvGjTIw4X1wzy5QwpGgWg==
X-Received: by 2002:a17:907:94d1:b0:96a:f09b:373e with SMTP id dn17-20020a17090794d100b0096af09b373emr1797081ejc.15.1685435344329;
        Tue, 30 May 2023 01:29:04 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id lz13-20020a170906fb0d00b0094f67ea6598sm7042329ejb.193.2023.05.30.01.29.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 01:29:02 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f6e68cc738so28179165e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:29:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3787:b0:3f6:1e6:d5a2 with SMTP id
 o7-20020a05600c378700b003f601e6d5a2mr946577wmr.4.1685435341339; Tue, 30 May
 2023 01:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230518115258.14320-1-shuijing.li@mediatek.com> <0ff74fff-9e48-e2a6-617c-13d4cfc2e157@gmail.com>
In-Reply-To: <0ff74fff-9e48-e2a6-617c-13d4cfc2e157@gmail.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Tue, 30 May 2023 16:28:24 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhVrbaAh2u7rG-=-RubsxTZvMBRZO-t0NA8jG7M8187EA@mail.gmail.com>
Message-ID: <CAC=S1nhVrbaAh2u7rG-=-RubsxTZvMBRZO-t0NA8jG7M8187EA@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: mtk_disp: Fix the disable flow of disp_pwm
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Shuijing Li <shuijing.li@mediatek.com>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 6:43=E2=80=AFPM Matthias Brugger <matthias.bgg@gmai=
l.com> wrote:
>
>
>
> On 18/05/2023 13:52, Shuijing Li wrote:
> > There is a flow error in the original mtk_disp_pwm_apply() function.
> > If this function is called when the clock is disabled, there will be a
> > chance to operate the disp_pwm register, resulting in disp_pwm exceptio=
n.
> > Fix this accordingly.
> >
> > Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
>
> We are missing a fixes tag here.
> Fixes: 888a623db5d0 ("pwm: mtk-disp: Implement atomic API .apply()")
>
>
> with that:
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Tested-by: Fei Shao <fshao@chromium.org>

>
> > ---
> > Changes in v2:
> > Use
> > if (A && B) {
> >       something();
> > }
> > instead of
> > if (A) {
> >       if (B) {
> >               something();
> >       }
> > }
> > per suggestion from the previous thread:
> > https://lore.kernel.org/lkml/20230515140346.bxeu6xewi6a446nd@pengutroni=
x.de/
> > ---
> >   drivers/pwm/pwm-mtk-disp.c | 13 +++++--------
> >   1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> > index 79e321e96f56..2401b6733241 100644
> > --- a/drivers/pwm/pwm-mtk-disp.c
> > +++ b/drivers/pwm/pwm-mtk-disp.c
> > @@ -79,14 +79,11 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >       if (state->polarity !=3D PWM_POLARITY_NORMAL)
> >               return -EINVAL;
> >
> > -     if (!state->enabled) {
> > -             mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->ena=
ble_mask,
> > -                                      0x0);
> > -
> > -             if (mdp->enabled) {
> > -                     clk_disable_unprepare(mdp->clk_mm);
> > -                     clk_disable_unprepare(mdp->clk_main);
> > -             }
> > +     if (!state->enabled && mdp->enabled) {
> > +             mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN,
> > +                                      mdp->data->enable_mask, 0x0);
> > +             clk_disable_unprepare(mdp->clk_mm);
> > +             clk_disable_unprepare(mdp->clk_main);
> >
> >               mdp->enabled =3D false;
> >               return 0;
>
