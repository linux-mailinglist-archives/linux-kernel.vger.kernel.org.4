Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D4A652877
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiLTViX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbiLTViO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:38:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49621EC68
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 13:38:12 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso112834pjh.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 13:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGBStJPQMoU1T93Q2AMWHFSr3O3MSy8/Uza6vrZKt84=;
        b=Bu+HQ4gHLIpW4V7dmMzGXkkKqSs4vm24OQBqjKeS2ixezSZx9ddk3CbItfbny7I565
         vChkh+mkHwcEvLjxtgVe0W9dApKHUCr9TSu3XLvapL9sHXfkxns5Zyh3HVaesGrfj9yf
         34+EP8ZoMPLSAJmrAWbRf0/Od/Id7Dm0PxA9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGBStJPQMoU1T93Q2AMWHFSr3O3MSy8/Uza6vrZKt84=;
        b=kCRYc1BUpCmVHYEwt+HIPh+nBDb9mEHQtwqhecuBu7VlTsjyeOoWOK8kfWlu9sHqnP
         03m1GHQOitVrCT4s9NtmAF6cybGPiSxTxdUS+9BYW8bjY4G67d8de0GVpCk/BJ37nh5l
         jcwdyON3te0n910X7VMbDHrVZSCOoQVv3YgskB8cmdJtHE2CKl8esKpeQ7qTZCtHsMkm
         r+UGKNlxrJv7TrbLxmcrHEZ+EkXIwbcFXt9jQknFsySNzZl3gYBGRbXXZVbEPOk9U2t5
         XiW0ZyA3xsRjxa385dbAMOc1MmcAX5e73J/HDyUJlsJ1M69CiKOqbDeBnKGbfp0yS9K/
         1QTA==
X-Gm-Message-State: ANoB5pm6USKNE7VMWmr+Cpug2IGt/dQaS6zdsCqvy3AMzfvElGnfzbFw
        mGMWMJ2+HPDOkmac2HvexvJrVxyXaT4CK4tgUwQ=
X-Google-Smtp-Source: AA0mqf6LZYAQcKN3Pv4EoZLY5Fqi2QCN++SbdyKv2YRWLQQPGzXbaD+ppMcS4agR8bnNBFNU4Z7NOA==
X-Received: by 2002:a17:902:e887:b0:189:e5c5:3a92 with SMTP id w7-20020a170902e88700b00189e5c53a92mr64318773plg.60.1671572292162;
        Tue, 20 Dec 2022 13:38:12 -0800 (PST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id t19-20020a170902b21300b001782a6fbcacsm9845302plr.101.2022.12.20.13.38.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 13:38:11 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so104527pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 13:38:10 -0800 (PST)
X-Received: by 2002:a17:903:446:b0:191:2a9b:ec94 with SMTP id
 iw6-20020a170903044600b001912a9bec94mr464516plb.8.1671572290248; Tue, 20 Dec
 2022 13:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20221127-mtk-svs-v1-0-7a5819595838@chromium.org>
 <d683a2e7-b886-9bf6-27df-d8c67cedbbdd@collabora.com> <b8b14bcb-845f-aa18-f8aa-ad0bed9fb0bb@gmail.com>
 <52fb6ccf3fe1cb11f3e330ecc4d9c6cf1225c98a.camel@mediatek.com>
 <e0d3f5c7-6f6b-ee21-170c-51e5240de114@gmail.com> <CANiDSCv-625Jt7KYe3QdHv1tmU2W_c5195T+SitSM1ROocbQ2g@mail.gmail.com>
In-Reply-To: <CANiDSCv-625Jt7KYe3QdHv1tmU2W_c5195T+SitSM1ROocbQ2g@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Dec 2022 22:37:58 +0100
X-Gmail-Original-Message-ID: <CANiDSCvQONPtvYzjhonAZMpsQqix5jQW_gPbAVqxLRQ4si1JJQ@mail.gmail.com>
Message-ID: <CANiDSCvQONPtvYzjhonAZMpsQqix5jQW_gPbAVqxLRQ4si1JJQ@mail.gmail.com>
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

Hi again Roger

I think I managed to reproduce your issue on an "asurada" Chromebook.

Sending a v2 of the patch.

Thanks again for the heads-up and sorry for the mess ;)

