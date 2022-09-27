Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAA65EC5A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiI0ONO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiI0ONM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:13:12 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2718E1BA3A5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:13:10 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g12so6086720qts.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=cZNME+2oxt/cdxzygPofdLVyqQx3S2MR0tP4zyD+57o=;
        b=DPCaBk01L3Bku03OpHAJDmpYR492q8JMsSaqTQP0C+bj7Pd5pL/ERxT2QekSEnapVC
         sAujmQj7IVPF+I8vOW/yrynPleP5nmOqCZzYwkQWSYQGjjk+NSqsilGpLea3F77uNyvW
         nIybfbODygMcwIqn6G4H5BF/yCwP8DfhZZX2KfONDhVjsjfj9d6cjd4n5NHS2cBA8GrZ
         e7wuH2Z5HoRVbAf/BKW/dfmgIMy7BLEWLHe2D2CdHxJliMsi/lYs6v6YW83unp/W07LG
         TU6wmIh6ZMJZQhUSvmxlF6yhnarvzKmytRJTrVg6fo7+T3dXkqPwoNSlyv1zEm/Oj3x/
         lQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cZNME+2oxt/cdxzygPofdLVyqQx3S2MR0tP4zyD+57o=;
        b=NywdpWDuLrVYKap6Op3s1L97p4oudZIv8xO04gjUQ4NUekQVALVbb9wOBdqckwDPED
         8XM6ViyQtmE8LxwvDg5apQoozJNR1j6A2kGBcWGsQbyrMwvZ+mPuSW+3tvpUZ5kZoqWn
         nmpWztHCr93YNHk+4OUOIqkrT1StJkb5fNtgS3EycGSLywUcqajrZp/fBIqiUXRh3rIA
         JMsd2FtmiwDlGicek1wY6xyydRT9RoV1YJU66M9xgzXe2OKT0JjMQzCOYPgj89+2qksx
         MiIrf/ILv0K/uCobIkBLSjRT0nNlXXsqpmrvyY10bAT4sXx2GZvqdSC6JR/uijmLcwm8
         sXfA==
X-Gm-Message-State: ACrzQf29nmrAr3Bdwz+ql9j+9lMZnH+YsbLpBwqVF91umRCNUzKiEiqK
        UPXXcEt5kZcNIREKESjy8UaumbBc0nCAjC51F5s=
X-Google-Smtp-Source: AMsMyM7E7o0bKIf65jGSTRcbwmydky7+4/FR9aESxK4KyIPYVYfofgQhNKOwp5nNubosWEobUnQzJ5Cx2yGidqW7qiY=
X-Received: by 2002:ac8:7d14:0:b0:35c:bdbe:5b97 with SMTP id
 g20-20020ac87d14000000b0035cbdbe5b97mr22581355qtb.272.1664287989078; Tue, 27
 Sep 2022 07:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220926043618.566326-1-zyytlz.wz@163.com> <YzFkpRfkdnwgDDw6@kroah.com>
In-Reply-To: <YzFkpRfkdnwgDDw6@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 27 Sep 2022 22:12:58 +0800
Message-ID: <CAJedcCxGkz6i2LeCGWcHgU7P2n1TeB9gKVZCzmjPPJK=hhsfLA@mail.gmail.com>
Subject: Re: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, dimitri.sivanich@hpe.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        alex000young@gmail.com, security@kernel.org
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

Hi Greg,

I've resent the patch. Could you please review it and apply if there
is no more problem?

Thanks,
Zheng Wang

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B49=E6=9C=8826=E6=
=97=A5=E5=91=A8=E4=B8=80 16:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 26, 2022 at 12:36:18PM +0800, Zheng Wang wrote:
> > Gts may be freed in gru_check_chiplet_assignment.
> > The caller still use it after that, UAF happens.
> >
> > Fix it by introducing a return value to see if it's in error path or no=
t.
> > Free the gts in caller if gru_check_chiplet_assignment check failed.
> >
> > Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> >
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> >
> > ---
> >  drivers/misc/sgi-gru/grufault.c  | 14 ++++++++++++--
> >  drivers/misc/sgi-gru/grumain.c   | 17 +++++++++++++----
> >  drivers/misc/sgi-gru/grutables.h |  2 +-
> >  3 files changed, 26 insertions(+), 7 deletions(-)
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
> > index 9afda47efbf2..79903cf7e706 100644
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
> > @@ -934,7 +938,12 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
> >       mutex_lock(&gts->ts_ctxlock);
> >       preempt_disable();
> >
> > -     gru_check_context_placement(gts);
> > +     ret =3D gru_check_context_placement(gts);
> > +     if (ret) {
> > +             mutex_unlock(&gts->ts_ctxlock);
> > +             gru_unload_context(gts, 1);
> > +             return ret;
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
> >
> >
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/SubmittingPatches for what needs to be done
>   here to properly describe this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot
