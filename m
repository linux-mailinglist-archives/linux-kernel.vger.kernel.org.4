Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789C8729FD5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbjFIQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242130AbjFIQOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:14:55 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF083AA7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:14:53 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-777ac169033so114220439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686327291; x=1688919291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rk3RV3sQ8umXpReTsBFbhMYf09xiUdeQTMhyG8kXHGw=;
        b=GNGEnYh5u8vV+/z99Oxr5YbDRdAtkOxvvZbXWxGE8Qn+kN27gqFPvA+ssksR3EOaPX
         qeyLlpFw8AxcTrWSL2U2DByIbB9psSRfOwqezA6IwP6tHECQobDRZl5BUCAliDB4m9SM
         BJgEagqCt8/yyy65msZvTpw4bx3jdvdpMv+8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327291; x=1688919291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rk3RV3sQ8umXpReTsBFbhMYf09xiUdeQTMhyG8kXHGw=;
        b=WRZnt2iLVPuJYOe5g+4IXJzbn5XtXJlrdut0BWEUYyhVmFU7ov28s3965hAYhsnp0U
         ZXJMe/Ev3VyPMZPvrDFEKdBR6wyb+nmHIBN52ZpXS8j6GkxGwovaGLJ1Mj/GtGFAfdzq
         L8R0YEvByojCubQRZ3YTR7OPo1R5fBSHVbmyxEh+XJ8poHER5BKOha3nQxkPwZmnBDpX
         1qpmzI16KnG1MnoVnii6mlVTL+vWni9Ef7Pz2Ck+ulQ2IEYIXnYoINoqXv9d93Q0vRCk
         pVxuA8Mx4lfj0BwI9yWX77lSuk08nqXW8Ygj3CCoiOO3jXDXLzXqgtfv4jJKsEMq68Qr
         jn4w==
X-Gm-Message-State: AC+VfDwKZFB+6sGgiHd/Jsj4VneGCUlMlbXxYeyl3bfy8hQ92gmRj9wv
        5tg0K48yukV4zZYvqBAwSSVYVtrh1HCK5fxcepk=
X-Google-Smtp-Source: ACHHUZ7c3GJ+sESqk+kCkl7SwKlLElftoXV+j9g4A2eWzGG+JOjKwwT681RRc6uq6AK8dnbkymHMDw==
X-Received: by 2002:a05:6602:2d01:b0:777:a4d2:8871 with SMTP id c1-20020a0566022d0100b00777a4d28871mr4645275iow.5.1686327291262;
        Fri, 09 Jun 2023 09:14:51 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d958d000000b0076ffebfc9fasm1146523ioo.47.2023.06.09.09.14.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 09:14:50 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so259925ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:14:50 -0700 (PDT)
X-Received: by 2002:a05:6e02:b44:b0:33d:5d63:57b6 with SMTP id
 f4-20020a056e020b4400b0033d5d6357b6mr402827ilu.13.1686327290072; Fri, 09 Jun
 2023 09:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230609063615.758676-1-yangcong5@huaqin.corp-partner.google.com>
 <20230609063615.758676-3-yangcong5@huaqin.corp-partner.google.com> <CAD=FV=UPSwWpkGN3UyFm1c84gj7iDC7dYrT9CCqWnqkTun-4cg@mail.gmail.com>
In-Reply-To: <CAD=FV=UPSwWpkGN3UyFm1c84gj7iDC7dYrT9CCqWnqkTun-4cg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 9 Jun 2023 09:14:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Upq2t_+HtrX91etVhTQAK83khEX7MB-DzZuBpE5J3gJQ@mail.gmail.com>
Message-ID: <CAD=FV=Upq2t_+HtrX91etVhTQAK83khEX7MB-DzZuBpE5J3gJQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] HID: i2c-hid: elan: Add ili9882t timing
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, hsinyi@google.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
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

On Fri, Jun 9, 2023 at 9:14=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Thu, Jun 8, 2023 at 11:36=E2=80=AFPM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > The ili9882t is a TDDI IC (Touch with Display Driver). The
> > datasheet specifies there should be 60ms between touch SDA
> > sleep and panel RESX. Doug's series[1] allows panels and
> > touchscreens to power on/off together, so we can add the 65 ms
> > delay in i2c_hid_core_suspend before panel_unprepare.
> >
> > Because ili9882t touchscrgeen is a panel follower, and
> > needs to use vccio-supply instead of vcc33-supply, so set
> > it NULL to ili9882t_chip_data, then not use vcc33 regulator.
> >
> > [1]: https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromi=
um.org
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> >  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 50 ++++++++++++++++++++-------
> >  1 file changed, 38 insertions(+), 12 deletions(-)
>
> This seems reasonable to me now, but only makes sense to land if the
> panel follower patch series [1] lands. That series is currently at v2
> and will at least need a v3.
>
> [1] https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromium.=
org

Oh, but I should have added:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
