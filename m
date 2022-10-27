Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C0D60EED1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 05:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiJ0Dss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 23:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiJ0Dsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 23:48:41 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C914FD36
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 20:48:39 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x3so298764qtj.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 20:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZV13YUXJ1X5nZogU6EZCbAdVT5BnrOM5RZdjfgWMN4=;
        b=aqRMJbOWWinhxG70OgZg11E1vL4+rhlfxogLDPQ26WObUaNoFwMHkDJKBUbJQT0hbD
         gchjDm5eHgagifJFx7DVNDl7vjB7Wcs3eDn6Mcob4aEFXayGA0aaukwWQBqNuRk6rCvV
         LyoWSXvABofmzdyOgsVKR+lOpVdmLsU08q5R1AYWW0jgHuJl5WMW0jy87Fe/QCGI3ayy
         iXdHdAEorxByR+hq6LusC2MlamGRRdC0FhMs14syJ86tPl+bZGbvSy+C+78A7FJYrWgs
         P4AGFxoX74qLfJ7DlywYJXlyAdm3DEfa9nhRgpkcI/0vOLNmgcHSg44lhzWSqTDIhIoZ
         YoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZV13YUXJ1X5nZogU6EZCbAdVT5BnrOM5RZdjfgWMN4=;
        b=e7rwyQqKpGOIXQ7Oczn/vffx+FIcJeY0xOUK7A77n7L85GuDbahBIIhAPCQw9WLbPq
         OCJVa46+Dt81ko7sGDj4A6r7cLkqQimxO6qv6VrjAi18FUuuxzHc9i+xE5s+TMCYbXDs
         UZgX9iC21MZ9lxg4bNTTfIm1qYCq4KxLdoK8ezmK9/wGtFv+wjnf2SDkikKiQ97W3bFv
         QCmFmpHtbZbTAOc86LY6wrS9ESOcId8vV+uX9yhnJ2L4NcnBReuM4BAOjncGOZi+9Nno
         2Tpg0biKft5kt0/MSWIZH0lpbfH5hShqCJef3YKEo1RHyoDb7hMwQRKjQjZo0hVaqceU
         SPvw==
X-Gm-Message-State: ACrzQf0NxiCrC+1MMwGT6pJ1ZelOOVoEM3sxsgo9It5yHt/3Z/WStd9K
        2uk1iJKf8UeTQpZeLApk5KRPsl1wA3psjHeTfT0=
X-Google-Smtp-Source: AMsMyM4fE/kjKW/5+tczi48te8MykEZ0ZF8HtYlOzTN0mhjMOAwlotf6o1yRIHW8uRefUfR/T4TIyiu6lLsPZ4TPHn0=
X-Received: by 2002:a05:622a:170c:b0:39c:c8c4:71f5 with SMTP id
 h12-20020a05622a170c00b0039cc8c471f5mr40194028qtk.595.1666842518527; Wed, 26
 Oct 2022 20:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221019031445.901570-1-zyytlz.wz@163.com> <20221019140043.GD18792@hpe.com>
In-Reply-To: <20221019140043.GD18792@hpe.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 27 Oct 2022 11:48:27 +0800
Message-ID: <CAJedcCzDz6zEn2c2fb10DsJGGw1H1RWC98Fsr+x3sF5e-E43Sg@mail.gmail.com>
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

Dimitri Sivanich <sivanich@hpe.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=B8=89 22:00=E5=86=99=E9=81=93=EF=BC=9A

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

Yes, that's correct. I'll fix it later.

> > @@ -727,14 +728,16 @@ void gru_check_context_placement(struct gru_threa=
d_state *gts)
> >        */
> >       gru =3D gts->ts_gru;

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

Get it! Thanks agagin for your advice :)

Regards,
Zheng Wang
