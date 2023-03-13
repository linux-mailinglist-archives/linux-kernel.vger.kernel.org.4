Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E716A6B719B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCMIvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCMIu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:50:58 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96904FAB1;
        Mon, 13 Mar 2023 01:49:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id p6so6461660pga.0;
        Mon, 13 Mar 2023 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678697348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdJZFGWnCqrGrvX1AXmXSN5ym6vA1hPmy0582RXs6Uo=;
        b=lVhyFjJrYO5YFrPABmayHEJrldR9VVyOKxVDVd6Wo+aHPyUJqBH3i10hXtcEn+aDsb
         Z56nA82rDW4Pej1y0jajJ+uxJIOeYTX5COvWri7BEEanXSZEJwNTRrVTZVCWvNrIJAp4
         6w2YPnICOc07ATlGh1Ii2BwRPNwiHtpEOrbnEFhuDgSa1ko3+zQ6aXGHqGq6WPrWzwCH
         DgXXVcD9yyDvLCbr/pY78x67lGU9Qsei+zKM+/zsrbTJfMf261lQ18IK4pAYEig57aSD
         1ew6thgxTYVrAU+t5gY563kmk9Khk5IeDJUgx+bjovmPP7/dlVD363A4aftOS+5SAzZJ
         ZTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678697348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdJZFGWnCqrGrvX1AXmXSN5ym6vA1hPmy0582RXs6Uo=;
        b=j62LXA53/7sVhnYQsqUV1NCfzW11pmbCa+q+BMbqi9bSfuvltC5SmVEgRnHEi24jMP
         KJVgDIX9w23sv2ZrgmUJjc+e6PZjDjngEACaLUzhV/14WfjN3IvtVelkmXLIAssct7hz
         i97qw+snryo8lfY33P78hEJP+qTv+DQiE/MXMIwq9kyY4/EUs94Ey56sr5hNsWGQiYDF
         CNGSYKWTMxdgaAetHAA7eUeedYC/QlS2SWZrXcb42+dWkguv9ZecPvFtGaoSVV7JwdGt
         WuIwH+pHVIbOs23MsJfkfgkZ7r/Pt6Qat6Ar9m+47yAFNBXH8A86Ko9WoR1B9sKBVS0L
         ti1g==
X-Gm-Message-State: AO0yUKUVhXZH7YOrDpttcBvlE2P24oIc3gkv71gy2dlbm8DVo+hV01Pk
        OcpP3KA6mMtZ9ZhGDp6OV2Waa1PdX6StHFPeYlA=
X-Google-Smtp-Source: AK7set93yVCJ7vYMwpAXAJXNnGjB4sTvhmMwrUr4NfDYWkzd7Sv2OBew8QoG0y27UJHpTvhcdUJufud9Op3Yf7SNsFc=
X-Received: by 2002:a63:6e02:0:b0:50b:188d:3381 with SMTP id
 j2-20020a636e02000000b0050b188d3381mr615559pgc.4.1678697347846; Mon, 13 Mar
 2023 01:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230311161242.3773432-1-zyytlz.wz@163.com> <TYBPR01MB534196428158C2D79A910E07D8B99@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB534196428158C2D79A910E07D8B99@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 13 Mar 2023 16:48:54 +0800
Message-ID: <CAJedcCztRHuHVtrqsA3Osn+yp+Swgbu1GEAyfDE3d90CREn25g@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: udc: renesas_usb3: Fix use after free bug
 in renesas_usb3_remove due to race condition
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "phil.edworthy@renesas.com" <phil.edworthy@renesas.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> =E4=BA=8E2023=E5=B9=B4=
3=E6=9C=8813=E6=97=A5=E5=91=A8=E4=B8=80 16:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Zheng,
>
> > From: Zheng Wang, Sent: Sunday, March 12, 2023 1:13 AM
> >
> > In renesas_usb3_probe, &usb3->role_work is bound with
> > renesas_usb3_role_work. renesas_usb3_start will be called
> > to start the work.
> >
> > to make cleanup, there may be an unfinished work. The possible
> > sequence is as follows:
>
> Why do you remove the following description on this v2 patch?
> -----
> If we remove the driver which will call usbhs_remove
> -----
> I think this description is helpful to understand.
>

Sorry I misunderstood you previous response for my poor English. Will
append it again in the next version.

Best reagrds,
Zheng

>
> > Fix it by canceling the work before cleanup in the renesas_usb3_remove
> >
> > CPU0                  CPU1
> >
> >                     |renesas_usb3_role_work
> > renesas_usb3_remove |
> > usb_role_switch_unregister  |
> > device_unregister   |
> > kfree(sw)          |
> > free usb3->role_sw  |
> >                     |   usb_role_switch_set_role
> >                     |   //use usb3->role_sw
> >
> > Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of u=
sb role switch")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> > v2:
> > - fix typo, use clearer commit message and only cancel the UAF-related =
work suggested by Yoshihiro Shimoda
> > ---
> >  drivers/usb/gadget/udc/renesas_usb3.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget=
/udc/renesas_usb3.c
> > index bee6bceafc4f..a301af66bd91 100644
> > --- a/drivers/usb/gadget/udc/renesas_usb3.c
> > +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> > @@ -2661,6 +2661,7 @@ static int renesas_usb3_remove(struct platform_de=
vice *pdev)
> >       debugfs_remove_recursive(usb3->dentry);
> >       device_remove_file(&pdev->dev, &dev_attr_role);
> >
> > +     cancel_work_sync(&usb3->role_work);
> >       usb_role_switch_unregister(usb3->role_sw);
> >
> >       usb_del_gadget_udc(&usb3->gadget);
> > --
> > 2.25.1
>
