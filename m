Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EAB67B933
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbjAYSWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbjAYSWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:22:21 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A2659B4D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:22:18 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id h10so6936304ilq.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mQQ+b96bYTR/JdRx7lqvrfEUi55TNY9dz9cLJO4CiN8=;
        b=hisavarov1w5W1Psgb6++dahB/QO8VQceskeeHhNEm2K/HYSKp/ek8PCJtXp5Wcr7I
         gJFlg88ced3rjDWxpZLZlh/bdYD+xNek2hkD9nRMPGgLq0qNwF2kw70+d4/sZ14DS3NS
         F2cWRxngYJBjSmkvGBwxoNC3WL7bXBOpRqabY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQQ+b96bYTR/JdRx7lqvrfEUi55TNY9dz9cLJO4CiN8=;
        b=1tUwDQkZ96pGSemik1ExmvoXkVSdPVVK44ZlESir45m0S0OEoAV1tgedN6O7DcHeix
         2veCvv8t6haD/pd2r0EEtuheYG5/pD6V+07PkOiV7oK+ijvlKUG0P3dH02txfb0Mm8G3
         ho9J6rjbiP0/WnD+R8+C2iLKR8+RTHNkTCcfP4AS1Do9UJ5b3wQYIviOLFX/UH46ItOc
         eqGGEEzPUMOt0/RWmy/FJNoeDkVPnmD7e+BohTM9JePenOlVMoBoXW2bwOEucK+uUQWb
         EfGx9SetLVj8FP7QPQU83NG2Hvf3nFJoGTsDC9sUhSr35H8rGY0nmG5hWbSPJPYO7Iq6
         HqPA==
X-Gm-Message-State: AO0yUKWvgSX3YAqbqG8XHIfr2SFtrYGWfiWOC8E7vF2h366e8kWe4asc
        4Cro09dGj+eawWsOe36GUwUIUHbJT+uS3b0H
X-Google-Smtp-Source: AK7set8bYv+TVLVKa1ygBb0b8nY3hJXaX2kUZjCyWQbIRx3er6w2WzoqavPIvRBOh5sq1ig6fHsLCg==
X-Received: by 2002:a05:6e02:1d0d:b0:310:a137:b6f5 with SMTP id i13-20020a056e021d0d00b00310a137b6f5mr3196365ila.16.1674670937352;
        Wed, 25 Jan 2023 10:22:17 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id j5-20020a056e02218500b0030bfdb6ef60sm1688921ila.58.2023.01.25.10.22.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 10:22:15 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id c66so3432308iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:22:15 -0800 (PST)
X-Received: by 2002:a05:6638:2727:b0:374:f967:4187 with SMTP id
 m39-20020a056638272700b00374f9674187mr4302979jav.130.1674670934658; Wed, 25
 Jan 2023 10:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20230119145248.1.I90ffed3ddd21e818ae534f820cb4d6d8638859ab@changeid>
 <20230119145248.2.I2d7aec2fadb9c237cd0090a47d6a8ba2054bf0f8@changeid> <f08b04b2-3fdd-38f5-6402-16c57a3322d2@quicinc.com>
In-Reply-To: <f08b04b2-3fdd-38f5-6402-16c57a3322d2@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 25 Jan 2023 10:21:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WHH5=NZPWSyu6P0HVMpSJK_53=S6PgyjJZCKz8-dE1rg@mail.gmail.com>
Message-ID: <CAD=FV=WHH5=NZPWSyu6P0HVMpSJK_53=S6PgyjJZCKz8-dE1rg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm/dp: Return IRQ_NONE for unhandled interrupts
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 25, 2023 at 9:22 AM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> > -void dp_ctrl_isr(struct dp_ctrl *dp_ctrl)
> > +irqreturn_t dp_ctrl_isr(struct dp_ctrl *dp_ctrl)
> >   {
> >       struct dp_ctrl_private *ctrl;
> >       u32 isr;
> > +     irqreturn_t ret = IRQ_NONE;
> >
> >       if (!dp_ctrl)
> > -             return;
> > +             return IRQ_NONE;
> >
> >       ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
> >
> >       isr = dp_catalog_ctrl_get_interrupt(ctrl->catalog);
> can you add (!isr) check and return IRQ_NONE here to be consistent with
> dp_aux_isr()?

I could, though it doesn't really buy us a whole lot in this case and
just adds an extra test that's not needed. Here it should be easy for
someone reading the function to see that if "isr == 0" that neither of
the two "if" statements below will fire and we'll return "IRQ_NONE"
anyway.

...that actually made me go back and wonder whether we still needed
the "if" test in dp_aux_isr() or if it too was also redundant. It
turns out that it's not! The previous patch made dp_aux_irq() detect
unexpected interrupts. Thus the "if (!isr)" test earlier is important
because otherwise we'd end up WARNing "Unexpected interrupt:
0x00000000" which would be confusing.

So unless you or others feel strongly that I should add the redundant
test here, I'd rather keep it off. Let me know.

-Doug
