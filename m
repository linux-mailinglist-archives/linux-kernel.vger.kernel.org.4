Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048EF6A5C40
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjB1PqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjB1PqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:46:24 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E49E302B3;
        Tue, 28 Feb 2023 07:46:23 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso5801110ots.9;
        Tue, 28 Feb 2023 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBC6OVNsrTR74m7E6zxcjbZx0E4uXq6c6qLU8cPPu8w=;
        b=qcRfhI+DjRCPChROMhUlpR69nX3r/YbFhcHRZryG9e6J5dcy9dC9e7xz+mHTcjPanZ
         WZ/rKxt65Drsc5YwKefqKhjbdKeO6LgIDuHXteidVe9n/3driiJwbQ9HR+xi0aqNAWd/
         Z/vJqtAK+BghcxqFbjfYfZWNbMlJ4+QDmdh2acDbkBAdseZQcQgu+75npUvD4D2NR2x4
         ElF/TfZVMbTLmU44X/v7vUwhlNWoPXCF5afCq9BgolFibGG/AxhcGVTa9u2iiM3Hjdnd
         sZM83ya/rKv4WTxsOqcZ+4vgcRGrdhfa46+kWB5IwGWQyKBaqBUkq84pLWCs3gARzUs4
         4Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBC6OVNsrTR74m7E6zxcjbZx0E4uXq6c6qLU8cPPu8w=;
        b=LFfafcSDG3k0oHXR8CSA9fLID84tgutxHDYCn961cJKRz8DhwQYW6M9u+XbAVV9l49
         jfmAmtETzBAxFr2fMIOlU7OKhVOaA37HWLyve7wnlzm6/oNNsWKMBBzJM52CiZ9Gbb/9
         Sc11mdFzMd5Sm1k7h1V8yrkH/Elp+MDwzCw461gzLxJjcBUqf/PQqpIxESlXqMlEz3Uw
         +sZe5hmKDW9rd1HvIBlUwVNhneIqsh5NQZwrE0gxWsCrshkZUgiMD0QZhN9mAVz5odVv
         dJWHgUDUhsgv8232/0EHE+8wZKcw0RAb0rMlnqUKCdFRDEQpsLPJ7bqjyvKIq1Vdq6fJ
         s0XQ==
X-Gm-Message-State: AO0yUKWtiDmJBJOCHaLtBXa5GdFfvh8/hFC7GlyXdxg4lhryTRR9ijxb
        tHMu/mLfVpjsO3fiYGyjYNIrRnBmJ5nGchstokpNVnM2
X-Google-Smtp-Source: AK7set9C8cFya8pjgLJpKrGJ6GNk0nZskiNqYkfvA7UgZ6ypL5uzpHNs6llHzf7CVPCZtofa5Sc/CuV/D/0W8Ha057s=
X-Received: by 2002:a9d:705c:0:b0:693:c521:f86d with SMTP id
 x28-20020a9d705c000000b00693c521f86dmr1101399otj.6.1677599182481; Tue, 28 Feb
 2023 07:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
 <20230214103936.1061078-3-sergio.paracuellos@gmail.com> <20230214151101.GB742354@roeck-us.net>
 <CAMhs-H915iSR7TpuXdcg8NKLV8Scv9cwW36SZaXNK839kA4ybg@mail.gmail.com>
 <CAMhs-H_Ce-+MFi5zTMg8v8dSSg5ioaTy+Pw-0QMgK++PVtEViQ@mail.gmail.com>
 <20230228083920.GA5801@alpha.franken.de> <CAMhs-H8xGjGs0-qvxb5KgQ3YZw=2=scqaY15K3ZRp50jQcncSg@mail.gmail.com>
 <82659eef-528d-e421-aed4-21e1a7794bf5@roeck-us.net>
In-Reply-To: <82659eef-528d-e421-aed4-21e1a7794bf5@roeck-us.net>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 28 Feb 2023 16:46:10 +0100
Message-ID: <CAMhs-H8uPztGhWCRiQj69dZd8gtXy-fTDcn7ovOpp0LcX0H=wA@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] mips: dts: ralink: mt7621: rename watchdog node
 from 'wdt' into 'watchdog'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, arinc.unal@arinc9.com,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 3:55 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/28/23 00:51, Sergio Paracuellos wrote:
> > On Tue, Feb 28, 2023 at 9:41 AM Thomas Bogendoerfer
> > <tsbogend@alpha.franken.de> wrote:
> >>
> >> On Tue, Feb 28, 2023 at 05:44:21AM +0100, Sergio Paracuellos wrote:
> >>> On Tue, Feb 14, 2023 at 4:12 PM Sergio Paracuellos
> >>> <sergio.paracuellos@gmail.com> wrote:
> >>>>
> >>>> On Tue, Feb 14, 2023 at 4:11 PM Guenter Roeck <linux@roeck-us.net> w=
rote:
> >>>>>
> >>>>> On Tue, Feb 14, 2023 at 11:39:33AM +0100, Sergio Paracuellos wrote:
> >>>>>> Watchdog nodes must use 'watchdog' for node name. When a 'make dtb=
s_check'
> >>>>>> is performed the following warning appears:
> >>>>>>
> >>>>>> wdt@100: $nodename:0: 'wdt@100' does not match '^watchdog(@.*|-[0-=
9a-f])?$'
> >>>>>>
> >>>>>> Fix this warning up properly renaming the node into 'watchdog'.
> >>>>>>
> >>>>>> Reviewed-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>>>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >>>>>
> >>>>> Acked-by: Guenter Roeck <linux@roeck-us.net>
> >>>>>
> >>>>> Note that we can not apply this and the next patch of the series
> >>>>> through the watchdog tree since it crosses a maintainer boundary.
> >>>>
> >>>> I was expecting Thomas to get these two arch/mips patches or get an
> >>>> Acked-by from him in order for you to apply them.
> >>>
> >>> Hi Thomas,
> >>>
> >>> I think you have missed this series since you have started to apply
> >>> newer stuff in mips-next. Are you ok with taking or Acking patches 2
> >>> and 3 of this series?
> >>
> >> yes, I sort of missed it. If it's enough to take patch 2/3 I'll do tha=
t.
> >> If it's better to keep the series, I'm also ok with acking them.
> >> What's the best way forward ?
> >
> > Both trees work for me. The rest of the patches of this series should
> > go through the watchdog tree. Guenter, what is better for you?
> >
>
> Wim is handling pull requests. He has queued the other three patches in h=
is
> tree. I would suggest to apply the two remaining patches through the mips
> tree.

Thanks for letting me know, Guenter.

Thomas, please, take the patches 2 and 3 through the mips tree, then.

Thanks,
    Sergio Paracuellos
>
> Guenter
>
> > Thanks,
> >      Sergio Paracuellos
> >
> >>
> >> Thomas.
> >>
> >> --
> >> Crap can work. Given enough thrust pigs will fly, but it's not necessa=
rily a
> >> good idea.                                                [ RFC1925, 2=
.3 ]
>
