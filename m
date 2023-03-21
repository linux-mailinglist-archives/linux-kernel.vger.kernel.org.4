Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0DD6C2AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjCUG5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjCUG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:57:07 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF0824BED;
        Mon, 20 Mar 2023 23:56:38 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id bf30so3877685oib.12;
        Mon, 20 Mar 2023 23:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679381798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CB30YBR/unG1rtVrj/VEIoIIDqVdeb6HobkvOGdOhs=;
        b=ljEyPQ/miVXVu+ZkXp99IVFxim/tHSNUWMN+4y6JRzkUykqZhmcnNntq5viRLU26lW
         3+BbBMyvpE1sPre6zjo+lrT/+JDUo1yl1O4FblkNIaUquGngGNjiyX6U2URmgXv5gMAk
         vU0VrR1p/ostCdOeelGYLa/sAyRBmtkDFZdOv5wAkn11p3M0VIfT8EDuj9KWM2FmXGJr
         SAOlEMjX/r9JnXWKZFx2ngdrJowL4QiRsJdfNnESe5wGxPqOWAEpVKOjXWD5WBcpzYW2
         pMKGsXI/PL9kpKOFNH9b+dOQO+YAQ1vbxXPijZG1T6z/uawYtBCb2M5BdD9j++O/8ykx
         oY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679381798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CB30YBR/unG1rtVrj/VEIoIIDqVdeb6HobkvOGdOhs=;
        b=bS+zGYvnWGl8dFobnOa9JMVP2WIW7H061c4TLa7Xp4Pvj8TqqCOWgoE9yQwbPhgpjL
         eP+Bw1ucK5tcn5ZCB2YLXg7C98dzgBByuya9qCyW36dmlRWYdBfBHnF2pxMD5wux4ars
         Z3b6gutQ9iRZPAc3Cbmkwf3azfrNZjyXubjRkjFNmOEJnn5StokRyAZFH3S/Vint74UX
         SZ0ZFM+jj4IoXo2JfzVQ9ru64AQJOX+YZq92nL7CzC4Rt7M2QuE3B4xSE5PDYMybi2It
         QnGp2LnRzwkaw9jk6kHssG7VQuDADrk6U/WfyjKrb7iplMFaIenJAguI/4G4Q7VwAwSy
         SFoA==
X-Gm-Message-State: AO0yUKVyeJ1uVxB5e4KB3M/f9Z8T6nYuuZmwYzQFigeTXR19FVTldOBE
        PzGrQX4GJ/b57gSN5wKXrqyotzzcmPIfPvVaXEk=
X-Google-Smtp-Source: AK7set8XAb32jOcG6ctlGx42mqM8SUCZhdbCzSCOqkbYwbN4WIQyCH/Ly80MQgmj1MEHdFvG6xKhBB0Rd57/AHcSI5g=
X-Received: by 2002:a05:6808:199f:b0:384:21dd:2793 with SMTP id
 bj31-20020a056808199f00b0038421dd2793mr313020oib.0.1679381798025; Mon, 20 Mar
 2023 23:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com> <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
 <CAMhs-H8OQ9gJLsifLuHD2GN8rYwnY=Zmdb0kMEfX4UUHhjMUyQ@mail.gmail.com>
 <d0f74721-bf5a-62de-53dc-62e7e735e2dc@linaro.org> <bdc82b4a-f1a9-0372-5a57-200a422b1b70@arinc9.com>
 <21a90597-78c9-4d46-7b01-257702e7afca@linaro.org> <525a6388-a4b8-3052-fe81-5aa21d8f424a@arinc9.com>
 <507f79cf-acd8-5238-031a-fd71024e0c6a@linaro.org> <CAMhs-H8_S5eO7B+dZ7jeq7Jjnw71QBmSo4M+woe3U5sH7dCADg@mail.gmail.com>
 <39ba681e-5bab-cffc-edf7-4bf86387987c@linaro.org> <132de602-6467-536c-c66d-657f22a59bd5@arinc9.com>
 <40e3acac-b58a-7af8-b025-3678f84434da@linaro.org>
In-Reply-To: <40e3acac-b58a-7af8-b025-3678f84434da@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Mar 2023 07:56:25 +0100
Message-ID: <CAMhs-H9AWXvtbg=qz06HN3piUO0E5YF3RmrdRLC7qH2n6KjrSw@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
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

On Tue, Mar 21, 2023 at 7:43=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/03/2023 07:38, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> >>>>
> >>>> Ah, but indeed there are newer Mediatek MT6xxx and MT8xxx SoCs which=
 are
> >>>> ARM, so mediatek,mtmips-sysc would work.
> >>>
> >>> I can use 'mediatek,mtmips-sysc.yaml' as the name but compatibles wil=
l
> >>> start with ralink. There are already some existent compatibles for
> >>> mt762x already having ralink as prefix, so to be coherent ralink
> >>> should be maintained as prefix.
> >>
> >> The compatibles I mentioned start already with mediatek, so why do you
> >> want to introduce incorrect vendor name for these?
> >
> > Can you point out where these compatible strings for mt7620 and mt7628 =
are?
>
> git grep

Not for *-sysc nodes. The only current one in use (from git grep):

arch/mips/ralink/mt7620.c:      rt_sysc_membase =3D
plat_of_remap_node("ralink,mt7620a-sysc");

That's the reason I also used prefix ralink for the rest.

Does it make sense to you to maintain this one as ralink,mt7620a-sysc
and add the following with mediatek prefix?

mediatek,mt7620-sysc
mediatek,mt7628-sysc
mediatek,mt7688-sysc

That would be weird IMHO.

> Best regards,
> Krzysztof

Thanks,
    Sergio Paracuellos
