Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEAB7487C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjGEPU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGEPU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:20:27 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA026171C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:20:25 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-c49777d6e7aso5686700276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688570425; x=1691162425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZAMOcL8Jye/af3yaSjbrvGPJfLK9qoKybBywpqSYP8=;
        b=jaKnyeXhCzI63IG8PAR3T1afvNEDWJ4QxaglwGJLcLAiMtusHzWDfT3R+7QqeoPZAZ
         9S87eUpSgJkC4oT81fduykICvwaAvcudNefYjQFyUNOfI/gJP9iGPbbXyCqtILscp41s
         fv5eZVSshl+ws7ZrzhiVFxa9pq6drHc48QRv69rDqGaUcSZW7+bApiwqXpNlTifVPhMU
         35+5IkVNuj4ZdR1GwzUggPVoIymBswYkanEgiA9MwzWpMe9z0H+QY4B8zVI/HO7DWnsg
         IsvPUqF7Z4CCu6eOTjFX7WDZxHxX3eTu7pDz0rc2KhrYKd5SuPNEWPB5s7iZXJmWZfmv
         rjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688570425; x=1691162425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZAMOcL8Jye/af3yaSjbrvGPJfLK9qoKybBywpqSYP8=;
        b=Z6TBTFzDp1w64TvbSIvHZ2vlsPrHHOAITgA1hoyxPd9zphcT8T1YFpuqPMga7xPpvH
         6o/VDzWFl9lgoQSLInm6fMakfVyBqS8pC7V2wDKvovIkWgB0g9FtOvO0sKKthtgX8JCB
         qKa1C5qANoo4drjn31ml2zFe7NezmZK3+TgMdT5IchArEl28oeNWNhKydSFG742rqC1R
         ExwTTTHy7Zf6r5jUfTUqFsFmne5nR59KZDN8Znxao/PsI07zE9aAKd2FAk5pBESs5QAu
         URPAXe7Fbfd6M5u654K96Pg0Ue3MhmRMdpaDCmYCqbd/XkHjC1SN3Jn/LLw4xxODzqah
         MKKw==
X-Gm-Message-State: ABy/qLY0Wjg3JqvMF1nnoSSZzqxg8IANFPAvKTIaf2Q5uMVdXdVmZeWc
        ihXqmxeqktnO9yuUw/bZxY0ik3vJL1HZiAEL13o3Rw==
X-Google-Smtp-Source: APBJJlHk1vpTA5uaLaRclVjz1s9mRQt4WsK64OE9PqAsFvnK685YLuTLjbg0z+TgfGketcZHx+yKUNgzIr+d1TtcNtU=
X-Received: by 2002:a25:bbc2:0:b0:bff:3a4:2354 with SMTP id
 c2-20020a25bbc2000000b00bff03a42354mr17196399ybk.42.1688570425038; Wed, 05
 Jul 2023 08:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
 <brmrqeajbq3oyp3jjwmc6tuhiftz764u6az444xw6g7pwf5fr3@5tlp375qwhed>
 <617c8f8a-1fc7-c6a0-eaa5-ce75ff2adc1b@linaro.org> <CAA8EJppG=MAVpK1J_8bNnkJ23y9NtgY7a2GVResXJvhEKyNsrw@mail.gmail.com>
 <739a8bd9-9ff0-5072-fdae-b64efdf86842@collabora.com> <e927cfcd-bf34-5daf-0e24-4dd828106968@linaro.org>
 <epds77sccy4cc5cdpoc4ir7sfz5sz3biwep6rbks2nuyqncidu@77gb4t2wy6vn>
 <47a5678c-1eb3-dfc2-a9ac-f8e497455d11@linaro.org> <unsithzszj7awvsmxwr7reshso5ju7u4nssil5tty6pocictf5@gwoltpgeecer>
 <6e070141-8c0e-59ed-8a08-58c3fadb17df@linaro.org> <lidknise4copce3vb2wth4z3fl2p4npsc4u6ajqb6zsp6lnpca@rp6wxcmy2aa4>
In-Reply-To: <lidknise4copce3vb2wth4z3fl2p4npsc4u6ajqb6zsp6lnpca@rp6wxcmy2aa4>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 5 Jul 2023 18:20:13 +0300
Message-ID: <CAA8EJpq_VeY=44FqYm7QAT32AR=rmMOV0RtAfNFkb1hpSp29dw@mail.gmail.com>
Subject: Re: RFC: DSI host capabilities (was: [PATCH RFC 03/10] drm/panel: Add
 LGD panel driver for Sony Xperia XZ3)
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 at 17:24, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Wed, Jul 05, 2023 at 04:37:57PM +0300, Dmitry Baryshkov wrote:
> > > > >
> > > > > Either way, I'm not really sure it's a good idea to multiply the
> > > > > capabilities flags of the DSI host, and we should just stick to the
> > > > > spec. If the spec says that we have to support DSC while video is
> > > > > output, then that's what the panels should expect.
> > > >
> > > > Except some panels supports DSC & non-DSC, Video and Command mode, and
> > > > all that is runtime configurable. How do you handle that ?
> > >
> > > In this case, most of the constraints are going to be on the encoder
> > > still so it should be the one driving it. The panel will only care about
> > > which mode has been selected, but it shouldn't be the one driving it,
> > > and thus we still don't really need to expose the host capabilities.
> >
> > This is an interesting perspective. This means that we can and actually have
> > to extend the drm_display_mode with the DSI data and compression
> > information.
>
> I wouldn't extend drm_display_mode, but extending one of the state
> structures definitely.
>
> We already have some extra variables in drm_connector_state for HDMI,
> I don't think it would be a big deal to add a few for MIPI-DSI.
>
> We also floated the idea for a while to create bus-specific states, with
> helpers to match. Maybe it would be a good occasion to start doing it?
>
> > For example, the panel that supports all four types for the 1080p should
> > export several modes:
> >
> > 1920x1080-command
> > 1920x1080-command-DSC
> > 1920x1080-video
> > 1920x1080-video-DSC
> >
> > where video/command and DSC are some kinds of flags and/or information in
> > the drm_display_mode? Ideally DSC also has several sub-flags, which denote
> > what kind of configuration is supported by the DSC sink (e.g. bpp, yuv,
> > etc).
>
> So we have two things to do, right? We need to expose what the panel can
> take (ie, EDID for HDMI), and then we need to tell it what we picked
> (infoframes).
>
> We already express the former in mipi_dsi_device, so we could extend the
> flags stored there.
>
> And then, we need to tie what the DSI host chose to a given atomic state
> so the panel knows what was picked and how it should set everything up.

This is definitely something we need. Marijn has been stuck with the
panels that support different models ([1]).

Would you prefer a separate API for this kind of information or
abusing atomic_enable() is fine from your point of view?

My vote would be for going with existing operations, with the slight
fear of ending up with another DSI-specific hack (like
pre_enable_prev_first).

>
> > Another option would be to get this handled via the bus format negotiation,
> > but that sounds like worse idea to me.
>
> Yeah, I'm not really fond of the format negociation stuff either.


[1] https://lore.kernel.org/linux-arm-msm/20230521-drm-panels-sony-v1-8-541c341d6bee@somainline.org/

-- 
With best wishes
Dmitry
