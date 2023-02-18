Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7777E69B693
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBRAGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBRAGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:06:30 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6EC47432
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:06:29 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n6so1411495pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvX+1aCGeXmThaAv0HPXava3Nq97NGfPprIlYrZXPc0=;
        b=oa01nWCg8WRSIAOF4SxvXx80cK5iWqHD909oZptALrrrH9SSm9GbPDBbTBPRNGt2Kr
         WE3imOrFURj/HP2Xqpd9IAeotlG92HflpVdn+xQk5+avZcJhxDmFf1S/i5QVUbUVEZ40
         eDVdSwml+asH+kpSNHckj1LeD4XGU1juqm2+NGO8ruuE81500lj2qbvTm3UJ1iW/h2hM
         vu/m0ZOKhUgZxvoB0SI3wXiZSUTJ3G8iPtuznDQMoLKm0UNkVuU/XQBIoJq4+jmlhyFE
         U/8pgizlMAJQgoz7nJoMpAG0RtEds84GQkGpWf5oG1XRWxoQsTsih0RyJqCYVznrRuYV
         6HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvX+1aCGeXmThaAv0HPXava3Nq97NGfPprIlYrZXPc0=;
        b=B1AaUJcIhV4VwIP1y28hQS+ZOVRS64jjXwwQ/S45pkTNUGswEpVNHOPX6fJDSnmP71
         mVChDL5VnwtYeeiji7WvofVBfUepBKFoZvAndV3AzcXMUk24zttk5a4stOXZqjAhfX21
         D3KXEL3PKwL7RKZeNWxeQClRL8cQiCQeqEeWSLPNjiFx6A7kZZIOsRgsART1Sjz4W3/V
         rpTXz0yeKwkuSWew6J5Uq10wK83Tbqsvj5cuux0Zds4JPRVylUkG1Mp4CqX3Sw0MhzK6
         wYqpwvJVIuRVV/uEeU//W6bAu3ncGmYVHxK8xZW3dWw0x/aOY+7QJp+/rdc5RA1dAf86
         4cZA==
X-Gm-Message-State: AO0yUKW77DBoJoyKMZU0tvhd7y/1zH6auY5u7c4nMaRoWpAJcJ3LJWNS
        4zmRhZJMyWCVkoK8K5lBs82jbyFT1w0822TpY2xqHQ==
X-Google-Smtp-Source: AK7set9WNLiMSIfMK/eaD1L/sZEjT4QbzX7DFSsiQya3t3NWvVFnzves2sJvzG6q4ThXNZJ4aMs5ZKv0ReEnOqvysR8=
X-Received: by 2002:a63:6e47:0:b0:4fb:b3d4:8649 with SMTP id
 j68-20020a636e47000000b004fbb3d48649mr355829pgc.7.1676678788412; Fri, 17 Feb
 2023 16:06:28 -0800 (PST)
MIME-Version: 1.0
References: <932DEB17-70FB-4416-80B3-C48A7C31848F@kohlschutter.com>
 <20220825212842.7176-1-christian@kohlschutter.com> <CAGETcx__Ez8i9O2O30-Q1R00xOqBjkKMCwt37_AGAQjNvZqpdg@mail.gmail.com>
 <B6E001E2-9BCD-420A-B0F6-1495DE46955E@kohlschutter.com> <CAGETcx_OKA+MkExc98337kZYKsoJtV0ZdfYJE7Tk00CFvCt2bA@mail.gmail.com>
 <F6AC6A52-49BA-4F80-91A8-271E11CD17E4@kohlschutter.com>
In-Reply-To: <F6AC6A52-49BA-4F80-91A8-271E11CD17E4@kohlschutter.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Feb 2023 16:05:52 -0800
Message-ID: <CAGETcx839=FSj-njD03bqaEFKPfhEY7DXnjQ5V1+s0G2vn86Eg@mail.gmail.com>
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

On Fri, Feb 17, 2023 at 4:01 PM Christian Kohlsch=C3=BCtter
<christian@kohlschutter.com> wrote:
>
> On 18. Feb 2023, at 00:46, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Fri, Feb 17, 2023 at 3:33 PM Christian Kohlsch=C3=BCtter
> > <christian@kohlschutter.com> wrote:
> >>
> >> On 18. Feb 2023, at 00:22, Saravana Kannan <saravanak@google.com> wrot=
e:
> >>>
> >>> On Thu, Aug 25, 2022 at 2:28 PM Christian Kohlsch=C3=BCtter
> >>> <christian@kohlschutter.com> wrote:
> >>>>
> >>>> Previously, an unresolved regulator supply reference upon calling
> >>>> regulator_register on an always-on or boot-on regulator caused
> >>>> set_machine_constraints to be called twice.
> >>>>
> >>>> This in turn may initialize the regulator twice, leading to voltage
> >>>> glitches that are timing-dependent. A simple, unrelated configuratio=
n
> >>>> change may be enough to hide this problem, only to be surfaced by
> >>>> chance.
> >>>
> >>> In your case, can you elaborate which part of the constraints/init
> >>> twice caused the issue?
> >>>
> >>> I'm trying to simplify some of the supply resolving code and I'm
> >>> trying to not break your use case.
> >>>
> >>> -Saravana
> >>
> >> Here's a write-up of my use case, and how we got to the solution:
> >> https://kohlschuetter.github.io/blog/posts/2022/10/28/linux-nanopi-r4s=
/
> >
> > I did read the write up before I sent my request. I'm asking for
> > specifics on which functions in the set_machine_constraints() was
> > causing the issue. And it's also a bit unclear to me if the issue was
> > with having stuff called twice on the alway-on regulator or the
> > supply.
> >
> > -Saravana
>
> I'm afraid I cannot give a more detailed answer than what's in the write =
up and the previous discussion on this mailing list; I thought it's pretty =
detailed already.

Well, I do my best not to break your use case with whatever info you
are willing to provide. We'll figure it out one way or another I
suppose.

> However, it should be relatively straightforward to reproduce the issue.

If one has the hardware. Which I don't.

-Saravana
