Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381DD623A59
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiKJDZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKJDY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:24:59 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC62618B2A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:24:57 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id g10-20020a4ab4ca000000b00481082808cbso97142ooo.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 19:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxvhlSfkTbAfGMsGQ2xnp1gkpgPBCpNwQEyP3QqYQ90=;
        b=MfsW8kx/ODLB1xRAqmfFB9Ea7souOnCS3hsa2lR4PwZ8Pf5N2ubbkqkE7koKdIKzjp
         Cpngr+bwNphhi/1SraQEOdbWZto2pgYwiXXqUSljR2fa1oi4Fkqzewqgea/NJvr5hwAx
         PHYlaQfaBFVV0rMmwV4yoi9wdbHsyqNOj5+LuEu2rTUMwyZJRAfCI5Kpbbu1e8yLEffm
         fEyTP1lRvqZlSahroOhPaK615bJnBBCKOVIUWzZS3ipKd5L/tOZK0XMBWooJzDQuG1Cb
         z53kjhwDfocvgISsK3CVR3wsPBH9pVtHgl1syHgDvGJFIYucmI7E/4JbQ0sX37SlKulF
         jmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxvhlSfkTbAfGMsGQ2xnp1gkpgPBCpNwQEyP3QqYQ90=;
        b=ZA0qSsVUQQ9IRHanuRGhv7Az0tia1iu6Fc5pA7HgNlgn/QeYlQ4Zf90Dc6HFKBJZkb
         Su867PlG96NrbiiGi1owf24FX/jIN/sN1M6XsscbhVsEdfa3xMTozmy0o1LIi6HDqdI8
         Syh2ilfTd986NzMY5o/p9Q0LYx98N0T9CMZMTfddYTaB39k38wy+w5yhkBm9wkdLYjOn
         t4tTRBN3xZVHRCH9CbVRs9aT82ewwhkZS3UZWNjy8qSTWUKun+via7Quor11/PkU6EXj
         lsLOP79U00Q9ZoKg4VI6IRw1bB5cUhdp9AQ1hFP2yS0UohsYGh3K7AAzb2FEgAV5tu0h
         Zm9A==
X-Gm-Message-State: ACrzQf3k2Hg0adEXzSUBD0IQIx1DCMJEtD6sJPJgBEdUcTRfH1K6zXwF
        3SGbe4EJg4EjodCMyfyaLQh80fz1beO3e6q+sCw=
X-Google-Smtp-Source: AMsMyM4kugaxIQK6e2500ZL42LZtck+CDA+r6/FTqz42TU2G79duTlH14Rzuc/YN3TbPlswe9/BaImEQSRy4Jlz85fY=
X-Received: by 2002:a4a:db96:0:b0:49e:3627:279f with SMTP id
 s22-20020a4adb96000000b0049e3627279fmr875163oou.5.1668050697218; Wed, 09 Nov
 2022 19:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20221109141701.237407-1-zyytlz.wz@163.com> <20221109223257.GB34247@hpe.com>
In-Reply-To: <20221109223257.GB34247@hpe.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 10 Nov 2022 11:24:45 +0800
Message-ID: <CAJedcCzB3-iuWU0jdDQ0C5m6mZBD4p7DW8=gYkE7LjTfg=cFZg@mail.gmail.com>
Subject: Re: [PATCH v9] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Dimitri Sivanich <sivanich@hpe.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, gregkh@linuxfoundation.org,
        zhengyejian1@huawei.com, dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, alex000young@gmail.com,
        security@kernel.org, lkp@intel.com
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

Dimitri Sivanich <sivanich@hpe.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8810=E6=
=97=A5=E5=91=A8=E5=9B=9B 06:33=E5=86=99=E9=81=93=EF=BC=9A
>

> > diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/gru=
fault.c
> > index d7ef61e602ed..bdd515d33225 100644
> > --- a/drivers/misc/sgi-gru/grufault.c
> > +++ b/drivers/misc/sgi-gru/grufault.c
> > @@ -656,7 +656,9 @@ int gru_handle_user_call_os(unsigned long cb)
> >       if (ucbnum >=3D gts->ts_cbr_au_count * GRU_CBR_AU_SIZE)
> >               goto exit;
> >
> > -     gru_check_context_placement(gts);
> > +     ret =3D gru_check_context_placement(gts);
>
> Below we do not want to skip over the rest of the logic in either return =
case.
> You will have to do the gru_find_lock_gts again after unloading the gru c=
ontext,
> then check the gts value, then return EINVAL if not set (same as earlier =
in the
> function).

Hello my friend! Thanks for your detailed review. I think you are right.
I'll see what I can do and make a revision.

>
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
> > @@ -874,7 +880,11 @@ int gru_set_context_option(unsigned long arg)
> >               } else {
> >                       gts->ts_user_blade_id =3D req.val1;
> >                       gts->ts_user_chiplet_id =3D req.val0;
> > -                     gru_check_context_placement(gts);
> > +                     if (gru_check_context_placement(gts)) {
> > +                             gru_unlock_gts(gts);
> > +                             gru_unload_context(gts, 1);
>
> Looking at this again, I think we should return 0, as we originally would
> have done in this case anyway.

I think here we have finished the handling of the gts when it's illegal.
So return 0 is fine for me.

>
> > +                             return -EINVAL;
> > +                     }
> >               }
> >               break;
> >       case sco_gseg_owner:

> >        * If the current task is the context owner, verify that the
> > @@ -726,15 +727,23 @@ void gru_check_context_placement(struct gru_threa=
d_state *gts)
> >        * references. Pthread apps use non-owner references to the CBRs.
> >        */
> >       gru =3D gts->ts_gru;
> > +     /*
> > +      * If gru or gts->ts_tgid_owner isn't initialized properly, retur=
n
> > +      * success is fine, for it's not a deadly error. The related vari=
able
> > +      * can be reconfigure in other function.The caller is responsible
> > +      * for their inspection, and reinitialization if needed.
> > +      */
>
> How about this instead?
>   "If gru or gts->ts_tgid_owner isn't initialized properly, return
>    success to indicate that the caller does not need to unload the gru
>    context.  The caller is responsible for their inspection and
>    reinitialization if needed."
>

Yes, sounds much more clear for the developer, thanks for your suggestion :=
)

Best regards,
Zheng Wang
