Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CD8738337
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjFUMCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjFUMCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:02:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8876170C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:02:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-260a4020ebaso2285062a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687348945; x=1689940945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhxmnBwA3kxFM1Khy1EXv4uS5Bs0rCsQz59EI6x6O38=;
        b=F/KGFrLg4zD/PMnwpqt+njNXxH5Rs94zpA07R9mKFtHQJG79P/UwYxEP8E448E4kod
         ujgEISipQqVYQb/8UsU6WJSKzTgNY7IwsGo74ryReNAfPQdJtk1h3p03MMhuITs7K+r4
         BXe7y7d2dah3gGHL8Gmm6qIDGh1FTuKO949HM6XX/LnCXScv8WkiSTqzXQyh0OlDD3wj
         FyBoXTUCKetNKgrv+dzwTspwpCeaXxHZkIBAwbY4inwnq2Ehx/BIFthlPeXFjyULT2Lb
         nBosdkgEGXJ/huQqsRElA5XBTBhZ1JsMAgYVDYFmRfk26YAtp7qD0IsFdGm4dhGvO9qB
         m4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687348945; x=1689940945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhxmnBwA3kxFM1Khy1EXv4uS5Bs0rCsQz59EI6x6O38=;
        b=N3YxTDRkO5Pc7b1tYj8taU5BGuAC8D174zCZJX33liUdmjdAAUHN2uGGxJl14vrNhU
         hvO8hjeP7mEL2M5yYev6J68VRdM3Koo29vtn61f6QMnXTNCAiMKk1yZ9dpYTmNlKaM8d
         khoXo0ti7rLo16GyE/gWwuX9G4o6uBwEMrs+HjNiXnhTO9pB96Ey17rReO3PVq9B5BMF
         qy5oajgcZ0EgBHy1DYieddYjS+9PjrjtSWw5EQl23Eoic7WioRKFj262B9Rw6UU6VSuS
         bgvMH+/jwuAzdE3iSIRh9xGMck3U5whJe5/14g9L6XV+9TIM/A0srsPIjl0udiSS9NDN
         DCWw==
X-Gm-Message-State: AC+VfDx2lGf4R3NN1hrGlmqHc0LZlMt0E6qjCNyqTD/cOCisygst6H6E
        1hoIHo1eYTeh1kOrXVaCd1CpruOT4lsnZlx+1F/UOw==
X-Google-Smtp-Source: ACHHUZ5zFAeEYC/BiDisvvqJBTZap8sir1tOWv1nt/yk/At8UfskkIcU6yoJqTMS0MMTY6rXaqm3/YermK4VVVfrFds=
X-Received: by 2002:a17:90a:43e4:b0:25b:dc4b:611d with SMTP id
 r91-20020a17090a43e400b0025bdc4b611dmr15221652pjg.26.1687348945091; Wed, 21
 Jun 2023 05:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
 <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <CAGm54UExHOBw61DJNqxvW67OSr60fQ+Q247t63RzymiMOmHmFg@mail.gmail.com>
 <HK0PR06MB320203EF8E3AD14C34359B0580329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Y1ueEYJk2epT/g4J@kroah.com> <HK0PR06MB32024F58191E17DC5ABC99F380329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Y1uyssu84kl1INSR@kroah.com> <CAGm54UGmp=kTKGLhEfENF4SqkvRt_GcpuGH_g5PjtQiBkwtOsA@mail.gmail.com>
 <TY2PR06MB321303972156248AB08CAB2480EB9@TY2PR06MB3213.apcprd06.prod.outlook.com>
 <CAGm54UHWhRQsvaBQM7mgfP2A5os=mYDTfKS9qfS0C5_9XkcrSA@mail.gmail.com>
In-Reply-To: <CAGm54UHWhRQsvaBQM7mgfP2A5os=mYDTfKS9qfS0C5_9XkcrSA@mail.gmail.com>
From:   Lei Yu <yulei.sh@bytedance.com>
Date:   Wed, 21 Jun 2023 20:02:14 +0800
Message-ID: <CAGm54UG2uD2jruRc33Xm4izepYpuFNBBcGe594as8_fx1uEWQg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: aspeed: fix buffer overflow
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Henry Tian <tianxiaofeng@bytedance.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Neal Liu <neal_liu@aspeedtech.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 10:26=E2=80=AFAM Lei Yu <yulei.sh@bytedance.com> wr=
ote:
>
> On Wed, Dec 21, 2022 at 10:17 AM Neal Liu <neal_liu@aspeedtech.com> wrote=
:
> > > > > > > Using rndis is able to set MTU to 2000, and the issue can be
> > > reproduced.
> > >
> > > USB ecm is also tested and it is possible to set MTU to 2000, and cou=
ld
> > > reproduce the issue.
> > > So I think this patch is needed anyway.
> > >
> > > @Neal Liu Could you kindly help to verify the USB ECM case?
> >
> > How to set MTU to 2000 on USB ECM case? I remember last time I cannot s=
et by using "ifconfig ..."
> > Regardless ECM or RNDIS, I agree this patch is still needed.
>
> You were able to set MTU to 2000 for RNDIS but not for NCM.
> @Greg Kroah-Hartman indicated that RNDIS should not be used anymore.
> So I tested ECM and verified it could set MTU 2000 and the issue could
> be reproduced.

This patch fixes the kernel oops in the aspeed-vhub driver for both
USB ECM and RNDIS.
It now has an Acked-by from benh and Reviewed-by from neal_liu

Should we merge this patch?
