Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EAE6ADABE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCGJo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCGJot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:44:49 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134C84C6DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:44:44 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id f23so11733995vsa.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678182283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//cYdkbYFLjikSLrQMK52LAnpkQRDpOmX2g1yW5gAEM=;
        b=ECn30YO1MEaRGU7MgUmW3hhEOL9fYlUfG4f1CoC7fkpcA+EPGildLtMtol6XhV6xsa
         D2V3QeQXyUC8ViK3lLMGs4iWryPCTzni+gFahSbT3qyXkLth7OZm1BgNY4kO6vRUbMus
         fXJsvX8Z5pgSrZnls4oTHvoruKIoPJpQFxYQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678182283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//cYdkbYFLjikSLrQMK52LAnpkQRDpOmX2g1yW5gAEM=;
        b=J33HI2QuM70aYdtFKVTdlFtAzY73clmAJhTjYuKpSqw1GJpZ3paShgHBK85pBzZ5gi
         WO5B2V0DBttEz6mjKfrG4hNDHcpRps/ZORVsTfqNOE2X8G9e584NNhO7DNumGhDmc+VS
         OBJzWULOAu0mBVhd1l933G5wME2C1fXPMRRKwcE9G10L40Z9wYDi0rgYZ41YYBUGsmon
         3b3gfmT7mRpCZxM3LYlFJcM+UBGt87NKCBDu23rXKLF1SmthLZNu8cnDbQ2/PfRx3JQe
         S/uOG7IWzKDn129ggiorgSpbkWl6FIQQF6WpkOyxIM8hIlp9cEUg4ZmrFNfiPl+ciVIj
         6EeA==
X-Gm-Message-State: AO0yUKXCqCQ6sMcidg00oc8cW/UU0rRrVIJ9KvjPF9w4NRhqFFaTlQ5H
        PpNBNrEcKSeZFZRTwTs+BHkJYtek8hDL92U3ypRRgw==
X-Google-Smtp-Source: AK7set/1eEgQqC8T0I7qSYCA34Qq3DGlXqTOrAUPGOGCAvlEKAqRKkYJEV/Zy1k3IPgIz9XnkV8pcIYHwdVRMHK8Pi4=
X-Received: by 2002:a67:e3cb:0:b0:421:e25b:3d0c with SMTP id
 k11-20020a67e3cb000000b00421e25b3d0cmr3355189vsm.3.1678182283170; Tue, 07 Mar
 2023 01:44:43 -0800 (PST)
MIME-Version: 1.0
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
 <20230301095523.428461-13-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GHdtbheL6wxtDo-szk+=3BGk2z93SBowd4Z=E9XupZkw@mail.gmail.com>
 <5dba27e1-d480-ea24-c1ba-03bb7f77b1b1@collabora.com> <CAGXv+5FwNfZ7TwKVMM5_uAjYQ6ZmhZVFsWREb_da-jxC6EUVJw@mail.gmail.com>
 <CAGXv+5F8A4kLq3y8dE4mrcVb338-afDorWsS5MRBvWVPgiAhEA@mail.gmail.com> <e1b9d901-421c-3509-c92a-c59d49ff2b0d@collabora.com>
In-Reply-To: <e1b9d901-421c-3509-c92a-c59d49ff2b0d@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 17:44:32 +0800
Message-ID: <CAGXv+5EcAMmGro9UFLmQvkgcBykS9rsUdF_YsdbRUbtipfEFJA@mail.gmail.com>
Subject: Re: [PATCH v4 12/19] arm64: dts: mediatek: mt8192-asurada: Couple
 VGPU and VSRAM_OTHER regulators
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 5:30=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/03/23 10:24, Chen-Yu Tsai ha scritto:
> > On Fri, Mar 3, 2023 at 12:09=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.or=
g> wrote:
> >>
> >> On Thu, Mar 2, 2023 at 6:17=E2=80=AFPM AngeloGioacchino Del Regno
> >> <angelogioacchino.delregno@collabora.com> wrote:
> >>>
> >>> Il 02/03/23 11:03, Chen-Yu Tsai ha scritto:
> >>>> On Wed, Mar 1, 2023 at 5:55=E2=80=AFPM AngeloGioacchino Del Regno
> >>>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>>>
> >>>>> Add coupling for these regulators, as VSRAM_OTHER is used to power =
the
> >>>>> GPU SRAM, and they have a strict voltage output relation to satisfy=
 in
