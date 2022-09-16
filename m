Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325C45BB010
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiIPPS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIPPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:18:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BEDAB046
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:18:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lh5so8409650ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=55ikNjZu2lLTSKrlcR45Rd2dsmWzpxFU3Izjr1Z+HPM=;
        b=dm694FgQRRW58JJlBKZdxPpYagX8GiPvP8m7dJkhEzwogQFodCRlaH8MX2pZFZchkh
         OH/Lcjo9P1A0QJaOr9SjJ/Jxi/rzOm3JuCEbL+ubt/u2vzHdS8gLsNN6kxrBgKXFLiTV
         TQq9whjQltpVX5o6LTDXb4nnsfVkGpRyWAG2ui64BQ4gPsHEV/4v3NgtKC2CtXXRTT1X
         a7fabXDklDxANwDY7TcSoj7bQBXUQLTyW9mJTjuZ8KuFQJoLg9kE+xw7yLFmD5p+uVbQ
         GSssWku35Je7JRyF+psTNVgyA/CM4JoLsnvDOagb7c8w2Mjn2kp92GHR3JRChNZLUsLe
         m44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=55ikNjZu2lLTSKrlcR45Rd2dsmWzpxFU3Izjr1Z+HPM=;
        b=f+1aD0idGHHYMy4DCkBEIMZu3+ccw0toUT8EWXYullGY6jOL1eens+TZFSUymsI2HN
         HApy2Uw1kr9o/x7K61i4wKOh6cgfiLMXfwGVaFp01ahqALm6amTKVZxhCM+e62nXEJvp
         lEml7ehCFEhz5rEoDpp6HTASVOW7BPiVxj3YD0y9uRgbFMKvZS75bZIM/ulGiMcwyPGM
         yYn5cf8gglLmI57QYlbZxMX3WxYypvrHN6qavXmcEn0jY2B146OcytDKKRP09BW1cUYa
         yORn35k0LeCWDdVAimHOlJPhqtZm7ER5dmFIu673dqVFcpEF5BsGvJNtUMGa5qe2JrLR
         5xJA==
X-Gm-Message-State: ACrzQf3OtjqpO6hqeW+Hbnz0w8H13tgMQc+8542XnDY1OQpboYNZlLUc
        SakUjtMnhFHrTd+dso2+KSpyhHDkTeUh+mKHa1E=
X-Google-Smtp-Source: AMsMyM4YqBrJ/2f3gYg3zPEjly8pxbEx8kbYBSINcFeq3WVMnUlDZh/wikdm/NhblARITHT4YEsrZX4l0KuXSuNffcQ=
X-Received: by 2002:a17:907:16a6:b0:780:4a3c:d179 with SMTP id
 hc38-20020a17090716a600b007804a3cd179mr4005451ejc.289.1663341530376; Fri, 16
 Sep 2022 08:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_48738CD5589B4162E0D0B9D85B84DCD33C0A@qq.com> <YyQwsxDoaWT6Y5a0@kroah.com>
In-Reply-To: <YyQwsxDoaWT6Y5a0@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 16 Sep 2022 23:18:38 +0800
Message-ID: <CAJedcCzPk1YQqP3o6N9cs+-86zPGKCdKMCr4R9dSFP7WSuSmpw@mail.gmail.com>
Subject: Re: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     xmzyshypnc <1002992920@qq.com>, dimitri.sivanich@hpe.com,
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

Hi greg,

I've received your advice and rewrite the patch.

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B49=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=BA=94 16:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Sep 16, 2022 at 03:39:57PM +0800, xmzyshypnc wrote:
> > in drivers/misc/sgi-gru/grufile.c, gru_file_unlocked_ioctl function can=
 be called by user. If the req is GRU_SET_CONTEXT_OPTION, it will call gru_=
set_context_option.
>
> Please properly wrap your changelog text at 72 columns like your editor
> asked you to when you wrote the changelog text.
>
> >
> > In gru_set_context_option, as req can be controlled by user (copy_from_=
user(&req, (void __user *)arg, sizeof(req))), we can get into sco_blade_chi=
plet case and reach gru_check_context_placement function call.
> >
> > in gru_check_context_placement function, if the error path was steped, =
say gru_check_chiplet_assignment return 0, then it will fall into gru_unloa=
d_context function,which will call gru_free_gru_context->gts_drop. As gts->=
ts_refcnt was set to 1 in gru_alloc_gts. It will finnaly call kfree(gts) in=
 gts_drop function.
> >
> > Then gru_unlock_gts will be called in gru_set_context_option function. =
which is a typical Use after free.
> >
> > The same problem exists in gru_handle_user_call_os function and gru_fau=
lt function.
> >
> > Fix it by introduce the return value to see if gts is in good case or n=
ot. Free the gts in caller when gru_check_chiplet_assignment check failed.
> >
> > Signed-off-by: xmzyshypnc <1002992920@qq.com>
> > ---
> >  drivers/misc/sgi-gru/grufault.c  | 14 ++++++++++++--
> >  drivers/misc/sgi-gru/grumain.c   | 19 +++++++++++++++----
> >  drivers/misc/sgi-gru/grutables.h |  2 +-
> >  3 files changed, 28 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/gru=
fault.c
> > index d7ef61e602ed..08e837a45ad7 100644
> > --- a/drivers/misc/sgi-gru/grufault.c
> > +++ b/drivers/misc/sgi-gru/grufault.c
> > @@ -656,7 +656,13 @@ int gru_handle_user_call_os(unsigned long cb)
> >       if (ucbnum >=3D gts->ts_cbr_au_count * GRU_CBR_AU_SIZE)
> >               goto exit;
> >
> > -     gru_check_context_placement(gts);
> > +     ret =3D gru_check_context_placement(gts);
> > +
> > +     if (ret) {
>
> No blank line needed.

Got it.

>
> > +             gru_unlock_gts(gts);
> > +             gru_unload_context(gts, 1);
> > +             return -EINVAL;
>
> Jump to an error block at the end of the function instead?
>
> > +     }
> >
> >       /*
> >        * CCH may contain stale data if ts_force_cch_reload is set.
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
> > index 9afda47efbf2..e1ecf86df3c1 100644
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
>
> Why is this succeeding if there was an error?
>

The logic code here is when gts->ts_gru is null, it try again. It
won't free the gts so I think it can still be called after this
branch.

> >
> >       if (!gru_check_chiplet_assignment(gru, gts)) {
> >               STAT(check_context_unload);
> > -             gru_unload_context(gts, 1);
> > +             ret =3D 1;
>
> 1 is not a valid error value;
>
>
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
> > +             return VM_FAULT_NOPAGE;
>
> Why not return ret?
>

Got it.

> > +     }
> >
> >       if (!gts->ts_gru) {
> >               STAT(load_user_context);
> > @@ -958,6 +967,8 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
> >       preempt_enable();
> >       mutex_unlock(&gts->ts_ctxlock);
> >
> > +
> > +
>
> Why the blank lines added?
>

Removed.

Best regards,

Zheng Wang
