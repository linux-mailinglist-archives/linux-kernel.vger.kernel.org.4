Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FF45F5745
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiJEPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJEPOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:14:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8595E65BF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 08:14:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u21so19249685edi.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kFWy1h0GujeKKIt/U4s0Yal8/TAWysVv3EH0DHTh2+I=;
        b=AFAYpcBDaiii63veXKXcAqnDWDy5a/T4lZbVKpjCbWd+v39jKdmMZ/IW2b65A2RQe9
         qQynzx9pFmTsx154M76wNPn0gzv4tJmkw8ZRfVe+xR7n08dKBsTnsfd9ug/dkmJaI1ix
         w6oJuzT/tZfu0m2qtu5aZdLCvpEQaJ+FTzFLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFWy1h0GujeKKIt/U4s0Yal8/TAWysVv3EH0DHTh2+I=;
        b=G9QCMmp894cCN+EWFrszdBbEhiP6f/6en4Davwbecc5R8DxMLE/i4dmhFoJhSXMmbi
         Z215S5MseduMRmQkklVTQR/hG2o+Z/+dcyrgxk9oa/yv25NGH75PwcZC0Pj3VROZ0X2b
         RHE9eUwXxMHhcumxn0nrRiTkmYBUsuwRQEaakGJSPrxWAD6/7yiDYqkuWn5RETBgzrwq
         akvg0NPKLoUwtAws+tUDztdhajBYar2l6/33QUkjT7jrpZhBto6i+2chmmzwuhYlezUb
         KCwW3gKqLq0vUB/jr3RDy0gQ14BWMih3MeK+Hb/U4SfEob0sIm3DjZyjU5stJVaZnogQ
         KDiA==
X-Gm-Message-State: ACrzQf1Xzo7YIHfuao2mYTTwAkXEKPefLp+enSksyO983iHGBxVY0EWf
        wts1iNMNA+O5YLaSdRTtDzcTLVQP71p71vjB
X-Google-Smtp-Source: AMsMyM4cqpz3WoTQfn20QbTZwFCom4P4cyfl9y7oFIkKJCo3IORXrh25VSZhSL73dl4sIIHN/uVlCg==
X-Received: by 2002:a05:6402:5192:b0:459:b6e8:b45c with SMTP id q18-20020a056402519200b00459b6e8b45cmr214570edd.233.1664982878861;
        Wed, 05 Oct 2022 08:14:38 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id x100-20020a50baed000000b00458947539desm4000035ede.78.2022.10.05.08.14.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 08:14:37 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id a3so14147967wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 08:14:37 -0700 (PDT)
X-Received: by 2002:adf:dd0c:0:b0:22e:4bf6:6c08 with SMTP id
 a12-20020adfdd0c000000b0022e4bf66c08mr128514wrm.617.1664982876836; Wed, 05
 Oct 2022 08:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220930042506.2529522-1-jason.yen@paradetech.corp-partner.google.com>
 <CAD=FV=XoyhpoRpQpv5dNYy0qEJcu=JRw=1TKynX-5ecjLJoibw@mail.gmail.com>
In-Reply-To: <CAD=FV=XoyhpoRpQpv5dNYy0qEJcu=JRw=1TKynX-5ecjLJoibw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 5 Oct 2022 08:14:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WuEifohmfUjucwrLAirSGoneovuNDmSCLtLxwQbs-frQ@mail.gmail.com>
Message-ID: <CAD=FV=WuEifohmfUjucwrLAirSGoneovuNDmSCLtLxwQbs-frQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: ps8640: Add software to support aux defer
To:     Jason Yen <jason.yen@paradetech.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 30, 2022 at 7:20 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Sep 29, 2022 at 9:25 PM Jason Yen
> <jason.yen@paradetech.corp-partner.google.com> wrote:
> >
> > This chip can not handle aux defer if the host directly program
> > its aux registers to access edid/dpcd. So we need let software
> > to handle the aux defer situation.
> >
> > Signed-off-by: Jason Yen <jason.yen@paradetech.corp-partner.google.com>
> > ---
> >
> > Changes in v2:
> > - Add aux defer handler
> > - Remove incorrect statements
> >
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> > index 31e88cb39f8a..76ada237096d 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -286,7 +286,6 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
> >         }
> >
> >         switch (data & SWAUX_STATUS_MASK) {
> > -       /* Ignore the DEFER cases as they are already handled in hardware */
> >         case SWAUX_STATUS_NACK:
> >         case SWAUX_STATUS_I2C_NACK:
> >                 /*
> > @@ -303,6 +302,14 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
> >         case SWAUX_STATUS_ACKM:
> >                 len = data & SWAUX_M_MASK;
> >                 break;
> > +       case SWAUX_STATUS_DEFER:
> > +       case SWAUX_STATUS_I2C_DEFER:
> > +               if (is_native_aux)
> > +                       msg->reply |= DP_AUX_NATIVE_REPLY_DEFER;
> > +               else
> > +                       msg->reply |= DP_AUX_I2C_REPLY_DEFER;
> > +               len = data & SWAUX_M_MASK;
> > +               break;
>
> This seems fine to me now. There is nothing too controversial here but
> I'll still give this a few days on the list for anyone else to speak
> up. I'll plan to land it midway through next week unless anything
> comes up.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

As promised, pushed to drm-misc-next:

562d2dd87028 drm/bridge: ps8640: Add software to support aux defer
