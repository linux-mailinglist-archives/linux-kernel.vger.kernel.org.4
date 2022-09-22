Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685CC5E58F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiIVDAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiIVDAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:00:41 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6E37F0A0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:00:37 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g12so5491046qts.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=YlJD8tCE9et0QaEe7jWRB3CIttT6TuHJ6CPBDS6dEhQ=;
        b=Vm2z7qIsHQ+lECcBSg5sHQUSFxK9qnyIq8fTxppNtRSaRzKGAevaFKAGjyrig5cGbo
         2gIApPa7sGQQGCm92idpVZE19IZJHH5eZneF30RgGaCkMk2Sjslg2A49+QV7y3Z/v3FQ
         7NsdfTP7fLeupxQIXoHGNaHSxXJYcJn6FQ/Yroxq9M1OM9P7TWXqvmH1oC6T/HjGsD0P
         t5JUPUZMgQxam/Tvpv7uP3yvW2VJ3A8MhlWr5S7qmcom8CNTyA+ur7zBiwC1z7izVKkQ
         0QXxeq0GQEzfthij5H/P2/NDZWQtlPg8gMN4TpbABgfuCynXfaIeIRbreOyfcgTy4FAy
         2/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YlJD8tCE9et0QaEe7jWRB3CIttT6TuHJ6CPBDS6dEhQ=;
        b=HM5H10ZG3LzMFvyVxRoLTTPC+1MxOfhgV9u0tHbaFn7D8eV19+7Ysc7sqf7v3+uOqw
         yooBoWNK7KjZQ8ltLsknHA/0F7I8odQA7KjAh7MIQq4aJ2Bnh/dA+DzxBZGq4Ao/Brr4
         FSOHtHkr+WEiEHJZdF2b7vf86VCkkh+TwNFAC2wHscaQexdcwXPO3qJHLmYN3/HpOIEq
         scAKl08n1g5rVpe5KxebF1m9ihowK5ssXnNRkToIBPbGzVkm6wexOrWWVmGOKmO+cxg6
         sfFhDwlF82YgkhPkutsY9wscyNf9gwbWMoFqg7ncvt8QGyo/3jpNsUwAEvzgQ81qlPHV
         H+fA==
X-Gm-Message-State: ACrzQf3YxaAQ4EdFehQVOmEWie9O1CiEsFE4dtbJuaDMoXAL06Wk2emu
        bwlgHoPqb+9LwpFyfmk8YeVNBEXK3NI8QOQO32A=
X-Google-Smtp-Source: AMsMyM4wdIS0Jx6tR+5xrCeOKTi4Y6Hg/92TbiZLBukNjuCDCrP0BraNgkqy+TLOKpADNO+eisRc9Rqtyrsx+1qk/xQ=
X-Received: by 2002:a05:622a:189d:b0:35b:c3f7:495e with SMTP id
 v29-20020a05622a189d00b0035bc3f7495emr1198600qtc.416.1663815636542; Wed, 21
 Sep 2022 20:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220919143205.207353-1-zyytlz.wz@163.com>
In-Reply-To: <20220919143205.207353-1-zyytlz.wz@163.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 22 Sep 2022 11:00:23 +0800
Message-ID: <CAJedcCyo7cbrx=LgCVpy1F4cDr=wh+1K15X3b3-Yt9wzDoXrzQ@mail.gmail.com>
Subject: Re: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     dimitri.sivanich@hpe.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
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

Hi,

I've sent the patch with anothe account.
Could you please try this one?

Regards,
Zheng Wang

