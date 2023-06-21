Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E4D737E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjFUIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjFUIku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:40:50 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4871FE7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:40:10 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f9d619103dso109351cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687336810; x=1689928810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQMoXMnbWU/uyGYsJxGBmzcur0xnsX6AwrHBtRRMA2I=;
        b=lwi7c+pCIZqb++zcz4hGkaCndThXtwbaE6E9+3J+IxVdpa35rZLHGHXoRgonzS7SHv
         o6pihBBYWga2wMO84Rd7srilI581XiveFvvsiuO0AtZewj05UbdtBDUahjHZ1WoOECrH
         lBOTX6JaKh4ezaX794YQ6WxNrrJtpVhafVksKSwpRnKufRB67zUUrWvcphwJuRfQTe9A
         LgeCT5oPXGAlfpcmFuSS85LC90zDlbIZoxa6n2yKs1vODXcnW91l6Wacugd/xhja+Gq7
         7absC1E6pW81iQRaHCJR32mkdPVfyLWfhxqBAAkCXnnYIsgGnXWA4aJwyp6Q8A2Lel9J
         6WlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687336810; x=1689928810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQMoXMnbWU/uyGYsJxGBmzcur0xnsX6AwrHBtRRMA2I=;
        b=RUQFZUPZ8B7i71r9Bv3K4pJMmp+rfVvFbAysxa5AexJFoYz7bP5fZv7N6iNpdYtxvr
         epXX8hHXXlF4SR2s0bmFJsOhAR4OakWmd3WiG9E7nvRLLw0cxPgYmOwsyMR1cGJPj2J7
         3tM00rfq1uHhzsuE3/BMguvdDKuck4QFQqrRRYCh0lkEBhccLGEiZZ53mTej76aGbh0w
         1UWyJM8fJeAf32Nlx5Lw+vUPLiLQS5OblYYieVhifawYfa6iTyCHwBqLXoJqcS9ApWci
         daeGOm+xG7AJHzdMjnMfBaUFCdVDRJxF1YjsJ5vnEgLWDKJWiyB/+EQ0eil3Lvnaeipl
         6pwQ==
X-Gm-Message-State: AC+VfDw1pC8Wq2tov2oTj8CE+OxP+4lDFVmwSQTCJBU86niuExHuJal9
        fnsB40xouZOUeYUi4PmEeOcw+5OjsUSCy6yzy8NPFA==
X-Google-Smtp-Source: ACHHUZ6C8CcgmEZ5PbR0wUat4gTexFJ5bM8IZ7FeNQMEVP7/uZEPM63ok3JDnGFHqo1o3vsorbD0i8x9TeiyXF0kJY0=
X-Received: by 2002:ac8:5843:0:b0:3e0:c2dd:fd29 with SMTP id
 h3-20020ac85843000000b003e0c2ddfd29mr1399722qth.4.1687336809930; Wed, 21 Jun
 2023 01:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230530114216.1420790-1-yimingtseng@google.com> <CAJZ5v0gmmyLMWwzn8q_DCrKVg6mNJ+mHFcLt2AY8LJJ_4dt7dg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gmmyLMWwzn8q_DCrKVg6mNJ+mHFcLt2AY8LJJ_4dt7dg@mail.gmail.com>
From:   Yi-ming Tseng <yimingtseng@google.com>
Date:   Wed, 21 Jun 2023 16:39:58 +0800
Message-ID: <CAA5JqK5MUv-uC1xFNUB-TzjYH-J7VONGcFu2Em6OQnKL2C13Tg@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: fix overflow in genpd_parse_state
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marscheng@google.com, n.zhandarovich@fintech.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh I just found there is a similar patch from Nikita Zhandarovich
and it will be applied in v6.5. I think we can drop this patch. Thanks
and sorry for duplicated patches.

The patch from Nikita Zhandarovich and the discussion:
https://lore.kernel.org/all/CAJZ5v0gx7bD9EZKPQWyAAZ6hSKjK4hr-nkrJu84HEK-g2A=
MAaw@mail.gmail.com/

Thanks again.

On Sat, Jun 17, 2023 at 1:44=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, May 30, 2023 at 1:42=E2=80=AFPM YiMing Tseng <yimingtseng@google.=
com> wrote:
> >
> > Add type casters to prevent 32-bit overflow before assigning to s64
> > variables. It allows full 32-bit range support for latency and
> > residency.
>
> OK, but is it really a practical problem?
>
> Ulf, what do you think?
>
> > Signed-off-by: YiMing Tseng <yimingtseng@google.com>
> > ---
> >  drivers/base/power/domain.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 32084e38b73d..26a04cd8d8dc 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2939,10 +2939,10 @@ static int genpd_parse_state(struct genpd_power=
_state *genpd_state,
> >
> >         err =3D of_property_read_u32(state_node, "min-residency-us", &r=
esidency);
> >         if (!err)
> > -               genpd_state->residency_ns =3D 1000 * residency;
> > +               genpd_state->residency_ns =3D (s64)1000 * residency;
> >
> > -       genpd_state->power_on_latency_ns =3D 1000 * exit_latency;
> > -       genpd_state->power_off_latency_ns =3D 1000 * entry_latency;
> > +       genpd_state->power_on_latency_ns =3D (s64)1000 * exit_latency;
> > +       genpd_state->power_off_latency_ns =3D (s64)1000 * entry_latency=
;
> >         genpd_state->fwnode =3D &state_node->fwnode;
> >
> >         return 0;
> > --
