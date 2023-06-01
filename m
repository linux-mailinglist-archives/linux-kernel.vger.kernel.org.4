Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F6171F320
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjFATli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFATlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:41:36 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B8B189;
        Thu,  1 Jun 2023 12:41:35 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2af316b4515so18127391fa.1;
        Thu, 01 Jun 2023 12:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685648493; x=1688240493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOefF1RvR5DKubBAm6OxHlMrlAp/F0A3Hij/nZ8UEGc=;
        b=RXNGpoUIp21qcF8zs+KFt7zYPSG7+HlGDFgXFDsGcDNdwk0OW8pMmvMgN8VBncf3t9
         Ob3/ibn/e11ASdNLrRFmG935e1N7UFCBJWy6l0rh1f0FE4GSxl4oCSpsN+RhVunZW6V+
         quIeOidF5lmdrpk67yK2MY8mDitzxF3DcQDMbtOQ1HVQgXtedUvk6/bn0pOcc/7PBUxE
         KsQP72uYDu1l23GSNA54vjhmJwwwqax95sjorrfceOENnl3xbyUiiQm1z3vfOPddctrP
         6DgR1uZLtGzYdm2ZjhsnMyfAFSapuctMSY/voqvYnJhqKmo8rHxD5WOvfBrFYV3WSiDo
         bjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685648493; x=1688240493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOefF1RvR5DKubBAm6OxHlMrlAp/F0A3Hij/nZ8UEGc=;
        b=UuUfIShFBlMa1aob3GRlP/bfGi/94KOwYFuT/UTt5KodtICqGedQXPgeBmcE3EVZcF
         i6nwVm9Gmhq4n2lBZ/Ms5gvPevQXkGkQBhbNqVTf9+LLJccK6J6yyCt0WInEZ6yOKQHK
         LG8WSvf1J1uTW4nRCcjiSa8r5p1XfNSGXA/wf73AJOZkvMJindyLC7ePzo/TtA7Fhbo7
         gg6ZFYXwqhqWsFzQkV4W8p/jcO83B4ForU3N5eyzkhFrpVvIiWRroYCWCtDIGelov9EX
         UtfuZM0+2g//aRI3VJ/z5rSZg6VhkIV22dhVXCXI7LiNIt4IsYU/nPA88cBY8UBDqTy6
         Gohw==
X-Gm-Message-State: AC+VfDzMxCLOU59atgXpMxfNZaLpKEo3+XomJ4l3crY0tGORbMJoCylA
        Lf0d3cZx7EERUvOY4KwTdsM=
X-Google-Smtp-Source: ACHHUZ6x3KIW69nM/pmEyLwFVAPLFhxWlHOmA/vqeVYEMWcA3V8UIVzrIR6dNphFCH/yXweO5GLHEg==
X-Received: by 2002:a2e:96cb:0:b0:2aa:40dd:7a55 with SMTP id d11-20020a2e96cb000000b002aa40dd7a55mr308567ljj.8.1685648492634;
        Thu, 01 Jun 2023 12:41:32 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090627c300b0096a1ba4e0d1sm10909812ejc.32.2023.06.01.12.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 12:41:31 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Frank Oltmanns <frank@oltmanns.dev>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH 0/3] clk: sunxi-ng: Optimize rate selection for NKM clocks
Date:   Thu, 01 Jun 2023 21:41:30 +0200
Message-ID: <4831731.31r3eYUQgx@jernej-laptop>
In-Reply-To: <87mt1jbf18.fsf@oltmanns.dev>
References: <20230527132747.83196-1-frank@oltmanns.dev>
 <flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwfiuznk@eewnnut5mvsq>
 <87mt1jbf18.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 01. junij 2023 ob 07:16:45 CEST je Frank Oltmanns napisal=
