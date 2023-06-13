Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2FE72EAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbjFMSZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240421AbjFMSZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:25:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5E610CC;
        Tue, 13 Jun 2023 11:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2264462F59;
        Tue, 13 Jun 2023 18:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAFEC433D9;
        Tue, 13 Jun 2023 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686680714;
        bh=jWg/New539N3VJZmMOxA0JmnZ0dZKjTSIx6uuvCsdhI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rOE+V+qajgMj+P/lK8M5eMIy2GTKb+x/c2ma4s9l0HcJSxQMRqhVoHuMN+Nd9Z5wJ
         TTYLYg60gMIe2301mrSF5ksa//TwB7chF6kq1bKGWxYOZxXkudv5KwetNnrGodNSj6
         xSkIhPmQEcO+OM92lGJGYGK6y0VLvkYhGomJYgeZzb21A/favFYh6wTZB9XD7243TJ
         HbU9275R5T8GUstYO7zGEVyKP9mYnho0HWPMXGHvBQrPcdYqatGTcrakCo3epHBMQo
         a2y401vEd2aXXj1oMakGquU97mTx5KHKVmiQnx6nv5yLAEUKuTm30EFxWVO1bJ5u4t
         m9Ury5lgR17+Q==
Message-ID: <86d58c6b131028a71964a0bcb135f01f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7s2xdk43a2lhyezgj6bbwxaekbtgym2rin7t432m4pos4j6v74@qaxm3htjak4a>
References: <20230526171057.66876-1-sebastian.reichel@collabora.com> <20230526171057.66876-2-sebastian.reichel@collabora.com> <2f3328c4be9db6feef2cc662ede70f92.sboyd@kernel.org> <7s2xdk43a2lhyezgj6bbwxaekbtgym2rin7t432m4pos4j6v74@qaxm3htjak4a>
Subject: Re: [PATCH v2 1/2] clk: composite: Fix handling of high clock rates
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christopher Obbard <chris.obbard@collabora.com>,
        David Laight <David.Laight@aculab.com>, kernel@collabora.com,
        stable@vger.kernel.org
To:     Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 13 Jun 2023 11:25:12 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2023-06-13 05:14:25)
> On Mon, Jun 12, 2023 at 05:10:35PM -0700, Stephen Boyd wrote:
> > Quoting Sebastian Reichel (2023-05-26 10:10:56)
> > > diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> > > index edfa94641bbf..66759fe28fad 100644
> > > --- a/drivers/clk/clk-composite.c
> > > +++ b/drivers/clk/clk-composite.c
> > > @@ -119,7 +119,10 @@ static int clk_composite_determine_rate(struct c=
lk_hw *hw,
> > >                         if (ret)
> > >                                 continue;
> > > =20
> > > -                       rate_diff =3D abs(req->rate - tmp_req.rate);
> > > +                       if (req->rate >=3D tmp_req.rate)
> > > +                               rate_diff =3D req->rate - tmp_req.rat=
e;
> > > +                       else
> > > +                               rate_diff =3D tmp_req.rate - req->rat=
e;
> >=20
> > This problem is widespread
> >=20
> >  $ git grep abs\(.*- -- drivers/clk/ | wc -l
> >  52
> >=20
> > so we may have a bigger problem here. Maybe some sort of coccinelle
> > script or smatch checker can be written to look for abs() usage with an
> > unsigned long type or a subtraction expression. This may also be worse
> > after converting drivers to clk_hw_forward_rate_request() and
> > clk_hw_init_rate_request() because those set the rate to ULONG_MAX.
> > +Maxime for that as an FYI.
>=20
> We set max_rate to ULONG_MAX in those functions, and I don't think we
> have a lot of driver that will call clk_round_rate on the max rate, so
> we should be somewhat ok?

Good point. I haven't looked to see if any drivers are using the
max_rate directly. Hopefully they aren't.
