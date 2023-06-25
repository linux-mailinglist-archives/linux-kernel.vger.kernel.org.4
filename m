Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FAE73CE14
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 04:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjFYCif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 22:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjFYCid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 22:38:33 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FE5EA;
        Sat, 24 Jun 2023 19:38:30 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-780ce0cb634so91383139f.1;
        Sat, 24 Jun 2023 19:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687660710; x=1690252710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNGvBKcB3CIKcyMYClQXOpCaMALtJJX4nJCCga1/ri8=;
        b=I8EEvHFDfz8A0C4im3EViIobl7u0ysO5B49LsTgx/a3K7SLnoXQMexu9aMQXMRNTDs
         RqPH1stvctMwv2QAaVvn+qlz4DNFD7vmPZN+5T2zIgoiPo4krZmavazeSrVib64JFmAn
         6HsR38TMW3VNKljOFcnbtBK/rvvh5CZTzVWSwoSpwUhYjG3Hgafhd9gdxss7fHu9ijHB
         k2P4fmPLxzO5U1tyMQvSFPzrtKQ3oStWpqxyBAK4kr3rUlG6hlYqTv9z8taMW8N1zfl9
         JLvTqoMYJIBGuqIqC6xS2N2RPEO/caxPEHo/99e2HzefN1Fejq1d47Wu3Wf0yCnf61w8
         J5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687660710; x=1690252710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNGvBKcB3CIKcyMYClQXOpCaMALtJJX4nJCCga1/ri8=;
        b=QuB5gWBzczB9vW2JAk5Oybxx5yUuwnU7XmGNkPHMLCm/lIfK1MMHp/e9p8xbuPpqu4
         OznBF24ZhH/xVlYCbKVvZX0jrUWztC/GJKaK1tytZslmmArSarXl8M3rJaAVnXMO6RL8
         t1BXi8wJP03Z0wnpTyxSY7ip8uO4iL/DDSiWzGhNzbkZ5cH75BLz+Ed2phfPTX8Wm8e4
         04anctGvnAMNpf6Mq71gd96b1voeZl91Urne8mA7aMgQm9NnLTYJv/VOCGe4lTssoHYQ
         kOJxjDcJuF8AgWd4zuUc5nnnN1+pLqlIxk3dUWJ5vAXm+P0yBmauML5Ffe1uwbKYRatC
         dV7A==
X-Gm-Message-State: AC+VfDx1pMpEtNyN+VKnASgh7eR4MjqX391t36F8Mx0fRgiCIAYpQvcJ
        PHri/1T9PfLbOmLq2n9SieneiFlqY4r6Xec/wC63G4lqBireZKvrobA=
X-Google-Smtp-Source: ACHHUZ5b8T8/AhZsTCN9k3g/rmP3OKooQH9lxoY6FAb7wtbc/uzFjD8/2Hca7QSx15AoiRE2m9e+xUWapuRmMBZqMc4=
X-Received: by 2002:a6b:440d:0:b0:783:37b2:4b37 with SMTP id
 r13-20020a6b440d000000b0078337b24b37mr5657736ioa.3.1687660709855; Sat, 24 Jun
 2023 19:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230306062633.200427-1-zyytlz.wz@163.com> <CAJedcCzeVwwi9SkkwouFXUAVhF-tKF4dkqsFqVQwszSwY1SJ0A@mail.gmail.com>
 <57c17bfd-83f3-fcce-0eab-e28469fb0ced@collabora.com> <11c2bce1e5286ad3a9a5be2ee59c2beac168f135.camel@mediatek.com>
 <CAJedcCx13sz5h=fWvJU38P_1W-zd6yZe=iSMpO28_E_kAqUGDA@mail.gmail.com>
 <cfa2f64d2d01ffc53a6afdc9a5b867bbcb07b5f6.camel@mediatek.com>
 <CAJedcCwhk_XuMF8keGZGBTVBZSMuoQeyV_7L1H2VeT2x_vj-ZQ@mail.gmail.com>
 <86c98d73b0d294e143014ea5e15d0a5d065e1a66.camel@mediatek.com>
 <CAJedcCyiczZiKm=zQyYwJCszmEHKYX+sVEBx7UC082pS5K5Oww@mail.gmail.com>
 <0bf5c11128f96d820f8e3ffaf5e9402aa0c0a1a5.camel@mediatek.com>
 <CAJedcCyVOpNyXsm6NW738tPvGF_nNDh_NCKXqKWgrnhKV5y-2g@mail.gmail.com>
 <CAJedcCw6ZiTfKRGkO9OQ+5Ykx=S3b5MMKW_vD3SX+i+tON6hVA@mail.gmail.com>
 <7dac4bde1216df33c12ecc3fb19ac1499478facf.camel@mediatek.com>
 <CAJedcCwkCwtDM3Yo5gCQX7G_WpFg6YVgFAPzjHa61X0nNcL0pA@mail.gmail.com>
 <94ff8d75d88c7ab356949ad319c3085e45ac2488.camel@mediatek.com>
 <CAJedcCwgVTLJsYTncnt5ab6yAqbrJ7oGf9Ftak1vCoemeQz16w@mail.gmail.com>
 <54e3e5cd0160c8a592a5e783d9e1b2e20fe30555.camel@mediatek.com> <CAJedcCw0t-cubOWXOssRiGa0Ltf-XkCh-0Tu7NjftkBsOVYUnQ@mail.gmail.com>
