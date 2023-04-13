Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188346E113D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjDMPfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDMPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:35:38 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AFC9755
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:35:29 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 185so21445142pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681400129; x=1683992129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wj/wa6WpHTBFyxPNYkL5IzzzdL6xSIEEdLqjlbSu7iA=;
        b=BT1EDxm154Qs8n7f7Ddi2eHkivkOlP8lc3sMyS9QhyT9VdDLHexL3hkPHI2K5WbOpY
         Qm3HmW0pktwlWdRBVp/1S4dretjVEhIdP9d738FSqqjno8xeXf0BFSCh5migWn9xalkT
         2XMIb9n1d22x2doaFpJ4RP7cj/lUz6dAl4jw3rkaKGpzM0rhL0QTExkjqOnDi/Brxkys
         iTQjKZaviQrHbFt944l5UCzwthtwtnX5MOKHrmtqIZqTypR4jZJlGnTk6P9oOl0hrXMm
         9Wlt3EIML3ilK1X0Go7tQ4DVAEKCvbyRYyQqKIDS/Z4mBs/V3wDvZ4m+xHjvuB7dgBwk
         RKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681400129; x=1683992129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wj/wa6WpHTBFyxPNYkL5IzzzdL6xSIEEdLqjlbSu7iA=;
        b=NiMU1VfitEkSrMjIigxBgxtnAEZQdAtWuDAa5RimC6Sfv2XP6J91twlEfltWhH4oY7
         WE0xAIR0gdeRGTpizVf7tUJ3/e+xXA/vFEFevdNp+ka94en4yV75ANO+Z6z3dmDuHG/o
         TkVoJrDdem/Uy5BjDyXRY1gWC66jD996JDPdC2Jw25IZfREAqQKjhj2jl4JabREhrbKh
         SooLng3zleoSXCrguxRLBb2t2kjrCcgDJOz6BgZ40/fpP6DIok66wa6+YiIIy4oYGzRP
         Hcgz//Qg/9hM8ubUCvemcSqFbok3E7ePNIi1cqNyBh1RHvPArkx8zDODfsSJpik0h2cH
         newQ==
X-Gm-Message-State: AAQBX9fxV1joYl0D+/9J3GQrcl6djECXrfTcDUYPtjGrmWXTTCzDjTFq
        T1urNGeHN7XYxiavS8hRn3rqzjpXYERXLYPu1Xw=
X-Google-Smtp-Source: AKy350bAYtOQHqoT2pNEiHfcNerhB8vfnAQMOOwOBxIRY4Xq5lYocU2yjNBF0vgD24zIW6Bv8REmr797uu/8kuTVw2w=
X-Received: by 2002:a65:51c7:0:b0:51a:f873:2645 with SMTP id
 i7-20020a6551c7000000b0051af8732645mr599219pgq.9.1681400129269; Thu, 13 Apr
 2023 08:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230312145305.1908607-1-zyytlz.wz@163.com> <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
 <CAJedcCyJnV+KnFF5h+2-0W1R4uaUxUxXFUH3Q9HGYh-5F5LmBQ@mail.gmail.com>
 <CAJedcCyERP0-9DNgeKmS3C9Soqq590PteEorr_bxKzNanht=TQ@mail.gmail.com>
 <CAMSo37Vfr0DOqN+1XjH0o3pOY=BaHnSFkUbnZPOdMQ3TbfoAKg@mail.gmail.com>
 <CAJedcCzm3MqYe3QGT7V4sMmDsVHbjVSnEc2NXWPMGVZL=a_cBA@mail.gmail.com> <2023041308-nerd-dry-98a6@gregkh>
In-Reply-To: <2023041308-nerd-dry-98a6@gregkh>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 13 Apr 2023 23:35:17 +0800
Message-ID: <CAJedcCyeM2a79i0=ffKwdKfnQayo7svhTTEth2ka6K9np0Ztiw@mail.gmail.com>
Subject: Re: [PATCH] misc: hisi_hikey_usb: Fix use after free bug in
 hisi_hikey_usb_remove due to race condition
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yongqin Liu <yongqin.liu@linaro.org>,
        John Stultz <jstultz@google.com>,
        Zheng Wang <zyytlz.wz@163.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Mauro Carvalho Chehab <mchehab@kernel.org>
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

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8813=E6=
=97=A5=E5=91=A8=E5=9B=9B 20:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Apr 13, 2023 at 07:12:07PM +0800, Zheng Hacker wrote:
> > Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8813=
=E6=97=A5=E5=91=A8=E5=9B=9B 18:55=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hi, Zheng
> > >
> > > On Thu, 13 Apr 2023 at 16:08, Zheng Hacker <hackerzheng666@gmail.com>=
 wrote:
> > > >
> > > > Friendly ping about the bug.
> > >
> > > Sorry, wasn't aware of this message before,
> > >
> > > Could you please help share the instructions to reproduce the problem
> > > this change fixes?
> > >
> >
> > Hi Yongqin,
> >
> > Thanks for your reply. This bug is found by static analysis. There is n=
o PoC.
> >
> > >From my personal experience, triggering race condition bugs stably in
> > the kernel needs some tricks.
> > For example, you can insert some sleep-time code to slow down the
> > thread until the related object is freed.
> > Besides, you can use gdb to control the time window. Also, there are
> > some other tricks as [1] said.
> >
> > As for the reproduction, this attack vector requires that the attacker
> > can physically access the device.
> > When he/she unplugs the usb, the remove function is triggered, and if
> > the set callback is invoked, there might be a race condition.
>
> How does the removal of the USB device trigger a platform device
> removal?

Sorry I made a mistake. The USB device usually calls disconnect
callback when it's unpluged.
What I want to express here is When the driver-related device(here
it's USB GPIO Hub) was removed, the remove function is triggered.
>
> Are you sure this can be triggered by some other way other than manually
> unloading the driver?

As I didn't make a PoC, I'm not 100 percent sure about that.

Best regards,
Zheng

>
> thanks,
>
> greg k-h
