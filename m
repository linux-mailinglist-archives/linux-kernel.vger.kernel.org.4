Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1005EAC13
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiIZQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiIZQGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:06:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C598AE6D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:54:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e18so9415494edj.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OTQQafdYKhVU1CUsDylDEUFWuB5UKeHQ3P3f0D343jA=;
        b=X6Szd4P/Y8jrSapH1KfrBEHwbfRvaED1elbdcHIybIcX91cqAaGu6dZ/eOe+tzg293
         zpFOIyVPnPMqeC/flsaOreo467LTT3LrymCWDidJDQbuSIODXju0BkdUUaHkwCOoz+Em
         Y6rL//DxT+GlC3zFaaAvqKB02/zFVU7Sr5CFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OTQQafdYKhVU1CUsDylDEUFWuB5UKeHQ3P3f0D343jA=;
        b=OZdbT2V/5UOlKLj68YztutvbgZGvtNUhrPX4p3HhLDGiUrxJZswRpfnfLq4gRq8ztx
         PPjjeg/5NFO5WM6roVrHXWvpFC/Pe6vPHxSGufgZKTbCKd4P0tGAyWrzN2RfhtuzVnYi
         K4KKbP79IlCe/Ov3d9MBal0KfrKE1OrrRm4VNl+P7dlHw63rmi3EpCRRKen5lgiffXxj
         iKPfeQjTWGhNTzkXl1QyeXoS4yVtOp6zbPPFPWslVb1ZDNdKRzo9FAgSexdMtZQYKjhc
         9AN6tUdJ3DCCzImahduAzAW0FK9FMdZkZ0/zTWrP0zs5Emkc0UxTiZ1YbrIPlUHc+OSU
         bvCw==
X-Gm-Message-State: ACrzQf3dsDUe4OnA7lASwJyFJwXecfPgh+/3+auSRllxlc3ep0NstOez
        aQKjUT9I3ZhVojNzJHdzDcgZIL4EHke/PmiY
X-Google-Smtp-Source: AMsMyM41yA8n7re3JLIPyAVWj6ab1Z480Oi7SazK+SkEFkHcINoOAMGy9SpjPOda9FwJUCx0WwjN/Q==
X-Received: by 2002:aa7:d293:0:b0:457:65d:c0cb with SMTP id w19-20020aa7d293000000b00457065dc0cbmr11529587edq.25.1664204072850;
        Mon, 26 Sep 2022 07:54:32 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906538600b0077f324979absm8452765ejo.67.2022.09.26.07.54.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:54:32 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id cc5so10635379wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:54:31 -0700 (PDT)
X-Received: by 2002:a5d:6488:0:b0:22b:3b0b:5e72 with SMTP id
 o8-20020a5d6488000000b0022b3b0b5e72mr12684396wri.138.1664204071442; Mon, 26
 Sep 2022 07:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220926100839.482804-1-sean.hong@quanta.corp-partner.google.com> <CAD=FV=U1iUHBbA52Jr2mV5JSvTeipTZ3DuAS9mJ6gitBDwp8UQ@mail.gmail.com>
In-Reply-To: <CAD=FV=U1iUHBbA52Jr2mV5JSvTeipTZ3DuAS9mJ6gitBDwp8UQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 26 Sep 2022 07:54:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WOTBvBKh2LqX08pBh2HyJ_ORbLyuwcy5zFOwzUYqFYHw@mail.gmail.com>
Message-ID: <CAD=FV=WOTBvBKh2LqX08pBh2HyJ_ORbLyuwcy5zFOwzUYqFYHw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add INX N116BCA-EA2
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 26, 2022 at 7:39 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Sep 26, 2022 at 3:08 AM Sean Hong
> <sean.hong@quanta.corp-partner.google.com> wrote:
> >
> > Add support for the INX - N116BCA-EA2 (HW: C1) panel
> >
> > Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > index 060f4f98bc04..ba75fae7d376 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -1889,6 +1889,7 @@ static const struct edp_panel_entry edp_panels[] = {
> >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
> >
> >         EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
> > +       EDP_PANEL_ENTRY('C', 'M', 'N', 0x1154, &delay_200_500_p2e80, "N116BCA-EA2"),
> >         EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
>
> This patch doesn't apply cleanly. You should be posting it against the
> top of drm-misc-next to make it easy to apply.
>
> In this case the merge conflict was trivial so I've fixed it and pushed it but:
> * Other folks applying patches won't do this.
> * If a patch is more complicated, I won't do this either.
>
> In any case, this is now in drm-misc-next as:
>
> c7bcc1056cff drm/panel-edp: Add INX N116BCA-EA2

Actually, though I've applied this change, while I was picking things
to the downstream ChromeOS tree I was reminded about a patch that
Chen-Yu landed recently:

https://patchwork.freedesktop.org/patch/msgid/20220908085454.1024167-1-wenst@chromium.org

I suspect that the two Innolux panels that you added recently need the
same treatment. Can you please post a patch for that? Said another
way: I think all of the Innolux panels that are using
"delay_200_500_p2e80" should switch to "delay_200_500_e80_d50"

Thanks!