In-Reply-To: <CAJedcCw0t-cubOWXOssRiGa0Ltf-XkCh-0Tu7NjftkBsOVYUnQ@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sun, 25 Jun 2023 10:38:16 +0800
Message-ID: <CAJedcCwvN0br2vLqyOwsNiNu2Rx3fe8NS1DxLDmpFdOywy8d-Q@mail.gmail.com>
Subject: Re: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     =?UTF-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "zyytlz.wz@163.com" <zyytlz.wz@163.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>,
        =?UTF-8?B?QmluIExpdSAo5YiY5b2sKQ==?= <bin.liu@mediatek.com>,
        =?UTF-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I sent the patch-v2, but found some mail was rejected due to Network
error. Here is the newest patch link:

https://lore.kernel.org/all/20230624145050.2471885-1-zyytlz.wz@163.com/


Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=8815=
=E6=97=A5=E5=91=A8=E5=9B=9B 10:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kyrie,
>
> Thanks for your kind reminder. I'll write the patch as soon as I can.
>
> Best regards,
> Zheng Wang
>
> Kyrie Wu (=E5=90=B4=E6=99=97) <Kyrie.Wu@mediatek.com> =E4=BA=8E2023=E5=B9=
=B46=E6=9C=8815=E6=97=A5=E5=91=A8=E5=9B=9B 10:40=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, 2023-05-15 at 10:57 +0800, Zheng Hacker wrote:
> > > External email : Please do not click links or open attachments until
> > > you have verified the sender or the content.
> > >
> > >
> > > Hi Kyrie,
> > >
> > > I think your analysis is right, I'll make the change in the next
> > > version.
> > >
> > > Best regards,
> > > Zheng
> > >
> > Dear Zheng,
> >
> > Could you please update the next version at any convenient time?
> >
> > Thanks.
> >
> > Bset Regards,
> > Kyrie.
> >
> > > Kyrie Wu (=E5=90=B4=E6=99=97) <Kyrie.Wu@mediatek.com> =E4=BA=8E2023=
=E5=B9=B45=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=94 09:24=E5=86=99=E9=81=93=EF=
=BC=9A
> > > >
> > > > On Tue, 2023-03-14 at 11:37 +0800, Zheng Hacker wrote:
> > > > > Kyrie Wu (=E5=90=B4=E6=99=97) <Kyrie.Wu@mediatek.com> =E4=BA=8E20=
23=E5=B9=B43=E6=9C=8814=E6=97=A5=E5=91=A8=E4=BA=8C 10:49=E5=86=99=E9=81=93=
=EF=BC=9A
> > > > > >
> > > > > > On Thu, 2023-03-09 at 15:31 +0800, Zheng Hacker wrote:
> > > > > > > Dear Kyrie,
> > > > > > >
> > > > > > > Guenter gave some advice about this issue in [1]. As we are
> > > > > > > not
> > > > > > > familiar with the code here, could you please see if the bug
> > > > > > > really
> > > > > > > exists?
> > > > > > >
> > > > > > > [1]
> > > > > > >
> > > >
> > > >
> > https://lore.kernel.org/all/e03134f9-9433-ab6b-170a-8ce752fccdeb@roeck-=
us.net/
> > > > > > >
> > > > > > > Best regards,
> > > > > > > Zheng
> > > > > >
> > > > > > Dear zheng,
> > > > > >
> > > > > > I have no more questions for your patch, thank you for your
> > > > > > contribution to mtk jpeg driver.
> > > > > >
> > > > >
> > > > > Thanks for your detailed review and explanation about the code. I
> > > > > have
> > > > > learned a lot
> > > > > from it. Have a nice day :)
> > > > >
> > > > > Best regards,
> > > > > Zheng
> > > >
> > > > Dear Zheng,
> > > >
> > > > I think that cancel_delayed_work, added in remove function, should
> > > > change to cancel_delayed_work_sync to solve UAF. The corresponding
> > > > operation flow is shown as follow:
> > > >       CPU0                      CPU1
> > > >                       |mtk_jpeg_job_timeout_work
> > > > mtk_jpeg_remove       |
> > > >   cancel_delayed_work |
> > > >   v4l2_m2m_release    |
> > > >     kfree(m2m_dev);   |
> > > >                       |
> > > >                       | v4l2_m2m_get_curr_priv
> > > >                       |  m2m_dev->curr_ctx //use
> > > >
> > > > If cancel_delayed_work is called in async mode like above, and the
> > > > m2m_dev is freed. But it is used in mtk_jpeg_job_timeout_work, this
> > > > calling may cause UAF.
> > > >
> > > > Thanks.
> > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=
=B43=E6=9C=888=E6=97=A5=E5=91=A8=E4=B8=89 17:11=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > >
> > > > > > > > Dear Kyrie,
> > > > > > > >
> > > > > > > > Sorry for my misunderstanding. I've seen the timeout worker
> > > > > > > > is
> > > > > > > > bound
> > > > > > > > with mtk_jpegdec_timeout_work rather than
> > > > > > > > mtk_jpeg_job_timeout_work.So
> > > > > > > > the competition won't happen.
> > > > > > > >
> > > > > > > > Back to the beginning scene, I still don't know if it's a
> > > > > > > > UAF
> > > > > > > > issue
> > > > > > > > or
> > > > > > > > not. The normal schedule is very strong to me. If we can
> > > > > > > > call
> > > > > > > > mtk_jpeg_remove directly without calling mtk_jpeg_release,
> > > > > > > > The UAF is still possible. Otherwis, I think it's safe
> > > > > > > > here.
> > > > > > > >
> > > > > > > > Best regards,
> > > > > > > > Zheng
> > > > > > > >
> > > > > > > > Kyrie Wu (=E5=90=B4=E6=99=97) <Kyrie.Wu@mediatek.com> =E4=
=BA=8E2023=E5=B9=B43=E6=9C=888=E6=97=A5=E5=91=A8=E4=B8=89 15:39=E5=86=99=E9=
=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > On Wed, 2023-03-08 at 14:10 +0800, Zheng Hacker wrote:
> > > > > > > > > > Hi Kyrie,
> > > > > > > > > >
> > > > > > > > > > After reviewing the code, I found anothe possible code
> > > > > > > > > > path. As
> > > > > > > > > > I am
> > > > > > > > > > not familiar with the module. It has high possibility
> > > > > > > > > > it's
> > > > > > > > > > wrong.
> > > > > > > > > > Could please help me check this? Very much appreciated
> > > > > > > > > > for
> > > > > > > > > > your
> > > > > > > > > > valuable time.
> > > > > > > > > >
> > > > > > > > > > In summary, mtk_jpegdec_worker was set in mtk_jpeg_open
> > > > > > > > > > and
> > > > > > > > > > started
> > > > > > > > > > in
> > > > > > > > > > mtk_jpeg_multicore_dec_device_run, which made it
> > > > > > > > > > running on
> > > > > > > > > > cpu1.
> > > > > > > > > > Inside the mtk_jpeg_multicore_dec_device_run, it will
> > > > > > > > > > call
> > > > > > > > > > schedule_delayed_work  to start the timeout_work, which
> > > > > > > > > > will
> > > > > > > > > > make it
> > > > > > > > > > running on cpu2. Meanwhile, we can call
> > > > > > > > > > mtk_jpeg_release to cancel the job. But there might be
> > > > > > > > > > a
> > > > > > > > > > race
> > > > > > > > > > between
> > > > > > > > > > mtk_jpegdec_worker and v4l2_m2m_cancel_job. It may call
> > > > > > > > > > v4l2_m2m_job_finish too early to wake up the event.
> > > > > > > > > > The remove will go on, the other race is as described
> > > > > > > > > > earlier.
> > > > > > > > > >
> > > > > > > > > > cpu0                         cpu1                  cpu2
> > > > > > > > > > (1)->device_run
> > > > > > > > > > mtk_jpeg_multicore
> > > > > > > > > > _dec_device_run
> > > > > > > > > > queue_work
> > > > > > > > > > (jpeg->workqueue,
> > > > > > > > > > &ctx->jpeg_work);
> > > > > > > > > >                       (2)mtk_jpegdec_worker
> > > > > > > > > > (3)mtk_jpeg_release
> > > > > > > > > > v4l2_m2m_cancel_job
> > > > > > > > > > wait event
> > > > > > > > > >
> > > > > > > > > >                       schedule_delayed_work
> > > > > > > > > >                                             (4)mtk_jpeg
> > > > > > > > > > _job
> > > > > > > > > > _tim
> > > > > > > > > > eout_w
> > > > > > > > > > ork
> > > > > > > > > >                       (5)v4l2_m2m_job_finish
> > > > > > > > > >                       wake up
> > > > > > > > > > (6)mtk_jpeg_remove
> > > > > > > > > > v4l2_m2m_release
> > > > > > > > > > kfree(m2m_dev)
> > > > > > > > > >                                             (7)v4l2_m2m
> > > > > > > > > > _get
> > > > > > > > > > _cur
> > > > > > > > > > r_priv
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Dear zheng,
> > > > > > > > >
> > > > > > > > > The mtk_jpeg_multicore_dec_device_run function is used
> > > > > > > > > for
> > > > > > > > > multi-
> > > > > > > > > hw
> > > > > > > > > jpeg decoding. Instead of scheduling
> > > > > > > > > mtk_jpeg_job_timeout_work,
> > > > > > > > > mtk_jpegdec_worker is scheduled in this function.
> > > > > > > > >
> > > > > > > > > The mtk_jpeg_dec_device_run function is used for single
> > > > > > > > > hw
> > > > > > > > > jpeg
> > > > > > > > > decoding, which schedules mtk_jpeg_job_timeout_work.
> > > > > > > > >
> > > > > > > > > A driver is either a single hw driver or a multi-hw
> > > > > > > > > driver
> > > > > > > > > and
> > > > > > > > > cannot
> > > > > > > > > represent both at the same time.
> > > > > > > > > mtk_jpeg_job_timeout_work and mtk_jpegdec_worker cannot
> > > > > > > > > be
> > > > > > > > > scheduled at
> > > > > > > > > the same time.
> > > > > > > > > So mtk_jpeg_job_timeout_work calls v4l2_m2m_job_finish
> > > > > > > > > would
> > > > > > > > > not
> > > > > > > > > cause
> > > > > > > > > competition between the mtk_jpegdec_worker and
> > > > > > > > > v4l2_m2m_cancel_job.
> > > > > > > > >
> > > > > > > > > Regards,
> > > > > > > > > Kyrie.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > Kyrie Wu (=E5=90=B4=E6=99=97) <Kyrie.Wu@mediatek.com> =
=E4=BA=8E2023=E5=B9=B43=E6=9C=888=E6=97=A5=E5=91=A8=E4=B8=89
> > > > > > > > > > 11:32=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > > >
> > > > > > > > > > > On Wed, 2023-03-08 at 10:20 +0800, Zheng Hacker
> > > > > > > > > > > wrote:
> > > > > > > > > > > > Hi Kyrie,
> > > > > > > > > > > >
> > > > > > > > > > > > Thank you for your careful analysis and response. I
> > > > > > > > > > > > still
> > > > > > > > > > > > have
> > > > > > > > > > > > some
> > > > > > > > > > > > areas that I don't quite understand and would like
> > > > > > > > > > > > to
> > > > > > > > > > > > ask
> > > > > > > > > > > > for
> > > > > > > > > > > > clarification. That is, how do the function
> > > > > > > > > > > > pointers
> > > > > > > > > > > > for
> > > > > > > > > > > > stop
> > > > > > > > > > > > streaming, initialized as
> > > > > > > > > > > > mtk_jpeg_enc_stop_streaming
> > > > > > > > > > > > and
> > > > > > > > > > > > mtk_jpeg_dec_stop_streaming, ensure that the worker
> > > > > > > > > > > > is
> > > > > > > > > > > > canceled?
> > > > > > > > > > > > I
> > > > > > > > > > > > would greatly appreciate your response.
> > > > > > > > > > > >
> > > > > > > > > > > > Best regards,
> > > > > > > > > > > > Zheng
> > > > > > > > > > >
> > > > > > > > > > > Dear zheng,
> > > > > > > > > > >
> > > > > > > > > > > For stop streaming, what I mean is that stoppping
> > > > > > > > > > > jpeg
> > > > > > > > > > > decoding or
> > > > > > > > > > > encoding.
> > > > > > > > > > > Ok, let me introduce the sw flow of stop streaming:
> > > > > > > > > > > Firstly, the app will call v4l2_m2m_ioctl_streamoff,
> > > > > > > > > > > which
> > > > > > > > > > > will
> > > > > > > > > > > call
> > > > > > > > > > > v4l2_m2m_cancel_job, if it finds a job running(as you
> > > > > > > > > > > note,
> > > > > > > > > > > cpu1 is
> > > > > > > > > > > running), it will wait event, the event is wake up by
> > > > > > > > > > > v4l2_m2m_job_finish function. And v4l2_m2m_job_finish
> > > > > > > > > > > is
> > > > > > > > > > > called by
> > > > > > > > > > > jpeg
> > > > > > > > > > > dec/enc irq handler, which means that the waitting
> > > > > > > > > > > would
> > > > > > > > > > > result mtk
> > > > > > > > > > > hw
> > > > > > > > > > > to finish dec/enc, irq will occur and irq handler
> > > > > > > > > > > would
> > > > > > > > > > > cancel
> > > > > > > > > > > timeout
> > > > > > > > > > > worker. The follow is shown as blow.
> > > > > > > > > > > v4l2_m2m_ioctl_streamoff
> > > > > > > > > > >    v4l2_m2m_cancel_job                mtk_jpeg_enc_ir
> > > > > > > > > > > q/mt
> > > > > > > > > > > k_jp
> > > > > > > > > > > eg_dec
> > > > > > > > > > > _irq
> > > > > > > > > > >        wait evnet <------ wake up ------
> > > > > > > > > > > v4l2_m2m_job_finish
> > > > > > > > > > >                                         cancel
> > > > > > > > > > > timeout
> > > > > > > > > > > work
> > > > > > > > > > >
> > > > > > > > > > > As mentioned above, if it is normal stop streaming
> > > > > > > > > > > action,
> > > > > > > > > > > there
> > > > > > > > > > > will
> > > > > > > > > > > be no happen that the timeout worker does not
> > > > > > > > > > > canceled.
> > > > > > > > > > >
> > > > > > > > > > > But if mtk_jpeg_remove is called directly without
> > > > > > > > > > > above
> > > > > > > > > > > flow,
> > > > > > > > > > > it
> > > > > > > > > > > would
> > > > > > > > > > > cause lots of issues.
> > > > > > > > > > >
> > > > > > > > > > > Regards,
> > > > > > > > > > > Kyrie.
> > > > > > > > > > > >
> > > > > > > > > > > > Kyrie Wu (=E5=90=B4=E6=99=97) <Kyrie.Wu@mediatek.co=
m> =E4=BA=8E2023=E5=B9=B43=E6=9C=888=E6=97=A5=E5=91=A8=E4=B8=89
> > > > > > > > > > > > 10:02=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Tue, 2023-03-07 at 23:03 +0800, Zheng Hacker
> > > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > The timer function was set in mtk_jpeg_probe
> > > > > > > > > > > > > > with
> > > > > > > > > > > > > > mtk_jpeg_job_timeout_work function.
> > > > > > > > > > > > > > And the worker is started in
> > > > > > > > > > > > > > mtk_jpeg_dec_device_run.
> > > > > > > > > > > > > > There are two functions (mtk_jpeg_enc_irq and
> > > > > > > > > > > > > > mtk_jpeg_dec_irq)
> > > > > > > > > > > > > > which
> > > > > > > > > > > > > > may cancel the worker.
> > > > > > > > > > > > > > They are used as IRQ handler function which is
> > > > > > > > > > > > > > saved as
> > > > > > > > > > > > > > function
> > > > > > > > > > > > > > pointer in a variable.
> > > > > > > > > > > > > > In mtk_jpeg_probe, they are registered by
> > > > > > > > > > > > > > devm_request_irq:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > ret =3D devm_request_irq(&pdev->dev,
> > > > > > > > > > > > > >                jpeg_irq,
> > > > > > > > > > > > > >                jpeg->variant->irq_handler,
> > > > > > > > > > > > > >                0,
> > > > > > > > > > > > > >                pdev->name, jpeg);
> > > > > > > > > > > > > >     if (ret) {
> > > > > > > > > > > > > >       dev_err(&pdev->dev, "Failed to request
> > > > > > > > > > > > > > jpeg_irq
> > > > > > > > > > > > > > %d
> > > > > > > > > > > > > > (%d)\n",
> > > > > > > > > > > > > >         jpeg_irq, ret);
> > > > > > > > > > > > > >       return ret;
> > > > > > > > > > > > > >     }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > However, if we remove the module without
> > > > > > > > > > > > > > triggering
> > > > > > > > > > > > > > the
> > > > > > > > > > > > > > irq,
> > > > > > > > > > > > > > the
> > > > > > > > > > > > > > worker will never be removed.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > As for the schedule, mtk_jpeg_dec_device_run
> > > > > > > > > > > > > > and
> > > > > > > > > > > > > > mtk_jpeg_enc_device_run will start the worker.
> > > > > > > > > > > > > > The schedule invoking is quite complicated. As
> > > > > > > > > > > > > > far
> > > > > > > > > > > > > > as I
> > > > > > > > > > > > > > know,
> > > > > > > > > > > > > > the
> > > > > > > > > > > > > > invoking chain is as follows:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > v4l2_m2m_init->v4l2_m2m_device_run_work-
> > > > > > > > > > > > > > > v4l2_m2m_try_run
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > the v4l2_m2m_device_run_work function is also a
> > > > > > > > > > > > > > worker
> > > > > > > > > > > > > > which
> > > > > > > > > > > > > > is
> > > > > > > > > > > > > > set
> > > > > > > > > > > > > > in
> > > > > > > > > > > > > > v4l2_m2m_init and started in
> > > > > > > > > > > > > > v4l2_m2m_schedule_next_job.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Before calling remove function,
> > > > > > > > > > > > > > the  mtk_jpeg_release
> > > > > > > > > > > > > > was
> > > > > > > > > > > > > > invoked
> > > > > > > > > > > > > > to
> > > > > > > > > > > > > > release the related resource.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > v4l2_m2m_cancel_job will cancel the job by
> > > > > > > > > > > > > > calling
> > > > > > > > > > > > > > m2m_dev->m2m_ops->job_abort(m2m_ctx->priv).
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > But this will only cancel the current queue by
> > > > > > > > > > > > > > list_del(&m2m_dev->curr_ctx->queue);
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I think this can not cancel the posted task
> > > > > > > > > > > > > > mentioned
> > > > > > > > > > > > > > before.
> > > > > > > > > > > > > > So
> > > > > > > > > > > > > > I
> > > > > > > > > > > > > > think if mtk_jpeg_job_timeout_work
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > is working on, and using jpeg->m2m_dev after
> > > > > > > > > > > > > > freeing it
> > > > > > > > > > > > > > in
> > > > > > > > > > > > > > mtk_jpeg_remove, it will cause a UAF bug.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > static int mtk_jpeg_release(struct file *file)
> > > > > > > > > > > > > > {
> > > > > > > > > > > > > >   struct mtk_jpeg_dev *jpeg =3D
> > > > > > > > > > > > > > video_drvdata(file);
> > > > > > > > > > > > > >   struct mtk_jpeg_ctx *ctx =3D
> > > > > > > > > > > > > > mtk_jpeg_fh_to_ctx(file-
> > > > > > > > > > > > > > > private_data);
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >   mutex_lock(&jpeg->lock);
> > > > > > > > > > > > > >   v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
> > > > > > > > > > > > > >   [1] v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
> > > > > > > > > > > > > >   v4l2_fh_del(&ctx->fh);
> > > > > > > > > > > > > >   v4l2_fh_exit(&ctx->fh);
> > > > > > > > > > > > > >   kfree(ctx);
> > > > > > > > > > > > > >   mutex_unlock(&jpeg->lock);
> > > > > > > > > > > > > >   return 0;
> > > > > > > > > > > > > > }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > void v4l2_m2m_ctx_release(struct v4l2_m2m_ctx
> > > > > > > > > > > > > > *m2m_ctx)
> > > > > > > > > > > > > > {
> > > > > > > > > > > > > >   /* wait until the current context is dequeued
> > > > > > > > > > > > > > from
> > > > > > > > > > > > > > job_queue */
> > > > > > > > > > > > > >   [2] v4l2_m2m_cancel_job(m2m_ctx);
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >   vb2_queue_release(&m2m_ctx->cap_q_ctx.q);
> > > > > > > > > > > > > >   vb2_queue_release(&m2m_ctx->out_q_ctx.q);
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >   kfree(m2m_ctx);
> > > > > > > > > > > > > > }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Note that all of this is static analysis, which
> > > > > > > > > > > > > > may
> > > > > > > > > > > > > > be
> > > > > > > > > > > > > > false
> > > > > > > > > > > > > > positive.
> > > > > > > > > > > > > > Feel free to tell me if there is something I've
> > > > > > > > > > > > > > missed.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Regard,
> > > > > > > > > > > > > > Zheng
> > > > > > > > > > > > >
> > > > > > > > > > > > > Dear Zheng,
> > > > > > > > > > > > >
> > > > > > > > > > > > > You set up an application scenario:
> > > > > > > > > > > > > cpu1 is using the mtk-jpeg driver and timeout
> > > > > > > > > > > > > work
> > > > > > > > > > > > > has
> > > > > > > > > > > > > been
> > > > > > > > > > > > > scheduled.
> > > > > > > > > > > > > At the same time cpu0 wanted to remove the mtk-
> > > > > > > > > > > > > jpeg
> > > > > > > > > > > > > driver,
> > > > > > > > > > > > > which
> > > > > > > > > > > > > caused the UAF bug.
> > > > > > > > > > > > > I wonder if such an irrational application
> > > > > > > > > > > > > scenario
> > > > > > > > > > > > > could
> > > > > > > > > > > > > exist.
> > > > > > > > > > > > > This
> > > > > > > > > > > > > scenario, as you described, not only leads to the
> > > > > > > > > > > > > problems you
> > > > > > > > > > > > > mentioned, but also to output&capture memory
> > > > > > > > > > > > > leaks
> > > > > > > > > > > > > and
> > > > > > > > > > > > > unreleased
> > > > > > > > > > > > > resources, such as spinlock.
> > > > > > > > > > > > > Typically, if we want to remove the driver, we
> > > > > > > > > > > > > firstly do
> > > > > > > > > > > > > stop
> > > > > > > > > > > > > streaming, which ensures that the worker has been
> > > > > > > > > > > > > canceled.
> > > > > > > > > > > > > I agree with your changes from the perspective of
> > > > > > > > > > > > > strengthening
> > > > > > > > > > > > > the
> > > > > > > > > > > > > robustness of the driver code.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Regards,
> > > > > > > > > > > > > Kyrie.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Irui Wang (=E7=8E=8B=E7=91=9E) <Irui.Wang@media=
tek.com>
> > > > > > > > > > > > > > =E4=BA=8E2023=E5=B9=B43=E6=9C=887=E6=97=A5=E5=
=91=A8=E4=BA=8C
> > > > > > > > > > > > > > 18:23=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Dear Angelo and Zheng,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Thanks for your patch and comments.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Dear Kyrie,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Please help to check this, thanks.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Best Regards
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Tue, 2023-03-07 at 10:49 +0100,
> > > > > > > > > > > > > > > AngeloGioacchino
> > > > > > > > > > > > > > > Del
> > > > > > > > > > > > > > > Regno
> > > > > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > > > Il 07/03/23 10:27, Zheng Hacker ha scritto:
> > > > > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Is there anyone who can help with this? I
> > > > > > > > > > > > > > > > > can
> > > > > > > > > > > > > > > > > provide
> > > > > > > > > > > > > > > > > more
> > > > > > > > > > > > > > > > > details
> > > > > > > > > > > > > > > > > like invoking chain if needed.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Providing more details is always good.
> > > > > > > > > > > > > > > > Please
> > > > > > > > > > > > > > > > do.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Meanwhile, adding Irui Wang to the loop:
> > > > > > > > > > > > > > > > he's
> > > > > > > > > > > > > > > > doing
> > > > > > > > > > > > > > > > mtk-
> > > > > > > > > > > > > > > > jpeg.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Regards,
> > > > > > > > > > > > > > > > Angelo
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Thanks,
> > > > > > > > > > > > > > > > > Zheng
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Zheng Wang <zyytlz.wz@163.com>
> > > > > > > > > > > > > > > > > =E4=BA=8E2023=E5=B9=B43=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=B8=80
> > > > > > > > > > > > > > > > > 14:28=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > In mtk_jpeg_probe, &jpeg-
> > > > > > > > > > > > > > > > > > >job_timeout_work
> > > > > > > > > > > > > > > > > > is
> > > > > > > > > > > > > > > > > > bound
> > > > > > > > > > > > > > > > > > with
> > > > > > > > > > > > > > > > > > mtk_jpeg_job_timeout_work. Then
> > > > > > > > > > > > > > > > > > mtk_jpeg_dec_device_run
> > > > > > > > > > > > > > > > > > and mtk_jpeg_enc_device_run may be
> > > > > > > > > > > > > > > > > > called
> > > > > > > > > > > > > > > > > > to
> > > > > > > > > > > > > > > > > > start
> > > > > > > > > > > > > > > > > > the
> > > > > > > > > > > > > > > > > > work.
> > > > > > > > > > > > > > > > > > If we remove the module which will call
> > > > > > > > > > > > > > > > > > mtk_jpeg_remove
> > > > > > > > > > > > > > > > > > to make cleanup, there may be a
> > > > > > > > > > > > > > > > > > unfinished
> > > > > > > > > > > > > > > > > > work. The
> > > > > > > > > > > > > > > > > > possible sequence is as follows, which
> > > > > > > > > > > > > > > > > > will
> > > > > > > > > > > > > > > > > > cause a
> > > > > > > > > > > > > > > > > > typical UAF bug.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Fix it by canceling the work before
> > > > > > > > > > > > > > > > > > cleanup
> > > > > > > > > > > > > > > > > > in
> > > > > > > > > > > > > > > > > > the
> > > > > > > > > > > > > > > > > > mtk_jpeg_remove
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > CPU0                  CPU1
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >                      |mtk_jpeg_job_time
> > > > > > > > > > > > > > > > > > out_
> > > > > > > > > > > > > > > > > > work
> > > > > > > > > > > > > > > > > > mtk_jpeg_remove     |
> > > > > > > > > > > > > > > > > >    v4l2_m2m_release  |
> > > > > > > > > > > > > > > > > >      kfree(m2m_dev); |
> > > > > > > > > > > > > > > > > >                      |
> > > > > > > > > > > > > > > > > >                      |
> > > > > > > > > > > > > > > > > > v4l2_m2m_get_curr_priv
> > > > > > > > > > > > > > > > > >                      |   m2m_dev-
> > > > > > > > > > > > > > > > > > >curr_ctx
> > > > > > > > > > > > > > > > > > //use
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Signed-off-by: Zheng Wang <
> > > > > > > > > > > > > > > > > > zyytlz.wz@163.com>
> > > > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > drivers/media/platform/mediatek/jpeg/mt
> > > > > > > > > > > > > > > > > > k_jp
> > > > > > > > > > > > > > > > > > eg_c
> > > > > > > > > > > > > > > > > > ore.c
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > 2 +-
> > > > > > > > > > > > > > > > > >   1 file changed, 1 insertion(+), 1
> > > > > > > > > > > > > > > > > > deletion(-)
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > diff --git
> > > > > > > > > > > > > > > > > > a/drivers/media/platform/mediatek/jpeg/
> > > > > > > > > > > > > > > > > > mtk_
> > > > > > > > > > > > > > > > > > jpeg
> > > > > > > > > > > > > > > > > > _core.
> > > > > > > > > > > > > > > > > > c
> > > > > > > > > > > > > > > > > > b/drivers/media/platform/mediatek/jpeg/
> > > > > > > > > > > > > > > > > > mtk_
> > > > > > > > > > > > > > > > > > jpeg
> > > > > > > > > > > > > > > > > > _core.
> > > > > > > > > > > > > > > > > > c
> > > > > > > > > > > > > > > > > > index 969516a940ba..364513e7897e 100644
> > > > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > > > > a/drivers/media/platform/mediatek/jpeg/
> > > > > > > > > > > > > > > > > > mtk_
> > > > > > > > > > > > > > > > > > jpeg
> > > > > > > > > > > > > > > > > > _core.
> > > > > > > > > > > > > > > > > > c
> > > > > > > > > > > > > > > > > > +++
> > > > > > > > > > > > > > > > > > b/drivers/media/platform/mediatek/jpeg/
> > > > > > > > > > > > > > > > > > mtk_
> > > > > > > > > > > > > > > > > > jpeg
> > > > > > > > > > > > > > > > > > _core.
> > > > > > > > > > > > > > > > > > c
> > > > > > > > > > > > > > > > > > @@ -1793,7 +1793,7 @@ static int
> > > > > > > > > > > > > > > > > > mtk_jpeg_probe(struct
> > > > > > > > > > > > > > > > > > platform_device *pdev)
> > > > > > > > > > > > > > > > > >   static int mtk_jpeg_remove(struct
> > > > > > > > > > > > > > > > > > platform_device
> > > > > > > > > > > > > > > > > > *pdev)
> > > > > > > > > > > > > > > > > >   {
> > > > > > > > > > > > > > > > > >          struct mtk_jpeg_dev *jpeg =3D
> > > > > > > > > > > > > > > > > > platform_get_drvdata(pdev);
> > > > > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > > > > +       cancel_delayed_work(&jpeg-
> > > > > > > > > > > > > > > > > > > job_timeout_work);
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >          pm_runtime_disable(&pdev-
> > > > > > > > > > > > > > > > > > >dev);
> > > > > > > > > > > > > > > > > >          video_unregister_device(jpeg-
> > > > > > > > > > > > > > > > > > > vdev);
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >          v4l2_m2m_release(jpeg-
> > > > > > > > > > > > > > > > > > >m2m_dev);
> > > > > > > > > > > > > > > > > > --
> > > > > > > > > > > > > > > > > > 2.25.1
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