(a):
> Hi Maxime,
>=20
> On 2023-05-31 at 15:48:43 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> > [[PGP Signed Part:Undecided]]
> > Hi Frank,
> >
> > On Sat, May 27, 2023 at 03:27:44PM +0200, Frank Oltmanns wrote:
> >> I would like to bring your attention to the current process of setting
> >> the rate of an NKM clock. As it stands, when setting the rate of an
> >> NKM clock, the rate nearest but less than or equal to the requested
> >> rate is found, instead of the nearest rate.
> >
> > Yeah, it's actually pretty common, see clk_mux_determine_rate_flags()
> > for example. Some devices require that we don't overshoot, while some
> > prefer to have the closest rate.
> >
> > Both are fine, and it's a bit context specific which one we should
> > favour. If we were to do anything, it would be to support both and let
> > the clock driver select which behaviour it wants.
> >
>=20
> Ok, understood. Thank you for the explanation! Now, I'm wondering if
> anyone would be using such a flag, if I added it.
>=20
> >
> >> Moreover, ccu_nkm_find_best() is called multiple times (footnote [1])
> >> when setting a rate, each time iterating over all combinations of n,
> >> k, and m.
> >
> > Yeah, that's expected as well.
>=20
> I'm wondering though, if iterating over all combinations is set in
> stone, or if some kind of optimization would be in order.
>=20
> >
> >> In response to this, I propose the following refinements to optimize t=
he NKM
> >> clock setting:
> >>  a. when finding the best rate use the nearest rate, even if it is gre=
ater than
> >>     the requested rate (PATCH 1)
> >>  b. utilize binary search to find the best rate by going through a
> >>     precalculated, ordered list of all meaningful combinations of n, k=
, and m
> >>     (PATCH 2)
> >
> > One thing you haven't really addressed is why we would be doing this? Is
> > there some clocks that require a more precise clock and don't? Is the
> > factor calculation a bottleneck for some workloads?
>=20
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I'm a pinephone user (ccu-sun50i-a64). I'm using U-Boot which sets the
> pll-video0 to 294 MHz on boot. The phone's panel requires DCLK to run at
> 108 MHz to get a nice 60 Hz vertical refresh rate. The clock structure
> is this:
>=20
>     clock                       clock type
>     --------------------------------------
>     pll-video0                  ccu_nm
>        pll-mipi                 ccu_nkm
>           tcon0                 ccu_mux
>              tcon-data-clock    sun4i_dclk
>=20
> The divider between tcon0 and tcon-data-clock is fixed at 4. So, I need
> pll-mipi to run at 432 MHz to get the desired vertical refresh rate.
> When pll-vdeo0 is at 294 MHz this is that rate cannot be matched exactly
> with any combination. The best we can get is 431.2 MHz (n=3D11, k=3D2,
> m=3D15).
>=20
> The pinephone has some "vendor" patches (megi kernel) that
>  a. add HDMI
>  b. allow re-setting pll-mipi's rate when pll-video0 changes
>=20
> Re: Who needs a more precise clock?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> When plugging in HDMI, pll-video's rate is set to 297 MHz, which - in
> the vendor kernel, not mainline - triggers recalculation of pll-mipi
> (trying to set it to 431.2 MHz). It ends up with a rate of 424.285714
> MHz, because this is the nearest, but less than 431.2 MHz (n=3D5, k=3D2,
> m=3D7). The nearest rate would be 432 MHz.
>=20
> So, while analyzing the whole situation that I described above, I found
> out that the NKM clocks are not set to the closest rate and wondered why
> that is. Hence my request for comments.
>=20
> Now, one could argue that pll-video0 should be set to 297MHz at boot or
> that pll-mipi should try to set the *requested* rate instead of the
> previous rate when the pll-video0 changes. And I think that both are
> valid or even better approaches than my proposal in this RFC to address
> this specific problem and I'll probably sent patches to discuss this as
> well.

Ideally, clock rate setting code should be immune on "initial" values, set =
by
bootloader or default values. If it's not, then it should be improved in the
way that it is.

>=20
>=20
> Re: Why speed up factor calculation?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I'm not aware that the current implementation of calculating n, k, and m
> poses a bottleneck in any situation. Again, while going through the
> code, I wondered why not save a few CPU cycles by precalculating the
> meaningful combinations. In my opinion, it does not have any side
> effects, so we might as well do it. (There is of course the side effect
> of using a higher rate, but this is unrelated to precalculation as I
> could as well employ a rate comparison that only allows lower rates, or
> only optionally higher rates.)
>=20
> > Clocks in general are very regression-prone, so I'd rather be a bit
> > conservative there, and "if it ain't broke, don't fix it".
>=20
> Sure, I get that.
>=20
> As I stated in my cover letter:
> "The motivation for these proposed changes lies in the current behavior
> of rate selection for NKM clocks, which doesn't observe the
> CLK_SET_RATE_PARENT flag. I.e. it does not select a different rate for
> the parent clock to find the optimal rate."
>=20
> I thought that this required this optimization to be implemented, but by
> now, I'm no longer sure. I'll probably continue investigating different
> paths for CLK_SET_RATE_PARENT for NKM clocks and follow up with new
> findings.

Let's leave out any optimizations that are not apparently needed. Most clock
rates are set only once at boot and others, like video clocks, not that oft=
en,
so a suboptimal code speed doesn't hurt currently.

Best regards,
Jernej

>=20
> Thanks,
>   Frank
>=20
> >
> > Maxime
> >
> > [[End of PGP Signed Part]]
>=20