Thanks!

On Tue, 20 Dec 2022 at 21:44, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Roger
>
> Thanks for the heads up.
>
> This is the tree that I am using to test this:
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/=
+/3918592/7
> ( https://chromium.googlesource.com/chromiumos/third_party/kernel/+/3daf5=
7d76c9e3d7c73d038ff2e43984412b503a2
> )
>
> You can use this tool for kexec:
> https://chromium-review.googlesource.com/c/chromiumos/platform2/+/3953579
>
> The syntax is kexec-lite  --reboot --kernel /boot/Image --cmdline
> "$(cat /proc/cmdline)"
>
> On Tue, 20 Dec 2022 at 15:50, Matthias Brugger <matthias.bgg@gmail.com> w=
rote:
> >
> >
> >
> > On 20/12/2022 12:03, Roger Lu (=E9=99=B8=E7=91=9E=E5=82=91) wrote:
> > > Hi Matthias Sir,
> > >
> > > After applying this patch, SVS probes fail as below on my MT8192 plat=
form. If
> > > thing isn't too late, please do not merge this patch. I'll ask Ricard=
o how to
> > > reproduce this issue and give the correct solution. Thanks in advance=
.
> > >
> >
> > Ok, I just dropped the patch from v6.2-tmp/soc branch.
> >
> > Regards,
> > Matthias
> >
> > > #MT8192 platform SVS probe fail log
> > > [   10.209430]  SVSB_GPU_LOW: init02 completion timeout
> > > [   10.214402] mtk-svs 1100b000.svs: svs start fail: -16
> > > [   10.219479] mtk-svs: probe of 1100b000.svs failed with error -16
> > >
> > > Hi Ricardo,
> > >
> > > Could you share us how you reproduce this issue? I have MT8192 Chrome=
book and
> > > can give it a try to reproduce the issue you encountered. Thanks a lo=
t.
> > >
> > > Sincerely,
> > > Roger Lu.
> > >
> > > On Fri, 2022-12-16 at 13:47 +0100, Matthias Brugger wrote:
> > >>
> > >> On 30/11/2022 12:00, AngeloGioacchino Del Regno wrote:
> > >> > Il 27/11/22 21:22, Ricardo Ribalda ha scritto:
> > >> > > If the system does not come from reset (like when is booted via
> > >> > > kexec()), the peripheral might triger an IRQ before the data str=
uctures
> > >> > > are initialised.
> > >> > >
> > >> > > Fixes:
> > >> > >
> > >> > > [    0.227710] Unable to handle kernel NULL pointer dereference =
at
> > >> > > virtual
> > >> > > address 0000000000000f08
> > >> > > [    0.227913] Call trace:
> > >> > > [    0.227918]  svs_isr+0x8c/0x538
> > >> > >
> > >> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > >> >
> > >> > Reviewed-by: AngeloGioacchino Del Regno <
> > >> > angelogioacchino.delregno@collabora.com>
> > >> >
> > >> >
> > >>
> > >> Applied thanks!
> > >>
> > >
> > > ************* MEDIATEK Confidentiality Notice ********************
> > > The information contained in this e-mail message (including any
> > > attachments) may be confidential, proprietary, privileged, or otherwi=
se
> > > exempt from disclosure under applicable laws. It is intended to be
> > > conveyed only to the designated recipient(s). Any use, dissemination,
> > > distribution, printing, retaining or copying of this e-mail (includin=
g its
> > > attachments) by unintended recipient(s) is strictly prohibited and ma=
y
> > > be unlawful. If you are not an intended recipient of this e-mail, or =
believe
> > > that you have received this e-mail in error, please notify the sender
> > > immediately (by replying to this e-mail), delete any and all copies o=
f
> > > this e-mail (including any attachments) from your system, and do not
> > > disclose the content of this e-mail to any other person. Thank you!
>
>
>
> --
> Ricardo Ribalda



--=20
Ricardo Ribalda
