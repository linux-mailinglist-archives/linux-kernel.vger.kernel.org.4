Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8A263B4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiK1WOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiK1WOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:14:51 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0BD1B0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:14:50 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n188so8731861iof.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRCP5i+kS7Z6U29Z84RcTfhHLs05Gmm0hutojax5sCQ=;
        b=j8VmxmloAfeZxEA3bXqzHAqH4WWzlyvDlESJv713QjFWvS1Hn8f7Ue3yiGK6JHS/Ue
         Zh4TzPaicWn/3R0FGXzTUisHAPSpFYj2QVIQjjccPUTBGCOh31fWgWZmgg1nf5dgXnb5
         ePvpR9jbLcUt2+vJDPVM5E3gfYIj6NrTmNdYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRCP5i+kS7Z6U29Z84RcTfhHLs05Gmm0hutojax5sCQ=;
        b=zpol8DD9+VPW2MmvbkPOFF9G0K6udaLVurr4MBcy9u4tiiE6VVdOqLwqR1sYkdQsF4
         yFYd4HC1B+TqhPefLVk5/EBQRaFXqZO7RsJ0O76BoztgxI+6GMpvj5r3PG0Y/9ti66yY
         UprmSXkMkYBGt8sqsUunD66KOzQEeSFPYoWH7p2Aj3eLAMEUJrcCp3dWK9E3R6QpctXO
         wAW/uXfgng+VmHk5cauCgVoM/K7bnzvNI3FJC2qzJgrRkgESUwjGzDpnsf9WexA98lkk
         T3HLcddfK2tkHdH8NnMZmzJbgR/AY3QHTBnZgDV6M2r6kt6DPOz+JQNN2waHyi6ol8SV
         mP/g==
X-Gm-Message-State: ANoB5pl/dk7xhN8/qkjLtXHD52kGm+tWUekYlqw+sDnfYYG4QdmVGIPX
        8r5nfbYWyxYtwJXyDzLNz6PX25YVvxKPZfWO
X-Google-Smtp-Source: AA0mqf76huWWbwQkN/tuL4Xcqb7GnEi436n8WdpjP5jhqK00OGU2eR5cgngpAOuI2o0pTWunDvNQng==
X-Received: by 2002:a02:ad09:0:b0:363:ba2d:fe04 with SMTP id s9-20020a02ad09000000b00363ba2dfe04mr24818956jan.226.1669673690058;
        Mon, 28 Nov 2022 14:14:50 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id d74-20020a02624d000000b00363e4730a41sm4648093jac.175.2022.11.28.14.14.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 14:14:49 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id h206so8738586iof.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:14:49 -0800 (PST)
X-Received: by 2002:a05:6638:11d3:b0:389:ebdc:8f4 with SMTP id
 g19-20020a05663811d300b00389ebdc08f4mr530772jas.27.1669673688675; Mon, 28 Nov
 2022 14:14:48 -0800 (PST)
MIME-Version: 1.0
References: <20221125-mtk-iommu-v1-0-bb5ecac97a28@chromium.org> <9e81fb3cc4f315f330c610dfb16bad50b7241f4c.camel@mediatek.com>
In-Reply-To: <9e81fb3cc4f315f330c610dfb16bad50b7241f4c.camel@mediatek.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 28 Nov 2022 23:14:37 +0100
X-Gmail-Original-Message-ID: <CANiDSCv_ZBLFTp42AZz9Td_JCR0MKLooW2gtFo3woT-dOQtm8w@mail.gmail.com>
Message-ID: <CANiDSCv_ZBLFTp42AZz9Td_JCR0MKLooW2gtFo3woT-dOQtm8w@mail.gmail.com>
Subject: Re: [PATCH] iommu/mediatek: Fix crash on isr after kexec()
To:     =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
Cc:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
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

Hi Yong


On Mon, 28 Nov 2022 at 07:44, Yong Wu (=E5=90=B4=E5=8B=87) <Yong.Wu@mediate=
k.com> wrote:
>
> On Fri, 2022-11-25 at 17:28 +0100, Ricardo Ribalda wrote:
> > If the system is rebooted via isr(), the IRQ handler might be
> > triggerd
> > before the domain is initialized. Resulting on an invalid memory
> > access
> > error.
> >
> > Fix:
> > [    0.500930] Unable to handle kernel read from unreadable memory at
> > virtual address 0000000000000070
> > [    0.501166] Call trace:
> > [    0.501174]  report_iommu_fault+0x28/0xfc
> > [    0.501180]  mtk_iommu_isr+0x10c/0x1c0
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > To: Yong Wu <yong.wu@mediatek.com>
> > To: Joerg Roedel <joro@8bytes.org>
> > To: Will Deacon <will@kernel.org>
> > To: Robin Murphy <robin.murphy@arm.com>
> > To: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: iommu@lists.linux.dev
> > Cc: linux-mediatek@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/iommu/mtk_iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 2ab2ecfe01f8..17f6be5a5097 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -454,7 +454,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void
> > *dev_id)
> >               fault_larb =3D data->plat_data-
> > >larbid_remap[fault_larb][sub_comm];
> >       }
> >
> > -     if (report_iommu_fault(&dom->domain, bank->parent_dev,
> > fault_iova,
> > +     if (dom && report_iommu_fault(&dom->domain, bank->parent_dev,
> > fault_iova,
>
>
> Which SoC does this issue happen? Does this issue is happened in the
> upstream kernel or the downstream kernel?

I am using chromeos-5.10 and chromeos-5.15 (which are pretty much upstream)=
.

I have seen this issue at least with MT8195 and MT8183


>
> Normally each port enable the iommu defaultly. Let's print the error
> log even though "dom" is null to check which port fail here. then
> analyse the port's behavior.
>
> if (!dom || report_iommu_fault(xx))
>      dev_err_ratelimited(xx)

sending a v2 with the change.

Thanks!


>
> >                              write ? IOMMU_FAULT_WRITE :
> > IOMMU_FAULT_READ)) {
> >               dev_err_ratelimited(
> >                       bank->parent_dev,
> >
> > ---
> > base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> > change-id: 20221125-mtk-iommu-13023f971298
> >
> > Best regards,



--=20
Ricardo Ribalda
