Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A93715AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjE3J7A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 05:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjE3J64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:58:56 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9AA102;
        Tue, 30 May 2023 02:58:49 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5664b14966bso28903967b3.1;
        Tue, 30 May 2023 02:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685440728; x=1688032728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WSkehpACbIBkuvPEqFsXs2d/6yWL321TN10hmtC+Jg=;
        b=KnHNtBP25sM7TGn2UT+1wPmqEKbqiQfLzEa3lWsknCLUc4am2lQFR/pnEE/d9CCUqz
         gFwstweUJicjv8H0WxQPW3UaV9sH4AWEept6Fe9uSXNBxTi4xWjPkbVuF5xTW+LneVJN
         s7ln9fHxa2Xz3SliKdPXmX7xJUKhjWWSX6uk88JYTVWbjQSRFgVjqvJgYhVjPULeUfql
         nHeAs4p8JpqCPCUo7oNwywuMWTEiJlaxL+oKVHWXkhAOakfViuFelRnkuHDf9vHl1Va6
         ZPw0x/a12g2Sgn68lmkSd579zWwhNvTOmlQVxvaFWm2ygu+qBh/zge/nn88QTnnxU/UM
         T+pQ==
X-Gm-Message-State: AC+VfDx62HiQHodhd8MKMzCvqhUJBgYJrJgXlSjlMzA53g1ukn94gBiV
        WYiQyIUl4HdyCPQM9tFpnqJTPKt8zINElg==
X-Google-Smtp-Source: ACHHUZ7d1rrI+2ZXOORb+PSg08PjbGfw/yB2w4Cji3hPQ7cJWemWEU62Q4oGdrajon0MSbh92xr+kg==
X-Received: by 2002:a0d:db42:0:b0:561:e561:9fd7 with SMTP id d63-20020a0ddb42000000b00561e5619fd7mr1707228ywe.39.1685440728369;
        Tue, 30 May 2023 02:58:48 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id o15-20020a81de4f000000b00568bc0bbf8esm619116ywl.71.2023.05.30.02.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 02:58:47 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-ba829e17aacso6031913276.0;
        Tue, 30 May 2023 02:58:47 -0700 (PDT)
X-Received: by 2002:a25:1585:0:b0:b9e:7ec8:5d45 with SMTP id
 127-20020a251585000000b00b9e7ec85d45mr1954396ybv.55.1685440727022; Tue, 30
 May 2023 02:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230515131353.v2.cover@dianders> <20230515131353.v2.2.I88dc0a0eb1d9d537de61604cd8994ecc55c0cac1@changeid>
 <CAMuHMdWM_t7uQqkesM3fnSK7THrmLszA7U54==A0-98xPH90Bw@mail.gmail.com> <868rd6cfsy.wl-maz@kernel.org>
In-Reply-To: <868rd6cfsy.wl-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 May 2023 11:58:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6E9JR9A1LxzXMWS8o06L7hawQ9e20=ysjeviv+EOrtA@mail.gmail.com>
Message-ID: <CAMuHMdW6E9JR9A1LxzXMWS8o06L7hawQ9e20=ysjeviv+EOrtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] irqchip/gic-v3: Disable pseudo NMIs on Mediatek
 devices w/ firmware issues
To:     Marc Zyngier <maz@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, wenst@chromium.org,
        yidilin@chromium.org, Tinghan Shen <tinghan.shen@mediatek.com>,
        jwerner@chromium.org, Weiyi Lu <weiyi.lu@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, May 30, 2023 at 11:46 AM Marc Zyngier <maz@kernel.org> wrote:
> On Tue, 30 May 2023 09:29:02 +0100,
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, May 15, 2023 at 10:16 PM Douglas Anderson <dianders@chromium.org> wrote:
> > > Some Chromebooks with Mediatek SoCs have a problem where the firmware
> > > doesn't properly save/restore certain GICR registers. Newer
> > > Chromebooks should fix this issue and we may be able to do firmware
> > > updates for old Chromebooks. At the moment, the only known issue with
> > > these Chromebooks is that we can't enable "pseudo NMIs" since the
> > > priority register can be lost. Enabling "pseudo NMIs" on Chromebooks
> > > with the problematic firmware causes crashes and freezes.
> > >
> > > Let's detect devices with this problem and then disable "pseudo NMIs"
> > > on them. We'll detect the problem by looking for the presence of the
> > > "mediatek,broken-save-restore-fw" property in the GIC device tree
> > > node. Any devices with fixed firmware will not have this property.
> > >
> > > Our detection plan works because we never bake a Chromebook's device
> > > tree into firmware. Instead, device trees are always bundled with the
> > > kernel. We'll update the device trees of all affected Chromebooks and
> > > then we'll never enable "pseudo NMI" on a kernel that is bundled with
> > > old device trees. When a firmware update is shipped that fixes this
> > > issue it will know to patch the device tree to remove the property.
> > >
> > > In order to make this work, the quick detection mechanism of the GICv3
> > > code is extended to be able to look for properties in addition to
> > > looking at "compatible".
> > >
> > > Reviewed-by: Julius Werner <jwerner@chromium.org>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - mediatek,gicr-save-quirk => mediatek,broken-save-restore-fw
> >
> > Thanks for your patch, which is now commit 44bd78dd2b8897f5
> > ("irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/
> > firmware issues") in v6.4-rc4.
> >
> > This causes enabling an unrelated workaround on R-Car V4H:
> >
> >     GIC: enabling workaround for GICv3: Cavium erratum 38539
> >
> > > --- a/drivers/irqchip/irq-gic-common.c
> > > +++ b/drivers/irqchip/irq-gic-common.c
> > > @@ -16,7 +16,11 @@ void gic_enable_of_quirks(const struct device_node *np,
> > >                           const struct gic_quirk *quirks, void *data)
> > >  {
> > >         for (; quirks->desc; quirks++) {
> > > -               if (!of_device_is_compatible(np, quirks->compatible))
> > > +               if (quirks->compatible &&
> > > +                   !of_device_is_compatible(np, quirks->compatible))
> > > +                       continue;
> > > +               if (quirks->property &&
> > > +                   !of_property_read_bool(np, quirks->property))
> > >                         continue;
> >
> > Presumably the loop should continue if none of quirks-compatible
> > or quirks->property is set?
>
> Indeed, thanks for pointing that out. Can you give the following hack
> a go (compile tested only)?
>
> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
> index de47b51cdadb..7b591736ab58 100644
> --- a/drivers/irqchip/irq-gic-common.c
> +++ b/drivers/irqchip/irq-gic-common.c
> @@ -16,6 +16,8 @@ void gic_enable_of_quirks(const struct device_node *np,
>                           const struct gic_quirk *quirks, void *data)
>  {
>         for (; quirks->desc; quirks++) {
> +               if (!quirks->compatible && !quirks->property)
> +                       continue;
>                 if (quirks->compatible &&
>                     !of_device_is_compatible(np, quirks->compatible))
>                         continue;
>
> If that works for you, I'll queue it ASAP.

Thanks, that fixes the issue for me on Renesas White-Hawk (R-Car V4H).
No regressions on Koelsch (R-Car M2-W) and Salvator-XS (R-Car H3 ES2.0).
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
