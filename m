Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD01C69B680
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBQXq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBQXqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:46:55 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB8A65359
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:46:54 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id y2so2663337pjd.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676677613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckp4pLuUHkuempvnYbrn9XuKX3oztgaEXvwAfzzvbKY=;
        b=rWGWSdMT5ixaW0iNl8IhrhsuifkVG2oQPpuqB2Eetrood7DpY5O3hTe8+qsucNsr11
         UCr2m1Sm7iSV33/sNfViZVRh1QGM0SlGmlVSekcypOu6X2iwzSK0RiUkTAyCxHutakzb
         ZNFHMeAzuxMeRESMv9EdMvXIpiJXuIGsMayaq2iAVID//4R0tOdLAuq2IrOqg9gGKVqm
         BbbYZZdAtHuaOsGVxkdFuk5s6nY5jWvbns5uG/pcVznnZmBCoAdMiUf9cDPwfYlAzRhk
         QTGnsMphT8kymOGYBnNjK2l1BJ/0o7Xw8dR/pzvTnvHYrUG2zYDaWbuCzglaw5NaFn72
         pxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676677613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckp4pLuUHkuempvnYbrn9XuKX3oztgaEXvwAfzzvbKY=;
        b=rbYklaBzBH0IYnOetd2EENiVmSD6KTzR7Eh3VLunAL0KPhFr/i6N9MQ+ewVaGslRvx
         WSi4cmz+AIkesMiFd34Wo4/rYta9FvX2M+4JZfUOy8OvLCICbehI/EwGMhyYARTEjY2m
         1vhE9SyTBGdoFFEb1bdpbWdk9O50XjipWrOEjBCuHv73pGqbFcmIZ2DApyZqiwJrJZoB
         XJvLB87ahU6a8NLO21WeibT4bc/Z1IUjf3gdEgfo6S/DceGoEg3V2/tYoRJ/YkA/H2Yc
         GN0PzmKi34A3nrf+VuwK3AFvliDKHYYZ52J4G9+HQ96rkDV0aT035DVbJ9bgnLnhQTcy
         lZIA==
X-Gm-Message-State: AO0yUKWr2NQJw6v4ZZCPZafW9ILJqlIYrsZqGiDbB+2jnIfMksvcciqy
        /8dZBNQH0tDhphRTgghty3oFE1GqoXimeDfvoUkmGQ==
X-Google-Smtp-Source: AK7set/WKbRLdtHn4gVAoqZXddY2wGOMgp4LCc77gafDWBJfKQOBHBqd8D3oSx1xsHRCoFAuoVn5+jh3RFhp9BlMoys=
X-Received: by 2002:a17:903:328e:b0:19b:c39:3ba5 with SMTP id
 jh14-20020a170903328e00b0019b0c393ba5mr862857plb.29.1676677613373; Fri, 17
 Feb 2023 15:46:53 -0800 (PST)
MIME-Version: 1.0
References: <932DEB17-70FB-4416-80B3-C48A7C31848F@kohlschutter.com>
 <20220825212842.7176-1-christian@kohlschutter.com> <CAGETcx__Ez8i9O2O30-Q1R00xOqBjkKMCwt37_AGAQjNvZqpdg@mail.gmail.com>
 <B6E001E2-9BCD-420A-B0F6-1495DE46955E@kohlschutter.com>
In-Reply-To: <B6E001E2-9BCD-420A-B0F6-1495DE46955E@kohlschutter.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Feb 2023 15:46:17 -0800
Message-ID: <CAGETcx_OKA+MkExc98337kZYKsoJtV0ZdfYJE7Tk00CFvCt2bA@mail.gmail.com>
Subject: Re: [PATCH v5] regulator: core: Resolve supply name earlier to
 prevent double-init
To:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, m.reichl@fivetechno.de,
        robin.murphy@arm.com, vincent.legoll@gmail.com, wens@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 3:33 PM Christian Kohlsch=C3=BCtter
<christian@kohlschutter.com> wrote:
>
> On 18. Feb 2023, at 00:22, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 2:28 PM Christian Kohlsch=C3=BCtter
> > <christian@kohlschutter.com> wrote:
> >>
> >> Previously, an unresolved regulator supply reference upon calling
> >> regulator_register on an always-on or boot-on regulator caused
> >> set_machine_constraints to be called twice.
> >>
> >> This in turn may initialize the regulator twice, leading to voltage
> >> glitches that are timing-dependent. A simple, unrelated configuration
> >> change may be enough to hide this problem, only to be surfaced by
> >> chance.
> >
> > In your case, can you elaborate which part of the constraints/init
> > twice caused the issue?
> >
> > I'm trying to simplify some of the supply resolving code and I'm
> > trying to not break your use case.
> >
> > -Saravana
>
> Here's a write-up of my use case, and how we got to the solution:
> https://kohlschuetter.github.io/blog/posts/2022/10/28/linux-nanopi-r4s/

I did read the write up before I sent my request. I'm asking for
specifics on which functions in the set_machine_constraints() was
causing the issue. And it's also a bit unclear to me if the issue was
with having stuff called twice on the alway-on regulator or the
supply.

-Saravana
