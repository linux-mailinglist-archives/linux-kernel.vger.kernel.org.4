Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E536BD7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjCPSL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjCPSLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:11:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD3FCD646;
        Thu, 16 Mar 2023 11:11:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ja10so2678118plb.5;
        Thu, 16 Mar 2023 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678990279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blwiDs4Y0cRHeb4/ky2pgDT+AcWOl0EjhDPsL2Pe9RA=;
        b=Nu1K5SUUGuufVupOmoR4HW0BFs3ydHOUtM7uWBbnLD+VFHj0utxfYxEI9z6SbKAcdF
         HM1yjTPDBkgrv7ywv76dAl3MMaddo28o6Pe8/MLQlyz5SoOPatIcmE4Egx6Olm2OAlRt
         uJpVnQy8gqkk8XR4xi0Vzk/lYsI5eKtFYLiqQZYEJoHm5R1Q6lx/xhUbd8yWkTMFIVmx
         1wEy8DdnZ0TgGsP6m8hmEzecXFu37vNZZiRnbGpX3vmq47SYw9y4YAt3NqVXM2u/sia+
         ByvLaubz6Ha/B4SkuJfpAnvL78c6MIfzpw/a6Dk/eCo1y9ygDVuuF/Rb2jtkQuoga3Mq
         RvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678990279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blwiDs4Y0cRHeb4/ky2pgDT+AcWOl0EjhDPsL2Pe9RA=;
        b=FVfxkromkXU6YexGNJT1+/8JkEH6opYuSlrYfHVXk/Or9jWpZvy+AZTQyuiciJecUb
         rertuYlCHAaeWO5VhSdkKPqZsxSAajZQN6UHKQtwDDJt5XbctyoDYDfGZPpU5YLU6JyL
         6rsWrjfIEluTldZ7uwlFS2R0ymvxXvQTAPHGeCR8WjjAQxikLQWx2PqbJp2tjM4u6x09
         4E4DQT/QOmemMKO90V8Tb+pSMUfHfDhyK8aKzGoVCpUCgyJ4HCi3uaHxSMD1IlBQ9k9R
         C+Xv1yzQqPqjgG1jkMlIo5Z6w4CEW2JHGm0I7i3zFhaSb0iahdzGItOzdW4mnfNj1q8x
         EANw==
X-Gm-Message-State: AO0yUKXouKrP2E3ha9XZezIGoVJlRQL2usqh5/9CvlDECeS7WU+lH19i
        aYt/BGPMBuubyEftYvPiPPc1rmio5yb3g/se+cQ=
X-Google-Smtp-Source: AK7set+WpQE87j6WM/vcZvoZbdbpc67Jz2uHwpWTm5zeNSLNRJVv+LEbnOwoTOdNhNvD9Q7lQRbkWqGW95XcF0qYdZs=
X-Received: by 2002:a17:903:3291:b0:1a0:52f1:8ea7 with SMTP id
 jh17-20020a170903329100b001a052f18ea7mr1771535plb.12.1678990279624; Thu, 16
 Mar 2023 11:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230316175457.1595921-1-zyytlz.wz@163.com> <ZBNbRrKaNomV4nyJ@kroah.com>
In-Reply-To: <ZBNbRrKaNomV4nyJ@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 17 Mar 2023 02:11:09 +0800
Message-ID: <CAJedcCzFhn90bSvd3S0=1rfrxAzVbjdxRsoRfqCCWuoa8m23OQ@mail.gmail.com>
Subject: Re: [PATCH v6] usb: gadget: udc: renesas_usb3: Fix use after free bug
 in renesas_usb3_remove due to race condition
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, p.zabel@pengutronix.de,
        biju.das.jz@bp.renesas.com, phil.edworthy@renesas.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        yoshihiro.shimoda.uh@renesas.com
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

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=BA=94 02:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Mar 17, 2023 at 01:54:57AM +0800, Zheng Wang wrote:
> > In renesas_usb3_probe, role_work is bound with renesas_usb3_role_work.
> > renesas_usb3_start will be called to start the work.
> >
> > If we remove the driver which will call usbhs_remove, there may be
> > an unfinished work. The possible sequence is as follows:
> >
> > Fix it by canceling the work before cleanup in the renesas_usb3_remove.
> >
> > Note that removing a driver is a root-only operation, and should never
> > happen.
> >
> > CPU0                                          CPU1
> >
> >                                       | renesas_usb3_role_work
> > renesas_usb3_remove                   |
> > usb_role_switch_unregister|
> > device_unregister                     |
> > kfree(sw)                                             |
> > free usb3->role_sw                    |
> >                                       | usb_role_switch_set_role
> >                                       | //use usb3->role_sw
>
> Please use spaces for this, as something went wrong and it does not line
> up :(

Oh yes, will do in the next version. Thanks  for your advice :)

Best regards,
Zheng