> >>>>> order to ensure GPU stable operation.
> >>>>> While at it, also add voltage constraint overrides for the GPU SRAM
> >>>>> regulator "mt6359_vsram_others" so that we stay in a safe range of
> >>>>> 0.75-0.80V.
> >>>>>
> >>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregn=
o@collabora.com>
> >>>>> ---
> >>>>>    arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 9 +++++++++
> >>>>>    1 file changed, 9 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arc=
h/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> >>>>> index 8570b78c04a4..f858eca219d7 100644
> >>>>> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> >>>>> @@ -447,6 +447,13 @@ &mt6359_vrf12_ldo_reg {
> >>>>>           regulator-always-on;
> >>>>>    };
> >>>>>
> >>>>> +&mt6359_vsram_others_ldo_reg {
> >>>>> +       regulator-min-microvolt =3D <750000>;
> >>>>> +       regulator-max-microvolt =3D <800000>;
> >>>>> +       regulator-coupled-with =3D <&mt6315_7_vbuck1>;
> >>>>> +       regulator-coupled-max-spread =3D <10000>;
> >>>>
> >>>> Looking again at the downstream OPP table, it seems there's no volta=
ge
> >>>> difference requirement. It only needs V_SRAM >=3D V_GPU. Same applie=
s to
> >>>> MT8195. Looks like only MT8183 and MT8186 need V_SRAM - V_GPU >=3D 1=
0000.
> >>>
> >>> On MT8195 we don't need any regulator coupling. There, the GPU-SRAM v=
oltage
> >>> is fixed at .. I don't remember, 0.7V? - anyway - MT8195 doesn't need=
 to
> >>> scale the vsram.
> >>
> >> Looks like it's fixed at 0.75V. I guess we're Ok on MT8195.
> >>
> >>>>
> >>>> Would setting max-spread to 0 work? I ask because with both regulato=
r's
> >>>> maximum voltage set to 0.8V, there's no way we can reach the highest
> >>>> OPP.
> >>>>
> >>>
> >>> No that doesn't work. I can raise the Vgpu max voltage to 0.88V to so=
lve the
> >>> issue right here and right now, or we can leave it like that and revi=
sit it
> >>> later.
> >>>
> >>> I would at this point go for setting mt6315_7_vbuck1's max-microvolt =
to
> >>> 880000, as this is the maximum recommended voltage for the GPU as per=
 the
> >>> MT8192 datasheet, it would also make sense as we would be still descr=
ibing
> >>> the hardware in a correct manner.
> >>>
> >>> What do you think?
> >>
> >> If it's just to accommodate the coupler stuff, I say just set the maxi=
mum
> >> at the lowest possible setting that satisfies the coupler constraint a=
nd
> >> granularity of the regulator. The regulator does 6250 uV steps, so I g=
uess
> >> we could set the maximum at 812500 uV, with a comment stating the nomi=
nal
> >> voltage of 800000 uV and that the extra 12500 uV is to workaround coup=
ler
> >> limitations.
> >>
> >> Does that sound OK?
> >
> > Even without changing anything, the coupler seems to work OK:
> >
> >   vsram_others                     1    1      0  normal   800mV
> > 0mA   750mV   800mV
> >      10006000.syscon:power-controller-domain   1
> >           0mA     0mV     0mV
> >   Vgpu                             2    2      0  normal   800mV
> > 0mA   606mV   800mV
> >      13000000.gpu-mali             1
> > 0mA   800mV   800mV
> >      10006000.syscon:power-controller-domain   1
> >           0mA     0mV     0mV
> >
> > Am I missing something?
> >
>
> I don't think you are... I may be getting confused by all of the changese=
ts
> that I'm pushing at once.
>
> Hence, is this commit fine as it is?

It works for some reason. Maybe it's a bug in the coupler. Either way I
think it works, even though the numbers might be a bit off. We can revisit
it later.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
