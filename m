Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECC97344F0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 07:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjFRFFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 01:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFRFFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 01:05:09 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444BE1731;
        Sat, 17 Jun 2023 22:05:08 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1a991886254so2448084fac.2;
        Sat, 17 Jun 2023 22:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687064706; x=1689656706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PiW+MJlJ2pTX+mzQXGX5U4qXNI/w3DLeXi95EkHBqc=;
        b=JGC0dfEwqu6kZ3c45wSO54eZXVM1fnR6DcXcK76aS3HtHJL0QFFAKdx1xcWqBBc4Ka
         V95+yuD7O2dlwsyzmiXpPDQ9h/c59cLxPKvN0Wnl+zngT/VFckrO2Sxc6Ju4JtcZxpxQ
         ZdMujd4c+3J37u378dNkqumrPnrEzLGqnBkzqW70zLEvj2JWL2x6wjm237Wzx+kbtztU
         qpQ6zVINLPokjU2aOVPkT0wIRDhmZv7zLZgVlXprufYelVjg8Y84UZC0Ss54iBAFpxJC
         I3Iu8HWtCo1Jc5/1UvlwXnPe2R3dC9WG1yYcKtL+ArpOic3iwIqHf9Os2sGyvHvLYWjA
         YzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687064706; x=1689656706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PiW+MJlJ2pTX+mzQXGX5U4qXNI/w3DLeXi95EkHBqc=;
        b=aLvdFwl/8tIqm1ZK9TOPzU7VrRMQbEnWuD3wTeKEQl8I9mDTem2C6MsptViG86WcTV
         baAPKVD636VseMmI5RQXMCQDI1RUhVpxlMuXJoOFAzKe6JA7Uk5Azouum3rYzPNpS8uL
         eMVIrHVzEPpAxd8BvWeJAOeAssGUBzBHivicG2ND2ZS72G10aAU99DnwdtsoN6Kjgo4k
         27wkYmxKDtqz/C5NXF/0l/EB5K0tl2KmPW90jQmrGcXVke4LmV3d+gTJpTlbq7KHmV/l
         ejUC9+RJWX8yys8JaWSGDu+T/4X1wwB5h/0raJohEoUoz7vqVzcpR1AvXaOGIwvP0r5W
         KUMw==
X-Gm-Message-State: AC+VfDwTmlcw6Ew2qvpUGLbaT6dwLE7GVJ5AFQ+fvWxJcYa1mW1601t2
        g/LtdlYU3zWqaOAJMKczbVapfzSzItloUjiqIBZyHcUJh2c=
X-Google-Smtp-Source: ACHHUZ5B7zcZSRzkr3xEkDsmDO4sQjMK2G6DnHnF9bhgUSsx4rAVHDbb+ZlljI5BWOF1QtYQRJ3OW25mnYeJvw/bEWY=
X-Received: by 2002:a05:6870:8805:b0:192:ba3b:a18 with SMTP id
 n5-20020a056870880500b00192ba3b0a18mr3761926oam.51.1687064706585; Sat, 17 Jun
 2023 22:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230617052435.359177-3-sergio.paracuellos@gmail.com>
 <TYAP286MB0315AB8274CDD341D49809A2BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
 <e0f74bdc-3a4b-596a-5ec7-83054377813e@linaro.org> <CAMhs-H9M_c8+AkqUTpYeS2q7_+wBA-jhhiXj-QVXNUDmuERcOA@mail.gmail.com>
 <05e3ff33-ad4e-d2fb-dfd5-7b5265881b74@linaro.org> <CAMhs-H-ncXC37SAMkLfrFmpRi0ORkkCV9rQmrtmw_ndOLo+J0Q@mail.gmail.com>
 <10f01535-ab4f-b0d4-306b-a90f4ad19008@linaro.org> <CAMhs-H-uc_VzZ4MS0VLn9AajFRM-BYKEn4zGJ36H3EmL0oX-WA@mail.gmail.com>
