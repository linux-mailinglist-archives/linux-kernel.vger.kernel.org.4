Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFBE668F38
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbjAMH0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjAMHZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:25:42 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDA534749
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:19:52 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v10so28786001edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpXLHrg8X0CGU6JDii/ohDZ9K/nd3cxPDJslReflqhY=;
        b=ehe9mwAR5ZA5cDQuVHFHDRchLkfrmo3peGHkDc0PFG5s0Upfmnko1VLDA+CWvB1J5v
         RRFHV/PPqwMe8sV7rxbCD27+WnACTn87EFaP+aYY7rAGw93+sCDFbNKrXQiAHzBKBW9Z
         4IjVj0tbW1Oo8qo5jMRx7fC6gfss50Btap5WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpXLHrg8X0CGU6JDii/ohDZ9K/nd3cxPDJslReflqhY=;
        b=gJCRNec8ASUhK4DBvtB4AeAXAwJWt/E+q78AyycDgp2BH9ClX0dbSEd6YKYUjuqedb
         sIEl86VK83g5qY0hSMIR7PMOtcWkhrr/32kRefHp0FEWV5CmPM8wBT4WdbVxMSb76WvB
         qG7SJKVYFU7Gw7EJYIK431qELmdYk6VqmURdgMMmw2oRxQU+QPzTk4RyQWgalDA9nztr
         x7iHJZ4L71HexS35I0twnbCo9TB+WZwpcYVhwpk4tPBUtFMwO244fIhSlVFbCyf52eiI
         IndQ0WA2ieFt6nLwgWGvMVlR6Dsl9MRO/lJebr4eoVV4l38hDluHi6mHPag/ai+SDg3s
         URNw==
X-Gm-Message-State: AFqh2kotKI7WK1ns1Df4CJBijLp3AbsgWpQuFwgoigrdYQjPeVl8UyD7
        YRDdvamIfdvOwOaxDWeBsLXNi/eUOFbzrDDTPXn6rw==
X-Google-Smtp-Source: AMrXdXs9143abyTWHtHNY5LHnX/w6oQ4m5L/dgDdGys9klvHOQFzzvk3yR3WZdd/+Kl7n1QvVTdml6OSgSBqEZ3r5Zg=
X-Received: by 2002:a05:6402:1619:b0:499:bbb0:7f3e with SMTP id
 f25-20020a056402161900b00499bbb07f3emr2072687edv.104.1673594390525; Thu, 12
 Jan 2023 23:19:50 -0800 (PST)
MIME-Version: 1.0
References: <CAOf5uwns3YZMY5xhM+o0rNvtTqEDwCbua5HuSy-LBwgZq_eWYg@mail.gmail.com>
 <DB7PR04MB4010D6ABA0D10AB826F468CC90C29@DB7PR04MB4010.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB4010D6ABA0D10AB826F468CC90C29@DB7PR04MB4010.eurprd04.prod.outlook.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Fri, 13 Jan 2023 08:19:39 +0100
Message-ID: <CAOf5uwmaP0x3s7W6OZaCfLmJguSMtKtJtLCgKZ2nuDZ9VgpLVg@mail.gmail.com>
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

Hi

On Fri, Jan 13, 2023 at 4:30 AM Bough Chen <haibo.chen@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > Sent: 2023=E5=B9=B41=E6=9C=889=E6=97=A5 21:02
> > To: Bough Chen <haibo.chen@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
> > Fabio Estevam <festevam@gmail.com>; LKML <linux-kernel@vger.kernel.org>
> > Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>;
> > linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>
> > Subject: NXP imx6ull nonalignment buffer question
> >
> > Hi Haibo
> >
> > Working on imx6ulz design and found that if I send a sdio packet using =
the
> > sdio_writesb the adma driver tries to handle it with two dma descriptor=
s. The
> > first one filled with the bytes up to 3 to cover the misalign and then =
another
> > buffer descriptor
> >
> >   offset =3D (SDHCI_ADMA2_ALIGN - (addr & SDHCI_ADMA2_MASK)) &
> >                          SDHCI_ADMA2_MASK;
> >                 if (offset) {
> >                         if (data->flags & MMC_DATA_WRITE) {
> >                                 buffer =3D sdhci_kmap_atomic(sg);
> >                                 memcpy(align, buffer, offset);
> >                                 sdhci_kunmap_atomic(buffer);
> >                         }
> >
> >                         /* tran, valid */
> >                         __sdhci_adma_write_desc(host, &desc,
> > align_addr,
> >                                                 offset,
> > ADMA2_TRAN_VALID);
> >
> >                         BUG_ON(offset > 65536);
> >
> >                         align +=3D SDHCI_ADMA2_ALIGN;
> >                         align_addr +=3D SDHCI_ADMA2_ALIGN;
> >
> >                         addr +=3D offset;
> >                         len -=3D offset;
> >                 }
> >
> > In 48.7.4 Data Length Setting
> > For either ADMA (ADMA1 or ADMA2) transfer, the data in the data buffer =
must
> > be word aligned, so the data length set in the descriptor must be a mul=
tiple of 4.
> > I have noticed that this code does not work as expected.
>
> Hi Michael,
>
> My understanding is: for the sentence " the data in the data buffer must =
be word aligned", this means the start address of the data must be word ali=
gned, but not limit the data length.
>

Ok. My specific problem is that this seems not working on imx6ulz, I
found the problem working on a wifi chipset, if the request gets split
for no-alignment
of the data in two dma descriptors, the chipset does not reply to me.
Anyway, I will retest it with the upstream kernel again. I will check
better and I will follow up if any more question

Thank you

> Best Regards
> Haibo Chen
> >
> > Did you have any feedback?
> >
> > Michael
