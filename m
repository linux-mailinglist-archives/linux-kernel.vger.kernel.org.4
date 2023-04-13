Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DEE6E0C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDMLMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDMLMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:12:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ADF5FDE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:12:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id lh8so1601555plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681384339; x=1683976339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A73lIhTXN7SmewkpI9NxDWpme+x9dolditKkQgZC8NA=;
        b=XSjnJwmJv2qB/HoGUzKhLO0qSpSMz8QvIXHumXbWbrFWPs266GvyxjGgAi0h8hmGIB
         W/bTmRP1GhtbEtKaqNriNMoeUE5WGW+tGOEDiPc2rpkzl2uUXLOWIWfq6EoRKFJt107o
         gNe2YIdBBubMFFHiEJjCXfGOJpJp/eM2q+tis2uQXOiATnVM/Zi4aXGeKIbtmQDZs+Jj
         v1hmxBhLOQb9qZ0gxrhaAdrG9hjkrg/CzQQ2FRD/jHKHSRftB2z7Lk3eSKUV1lkJIPBe
         7pJDfiPRhOAVmNzwTFatyYzUdVeTYT8pL+Uuz1MBof9g5zddrWKqWl8/cjxPrXv6j8qQ
         77GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681384339; x=1683976339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A73lIhTXN7SmewkpI9NxDWpme+x9dolditKkQgZC8NA=;
        b=fnP6Q13CXJVYhlQaMCIKE/fHAghT7y7cYjjLsaH1eUp+ABrTXW5ejQ8LL+4EmNXFtA
         xo+LfCdlfGi3CA/uDJbnCJbT4pPK4lmNYvCaE4AtoLoZo3AkBebg3X752W5MC4mvwqUD
         AxBd8Mzl3GyyNrg3M0head1pQBCYRO9gKu4GN1GAqVxM9RekZvp4oP5xWJ0pSDzplAGc
         3eiHyZ200XQQz/VVIc6jhdtQTsBiguX6/s+DAORznkiL1I25FmtMpsjwDPeGrBiunhjg
         oDlgkihO3Wdo0IjdTbrRCwdevNPPN+g6+KUsLmACcA40zPejVMN1U3j9R9e1ymOwuqLO
         lC0A==
X-Gm-Message-State: AAQBX9eAIbuSe3HlAKuPXjRom3g54Cojz2tiQTEtBaF+Ik1gWe8LeOzA
        QeI03XkpWoCvtAM/fvN9lh2A1j5vbrfy4ch5HHM=
X-Google-Smtp-Source: AKy350bacMx37uuFwzQ0zqDbeOBQbnko1h8u4MC+4Jg/nV+7/t2rpGMh5fDWMRtyY9KhrIjItLuLow99/+KfFG+WD5I=
X-Received: by 2002:a17:90a:6fc7:b0:244:9909:6e60 with SMTP id
 e65-20020a17090a6fc700b0024499096e60mr425249pjk.3.1681384338861; Thu, 13 Apr
 2023 04:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230312145305.1908607-1-zyytlz.wz@163.com> <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
 <CAJedcCyJnV+KnFF5h+2-0W1R4uaUxUxXFUH3Q9HGYh-5F5LmBQ@mail.gmail.com>
 <CAJedcCyERP0-9DNgeKmS3C9Soqq590PteEorr_bxKzNanht=TQ@mail.gmail.com> <CAMSo37Vfr0DOqN+1XjH0o3pOY=BaHnSFkUbnZPOdMQ3TbfoAKg@mail.gmail.com>
In-Reply-To: <CAMSo37Vfr0DOqN+1XjH0o3pOY=BaHnSFkUbnZPOdMQ3TbfoAKg@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 13 Apr 2023 19:12:07 +0800
Message-ID: <CAJedcCzm3MqYe3QGT7V4sMmDsVHbjVSnEc2NXWPMGVZL=a_cBA@mail.gmail.com>
Subject: Re: [PATCH] misc: hisi_hikey_usb: Fix use after free bug in
 hisi_hikey_usb_remove due to race condition