In-Reply-To: <CAMhs-H-uc_VzZ4MS0VLn9AajFRM-BYKEn4zGJ36H3EmL0oX-WA@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 18 Jun 2023 07:04:55 +0200
Message-ID: <CAMhs-H-Aw8gdj=ZUep6ZX_9JH0TK9JgDx=sdduNkOROkzEN96g@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shiji Yang <yangshiji66@outlook.com>, arinc.unal@arinc9.com,
        devicetree@vger.kernel.org, john@phrozen.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        tsbogend@alpha.franken.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi krzysztof,

On Sat, Jun 17, 2023 at 9:11=E2=80=AFPM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> On Sat, Jun 17, 2023 at 7:20=E2=80=AFPM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 17/06/2023 17:37, Sergio Paracuellos wrote:
> > >>> The case of
> > >>> searching for compatible is a mess since as you can see in the
> > >>> bindings there are tons of compatibles to search for, then (this co=
de
> > >>> is common to all ralink platforms).
> > >>
> > >> Compatible is one of the ways using ABI.
> > >
> > > Ok so it is also a broken approach, then.
> >
> > What is exactly broken approach? Fetching by compatibles? Somehow many
> > other platforms do not have problem with that, even for multiple
> > compatibles. Why yours is special?

Ok so fetching by compatible would be a valid approach, then. The
following works for me. Would you also be ok doing it this way?

static const char *clk_cpu(int *idx)
{
    *idx =3D 1;

    switch (ralink_soc) {
    case RT2880_SOC:
        return "ralink,rt2880-sysc";
    case RT3883_SOC:
        return "ralink,rt3883-sysc";
    case RT305X_SOC_RT3050:
        return "ralink,rt3050-sysc";
    case RT305X_SOC_RT3052:
        return "ralink,rt3052-sysc";
    case RT305X_SOC_RT3350:
        return "ralink,rt3350-sysc";
    case RT305X_SOC_RT3352:
        return "ralink,rt3352-sysc";
    case RT305X_SOC_RT5350:
        return "ralink,rt5350-sysc";
    case MT762X_SOC_MT7620A:
        *idx =3D 2;
        return "ralink,mt7620a-sysc";
     case MT762X_SOC_MT7620N:
        *idx =3D 2;
        return "ralink,mt7620-sysc";
     case MT762X_SOC_MT7628AN:
        return "ralink,mt7628-sysc";
     case MT762X_SOC_MT7688:
       return "ralink,mt7688-sysc";
     default:
        *idx =3D -1;
        return "invalid";
  }
}

void __init plat_time_init(void)
{
    struct of_phandle_args clkspec;
    const char *compatible;
    struct clk *clk;
    int cpu_clk_idx;

    ralink_of_remap();

    compatible =3D clk_cpu(&cpu_clk_idx);
    if (cpu_clk_idx =3D=3D -1)
        panic("unable to get CPU clock index");

   of_clk_init(NULL);
   clkspec.np =3D of_find_compatible_node(NULL, NULL, compatible);
   clkspec.args_count =3D 1;
   clkspec.args[0] =3D cpu_clk_idx;
   clk =3D of_clk_get_from_provider(&clkspec);
   if (IS_ERR(clk))
       panic("unable to get CPU clock, err=3D%ld", PTR_ERR(clk));
   pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
   mips_hpt_frequency =3D clk_get_rate(clk) / 2;
   clk_put(clk);
   timer_probe();
}

Thanks,
    Sergio Paracuellos
>
> I guess it is not special but I cannot figure out the way of getting
> this clock using compatibles...
>
> >
> > Anyway, it is not a correct way to get clocks frequency. There is CCF
> > for this, although maybe Ralink does not support it?
>
> This means to use clk_get() if I understand properly but it does not
> work at all for ralink...
>
> >
> > Best regards,
> > Krzysztof
> >
>
> Thanks,
>     Sergio Paracuellos
