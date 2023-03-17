Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BCB6BDFE1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 05:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCQEAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 00:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCQEAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 00:00:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F659EC64;
        Thu, 16 Mar 2023 21:00:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id y19so2172637pgk.5;
        Thu, 16 Mar 2023 21:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679025609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FtPdv+3fxLwAj0l4lRB0nnuP21Ve7eF9XkO1i7h3oE=;
        b=GNqr+xVWfB7oh+fKZoesTL/DGTjJXWLCQEASBAmRaPnBC7+NtjlPlgZbfb5kkZUKMK
         mMMFmYmRIIJ/F6iNovaF/Fk20LRKeXV1PtWXRqfeN4YpRsgGCTcjI7MB1QY3PiGI44Yj
         pOGBItugCvjqJS8XXB03OTUvKEVvx2O8pGZlImoj3oMlm2CJLxnhVRngDQcMaeWzcKE7
         HLFIUpDp6Zakj/rtdIb7bABAGUqEyhsmdwlzd+vk6NNrpXRFFjohdpDbNE1iT9KHJJUx
         L4XMvI5ktCPTQqVOy1NZVAshrWQXDJ5ghwDq7Rwe5ffWZHaa0sBfZpHH5iDaM8pVac2b
         gWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679025609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FtPdv+3fxLwAj0l4lRB0nnuP21Ve7eF9XkO1i7h3oE=;
        b=VXYAjZuQF4Z10YUoh/I1dVEpxXKs7ToUuPBxEHL8hzFee3xoa/uNL3fC/3z4vZFvwV
         OCJhbvwUm756W6ZqMuuFLvDbcQXYTF5MnWdn9OHaUKHzzaqcOe33ydEPzrpn5PQqqcuu
         EPc+i8N3wzE4cWL32yuf+thFXJGoF/RBqD2uCAXUA2PVvIbRHycWzGf69BKjQalzYmka
         AtvuTC+QRbdhBN9MQzD1hYSzgI1naJmyzWExopqneZwN4F9i1Yn+icNhDg1ATLd2QOwv
         betMA9rkOf3BWnhybUPw31u6TjZ7fVSbzmg/VLrHMGS2H/7i/sv++WEpGzUql1eFT0te
         wIxw==
X-Gm-Message-State: AO0yUKWqiDHfkfoVJKxSXkY1HTb+Oz9aQIVnJOBQ8cPxJjJRZVTomk6Y
        7mVbjPNxWXPRgEJVQcs4ULJ6HlQzi4DjZwOraIc=
X-Google-Smtp-Source: AK7set+yvSrXqDyv6XR6FaBOeYq+aSNu+qfPmjxFKuXPtecEW+Is1Zk1HvcrQL/lBjJQcANbMHjyQji9nMPNIU+qq28=
X-Received: by 2002:a05:6a00:d45:b0:625:66a9:c393 with SMTP id
 n5-20020a056a000d4500b0062566a9c393mr2162919pfv.0.1679025609042; Thu, 16 Mar
 2023 21:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230316180850.1600867-1-zyytlz.wz@163.com> <ZBNo5gr1ILs5mR5z@kroah.com>
In-Reply-To: <ZBNo5gr1ILs5mR5z@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 17 Mar 2023 11:59:57 +0800
Message-ID: <CAJedcCwkuznS1kSTvJXhzPoavcZDWNhNMshi-Ux0spSVRwU=RA@mail.gmail.com>
Subject: Re: [PATCH v7] usb: gadget: udc: renesas_usb3: Fix use after free bug
 in renesas_usb3_remove due to race condition
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, skhan@linuxfoundation.org,
        p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com,
        phil.edworthy@renesas.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, yoshihiro.shimoda.uh@renesas.com
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
=97=A5=E5=91=A8=E4=BA=94 03:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Mar 17, 2023 at 02:08:50AM +0800, Zheng Wang wrote:
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
> This still isn't working :(
>
Sorry I haven't read your advice when submiting this version of patch.

Best Regards,
Zheng
