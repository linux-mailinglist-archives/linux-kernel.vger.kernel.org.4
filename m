Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B5E7431D1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjF3AmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjF3AmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:42:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C810810C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:42:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992b2249d82so130129566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688085719; x=1690677719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gb81mYg1YRwOXWbF2VsLlxsYCtOl437hvg6gzGbEbw=;
        b=dU+T+kzhy6oRFhOySjmOnRg0SS1q8JS3h8wj0es9YlruudWRF1sEBlP2vp8fwYhyor
         Nhik3ITmNDrGeP3Iw9390z/hOJkltJeTBukUfagFoJu4TSBKwP5KRiOhS5MFhWcPohyU
         6wK78o0f64WQBX142gm8XOH/rm2Gtr+WJs1hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688085719; x=1690677719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Gb81mYg1YRwOXWbF2VsLlxsYCtOl437hvg6gzGbEbw=;
        b=K4mAGvQVRyghrofTmxFCErW/UpgOImOd0Y127eNpTZBJvMCk3V5CjN+Z8Z7A4rUVUy
         V3LkxhKyOGVkgvxWUW58wPTqwOMJ9+rN/i4QCZ45ENKzTJtIiqZT9z099K0BMV2Egxbd
         HooLy4jQMeAzNC/PEeLubCldFqXhbcArcg/LMe12rCDWrGbQ4RJsMfQFaMfB9KSODeKc
         h7QWq3zIrEmrW8zVEhZMxoC4aBmEy0ARAXsG2SaF0goRXm1tJKkWswillksLK9aYBN5g
         3PgykZXLAbEme0zDAEevApu1rginAjrpjtHm/2SDkvaOW3XqNUhGTfogo9d76ghezxfO
         E/oA==
X-Gm-Message-State: ABy/qLbBYLJLRXjZqcTexDQUwru6PGRJH+stwUUfJx+6klSK3/AHPojd
        7lzj+MC4BSW16V665Sv9R+pKbbu9av3S7U31IG4NGWob
X-Google-Smtp-Source: ACHHUZ7UOfcwaXFbDLxinCoYPgJ3EYpi/G6kNnsA8J5BBiarhZ8ya28ugxm3+NteXuu9/zwjIr0mxA==
X-Received: by 2002:a17:906:4d02:b0:991:e24f:b290 with SMTP id r2-20020a1709064d0200b00991e24fb290mr662628eju.26.1688085719825;
        Thu, 29 Jun 2023 17:41:59 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906085900b0098e42bef736sm6100971ejd.176.2023.06.29.17.41.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 17:41:59 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so2353a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:41:58 -0700 (PDT)
X-Received: by 2002:a50:baaf:0:b0:510:b2b7:8a78 with SMTP id
 x44-20020a50baaf000000b00510b2b78a78mr207972ede.5.1688085718420; Thu, 29 Jun
 2023 17:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230627050148.2045691-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=WR=fnhCxC37Eo3hinh2MV=eTNuXG+GrwgR6K_pV4Rbaw@mail.gmail.com>
In-Reply-To: <CAD=FV=WR=fnhCxC37Eo3hinh2MV=eTNuXG+GrwgR6K_pV4Rbaw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Jun 2023 17:41:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UcFn7Wq_Ock6RCT0mPhgjpJwF7dJjcbwcoESW9nni62Q@mail.gmail.com>
Message-ID: <CAD=FV=UcFn7Wq_Ock6RCT0mPhgjpJwF7dJjcbwcoESW9nni62Q@mail.gmail.com>
Subject: Re: [v2] drm/panel: Fine tune Starry-ili9882t panel HFP and HBP
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        airlied@gmail.com, hsinyi@google.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 27, 2023 at 2:17=E2=80=AFPM Doug Anderson <dianders@google.com>=
 wrote:
>
> Hi,
>
> On Mon, Jun 26, 2023 at 10:01=E2=80=AFPM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > Because the setting of hproch is too small, there will be warning in

I realized that hproch should be hporch. I fixed when applying.


> > kernel log[1]. After fine tune the HFP and HBP, this warning can be
> > solved. The actual measurement frame rate is 60.1Hz.
> >
> > [1]: WARNING kernel:[drm] HFP + HBP less than d-phy, FPS will under 60H=
z
>
> Thanks for including the warming. This looks like something that's
> only printed on Mediatek display controllers. Just out of curiosity:
> is that because Mediatek controllers have special requirements, or is
> this something generic and the Mediatek controller is the only one
> that warns about it?
>
>
> > Fixes: 8716a6473e6c ("drm/panel: Support for Starry-ili9882t TDDI
> > MIPI-DSI panel")
>
> Ideally the tool you have to send mail wouldn't wrap the Fixes line.
> Probably not worth resending just for this, but see if there's
> something you can do to fix this in the future.
>
> Since this is a tiny fix, I don't think we need to wait too long. I'll
> plan to land it on Thursday unless Neil wants to land it himself
> sooner.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

OK, landed. This is a weird time to land since this is a fix and the
fix has already made its way to Linus's tree but -rc1 isn't ready yet.
From reading the flowchart in the committer guidelines:

https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-misc.html

...this means that it lands in drm-misc-next-fixes, so I've pushed it there=
.

59bba51ec2a5 drm/panel: Fine tune Starry-ili9882t panel HFP and HBP

-Doug
