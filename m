Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7695FA1EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJJQ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJJQ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:27:39 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E1C1C933
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:27:38 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id h10so7403896qvq.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gCsgld326sMzPUJZsyGspl1RBYLHRFVtM4C0vnRTXQ=;
        b=bJwgW6oIX0Aar7xqTp/y9T4Jen79CmkB0OqopxhisbvA7gMr/n8KTzRe5zZCo+rsHm
         cbhOSDrYJa+FkvnGvWWMKEvQ7E0lhrIScBLtvvhuWKk/VMRkytlRMtTIWCKbYAVqwFcV
         kbs3BcA0WD6+ZUwEylPZvSSPy3qA6kGMtVxoHLCmpgUo6XOG4bS5iTSdTS/HUCwNR49V
         sw+Zf2I4N7AWYQ7kgk8IdJC8vuJGeWFyAh6/sI48NhoqRW/FyvQr2QYso3nitB0T3kpU
         5HEB3Yj2p911I9LYnbOKAL0e8cU/zH+rKz5gKdeWYdb7j7Wib+Q0S9tOHlhiOv62N+ER
         piTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gCsgld326sMzPUJZsyGspl1RBYLHRFVtM4C0vnRTXQ=;
        b=5t8/oFW94zRPVkbaAgWM+m745vRSVYWcdVXSP9OJ5QG45WHMjo+DonpoqUmCYMpGei
         1IkvCrItcWgkTiyUbUuPnFEUiCV3nc6J+VOJbV1N57rgagzdLGhGLOA5XofPuDlAb+2A
         NTPi+WU34xV2/INekHZHtTXX2vNod12ud+zRWHxhbgHEeODBNYav8mPeItLhcT4Ahr5C
         WvL4mZIRg2MVsQgBVfyJz4Ci6qpN3VAOxMBpS9OVzRgBF8QLAJdNI1QPnpTW2hbwgfS5
         DwSY+EiWkfYLCSNn8dPJTGWlV1cTR+VtnMPjs+KBMemuI48aoGntkEC5f59xuvL9HWZ7
         raBQ==
X-Gm-Message-State: ACrzQf2BgAksezqY11Gq+d1KfJCkh272u2FqOvRm3vhsc1aNwZl85S7f
        12CAkAzCOlYJ5dXcMrc8oGhhfQaobIfU4Yj0B7daiPtXEzHaFw==
X-Google-Smtp-Source: AMsMyM7mx0xRKlFrItfYgceqI8+JApOjMS5fQuWaywbpsmr0vTdIhQTFvfxdzLsEKNf5KJtZAroiZicxGlSS3nhL7Pk=
X-Received: by 2002:a05:6214:3005:b0:4ad:8042:128a with SMTP id
 ke5-20020a056214300500b004ad8042128amr15648331qvb.66.1665419257129; Mon, 10
 Oct 2022 09:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221006152643.1694235-1-zyytlz.wz@163.com> <20221009192730.508824-1-zhengyejian1@huawei.com>
In-Reply-To: <20221009192730.508824-1-zhengyejian1@huawei.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 11 Oct 2022 00:27:26 +0800
Message-ID: <CAJedcCxkAGWVo8WySk9w5PPBuy_Q70FQtyT1jfitnc9x5Fcv4Q@mail.gmail.com>
Subject: Re: [PATCH v2] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     zyytlz.wz@163.com, alex000young@gmail.com, arnd@arndb.de,
        dimitri.sivanich@hpe.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, security@kernel.org
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

Zheng Yejian <zhengyejian1@huawei.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=889=
=E6=97=A5=E5=91=A8=E6=97=A5 19:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu,  6 Oct 2022 23:26:43 +0800
> Zheng Wang <zyytlz.wz@163.com> wrote:
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
> > v2:
> > - commit message changes suggested by Greg
> >
> > v1: https://lore.kernel.org/lkml/CAJedcCzY72jqgF-pCPtx66vXXwdPn-KMagZnq=
rxcpWw1NxTLaA@mail.gmail.com/
> > ---
> >  drivers/misc/sgi-gru/grufault.c  | 15 ++++++++++++---
> >  drivers/misc/sgi-gru/grumain.c   | 17 +++++++++++++----
> >  drivers/misc/sgi-gru/grutables.h |  2 +-
> >  3 files changed, 26 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/gru=
fault.c
> > index d7ef61e602ed..f1e5b96fef4b 100644
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
> > @@ -889,6 +895,9 @@ int gru_set_context_option(unsigned long arg)
> >               ret =3D -EINVAL;
> >       }
> >       gru_unlock_gts(gts);
> > -
> > +     if (ret) {
> > +             gru_unload_context(gts, 1);
> > +             ret =3D -EINVAL;
> > +     }
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
>
> preempt_disable() is called before, is a preempt_enable() required here?
>

Oh yes, thanks for your suggestion Yejian. I will add that in the next patc=
h :).

Best regards,
Zheng Wang
