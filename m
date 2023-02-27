Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D346A407E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjB0LWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjB0LWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:22:17 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420571E297
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:22:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cy6so24317984edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuW3scZHE2qMIgtFav0tuZiA0IMLEVnQDpbtGr6T0Gw=;
        b=rNlxQQUOx7dVy6M2Z8ycX1fJmg8tUUKIH3s4Qlh4bIY/1L+x1oxqhlP7V9uFWJX8kv
         cBwFIP/yv0+pF4D0KH2+LoVhr13DnA7Ios8a6oLMt+s4mOcYEYL0TXKuEy6UvwW2dw+i
         J92QUwacdJfKIGUEhZwEG6GyjB/RvR2W4SVDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuW3scZHE2qMIgtFav0tuZiA0IMLEVnQDpbtGr6T0Gw=;
        b=N5WzWGFWjE39z8m0hwuFLT7eHp+DKAl+ektRkm2rDhkvooiKp2jyPYFynbIx1mXqef
         KffcejISw8o9Vna9dCJdi09Txh/kZUjEb4umPCgxVTa0wGKXXeIRnMH6W4fXcCBhGd+u
         WPesLrOzXlIi0CL9YpKIB/RZB/S4/hbDCb4Dsv+SW/MHu1LKQMHoJ7g/8XUmCa8SVPTG
         wP4COUJZQXVMj32uFmSqxEDoeERyU32bLeUqDTCW5VL2W+e2XRDV8COjwe7+rNmWwdWe
         Wes4egpDLhzIJV8nK4S+YmKpUf2sj10XmMs/NEt3ayKV+mOTlozpNeN3R/Zg8Galc0Ke
         6Njw==
X-Gm-Message-State: AO0yUKV5cqX8OYhmPLNYpvIJD/rW5Gnhq1KtVYLmc0wW7i3YVsrSxsQv
        qwtVG/Ajj4lZmXt0MubVdmugvVDkcDJzfi/GOnqItQ==
X-Google-Smtp-Source: AK7set+NST0tU95K/hcnvFxkA+frcNPo5jFrZM4yJiD8J/K/tyv/ByDI/Wz689ivuK6NQRsTfokduGioM6mvK9Bq3uI=
X-Received: by 2002:a50:d544:0:b0:4ad:6e3e:7da6 with SMTP id
 f4-20020a50d544000000b004ad6e3e7da6mr11797961edj.6.1677496934725; Mon, 27 Feb
 2023 03:22:14 -0800 (PST)
MIME-Version: 1.0
References: <CAOf5uwns3YZMY5xhM+o0rNvtTqEDwCbua5HuSy-LBwgZq_eWYg@mail.gmail.com>
 <DB7PR04MB4010D6ABA0D10AB826F468CC90C29@DB7PR04MB4010.eurprd04.prod.outlook.com>
 <CAOf5uwmaP0x3s7W6OZaCfLmJguSMtKtJtLCgKZ2nuDZ9VgpLVg@mail.gmail.com>
In-Reply-To: <CAOf5uwmaP0x3s7W6OZaCfLmJguSMtKtJtLCgKZ2nuDZ9VgpLVg@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 27 Feb 2023 12:22:03 +0100
Message-ID: <CAOf5uwnuFBXF52Tbe7EFXcjzjbr-oOhn-fDVw=p8uZ8Y_Z7v+Q@mail.gmail.com>
Subject: Re: NXP imx6ull nonalignment buffer question
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bough

On Fri, Jan 13, 2023 at 8:19=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Fri, Jan 13, 2023 at 4:30 AM Bough Chen <haibo.chen@nxp.com> wrote:
> >
> > > -----Original Message-----
> > > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > > Sent: 2023=E5=B9=B41=E6=9C=889=E6=97=A5 21:02
> > > To: Bough Chen <haibo.chen@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
> > > Fabio Estevam <festevam@gmail.com>; LKML <linux-kernel@vger.kernel.or=
g>
> > > Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>;
> > > linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>
> > > Subject: NXP imx6ull nonalignment buffer question
> > >
> > > Hi Haibo
> > >
> > > Working on imx6ulz design and found that if I send a sdio packet usin=
g the
> > > sdio_writesb the adma driver tries to handle it with two dma descript=
ors. The
> > > first one filled with the bytes up to 3 to cover the misalign and the=
n another
> > > buffer descriptor
> > >
> > >   offset =3D (SDHCI_ADMA2_ALIGN - (addr & SDHCI_ADMA2_MASK)) &
> > >                          SDHCI_ADMA2_MASK;
> > >                 if (offset) {
> > >                         if (data->flags & MMC_DATA_WRITE) {
> > >                                 buffer =3D sdhci_kmap_atomic(sg);
> > >                                 memcpy(align, buffer, offset);
> > >                                 sdhci_kunmap_atomic(buffer);
> > >                         }
> > >
> > >                         /* tran, valid */
> > >                         __sdhci_adma_write_desc(host, &desc,
> > > align_addr,
> > >                                                 offset,
> > > ADMA2_TRAN_VALID);
> > >
> > >                         BUG_ON(offset > 65536);
> > >
> > >                         align +=3D SDHCI_ADMA2_ALIGN;
> > >                         align_addr +=3D SDHCI_ADMA2_ALIGN;
> > >
> > >                         addr +=3D offset;
> > >                         len -=3D offset;
> > >                 }
> > >
> > > In 48.7.4 Data Length Setting
> > > For either ADMA (ADMA1 or ADMA2) transfer, the data in the data buffe=
r must
> > > be word aligned, so the data length set in the descriptor must be a m=
ultiple of 4.
> > > I have noticed that this code does not work as expected.
> >
> > Hi Michael,
> >
> > My understanding is: for the sentence " the data in the data buffer mus=
t be word aligned", this means the start address of the data must be word a=
ligned, but not limit the data length.
> >
>
> Ok. My specific problem is that this seems not working on imx6ulz, I
> found the problem working on a wifi chipset, if the request gets split
> for no-alignment
> of the data in two dma descriptors, the chipset does not reply to me.
> Anyway, I will retest it with the upstream kernel again. I will check
> better and I will follow up if any more question
>

I have done some tests and I need this quirk
SDHCI_QUIRK_32BIT_ADMA_SIZE on imx6ulz cpu and I think that it applies
even on imx6ull.
Wifi can work only if the data on the sdio are aligned or we use
interrupt mode for no-alignment data. I did not find an errata and I
can not add as a quirk without a confirmation

Michael
