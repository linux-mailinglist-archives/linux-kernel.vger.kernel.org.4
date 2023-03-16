Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC756BD7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCPSDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjCPSD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:03:28 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7C5B32A7;
        Thu, 16 Mar 2023 11:03:26 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x37so1441621pga.1;
        Thu, 16 Mar 2023 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678989805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIn2kE2s79edf477i7H+WFq+THi/OkrZPuC6+XMbTWA=;
        b=kYsyRpWPNBF4owmwT6Qam20ezzZ8yyFOA1zjg0e5XmIIYdCSD/1B6I74hDmFtgaktx
         wrsKDr/izgmzj6jyW1HgVmScDteEEclq9N91Tb1OG5lKi3gqs5kgt/R7Pd0bwouQlKE8
         pOm/++XZlEazKnwbzk9RXorziJIt3VlhIpXdg+sVkN9vIdvqDap3e/emnr03tE56yw/F
         BOywbe4Rhuy2wYlxc9suLP6SDwkadPO5w88fQDLfLDa6E67PyqTBClkKhQfpbYlZ6ovw
         n5An1wlv6omuxKMKFJzuqNUSR2epeR5ISGzmMQPXAEIkqYF4u9dkReMHPHGp47ohR7V+
         MSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678989805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIn2kE2s79edf477i7H+WFq+THi/OkrZPuC6+XMbTWA=;
        b=Ta09c7aLqXwfFro/Qom65rLfvIaRntXDWegm19AeHSLEp5vq07Kh4TqVVpUBjZcSGH
         pLW8BtPQeEto2aiBrJl05/5fDdASA7RxbNX3wVTCCQIGyfudm2jCT96yBt4Xg3jnVPSH
         8Dd9TlIBK4cfmvhd2W56QQcqq1KbbHfPuXu+1xeGUI/ocs6cXgPjlnpZ7hb6Ymictq++
         yvgVThVYI3WRZ/82E0rx9DG7EaenW6VoHuDncKHGudzvuzlgLIVwdCSlwq2xPN63cOpt
         I7FiBDdWaDGs7NcbNXHcOj8vsiiPqAerOxRNZ6ZfJvT7vtVPUw3Pc6/RkoNfa1wc6Cmi
         MNGw==
X-Gm-Message-State: AO0yUKW1N9LWM5hnWWdgx+OwNM3Dta5sxoQHC4/NHbGmBLncCHWMNJwl
        GXg1KZPogphFAHOJub045aSWiX695hXaHPTCRrz/pcYsBXLJYFFDMJc=
X-Google-Smtp-Source: AK7set/SLtDcC9lIQRhQNPqqZf8YEfKuOpb8XUnL4tJdXqbdXnEqTsbCVbOPaW7V+85HquZPw6h/YZ2aJE5SXYCG7t0=
X-Received: by 2002:a65:56ca:0:b0:503:77c9:45aa with SMTP id
 w10-20020a6556ca000000b0050377c945aamr1060528pgs.9.1678989805593; Thu, 16 Mar
 2023 11:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230316174818.1593588-1-zyytlz.wz@163.com> <a1ad3c9e-ee3d-7d30-fe8e-bca2eed77872@linuxfoundation.org>
In-Reply-To: <a1ad3c9e-ee3d-7d30-fe8e-bca2eed77872@linuxfoundation.org>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 17 Mar 2023 02:03:15 +0800
Message-ID: <CAJedcCye9HsDBrao=VEsN=qxkV3HCmGPTix3g8BL+K6oCCaE=w@mail.gmail.com>
Subject: Re: [PATCH RESEND] usbip: vudc: Fix use after free bug in vudc_remove
 due to race condition
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, valentina.manea.m@gmail.com,
        shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com
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

Shuah Khan <skhan@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=BA=94 01:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On 3/16/23 11:48, Zheng Wang wrote:
> > In vudc_probe, it calls init_vudc_hw, which bound &udc->timer with v_ti=
mer.
> >
> > When it calls usbip_sockfd_store, it will call v_start_timer to start t=
he
> > timer work.
> >
> > When we call vudc_remove to remove the driver, theremay be a sequence a=
s
> > follows:
> >
> > Fix it by shutdown the timer work before cleanup in vudc_remove.
> >
>
> Send me v2 for this patch with adding details on how you found this probl=
em
> to this commit log.
>

Get it, I found it by static analysis. So this might be false postive.
Will add this
to next version of patch

Best regards,
Zheng

> > Note that removing a driver is a root-only operation, and should never
> > happen.
> >
> > CPU0                  CPU1
> >
> >                       |v_timer
> > vudc_remove          |
> > kfree(udc);          |
> > //free shost         |
> >                       |udc->gadget
> >                       |//use
> >
> > Fixes: b6a0ca111867 ("usbip: vudc: Add UDC specific ops")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> >   drivers/usb/usbip/vudc_dev.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.=
c
> > index 2bc428f2e261..33d0991755bb 100644
> > --- a/drivers/usb/usbip/vudc_dev.c
> > +++ b/drivers/usb/usbip/vudc_dev.c
> > @@ -633,6 +633,7 @@ int vudc_remove(struct platform_device *pdev)
> >   {
> >       struct vudc *udc =3D platform_get_drvdata(pdev);
> >
> > +     timer_shutdown_sync(&udc->timer);
> >       usb_del_gadget_udc(&udc->gadget);
> >       cleanup_vudc_hw(udc);
> >       kfree(udc);
>
> thanks,
> -- Shuah