To:     Yongqin Liu <yongqin.liu@linaro.org>
Cc:     John Stultz <jstultz@google.com>, Zheng Wang <zyytlz.wz@163.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8813=E6=
=97=A5=E5=91=A8=E5=9B=9B 18:55=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi, Zheng
>
> On Thu, 13 Apr 2023 at 16:08, Zheng Hacker <hackerzheng666@gmail.com> wro=
te:
> >
> > Friendly ping about the bug.
>
> Sorry, wasn't aware of this message before,
>
> Could you please help share the instructions to reproduce the problem
> this change fixes?
>

Hi Yongqin,

Thanks for your reply. This bug is found by static analysis. There is no Po=
C.

From my personal experience, triggering race condition bugs stably in
the kernel needs some tricks.
For example, you can insert some sleep-time code to slow down the
thread until the related object is freed.
Besides, you can use gdb to control the time window. Also, there are
some other tricks as [1] said.

As for the reproduction, this attack vector requires that the attacker
can physically access the device.
When he/she unplugs the usb, the remove function is triggered, and if
the set callback is invoked, there might be a race condition.

In practice, you can just use rmmod command to simulate the unplug
movement, which will also trigger the hisi_hikey_usb_remove if there
is a real USB device.

If there's some other help I can provide, please feel free to let me know.

Thanks again for your effort.

Best regards,
Zheng

[1] https://www.usenix.org/conference/usenixsecurity21/presentation/lee-yoo=
chan

> Thanks,
> Yongqin Liu
> > Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=BA=8C 09:01=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > John Stultz <jstultz@google.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=BA=8C 03:57=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Sun, Mar 12, 2023 at 7:53=E2=80=AFAM Zheng Wang <zyytlz.wz@163.c=
om> wrote:
> > > > >
> > > > > In hisi_hikey_usb_probe, it called hisi_hikey_usb_of_role_switch
> > > > > and bound &hisi_hikey_usb->work with relay_set_role_switch.
> > > > > When it calls hub_usb_role_switch_set, it will finally call
> > > > > schedule_work to start the work.
> > > > >
> > > > > When we call hisi_hikey_usb_remove to remove the driver, there
> > > > > may be a sequence as follows:
> > > > >
> > > > > Fix it by finishing the work before cleanup in hisi_hikey_usb_rem=
ove.
> > > > >
> > > > > CPU0                  CPU1
> > > > >
> > > > >                     |relay_set_role_switch
> > > > > hisi_hikey_usb_remove|
> > > > >   usb_role_switch_put|
> > > > >     usb_role_switch_release  |
> > > > >      kfree(sw)     |
> > > > >                     | usb_role_switch_set_role
> > > > >                     |   //use
> > > > >
> > > > > Fixes: 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onb=
oard USB gpio hub on Hikey960")
> > > > > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > > > > ---
> > > > >  drivers/misc/hisi_hikey_usb.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hi=
key_usb.c
> > > > > index 2165ec35a343..26fc895c4418 100644
> > > > > --- a/drivers/misc/hisi_hikey_usb.c
> > > > > +++ b/drivers/misc/hisi_hikey_usb.c
> > > > > @@ -242,6 +242,7 @@ static int hisi_hikey_usb_probe(struct platfo=
rm_device *pdev)
> > > > >  static int  hisi_hikey_usb_remove(struct platform_device *pdev)
> > > > >  {
> > > > >         struct hisi_hikey_usb *hisi_hikey_usb =3D platform_get_dr=
vdata(pdev);
> > > > > +       cancel_work_sync(&hisi_hikey_usb->work);
> > > > >
> > > > >         if (hisi_hikey_usb->hub_role_sw) {
> > > > >                 usb_role_switch_unregister(hisi_hikey_usb->hub_ro=
le_sw);
> > > >
> > > > Looks sane to me.
> > > > Pulling in Sumit and YongQin as they have hardware and can test wit=
h it.
> > > >
> > > Hi John,
> > >
> > > Thanks for your reply. Thank Sumit and YongQin for being willing to
> > > test the solution with their hardware.
> > >
> > > Best regards,
> > > Zheng
>
>
>
> --
> Best Regards,
> Yongqin Liu
> ---------------------------------------------------------------
> #mailing list
> linaro-android@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-android