Zheng Wang <zyytlz.wz@163.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8819=E6=97=A5=
=E5=91=A8=E4=B8=80 22:32=E5=86=99=E9=81=93=EF=BC=9A
>
> In grufile.c, gru_file_unlocked_ioctl function can be called by user.
>
> If the req is GRU_SET_CONTEXT_OPTION, it will call gru_set_context_option=
.
>
> In gru_set_context_option, as req can be controlled by user,
>
> We can reach gru_check_context_placement function call.
>
> In gru_check_context_placement function, if the error path was steped,
>
> say gru_check_chiplet_assignment return 0,
>
> Then it will fall into gru_unload_context function.
>
> And it will finnaly call kfree gts in gts_drop function.
>
> Then gru_unlock_gts will be called in gru_set_context_option function.
>
> This is a typical Use after free.
>
> The same problem exists in gru_handle_user_call_os and gru_fault.
>
> Fix it by introduce the return value to see if gts is in good case or not=
.
>
> Free the gts in caller when gru_check_chiplet_assignment check failed.
>
> Reported-by: Zheng Wang <hackerzheng666@gmail.com> Zhuorao Yang <alex000y=
oung@gmail.com>
>
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/misc/sgi-gru/grufault.c  | 14 ++++++++++++--
>  drivers/misc/sgi-gru/grumain.c   | 17 +++++++++++++----
>  drivers/misc/sgi-gru/grutables.h |  2 +-
>  3 files changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufa=
ult.c
> index d7ef61e602ed..2b5b049fbd38 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -656,7 +656,9 @@ int gru_handle_user_call_os(unsigned long cb)
>         if (ucbnum >=3D gts->ts_cbr_au_count * GRU_CBR_AU_SIZE)
>                 goto exit;
>
> -       gru_check_context_placement(gts);
> +       ret =3D gru_check_context_placement(gts);
> +       if (ret)
> +               goto err;
>
>         /*
>          * CCH may contain stale data if ts_force_cch_reload is set.
> @@ -677,6 +679,10 @@ int gru_handle_user_call_os(unsigned long cb)
>  exit:
>         gru_unlock_gts(gts);
>         return ret;
> +err:
> +       gru_unlock_gts(gts);
> +       gru_unload_context(gts, 1);
> +       return -EINVAL;
>  }
>
>  /*
> @@ -874,7 +880,7 @@ int gru_set_context_option(unsigned long arg)
>                 } else {
>                         gts->ts_user_blade_id =3D req.val1;
>                         gts->ts_user_chiplet_id =3D req.val0;
> -                       gru_check_context_placement(gts);
> +                       ret =3D gru_check_context_placement(gts);
>                 }
>                 break;
>         case sco_gseg_owner:
> @@ -889,6 +895,10 @@ int gru_set_context_option(unsigned long arg)
>                 ret =3D -EINVAL;
>         }
>         gru_unlock_gts(gts);
> +       if (ret) {
> +               gru_unload_context(gts, 1);
> +               ret =3D -EINVAL;
> +       }
>
>         return ret;
>  }
> diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumai=
n.c
> index 9afda47efbf2..79903cf7e706 100644
> --- a/drivers/misc/sgi-gru/grumain.c
> +++ b/drivers/misc/sgi-gru/grumain.c
> @@ -716,9 +716,10 @@ static int gru_check_chiplet_assignment(struct gru_s=
tate *gru,
>   * chiplet. Misassignment can occur if the process migrates to a differe=
nt
>   * blade or if the user changes the selected blade/chiplet.
>   */
> -void gru_check_context_placement(struct gru_thread_state *gts)
> +int gru_check_context_placement(struct gru_thread_state *gts)
>  {
>         struct gru_state *gru;
> +       int ret =3D 0;
>
>         /*
>          * If the current task is the context owner, verify that the
> @@ -727,14 +728,16 @@ void gru_check_context_placement(struct gru_thread_=
state *gts)
>          */
>         gru =3D gts->ts_gru;
>         if (!gru || gts->ts_tgid_owner !=3D current->tgid)
> -               return;
> +               return ret;
>
>         if (!gru_check_chiplet_assignment(gru, gts)) {
>                 STAT(check_context_unload);
> -               gru_unload_context(gts, 1);
> +               ret =3D -EINVAL;
>         } else if (gru_retarget_intr(gts)) {
>                 STAT(check_context_retarget_intr);
>         }
> +
> +       return ret;
>  }
>
>
> @@ -919,6 +922,7 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
>         struct gru_thread_state *gts;
>         unsigned long paddr, vaddr;
>         unsigned long expires;
> +       int ret;
>
>         vaddr =3D vmf->address;
>         gru_dbg(grudev, "vma %p, vaddr 0x%lx (0x%lx)\n",
> @@ -934,7 +938,12 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
>         mutex_lock(&gts->ts_ctxlock);
>         preempt_disable();
>
> -       gru_check_context_placement(gts);
> +       ret =3D gru_check_context_placement(gts);
> +       if (ret) {
> +               mutex_unlock(&gts->ts_ctxlock);
> +               gru_unload_context(gts, 1);
> +               return ret;
> +       }
>
>         if (!gts->ts_gru) {
>                 STAT(load_user_context);
> diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grut=
ables.h
> index 5efc869fe59a..f4a5a787685f 100644
> --- a/drivers/misc/sgi-gru/grutables.h
> +++ b/drivers/misc/sgi-gru/grutables.h
> @@ -632,7 +632,7 @@ extern int gru_user_flush_tlb(unsigned long arg);
>  extern int gru_user_unload_context(unsigned long arg);
>  extern int gru_get_exception_detail(unsigned long arg);
>  extern int gru_set_context_option(unsigned long address);
> -extern void gru_check_context_placement(struct gru_thread_state *gts);
> +extern int gru_check_context_placement(struct gru_thread_state *gts);
>  extern int gru_cpu_fault_map_id(void);
>  extern struct vm_area_struct *gru_find_vma(unsigned long vaddr);
>  extern void gru_flush_all_tlb(struct gru_state *gru);
> --
> 2.25.1
>
