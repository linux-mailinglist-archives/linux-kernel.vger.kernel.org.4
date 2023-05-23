Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F0A70DD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjEWNcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEWNcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:32:45 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10ABE9
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:32:43 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-331430faba8so1873035ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684848763; x=1687440763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO7uVfTZIwTK5eWidHNY3IE4aDCiaYIaf7Mtd0r6B0Y=;
        b=DnYbbxF8qWvdVMmjdAIOmFm/8GXYYrr+L+3jVS4o5/ftLIaCAA7GyXMraADoLxCa7b
         YFobYJODZ6BwDSjiPrwXbN5jjmHgi0Iqv1BCRydt37gKEX2KwRFSkmSnoq/9sWCud7zx
         2ZevSqOVnSEei+es+V1DzYU1apxZfOGr9/l+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684848763; x=1687440763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qO7uVfTZIwTK5eWidHNY3IE4aDCiaYIaf7Mtd0r6B0Y=;
        b=G7ZRjqN3f/zdxe8vRL5+joiXzsv3wOXoeVMs/GNTLE41SBhw6FqcdBnxtkDvYgtLco
         sGkR3hzS9dISfAovf5ZBpChSeWVYdrCI+RWGbhEZ9MbKP1EDYUJizFN/AY0GbWqk8UXd
         Flxxeo3K37Ks4wAA8i+S+ScdIKVCGahX9248k8zPSoF0AS8n8Nngjzr8HAAS19em0O68
         a68dPvbsAdfDdPX9+dmj+qCds8WVhE8vh62G9V+JgjgVesBhGR5Ag1iQnbc7V8mo1VFB
         ZSaa4a/S+q7FcYp55kpsOd3k+A8bKu/hs3+A2Lo2yZ3Epe8aAdpwvkDNspdYWTfnAU0o
         4qgw==
X-Gm-Message-State: AC+VfDxvPIzrKR8RJpTIly84PsWLV91ODt2kbcmYheaK5fFvy/niRh5J
        fWhLUmXfJ2mP5Q1Orrvtpe9QnOKx9FdOqb9zF78=
X-Google-Smtp-Source: ACHHUZ7QuoI+Z0DTXFy8smR5pjO30aSayOA3cCazqF4LvaqXyL7XpZgSFXaZq6gpJXVTNDxNJ4HF/Q==
X-Received: by 2002:a92:c011:0:b0:33a:7100:81ee with SMTP id q17-20020a92c011000000b0033a710081eemr505072ild.11.1684848763049;
        Tue, 23 May 2023 06:32:43 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id bo14-20020a056638438e00b00418af04e405sm190058jab.116.2023.05.23.06.32.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 06:32:42 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-33828a86ee2so168365ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:32:42 -0700 (PDT)
X-Received: by 2002:a05:6e02:1d0f:b0:329:333e:4e79 with SMTP id
 i15-20020a056e021d0f00b00329333e4e79mr252495ila.1.1684848762023; Tue, 23 May
 2023 06:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230427035656.1962698-1-fshao@chromium.org> <CAD=FV=XVubT-ozs7JssBPz+9UcsZb+q0My8Aq6HNs-nFiJnogg@mail.gmail.com>
 <nycvar.YFH.7.76.2305231510270.29760@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2305231510270.29760@cbobk.fhfr.pm>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 May 2023 06:32:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UyEw5xViGreQb6+cLNLrMcT27ts5P87aR=FEYWNOBM_w@mail.gmail.com>
Message-ID: <CAD=FV=UyEw5xViGreQb6+cLNLrMcT27ts5P87aR=FEYWNOBM_w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Fix Goodix touchscreen power leakage for MT8186 boards
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Fei Shao <fshao@chromium.org>, Jeff LaBundy <jeff@labundy.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, May 23, 2023 at 6:11=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> On Fri, 19 May 2023, Doug Anderson wrote:
>
> > > These changes are based on the series in [1], which modified the
> > > i2c-hid-of-goodix driver and removed the workaround for a power leaka=
ge
> > > issue, so the issue revisits on Mediatek MT8186 boards (Steelix).
> > >
> > > The root cause is that the touchscreen can be powered in different wa=
ys
> > > depending on the hardware designs, and it's not as easy to come up wi=
th
> > > a solution that is both simple and elegant for all the known designs.
> > >
> > > To address the issue, I ended up adding a new boolean property for th=
e
> > > driver so that we can control the power up/down sequence depending on
> > > that.
> > >
> > > Adding a new property might not be the cleanest approach for this, bu=
t
> > > at least the intention would be easy enough to understand, and it
> > > introduces relatively small change to the code and fully preserves th=
e
> > > original control flow.
> > > I hope this is something acceptable, and I'm open to any better
> > > approaches.
> > >
> > > [1] https://lore.kernel.org/all/20230207024816.525938-1-dianders@chro=
mium.org/
> > >
> > > Changes in v4:
> > > - Minor coding style improvement
> > >
> > > Changes in v3:
> > > - In power-down, only skip the GPIO but not the regulator calls if th=
e
> > >   flag is set
> > >
> > > Changes in v2:
> > > - Use a more accurate property name and with "goodix," prefix.
> > > - Do not change the regulator_enable logic during power-up.
> > >
> > > Fei Shao (2):
> > >   dt-bindings: input: goodix: Add "goodix,no-reset-during-suspend"
> > >     property
> > >   HID: i2c-hid: goodix: Add support for "goodix,no-reset-during-suspe=
nd"
> > >     property
> > >
> > >  .../bindings/input/goodix,gt7375p.yaml           |  9 +++++++++
> > >  drivers/hid/i2c-hid/i2c-hid-of-goodix.c          | 16 ++++++++++++++=
+-
> > >  2 files changed, 24 insertions(+), 1 deletion(-)
> >
> > Just double-checking if there is any work needed on this series. I
> > think it's ready to land but I wanted to double-check.
>
> I don't think I've been CCed on the dt-binding part (patch 1/2 I guess).
> Has it been Acked? If so, I will happily take it through hid.git, but
> please send it my way.

Yeah, Rob Acked it:

https://lore.kernel.org/r/168261692866.3205353.5077242811275926416.robh@ker=
nel.org/

Fei: can you repost the series with collected tags and make sure to CC Jiri=
?

Thanks!

-Doug
