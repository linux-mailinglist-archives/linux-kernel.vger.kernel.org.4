Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A537660EE17
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiJ0Cxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiJ0Cxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:53:52 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1214127422
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 19:53:50 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id c8so126244qvn.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 19:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/F0KvvzPzam+pL/zq2NtDH9Kf+pd5H0FPgs/iHKLvXc=;
        b=QVZBiowV4VwQ15j3CxQ/4O0VghNGgQ/2rkFrKv0FoxTsT5c1iE4OITi4W1xUmHul6W
         hBf72l+fAmt7LZuWkXsn9xB+vYQIu2Pp1EtC6iFPKuf8GI39ck8PLhhV3ljivogtS8yT
         BEjnJyx2hCAw78f4dXMuD+xbnTsiTtkjxYrRJ85/JN6vYzCzdOi9fGBzzDJ1llduepDA
         WCnqph7Acu0+i6HYw1Z0NbmRv3eVguMtVR+8EXFQhgBoabCOYaOaKPCcda66XYtPG41C
         ueEZGh+zbslQjrebtbbEzc5Fghm5Dvrn9s6DJ301v1mKoKTsdpWxt5yYQ0SCrvztMYAV
         GidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/F0KvvzPzam+pL/zq2NtDH9Kf+pd5H0FPgs/iHKLvXc=;
        b=gJhS+NIJddKmkzg0PQ6iJF02XT8KfRjvrhOE5W+zJQzGXrWnrDoMqgY30X2YZfx65G
         CTpP1uWzOyCktJDO7L2Rm6jI1B397JwJ1fkESURDU+1uFGOE9oKUpvdDI5x1BYn7fVJg
         6jK5UYd7PIjkMKfMOnrhhs/Ggtt1AZr6tGdOG56bamRH+fu7MUEvNDO6u+0m2YjZq1Eu
         qEs5J4ZYvtgsqxfxHo4HkStpEUGo588T/ADI/K2fzCcN50yUr1tFv7W8jFSXKCvm8bV3
         rTOx+sLiQksx0BcCj6iVOhimGULBkgUIhn0IeMHAMdJl3DboDe0Slqys1J8MU9r4ZDlT
         vR8A==
X-Gm-Message-State: ACrzQf3hVRCPwTZxad+uL4vpMflAAMxJjZeq/2y3zVqBrUd3Gd/XWhJI
        VYzRGHrcOW0dEnUIqVcwmoRS+qk2DDIJ+exvwYM=
X-Google-Smtp-Source: AMsMyM5ZrEWTmp6PYkQxZOw544IMl1yCLNkeobkQKPMBY3ycS7uHmalEPRaHmj3NWebJHoi3agGO0IyE3eh1fKDsLlA=
X-Received: by 2002:a05:6214:21ea:b0:4b1:bc8f:b182 with SMTP id
 p10-20020a05621421ea00b004b1bc8fb182mr38658502qvj.90.1666839229808; Wed, 26
 Oct 2022 19:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221019031445.901570-1-zyytlz.wz@163.com> <20221019140043.GD18792@hpe.com>
In-Reply-To: <20221019140043.GD18792@hpe.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 27 Oct 2022 10:53:36 +0800
Message-ID: <CAJedcCx-NsboZcyuFAOzR1LqcGK+jfDOQu9xb0i+VFSaw2drQQ@mail.gmail.com>
Subject: Re: [PATCH v4] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Dimitri Sivanich <sivanich@hpe.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, gregkh@linuxfoundation.org,
        zhengyejian1@huawei.com, dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, alex000young@gmail.com,
        security@kernel.org
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

Hi Dimitri Sivanich,

Sorry for my late reply. I was a little busy last week. I'll check the
code right now and let you know.

Thanks for your suggestion :)

Best Regards,
Zheng Wang

Dimitri Sivanich <sivanich@hpe.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=B8=89 22:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Oct 19, 2022 at 11:14:45AM +0800, Zheng Wang wrote:
> > Gts may be freed in gru_check_chiplet_assignment.
> > The caller still use it after that, UAF happens.
> >
> > Fix it by introducing a return value to see if it's in error path or no=
t.
> > Free the gts in caller if gru_check_chiplet_assignment check failed.
> >
> > Fixes: 55484c45dbec ("gru: allow users to specify gru chiplet 2")
> > Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> > v4:
> > - use VM_FAULT_NOPAGE as failure code in gru_fault and -EINVAL in other=
 functions suggested by Yejian
