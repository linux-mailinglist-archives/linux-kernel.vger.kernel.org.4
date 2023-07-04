Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F081E746B05
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjGDHro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGDHrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:47:19 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993D410D9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:47:01 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso5902176276.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688456820; x=1691048820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRkvpRfMuOlSLRipkiu8Jze1f6nATDLcC9Hl3jUoeDQ=;
        b=Cqx18F0N47ar3DMEAXrXv9rl0+r4nk7G3XIVZRj+2UatRbWk2pkiJ9fKNXd1oP8qjq
         4XGs4CS5/ocs96OdReTui+io6Q2RUlZ2xxAxeEfoNbFw56P4i3S1lZhx6voqo8pd4ZdQ
         b/z4MqyLg8Lk25P+fCUbRY5CLKhcdCYyP1VaofG31awCT1pligE7xlPpR9vrV2FAtAB8
         hrTY3OLE3iGxJDe19xFGHJKZrbGQbgeVnZQZ1LO88hXcP8k+t1rKS1uSbiU2YmEBku1z
         zhrV/EdGR6Ifa04qAC0UcP4bA69IZzAjaNuqfw6hl7caT3ETmaYRF7TCVLwGVDifp70u
         65rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688456820; x=1691048820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRkvpRfMuOlSLRipkiu8Jze1f6nATDLcC9Hl3jUoeDQ=;
        b=YeOsxsx9dN0gy5yRop+pfbynYg4rovO0aOYIWDiR6pt1O7QGyrwrIRjuBqCzWK5j48
         v9L4MdpNyXGWdXmTXtDUU8N2n4jX225RtezMtCUtQFY4GxXOikGekJvUtaDzWTX+tN/K
         dbWiX9wxVi9tE8UZvhCuBBqulhoKuYxK7hVGZUZnHTDouoEk9jJxIlOpJIZE5WlMJrpk
         2Zaz4HgWJrUea8RroTK3lZyeVs5AUJ4dvkwcyBS6+pyejZ4MpNaMNj2gJ/mjqap3A4Ke
         yfpQ1zQ1mFgpO3JRUO/CJzYP26lfLIgchUunwiteKOvQHcfaMw18YJi+dVSgKfqGimZ5
         6l1A==
X-Gm-Message-State: ABy/qLbmCx/QnAnacek3NnQ3TfE5CkJiQ5DZ6VCWZwBsSHQ27+4JlJys
        5+z0CP+u1072zkH+4TpHdmoVlUXaTU1yZ8+1KF+f6g==
X-Google-Smtp-Source: APBJJlEOVYLwvS3+qiYbXUZ3wW+zZMGMoOzX9B+2fCT/SfdKHpfvSIDaTLdVEL1H0hSnyYGdkqZBANWlryRDoYIKA2I=
X-Received: by 2002:a25:a8a:0:b0:bcb:9b43:5a89 with SMTP id
 132-20020a250a8a000000b00bcb9b435a89mr11258112ybk.61.1688456820597; Tue, 04
 Jul 2023 00:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <1adda828-cf35-fb2c-6db5-f9ca91b5b62a@linaro.org>
 <20230525093151.2338370-1-yangcong5@huaqin.corp-partner.google.com>
 <20230525093151.2338370-5-yangcong5@huaqin.corp-partner.google.com> <CAD=FV=W_Vw=WTuap60PtzU8Jc58T1PsEhJfY96NmFFgmC1DB9w@mail.gmail.com>
In-Reply-To: <CAD=FV=W_Vw=WTuap60PtzU8Jc58T1PsEhJfY96NmFFgmC1DB9w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Jul 2023 09:46:49 +0200
Message-ID: <CACRpkdZkNio99zS+ttEXncOtS1TcYbfunKSKddErRDV1gTY43w@mail.gmail.com>
Subject: Re: [v4 4/4] drm/panel: Support for Starry-ili9882t TDDI MIPI-DSI panel
To:     Doug Anderson <dianders@google.com>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        neil.armstrong@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, sam@ravnborg.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        hsinyi@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 5:55=E2=80=AFPM Doug Anderson <dianders@google.com> =
wrote:
> On Thu, May 25, 2023 at 2:32=E2=80=AFAM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > The Starry-ili9882 is a 10.51" WUXGA TFT panel. which fits in nicely wi=
th
> > the existing panel-boe-tv101wum-nl6 driver. From the datasheet,MIPI nee=
d
> > to keep the LP11 state before the lcm_reset pin is pulled high. So add
> > lp11_before_reset flag.
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 371 ++++++++++++++++++
> >  1 file changed, 371 insertions(+)
>
> Applied to drm-misc-next:
>
> 8716a6473e6c drm/panel: Support for Starry-ili9882t TDDI MIPI-DSI panel

Sorry for noticing too late and coming after the fact and complaining.

We must stop using the panel-boe-tv101wum-nl6.c driver as a
one-stop-shop for Chromium panels. The Starry panel in particular
hardware-wise has nothing in common with the other panels in this
driver and I'm suspicious about patch 3/4 as well.

Please check my patch breaking it out to a separate driver, and
if you could check internally if you have a datasheet for Ilitek
ILI9882t or can use your vendor leverage to get one to improve
on the driver (such as define the DCS commands...) that would
be great.

There are good reasons for grouping the panel drivers into
respective display controller such as fixing bugs in one place
and if we ever want to properly support things such as
gamma correction it will provide the proper per-display-controller
approach.

Yours,
Linus Walleij
