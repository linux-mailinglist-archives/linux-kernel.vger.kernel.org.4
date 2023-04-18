Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16786E6CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjDRTGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjDRTGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:06:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC86519A2;
        Tue, 18 Apr 2023 12:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56B9662799;
        Tue, 18 Apr 2023 19:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B545EC433D2;
        Tue, 18 Apr 2023 19:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681844770;
        bh=kTrRXIOKBHABQ2pWiTWaUDVKadSjGYzFErkx73DzSo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hoOnHWn/xRuJ0j+wRoGuUEUqRd3npli6dnbUdCscy1huICZm/o/m9XF1lSrwxpjJs
         xvzFazJoGr8ph0VuhmpfPw2F7ldrUrDJnFFiPZ6pwHGuz20Sj2/6RBb8peoF2PTINR
         rbXKDPeaK98y+dbg1wS696rbzMppawp3gCxWwivvyxqu0VDbm6+mPDUgN1Q1HYwObA
         i3ISK2QLNArT15yR8EVNJBqBMum5He//HD+5VXarGzK2j2NXLOm+Huxih5dLkSao56
         sCldR78C3hAUsckIMBW+OcjsNR7M8AIz5aVa2KL0JcjACx2XPlm0G/RH00h5YZdpKU
         VygZM5jxqT/Fw==
Received: by mail-yb1-f180.google.com with SMTP id n193so7646116ybf.12;
        Tue, 18 Apr 2023 12:06:10 -0700 (PDT)
X-Gm-Message-State: AAQBX9eYwRU8jw4WU8SMhsf7iRzembivq8Ikh3GbdPnGD8jisSEOFdv4
        OdEAyQwh19DuSCDQnhl9WQA+WoLuG0n/quf1FA==
X-Google-Smtp-Source: AKy350YVYOWCgXjIX8NCg8mPMqccSWud4t+DEI8ZLyb6xuoMFSDufniyipw9gtGay0rtZJT+8hp8SxBK/VeYqwhpKhI=
X-Received: by 2002:a25:6c41:0:b0:b8f:1d2c:243f with SMTP id
 h62-20020a256c41000000b00b8f1d2c243fmr9837346ybc.1.1681844769788; Tue, 18 Apr
 2023 12:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144710.1543139-1-robh@kernel.org> <20230418162500.GC1764573-robh@kernel.org>
 <CABb+yY3Y8oZYG1y8zfTCC8g7=T0HQp3G3N_iECudo1gduYpy-A@mail.gmail.com>
In-Reply-To: <CABb+yY3Y8oZYG1y8zfTCC8g7=T0HQp3G3N_iECudo1gduYpy-A@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Apr 2023 14:05:58 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Oxj4ZDMyS_jOXiZEL2p=mYGr4MOGxiLen1ThRVE5cMw@mail.gmail.com>
Message-ID: <CAL_Jsq+Oxj4ZDMyS_jOXiZEL2p=mYGr4MOGxiLen1ThRVE5cMw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Use of_property_read_bool() for boolean properties
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:36=E2=80=AFAM Jassi Brar <jassisinghbrar@gmail.c=
om> wrote:
>
> On Tue, Apr 18, 2023 at 11:25=E2=80=AFAM Rob Herring <robh@kernel.org> wr=
ote:
> >
> > On Fri, Mar 10, 2023 at 08:47:10AM -0600, Rob Herring wrote:
> > > It is preferred to use typed property access functions (i.e.
> > > of_property_read_<type> functions) rather than low-level
> > > of_get_property/of_find_property functions for reading properties.
> > > Convert reading boolean properties to to of_property_read_bool().
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/mailbox/hi6220-mailbox.c | 5 +----
> > >  drivers/mailbox/omap-mailbox.c   | 3 +--
> > >  2 files changed, 2 insertions(+), 6 deletions(-)
> >
> > Ping!
> >
> Pong :)
>
> I don't usually reply back that it looks good and will pick for the
> merge window. I just do that. So yes, it is not overlooked.

Okay. No reply nor applying it in over a month is not a great
experience for submitters.

Rob
