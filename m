Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8541652808
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiLTUoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiLTUoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:44:21 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A202CE1E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:44:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gt4so13649263pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFJ52Jvif4kqXh2cyc1/ZmoPfPIQip5jewjrb6LAFws=;
        b=Pd4ElttST4MpL9hibF2X3mMy+HUUfHhLj41kwyBAQaoYc1y2g0UHePF5FEZcnSduPY
         MLmI6S9+QF6SIny/exlAYN4fslzCVAhmMKqn/ZNFhkR3sWXpg9LXaLJ0+FxGo9hAO17v
         u4a/3gzKxYd16I/oOHmZQCuxu/S5Gihpx6O44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFJ52Jvif4kqXh2cyc1/ZmoPfPIQip5jewjrb6LAFws=;
        b=V2KDgwpSgkjcjVlumMc4lNr4cU5NIB5MpWGpw96+xoR1zP08NGtvZ08I8YjS2htWd6
         8BvuJPKiLJuYzAT0xwcY1FP9uMr+BhMF5eUpFdbDLN/c+btTiHZ65DuqxHtNM7yE9YWl
         ChJgijfXADa5WeZ+uvrVr12ib4A+AFhzqHm0/bu5dNEUldmyy3w3tacRPhCkKtlUD7Vj
         99N3gK+KLvoLSfzAfh8XkOtNMC16ubIptVNVn+XZgjQMKwzxWyXAHYFfHiWnYeP1Vg1T
         /qHOqjw6y6Sur6xUtW6MH6uUPU8GyWESzGC1bR/jJmZrWss3c+S7gVStiES9w8AkDl+F
         Cm9w==
X-Gm-Message-State: AFqh2kpPXbC3AtQ38cnOqw1052N5zJmyObipL4ANgHRf44TqAzzvIDJ6
        /JKjqarIprh/O4RHHhg21w+97RzVdhnBOwCW
X-Google-Smtp-Source: AMrXdXtY8jHjX3hCbl+H5A3IaUWbZ2g6RlDBSLQUai0Xl7ruTeRaFxjVnP5YYPxsjFxoxoiAm78IkA==
X-Received: by 2002:a17:902:e845:b0:187:3a79:6038 with SMTP id t5-20020a170902e84500b001873a796038mr20912825plg.18.1671569059685;
        Tue, 20 Dec 2022 12:44:19 -0800 (PST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com. [209.85.216.48])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902778f00b001891a17bd93sm9784340pll.43.2022.12.20.12.44.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 12:44:18 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id gt4so13649176pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:44:18 -0800 (PST)
X-Received: by 2002:a17:90a:9c09:b0:219:33a1:d05f with SMTP id
 h9-20020a17090a9c0900b0021933a1d05fmr1883291pjp.116.1671569057656; Tue, 20
 Dec 2022 12:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20221127-mtk-svs-v1-0-7a5819595838@chromium.org>
 <d683a2e7-b886-9bf6-27df-d8c67cedbbdd@collabora.com> <b8b14bcb-845f-aa18-f8aa-ad0bed9fb0bb@gmail.com>
 <52fb6ccf3fe1cb11f3e330ecc4d9c6cf1225c98a.camel@mediatek.com> <e0d3f5c7-6f6b-ee21-170c-51e5240de114@gmail.com>
In-Reply-To: <e0d3f5c7-6f6b-ee21-170c-51e5240de114@gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Dec 2022 21:44:06 +0100
X-Gmail-Original-Message-ID: <CANiDSCv-625Jt7KYe3QdHv1tmU2W_c5195T+SitSM1ROocbQ2g@mail.gmail.com>
Message-ID: <CANiDSCv-625Jt7KYe3QdHv1tmU2W_c5195T+SitSM1ROocbQ2g@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: mtk-svs: Enable the IRQ later
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger

Thanks for the heads up.

This is the tree that I am using to test this:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
3918592/7
( https://chromium.googlesource.com/chromiumos/third_party/kernel/+/3daf57d=
76c9e3d7c73d038ff2e43984412b503a2
)

You can use this tool for kexec:
https://chromium-review.googlesource.com/c/chromiumos/platform2/+/3953579

The syntax is kexec-lite  --reboot --kernel /boot/Image --cmdline
"$(cat /proc/cmdline)"

On Tue, 20 Dec 2022 at 15:50, Matthias Brugger <matthias.bgg@gmail.com> wro=
te:
>
>
>
> On 20/12/2022 12:03, Roger Lu (=E9=99=B8=E7=91=9E=E5=82=91) wrote:
> > Hi Matthias Sir,
> >
> > After applying this patch, SVS probes fail as below on my MT8192 platfo=
rm. If
> > thing isn't too late, please do not merge this patch. I'll ask Ricardo =
how to
> > reproduce this issue and give the correct solution. Thanks in advance.
> >
>
> Ok, I just dropped the patch from v6.2-tmp/soc branch.
>
> Regards,
> Matthias
>
> > #MT8192 platform SVS probe fail log
> > [   10.209430]  SVSB_GPU_LOW: init02 completion timeout
> > [   10.214402] mtk-svs 1100b000.svs: svs start fail: -16
> > [   10.219479] mtk-svs: probe of 1100b000.svs failed with error -16
> >
> > Hi Ricardo,
> >
> > Could you share us how you reproduce this issue? I have MT8192 Chromebo=
ok and
> > can give it a try to reproduce the issue you encountered. Thanks a lot.
> >
> > Sincerely,
> > Roger Lu.
> >
> > On Fri, 2022-12-16 at 13:47 +0100, Matthias Brugger wrote:
> >>
> >> On 30/11/2022 12:00, AngeloGioacchino Del Regno wrote:
> >> > Il 27/11/22 21:22, Ricardo Ribalda ha scritto:
> >> > > If the system does not come from reset (like when is booted via
> >> > > kexec()), the peripheral might triger an IRQ before the data struc=
tures
> >> > > are initialised.
> >> > >
> >> > > Fixes:
> >> > >
> >> > > [    0.227710] Unable to handle kernel NULL pointer dereference at
> >> > > virtual
> >> > > address 0000000000000f08
> >> > > [    0.227913] Call trace:
> >> > > [    0.227918]  svs_isr+0x8c/0x538
> >> > >
> >> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >> >
> >> > Reviewed-by: AngeloGioacchino Del Regno <
> >> > angelogioacchino.delregno@collabora.com>
> >> >
> >> >
> >>
> >> Applied thanks!
> >>
> >
> > ************* MEDIATEK Confidentiality Notice ********************
> > The information contained in this e-mail message (including any
> > attachments) may be confidential, proprietary, privileged, or otherwise
> > exempt from disclosure under applicable laws. It is intended to be
> > conveyed only to the designated recipient(s). Any use, dissemination,
> > distribution, printing, retaining or copying of this e-mail (including =
its
> > attachments) by unintended recipient(s) is strictly prohibited and may
> > be unlawful. If you are not an intended recipient of this e-mail, or be=
lieve
> > that you have received this e-mail in error, please notify the sender
> > immediately (by replying to this e-mail), delete any and all copies of
> > this e-mail (including any attachments) from your system, and do not
> > disclose the content of this e-mail to any other person. Thank you!



--=20
Ricardo Ribalda
