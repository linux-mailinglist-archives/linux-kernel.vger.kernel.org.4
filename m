Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3B472EA92
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjFMSKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbjFMSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:10:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D233019B1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:10:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-97454836448so821110866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686679799; x=1689271799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3Po5spbpb4nIlZOQHtySXaHRCrpmcN+t2eknJKAn38=;
        b=j+TQQaIqISC+ws6oemEm7jkGMJEbYY13uvvVNl8F67whHXCrt3kPc5KppeGcA8bt0J
         AaxujUF7CtvkJJsCLcsUqQNVK9EjTlPMat37zZ6JwPFdOA5mpMNTz2u/jYvflWGRx3dC
         flD5JJYBThGmpGDTcTPk8xIhjXl2kDm0ouXJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686679799; x=1689271799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3Po5spbpb4nIlZOQHtySXaHRCrpmcN+t2eknJKAn38=;
        b=ESYiqTuMy/PMcd1oIemH+lJMYdQ57kj5dgtpnJwha6YL+XOwAfhgV1RoeLhyRZkrhr
         v+3MjMbZq7CVs3tEzlgTbdzDBpCmxGwNvyk3Sh1w6rCH1UREKUeVjE5tO+4mWI049G70
         MBJ9TFxenFUZX4F8aN3pSDD/OVVxIE0yr488wAiURkAPkW0IRl5/O/TEQSYyF3sswaTP
         +y0SA2ugRaThMSvAWnLPcRdtO5WONJyu0PdoiofabxQh7OKrrrcLY8PigKAWdHUsSWpK
         nuApjPnQKAWPwbULgkcyx1/oApuyO2jrGWnuq3MUs/VzkLkCXs62b2851ccS4F0vO6Vr
         iNcQ==
X-Gm-Message-State: AC+VfDzUp8FdwGF4cxTk3udHO0zy1aN77A4votAgJSrQbJf9QvYGEhbn
        1O9uFCcyJGbZ6B7ARioNcZoEtrgqeU1YtTr/w8JPWPPT
X-Google-Smtp-Source: ACHHUZ4w8b93lsYhXH/AZn6h2dxIKahsvMcjjwhYNVgTpLxKLvqFHPzOTsx16w8CZ90mE2lNs+Ug5w==
X-Received: by 2002:a17:907:2d29:b0:94a:74c9:3611 with SMTP id gs41-20020a1709072d2900b0094a74c93611mr13514178ejc.35.1686679798828;
        Tue, 13 Jun 2023 11:09:58 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id lw4-20020a170906bcc400b009787209732esm7041661ejb.143.2023.06.13.11.09.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:09:56 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-514ad92d1e3so1460a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:09:55 -0700 (PDT)
X-Received: by 2002:a50:bac8:0:b0:507:6632:bbbf with SMTP id
 x66-20020a50bac8000000b005076632bbbfmr952ede.6.1686679795562; Tue, 13 Jun
 2023 11:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230608012443.839372-1-suhui@nfschina.com> <CAD=FV=WqmqaKXG20MuMwjwyR-8deFF7+chqphN=hiJ05mfC=HA@mail.gmail.com>
In-Reply-To: <CAD=FV=WqmqaKXG20MuMwjwyR-8deFF7+chqphN=hiJ05mfC=HA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 13 Jun 2023 11:09:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V=+L-x8PP3jHO7i+=s+Fb9cRAwj9JMzLJvDQryrOk9DQ@mail.gmail.com>
Message-ID: <CAD=FV=V=+L-x8PP3jHO7i+=s+Fb9cRAwj9JMzLJvDQryrOk9DQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge: ti-sn65dsi86: Avoid possible buffer overflow
To:     Su Hui <suhui@nfschina.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, andersson@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        u.kleine-koenig@pengutronix.de
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

On Thu, Jun 8, 2023 at 8:15=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Wed, Jun 7, 2023 at 6:25=E2=80=AFPM Su Hui <suhui@nfschina.com> wrote:
> >
> > Smatch error:buffer overflow 'ti_sn_bridge_refclk_lut' 5 <=3D 5.
> >
> > Fixes: cea86c5bb442 ("drm/bridge: ti-sn65dsi86: Implement the pwm_chip"=
)
> > Signed-off-by: Su Hui <suhui@nfschina.com>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/br=
idge/ti-sn65dsi86.c
> > index 7a748785c545..4676cf2900df 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -298,6 +298,10 @@ static void ti_sn_bridge_set_refclk_freq(struct ti=
_sn65dsi86 *pdata)
> >                 if (refclk_lut[i] =3D=3D refclk_rate)
> >                         break;
> >
> > +       /* avoid buffer overflow and "1" is the default rate in the dat=
asheet. */
> > +       if (i >=3D refclk_lut_size)
> > +               i =3D 1;
> > +
>
> Looks great now, thanks!
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Unless someone beats me to it or objects, I'll plan to commit this to
> drm-misc-fixes early next week.

Pushed to drm-misc-fixes:

95011f267c44 drm/bridge: ti-sn65dsi86: Avoid possible buffer overflow
