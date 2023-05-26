Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE8711FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242045AbjEZGPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbjEZGO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:14:58 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B43125
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 23:14:57 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3381a0cae92so3535745ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 23:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685081696; x=1687673696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qi7D9mvtZvdngBJp97OBVBXhgpmVbWBZr97BGMtinqs=;
        b=QbEACKO6ccH3MPiTtpcel0oqQM6z5K91a36oAP+s6lVgt9JS7k2R2rLNudgD+8vzS0
         BL5tb90LqLRnR6QuqaSdn1pBpJqkYmBIYyQZVZMQf3KFXS64EY11ECCD5ix9XOmnyxIx
         mFJCF0niwZqWQOuQ+5gzcDnmOL+5ZwlFpqu6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685081696; x=1687673696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qi7D9mvtZvdngBJp97OBVBXhgpmVbWBZr97BGMtinqs=;
        b=SB4QtR1QT4V/D0wVxxvBijFVfsStyEHak/lcDcag7hQGJjM5DEnrKF8M3R4TPXyPyg
         LeqjsVIKReYLdFIPgHvvnoKtzpbxERcdDs4IrIsybrPvAsSn0isKPLhOeGoutvlAD1Wm
         eaKCXCkis9HiruLPgX0itjeVC//ayC9B1H3R8TcrzUQMynIqW/7fMypm740m6isdHKLo
         HgTN8CpFpeRpLXeFg5cBc4vWJ1VYj/asdP5tW7+SRjPuKOLUuW21NbW0g8cEYM/lfpc+
         wlKFCA3wTcytXbBWmxtwpzzz6dFPnxQodFr69qNZGnDf9NpVUEUt8D75y39waUYEWcpA
         2PdQ==
X-Gm-Message-State: AC+VfDyH5/S3TkSt3agO0PEQP1StjuE+HmDuDyskMBrpl+wy1QDdHtvb
        MOFePt2UGL4TDTwoDIzGLYExZ9LEf3U4/CRvehxh/w==
X-Google-Smtp-Source: ACHHUZ5FwfBds24ldh80wDy8EcOs+yRHNoW67/ghdIa4MVk9kkBlHtdpjIo0Co/rJ7v/ARevPx/+p9aV+PcNPIWm6O8=
X-Received: by 2002:a92:c00d:0:b0:331:1f0e:79b7 with SMTP id
 q13-20020a92c00d000000b003311f0e79b7mr822785ild.3.1685081696748; Thu, 25 May
 2023 23:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230417123956.926266-1-treapking@chromium.org> <CAD=FV=VoC2gK5MtBU9qhVxJwRRUGBMLT96UH7F+QKcmGEYo_sQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VoC2gK5MtBU9qhVxJwRRUGBMLT96UH7F+QKcmGEYo_sQ@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 26 May 2023 14:14:45 +0800
Message-ID: <CAEXTbpeGm4wt_FFGDawfxKo9L4dvFw++=WiiucWcaR39VFPfvQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8173: Power on panel regulator on boot
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Doug Anderson <dianders@chromium.org>
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

Friendly ping on this patch.

Pin-yen

On Mon, Apr 17, 2023 at 9:32=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Apr 17, 2023 at 5:40=E2=80=AFAM Pin-yen Lin <treapking@chromium.o=
rg> wrote:
> >
> > Add "regulator-boot-on" to "panel_fixed_3v3" to save time on powering
> > the regulator during boot.  Also add "off-on-delay-us" to the node to
> > make sure the regulator never violates the panel timing requirements.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > ---
> >
> >  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
