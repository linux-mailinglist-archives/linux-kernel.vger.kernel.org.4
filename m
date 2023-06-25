Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CA073CE2A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 05:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjFYDIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 23:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFYDIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 23:08:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D21FE65
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 20:08:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-54fb23ff7d3so1052697a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 20:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687662484; x=1690254484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh8y9rGkY0XrishvL/YriS+pn1suafnY/Ovufgrc/To=;
        b=S1HFlcqs8l0XO2V+kdO93mLZSNlhR+kNBtOscaXM8ZAuK+nt+kONB5CmffSF6B17Or
         GMDtkPINo5NY9ahXUTWawPYZ6AjvrjnIHv6sWZKzyTX7/SIFXxvdPvBZ8+hCGEshgwEL
         DdJ858OzfjMUp62a8UA/N/0q9yXDX29eBz2B5NwEeBu+hMT/gXEtggZGs4Yo71x7qg7O
         1NTkGpfambYFBPwK9Y2cbv7b1sW/WLrgHS1w+4p1HA5AovgA+wYnfWBk5mEC2heCbn3M
         mkSg5Y3l4so4E7Fw5w5+GVVFjTM8pR2/q6caVVYl0Kk4aUyxphIAHBRdf3JLHuTZbZo0
         zyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687662484; x=1690254484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mh8y9rGkY0XrishvL/YriS+pn1suafnY/Ovufgrc/To=;
        b=ba1FhG5xmWMHRTDjvLVLgTp4/9dhwYeO4HR03Aml+rV9+qfiW0hCkS0FDNZLn/lrRw
         K2sGuYzdnB+5LMa4JJ/sFM4iIU/H8/zW2mqvR53tABXP9LOfocR4KgXvCf9z4maCZx+P
         Kp9qvw9CPeL2zmnqA6SjCMME/32+ySwfSZg688UDmDJsQfnWhpVv+TZ1X5NqBaiUOU5F
         79vUM+kqmO6QXzMvABPLG8yc+WWPlgtXesO2zmWJ+EBedrPco137vmw2wpHDFY50ezVP
         HjIDn2Oe+9z7sxJeR2+StlZ079cVXqi1OkNtbNmyK/PfIfF7h92ec0NYsmJWn17t1+UV
         fYqA==
X-Gm-Message-State: AC+VfDzSQKxZ2Ipy51/bNmh5u61J3tupxM5lNypa/pKNI9vj3ZyfWE+/
        ldSxpEKuE3foieSufpJgpc2FvLsDM6Rtq7vTtW2Qlw==
X-Google-Smtp-Source: ACHHUZ5g0BtDrRKiJvnE1ZMKauIGJlA4TKSEOVZnrpZZ3VN6xvPFO5CT4Vj7GvFykNxQbh2xUPYgKuG2DDfs6m73I2E=
X-Received: by 2002:a17:90a:bb81:b0:262:a546:e8a2 with SMTP id
 v1-20020a17090abb8100b00262a546e8a2mr2764648pjr.33.1687662484519; Sat, 24 Jun
 2023 20:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <CAGm54UExHOBw61DJNqxvW67OSr60fQ+Q247t63RzymiMOmHmFg@mail.gmail.com>
 <HK0PR06MB320203EF8E3AD14C34359B0580329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Y1ueEYJk2epT/g4J@kroah.com> <HK0PR06MB32024F58191E17DC5ABC99F380329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Y1uyssu84kl1INSR@kroah.com> <CAGm54UGmp=kTKGLhEfENF4SqkvRt_GcpuGH_g5PjtQiBkwtOsA@mail.gmail.com>
 <TY2PR06MB321303972156248AB08CAB2480EB9@TY2PR06MB3213.apcprd06.prod.outlook.com>
 <CAGm54UHWhRQsvaBQM7mgfP2A5os=mYDTfKS9qfS0C5_9XkcrSA@mail.gmail.com>
 <CAGm54UG2uD2jruRc33Xm4izepYpuFNBBcGe594as8_fx1uEWQg@mail.gmail.com> <2023062146-stony-lair-b6a3@gregkh>
In-Reply-To: <2023062146-stony-lair-b6a3@gregkh>
From:   Lei Yu <yulei.sh@bytedance.com>
Date:   Sun, 25 Jun 2023 11:07:53 +0800
Message-ID: <CAGm54UGarmoR-LT=hosC3ChAXvV2Pt4=GYWc=cxZV6j3yOo=GQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] usb: gadget: aspeed: fix buffer overflow
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 12:00=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 21, 2023 at 08:02:14PM +0800, Lei Yu wrote:
> > On Wed, Dec 21, 2022 at 10:26=E2=80=AFAM Lei Yu <yulei.sh@bytedance.com=
> wrote:
> > >
> > > On Wed, Dec 21, 2022 at 10:17 AM Neal Liu <neal_liu@aspeedtech.com> w=
rote:
> > > > > > > > > Using rndis is able to set MTU to 2000, and the issue can=
 be
> > > > > reproduced.
> > > > >
> > > > > USB ecm is also tested and it is possible to set MTU to 2000, and=
 could
> > > > > reproduce the issue.
> > > > > So I think this patch is needed anyway.
> > > > >
> > > > > @Neal Liu Could you kindly help to verify the USB ECM case?
> > > >
> > > > How to set MTU to 2000 on USB ECM case? I remember last time I cann=
ot set by using "ifconfig ..."
> > > > Regardless ECM or RNDIS, I agree this patch is still needed.
> > >
> > > You were able to set MTU to 2000 for RNDIS but not for NCM.
> > > @Greg Kroah-Hartman indicated that RNDIS should not be used anymore.
> > > So I tested ECM and verified it could set MTU 2000 and the issue coul=
d
> > > be reproduced.
> >
> > This patch fixes the kernel oops in the aspeed-vhub driver for both
> > USB ECM and RNDIS.
> > It now has an Acked-by from benh and Reviewed-by from neal_liu
> >
> > Should we merge this patch?
>
> Can you please resend it?

I just find that the patch is already merged in v6.2
Thanks.