> >
> > v3:
> > - add preempt_enable and use VM_FAULT_NOPAGE as failure code suggested =
by Yejian
> >
> > v2:
> > - commit message changes suggested by Greg
> >
> > v1: https://lore.kernel.org/lkml/CAJedcCzY72jqgF-pCPtx66vXXwdPn-KMagZnq=
rxcpWw1NxTLaA@mail.gmail.com/
> > ---
> >  drivers/misc/sgi-gru/grufault.c  | 14 ++++++++++++--
> >  drivers/misc/sgi-gru/grumain.c   | 18 ++++++++++++++----
> >  drivers/misc/sgi-gru/grutables.h |  2 +-
> >  3 files changed, 27 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/gru=
fault.c
> > index d7ef61e602ed..2b5b049fbd38 100644
> > --- a/drivers/misc/sgi-gru/grufault.c
> > +++ b/drivers/misc/sgi-gru/grufault.c
> > @@ -656,7 +656,9 @@ int gru_handle_user_call_os(unsigned long cb)
> >       if (ucbnum >=3D gts->ts_cbr_au_count * GRU_CBR_AU_SIZE)
> >               goto exit;
> >
> > -     gru_check_context_placement(gts);
> > +     ret =3D gru_check_context_placement(gts);
> > +     if (ret)
> > +             goto err;
> >
> >       /*
> >        * CCH may contain stale data if ts_force_cch_reload is set.
> > @@ -677,6 +679,10 @@ int gru_handle_user_call_os(unsigned long cb)
> >  exit:
> >       gru_unlock_gts(gts);
> >       return ret;
> > +err:
> > +     gru_unlock_gts(gts);
> > +     gru_unload_context(gts, 1);
> > +     return -EINVAL;
> >  }
> >
> >  /*
> > @@ -874,7 +880,7 @@ int gru_set_context_option(unsigned long arg)
> >               } else {
> >                       gts->ts_user_blade_id =3D req.val1;
> >                       gts->ts_user_chiplet_id =3D req.val0;
> > -                     gru_check_context_placement(gts);
> > +                     ret =3D gru_check_context_placement(gts);
>
> In gru_set_context_option(), you are calling gru_unload_context() for all
> non-zero 'ret' values, but there are other instances where non-zero 'ret'
> values are being set that should not call gru_unload_context().  Maybe do
> this instead:
>                         if (gru_check_context_placement(gts)) {
>                                 gru_unlock_gts(gts);
>                                 gru_unload_context(gts, 1);
>                                 return -EINVAL;
>                         }
>
> >               }
> >               break;
> >       case sco_gseg_owner:
> > @@ -889,6 +895,10 @@ int gru_set_context_option(unsigned long arg)
> >               ret =3D -EINVAL;
> >       }
> >       gru_unlock_gts(gts);
> > +     if (ret) {
> > +             gru_unload_context(gts, 1);
> > +             ret =3D -EINVAL;
> > +     }
> >
> >       return ret;
> >  }
> > diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grum=
ain.c
> > index 9afda47efbf2..77becb52f550 100644
> > --- a/drivers/misc/sgi-gru/grumain.c
> > +++ b/drivers/misc/sgi-gru/grumain.c
> > @@ -716,9 +716,10 @@ static int gru_check_chiplet_assignment(struct gru=
_state *gru,
> >   * chiplet. Misassignment can occur if the process migrates to a diffe=
rent
> >   * blade or if the user changes the selected blade/chiplet.
> >   */
> > -void gru_check_context_placement(struct gru_thread_state *gts)
> > +int gru_check_context_placement(struct gru_thread_state *gts)
> >  {
> >       struct gru_state *gru;
> > +     int ret =3D 0;
> >
> >       /*
> >        * If the current task is the context owner, verify that the
> > @@ -727,14 +728,16 @@ void gru_check_context_placement(struct gru_threa=
d_state *gts)
> >        */
> >       gru =3D gts->ts_gru;
> >       if (!gru || gts->ts_tgid_owner !=3D current->tgid)
> > -             return;
> > +             return ret;
> >
> >       if (!gru_check_chiplet_assignment(gru, gts)) {
> >               STAT(check_context_unload);
> > -             gru_unload_context(gts, 1);
> > +             ret =3D -EINVAL;
> >       } else if (gru_retarget_intr(gts)) {
> >               STAT(check_context_retarget_intr);
> >       }
> > +
> > +     return ret;
> >  }
> >
> >
> > @@ -919,6 +922,7 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
> >       struct gru_thread_state *gts;
> >       unsigned long paddr, vaddr;
> >       unsigned long expires;
> > +     int ret;
> >
> >       vaddr =3D vmf->address;
> >       gru_dbg(grudev, "vma %p, vaddr 0x%lx (0x%lx)\n",
> > @@ -934,7 +938,13 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
> >       mutex_lock(&gts->ts_ctxlock);
> >       preempt_disable();
> >
> > -     gru_check_context_placement(gts);
> > +     ret =3D gru_check_context_placement(gts);
> > +     if (ret) {
>
> One suggestion, there is now no need to declare 'ret'.  Do this instead:
>         if (gru_check_context_placement(gts)) {
>
> > +             preempt_enable();
> > +             mutex_unlock(&gts->ts_ctxlock);
> > +             gru_unload_context(gts, 1);
> > +             return VM_FAULT_NOPAGE;
> > +     }
> >
> >       if (!gts->ts_gru) {
> >               STAT(load_user_context);
> > diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/gr=
utables.h
> > index 5efc869fe59a..f4a5a787685f 100644
> > --- a/drivers/misc/sgi-gru/grutables.h
> > +++ b/drivers/misc/sgi-gru/grutables.h
> > @@ -632,7 +632,7 @@ extern int gru_user_flush_tlb(unsigned long arg);
> >  extern int gru_user_unload_context(unsigned long arg);
> >  extern int gru_get_exception_detail(unsigned long arg);
> >  extern int gru_set_context_option(unsigned long address);
> > -extern void gru_check_context_placement(struct gru_thread_state *gts);
> > +extern int gru_check_context_placement(struct gru_thread_state *gts);
> >  extern int gru_cpu_fault_map_id(void);
> >  extern struct vm_area_struct *gru_find_vma(unsigned long vaddr);
> >  extern void gru_flush_all_tlb(struct gru_state *gru);
> > --
> > 2.25.1
