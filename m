Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090656BBCEB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjCOTFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjCOTEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:04:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6CB6C19B;
        Wed, 15 Mar 2023 12:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 700D561E07;
        Wed, 15 Mar 2023 19:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF1EC433D2;
        Wed, 15 Mar 2023 19:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678907088;
        bh=PHCqtfNPtykLQzgOmD479r+vtvy5dP8Tx6mGL6Sg3ak=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qKdBV3PNcXnrOccuRb2+b9kinnFWwz05lqXdy54fU9J37SpHDUIgXnn+I5S/6WeHL
         SK5wZW1D/TPAQUvevh/VOdHiBJ36RAZHiRiiCAQMG2i2mVflMV8GVgPn+bb64VQ1r7
         FTmMRDRRa7LtxOdgTvCoT5RYJ73jU61FiUUwua4PCTNb26Ru8s2IGnKwIAVeG/uWrD
         hXcWvJuaDN5zf8fsF5/oxF85WKAfK8HHP0LGVdxLOLX3zQOSxLkpsf5iureCBqXgGi
         vlZxwRkaz+ZrHr3/mxSHeqj3leMNtVB54aDyYPuSGMUH/4A0f70QY4VEzOKuFgO3g/
         y5kek1OV90Atg==
Message-ID: <48d30bc1f094bee18a2180a5b8e65e40.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJhJPsWDO_nyPLH7uMTB+ODS74SAKDPGOXxk_Nperk1dKBKStQ@mail.gmail.com>
References: <20230210111141.1379645-1-keguang.zhang@gmail.com> <a3e6f6038511ad48258627dbf4c335e2.sboyd@kernel.org> <CAJhJPsUQN5Lo_rVUbbmGY68gorwkcQT=9AXfcEh371cP97Wj_A@mail.gmail.com> <20230315092910.GA8008@alpha.franken.de> <CAJhJPsWDO_nyPLH7uMTB+ODS74SAKDPGOXxk_Nperk1dKBKStQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: loongson32: Update the clock initialization
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date:   Wed, 15 Mar 2023 12:04:46 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Keguang Zhang (2023-03-15 02:43:02)
> On Wed, Mar 15, 2023 at 5:29=E2=80=AFPM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
> >
> > On Wed, Mar 15, 2023 at 11:07:23AM +0800, Keguang Zhang wrote:
> > > On Sat, Feb 11, 2023 at 7:31=E2=80=AFAM Stephen Boyd <sboyd@kernel.or=
g> wrote:
> > > >
> > > > Quoting Keguang Zhang (2023-02-10 03:11:41)
> > > > > The Loongson-1 clock driver is under re-implementation
> > > > > to add DT support. As a result, ls1x_clk_init() will be dropped s=
oon.
> > > > > Therefore, call of_clk_init() for clock initialization instead.
> > > > >
> > > > > Link: https://lore.kernel.org/all/20230209132614.1079198-3-keguan=
g.zhang@gmail.com
> > > > > Link: https://lore.kernel.org/all/20230209132614.1079198-4-keguan=
g.zhang@gmail.com
> > >
> > > Hi Thomas,
> > > Sorry to bother you.
> > > For fear of raising build error, is it possible to merge this patch
> > > before the above two patches getting applied?
> > > Or is there anything to improve?
> > > Thanks very much!
> >
> > the IMHO best way would be to let this patch go the same way as
> > the other patch set. So Stephen could you take this into your
> > tree, too ?
> >
> Sure. Will do.
>=20

Please resend this patch along with the loongson patches that it goes
with.
